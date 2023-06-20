Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AE37369B9
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:46:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBYrs-0005ZD-Q5; Tue, 20 Jun 2023 06:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBYre-0005TV-JY
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:45:35 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBYrb-0006Ah-9o
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:45:33 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4f004cc54f4so6026932e87.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 03:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687257929; x=1689849929;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P9HtAUbQG2WEBuGLDkf0mvAshs8VjcKrOvKuVeCQIcg=;
 b=ANxvYeD9y0hb6vBrl9X+91t4YD6mWxllHpQSb6faKvOBvgCYvec1drwjd88lnYabUP
 IvT8WGRKe5H67ZwUs27vhCZYlNY0bs7Ri5r5EQFD5+JNRzMm/SV4doYUp3pxid0DolQ8
 7pB4oI3knSzFerE0tDoE+B0agbsZGzB7ryHSULldLByoZgloi54INBMO/H7ybWFYSNC0
 26TElT/YFDrlD3da/OJ3+IPVJ7fYvWU55PI3on1XNw/gpT8FbBN/9I+oVgsfCtv3Ejjn
 olfu1rGP8NPW0ajKtzv36qQ/1Ci1Onq0OUYnLu1cO3ozRM246JHfJSJ7UjH81Nk28S8d
 hZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687257929; x=1689849929;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P9HtAUbQG2WEBuGLDkf0mvAshs8VjcKrOvKuVeCQIcg=;
 b=jJqV1N2teowmal5YSWgtzmkxM5qQMUpDhUU1wDPxW67Qm3qCUAmylJTCuU8kP3W+8A
 d82dYOAho4rBc00wdYpQzt+o8+weUJY3N7DNayRG8LtMHfUU7318C2K+xT6hUaACU2o7
 6PJFQO/g+94DzyWDWSOQ9nnsfgqNnpn2n17DnkOD4Fet7Xp1nzgIt+oyh8knrJ3HJyaC
 fKlo12fMhi1zhd6nm1NXKEulZJjilAtaALLh0dj/wrTarIjwsbJ3/2cc5IZmAxC25HD9
 OdWrW/XbmqG5pEx8dsCOBUrGGdy2qBA9Vjhr+2CJWB8QadMRcn2PZNjpc4HrtrE3wz5Q
 houQ==
X-Gm-Message-State: AC+VfDyZR5CI0KkIayUN32aJIavh/jd/dYSg8e4ne3R/A9Hbhpff0CCT
 eyxOU7+jfAZf6x9pKqFcA+r0fisTxaL46IajNmuu/CeEQAQOwV05
X-Google-Smtp-Source: ACHHUZ7d5WO2/C8lV6IKKOO66aIx5SQ3rdXEeupEn1Vu4YwKnkZTr6hp00GppnMunykpIuavA1P3ixsqGFGRXpwsVXc=
X-Received: by 2002:a19:4f49:0:b0:4f8:58d3:b7ab with SMTP id
 a9-20020a194f49000000b004f858d3b7abmr6705676lfk.4.1687257929307; Tue, 20 Jun
 2023 03:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230610133132.290703-1-danielhb413@gmail.com>
 <20230610133132.290703-6-danielhb413@gmail.com>
In-Reply-To: <20230610133132.290703-6-danielhb413@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2023 11:45:18 +0100
Message-ID: <CAFEAcA_KKSc=Ns9n1UJKdnhZ846EGK-nFbsG_e2mw_zwMoOJcw@mail.gmail.com>
Subject: Re: [PULL 05/29] pnv/xive2: Handle TIMA access through all ports
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, richard.henderson@linaro.org, 
 Frederic Barrat <fbarrat@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
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

On Sat, 10 Jun 2023 at 14:31, Daniel Henrique Barboza
<danielhb413@gmail.com> wrote:
>
> From: Frederic Barrat <fbarrat@linux.ibm.com>
>
> The Thread Interrupt Management Area (TIMA) can be accessed through 4
> ports, targeted by the address. The base address of a TIMA
> is using port 0 and the other ports are 0x80 apart. Using one port or
> another can be useful to balance the load on the snoop buses. With
> skiboot and linux, we currently use port 0, but as it tends to be
> busy, another hypervisor is using port 1 for TIMA access.
>
> The port address bits fall in between the special op indication
> bits (the 2 MSBs) and the register offset bits (the 6 LSBs). They are
> "don't care" for the hardware when processing a TIMA operation. This
> patch filters out those port address bits so that a TIMA operation can
> be triggered using any port.
>
> It is also true for indirect access (through the IC BAR) and it's
> actually nothing new, it was already the case on P9. Which helps here,
> as the TIMA handling code is common between P9 (xive) and P10 (xive2).
>
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Message-Id: <20230601121331.487207-6-fbarrat@linux.ibm.com>
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---

Hi -- Coverity points out that there's a problem with this
change (CID 1512997, 1512998):

> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -1662,6 +1662,8 @@ static void pnv_xive2_tm_write(void *opaque, hwaddr=
 offset,
>      bool gen1_tima_os =3D
>          xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_GEN1_TIMA_OS;
>
> +    offset &=3D TM_ADDRESS_MASK;

Here we now mask off most of the bytes of 'offset',
because TM_ADDRESS_MASK is 0xC3F...

> +
>      /* TODO: should we switch the TM ops table instead ? */
>      if (!gen1_tima_os && offset =3D=3D HV_PUSH_OS_CTX_OFFSET) {

...but here we compare offset against HV_PUSH_OS_CTX_OFFSET,
which is defined as
#define HV_PUSH_OS_CTX_OFFSET  (HV_PAGE_OFFSET | (TM_QW1_OS + TM_WORD2))
and since
#define HV_PAGE_OFFSET         (XIVE_TM_HV_PAGE << TM_SHIFT)
#define XIVE_TM_HV_PAGE         0x1
#define TM_SHIFT                16

that means HV_PUSH_OS_CTX_OFFSET has bits defined in the
upper 16 bits, and the comparison can now never be true,
making the if() dead code.

>          xive2_tm_push_os_ctx(xptr, tctx, offset, value, size);
> @@ -1681,6 +1683,8 @@ static uint64_t pnv_xive2_tm_read(void *opaque, hwa=
ddr offset, unsigned size)
>      bool gen1_tima_os =3D
>          xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_GEN1_TIMA_OS;
>
> +    offset &=3D TM_ADDRESS_MASK;
> +
>      /* TODO: should we switch the TM ops table instead ? */
>      if (!gen1_tima_os && offset =3D=3D HV_PULL_OS_CTX_OFFSET) {
>          return xive2_tm_pull_os_ctx(xptr, tctx, offset, size);

Similarly here.

thanks
-- PMM

