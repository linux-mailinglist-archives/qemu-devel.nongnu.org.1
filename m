Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 258E37092DB
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 11:19:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzwFy-0005DB-14; Fri, 19 May 2023 05:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzwFw-0005Cp-0q
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:18:36 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzwFt-0003bj-EJ
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:18:35 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-510c734fa2dso1247985a12.0
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 02:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684487910; x=1687079910;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pF+94+WYAd0Xj1GS1XNVyRMXHfG2s/Cgnpk57e31Vhg=;
 b=FfRe5zl/guPWD0gy2VwXfKm6TuZLLFhu6tUJ0tyevbTt6rVNc0nBY2NghnQ3hw9j6w
 ZHEirsuLSP3iwX9/unsX2+wpJvGGLhzRLqHANfKFBr2cy7Hdgd05FHdSAWpZCjno11w9
 XulLz4F8faFNYDWfbFWFtXKAmqHbltTnlTbVE0hIdX2JKizRG6UKC4DpinKFjPY/ipI+
 TYvgVtCH7dfJxvUerAcaOJuHf+jE9RxpMr31SkSFgt3IJte66ZctyoZYFNx57AxLHAfz
 cOn9kPbNa4ZtvQC1TN81ifQtY/zplfxUDOfOUoMGbALh1Z4NmNxqnjN1dPVjrKNn4vRg
 HpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684487910; x=1687079910;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pF+94+WYAd0Xj1GS1XNVyRMXHfG2s/Cgnpk57e31Vhg=;
 b=cte30nj67eyzfAc7wbD8p6mC0rroxZPl37XI7oFm7xvhp1m8cGozMo3nBTYyCeu1yA
 dSeLbFxXw5bXwfyAXvqj2ENY8pKv8uLQ9/mpVOta6r6zCrR0ZGrMQjwTUJd2+FazeOx3
 S2M01f4q4wJJpqQpQurJ/eAh0bR2rdAyRwmcy4nGt2SC1jl4eKKgAuP4TSe1Sim1r/t3
 6FweHLnIC9OWkBsXf3Rjl8+jw1dtWLodupP3xBFOy/+kfdFwlxdD+qKihd2U6ST3j92N
 zuA1XjmL8rABlud6AkibyxbabPYBDb5iopQmxs9bGr7/9xZ0uib36A3npOFXC3Ad3I1k
 cjWQ==
X-Gm-Message-State: AC+VfDwF+8XAn3HjPeGMb6RnJ6Rn6TIxtwkecy3vD4o4orDbvR0Y5PYS
 hVtphoCbYpMPiWgwdZ4mV2YsHSWtnbmqBOLMzGpfww==
X-Google-Smtp-Source: ACHHUZ4WkInYgfpE55a818sjkKyRasCSWfoQ/cFjWFoLagbZbmlAhx63blPey8jTbLoHiHjE6ivG0mUnd+3P3bLMEaE=
X-Received: by 2002:a05:6402:2554:b0:504:77ed:5a33 with SMTP id
 l20-20020a056402255400b0050477ed5a33mr7746048edb.8.1684487910648; Fri, 19 May
 2023 02:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <58b8067d-3136-94ed-f53e-2ccd0feb8c75@linaro.org>
In-Reply-To: <58b8067d-3136-94ed-f53e-2ccd0feb8c75@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 May 2023 10:18:19 +0100
Message-ID: <CAFEAcA8nKiES473FbfCa=jkTO2SaVTKOgGPoAAFAzaojZZ86jA@mail.gmail.com>
Subject: Re: gitlab shared runner time expired
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Thu, 18 May 2023 at 20:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> So, here we are again, out of runner time with 13 days left in the month.

This is quite early -- have you been processing pull requests
strictly one at a time, or in (small) batches ?

-- PMM

