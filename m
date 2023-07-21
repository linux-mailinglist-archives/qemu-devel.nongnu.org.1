Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A7175BB6C
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 02:06:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMddK-0006Lw-Gd; Thu, 20 Jul 2023 20:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qMddH-0006LU-No
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 20:04:31 -0400
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qMddG-0007CA-0D
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 20:04:31 -0400
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-4716e4adb14so639892e0c.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 17:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689897868; x=1690502668;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=34Re0+q8TCfwOWkY908itYze+0A7ow4Rx7T3bxWkk+g=;
 b=DF45T3hsIH1cLpZUjdGefFOQgCrfOOk+Ka36EaYBnKIKHoJ6FMl7Fg32Horht2ckVb
 NFohl7JLFYZY4Scwj3FZ/Jjsidl8WaPkNCrMJNczMRZWysft0KnBjY4z3ABzYIAWeDxR
 XER3Qyv3OVSt9uC+XJeXxLfnp/0XUT34mnrPJaNd2ZxzmCUszLQGkoeprpEuCas4PVQ1
 g+JIQCDlu7EZw01NcqYAvHL77rkjyPrg52rh0ENDz0uMAFsMq0Klxq8iBuL2ZLOsmQyY
 8473S3iKrSctHQABZzHkMM4kESnjmpjjEjyB0PBtOWdTne1a1CxpQEGtNxkrmq041GP5
 bKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689897868; x=1690502668;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=34Re0+q8TCfwOWkY908itYze+0A7ow4Rx7T3bxWkk+g=;
 b=QL4NnP73gmlMPB38A+v/Sb/AAW0A6wieZz8PnnspfCalqKccu3nCQPJNWJ3HlUbLSR
 7QOraeLzA/tVBB3i/+s/J9CVXk9NCVR9+3IMrAwq6VGfS/PFnYRFasIE8OGVPiQsN5/s
 XLGoPtwSMSSHVMlWyKSdDrrv1RCWOZBXPj/8pMCbCergn7XvJDCUJ/EyD3nGO+syjMDU
 97YMSiq+ElRgcxV8qK2Pnnnn6c5LV5Bzx4DXR9ZMfe2T17kIMClurPpVEyt/+CzCpPUs
 +IJ5lj1CXs9eC940JNPk9GybF8keddP57oFcvrVnmy6+1hlLJ3wEzA2S3Iul7z3IP2J/
 HiFA==
X-Gm-Message-State: ABy/qLZF6aS2eC7MIPWXOsBw9MgbEHrhHjG0BfnIWh9yYXxvQRCPEMc1
 DgV4YfzkIW91JA5oBIv6M7hJ+sfTj5HvnfNqQu8=
X-Google-Smtp-Source: APBJJlGEG9sJcoH5tcHyLQKlKGPqmyeQ2O3AoUVMunw7z2Xhsu+fjxrDQRB4m5FJvf7kNH5pb9EOoTf4EsktPdAkpq4=
X-Received: by 2002:a67:fd73:0:b0:443:5bec:a2fd with SMTP id
 h19-20020a67fd73000000b004435beca2fdmr165408vsa.18.1689897868320; Thu, 20 Jul
 2023 17:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230719165817.889465-1-bmeng@tinylab.org>
In-Reply-To: <20230719165817.889465-1-bmeng@tinylab.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 21 Jul 2023 10:04:02 +1000
Message-ID: <CAKmqyKNPZFyj_nPUcTN1qLmQ1SjuYf=ZwGWj7ao3-2JA1JYBmg@mail.gmail.com>
Subject: Re: [PATCH] roms/opensbi: Upgrade from v1.3 to v1.3.1
To: Bin Meng <bmeng@tinylab.org>, Conor Dooley <conor.dooley@microchip.com>, 
 Conor Dooley <conor@kernel.org>
Cc: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa31.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Jul 20, 2023 at 3:00=E2=80=AFAM Bin Meng <bmeng@tinylab.org> wrote:
>
> Upgrade OpenSBI from v1.3 to v1.3.1 and the pre-built bios images
> which fixes the boot failure seen when using QEMU to do a direct
> kernel boot with Microchip Icicle Kit board machine.
>
> The v1.3.1 release includes the following commits:
>
> 0907de3 lib: sbi: fix comment indent
> eb736a5 lib: sbi_pmu: Avoid out of bounds access
> 7828eeb gpio/desginware: add Synopsys DesignWare APB GPIO support
> c6a3573 lib: utils: Fix sbi_hartid_to_scratch() usage in ACLINT drivers
> 057eb10 lib: utils/gpio: Fix RV32 compile error for designware GPIO drive=
r
>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

@Conor Dooley @Conor Dooley Any chance you can test this?

Alistair

>
> ---
> Please pull the complete patch from https://github.com/lbmeng/qemu
> opensbi branch.
>
>  .../opensbi-riscv32-generic-fw_dynamic.bin    | Bin 135344 -> 135376 byt=
es
>  .../opensbi-riscv64-generic-fw_dynamic.bin    | Bin 138304 -> 138368 byt=
es
>  roms/opensbi                                  |   2 +-
>  3 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin b/pc-bios/ope=
nsbi-riscv32-generic-fw_dynamic.bin
> index 7b6c67e0ae..9a2ba3f2a4 100644
> Binary files a/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin and b/pc-bi=
os/opensbi-riscv32-generic-fw_dynamic.bin differ
> diff --git a/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin b/pc-bios/ope=
nsbi-riscv64-generic-fw_dynamic.bin
> index 1b831b412c..5d4e812819 100644
> Binary files a/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin and b/pc-bi=
os/opensbi-riscv64-generic-fw_dynamic.bin differ
> diff --git a/roms/opensbi b/roms/opensbi
> index 2552799a1d..057eb10b6d 160000
> --- a/roms/opensbi
> +++ b/roms/opensbi
> @@ -1 +1 @@
> -Subproject commit 2552799a1df30a3dcd2321a8b75d61d06f5fb9fc
> +Subproject commit 057eb10b6d523540012e6947d5c9f63e95244e94
> --
> 2.34.1
>
>

