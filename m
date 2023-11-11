Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9CC7E8BDB
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Nov 2023 18:21:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1red-0005h9-G8; Sat, 11 Nov 2023 12:20:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1r1reR-0005gk-GM
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 12:20:07 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1r1reP-0000kN-6K
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 12:20:07 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6b7f0170d7bso3137545b3a.2
 for <qemu-devel@nongnu.org>; Sat, 11 Nov 2023 09:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699723203; x=1700328003; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jF83vCDlvY+kPG9CpJzgogrw2aphukWzgva/84zO4eg=;
 b=TqfbrE2fWGoRWfdXLX2U/cfUP8Qw+cuwRqPRMOWpHJX74inukLcqhU707ozDVCAwka
 SFLQkpi26h8uBzrLOQaZNSOR7nDiS/aYihctf9I01b7whhmZ2iJriBS4X5j/GVgsgE1s
 SN2xIsch7j1SaPE472EUVlVKg3C+HaTdf+LBvhPE+RnKGhIiDkZq2G5tPHnaPGZ4FqFk
 Ntw0yeECMQygdVx7s4iHqca/VOEP0USe94YXS1vE+3IGlyYUyFOCxxzbnndiKnalCGK3
 tGrr0rJIJuFhaU8arSzlw0a5cBZp7mZXQrLNMLBxlCM6DyAz81cFnezQl609i7c3qoTY
 Mx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699723203; x=1700328003;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jF83vCDlvY+kPG9CpJzgogrw2aphukWzgva/84zO4eg=;
 b=ou/X3NTA958LaoyP4k3ETwV0gaU0BtVQ+SlcfHxcX6+8RbuHugz9hQx5bxtlCQMuCC
 EYP55JYEHN/nhPUB3Drvu7ALuZVXXPAwq0zDw+RYjLVCyPsozl2c/ykX/kACypKGf0gp
 W7xu2Rq4kV0sjJH8e2TmtFF8etcijqzch6oupEz27w7cvMy+oK0uuVean5VHxng0GPER
 o+2yZCloJi85zQn3LHnq57D9bL2N9IKpzMx7mLEGVPq05dU3w5ry7fBrIHcN9hsVCXnq
 oNyijD46EZhKF9R4CCjzaPEOLY+cPrDihK/3dfkBoEu2SUlA0eNCsA7VxBliS7Qz3LWD
 6sgA==
X-Gm-Message-State: AOJu0Yys4DjQWYw81PN3cCTDL+Urw4LeOvoncmelGGyMw1UP6V0OYC5n
 3jtq3F3KrldyL9kLQv2DuMwofS/WZL8=
X-Google-Smtp-Source: AGHT+IEgPvdta7Gy52xuD+9k11lbGzhvvFgifa5oOmUG57QtFfX/XTgfCMMkcxjU+i2wWAy6s69kSg==
X-Received: by 2002:a05:6a20:7490:b0:181:3649:2a31 with SMTP id
 p16-20020a056a20749000b0018136492a31mr3220669pzd.33.1699723202987; 
 Sat, 11 Nov 2023 09:20:02 -0800 (PST)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 fe19-20020a056a002f1300b0068e49cb1692sm1510813pfb.1.2023.11.11.09.20.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Nov 2023 09:20:02 -0800 (PST)
