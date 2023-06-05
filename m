Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F4C722C05
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 17:57:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6CZe-0005P8-KO; Mon, 05 Jun 2023 11:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6CZd-0005On-6j
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 11:56:49 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6CZa-00047q-Nt
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 11:56:48 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5149aafef44so7111229a12.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 08:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685980604; x=1688572604;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IdJHHtffXmwBS9mTutnKEK3lnhB6cNHMZ7eV3hw1Odo=;
 b=boVKRku3EOieHAt8iiLKJAUBlTPoiLp15LESsLBzJLDC3Bbg/oFK7M3Xxhuo75zkB2
 zL9oxCQCccdp/9ejV0ohw5U4U6tInO5JUaNnfG/PUsCKuv+WddWRUE9btYk+e+fZpC2n
 n3EE7+6+2VLaIiiX5/dxputOQil2bHjqffenP6I2XjZCBzd6C1iscHfGrqeVsr2TOsgc
 kjiaY+I7RFW5ksLNyS0p0smyi1V9ND5Wvk+hebN8t2X1M5PT/6lGbRur727olzNIewdt
 8TL7POXsyURQeJ+yRFN5l1/8MWZliBEsIR9Uo/uNgHiBMsCicsOBrMSOV+TzUgIB+3N9
 z/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685980604; x=1688572604;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IdJHHtffXmwBS9mTutnKEK3lnhB6cNHMZ7eV3hw1Odo=;
 b=NuEcSpZkcLTDGxVy+QmncYOnBrDLUkuC5a0NraxJjWe1bRFmcjcaCcZWb9XkY1y6hf
 2SyRtOv4AgxOBzHE7UYq3CCg0IpK45iDuZbMpI1zJTlj0GbOLZwTDFhfz9YjjnevJIKx
 1fnZhPf4VeVpIGvU68i7+AEIIUQHXIptqzvcDwexkaSJhsFG2BqNpiFBTN/QhwwvtPjz
 fbhuwXpYn+Z8ADgLcINxtYfTibIw7qgwcAlPEN5fSqiteZJHb/kqEVD6vLD/yW+qaLbU
 JKt9Yj4r9+cSNKXPXBYBTZPbhprZt93FogCJprGucqCPUnzsUHIMVk1druOfwP6MT4nv
 5ctw==
X-Gm-Message-State: AC+VfDyGgWGkVTuOrfTCklEoLKm+dMk6x6sHTEqZYWFdQYSgIycrZRhd
 QPrmB9GTgfAx/lEjwLUT4Rp4UTD9x7TWFCbQ6YjXh8s8isy6zj5Y
X-Google-Smtp-Source: ACHHUZ6x9rZ+wwX8A1AiKdjt6SZyfdTJCMJp2sYKaeHyx9aNa4vEsh6hbf6zZd4V15oGgTRme6r9bbDYv5YKc7T25tc=
X-Received: by 2002:aa7:d80f:0:b0:514:9e26:1f51 with SMTP id
 v15-20020aa7d80f000000b005149e261f51mr8248860edq.24.1685980604696; Mon, 05
 Jun 2023 08:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230530191438.411344-1-richard.henderson@linaro.org>
In-Reply-To: <20230530191438.411344-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Jun 2023 16:56:11 +0100
Message-ID: <CAFEAcA_d71EKi2bLJVy_sUbGZEwcCSL7QMrPTGDLQqXcg1Wb3w@mail.gmail.com>
Subject: Re: [PATCH v3 00/20] target/arm: Implement FEAT_LSE2
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Tue, 30 May 2023 at 20:20, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> All prerequisites are upstream.  There are still outstanding patches
> to improve the atomic16 support, but those are all optimizations.
>
> Patches needing r-b:
>   16-target-arm-Relax-ordered-atomic-alignment-checks-.patch

Applied to target-arm.next, thanks.

-- PMM

