Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B993B7A947F
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 15:05:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjJL5-0006mx-9g; Thu, 21 Sep 2023 09:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjJIV-0001tk-8R
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 09:00:50 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjJIO-0002ss-Fp
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 09:00:43 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-52f9a45b4bdso1081664a12.3
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 06:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695301236; x=1695906036; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=AHXQ+0yyjte4yHlMFoZZh8nVjC453f8xgRENeTmv8Ck=;
 b=pUNz3zOMjVMSnA5+oEOPB6Hk2pjtvxWU1bBtyslVaSlm566WUYzd08fsA+f1W+ljs+
 ou1UffkSN1QAvdTc8cFxpgVO+5KcXOLcX3GuzD8Bf/o8wTAYpbx7TNImRha7/zfOo0PE
 4IFmooYK8i1sxCyycLlvInUUtQNY4UvO06ib98c+C+kEtaNFN0VEcpBeinSmvN7QlA3x
 3tjmqVNBIf+pMnLtjJZvjQhsejWtbS+iMnnjCFVUebhRBOtuPZeDOvg2EMTvxbu+/h93
 L86mHy9kDaGKh3MKgaDqBCGvzgmeTn9vgJY2dc0t0dExBFENrbFjTNOErc1+fzltQj7r
 bB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695301236; x=1695906036;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AHXQ+0yyjte4yHlMFoZZh8nVjC453f8xgRENeTmv8Ck=;
 b=eNNkXTp/tep23OAWcdVgb1HHBRcry/uk3LOGHJJPa2sE5tMq3IHGF0oAIBAHsed5J9
 zou08kxtSu3pcp22tPKllKgvPOjAt0k65Y0/s3mXnAMQ6UWTRVGoQPXNycqm0uKlgwqO
 zQ0H8kqJi0RIKsAghzxC1XpiQX7ZpS5A42ag9Pcixu6j0P+xdwWJIMoToxX2DIi3dLUn
 pZxmmlm7A2yfEOX1aRpc3bjeBThb1Sishn0uJ0zX16NKW+W8FmUi/DYb0AhyxmmPFfSS
 Uedf+uGXa9DFaPWqPwksQUgSkYOrkTB2o1qx7pC5C0TGEsMk8O6+YUhxy0yf6WVkxQ9I
 kmwQ==
X-Gm-Message-State: AOJu0YyCWUuvoopvO1ctVX4URdt6BK2vv5f1r4KfFgPLACCT474Y3TWy
 dC1pzJQ7K6O0BjX09mxHY/J+E/6kFHcLMXD7exzUIBsgSRcY0zpTRDI=
X-Google-Smtp-Source: AGHT+IEL5QaN7pY3ypXxZdIA4Tn2VAmkV+jeWUuiGj114EC8xkS6M+CabmBEDnVPVsEvCHcHVa1IU11PmvZWq3MgZvY=
X-Received: by 2002:a05:6402:515c:b0:532:bc4d:906f with SMTP id
 n28-20020a056402515c00b00532bc4d906fmr4455128edd.5.1695293439440; Thu, 21 Sep
 2023 03:50:39 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Sep 2023 11:50:20 +0100
Message-ID: <CAFEAcA_P5aOTQnM2ARYgR5WvKouvndMbX95XNmDsS0KTxMkMMw@mail.gmail.com>
Subject: EDK2 ArmVirtQemu behaviour with multiple UARTs
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: devel@edk2.groups.io, Leif Lindholm <quic_llindhol@quicinc.com>, 
 Ard Biesheuvel <ardb+tianocore@kernel.org>, Sami Mujawar <sami.mujawar@arm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi; I've been looking again at a very long standing missing feature in
the QEMU virt board, which is that we only have one UART. One of the
things that has stalled this in the past has been the odd behaviour of
EDK2 if the DTB that QEMU passes it describes two UARTs.

I'm going to describe the behaviour I see in more detail below, but to
put the summary up front:
 * EDK2 puts some debug output on one UART and some on the other
   (the exact arrangement depends on ordering of the dtb nodes)
 * EDK2 doesn't look at either stdout-path or the serial* aliases,
   so its choices about how to use the UARTs differ from those
   made by the guest kernel it is booting (and it also seems to be
   iterating through the dtb in the opposite order to the kernel)