Message-ID: <7d866ee2-a166-457b-8137-4791caaff3cc@gmail.com>
Date: Sun, 12 Nov 2023 02:19:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/8] Firmware/edk2 20230918 patches
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>
References: <20230918133338.2399701-1-kraxel@redhat.com>
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <20230918133338.2399701-1-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/09/18 22:33, Gerd Hoffmann wrote:
> The following changes since commit c5ea91da443b458352c1b629b490ee6631775cb4:
> 
>    Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2023-09-08 10:06:25 -0400)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/kraxel/qemu.git tags/firmware/edk2-20230918-pull-request
> 
> for you to fetch changes up to 0ec0767e59261b7a1f59e904020cf52b45380e54:
> 
>    tests/acpi: disallow virt/SSDT.memhp updates (2023-09-18 15:27:27 +0200)
> 
> ----------------------------------------------------------------
> edk2: update to edk2-stable202308
> 
> v2: include acpi test data updates
> 
> ----------------------------------------------------------------
> 
> Gerd Hoffmann (8):
>    tests/acpi: allow virt/SSDT.memhp updates
>    edk2: update build script
>    edk2: update build config
>    edk2: workaround edk-stable202308 bug
>    edk2: update submodule to edk2-stable202308
>    edk2: update binaries to edk2-stable202308
>    tests/acpi: update virt/SSDT.memhp
>    tests/acpi: disallow virt/SSDT.memhp updates
> 
>   roms/edk2-build.py                     | 202 ++++++++++++++++---------
>   pc-bios/edk2-aarch64-code.fd.bz2       | Bin 1508184 -> 1573561 bytes
>   pc-bios/edk2-arm-code.fd.bz2           | Bin 1483149 -> 1560966 bytes
>   pc-bios/edk2-i386-code.fd.bz2          | Bin 1695318 -> 1770410 bytes
>   pc-bios/edk2-i386-secure-code.fd.bz2   | Bin 1922002 -> 2121818 bytes
>   pc-bios/edk2-riscv-code.fd.bz2         | Bin 0 -> 1177402 bytes
>   pc-bios/edk2-riscv-vars.fd.bz2         | Bin 0 -> 231 bytes
>   pc-bios/edk2-riscv.fd.bz2              | Bin 1096418 -> 0 bytes
>   pc-bios/edk2-x86_64-code.fd.bz2        | Bin 1796544 -> 1887921 bytes
>   pc-bios/edk2-x86_64-microvm.fd.bz2     | Bin 1697788 -> 1782629 bytes
>   pc-bios/edk2-x86_64-secure-code.fd.bz2 | Bin 1999841 -> 2200701 bytes
>   roms/edk2                              |   2 +-
>   roms/edk2-build.config                 |  12 +-
>   tests/data/acpi/virt/SSDT.memhp        | Bin 1817 -> 1817 bytes
>   14 files changed, 139 insertions(+), 77 deletions(-)
>   create mode 100644 pc-bios/edk2-riscv-code.fd.bz2
>   create mode 100644 pc-bios/edk2-riscv-vars.fd.bz2
>   delete mode 100644 pc-bios/edk2-riscv.fd.bz2
> 

Hi,

This apparently broke EDK2 for AArch64. I tried the following command:
build/qemu-system-aarch64 -drive 
file=build/pc-bios/edk2-aarch64-code.fd,format=raw,if=pflash,readonly=on 
-M virt -cpu max -nographic -cdrom 
Fedora-Silverblue-ostree-aarch64-37-1.7.iso

Below is the output:
BdsDxe: loading Boot0001 "UEFI Misc Device" from PciRoot(0x0)/Pci(0x2,0x0)
BdsDxe: starting Boot0001 "UEFI Misc Device" from PciRoot(0x0)/Pci(0x2,0x0)


Synchronous Exception at 0x0000000043695920
PC 0x000043695920
PC 0x000043697EE4
PC 0x00004369A514
PC 0x00004369B030
PC 0x000043C04288
PC 0x000043C04338
PC 0x000043C051B4
PC 0x000043C02030
PC 0x000047685788 (0x00004767E000+0x00007788) [ 1] DxeCore.dll
PC 0x00004732AECC (0x000047324000+0x00006ECC) [ 2] BdsDxe.dll
PC 0x00004732DFD4 (0x000047324000+0x00009FD4) [ 2] BdsDxe.dll
PC 0x00004768900C (0x00004767E000+0x0000B00C) [ 3] DxeCore.dll
[ 1] 
/home/kraxel/projects/qemu/roms/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Core/Dxe/DxeMain/DEBUG/DxeCore.dll
[ 2] 
/home/kraxel/projects/qemu/roms/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Universal/BdsDxe/BdsDxe/DEBUG/BdsDxe.dll
[ 3] 
/home/kraxel/projects/qemu/roms/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Core/Dxe/DxeMain/DEBUG/DxeCore.dll

   X0 0x0000000043679960   X1 0x0000000000000000   X2 0x000000000000000D 
   X3 0x00000000436A2F70
   X4 0x0000000043679920   X5 0x000000004366B000   X6 0x0000000043677000 
   X7 0x00000000436A20D0
   X8 0x00000000436A20C8   X9 0x00000000436A20D0  X10 0x00000000436A20E0 
  X11 0x00000000436A20D0
  X12 0x0000000043679FFF  X13 0x0000000000000008  X14 0x0000000000000000 
  X15 0x0000000000000000
  X16 0x00000000473962BC  X17 0x00000000E6D79577  X18 0x0000000000000011 
  X19 0x0000000043C83000
  X20 0x0000000000000000  X21 0x0000000046310C98  X22 0x0000000043C972F0 
  X23 0x0000000000000000
  X24 0x0000000043C97000  X25 0x0000000043C973B8  X26 0x0000000043C973C0 
  X27 0x0000000043C973C8
  X28 0x0000000043C973D0   FP 0x000000004767D6A0   LR 0x0000000043697EE4

   V0 0xAFAFAFAFAFAFAFAF AFAFAFAFAFAFAFAF   V1 0x0000000000000004 
