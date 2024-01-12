Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2A582C543
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 19:13:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOM1J-0007iG-KP; Fri, 12 Jan 2024 13:12:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOM1H-0007i0-U2
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 13:12:39 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOM1F-0001Bx-Kt
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 13:12:39 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5571e662b93so5717576a12.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 10:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705083156; x=1705687956; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kjXzb5KjXQz3d5/KnlN/FIkfPU5DXViM22ChPoPwNLo=;
 b=ZrH+wtzFUwzbnbQESfXGvth+Yj18Yf6QVgVFIjpcm4cEBuDqxNmtsloQjr+dlk7VHT
 2w6rj4WnrN0K2IsF7a1/Ruo2eNIl/8f8EbwVADJJjUazxzPmQZ6LbhG+K/O7n71VSffL
 Z4ML2FbbZGR3wjj5DATOSFgEdchgwKDOE8+1N22bdV0Qz/yUUaW2VqSuorZReNrr642z
 7A+wFPYJrc8KzRQkpRd4y3adz/9KQIDrRqD8aF+JMlt6+ZdJP156Oh/7Ulz8kvWYDU0A
 un1EZ7k8s+Gagilt3Zvn/ERLnS2RRuwHOuaTOtSIJKBECwTKpFXF0tKdkCjzC4P8Bfk/
 IBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705083156; x=1705687956;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kjXzb5KjXQz3d5/KnlN/FIkfPU5DXViM22ChPoPwNLo=;
 b=k4y1xL8N9I9pqzPM0uxhwvEH1DoktPjwXVyUf2i2TRTDojpEwuWoIpbLw3W69hMqUh
 WbUT3RKlAY/B+OUW3DeF/GWr4Y0MdUiTghV4Hp3QFlFRpgqfadZ0bQ8y0B3bPxbCBi/T
 PVKO4+f5VtNs5WvIMq+Y6UZLC8fdm6i2FV2uYWq172LC7v3pl34tTrF0zhAp6IW0bGWy
 ff9gfn1rP1f+eICvQ+Et0IFXgbbWRpwORTtj+Y0ZiKo6DIRBYfA6lnbknWC1Zb9JBaq/
 tOrN2hhpiw1h/7I9NXC5OZqrY8K1ulsJhuUJVAow+fuFyKSM/GItPgeT1b2dIv2xXrna
 fcpA==
X-Gm-Message-State: AOJu0Yy9mW3s5zcUdWSQ+ieEy/5RdAbFKHFjubdEAv4gmiIOtGflbx0x
 QPmbtRSwGUHR+Ek3IQu73tv+epLFvXac2nWwC3M2WjdVGnphnw==
X-Google-Smtp-Source: AGHT+IEWhVE18YS9y83qsbz01p8yDgVqq0mcVFRYUrDQZl1/wQ2FY/XCUQwCtqlRPpSL95sPYJt69wSRnlTYFx6KTYE=
X-Received: by 2002:aa7:db57:0:b0:558:e3ad:8acb with SMTP id
 n23-20020aa7db57000000b00558e3ad8acbmr433584edt.80.1705083155930; Fri, 12 Jan
 2024 10:12:35 -0800 (PST)
MIME-Version: 1.0
References: <20240111051054.83304-1-gshan@redhat.com>
In-Reply-To: <20240111051054.83304-1-gshan@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2024 18:12:25 +0000
Message-ID: <CAFEAcA93t6oXv3E9Qa13jvz+pMZHGCQR7hQuaWbT62MJLZGMvA@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/virt: Consolidate valid CPU types
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, philmd@linaro.org, 
 richard.henderson@linaro.org, shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Thu, 11 Jan 2024 at 05:11, Gavin Shan <gshan@redhat.com> wrote:
>
> It's found that some of the CPU type names in the array of valid
> CPU types are invalid because their corresponding classes aren't
> registered, as reported by Peter Maydell.
>
> [gshan@gshan build]$ ./qemu-system-arm -machine virt -cpu cortex-a9
> qemu-system-arm: Invalid CPU model: cortex-a9
> The valid models are: cortex-a7, cortex-a15, (null), (null), (null),
> (null), (null), (null), (null), (null), (null), (null), (null), max
>
> Fix it by consolidating the array of valid CPU types. After it's
> applied, we have the following output when TCG is enabled.
>
> [gshan@gshan build]$ ./qemu-system-arm -machine virt -cpu cortex-a9
> qemu-system-arm: Invalid CPU model: cortex-a9
> The valid models are: cortex-a7, cortex-a15, max
>
> [gshan@gshan build]$ ./qemu-system-aarch64 -machine virt -cpu cortex-a9
> qemu-system-aarch64: Invalid CPU model: cortex-a9
> The valid models are: cortex-a7, cortex-a15, cortex-a35, cortex-a55,
> cortex-a72, cortex-a76, cortex-a710, a64fx, neoverse-n1, neoverse-v1,
> neoverse-n2, cortex-a53, cortex-a57, max
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Fixes: fa8c617791 ("hw/arm/virt: Check CPU type in machine_run_board_init()")
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---



Applied to target-arm.next, thanks.

-- PMM

