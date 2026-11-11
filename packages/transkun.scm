(define-module (transkun)
  #:use-module (gnu packages machine-learning)
  #:use-module (guix-science-nonfree packages machine-learning)
  #:use-module (gnu packages)
  #:use-module (gnu packages compression)
  #:use-module ((guix licenses)
                #:prefix license:)
  #:use-module (guix git-download)
  #:use-module (guix gexp)
  #:use-module (gnu packages check)
  #:use-module (guix build-system pyproject)
  #:use-module (guix build-system trivial)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-science)
  #:use-module (gnu packages python-check)
  #:use-module (gnu packages python-build)
  #:use-module (gnu packages python-xyz)
  #:use-module (guix download)
  #:use-module (gnu packages audio)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages qt)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages elf)
  #:use-module (nonguix licenses)
  #:use-module (guix packages))

(define-public python-moduleconf
  (package
    (name "python-moduleconf")
    (version "0.1.4")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/Yujia-Yan/moduleconf")
             (commit "67aca166aee818c8d16a0f41bad31ad62a1e3757")))

       (file-name (git-file-name name version))
       (sha256
        (base32 "0l7fjqx4xl6vllsv0vd6s4ys0sis10y7gnj7fhynhxx5mwh4b06s"))))

    (arguments
     (list
      #:tests? #f))

    (build-system pyproject-build-system)

    (native-inputs (list python-setuptools))
    (home-page "https://github.com/Yujia-Yan/moduleconf")
    (synopsis "Moduleconf")
    (description "Moduleconf.")
    (license license:expat)))

(define-public python-sox
  (package
    (name "python-sox")
    (version "1.5.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/rabitt/pysox")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0039gksdcca5npnfvzy7dqc315f26mcy734la5v3hgvjj84cpcz8"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-numpy sox python-typing-extensions))
    (native-inputs (list python-pytest python-setuptools python-soundfile))
    (home-page "https://github.com/rabitt/pysox")
    (synopsis "SOX")
    (description "Python wrapper around @code{SoX}.")
    (license license:expat)))

