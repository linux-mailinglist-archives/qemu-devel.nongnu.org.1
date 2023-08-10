Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6A3777537
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 12:00:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU2RW-0007hh-4f; Thu, 10 Aug 2023 05:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1qU2RT-0007hQ-PT
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 05:58:55 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1qU2RQ-00087F-S6
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 05:58:55 -0400
Received: from loongson.cn (unknown [10.20.42.170])
 by gateway (Coremail) with SMTP id _____8CxNvHNtNRkKJEUAA--.44441S3;
 Thu, 10 Aug 2023 17:58:37 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxF8zLtNRkQOtSAA--.35876S3; 
 Thu, 10 Aug 2023 17:58:35 +0800 (CST)
Message-ID: <faa7b333-6e9e-f0ff-abe6-db773682fdef@loongson.cn>
Date: Thu, 10 Aug 2023 17:58:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] roms: Support compile the efi bios for loongarch
Content-Language: en-US
To: xianglai li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>
References: <260307952ffe5382a55d66a4999034490e04f7df.1691653307.git.lixianglai@loongson.cn>
From: bibo mao <maobibo@loongson.cn>
In-Reply-To: <260307952ffe5382a55d66a4999034490e04f7df.1691653307.git.lixianglai@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxF8zLtNRkQOtSAA--.35876S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWF47tr4xXF17XrWfAFW7WrX_yoWrtw13p3
 ykZ3WfGr4xJrW0qrs7Ga4rWFW3Grn5Gr15Xa95tryUAasxKr1jqF1ktas8GF47A3WUKFyU
 ZrykKw1v9a10qFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jO
 F4_UUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-4.14,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Xianglai,

I reply inline.

在 2023/8/10 15:42, xianglai li 写道:
> 1.Add edk2-platform submodule
> 2.Added loongarch UEFI BIOS support to compiled scripts.
The description is somewhat too simple, it should be paragraph. 

> 3.The cross-compilation toolchain on x86 can be obtained from the link below:
> https://github.com/loongson/build-tools/tree/2022.09.06
Fedora38 has LoongArch cross-compiler rpm package, maybe we do not need this.

> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
> Cc: "Daniel P. Berrangé" <berrange@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
> Cc: Song Gao <gaosong@loongson.cn>
> Cc: Bibo Mao <maobibo@loongson.cn>
> Signed-off-by: xianglai li <lixianglai@loongson.cn>
> ---
>  .gitmodules            |  3 +++
>  meson.build            |  2 +-
>  pc-bios/meson.build    |  2 ++
>  roms/edk2-build.config | 14 ++++++++++++++
>  roms/edk2-build.py     |  4 ++--
>  roms/edk2-platforms    |  1 +
>  6 files changed, 23 insertions(+), 3 deletions(-)
>  create mode 160000 roms/edk2-platforms
> 
> diff --git a/.gitmodules b/.gitmodules
> index 73cae4cd4d..0cb57123fa 100644
> --- a/.gitmodules
> +++ b/.gitmodules
> @@ -43,3 +43,6 @@
>  [submodule "tests/lcitool/libvirt-ci"]
>  	path = tests/lcitool/libvirt-ci
>  	url = https://gitlab.com/libvirt/libvirt-ci.git
> +[submodule "roms/edk2-platforms"]
> +	path = roms/edk2-platforms
> +	url = https://github.com/tianocore/edk2-platforms.git
> diff --git a/meson.build b/meson.build
> index 98e68ef0b1..b398caf2ce 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -153,7 +153,7 @@ if targetos != 'darwin'
>    modular_tcg = ['i386-softmmu', 'x86_64-softmmu']
>  endif
>  
> -edk2_targets = [ 'arm-softmmu', 'aarch64-softmmu', 'i386-softmmu', 'x86_64-softmmu' ]
> +edk2_targets = [ 'arm-softmmu', 'aarch64-softmmu', 'i386-softmmu', 'x86_64-softmmu', 'loongarch64-softmmu' ]
>  unpack_edk2_blobs = false
>  foreach target : edk2_targets
>    if target in target_dirs
> diff --git a/pc-bios/meson.build b/pc-bios/meson.build
> index a7224ef469..fc73222b6c 100644
> --- a/pc-bios/meson.build
> +++ b/pc-bios/meson.build
> @@ -9,6 +9,8 @@ if unpack_edk2_blobs
>      'edk2-i386-vars.fd',
>      'edk2-x86_64-code.fd',
>      'edk2-x86_64-secure-code.fd',
> +    'edk2-loongarch64-code.fd',
> +    'edk2-loongarch64-vars.fd',
>    ]
>  
>    foreach f : fds
> diff --git a/roms/edk2-build.config b/roms/edk2-build.config
> index 66ef9ffcb9..7960c4c2c5 100644
> --- a/roms/edk2-build.config
> +++ b/roms/edk2-build.config
> @@ -1,5 +1,6 @@
>  [global]
>  core = edk2
> +pkgs = edk2-platforms
>  
>  ####################################################################################
>  # options
> @@ -122,3 +123,16 @@ plat = RiscVVirtQemu
>  dest = ../pc-bios
>  cpy1 = FV/RISCV_VIRT.fd  edk2-riscv.fd
>  pad1 = edk2-riscv.fd     32m
> +
> +####################################################################################
> +# LoongArch64
> +
> +[build.loongach64.qemu]
> +conf = Platform/Loongson/LoongArchQemuPkg/Loongson.dsc
> +arch = LOONGARCH64
> +plat = LoongArchQemu
> +dest = ../pc-bios
> +cpy1 = FV/QEMU_EFI.fd  edk2-loongarch64-code.fd
> +pad1 = edk2-loongarch64-code.fd     4m
> +cpy2 = FV/QEMU_VARS.fd  edk2-loongarch64-vars.fd
> +pad2 = edk2-loongarch64-vars.fd     16m
> diff --git a/roms/edk2-build.py b/roms/edk2-build.py
> index 870893f7c8..dbd641e51e 100755
> --- a/roms/edk2-build.py
> +++ b/roms/edk2-build.py
> @@ -269,8 +269,8 @@ def prepare_env(cfg):
>      # for cross builds
>      if binary_exists('arm-linux-gnu-gcc'):
>          os.environ['GCC5_ARM_PREFIX'] = 'arm-linux-gnu-'
> -    if binary_exists('loongarch64-linux-gnu-gcc'):
> -        os.environ['GCC5_LOONGARCH64_PREFIX'] = 'loongarch64-linux-gnu-'
> +    if binary_exists('loongarch64-unknown-linux-gnu-gcc'):
> +        os.environ['GCC5_LOONGARCH64_PREFIX'] = 'loongarch64-unknown-linux-gnu-'
I think loongarch64-unknown-linux- is not necessary here, loongarch64-linux-gnu-
is default prefix on Fedora38, else there will be too many prefix names :)

Regards
Bibo Mao
>  
>      hostarch = os.uname().machine
>      if binary_exists('aarch64-linux-gnu-gcc') and hostarch != 'aarch64':
> diff --git a/roms/edk2-platforms b/roms/edk2-platforms
> new file mode 160000
> index 0000000000..84ccada592
> --- /dev/null
> +++ b/roms/edk2-platforms
> @@ -0,0 +1 @@
> +Subproject commit 84ccada59257a8151a592a416017fbb03b8ed3cf


