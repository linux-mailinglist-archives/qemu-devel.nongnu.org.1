Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B8770B3E3
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 05:53:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0way-0004tr-02; Sun, 21 May 2023 23:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@kernel.org>)
 id 1q0wav-0004th-Or
 for qemu-devel@nongnu.org; Sun, 21 May 2023 23:52:26 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@kernel.org>)
 id 1q0wau-0002sN-7K
 for qemu-devel@nongnu.org; Sun, 21 May 2023 23:52:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id CF84E617A9
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 03:52:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E0EC4339B
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 03:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1684727534;
 bh=MGNbrOPh9vHNov9VBSqgIIk3N6xbwGdm2COsx8pQo7E=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Rk532nbrPVZrwysqfkezTey7/btxzPa9DX4bjKpVrV/H1Rqo4pjZvGyV5T1GHoNE2
 wH57WLhIc50zHFybIpkG/lzaI+FndOKWZ+2OR5+zwMAJXoVN/lBUIWeWSebJo+7AT4
 uwwzj8aMpH+7Q7WbpeIni2hC6i+TXPEVRB3LU6b06ZlBOz08pVNKaBwJP4Srptf1GT
 c06vkOb2mE8MYDc+lWfCkIEU1WovsymlcRbVPRisCXh83BtScE2AsQopNr/M/EpM3l
 wOBAMTD1iJkMI9cSP6efsvY0tQN0t3Hp0OTCP9rCs5N24/kO7wOt2pV5R7SUEj6AU5
 akg9Fu+eHCGeA==
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-51190fd46c3so4455437a12.1
 for <qemu-devel@nongnu.org>; Sun, 21 May 2023 20:52:14 -0700 (PDT)
X-Gm-Message-State: AC+VfDyHm9LgZkhuN+Bek8qJP2ibSuezJSnl0H6CgmLjclvniKGpE7aG
 DsWlhokE6LUSr2GYymbNHzoh59ymIXzGFW5d9Ug=
X-Google-Smtp-Source: ACHHUZ7i1phNmaFBWkCPzKEfP7JB07RnzNaM0pr+8bWZJyesaiNYr6BMDcR3gjO1beAw3y7ajrLIOB1joPVqhkdXvu0=
X-Received: by 2002:aa7:c990:0:b0:50d:abde:c7a3 with SMTP id
 c16-20020aa7c990000000b0050dabdec7a3mr7153316edt.42.1684727532517; Sun, 21
 May 2023 20:52:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230521102307.87081-1-jiaxun.yang@flygoat.com>
 <20230521102307.87081-2-jiaxun.yang@flygoat.com>
In-Reply-To: <20230521102307.87081-2-jiaxun.yang@flygoat.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 22 May 2023 11:52:00 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4kx5cDcswkHpCYH9UZhh7PDEndP+NvwNgdZaZji6BFLA@mail.gmail.com>
Message-ID: <CAAhV-H4kx5cDcswkHpCYH9UZhh7PDEndP+NvwNgdZaZji6BFLA@mail.gmail.com>
Subject: Re: [PATCH 1/4] hw/intc/loongarch_ipi: Bring back all 4 IPI mailboxes
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: qemu-devel@nongnu.org, yangxiaojuan@loongson.cn, gaosong@loongson.cn, 
 philmd@linaro.org, crosa@redhat.com, wainersm@redhat.com, bleal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=chenhuacai@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi, Jiaxun,

Rename loongarch_ipi to loongson_ipi? It will be shared by both MIPS
and LoongArch in your series.


Huacai

On Sun, May 21, 2023 at 6:24=E2=80=AFPM Jiaxun Yang <jiaxun.yang@flygoat.co=
m> wrote:
>
> As per "Loongson 3A5000/3B5000 Processor Reference Manual",
> Loongson 3A5000's IPI implementation have 4 mailboxes per
> core.
>
> However, in 78464f023b54 ("hw/loongarch/virt: Modify ipi as
> percpu device"), the number of IPI mailboxes was reduced to
> one, which mismatches actual hardware.
>
> It won't affect LoongArch based system as LoongArch boot code
> only uses the first mailbox, however MIPS based Loongson boot
> code uses all 4 mailboxes.
>
> Fixes: 78464f023b54 ("hw/loongarch/virt: Modify ipi as percpu device")
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  hw/intc/loongarch_ipi.c         | 6 +++---
>  include/hw/intc/loongarch_ipi.h | 4 +++-
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
> index d6ab91721ea1..3e453816524e 100644
> --- a/hw/intc/loongarch_ipi.c
> +++ b/hw/intc/loongarch_ipi.c
> @@ -238,14 +238,14 @@ static void loongarch_ipi_init(Object *obj)
>
>  static const VMStateDescription vmstate_ipi_core =3D {
>      .name =3D "ipi-single",
> -    .version_id =3D 1,
> -    .minimum_version_id =3D 1,
> +    .version_id =3D 2,
> +    .minimum_version_id =3D 2,
>      .fields =3D (VMStateField[]) {
>          VMSTATE_UINT32(status, IPICore),
>          VMSTATE_UINT32(en, IPICore),
>          VMSTATE_UINT32(set, IPICore),
>          VMSTATE_UINT32(clear, IPICore),
> -        VMSTATE_UINT32_ARRAY(buf, IPICore, 2),
> +        VMSTATE_UINT32_ARRAY(buf, IPICore, IPI_MBX_NUM * 2),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> diff --git a/include/hw/intc/loongarch_ipi.h b/include/hw/intc/loongarch_=
ipi.h
> index 664e050b926e..6c6194786e80 100644
> --- a/include/hw/intc/loongarch_ipi.h
> +++ b/include/hw/intc/loongarch_ipi.h
> @@ -28,6 +28,8 @@
>  #define MAIL_SEND_OFFSET      0
>  #define ANY_SEND_OFFSET       (IOCSR_ANY_SEND - IOCSR_MAIL_SEND)
>
> +#define IPI_MBX_NUM           4
> +
>  #define TYPE_LOONGARCH_IPI "loongarch_ipi"
>  OBJECT_DECLARE_SIMPLE_TYPE(LoongArchIPI, LOONGARCH_IPI)
>
> @@ -37,7 +39,7 @@ typedef struct IPICore {
>      uint32_t set;
>      uint32_t clear;
>      /* 64bit buf divide into 2 32bit buf */
> -    uint32_t buf[2];
> +    uint32_t buf[IPI_MBX_NUM * 2];
>      qemu_irq irq;
>  } IPICore;
>
> --
> 2.39.2 (Apple Git-143)
>

