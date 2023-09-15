Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B977A2353
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:11:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhBOA-0005iX-59; Fri, 15 Sep 2023 12:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhBO8-0005iN-Vp
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:09:49 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhBO7-0006Te-00
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:09:48 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-52bcb8b199aso2808826a12.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 09:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694794184; x=1695398984; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hF5v+c1JQ0kP80vxS0nuCMOLEioG0m8CJTh4+ocDlMc=;
 b=KOZXqrzJVhknApWvKh3MBuoLFK7cjF5nDveR9BC2zHMJIhunDeLZQ5ZtSsdBjMCOrj
 Yc3uoyvIQFPgV0Uk/7WLt5eMZCAQvcHylEFsNPs7VN5u5CFW4WDe+IUz99sET5sh5+3j
 /4aL9xO0bIn8AN4mzxIVAOBxsjNJ8USByYmSkc6OQIqB82j6gzZTgjEZvHMOGSDiS2MQ
 bAAf6SLgFvvEyESAtO2TBFiBVgmw3nnUOmNsParfuPc5qLhjdTclX8g/Rk0Jdw9REOUS
 1CE0TCBcZxcMSyqGt9ikXfE20KiDjmJ/zZXOH190Qncjk7tiB+ZHSAVegMITlmhAAd34
 5t6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694794184; x=1695398984;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hF5v+c1JQ0kP80vxS0nuCMOLEioG0m8CJTh4+ocDlMc=;
 b=ql8eiS72Rv+kCSjprplCL9dPgrz/OhmiAyiVr41957crD/EGCmXWQKxglQGhM7x2DR
 f1smA+8d8lfjWaWGd1EOCUgf5XXIrCb8KBw4hhKexJzRJ55pEVraHNPZCYB1OVJYwcXs
 3blosKl9UVk2V+XBa7FVrLktX4nq9aEu8oC+4cB1k2GbDFi5nw3qyJcjxrcIbNffVurF
 obL20XR+nJNt91tPzCT9bpeptXBgwxnI16jVb9X6wdfkn3GNpYxvKX7VRx7JV649Io+o
 8qhDgGrlx5t7FB9VRJZGJ1zUF9FlzYf33VOm3sG8MQ6ljnFX/1jQB+PhXtJBzU/4EYSg
 8o5w==
X-Gm-Message-State: AOJu0YzjFmrAeak/1IuD9FmzWG7jHOJThT9NZlOSLZXy7uMqXhBnNtSE
 l+2LdzHhnrKWlve7O7oF5uz1Lw==
X-Google-Smtp-Source: AGHT+IGKHk4AiUNbDA8eRUg6Fr74zFrZClpIi2wTfgoicTq/x4Obc8rcTxsLLJ+wafxvo7GcIifRdQ==
X-Received: by 2002:aa7:d3d4:0:b0:51d:9399:4707 with SMTP id
 o20-20020aa7d3d4000000b0051d93994707mr1520011edr.26.1694794184113; 
 Fri, 15 Sep 2023 09:09:44 -0700 (PDT)
Received: from [192.168.69.115]
 (6lp61-h01-176-171-209-234.dsl.sta.abo.bbox.fr. [176.171.209.234])
 by smtp.gmail.com with ESMTPSA id
 eg33-20020a05640228a100b0053030c3355asm1914514edb.75.2023.09.15.09.09.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 09:09:43 -0700 (PDT)
Message-ID: <20171390-43cc-ee15-128c-7e9b9892483a@linaro.org>
Date: Fri, 15 Sep 2023 18:09:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC PATCH] gitlab: shuffle some targets and reduce avocado noise
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: fam@euphon.net, berrange@redhat.com, f4bug@amsat.org,
 pbonzini@redhat.com, stefanha@redhat.com, crosa@redhat.com,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
References: <20230915160358.615687-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230915160358.615687-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 15/9/23 18:03, Alex Bennée wrote:
> We move a couple of targets out of the avocado runs because there are
> no tests to run. Tricore already has some coverage, for cris we make
> use of the fedora image we have and its own check-tcg tests.
> 
> To reduce the noise of CANCEL messages we also set AVOCADO_TAGS
> appropriately so we filter down the number of tests we attempt.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   .gitlab-ci.d/buildtest.yml | 26 ++++++++++++++++++++++----
>   1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index aee9101507..7813cb09a4 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -30,6 +30,7 @@ avocado-system-alpine:
>     variables:
>       IMAGE: alpine
>       MAKE_CHECK_ARGS: check-avocado
> +    AVOCADO_TAGS: arch:avr arch:loongarch64 arch:mips64 arch:mipsel

Doh I never realized we weren't using AVOCADO_TAGS in CI, since this was
the point of adding it... I suppose the patchset was contributed half
way. Thanks for finishing the work here!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


