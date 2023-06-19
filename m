Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C79735760
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 14:53:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBENa-0006ED-MO; Mon, 19 Jun 2023 08:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBENX-0006AN-T7
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 08:53:07 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBENW-00067a-AD
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 08:53:07 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4f76a0a19d4so4291760e87.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 05:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687179184; x=1689771184;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w61GMLuOJlYAzuL0e6VboE27HsfD2McTSrV1nphgMVg=;
 b=fL1gBtFFfp18r9hJsyqg9CVhTGQAUIu0Ut5OhpfIjBOgWTpHlORa4PDWQrmEJkMTso
 AsQ4xsjPpBnk4c0BkoW3jmWaPB9+fd18LT5nf90ecYb2D1LBjJdejE5mNk8VZGgyKQio
 TxsXvzv4NcB5VaEUO145aG1RJvrmoxrJlKLpNRlBFzxW1WO26PmIRsFNq+CiXKhYQk+U
 VDzoGJcjHsbzrLBhjkRmDteD76JTF7n3KxttqsFakW/5C8UHgG0+phNtT9c+dShVGAvL
 ummibZDjo/w2Rg8KThgkz5uqfsJuajOYQZu5czS05KkDaRQpEKXCv/gyXlNO1Y08sQm0
 vqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687179184; x=1689771184;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w61GMLuOJlYAzuL0e6VboE27HsfD2McTSrV1nphgMVg=;
 b=FrIadNJfJgwxvAglvgODJ1eY/R9MVM/zrxkyzhylx0sBDYS1FyAK6f51IOGtanEFhL
 XGNFlOow+SZLyGbjgOJp/S1bqxOtXlrie69Qm+SlEAy20MBM2/PDzyad1IWOLQgtqfDm
 KYEM0yJRL1rS8M5V+4VsyO7YEzNiQcdXJJpuw1D5KaZTRHHpUvbVkGqGsSNWCXAkz863
 3uj2du3znxd7trYQpWUYydtlqJhHBauhLs7b6ez7aYyH/DMByW0CDuJWDd3JHfMI7eU8
 X+nwOrL9NEMzd0KctjTo/8ixQfS3fmIvypHqSBcRTCG81NbPIkfgnE4QOTG0gCLBs/Jh
 cxZA==
X-Gm-Message-State: AC+VfDytFvCoZ4xtpXxrG/aodblETAhuGWPdMZ46qCW/qVPaCN0mlMKc
 YN0R7fJfhknL7Hqq+8SicZQeGY6l3zzuYQsV51QkVQ==
X-Google-Smtp-Source: ACHHUZ58sgcPTzBmbZmhUUeg17X/9rVk/BXPvWWgKwsLQTlTk8mJJhO2dmuenmaBMZpV+/6ZNMYwBsFWBBxcDdx/Djg=
X-Received: by 2002:a05:6512:32b0:b0:4f8:5f19:4b4e with SMTP id
 q16-20020a05651232b000b004f85f194b4emr3129315lfe.51.1687179184331; Mon, 19
 Jun 2023 05:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230606182414.637467-1-marcin.juszkiewicz@linaro.org>
 <20230606182414.637467-2-marcin.juszkiewicz@linaro.org>
In-Reply-To: <20230606182414.637467-2-marcin.juszkiewicz@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Jun 2023 13:52:53 +0100
Message-ID: <CAFEAcA-u8KP4Lnt7TWwwOTeUdq9c0mE6NWv1duEYn0ujE8B6wg@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/arm/sbsa-ref: add ITS support in SBSA GIC
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>, 
 Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org, 
 Shashi Mallela <shashi.mallela@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
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

On Tue, 6 Jun 2023 at 19:24, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> From: Shashi Mallela <shashi.mallela@linaro.org>
>
> Included creation of ITS as part of SBSA platform GIC
> initialization.
>
> Signed-off-by: Shashi Mallela <shashi.mallela@linaro.org>

Marcin, this should have your signed-off-by too because
the patch came to us via you.

> +static void create_gic(SBSAMachineState *sms, MemoryRegion *mem)
>  {
>      unsigned int smp_cpus = MACHINE(sms)->smp.cpus;
>      SysBusDevice *gicbusdev;
> @@ -436,6 +451,12 @@ static void create_gic(SBSAMachineState *sms)
>      qdev_prop_set_uint32(sms->gic, "len-redist-region-count", 1);
>      qdev_prop_set_uint32(sms->gic, "redist-region-count[0]", redist0_count);
>
> +    if (!kvm_irqchip_in_kernel()) {
> +        object_property_set_link(OBJECT(sms->gic), "sysmem",
> +                                OBJECT(mem), &error_fatal);
> +        qdev_prop_set_bit(sms->gic, "has-lpi", true);
> +    }

sbsa-ref never uses KVM, so we don't need the
kvm_irqchip_in_kernel() check, we can just always
set the link and the has-lpi prop.

Otherwise this looks OK.

thanks
-- PMM

