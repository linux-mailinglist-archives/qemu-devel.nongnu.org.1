Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6E371F2C3
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 21:17:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4nmL-00027k-NR; Thu, 01 Jun 2023 15:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4nmJ-00027U-5m
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 15:16:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4nmF-0003BJ-9E
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 15:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685646962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uIcvWL05G+NF2Wz54ykEVDZlOs0JX9tvod0B1qrn50M=;
 b=KR7NGJODaEFmY/cvWIro7MERaW+nAFyGJpT8/HizCin+D5rso84jnBQMZKX5z+8pKYOlb8
 v3YU0oRbZ19+xrWeXGDv0FO9VE/QQmumQqR1ujjLcUEloisF5w+1x++TvGePip21ygdy0N
 /pMPqDsIa92tM1z6ttJ3z8b1a0pkaWU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-QA6rEDV6OxOuKQxGztFoBw-1; Thu, 01 Jun 2023 15:16:00 -0400
X-MC-Unique: QA6rEDV6OxOuKQxGztFoBw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-94a355c9028so84619266b.3
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 12:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685646959; x=1688238959;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uIcvWL05G+NF2Wz54ykEVDZlOs0JX9tvod0B1qrn50M=;
 b=CfbUXl52R6ASp8eKDlrCT3xJCpUm9I3vbsVgTQB86B+KyyHJ/NOSNodGrwtAEi9D9I
 R9wfuztDQYCYpeJqKt1VB4aKUhZG+C6AfLAdWIH/JqTOrNYAdcM8X7s4/oa7DfMZwjhc
 4n/82qSUwHZVnZGXI+7E29dA9ALVKVbdetxHB1HUplgYNJwuB7/fDvVi7BfZ7O79mIL2
 oY/X/ROyRRusM8eOTv7BzphGyHUm71aDVDJt/erm7VJjw4bCd/VSVcL3EZphCJVIi7Ia
 scb8WKpaMDWC2sI/VaNpkq8WbnDjlnDD2ek7862Hs0+1hVAcdJokCpSlflsWnKfZXfZx
 vOAg==
X-Gm-Message-State: AC+VfDwLn4BEOivI2/e/mUoOtrWmwxXC53vstni6u09Ne7dO4WLq7kIe
 lSu0e1vaJWkpzOLf5emzrVPmiEI3QY7W8l8etvnOzqsdCzecKbQKinGvn/cE9hWtKyUFMzqFzbP
 bgqSc/B+oAs/WruM=
X-Received: by 2002:a17:907:97c3:b0:974:b15:fcda with SMTP id
 js3-20020a17090797c300b009740b15fcdamr10493278ejc.54.1685646959368; 
 Thu, 01 Jun 2023 12:15:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Oo5dIifulAI0uySs66anbsel3dw/H+Pf5wGzDuQRuv62g7p9BSGA4oXCgLziWBLtVnqQjQQ==
X-Received: by 2002:a17:907:97c3:b0:974:b15:fcda with SMTP id
 js3-20020a17090797c300b009740b15fcdamr10493269ejc.54.1685646959111; 
 Thu, 01 Jun 2023 12:15:59 -0700 (PDT)
Received: from [192.168.8.105] (tmo-065-8.customers.d1-online.com.
 [80.187.65.8]) by smtp.gmail.com with ESMTPSA id
 p18-20020a170906a01200b00966447c76f3sm10955246ejy.39.2023.06.01.12.15.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 12:15:58 -0700 (PDT)
Message-ID: <13784cfe-1666-3350-cf79-7508afb79ede@redhat.com>
Date: Thu, 1 Jun 2023 21:15:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 6/6] mtest2make: stop disabling meson test timeouts
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <lvivier@redhat.com>
References: <20230601163123.1805282-1-berrange@redhat.com>
 <20230601163123.1805282-7-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230601163123.1805282-7-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 01/06/2023 18.31, Daniel P. Berrangé wrote:
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
> For example the recent-ish change that accidentally made migrate-test
> take 15-20 minutes instead of around 1 minute.
> 
> The main risk of this change is that the individual test timeouts might
> be too short to allow completion in high load scenarios. Thus, there is
> likely to be some short term pain where we have to bump the timeouts for
> certain tests to make them reliable enough. The preceeding few patches
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
> +.mtestargs = --no-rebuild -t $(TIMEOUT_MULTIPLIER)
>   ifneq ($(SPEED), quick)
>   .mtestargs += --setup $(SPEED)
>   endif

Basically Ack, but could you please double-check that "make check 
-j$(nproc)" still works if configure has been run with "--enable-debug" ? 
... maybe we need to adjust the multiplier in that case...

  Thomas


