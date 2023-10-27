Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F1F7D9940
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 15:05:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwMUu-0006mg-SD; Fri, 27 Oct 2023 09:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwMUo-0006mF-I8
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 09:03:27 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwMUm-00050Z-Pf
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 09:03:26 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-53e2308198eso3201100a12.1
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 06:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698411803; x=1699016603; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vV0oo815QhzL1gOOOissasTqRzmW7vZ7I0CYYBg4Y8E=;
 b=QreBGJBYjelsNoqa2CD4IfN3djc9ZURIMxv7w712woxn/K3xGxjekAUmki2J38IoDh
 MnWOGASSjA8XTVgrMaupx//qXLH9AOgVovxJrIzinQ4SFPm1DeLGfI6KOHxTFS68J80C
 /0nB4T81MNmJ4s0Ktahcw3oHglEJhE7QiA2XYGJ5Dy+MMLxp2PimweHm1/800nuaq8p+
 qqz+wA/j2dD5tZqnrlniLqL7LScq+fQsxk/MuL7kC+MUpCAL41BM/1N1vWCNXLOH8IxS
 U7hmqbJFA5sNQmGuGISOvQyfcGhTZkcb3eo9Te9gIp7IfQJmmSkTIpYRMCdmKPkxBo2s
 q5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698411803; x=1699016603;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vV0oo815QhzL1gOOOissasTqRzmW7vZ7I0CYYBg4Y8E=;
 b=VYUMSgzeD4aObTm8SAR087ek26ukCIYMu2u4giKFOBIFA4oW/0X2PJHt0XCckS6Biu
 xZj8VEysHfWp7ipXud6ra/ps7Ome2xayIK1VmjoZHufBHx38Rnfq+yX8E3kJ6EFxl2Yt
 lvdLQwCsYxwUatLFdZ0UEfBXlbZT5YQHCBxehCZU2ZgbaoHxPhT83BcEWKT1fh4oN4dr
 KF6QDxNuf5/Eg2oFdvek4OTL7MkCpkiZd3AOGS2rD5I0Ma7tYxAp3r6utVIpF4oJBkpp
 mXqbD5l32fz7DLphAPwvOKw4epaAb4JJ1D9SJkAqh78XzO4EMYgKzMHad+kU4ZhJ2fEs
 mMuA==
X-Gm-Message-State: AOJu0YxWp5GTZ6pQKrgiQoz6R0NBCkIcaPQbRsmYlmLs9Yqi2jEHrfTG
 XjBj9Tt1KzEP6hmd08SIaKMjYOZmqmHg/ZC35mo2OQ==
X-Google-Smtp-Source: AGHT+IEji4wus+D0E4c1QEdCMzKQ8cazrnRZGxjYHZwuvdema99wozyjC1549rZVrJE3tGdRcauBN9eJ5aYNFkKHHGk=
X-Received: by 2002:a05:6402:74c:b0:53f:b964:ddb1 with SMTP id
 p12-20020a056402074c00b0053fb964ddb1mr2365208edy.37.1698411802669; Fri, 27
 Oct 2023 06:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231017193217.1512868-1-tong.ho@amd.com>
 <20231017193217.1512868-4-tong.ho@amd.com>
In-Reply-To: <20231017193217.1512868-4-tong.ho@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Oct 2023 14:03:10 +0100
Message-ID: <CAFEAcA_yCEtDkW6R43LGNjWGH323HuSWPFibgaRSZ=+DqfrZ_g@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] tests/qtest: Introduce tests for AMD/Xilinx Versal
 TRNG device
To: Tong Ho <tong.ho@amd.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, alistair@alistair23.me, 
 edgar.iglesias@gmail.com, richard.henderson@linaro.org, 
 frasse.iglesias@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Tue, 17 Oct 2023 at 20:32, Tong Ho <tong.ho@amd.com> wrote:
>
> Signed-off-by: Tong Ho <tong.ho@amd.com>
> ---
>  tests/qtest/meson.build             |   2 +-
>  tests/qtest/xlnx-versal-trng-test.c | 486 ++++++++++++++++++++++++++++
>  2 files changed, 487 insertions(+), 1 deletion(-)
>  create mode 100644 tests/qtest/xlnx-versal-trng-test.c


> +static void trng_wait(uint32_t wait_mask, bool on, const char *act)
> +{
> +    time_t tmo = time(NULL) + 2; /* at most 2 seconds */

Don't put timeouts this short into tests, please; ideally,
avoid them entirely. Sometimes the CI machines are heavily
loaded and the test might not be able to complete in a
short time like this. If you must have a timeout, it should
be at least a minute. (And see below on whether we need one.)

> +    uint32_t event_mask = 0;
> +    uint32_t clear_mask = 0;
> +
> +    /*
> +     * Only selected bits are events in R_TRNG_STATUS, and
> +     * clear them needs to go through R_INT_CTRL.
> +     */
> +    if (wait_mask & TRNG_STATUS_CERTF_MASK) {
> +        event_mask |= TRNG_STATUS_CERTF_MASK;
> +        clear_mask |= TRNG_INT_CTRL_CERTF_RST_MASK;
> +    }
> +    if (wait_mask & TRNG_STATUS_DTF_MASK) {
> +        event_mask |= TRNG_STATUS_DTF_MASK;
> +        clear_mask |= TRNG_INT_CTRL_DTF_RST_MASK;
> +    }
> +    if (wait_mask & TRNG_STATUS_DONE_MASK) {
> +        event_mask |= TRNG_STATUS_DONE_MASK;
> +        clear_mask |= TRNG_INT_CTRL_DONE_RST_MASK;
> +    }
> +
> +    for (;;) {
> +        bool sta = !!(trng_status() & event_mask);
> +
> +        if ((on ^ sta) == 0) {
> +            break;
> +        }
> +
> +        if (time(NULL) >= tmo) {
> +            FAILED("%s: Timed out waiting for event 0x%x to be %d%s",
> +                   act, event_mask, (int)on, trng_info());
> +        }
> +
> +        g_usleep(10000);

Why does this test need to use sleeps and timeouts?
A qtest test controls the guest 'clock' directly, so
usually they're completely deterministic. Is there some
behaviour in the TRNG device which is asynchronous (in
a way not driven from the QEMU guest clock) that I've missed ?

> +    }
> +
> +    /* Remove event */
> +    trng_bit_set(R_TRNG_INT_CTRL, clear_mask);
> +
> +    if (!!(trng_read(R_TRNG_STATUS) & event_mask)) {
> +        FAILED("%s: Event 0x%0x stuck at 1 after clear: %s",
> +               act, event_mask, trng_info());
> +    }
> +}

thanks
-- PMM

