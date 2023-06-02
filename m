Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7043972085F
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 19:29:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q58aA-0007xr-1r; Fri, 02 Jun 2023 13:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q58a8-0007xb-5v
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 13:28:56 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q58a6-0000mA-Eq
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 13:28:55 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-51494659d49so3355599a12.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 10:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685726932; x=1688318932;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NG5dRzgytxeUAadTFR283hss7DOdpaupnF8nRz+IwsQ=;
 b=SXyN1HmTtj4PCekfSafAyzbbUuzPlTNT3/lAMZJ3SeY52bIeA1Lr2ZD9Wu0yyfaMFF
 8WKN7f/fQI50FPGftgrXHxUikiUw3fUZG8+oXKjz+3i7WicUqNsn9l1sKOc8J5J5pmMG
 ceINcCy6h+P1hvUc8F4VqAoGPVWAOY59H1RFrWPoFh6ZMHAt1fhSwoURlv5zQUN7zvdg
 HR4EAnR7j5iWYn9CCYRaQRYbemJk4w/1koHvKRCLPI/YJpoO3CKcix+zTJ/CQjk3BX9I
 O0G8mZ+Z7tsbm55nA83Tm3V/N8PFyAEwpu04TY+ZtrGLoZjsy7hvSDFTBSFz7RV5FbZY
 kCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685726932; x=1688318932;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NG5dRzgytxeUAadTFR283hss7DOdpaupnF8nRz+IwsQ=;
 b=EJSED8TEAdG7HNM3qFkEliB/YVBnca1y++yy7tV8/WYjuIPeOPmq066ZWg9xpl+dvz
 aZCyJIGSmGPwdQIrHgX5+lsrBA8VpwiLPdskSYr16qend5PUj1Z4RH8be1NiuIJ6hpUm
 gj6ivKTcxT4rE9aFsE6o/65mFHVzkTGo4FPwQjb6aeieTKe/FoG+kEFd9WsrsbaL7Igp
 4PM8BaV+SsUPjIz/672xF/qLxUoxaOSh0BiTnlxKGGm5FK9HYw6XhTBTkxi/TMGlQC3t
 0lxvIPwJXcZw1hfhrDzWCD4vJo70OLqbsdsISOWEVjmJlN1UiLs+ijgATISl6eLrPBxl
 Gd5Q==
X-Gm-Message-State: AC+VfDxfIt5053OZni6t0h9UCyWhZFpkCukkzG1ea9GJMTUM8bEwposW
 Nk7IXi52bcNEwLJBJh+o7ggnACaoUMV0/IinapsKHg==
X-Google-Smtp-Source: ACHHUZ5xcjA7fU08fzS2b8FFZg1QfTZwTNxdJorOUi9ff0lLjOScgHcuMbq4+CEeXNW1qqNax6DMs2eI8cmtw5gXUuQ=
X-Received: by 2002:a05:6402:b38:b0:514:9d2f:10be with SMTP id
 bo24-20020a0564020b3800b005149d2f10bemr2349405edb.18.1685726932466; Fri, 02
 Jun 2023 10:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230521102307.87081-1-jiaxun.yang@flygoat.com>
 <20230521102307.87081-2-jiaxun.yang@flygoat.com>
In-Reply-To: <20230521102307.87081-2-jiaxun.yang@flygoat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Jun 2023 18:28:41 +0100
Message-ID: <CAFEAcA9F4OOwg9LQn-y7ScixG9mZ58bsvcE6qGqxw1WXENYaZw@mail.gmail.com>
Subject: Re: [PATCH 1/4] hw/intc/loongarch_ipi: Bring back all 4 IPI mailboxes
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: qemu-devel@nongnu.org, yangxiaojuan@loongson.cn, gaosong@loongson.cn, 
 philmd@linaro.org, chenhuacai@kernel.org, crosa@redhat.com, 
 wainersm@redhat.com, bleal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Sun, 21 May 2023 at 11:24, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
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
>  static const VMStateDescription vmstate_ipi_core = {
>      .name = "ipi-single",
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> +    .version_id = 2,
> +    .minimum_version_id = 2,
>      .fields = (VMStateField[]) {
>          VMSTATE_UINT32(status, IPICore),
>          VMSTATE_UINT32(en, IPICore),
>          VMSTATE_UINT32(set, IPICore),
>          VMSTATE_UINT32(clear, IPICore),
> -        VMSTATE_UINT32_ARRAY(buf, IPICore, 2),
> +        VMSTATE_UINT32_ARRAY(buf, IPICore, IPI_MBX_NUM * 2),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> diff --git a/include/hw/intc/loongarch_ipi.h b/include/hw/intc/loongarch_ipi.h
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

In particular, this fixes Coverity issues CID 1512452 and 1512453,
where Coverity notices that the code in loongarch_ipi_writel() and
loongarch_ipi_readl() reads off the end of the too-short buf[].

thanks
-- PMM

