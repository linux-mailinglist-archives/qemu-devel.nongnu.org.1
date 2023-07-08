Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7466774BAFA
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 03:18:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHwZL-0000vP-L4; Fri, 07 Jul 2023 21:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qHwZJ-0000vC-MX; Fri, 07 Jul 2023 21:17:01 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qHwZI-0007o1-6g; Fri, 07 Jul 2023 21:17:01 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-55adfa61199so1832634a12.2; 
 Fri, 07 Jul 2023 18:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688779018; x=1691371018;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+pgHI+2l1TUc+TsN47MgDDbQHLWcucApUISXn08kqBo=;
 b=W06L6DS5rrTDrG5cARaKQWdcrH5tyMujQKPpus5B925A7F8VJbbNCU3O+wHw+rwILI
 tGp34M7ACuwIyDOIAWNZZznCbbM4IEHmb76H1s19F7qFiu8GivWEEbZlZEono4MhA50X
 KSf/QSHE5C/2xDiV73fD8Rg4wJOc9vlgQP0P24N7Xj/aZ96eiSWS6gCDn0veoVZqXL0m
 ABL0cBUUfPqXowDaBHzFL+MLV0qR4VjDa/GtKa4/YxwlbUx+DllfxgGWwQeh+EuD6ubZ
 2vCwM9H4PBKjmN5hDvoSBJP/S5RXGMeYoMM86bGcB/QoJkusQwZpe05/i1nEN0MwmNuu
 CjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688779018; x=1691371018;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+pgHI+2l1TUc+TsN47MgDDbQHLWcucApUISXn08kqBo=;
 b=k8j6mBjkpBB0NeLOaZjnqygypW+9FGaE4ogqRRKO7uXgSOBn1RhTpepYijsWlFGA/5
 9NYiKPT+M29xxVfYolfkuxbZaIqfowHQpV0l0GbbhsAQ7243di0x4nJKgnVVfzPvibOI
 hO2xV/5zGdJslweq4+FJB3Uq2XUUU+YBfVBeoPlsaSr9ANKBx9v6prMh5Nr4VSEVNGP6
 hZBL3LaXEW9UD2OVGeIIVae312zq9LYfqhoC6aQrcS5WoB0KWhCP+mYbE2+vi/SEXXar
 DAh9Ky6fRv1Q1f6ZwAso6wN/hyqgkExQ45WrNokMBu+HJS5v10xPifanY5dhFjuHKFAt
 NPGw==
X-Gm-Message-State: ABy/qLamu9lwStlbJgy7zlGJ8C+II1EGvZsR9DRuy1+G4GNQ0UQVSmW4
 dFtVcge7exkaFHlSXeNRI8k=
X-Google-Smtp-Source: APBJJlH+Do2IFbuqGMfUBLf9nmoB87mKiLIkhVAqjuEE5DyzG0tymPHzxzAIWfahGn+c0i8UWlv1wg==
X-Received: by 2002:a05:6a20:3951:b0:12e:8e34:f38e with SMTP id
 r17-20020a056a20395100b0012e8e34f38emr7200526pzg.48.1688779018012; 
 Fri, 07 Jul 2023 18:16:58 -0700 (PDT)
Received: from localhost ([61.68.2.145]) by smtp.gmail.com with ESMTPSA id
 f26-20020aa78b1a000000b0066a2e8431a0sm3361442pfd.183.2023.07.07.18.16.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 18:16:57 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 08 Jul 2023 11:16:52 +1000
Message-Id: <CTWE73ZF1T37.IQUBV31TU3LF@wheely>
Cc: <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2] ppc/pnv: Add QME region for P10
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Joel Stanley" <joel@jms.id.au>, =?utf-8?q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>
X-Mailer: aerc 0.15.2
References: <20230707071213.9924-1-joel@jms.id.au>
In-Reply-To: <20230707071213.9924-1-joel@jms.id.au>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52b.google.com
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

On Fri Jul 7, 2023 at 5:12 PM AEST, Joel Stanley wrote:
> The Quad Management Engine (QME) manages power related settings for its
> quad. The xscom region is separate from the quad xscoms, therefore a new
> region is added. The xscoms in a QME select a given core by selecting
> the forth nibble.
>
> Implement dummy reads for the stop state history (SSH) and special
> wakeup (SPWU) registers. This quietens some sxcom errors when skiboot
> boots on p10.
>
> Power9 does not have a QME.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Nice, already merged but looks good to me. Just one thing...

> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
> index a4c9d95dc5d3..9bc64635471e 100644
> --- a/include/hw/ppc/pnv_xscom.h
> +++ b/include/hw/ppc/pnv_xscom.h
> @@ -127,6 +127,17 @@ struct PnvXScomInterfaceClass {
>  #define PNV10_XSCOM_EC(proc)                    \
>      ((0x2 << 16) | ((1 << (3 - (proc))) << 12))
> =20
> +#define PNV10_XSCOM_QME(chiplet) \
> +        (PNV10_XSCOM_EQ(chiplet) | (0xE << 16))
> +
> +/*
> + * Make the region larger by 0x1000 (instead of starting at an offset) s=
o the
> + * modelled addresses start from 0
> + */
> +#define PNV10_XSCOM_QME_BASE(core)     \
> +    ((uint64_t) PNV10_XSCOM_QME(PNV10_XSCOM_EQ_CHIPLET(core)))
> +#define PNV10_XSCOM_QME_SIZE        (0x8000 + 0x1000)

I couldn't work out this comment.

Thanks,
Nick