The current proposal for adding a second UART is that it only happens
if you explicitly add one on the command line (with a second "-serial
something" option), so whatever we do won't break existing user
setups. So we have scope for saying "if you want to use a second UART,
you're going to want a newer EDK2 which handles it better". Exactly
what "better" means here is up for grabs, but honouring stdout-path
and the serial aliases would be the ideal I think. It would also be
possible to select a particular ordering for the DTB nodes to produce
"least-worst" behaviour from an existing EDK2 binary, but I'm not
sure if that's worth doing.

What do the EDK2 folks think about what the correct behaviour
should be for a 2-UART setup?

Anyway, on to the details about the setup and what I see from EDK2:

This is all with a debug ArmVirtQemu build, running at EL2 (i.e.
entirely non-secure), with some patches I've been working on to add
the extra UART to the board and the DTB. The DTB has the two UARTs:

        pl011@9000000 {
                clock-names = "uartclk\0apb_pclk";
                clocks = <0x8000 0x8000>;
                interrupts = <0x00 0x01 0x04>;
                reg = <0x00 0x9000000 0x00 0x1000>;
                compatible = "arm,pl011\0arm,primecell";
        };

        pl011@9040000 {
                clock-names = "uartclk\0apb_pclk";
                clocks = <0x8000 0x8000>;
                interrupts = <0x00 0x08 0x04>;
                reg = <0x00 0x9040000 0x00 0x1000>;
                compatible = "arm,pl011\0arm,primecell";
        };

and aliases:

        aliases {
                serial0 = "/pl011@9000000";
                serial1 = "/pl011@9040000";
        };

and in the /chosen node:
                stdout-path = "/pl011@9000000";

The ACPI table fragments generated by QEMU have entries for both
UARTs, as COM0 and COM1.

Given all this, EDK2 outputs:

uart0:
 * some UEFI output including debug output, starting:
UEFI firmware (version  built at 15:19:20 on Sep 19 2023)
add-symbol-file
/home/petmay01/linaro/edk2/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore/DEBUG/ArmPlatformPrePeiCore.dll
0x2000
add-symbol-file
/home/petmay01/linaro/edk2/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Core/Pei/PeiMain/DEBUG/PeiCore.dll
0xD240
Register PPI Notify: DCD0BE23-9586-40F4-B643-06522CED4EDE
Install PPI: 8C8CE578-8A3D-4F1C-9935-896185C32DD3
Install PPI: 5473C07A-3DCB-4DCA-BD6F-1E9689E7349A
The 0th FV start address is 0x00000001000, size is 0x001FF000, handle is 0x1000

 * the guest Linux kernel output (on what Linux says is ttyAMA0)

uart1:
 * a lot of UEFI output including debug output, starting:
DxeMain: MemoryBaseAddress=0x48000000 MemoryLength=0x38000000
add-symbol-file
/home/petmay01/linaro/edk2/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Core/Dxe/DxeMain/DEBUG/DxeCore.dll
0x47860000
HOBLIST address in DXE = 0x7FA35018
Memory Allocation 0x00000004 0x47FFF000 - 0x47FFFFFF
Memory Allocation 0x00000004 0x47FFE000 - 0x47FFEFFF

 * the GNU GRUB OS select screen and other GRUB output

The full output dumps can be seen at:
https://people.linaro.org/~peter.maydell/uart0.txt
https://people.linaro.org/~peter.maydell/uart1.txt

With only 1 UART, all the above appears on the single UART:
https://people.linaro.org/~peter.maydell/uart-single.txt

If I change QEMU to reverse the order of the nodes in the DTB (so the
pl011@9040000 nodes is listed first in the dtc output, and
pl011@900000 is listed second), then EDK2's output changes: the debug
output previously on uart0 is now on uart1, and vice-versa. The GRUB
output also switches to uart0. The Linux kernel output remains on
uart0 (this makes sense, because Linux is looking at the ACPI tables,
which are generated independently from the dtb). Output for this
setup is here:

https://people.linaro.org/~peter.maydell/uart0-rev.txt
https://people.linaro.org/~peter.maydell/uart1-rev.txt

A direct boot of Linux doesn't care about the dtb node ordering -- it
honours the aliases node and the chosen stdout-path string.
(Without the 'aliases' node, only the "pl011@9000000 first" dtb
order works, because it assigns ttyAMA0 and ttyAMA1 in the same
order as dtc prints them in the dtb disassembly.)

I would be happier if I understood why putting the nodes in reverse
order works, given that the code in EDK2 seems to be iterating through
the dtb forwards. I know there is at least one place in QEMU where the
node ordering gets reversed in the process of writing out the dtb, so
maybe there are more depending on how exactly the dtb is read. That
would I suppose explain why some EDK2 debug output goes to one UART
and some to the other, if the dtb read process differs during different
phases of EDK2 boot.

If you want to play around with this, I have some WIP patches at
https://git.linaro.org/people/pmaydell/qemu-arm.git uart-edk-investigation
(content wise they should be fine, but I haven't cleaned them up into
a coherent set of distinct patches yet, so they're a bit messy.)
A run of QEMU with both UARTs which sends all output to files looks like:

./build/arm-clang/qemu-system-aarch64 -display none -vga none \
  -machine virt,acpi=on,virtualization=on,mte=on,gic-version=max,iommu=smmuv3 \
  -smp 2 -m 1024 -cpu max,pauth-impdef=on \
  -bios ~/linaro/edk2/QEMU_EFI_DEBUG.fd \
  -drive file=/home/petmay01/avocado/data/cache/by_location/0154b7cd3a4f5e135299060c8cabbeec10b70b6d/alpine-standard-3.17.2-aarch64.iso,format=raw
\
  -device virtio-rng-pci,rng=rng0 \
  -object rng-random,id=rng0,filename=/dev/urandom \
  -chardev file,id=chr0,path=/tmp/uart0-rev.txt \
  -chardev file,id=chr1,path=/tmp/uart1-rev.txt \
  -serial chardev:chr0 -serial chardev:chr1

(adjust -serial options to taste)

thanks
-- PMM

