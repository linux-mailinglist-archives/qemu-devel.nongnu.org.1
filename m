Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE6F72C2CA
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 13:32:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8flo-00044W-DM; Mon, 12 Jun 2023 07:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8flm-00044L-Dq
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 07:31:34 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8flk-0006Xh-NV
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 07:31:34 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-30c55d2b9f3so2702484f8f.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 04:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686569491; x=1689161491;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+O5TtQQzFHSbKbGiCnt915qHhdP1FgapyzjwqH+5aB0=;
 b=JRrPmuyAWXKrWThEeBEgJWQLnpEhdkXdhv5SgI7eNje7hIaJYM5RqF4/8a42QW/oG1
 CbLtoMFbh8Dvrm/ZvrWBjTLBUVYqlJZtXlkJnMIig8Hw749kUzlPtsB6NpiRsNRO3egC
 7wP6lsJOa15Ftd8rAI6ZMGhXdvTLWIm/Ys5PL7srE7f/yScA4FyzqBfWBsNYBtxY6Lrh
 baadtsw8jEXrwBteNeVwpv5hLXOprY9PKFZEK9PE/aouaOTc7FQMhv9ANSP6lase+SDe
 QWGLnSfetoruz8Y8fynAa9lGTXYn8Eu2u8PlnRcCDdnnq+jwx3NLJx/wzd4M4+WhGNJj
 Xd/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686569491; x=1689161491;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+O5TtQQzFHSbKbGiCnt915qHhdP1FgapyzjwqH+5aB0=;
 b=iM1+FpcCazyf8Didp/DzRro6ZPV+nRB+qsMIVJOlFbei4jnV7/Lk8ckUa9LXxGMsS5
 K9vrwYwcLIzT3k2SPtKFtydDIjlki60L/lh6u4298tW5gBgi1HLIeFt+142RSb163bJF
 2OPtaY9t1BULOrw+QCvwr5rGbkxp9OuRJ5OjWQExD6MNKY2qRIvNUN+SuaoDeVhTfrRE
 3OEaFXtsdYbxn0bBhHP+aFV18tPVmdySSsqi1UTWRBm07MQgCxAlovyYf2imcYgZbML5
 JYxy1+NdtoFn51q5hQLkr2EiEmzeFNln8gsYi+3PAw7K6RmjAOue+KWSnRz/EabWyEc8
 HhpQ==
X-Gm-Message-State: AC+VfDyPoDy6rbd+/TFJ3wSGkSFM+uwqgyBh898VaDABt1j/vCZik9P2
 9mDbmgDtTcUSiNG0zOtBrPBoWoyfU5lNCRtsKJ0VnQ==
X-Google-Smtp-Source: ACHHUZ6rqnRUVX3UyKET/hrpISKLOlnYYpJblozOJiO8MAkOpShSZlGXb/d4dmx16+7twdM5oVB/eA==
X-Received: by 2002:a5d:6acd:0:b0:30f:b7b4:3e55 with SMTP id
 u13-20020a5d6acd000000b0030fb7b43e55mr4217963wrw.19.1686569491142; 
 Mon, 12 Jun 2023 04:31:31 -0700 (PDT)
Received: from [192.168.112.175] (176.red-88-28-1.dynamicip.rima-tde.net.
 [88.28.1.176]) by smtp.gmail.com with ESMTPSA id
 u8-20020adfeb48000000b003062b2c5255sm12258613wrn.40.2023.06.12.04.31.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jun 2023 04:31:30 -0700 (PDT)
Message-ID: <c1a40b6c-8810-bd05-5d24-9185929ba7e7@linaro.org>
Date: Mon, 12 Jun 2023 12:24:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 09/15] hw/pci-host/i440fx: Move i440fx_realize() into
 PCII440FXState section
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20230611103412.12109-1-shentey@gmail.com>
 <20230611103412.12109-10-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230611103412.12109-10-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 11/6/23 12:34, Bernhard Beschow wrote:
> i440fx_realize() realizes the PCI device inside the host bridge
> (PCII440FXState), but is implemented between i440fx_pcihost_realize() and
> i440fx_init() which deal with the host bridge itself (I440FXState). Since we
> want to append i440fx_init() to i440fx_pcihost_realize() later let's move
> i440fx_realize() out of the way.

Yes, i440fx_foo is is PCI PF#0 (physical function) of the
i440fx_pcihost_foo (host bridge) device. We could rename
i440fx_foo -> i440fx_pf0_foo / i440fx_pcifunc0_foo / i440fx_func0_foo
for clarity.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/pci-host/i440fx.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)


