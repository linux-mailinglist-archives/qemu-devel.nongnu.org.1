Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E46AC78C8EA
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 17:54:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb12L-0004dT-HU; Tue, 29 Aug 2023 11:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qb12J-0004d7-S4
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 11:53:47 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qb12G-0007SX-Bf
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 11:53:47 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5298e43bb67so9438268a12.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 08:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693324423; x=1693929223; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dFWvO2HSy4bQBUgPqx0FnbS5LqLLwLj4Qs4qOlhSbUs=;
 b=cFRmt0isrKKo41jC4tqpbNJfq4aNEJZrrkrySGb/cFLIKrfV0L02cJWL6iBcBCgDMH
 SrAnkzXnlI8FJhBD9kUa8fXJ8ziSwdVTleACJaap46NEuBQ+03ELzA05BvV7/6sbh2xM
 p5Ude3WJMRCiJpjnW5KYcdopnXfOcuM2iqhV7AQVZQKWQAT4i2Qu+HwCZCYcu9NLATlU
 uzigVEJyDwLCJpbf90ljGNOuVxLOFWACRWL+5UYPMWvI/BnNkcZm0jjlYhgD22jvP2Tm
 w2oTUCkPDKrftjPDFZiyXW3nrmB/CyYQyOD6cdy/dnkN+oIeYu21IPKrZoBWAdbMNoUG
 itsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693324423; x=1693929223;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dFWvO2HSy4bQBUgPqx0FnbS5LqLLwLj4Qs4qOlhSbUs=;
 b=OZt2zMNuxUnFQZbBDhqCftvv9QQdmI0ktfW4IW7tvOhL/UEqcl4sukxahN3ifCv9iJ
 yGLS2K+Dzta86xbdypPHMyOV8fr4guMuG1W2t6uLNPfPP3VC9XSU50lw+ip2tNUId2c6
 hhsQB5PY2KJ0q38mhlste0KePlItXAJmC1B5dsfezhaVCih0NC2IdmKCTbGh433ggWu7
 7QAgRrJBROksBygep3ursSMmiRvt+rE/4EGZRyb6lXYkppHMyKHZVRRGHxsn/QkI7TJ+
 47tM0ajPHTJcJ7Ua7b5S0t1KIsV6Ess96HUSq3VYXFlj/GgKWKLiku1RF4z+22T+Q69p
 goZg==
X-Gm-Message-State: AOJu0Yy61cZbmCvmSMGFHrZcVHj/p+oZZOVRicJSnyrTMG3ulhRT3UG+
 xucyy89CInpBR+RUtD4hu0YIWcvnPZ7XGmKnv9Epz4JrR1QjapH1
X-Google-Smtp-Source: AGHT+IFl4XuIm6PDK3izyI44AgLyRAFH6gKZZLgYtSxU3YiG71ZEwCBvw7VXw3KtQX1aGBhVqFbmo2OznnbMECh6SDw=
X-Received: by 2002:a05:6402:3514:b0:523:4e41:2a37 with SMTP id
 b20-20020a056402351400b005234e412a37mr3650079edd.11.1693324422895; Tue, 29
 Aug 2023 08:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230724174335.2150499-1-peter.maydell@linaro.org>
In-Reply-To: <20230724174335.2150499-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Aug 2023 16:53:32 +0100
Message-ID: <CAFEAcA-jjZHx-7-oCEu+2kMQ38J6=szkK1qrjmOi+gxAd5GOzg@mail.gmail.com>
Subject: Re: [PATCH for-8.2 0/3] arm: Use correct number of MPU regions on
 mps2-tz boards
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Mon, 24 Jul 2023 at 18:43, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patchseries resolves issue
> https://gitlab.com/qemu-project/qemu/-/issues/1772
> which is a report that we don't implement the correct number of MPU
> regions on our MPS2/MPS3 boards.  Ideally guest software ought not to
> care since (a) it can find out the number of regions by looking at
> the MPU_TYPE register and (b) if it wanted 8 MPU regions it can just
> ignore the 8 extra ones.  However, Zephyr at least seems both to
> hardcode this and to care.
>
> Patch 1 cleans up a bug in target/arm code that meant that we
> were accidentally not exposing the pmsav7-dregion on v8M CPUs.
>
> Patches 2 and 3 then define properties on the armv7m object
> and the ARMSSE SoC object, and have the mps2-tz.c board code
> set the properties appropriately to match the config as
> described for those FPGA images.

Ping for review on patch 3, please ?

thanks
-- PMM