(define-public python-torch-pypi
  (package
    (name "python-torch-pypi")
    (version "2.15.0")
    (source #f)
    (build-system trivial-build-system)
    (native-inputs
     (append
      (list (list "unzip" unzip))
      (list
       (list "torch-2.15.0-cp312-cp312-manylinux_2_28_x86_64.whl"
             (origin
               (method url-fetch)
               (uri "https://files.pythonhosted.org/packages/42/43/612036bf387d34afff1ec77d3aabe0d16776f1727b00b8bc4540fe5472b1/torch-2.15.0-cp312-cp312-manylinux_2_28_x86_64.whl")
               (sha256 (base32 "0yfx6ackirc5zzl9nis4xfw345imch6rpga9h6ji57rswgs8d33d"))))
       (list "cuda_toolkit-13.2.2-py2.py3-none-any.whl"
             (origin
               (method url-fetch)
               (uri "https://files.pythonhosted.org/packages/3d/62/854e4a141f5e87e5425513bad2a742a6260acfe06ef148001b5362148f31/cuda_toolkit-13.2.2-py2.py3-none-any.whl")
               (sha256 (base32 "1c47zmd8xfy3cx4abv5zg4z5vzqs9dwhs3715rm26mhkmlddqbni"))))
       (list "nvidia_cudnn_cu13-9.26.0.51-py3-none-manylinux_2_27_x86_64.whl"
             (origin
               (method url-fetch)
               (uri "https://files.pythonhosted.org/packages/ac/1b/ea72dd62f26ce3e0a7870b85148b75a5987507629b712deebeb87f7cce9a/nvidia_cudnn_cu13-9.26.0.51-py3-none-manylinux_2_27_x86_64.whl")
               (sha256 (base32 "16hllaqngzzjs8ai4zpzcbhgm1bl7c2y5nxwsrqqqsc6jx9nv5ww"))))
       (list "nvidia_cusparselt_cu13-0.8.1-py3-none-manylinux2014_x86_64.whl"
             (origin
               (method url-fetch)
               (uri "https://files.pythonhosted.org/packages/34/7d/2661f2fb3ac4302f3a246f5fc030213ac60c1fe0bce84f9783dbd831dbb7/nvidia_cusparselt_cu13-0.8.1-py3-none-manylinux2014_x86_64.whl")
               (sha256 (base32 "1l2d3y3x2q5lbmpn5y7nfl6h9lsc8lni1izwbbdzl0y3d1syhv3q"))))
       (list "nvidia_nccl_cu13-2.30.7-py3-none-manylinux_2_18_x86_64.whl"
             (origin
               (method url-fetch)
               (uri "https://files.pythonhosted.org/packages/3f/34/c500f90c7ae641b8e0f98965b36b8a7ac79cc8b296e8d251fe3eb592ee54/nvidia_nccl_cu13-2.30.7-py3-none-manylinux_2_18_x86_64.whl")
               (sha256 (base32 "0l2bxmar9kxxgyyna4j5djcrmz7n3zbf26szkkrx1vqhjzdpzynf"))))
       (list "nvidia_nvshmem_cu13-3.7.2-py3-none-manylinux2014_x86_64.manylinux_2_17_x86_64.whl"
             (origin
               (method url-fetch)
               (uri "https://files.pythonhosted.org/packages/4f/4a/037dfbbafc96ad1828ef62326f27970cae2c0eb271cf5b8e6922f32a7427/nvidia_nvshmem_cu13-3.7.2-py3-none-manylinux2014_x86_64.manylinux_2_17_x86_64.whl")
               (sha256 (base32 "0p139k719fpmja959vkcy0wwsz801qi6vz9kmpcdwp9bqr1zi95r"))))
       (list "cuda_bindings-13.5.0-cp312-cp312-manylinux_2_24_x86_64.manylinux_2_28_x86_64.whl"
             (origin
               (method url-fetch)
               (uri "https://files.pythonhosted.org/packages/27/68/14bf44f386672b03fcc0799be8d18df3e1c45847ee23b95721f6022abbaf/cuda_bindings-13.5.0-cp312-cp312-manylinux_2_24_x86_64.manylinux_2_28_x86_64.whl")
               (sha256 (base32 "0qpjnrl0j858l62xl54g6h4wy5f1xlzsxwvvyp86kmqj8748qsm4"))))
       (list "nvidia_cublas-13.4.1.3-py3-none-manylinux_2_27_x86_64.whl"
             (origin
               (method url-fetch)
               (uri "https://files.pythonhosted.org/packages/e1/97/d483a41da34df5c88727c57319576967f6d7befba5028d70928d2999635e/nvidia_cublas-13.4.1.3-py3-none-manylinux_2_27_x86_64.whl")
               (sha256 (base32 "1ixgwsixns4w1j5bgcdqiiykbq72qyp1dvii0957zc6g8av7r4d5"))))
       (list "nvidia_cuda_cupti-13.2.86-py3-none-manylinux_2_25_x86_64.whl"
             (origin
               (method url-fetch)
               (uri "https://files.pythonhosted.org/packages/b4/76/a10d9fb5d9a0e46d5f95e5520bd1b2d8ad22a9c0a09d2f8c20c5ee842a96/nvidia_cuda_cupti-13.2.86-py3-none-manylinux_2_25_x86_64.whl")
               (sha256 (base32 "11mm231v1akhrpwgrj6h3n9npz1nabcxjr0pjqgihdl3vlarz8lg"))))
       (list "nvidia_cuda_nvrtc-13.2.86-py3-none-manylinux2010_x86_64.manylinux_2_12_x86_64.whl"
             (origin
               (method url-fetch)
               (uri "https://files.pythonhosted.org/packages/1e/39/c58835ec8392a91b8d7bad83760eafc3085f64788b722ec2b44a27b3ca3e/nvidia_cuda_nvrtc-13.2.86-py3-none-manylinux2010_x86_64.manylinux_2_12_x86_64.whl")
               (sha256 (base32 "1ig17fjh0cail9wjaavm3chcxsggz12l24m25qi7hywn1q9wa4c1"))))
       (list "nvidia_cuda_runtime-13.2.86-py3-none-manylinux2014_x86_64.manylinux_2_17_x86_64.whl"
             (origin
               (method url-fetch)
               (uri "https://files.pythonhosted.org/packages/70/c6/8f8c5e893d183082ea78f973aebc7ebc845ee219d68bddac73b0f62490fe/nvidia_cuda_runtime-13.2.86-py3-none-manylinux2014_x86_64.manylinux_2_17_x86_64.whl")
               (sha256 (base32 "1w30gxgaj3xv493wdjm3899pkz167rzay0nip8qwxpfzh1v2961l"))))
       (list "nvidia_cufft-12.2.0.57-py3-none-manylinux2014_x86_64.manylinux_2_17_x86_64.whl"
             (origin
               (method url-fetch)
               (uri "https://files.pythonhosted.org/packages/41/28/868ed0c6ade5e6a75b25166b3cf191f4a2ff58ad618c1e40befb776c97c5/nvidia_cufft-12.2.0.57-py3-none-manylinux2014_x86_64.manylinux_2_17_x86_64.whl")
               (sha256 (base32 "1xjf3mi0pjp1100ywcfzhs5l1s0bagq26f648aqb0y9rvzx2gnil"))))
       (list "nvidia_cufile-1.17.1.22-py3-none-manylinux_2_27_x86_64.whl"
             (origin
               (method url-fetch)
               (uri "https://files.pythonhosted.org/packages/23/c5/661a73a9042fc5f81cdd5fe6e89f4170b3b33f7962e709987e2b5e5f1381/nvidia_cufile-1.17.1.22-py3-none-manylinux_2_27_x86_64.whl")
               (sha256 (base32 "0didwv9ikws89cg0p3swrsx94s7z04c1hcqrl01ks3fj7a6azzl7"))))
       (list "nvidia_cusolver-12.2.0.11-py3-none-manylinux_2_27_x86_64.whl"
             (origin
               (method url-fetch)
               (uri "https://files.pythonhosted.org/packages/e4/a4/90f7ade9992190788658c3c285f196fdb9bcc3a5bb93a325c245121d22fd/nvidia_cusolver-12.2.0.11-py3-none-manylinux_2_27_x86_64.whl")
               (sha256 (base32 "0hjbg4n3kwg77a6cdzy011d84xjmcdzc1ax6l64p7539cy7pgdgs"))))
       (list "nvidia_cusparse-12.7.10.12-py3-none-manylinux2014_x86_64.manylinux_2_17_x86_64.whl"
             (origin
               (method url-fetch)
               (uri "https://files.pythonhosted.org/packages/bc/46/3a9700cc13f30c9279af9a862363535c814fa27597199b21fd93cad66237/nvidia_cusparse-12.7.10.12-py3-none-manylinux2014_x86_64.manylinux_2_17_x86_64.whl")
               (sha256 (base32 "007sd6yqx8g0fcisa5jmfq8ldh7crp31rxh6bxl825fvwispr415"))))
       (list "nvidia_nvjitlink-13.5.37-py3-none-manylinux2010_x86_64.manylinux_2_12_x86_64.whl"
             (origin
               (method url-fetch)
               (uri "https://files.pythonhosted.org/packages/cc/1f/2321702b8d60b4b4dd18b957f61612dbac9cb1c07e940cf6582106b7c8b8/nvidia_nvjitlink-13.5.37-py3-none-manylinux2010_x86_64.manylinux_2_12_x86_64.whl")
               (sha256 (base32 "1swkmay1fg5841p0cbl7s01cw16y03jvv3ab0xgi814pcjwpq398"))))
       (list "nvidia_nvtx-13.2.86-py3-none-manylinux1_x86_64.manylinux_2_5_x86_64.whl"
             (origin
               (method url-fetch)
               (uri "https://files.pythonhosted.org/packages/49/ee/16bde09927e7ffacd50b117cd7d1dc764d145f03249fc41fdf6dfba3301f/nvidia_nvtx-13.2.86-py3-none-manylinux1_x86_64.manylinux_2_5_x86_64.whl")
               (sha256 (base32 "0if217rs2jdl44nwd48bgdkj87y8x80409fkqy8ig872mqmyg34n"))))
       (list "triton-3.9.0-cp312-abi3-manylinux_2_27_x86_64.manylinux_2_28_x86_64.whl"
             (origin
               (method url-fetch)
               (uri "https://files.pythonhosted.org/packages/3f/c9/af85b25e0d98bd921a7646ad1db1c8746250ee04b8f1595982d29b6283cf/triton-3.9.0-cp312-abi3-manylinux_2_27_x86_64.manylinux_2_28_x86_64.whl")
               (sha256 (base32 "1gv78aya13306r6awk0wm60kyybvd4isg6jc96ng0r0x5x7anljy"))))
       (list "cuda_pathfinder-1.8.6-py3-none-any.whl"
             (origin
               (method url-fetch)
               (uri "https://files.pythonhosted.org/packages/6a/9e/08555797c979322def080814686417ea93f66d38f5c48ebab6867a85a21e/cuda_pathfinder-1.8.6-py3-none-any.whl")
               (sha256 (base32 "102rqa1jfqhhr9vlpz2dpgdkv8jxva9870bisq8mmy9w6833nsxz"))))
       (list "fsspec-2026.9.0-py3-none-any.whl"
             (origin
               (method url-fetch)
               (uri "https://files.pythonhosted.org/packages/6c/c0/a98505f18594f1bce828bb159cec0fcf9860562f1a2c85913409fc8f3d9e/fsspec-2026.9.0-py3-none-any.whl")
               (sha256 (base32 "0pybbz85c9qy7xkxr9r3jkbl5916npk4ayprhnyq58wyx53fdmld"))))
       (list "networkx-3.7-py3-none-any.whl"
             (origin
               (method url-fetch)
               (uri "https://files.pythonhosted.org/packages/7e/cd/fe58041e9011f307c490e3e17dd48cc516448f7c698a3f2d9d9d65d7e6a8/networkx-3.7-py3-none-any.whl")
               (sha256 (base32 "1c51zipangvrz2vpzx4bllb7z9lqhmzqs39l8qvywk41lw9jrzg3"))))
       (list "setuptools-84.2.1-py3-none-any.whl"
             (origin
               (method url-fetch)
               (uri "https://files.pythonhosted.org/packages/ef/55/6dc6d6bb953bdfc52519a0059592c52b6e3b8ad51cf8256dffceb55b0610/setuptools-84.2.1-py3-none-any.whl")
               (sha256 (base32 "1hl9smrwh0qcr94y8qk46dgz3zk29x453qw0z1w98nijsm2hn56a"))))
       (list "sympy-1.14.0-py3-none-any.whl"
             (origin
               (method url-fetch)
               (uri "https://files.pythonhosted.org/packages/a2/09/77d55d46fd61b4a135c444fc97158ef34a095e5681d0a6c10b75bf356191/sympy-1.14.0-py3-none-any.whl")
               (sha256 (base32 "1xfq3dkk8gybiha9djrmcr5dj1cv8zsjhww4l85il56jk4zcr4g0"))))
       (list "mpmath-1.3.0-py3-none-any.whl"
             (origin
               (method url-fetch)
               (uri "https://files.pythonhosted.org/packages/43/e3/7d92a15f894aa0c9c4b49b8ee9ac9850d6e63b03c9c32c0367a13ae62209/mpmath-1.3.0-py3-none-any.whl")
               (sha256 (base32 "0b4dr3jkanrgw306r0hx90nliywcfc433wbzcjk83kdvh3zbkcm0"))))
       (list "typing_extensions-4.16.0-py3-none-any.whl"
             (origin
               (method url-fetch)
               (uri "https://files.pythonhosted.org/packages/49/d3/b8441a820a491ddfc024b0b0cf0393375b75ea13866d9c66727e54c2fc80/typing_extensions-4.16.0-py3-none-any.whl")
               (sha256 (base32 "1s62f1iqvmshyfrzx76f752pmxpijx7a3bbnn70i7s3l2d4al728"))))
       (list "filelock-4.2.10-py3-none-any.whl"
             (origin
               (method url-fetch)
               (uri "https://files.pythonhosted.org/packages/ef/90/5d0096a325aa0f83ba7a3968bfb485b67e32c947bdf9cd0fcb4b485be718/filelock-4.2.10-py3-none-any.whl")
               (sha256 (base32 "0mv87ljdzk2nm8q41f50p1k0nwi4vlz4ja6swd9ml2xj9pmslycl"))))
       (list "jinja2-3.1.6-py3-none-any.whl"
             (origin
               (method url-fetch)
               (uri "https://files.pythonhosted.org/packages/62/a1/3d680cbfd5f4b8f15abc1d571870c5fc3e594bb582bc3b64ea099db13e56/jinja2-3.1.6-py3-none-any.whl")
               (sha256 (base32 "0rrgdp707wfs11wk8prswvx6ma418sk16z6xql9hqba93x2y9v45"))))
       (list "markupsafe-3.0.4-cp312-cp312-manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64.whl"
             (origin
               (method url-fetch)
               (uri "https://files.pythonhosted.org/packages/4f/a7/aeedb5140afa41fc74c225e9184ab96723a6e873b6ee1c9fede7283456d8/markupsafe-3.0.4-cp312-cp312-manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64.whl")
               (sha256 (base32 "109mc677bxc28q0gx5l8vdwkb7cnjs1f6a1p0kb33y468ybly4lf"))))
       (list "nvidia_cuda_cccl-13.3.5.0.6-py3-none-manylinux2014_x86_64.manylinux_2_17_x86_64.whl"
             (origin
               (method url-fetch)
               (uri "https://files.pythonhosted.org/packages/a7/7e/4aa67cca14e0558b5a151a692f5ffe609930cdfc20d16c7a584de68424d4/nvidia_cuda_cccl-13.3.5.0.6-py3-none-manylinux2014_x86_64.manylinux_2_17_x86_64.whl")
               (sha256 (base32 "09p37v7mqgj6jbl3378ij4d6g5qpwkpc9h0038g05x9dzac008ym"))))
       (list "torchaudio-2.11.1-py3-none-manylinux_2_28_x86_64.whl"
             (origin
               (method url-fetch)
               (uri "https://files.pythonhosted.org/packages/e6/ad/b0bf9bfa9db80acf0ce660e01a67b3b735343ab51ce1410b18d2aaed254c/torchaudio-2.11.1-py3-none-manylinux_2_28_x86_64.whl")
               (sha256 (base32 "1vwic74k1j7vw725d4ymv3s9splba2c4xgiwvs4als0k3ssvawq1"))))
       )))
    (arguments
     (list
      #:modules '((guix build utils) (ice-9 ftw))
      #:builder
      #~(begin
          (use-modules (guix build utils) (ice-9 ftw))
          (define site (string-append #$output
                                      "/lib/python3.12/site-packages"))
          (mkdir-p site)
          (define unpack-root
            (string-append (getcwd) "/wheel-unpack"))
          (mkdir unpack-root)
          (define (entries dir)
            (filter (lambda (e) (not (member e '("." ".."))))
                    (scandir dir)))
          (define (install-into src dst)
            (mkdir-p (dirname dst))
            (if (file-is-directory? src)
                (copy-recursively src dst)
                (install-file src (dirname dst))))
          (define (install-wheel-data data-dir)
            (for-each
             (lambda (sub)
               (let ((s (string-append data-dir "/" sub)))
                 (cond
                  ((member sub '("purelib" "platlib"))
                   (for-each
                    (lambda (item)
                      (install-into (string-append s "/" item)
                                    (string-append site "/" item)))
                    (entries s)))
                  ((string=? sub "scripts")
                   (for-each
                    (lambda (item)
                      (let ((dst (string-append #$output "/bin/" item)))
                        (install-into (string-append s "/" item) dst)
                        (unless (file-is-directory? dst)
                          (chmod dst #o755))))
                    (entries s)))
                  ((member sub '("data" "headers" "tests"))
                   (for-each
                    (lambda (item)
                      (install-into (string-append s "/" item)
                                    (string-append #$output "/share/"
                                                   sub "/" item)))
                    (entries s)))
                  (else #t))))
             (entries data-dir)))
          (for-each
           (lambda (entry)
             (let ((label (car entry))
                   (path (cdr entry)))
               (when (and (string? label)
                          (string-suffix? ".whl" label))
                 (let ((tmp (string-append unpack-root "/" label)))
                   (mkdir tmp)
                   (system* (string-append
                             (assoc-ref %build-inputs "unzip")
                             "/bin/unzip")
                            "-qq" path "-d" tmp)
                   (for-each
                    (lambda (item)
                      (let ((src (string-append tmp "/" item)))
                        (if (string-suffix? ".data" item)
                            (install-wheel-data src)
                            (install-into src
                                          (string-append site "/" item)))))
                    (entries tmp))))))
           %build-inputs))))
    (home-page "https://pytorch.org/")
    (synopsis "PyTorch 2.15 + CUDA 13, unpacked from PyPI wheels")
    (description "PyTorch 2.15.0 and its CUDA 13 runtime dependencies,
installed declaratively from pinned PyPI wheels (torch, triton, the
nvidia-*-cu13 libraries, and their Python dependencies) into
lib/python3.12/site-packages.  Uses the system NVIDIA driver; no local
CUDA compilation required.")
    (license (nonfree "https://www.nvidia.com/en-us/drivers/cuda-toolkit-eula/"))))

(define-public python-pytorch-ranger
  (package
    (name "python-pytorch-ranger")
    (version "0.1.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url
              "https://github.com/mpariente/Ranger-Deep-Learning-Optimizer")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "11xzvk5n68898y4d4vwdcrnki30clsxkib4x4jji6rb7pfg5xxcl"))))
    (build-system pyproject-build-system)
    (arguments (list #:tests? #f))
    (propagated-inputs (list python-torch-pypi))
    (native-inputs (list python-setuptools))
    (home-page "https://github.com/mpariente/Ranger-Deep-Learning-Optimizer")
    (synopsis
     "ranger")
    (description
     "Cool thing.")
    (license license:asl2.0)))

  (define-public python-torch-optimizer
  (package
    (name "python-torch-optimizer")
    (version "0.3.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/jettify/pytorch-optimizer")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "17q4fkzlyvl4viiq3y76xzy5k4xlma1028gf23j86s9scdpnj9v0"))))
      (arguments
     (list
      #:tests? #f))

    (build-system pyproject-build-system)
    (propagated-inputs (list python-pytorch-ranger python-torch-pypi))
    (native-inputs (list python-setuptools))
    (home-page "https://github.com/jettify/pytorch-optimizer")
    (synopsis "pytorch")
    (description "optimizer")
    (license license:asl2.0)))

(define-public python-transkun
  (package
    (name "python-transkun")
    (version "2.0.1")
    (source
     (origin
       (method url-fetch)
       (uri "https://files.pythonhosted.org/packages/a2/1f/1e04ac0f04583d593ecca935270401404ad45e88c9db7b249b67bde20a1b/transkun-2.0.1-py3-none-any.whl")
       (sha256
        (base32 "1zjrr117k534k5qwk8z10kdbvg5wyg7qkc0m0kdgf88digw5nzvx"))))
    (build-system trivial-build-system)
    (native-inputs (list (list "unzip" unzip)))
    (arguments
     (list
      #:modules '((guix build utils))
      #:builder
      #~(begin
          (use-modules (guix build utils))
          (let ((site (string-append #$output
                                      "/lib/python3.12/site-packages"))
                (bin (string-append #$output "/bin")))
            (mkdir-p site)
            (mkdir-p bin)
            (system* (string-append
                      (assoc-ref %build-inputs "unzip") "/bin/unzip")
                     "-qq" #$source "-d" site)
            (for-each
             (lambda (spec)
               (let* ((script (string-append bin "/" (car spec)))
                      (rest (cdr spec))
                      (mod (car rest))
                      (func (car (cdr rest))))
                 (call-with-output-file script
                   (lambda (port)
                     (display "#!/usr/bin/env python3\n" port)
                     (display "import sys\n" port)
                     (display (string-append "from " mod " import " func
                                             "\n")
                              port)
                     (display "if __name__ == '__main__':\n" port)
                     (display (string-append "    sys.exit(" func "())\n")
                              port)))
                 (chmod script #o755)))
             '(("transkun" "transkun.transcribe" "main")
               ("transkunEval" "transkun.computeMetrics" "main")))))))
    (propagated-inputs
     (list python-scipy
           python-matplotlib
           python-tqdm
           python-seaborn
           python-pydub
           python-mir-eval
           python-pretty-midi
           python-ncls
           python-soxr
           python-tensorboard
           python-torch-pypi
           python-torch-optimizer
           python-sox
           python-moduleconf))
    (home-page "https://github.com/Yujia-Yan/Transkun")
    (synopsis "Automatic music transcription with note-level control")
    (description "Transkun is a PyTorch model for automatic music
transcription that additionally allows note-level control over the
generated output.")
    (license license:expat)))

(define-public python-rtmidi
  (package
    (name "python-rtmidi")
    (version "1.5.8")
    (source
     (origin
       (method url-fetch)
       (uri "https://files.pythonhosted.org/packages/f6/92/5a60f56dfb2740e644e932233928947423cd2101895319b331f84527eb31/python_rtmidi-1.5.8-cp312-cp312-manylinux_2_28_x86_64.whl")
       (sha256
        (base32 "00rq4ipkxl1y3gn2vyld63yicwpf3nkkbkscb6255x85wcj0khyf"))))
    (build-system trivial-build-system)
    (native-inputs
     (list (list "unzip" unzip)
           (list "patchelf" patchelf)
           (list "alsa-lib" alsa-lib)))
    (arguments
     (list
      #:modules '((guix build utils))
      #:builder
      #~(begin
          (use-modules (guix build utils))
          (let ((site (string-append #$output
                                      "/lib/python3.12/site-packages")))
            (mkdir-p site)
            (system* (string-append
                      (assoc-ref %build-inputs "unzip") "/bin/unzip")
                     "-qq" #$source "-d" site)
            (for-each
             (lambda (so)
               (system* (string-append
                         (assoc-ref %build-inputs "patchelf") "/bin/patchelf")
                        "--set-rpath"
                        (string-append "$ORIGIN/../python_rtmidi.:"
                                       #$(file-append alsa-lib "/lib"))
                        so))
             (find-files site
                         (lambda (name path)
                           (string-suffix? ".so" name))))))))
    (home-page "https://github.com/SpotlightKid/python-rtmidi")
    (synopsis "Python binding for the RtMidi C++ library")
    (description "A Python binding for the RtMidi C++ library, used by
HuMidi for MIDI device access.")
    (license license:expat)))

(define-public humidi
  (package
    (name "humidi")
    (version "2.0-ydotool-patched")
    (source
     (origin
       (method url-fetch)
       (uri "https://raw.githubusercontent.com/Erenhokinov/Just-a-minute/main/HuMidi-ydotool-patched-midi.zip")
       (sha256
        (base32 "11pwc6wcq6pqjr6d9mnb7g6pi2sz730mfsrws9ar93fzs8pfgjbd"))))
    (build-system trivial-build-system)
    (native-inputs (list (list "unzip" unzip)))
    (arguments
     (list
      #:modules '((guix build utils))
      #:builder
      #~(begin
          (use-modules (guix build utils))
          (let ((app (string-append #$output "/lib/humidi"))
                (bin (string-append #$output "/bin")))
            (system* (string-append
                      (assoc-ref %build-inputs "unzip") "/bin/unzip")
                     "-qq" #$source "-d" #$output)
            (mkdir-p (dirname app))
            (rename-file (string-append #$output "/humidi") app)
            (let ((cfg (string-append app
                                     "/managers/ConfigManager.py")))
              (call-with-input-file cfg
                (lambda (in)
                  (let loop ((acc '()))
                    (let ((c (read-char in)))
                      (if (eof-object? c)
                          (let* ((s (list->string (reverse acc)))
                                 (old "self.save_dir = os.path.join(self.root_dir, 'saves')")
                                 (new "self.save_dir = str(Path.home() / '.humidi' / 'saves')")
                                 (n (string-length s))
                                 (m (string-length old))
                                 (find (let scan ((i 0))
                                         (cond ((> (+ i m) n) #f)
                                               ((string=? (substring s i (+ i m)) old) i)
                                               (else (scan (+ i 1)))))))
                            (if find
                                (call-with-output-file cfg
                                  (lambda (out)
                                    (display (string-append
                                              (substring s 0 find)
                                              new
                                              (substring s (+ find m) n))
                                             out)))
                                (error "save_dir line not found in ConfigManager.py")))
                          (loop (cons c acc)))))))
            (mkdir-p bin)
            (let ((script (string-append bin "/humidi")))
              (call-with-output-file script
                (lambda (port)
                  (display "#!/bin/sh\n" port)
                  (display "export PATH=" port)
                  (display
                   (string-append #$(file-append ydotool "/bin") ":"
                                  #$(file-append alsa-utils "/bin")
                                  ":$PATH\n")
                   port)
                  (display "export GUIX_PYTHONPATH=" port)
                  (for-each
                   (lambda (site)
                     (display (string-append site ":") port))
                   (list #$(file-append python-pyqt-6
                                        "/lib/python3.12/site-packages")
                         #$(file-append python-mido
                                        "/lib/python3.12/site-packages")
                         #$(file-append python-numpy
                                        "/lib/python3.12/site-packages")
                         #$(file-append python-pynput
                                        "/lib/python3.12/site-packages")
                         #$(file-append python-evdev
                                        "/lib/python3.12/site-packages")
                         #$(file-append python-rtmidi
                                        "/lib/python3.12/site-packages")
                         #$(file-append python-pyqt6-sip
                                        "/lib/python3.12/site-packages")
                         #$(file-append python-sip
                                        "/lib/python3.12/site-packages")
                         #$(file-append python-xlib
                                        "/lib/python3.12/site-packages")))
                  (display ":$GUIX_PYTHONPATH\n" port)
                  (display "exec " port)
                  (display (string-append #$(file-append python "/bin/python3")
                                          " " app "/main.py \"$@\"\n")
                           port)))
              (chmod script #o755)))))))
    (propagated-inputs
     (list python-pyqt-6
           python-mido
           python-numpy
           python-pynput
           python-evdev
           python-rtmidi))
    (home-page "https://github.com/Erenhokinov/Just-a-minute")
    (synopsis "Humidi.")
    (description "HuMidii!")
    (license license:expat)))
