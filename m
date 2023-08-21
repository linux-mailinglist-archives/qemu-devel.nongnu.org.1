Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D2A782943
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 14:38:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY4A2-00071Z-8n; Mon, 21 Aug 2023 08:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qY4A0-00071Q-TB
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 08:37:33 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qY49y-0004Nj-OQ
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 08:37:32 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-528913c261bso3844752a12.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 05:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692621449; x=1693226249;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9D8BvQKwfka/Vm01+jLtmSzwY0XpXWcppJhC2IR7c54=;
 b=O24KU6H9i1EwXJLt3nmD5ivBUZqsfELZm+cj9Rjdn23t910RuOeshyphBtP0mMYM5u
 XgWR9VWntilGPjzNazt4oRLLG1caC1Ur7Z9PCGTn8QuSsAMMAX+Njth7iOskVihC/DQM
 9zkLtK2A7chMZUwTDrplxsdVR7TuY4agiKljz/f/T3OIgz9Dmd/J7WDX9YHQXfagkRRD
 madxbIqcA7+oMmPdtW+9bB0XBpUx7anaX+Bebv0xKyxr20m0A90LFmR+OvZ9UzfizLj/
 7e6vR8VPhc+ux3i82cQb+Gu5MgKDNUK2KMVK9IqF+mcLbuoOwf6LVB2LRw1fq8WWLLq0
 G8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692621449; x=1693226249;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9D8BvQKwfka/Vm01+jLtmSzwY0XpXWcppJhC2IR7c54=;
 b=M+VJiFHbKg1RXeFKZXAQ6JY48BHpValtxIcyq8A/xf32SHiRhD5W4p6dW/cHHDE/cL
 J9KWm67iqBwVZKq0ZfumKtNvoCwgMadmOtUCohNqSd84ybgGwMprbGS4ScMCQTtFmWdo
 7Bj0so9DeLs2u7Jvytfs2EA2AO/c/RwV+B4AyDX2e0xucpi8W9SH50y3oMH4YQSm3UzQ
 QEQUZJwnpc3Vqh3nuA+WYxdbphTh+a2niPT1/XlSReopX6HTr43NjB+WleGDZSePNjrC
 hp1ULH1MQ0W5R+LJ+tQ8LC1KpJD/I2qQ1h69OdHOwUT+eZh4h0Y5nqyyKFzQfoAoxTPP
 TDXw==
X-Gm-Message-State: AOJu0YyLNXAfcTq0UUdbFfjJlWk9+yyu5WydSLAfG2uH7aG08ibcFaqM
 iVo83LCedXHju37/8+K8lVDHWNMW/5BDEJdb9bie8A==
X-Google-Smtp-Source: AGHT+IGDu8QO9UtRDZh7xdas4pT6bzqjZsgefSTIs+m+K4rxr8dRjZ3ba47PXxjNa6fLK/MTl13k0RHm7aE2CTX2uV0=
X-Received: by 2002:aa7:da81:0:b0:525:4d3d:c6ba with SMTP id
 q1-20020aa7da81000000b005254d3dc6bamr5024337eds.37.1692621449217; Mon, 21 Aug
 2023 05:37:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230810191626.81084-1-francisco.iglesias@amd.com>
 <20230810191626.81084-4-francisco.iglesias@amd.com>
In-Reply-To: <20230810191626.81084-4-francisco.iglesias@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Aug 2023 13:37:18 +0100
Message-ID: <CAFEAcA9z40PG4x9Q3H-+tMKfC80-TH-EvoEoWp5gVJKkYT=y4Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] hw/misc/xlnx-versal-cfu: Introduce a model of
 Xilinx Versal CFU_FDRO
To: Francisco Iglesias <francisco.iglesias@amd.com>
Cc: qemu-devel@nongnu.org, frasse.iglesias@gmail.com, alistair@alistair23.me, 
 edgar.iglesias@gmail.com, fkonrad@amd.com, sai.pavan.boddu@amd.com, 
 tong.ho@amd.com, vikram.garhwal@amd.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 10 Aug 2023 at 20:16, Francisco Iglesias
<francisco.iglesias@amd.com> wrote:
>
> Introduce a model of Xilinx Versal's Configuration Frame Unit's data out
> port (CFU_FDRO).
>
> Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

