Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2457475DFD2
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 06:02:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNQHH-0008E6-Su; Sun, 23 Jul 2023 00:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qNQHB-0008CW-Nf
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 00:00:59 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qNQH7-0000Ad-KR
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 00:00:57 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-bc379e4c1cbso3581889276.2
 for <qemu-devel@nongnu.org>; Sat, 22 Jul 2023 21:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690084850; x=1690689650;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E60KbwSaG2q4GuCTMHadZBmbZnJaP1J6oGxFwcBfDrs=;
 b=b2xFjXLC2poIroMm1se3tNCdXnMTnDwe1rT5E90uqhvuElR7h68yFsqcS6Yj7hz/Li
 AKm3I61VPssfnlv03talVK5uuM83vDBamuatzzLhTTjG3iLUzpqVUJRMeXYuSiKNdbaL
 zgYFSxYX75GUfRwe3FLTNhKpQhHXnA/DDCTyNUujxsYjBsrVOTpKwGhPzfck7LyncX3O
 wsdZZfo1DglesR+sFOXT0y65JAVAv7923Wmv8asXx82X+QuSVCEPnRlREnDPLdaKlXp1
 QT4bzv7pzxLCY9Ye4AoRqZ9U+S75lJo3NauY6B3F20kT/lyJNmfGrXhClwVgfwArdcsw
 X+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690084850; x=1690689650;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E60KbwSaG2q4GuCTMHadZBmbZnJaP1J6oGxFwcBfDrs=;
 b=G+EXls/LtAZeQIDLbDhen/aLCVD1xLzPhp0gCPXCAg/j6/QF0/c/cWkGFXI+aHjp14
 +w6oauq7UQ7iCijkMxM2XQKD0otjZcPX7dtmEImgMAHqsZIKpivKiIJFCtMum1CX59vz
 mFLijUdN0qv68d0KaqR/G2ePGrI4GgZ7sDTeYow6ATfjz/YHBzrsIITH3IW5oXB/rFtl
 PzUrDlUavbx66+Yk4qiak03Rz9FkbEpMcB/K+F+WuWtTgp4fltzw2YFJzcVMGZyUJ5Y2
 HhEJ0X4QERd/0nL9kMLIuaOtqAA6ejZB2i1eMRwmoc8yLmDS5OQiTsiBqIMrvwybUBLh
 hLMQ==
X-Gm-Message-State: ABy/qLaHh+RjqGwBDe30KclfFqNCcgKbKs36cTa4WzPi55y8HiL98rsy
 kznNaGCACbxm3fiE826KSlDxnoG+3RHYECrAZdo=
X-Google-Smtp-Source: APBJJlFC2pEHBBHXH8D4OXg9CXpdGXPgkZmdGqGP2XlzI5LotBg8HSzJBhtNPBJBojS53N83vo/JaeM6Qb7fI8yGNMo=
X-Received: by 2002:a25:8e0d:0:b0:ced:ab16:15ee with SMTP id
 p13-20020a258e0d000000b00cedab1615eemr5533413ybl.17.1690084850259; Sat, 22
 Jul 2023 21:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230719165817.889465-1-bmeng@tinylab.org>
In-Reply-To: <20230719165817.889465-1-bmeng@tinylab.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Sun, 23 Jul 2023 14:00:23 +1000
Message-ID: <CAKmqyKPe6Zw1Yq+VGywT_d=9dJHFu4xbG_tSw9S_vVp0=iQ8-Q@mail.gmail.com>
Subject: Re: [PATCH] roms/opensbi: Upgrade from v1.3 to v1.3.1
To: Bin Meng <bmeng@tinylab.org>
Cc: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=alistair23@gmail.com; helo=mail-yb1-xb2a.google.com
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

Thanks!

Applied to riscv-to-apply.next

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

