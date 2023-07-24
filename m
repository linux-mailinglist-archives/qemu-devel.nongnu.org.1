Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D65275FA87
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 17:16:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNxGs-0005jF-Rp; Mon, 24 Jul 2023 11:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNxGl-0005ik-GF
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 11:14:43 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNxGj-0007PP-06
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 11:14:43 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5221ee899a0so2777868a12.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 08:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690211673; x=1690816473;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+PIm9T+rJycJHWPFWmaK4cVsimJSZoz3kUjvmFUlwh8=;
 b=MnEK+KHgVIAy00MJaSZWLghEnsWU5lVidTrRfYB0N2UmwZKtfMupA14Wvvc2gVkGbb
 kiGxe6ia5uapL1SY4Dq04yb6pRKQ8AYbR0TYHs/NfkBOGz/X2r5oXY2uyiK76ohevFIL
 vJrUip33jVwEY5v3gtc8iJoVR4i2U7us2CqXoX8vu6u6RZlx0A464YRixbpIxyQjLhIQ
 UCPDKk34+tBadlV8bhyheqIVyOWGRqwkCNpMQLi7li8WtubyzPOGp+HzFMeZADIaNwpA
 pEn3Pvv4uZioKQQgjOv7/jUEeny49MsjguxoP1VTdbThOXP6oTG37OG0f1BQVK2tVltE
 HRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690211673; x=1690816473;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+PIm9T+rJycJHWPFWmaK4cVsimJSZoz3kUjvmFUlwh8=;
 b=PqGdLiGPL8s5Iwkkua0tb7qGfDSqlFVvxE4ELXunH5xxL4gb4q6ecaDzV49DQTC+4S
 7aY6vd0t6auGptShFhxIT82K35FF7jQ0gM4U17REMHEjhPWEON26Wlml6YJ8SBgaFbUY
 xGyPY7Wd2HT8UfMMWhencjTzJePfEZiJXZt7NhOaclHEjx+BwbUpYxQazYcMl+i07NrU
 3NrruhI7ZyQTNdpmDtcrm31c9VuZAPeY2XV64sJRgeRBpsR6+H794+7MeJIjZeiJRwTY
 ZBGtl+bAieOKpXGFiFQp7lefsOXHkDRpf2eN3U8t2wGAH5SNO0tvJzBU7zw8Y6rCsgyf
 wwQA==
X-Gm-Message-State: ABy/qLZDDZ+oCM+gZJiKVJMasfpe8vhFHlA2cbYjQKKgnAcE0bFdJgZU
 amFYQVJgGawOJWldXSYR7s96xbYK4HRSjnTL83PmBQ==
X-Google-Smtp-Source: APBJJlGvC1ofRU20HZtf4lDx0gm2a6jFDQHG7sxtiw3tynHvVQ7FMCSuWA8Tot1+I0XGXwS1igPYGYrue99yd9YsO3s=
X-Received: by 2002:a05:6402:31f6:b0:522:3849:48db with SMTP id
 dy22-20020a05640231f600b00522384948dbmr1413115edb.3.1690211673475; Mon, 24
 Jul 2023 08:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230713054502.410911-1-gshan@redhat.com>
 <CAFEAcA8197FCwfNZrnxfO-87RveOko0Ju-KcTJOEi0vfjVtDKg@mail.gmail.com>
 <2d21e89f-c965-e8f1-3705-dfea8367fc7e@linaro.org>
 <CAFEAcA-XK0U0bPuAf4K7avdJqnmcibFX_swY1Weo_Tn3wHJ1fw@mail.gmail.com>
 <20230714135004.230c05b2@imammedo.users.ipa.redhat.com>
 <CAFEAcA92QFxN0at+5rk7yrfk1sj3tX-GcfZYYY5_=210np_j4g@mail.gmail.com>
 <20230717144455.6f02fde9@imammedo.users.ipa.redhat.com>
 <527ed3dc-b723-5c37-37e2-58d4266b1f32@redhat.com>
 <20230724170604.74b4ca0a@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230724170604.74b4ca0a@imammedo.users.ipa.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2023 16:14:22 +0100
Message-ID: <CAFEAcA-Tp7_vpGUea4W6cf3rTDqqGKy6VtsguDjiSAbRX=dL=Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] hw/arm/virt: Use generic CPU invalidation
To: Igor Mammedov <imammedo@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, pbonzini@redhat.com, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com, 
 shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Mon, 24 Jul 2023 at 16:06, Igor Mammedov <imammedo@redhat.com> wrote:
> I've seen others asking why you print type name instead of shorter cpu-model
> used on CLI. To do that would make you write a patch to implement reverse mapping.
> In some cases it's simple, in others plain impossible unless you can get
> access to -cpu foo stored somewhere.
>
> What I don't particularity like about adding reverse type->cpu_model mapping,
> is that it would complicate code to carter to QEMU's interface inconsistencies.
> And if you do it easy way (instead of fixing every target) touching only ARM,
> it will be spotty at best and just add to technical debt elsewhere ->
> more inconsistencies.
>
> What I'm proposing is for you to keep printing type names.
> So if others won't object to type names I'm more or less fine with your
> current approach.

I do object to type names, because the UI for choosing
a CPU ("-cpu whatever") does not take type names, it
takes CPU names. The QOM type names that those end up
being under the hood are a detail of QEMU's implementation
that we shouldn't expose to users in the help messages.

> Instead of adding type->cpu_model mapping (it's not the first time
> this particular question had arisen - there were similar patches before
> on qemu-devel), get rid of shortened cpu_model in user interface (-cpu)
> altogether and use CPU type name there.

I also think we should not do this, because it will break
a ton of existing command lines, and it's not clear it
has any benefit to users.

thanks
-- PMM

