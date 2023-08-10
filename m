Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5971177743B
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 11:18:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU1nK-0002YW-73; Thu, 10 Aug 2023 05:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qU1n6-0002R3-0z
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 05:17:16 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qU1n1-000062-TJ
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 05:17:09 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5234f2c6c1dso863607a12.1
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 02:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691659026; x=1692263826;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cROljJL0g0JpQ4Zaq6M6Leunnnywaeha3HFbFJAjtMg=;
 b=S/XS9zm1x+2jN7SIU5iFOPbaEVricnXezMf0e4+3Jk3PSeBw8g7XMXHHa4Yk2ZknHZ
 IPfQvu/xhu3y6xwoyUtoVxCxb5yHO303bR/bqCgMmHVyL1ujAjIafM74wjoG2WLgenfH
 R2Rd8chPDYyL+YXyWWsjpguPWp38QzsH2DJBERXXoVzKkB3Wn96UZPfXohbDz39mYnuu
 Kz5enXx/xGeJzLKECh9N7eE4c+wA646fj5Ph18le1LSwmq7QIZVGeRqVvdNSEVophAr3
 dRTz4dA8YItodDjVp0QYev+oiavBWrgKySDnj6lZmLIFhT2RclSvOE2+j4QqqqX1SQoH
 eklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691659026; x=1692263826;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cROljJL0g0JpQ4Zaq6M6Leunnnywaeha3HFbFJAjtMg=;
 b=ftHnXOi1m1l6mCeKnvD677Cxijg8lWKv0ZVKe7ZeRZjNYv+VXPCycz7UYrsWL1Qx3r
 xfKwhb8V1qFxt8fub+7CglGpTS5kU5x4kVt6e+Iq+0QF7les9hsetyY2VEgGu9RB8tCF
 iI7JYv6vl5kLJi+VugKEuGoh9vv5tSaQ4BYEhWAid4xMpjQME2ryd1IWAMq7it5o23iw
 Lpozaw65DC9VUXppoJLzeGUxAaxDjryPAglobCYJ94nW/ssLuZa2h6O1BfxX8/PUEz5V
 8YlY3frTGyo9ErXl8iRwQqfCgN7t41MxpboVb9wHTLgWcpLXHrka/ZxRcjqeq+xnmrgc
 STYA==
X-Gm-Message-State: AOJu0YxVZrk0E8eA3vI5Rba3/Db9BbZYoNKlQr9Fgi4JkxjGbY9U3pP5
 WKvyksXsrnbi3dOzZ+iEQXNEWPV1c3rbS/QGd/+sNQ==
X-Google-Smtp-Source: AGHT+IHmQ661dkFC7OZs3KnPMZtq40GMZGTESGXOO7ORZFpSCpuOLwJLDTdMLPXy8bSHXnRCxIpUQxWLjpsKruCxr/g=
X-Received: by 2002:aa7:d814:0:b0:522:2ba9:6fce with SMTP id
 v20-20020aa7d814000000b005222ba96fcemr1816474edq.8.1691659026097; Thu, 10 Aug
 2023 02:17:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230810023548.412310-1-richard.henderson@linaro.org>
 <20230810023548.412310-2-richard.henderson@linaro.org>
In-Reply-To: <20230810023548.412310-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Aug 2023 10:16:54 +0100
Message-ID: <CAFEAcA_utXHbmNydvQZoNVciuj8XnTjRW8zdGRbruyr2QK70ZA@mail.gmail.com>
Subject: Re: [PATCH 1/5] target/arm: Disable FEAT_TRF in neoverse-v1
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Thu, 10 Aug 2023 at 03:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Self-hosted trace is out of scope for QEMU.

True, but we already disable this in arm_cpu_realizefn()
along with FEAT_SPE, FEAT_AMU and a bunch of other "out
of scope" or not-yet-implemented features. I thought
it more reliable to do the disabling globally rather
than rely on everybody adding a new CPU to remember
to adjust the ID register values. (Plus if we ever do
implement some approximation to one of these features
we only need to change one place in the code, not
re-look-up all the CPU ID register values.) See
commit 7d8c283e10dd81.

thanks
-- PMM