0000000000000000
   V2 0x554E65213A544C55 41464544464F544E   V3 0x0000000000000000 
0010000000000000
   V4 0x0000000040000000 0000000000000000   V5 0x4010040140100401 
4010040140100401
   V6 0x0040000000001000 0040000000001000   V7 0x0000000000000000 
0000000000000000
   V8 0x0000000000000000 0000000000000000   V9 0x0000000000000000 
0000000000000000
  V10 0x0000000000000000 0000000000000000  V11 0x0000000000000000 
0000000000000000
  V12 0x0000000000000000 0000000000000000  V13 0x0000000000000000 
0000000000000000
  V14 0x0000000000000000 0000000000000000  V15 0x0000000000000000 
0000000000000000
  V16 0x0000000000000000 0000000000000000  V17 0x0000000000000000 
0000000000000000
  V18 0x0000000000000000 0000000000000000  V19 0x0000000000000000 
0000000000000000
  V20 0x0000000000000000 0000000000000000  V21 0x0000000000000000 
0000000000000000
  V22 0x0000000000000000 0000000000000000  V23 0x0000000000000000 
0000000000000000
  V24 0x0000000000000000 0000000000000000  V25 0x0000000000000000 
0000000000000000
  V26 0x0000000000000000 0000000000000000  V27 0x0000000000000000 
0000000000000000
  V28 0x0000000000000000 0000000000000000  V29 0x0000000000000000 
0000000000000000
  V30 0x0000000000000000 0000000000000000  V31 0x0000000000000000 
0000000000000000

   SP 0x000000004767D6A0  ELR 0x0000000043695920  SPSR 0x60000205  FPSR 
0x00000000
  ESR 0x9600004F          FAR 0x00000000436799D0

  ESR : EC 0x25  IL 0x1  ISS 0x0000004F

Data abort: Permission fault, third level

Stack dump:
   000004767D5A0: 0000000000000000 00000000AFAFAFAF 000000004767D6C0 
0000000043697EDC
   000004767D5C0: 41464544464F544E 554E65213A544C55 0010000000000000 
0000000000000000
   000004767D5E0: 00000000436A2F70 00000000436A2F68 0000036040100401 
00000000436A2B28
   000004767D600: 0040000000001000 0040000000001000 0000000000000000 
0000000000000000
   000004767D620: AFAFAFAFAFAFAFAF AFAFAFAFAFAFAFAF 0000000000000000 
0000000000000004
   000004767D640: 41464544464F544E 554E65213A544C55 0010000000000000 
0000000000000000
   000004767D660: 0000000000000000 0000000040000000 4010040140100401 
4010040140100401
   000004767D680: 0040000000001000 0040000000001000 0000000000000000 
0000000000000000
 > 000004767D6A0: 000000004767D6C0 0000000043697EE4 0000000043677000 
0000000043679960
   000004767D6C0: 000000004767D6F0 000000004369A514 000000000000FC18 
00000000436B2020
   000004767D6E0: 000000F700000000 0000000043679960 000000004767D710 
000000004369B030
   000004767D700: 00000000476830E0 00000000436B2018 000000004767D720 
0000000043C04288
   000004767D720: 000000004767D780 0000000043C04338 0000000000000000 
0000000043C6D000
   000004767D740: 0000000043C83000 0000000046310C98 002A5DF04767D780 
0000000043685000
   000004767D760: 0000000043684000 00000000000002A6 00000000441A1C18 
000000004392A018
   000004767D780: 000000004767D7E0 0000000043C051B4 0000000000000000 
0000000043C02428


Synchronous Exception at 0x0000000043695920
ASSERT [ArmCpuDxe] 
/home/kraxel/projects/qemu/roms/edk2/ArmPkg/Library/DefaultExceptionHandlerLib/AArch64/DefaultExceptionHandler.c(343): 
((BOOLEAN)(0==1))

