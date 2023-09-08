Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D088E798E4C
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 20:36:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qegKF-0006Db-At; Fri, 08 Sep 2023 14:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qegK6-0006DH-Px
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 14:35:18 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qegJv-0000Sr-Dk
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 14:35:18 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-52c88a03f99so2997569a12.2
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 11:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694198105; x=1694802905; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DwOs+oep05OkJ7YNSfXeMBL8IW6d898T+S51KR4qq9w=;
 b=rut/wnlc+/2OQR4X6kGkCnVBJvU0bVchD5ktxaqR3rWGbkU0o0UeBTrrhIjf4PEZzs
 rWDmjMjF6ycLWNxmLtFRglZvoVMPoEhfH9JwYM0Ssy2Uz6gvcIgnHG6zNKIMXEwFi+3Z
 n6Tost6BGmu/2EM51ic6HgO/MOj3JoP8tsGxpPeBO3UNXqLYwwgnaD38+Ad67y0lVLNB
 PXTMIuKMqQWNEPae/s50fjh18hM7GJrNbusZCsahY3XSDi8qVaL0m5Gkic4hVBm7i9xQ
 vCTuAD/+h/+e7QJS48Z72i+PY68MUPd9QnREXp7uAT9GuCdLxS6sz5x4IeixsMV+Njcu
 RiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694198105; x=1694802905;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DwOs+oep05OkJ7YNSfXeMBL8IW6d898T+S51KR4qq9w=;
 b=m5wgUMnYQtm8cMIYRj9koKCn4E2ZNsWGC1RrZDbLy+RDaCupju8SR1aKbDcWdwnfei
 DP1cC6vg601pLLMliBiTtY4Qzt2eQCQB4w70+OfAzf+YwTzJGguRxr3QkqcQHP9Bjae5
 4NQb+YHDg6AmmVy7Nx2g+vktvotlWjKJZ11IxVLM4Fv4yde/gyH0cL8kHPDXvLLHJGLr
 1MrhWBmKs8h+h00FaKiuwI/fyPiK6bHzG+tX0wWghGZNL/9xFtgMZ6OIpyJNh4Q1faAt
 OsL+oWOqEBoEbfxwxzsZEozwcq1IbrbaKY7I0X412rhuLNI9yQrICpD6LtSrEj1aq2Sp
 H5Aw==
X-Gm-Message-State: AOJu0YzHWufBJu3b7bRH7k/2+gjA1Wj8wzfEAUAU7zn0LzLaFA1/M0Kn
 7UjwPVRjBT9LLM5wrVg3QgzSuJuNR9XbXKmlXVQ5fw==
X-Google-Smtp-Source: AGHT+IGrkdcOwc0fVhRiJy2IO9o5YF4YDJm7TVLUKwI0u7b/yMfxuYxUCiaV2Spm+Zsmus+AgN6qBHdqPuKojxv0KZw=
X-Received: by 2002:aa7:c74b:0:b0:523:c35:c209 with SMTP id
 c11-20020aa7c74b000000b005230c35c209mr2399592eds.12.1694198104610; Fri, 08
 Sep 2023 11:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230831171849.3297497-1-tong.ho@amd.com>
 <20230831171849.3297497-2-tong.ho@amd.com>
 <622751d4-8a89-b34e-171f-9e9f7ac99972@linaro.org>
 <BL0PR12MB48829589D59FA02B93549E65E6E4A@BL0PR12MB4882.namprd12.prod.outlook.com>
 <CAFEAcA_KJFnxg-msgwiaFBzPYkj4RPQeYwLzd4RCy3_br11AGQ@mail.gmail.com>
 <BL0PR12MB4882D72296EE27610D9B04D5E6EDA@BL0PR12MB4882.namprd12.prod.outlook.com>
In-Reply-To: <BL0PR12MB4882D72296EE27610D9B04D5E6EDA@BL0PR12MB4882.namprd12.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Sep 2023 19:34:53 +0100
Message-ID: <CAFEAcA-F21-kpzoUNMiUJY6t9eyMueJ7b6RqgVOgAu_ZwdRkog@mail.gmail.com>
Subject: Re: [PATCH 1/3] hw/misc: Introduce AMD/Xilix Versal TRNG device
To: "Ho, Tong" <tong.ho@amd.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "alistair@alistair23.me" <alistair@alistair23.me>, 
 "edgar.iglesias@gmail.com" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 8 Sept 2023 at 18:56, Ho, Tong <tong.ho@amd.com> wrote:
>
> Hi Peter,
>
> The Versal TRNG device is required to support both TRNG mode and PRNG mode, and target/guest
> software selects and changes the mode at will during runtime.
>
> I do agree that, in the TRNG mode, the model using qemu_guest_getrandom() will work without any issues.
>
> When software selects the PRNG mode, the Versal TRNG device is expected to output a reproducible
> and deterministic sequence of values for a given seed.  This is part of the hardware spec.
>
> I fail to see how qemu_guest_getrandom() can be used to model such requirement correctly.

If the hardware documents a specific RNG that it must use,
then yes, we should model that, and the comments need
to make it clear that we're modelling a very specific
thing, not merely "here is an arbitrary PRNG".

-- PMM

