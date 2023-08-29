Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE7778C4F6
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 15:16:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qayYs-0001PC-C0; Tue, 29 Aug 2023 09:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qayYn-0001On-4C
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:15:09 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qayYi-0008Sf-GC
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:15:08 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-52bca2e8563so1672716a12.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 06:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693314902; x=1693919702;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G/qv3k2eF25/yOYgVWXwm8JOy7V7q8aRWlizXRVfJj4=;
 b=yichn1eoduAB5wUFcl5OPZneR2FiSY+fh6XyAFZlyaa7pdNr3ymcuJyVHtDQPVj+gh
 cwKiRlEvZdT4+FHlSq5ZLmcSk1Fy2nCJouNxjH1n5a5/tLTONu2EJ4YzixNwI41TWwQN
 7pKwPRLHqig+CEs3wHAgQwq/VmdYQT1Vy666CmL5465IzxR9Rpn1ZcLOKl6p+2WqQjjh
 2lDJgZfxuG3CM2fQgzRC40zWvAB2LeAmaqzO6Zvmk7aZyx0Ce6dhsHUzBh5MtqSWtlEr
 +QqUztvj/XOlr01z+TlXye8nLZXTVsL1eNo3VSDIYMQINYOpzD28BNQQAoWx6Jyc2XdY
 /Z1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693314902; x=1693919702;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G/qv3k2eF25/yOYgVWXwm8JOy7V7q8aRWlizXRVfJj4=;
 b=IpnA1BQbMfEVr1YXWVLTPnZ/abBkbHQgsF9qg3TbAC5jRvpoBNQ583ExNRfw/A9Mcg
 eGCoaPgYjAoQUTi44T33yiG8sfw34a/KZry3a7yfmDNFD7YdyasKjKkJ9giwB/ut57uj
 k5xr8n1jZUtCwuyeo6pEPbqDdEPP4bFB43LLQWEVNgqHKjMpju8ponptv/2YLaktZOwy
 LFJW36kdOIZt1zMFS0o/KTLfbcLVuqQc248+J/QpW+vTAzP3zPW9NpS9xxJ43Hwe0pWe
 dzEEK6Gqfd++Mf1gdl1kOiH1LDQm1W7PSLa9TChlS1WruNgbHweC3PXtCx/BLpJV7sHH
 jlUg==
X-Gm-Message-State: AOJu0YyOKH2G+tLZlVq1+6oeA/UioULHsWhll9xZ8Wo/bPed9YLwMsiK
 NHJmqEIbhGo8HETYdI2kf3EM1k7tWugXwjNH/GC0HQ==
X-Google-Smtp-Source: AGHT+IGkOhzA3ocqcpCK1Y38mGswx2lg8GteWbU40rsu+jzcTFdtdu8vVk2L5o9uWqd+Pr+km5O04ZyyoS7OmXD/zj4=
X-Received: by 2002:a05:6402:b29:b0:523:aef9:3b7b with SMTP id
 bo9-20020a0564020b2900b00523aef93b7bmr22065489edb.4.1693314902681; Tue, 29
 Aug 2023 06:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <56aa4acb-d54c-a457-5a32-9258cec1ac96@linaro.org>
In-Reply-To: <56aa4acb-d54c-a457-5a32-9258cec1ac96@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Aug 2023 14:14:51 +0100
Message-ID: <CAFEAcA81xq_yEXYdtAXtkqcdR=MHagSNf5rXOtt+AwohMY_=BQ@mail.gmail.com>
Subject: Re: PCIe: SLT attribute mismatch: 0xFF020100 instead of 0x20100
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org, Gowtham Siddarth <gowtham.siddarth@arm.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Tue, 29 Aug 2023 at 12:40, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> I am working on aarch64/sbsa-ref machine so people can have virtual
> machine to test their OS against something reminding standards compliant
> system.
>
> One of tools I use is BSA ACS (Base System Architecture - Architecture
> Compliance Suite) [1] written by Arm. It runs set of tests to check does
> system conforms to BSA specification.
>
> 1. https://github.com/ARM-software/bsa-acs
>
>
> SBSA-ref goes better and better, yet still we have some issues. One of
> them is test 822 ("Check Type 1 config header rules") which fails on
> each PCIe root port device:
>
> BDF 0x400 : SLT attribute mismatch: 0xFF020100 instead of 0x20100
> BDF 0x500 : SLT attribute mismatch: 0xFF030300 instead of 0x30300
> BDF 0x600 : SLT attribute mismatch: 0xFF040400 instead of 0x40400
>
> I reported it as an issue [2] and got response that it may be QEMU
> fault. My pcie knowledge is not good enough to know where the problem is.
>
> 2. https://github.com/ARM-software/bsa-acs/issues/193
>
>
> In the comment Gowtham Siddarth wrote:
>
> > Regarding the SLT (Secondary Latency Timer) register, the expected
> > values align with the ACS specifications, registering as 0. However,
> > a discrepancy arises in the register's attribute, intended to be set
> > as Read-Only. Contrary to this intent, the bit field seems to
> > function as> Read-Write. Ordinarily, when attempting to write to the
> > register by configuring all bits to 1, the anticipated behaviour
> > should involve rejecting the write operation, maintaining the value
> > at 0 to uphold the register's designated Read-Only nature. However,
> > in this scenario, the write action takes effect, leading to a
> > transformation of the register's value to FFs. This anomaly could
> > potentially stem from an issue within the emulator.
>
> Does someone know where the problem may be? And how to fix it?

I don't know enough about PCI to be sure here, but it sounds like
what you're saying is happening is that the test case writes all-1s
to some PCI register for the root port device, and expects that where
some bits in it are defined in the spec as read-only they don't get set?

Which registers exactly is the test case trying to write in this way ?

I've cc'd the QEMU PCI maintainers.

thanks
-- PMM

