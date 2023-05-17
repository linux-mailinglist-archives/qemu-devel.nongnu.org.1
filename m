Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 586F7705D4C
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 04:28:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz6tf-00063J-Si; Tue, 16 May 2023 22:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1pz6te-00063A-Lv
 for qemu-devel@nongnu.org; Tue, 16 May 2023 22:28:10 -0400
Received: from mail-vs1-xe2f.google.com ([2607:f8b0:4864:20::e2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1pz6td-0000tE-6G
 for qemu-devel@nongnu.org; Tue, 16 May 2023 22:28:10 -0400
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-4361050d1ccso46576137.2
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 19:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684290488; x=1686882488;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fsNrn1VmKaH2YU9r2ztbLNOH9SpNyKl5UsMcFWHQi1o=;
 b=Rq0GDmoxAQ7q6ipdWkTABGqnhjsspAPadh74+9Nyz6Yt55mH4CSnRIJBz6LkQ0dZgY
 7gfIj29dTMzkFb1teqRrZd1QTtjiQ0VJOo/IKjDgG2w35mEG8pMNOUt932IOf1ybtq/+
 oQemOBIvvMligP0ThzLwO/MFlfCKxA/ujMsHF+XcdAKBTUG0G9j/YaoliRDYzM/UAIm2
 ZuK1SeX3ir6Un3/fIzFW7JPM57dRVV3aLiNPVX27L5Nzhmd/KIp8cPNbMF6dEfv56oVW
 0dnNXfo6iX/ZyiHNDH6QF82oBg42g7yvKVXWbhaSwdA+2t3ovpNBO3rhtKiPaHujJqZp
 qomg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684290488; x=1686882488;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fsNrn1VmKaH2YU9r2ztbLNOH9SpNyKl5UsMcFWHQi1o=;
 b=g8dbxb1I4puqmXQgF/r+HO27qha5YuEQbX+A1mIkRG6VW0bvbMNQJdc0bymIwoR2qN
 qabzD8trjL2DjvpIjB60+T9VK0DpNgGoNY3Gp+qjdo9vIfWwX0DnQTVk8YpAc6fdngjT
 yd82OW/GyMUJieugzekUaAR176clZVtFXhQSHGKNq0/LpHXox88dpT1s27adN+A5yy1t
 xggSKr0BjLBEFgvtdjJtu1vPjP0UWaOvkyRxC1LdYHxwOmwOf3Kn3OtBA7Z9bF7TEqLO
 xfIwq5N8x6LqnDi5xqGCXNg7vfitz4uFPYxmSWvc88He+Su6CE4ZZlcnRe1cQBWZGuWZ
 q/9w==
X-Gm-Message-State: AC+VfDybILB6T9D023wAldLK+ZIPailwepJ1KS+J0stk6iTe2Njd4JRZ
 dlFmQ9KqulGJmsClJ8RBoPTT7tWWcECy6Q2K5S8=
X-Google-Smtp-Source: ACHHUZ4SfyFl2Y9DTfhg5FhWSccMsmgp1YWm3LHg0r/QKrz55pphV5RA54d/qdv+Xt4t0ETj+GA+JdP9Lg6KYdxWlV0=
X-Received: by 2002:a67:f9c7:0:b0:42f:f1ce:c469 with SMTP id
 c7-20020a67f9c7000000b0042ff1cec469mr15250051vsq.33.1684290487967; Tue, 16
 May 2023 19:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230423095938.3232631-1-yong.li@intel.com>
In-Reply-To: <20230423095938.3232631-1-yong.li@intel.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 17 May 2023 12:27:41 +1000
Message-ID: <CAKmqyKM09A-dCjrF+UJh_jQyTVjG7X3RPiXLXn-qy+Of-+Zg3Q@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/virt: Fix the boot logic if pflash0 is specified
To: Yong Li <yong.li@intel.com>
Cc: qemu-devel@nongnu.org, Zhiwei Liu <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2f;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2f.google.com
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

On Sun, Apr 23, 2023 at 11:39=E2=80=AFPM Yong Li <yong.li@intel.com> wrote:
>
> The firmware may be specified with -bios
> and the plfash0 device with option -drive if=3Dpflash.
> If both options are applied, it is intented that the pflash0 will
> store the secure variable and the firmware be the one specified
> by -bios. Explicitly specify "-bios none" if choose to boot from
> pflash0

This seems like the right approach.

Can you update the docs/system/riscv/virt.rst docs to include this informat=
ion?

Alistair

>
> Signed-off-by: Yong Li <yong.li@intel.com>
> Cc: "Zhiwei Liu" <zhiwei_liu@linux.alibaba.com>
> ---
>  hw/riscv/virt.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 4e3efbee16..b38b41e685 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1296,10 +1296,12 @@ static void virt_machine_done(Notifier *notifier,=
 void *data)
>          kernel_entry =3D 0;
>      }
>
> -    if (drive_get(IF_PFLASH, 0, 0)) {
> +    if (drive_get(IF_PFLASH, 0, 0) &&
> +            !strcmp(machine->firmware, "none")) {
>          /*
> -         * Pflash was supplied, let's overwrite the address we jump to a=
fter
> -         * reset to the base of the flash.
> +         * If pflash (unit 0) was supplied and at the same time the -boi=
s
> +         * is not specified, then let's overwrite the address we jump to
> +         * after reset to the base of the flash.
>           */
>          start_addr =3D virt_memmap[VIRT_FLASH].base;
>      }
> --
> 2.25.1
>
>

