Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E311875742F
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 08:31:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLeDP-00027A-7S; Tue, 18 Jul 2023 02:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLeDH-00026l-CB
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 02:29:35 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLeDD-0008KL-OE
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 02:29:34 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fc0aecf107so47949575e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 23:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689661767; x=1692253767;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RVinK/DJQP3dAFYeWuBpJgdtmJF3ennXH5vsB4ywhjI=;
 b=tTcnzSGSxqV+fjI4nw8nM6ot+a1QktS5eBMewODH6DfbjtpKdQwHt3gta/rtE1m4jV
 jO1laJa95AnYFf24ZUQIx8Z+kTKO4QfcVVKrxX5fFhH3Y3AHC+PEbfBA4KqrlrKEy/Bp
 LONBEBxyiF/XP/QoG+k9irMFL0owkArNdOPqZUCdwWYT2xoFPhEUeMK+0QwB6WX/BKDd
 rTj2Svg/qKgO9kltONh45AbJdNHqng9txy7xwsCRQKc06zDENL9BSYX0RJYuyUQPO0D1
 dTJuKm9Tv3gQDRl3QoNmtwOKNhlbR4TLfIMRL2IRB3sDH6luODwL8AzrJbKUJWhSksdN
 LYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689661767; x=1692253767;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RVinK/DJQP3dAFYeWuBpJgdtmJF3ennXH5vsB4ywhjI=;
 b=g/VHPQg6phyBnNl+m/1n8TOoon8F7Hh//CKDWVcQhgJmDzPCyti89zye/9bhWrKHNZ
 I+uC78f9Z0LX07Vkl8/fAmbUWwvumQbHIDHAdbcz009z3irsFZXEe0z10SgxXQPtbcXW
 OgrSdwyoyRF/IfHJmYwCSJ1QzBGTJZx4Ob8cvqRpp2a3BwT/uYI0BlOZJsnS7jeXlEuy
 M8YtPJFa7NEDmJYh1u2hZfpJnywr/19wn9SWucK6J9fTc20JuyO3ZJffoCxcCDoHMwGr
 Pg5SNHUVokomUbPuN/gjry1k19YjVscPOhtggUh8n8wJXWpq3AqbyxFaSYQs/yBSHWnM
 omjQ==
X-Gm-Message-State: ABy/qLZtwHbt1AhIf1wVpEjWHCJQ3wGY82yrA9zxMRFNxAUyC6+YOAGB
 Mne8nMv2ssg4PCSq8GDjr+/hAg==
X-Google-Smtp-Source: APBJJlGW8yoU+epCqObwALsI2MLRFDg3GfI/Qkc1q29+hTjkHUoYxyXtgwe1kJbBPZv7ctavtk+tPA==
X-Received: by 2002:a05:600c:ad3:b0:3fc:21:2c43 with SMTP id
 c19-20020a05600c0ad300b003fc00212c43mr980447wmr.13.1689661767344; 
 Mon, 17 Jul 2023 23:29:27 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.222.251])
 by smtp.gmail.com with ESMTPSA id
 d12-20020a5d4f8c000000b003141a3c4353sm1383935wru.30.2023.07.17.23.29.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 23:29:26 -0700 (PDT)
Message-ID: <bfe5c146-f943-d1ab-2abc-1ee0fe2d7c2f@linaro.org>
Date: Tue, 18 Jul 2023 08:29:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2 12/12] mtest2make: stop disabling meson test timeouts
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20230717182859.707658-1-berrange@redhat.com>
 <20230717182859.707658-13-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230717182859.707658-13-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.097,
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

On 17/7/23 20:28, Daniel P. Berrangé wrote:
> The mtest2make.py script passes the arg '-t 0' to 'meson test' which
> disables all test timeouts. This is a major source of pain when running
> in GitLab CI and a test gets stuck. It will stall until GitLab kills the
> CI job. This leaves us with little easily consumable information about
> the stalled test. The TAP format doesn't show the test name until it is
> completed, and TAP output from multiple tests it interleaved. So we
> have to analyse the log to figure out what tests had un-finished TAP
> output present and thus infer which test case caused the hang. This is
> very time consuming and error prone.
> 
> By allowing meson to kill stalled tests, we get a direct display of what
> test program got stuck, which lets us more directly focus in on what
> specific test case within the test program hung.
> 
> The other issue with disabling meson test timeouts by default is that it
> makes it more likely that maintainers inadvertantly introduce slowdowns.

"inadvertently"

> For example the recent-ish change that accidentally made migrate-test
> take 15-20 minutes instead of around 1 minute.
> 
> The main risk of this change is that the individual test timeouts might
> be too short to allow completion in high load scenarios. Thus, there is
> likely to be some short term pain where we have to bump the timeouts for
> certain tests to make them reliable enough.

[*] (see below)

> The preceeding few patches

"preceding"

> raised the timeouts for all failures that were immediately apparent
> in GitLab CI.
> 
> Even with the possible short term instability, this should still be a
> net win for debuggability of failed CI pipelines over the long term.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   scripts/mtest2make.py | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
> index 179dd54871..eb01a05ddb 100644
> --- a/scripts/mtest2make.py
> +++ b/scripts/mtest2make.py
> @@ -27,7 +27,8 @@ def names(self, base):
>   .speed.slow = $(foreach s,$(sort $(filter-out %-thorough, $1)), --suite $s)
>   .speed.thorough = $(foreach s,$(sort $1), --suite $s)
>   
> -.mtestargs = --no-rebuild -t 0
> +TIMEOUT_MULTIPLIER = 1

Maybe:

    MESON_TIMEOUT_MULTIPLIER ?= 1

So one can run:

   $ make check MESON_TIMEOUT_MULTIPLIER=0

to tune a modified test timeout limit in [*]?

Regardless,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +.mtestargs = --no-rebuild -t $(TIMEOUT_MULTIPLIER)
>   ifneq ($(SPEED), quick)
>   .mtestargs += --setup $(SPEED)
>   endif


