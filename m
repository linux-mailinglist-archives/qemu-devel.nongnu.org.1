Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDB6734FDC
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 11:25:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBB8E-0007mn-PD; Mon, 19 Jun 2023 05:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBB83-0007hG-6u
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 05:24:55 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBB81-0003f0-Is
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 05:24:54 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2b47354c658so15854161fa.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 02:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687166692; x=1689758692;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IrH6vgdoDkPFw6JCRQiJbmDNr82gUYPa1Xc7CXwFh1c=;
 b=cZ/cC3dt7+cJc2TreJQPAlXY6ir1A+1xCoiIKf8Jfzu+TlzsYXO1M/Ko3DD9e5Y+Kz
 ajo0NDqxT+v2mZloxDn4Su6USew2BqnsuZg3cfcKOzPbNf4TYcWGqU/AR/kWSdW+nebH
 oBg3dJgXMx5i8RlB6MFTwdm6+olJT1c6HJlZiIWDfdHFhsSkbyJ7+K+8FwDhC0TeXHnW
 zKtarrJ2d9fPkMg3Kmvfjbv5FNnK3UHfUYair3J8h1swvc6qZJeI7tAS9Xq8cXWaZN0U
 NtX/85h2zioYngmUAFBnfbJcty/Cc8n/+z9M+JpZZwWyOuU3y1wDxBp4X1/vfQIfG9n8
 MNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687166692; x=1689758692;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IrH6vgdoDkPFw6JCRQiJbmDNr82gUYPa1Xc7CXwFh1c=;
 b=kvxoMSXZnTXjFMEY8203k/5mDLbwn9+abvP5NlxNDAo6B3SpIVRIlrrMmkW3mDrrAK
 pE9sIUtr2W2XKurCbxiBNjj8ItovlUuaxwABlu2Lp1FPMjmI5SoYzKjRa+s4hSFKnXDh
 Hz1WqXKvwUC00F9p6+AhY7wmq/CbF0UBYqHfYxizLIMf+6GiX3fblReZTavLAgHvo9JL
 UXrKD1pbVygADNkDmr+8DThD/Ndh6aWkAMRyf2K2a6p+fizd3xfIeIobeeusrS2c5hzs
 j+h0XOtoP4vgD7JX/YJAsSPcSOgmmvArWixem1DLNILCBxjro/QG6yD2xS+Dw6JSAzZZ
 wk7g==
X-Gm-Message-State: AC+VfDwi0iOR1hZVMoJlKb4uG6P2ftTL9e1woSOwSGgOHyuq8+0rzilh
 o+UrWn06gdWCyH/E9djH0A2sOYFWbF5haf5geHDoaA==
X-Google-Smtp-Source: ACHHUZ5pJ5K1WbtqMkhpRCCFyf0306l5M3g8kzCiOIxBU5xPUuVhUJSLdJ2Wv5x2/ybSvOWqCNC+DWOairb3Bqdsxso=
X-Received: by 2002:a2e:b0c6:0:b0:2b4:7f2e:a42b with SMTP id
 g6-20020a2eb0c6000000b002b47f2ea42bmr649685ljl.37.1687166691919; Mon, 19 Jun
 2023 02:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230609055936.3925438-1-tommy.wu@sifive.com>
 <CAKmqyKMoeAn_7h=S0S=QR6YcYmvTd5VfT749Umm1BprUTrAjeg@mail.gmail.com>
In-Reply-To: <CAKmqyKMoeAn_7h=S0S=QR6YcYmvTd5VfT749Umm1BprUTrAjeg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Jun 2023 10:24:41 +0100
Message-ID: <CAFEAcA83+kaM9r4PqWks8tjCncnMS_Mh3NW=RyGFULV6wE5LMA@mail.gmail.com>
Subject: Re: [PATCH] hw/intc: If mmsiaddrcfgh.L == 1, smsiaddrcfg and
 smsiaddrcfgh are read-only.
To: Alistair Francis <alistair23@gmail.com>
Cc: Tommy Wu <tommy.wu@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Anup Patel <anup@brainfault.org>, Mayuresh Chitale <mchitale@ventanamicro.com>,
 Ivan Klokov <ivan.klokov@syntacore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 12 Jun 2023 at 05:12, Alistair Francis <alistair23@gmail.com> wrote=
:
>
> On Fri, Jun 9, 2023 at 4:01=E2=80=AFPM Tommy Wu <tommy.wu@sifive.com> wro=
te:
> >
> > According to the `The RISC-V Advanced Interrupt Architecture`
> > document, if register `mmsiaddrcfgh` of the domain has bit L set
> > to one, then `smsiaddrcfg` and `smsiaddrcfgh` are locked as
> > read-only alongside `mmsiaddrcfg` and `mmsiaddrcfgh`.
> >
> > Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
> > Reviewed-by: Frank Chang <frank.chang@sifive.com>
>
> Thanks!
>
> Applied to riscv-to-apply.next

If it hasn't gone in already, would you mind tweaking the
subject line so that it says which interrupt controller
the change is for ? (ie "hw/intc/riscv_aplic", not just "hw/intc".)

thanks
-- PMM

