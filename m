Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E7B78D00E
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:13:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7n2-0000oW-8p; Tue, 29 Aug 2023 19:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb733-0001kB-R1
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 18:18:57 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb731-00075R-NA
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 18:18:57 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c0bae4da38so2140175ad.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 15:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693347534; x=1693952334; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wWH9q1upOL/WvoMKIn308UaByAv09DM4ynYufYwKHRw=;
 b=eSh+RNErc+gxHZFETTmwfL3DhAcHMX7/aZwGtzR1MJ6kXPadqPDGhWaEetdAcGykM2
 FE6ZUb8WYf5P7jt8ylJc/KsqP0Hxp6nk4lw444BkB5fto3InpoBQpqZlEpCHNh/CyoDE
 tSP71HWBl/aHMoLgVLdFkL+X5cVFmLE1ZjeER+KVUnyjHE2oM81A+C+Jvrrv5mCWkHAV
 Lem1PoE/ygYwteg3UmOHdL26yNDZfeS19stWPxnnxgoUu72D3B4vGd+cHAIUbsFFg3fS
 TYzyy3qyLjWoGXayUwTOily0FKIuVOiLInNXn4uNSHi1uJ3Hd1hL6KdFFodmcuDkg1FP
 RCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693347534; x=1693952334;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wWH9q1upOL/WvoMKIn308UaByAv09DM4ynYufYwKHRw=;
 b=JJBxSFHeXqFmGqoCbilhKDm/o+6DPDPwyJlLXP2gpAiA+W2eYjnp4G18eDcBVhKMrR
 UTWpq3cvGDpujiOcfnVGiM5OkhLIHIAKFET98eLX0J/QNC5D/GdHC9LJc3D+PLLSg4en
 /cwf228EGbN6ij9AZsKcwf/8V5sUQRq1Xhl0XGjLWpwHxGg6osCDEETOPyia9eemOB3F
 g5IttvGMX/iEcX3IBzyZDfetvR60QnLCrDIUW62QbH+QT3NL4yEzZH/ez65apibfAotv
 SickwzYQV7ik3FbawlIm66bFxIRcXZY8KwC+xmt9Mk17ZKEbEw91iYy0OBujhKfdKA9x
 b54g==
X-Gm-Message-State: AOJu0YwuOpY4IKLnYS4DIWBdpjwMPL1WZyQ31MOtVmjc0XmN3aorWCNz
 L1N1f1sZJOmZN38l7j8LlQjhcA==
X-Google-Smtp-Source: AGHT+IFFNm3F9f8Pc/mATfW8Fp6IFz4lpN51MtqDf7PKyhdDDxDvVUU/4PIP1CNBU+EFdQkBvmN3iw==
X-Received: by 2002:a17:902:e5d1:b0:1c1:d730:f0cf with SMTP id
 u17-20020a170902e5d100b001c1d730f0cfmr776440plf.20.1693347534124; 
 Tue, 29 Aug 2023 15:18:54 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 c5-20020a170902d90500b001b9df8f14d7sm9764246plz.267.2023.08.29.15.18.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 15:18:53 -0700 (PDT)
Message-ID: <eb31a6e3-e709-21c6-a669-573eaf1a939c@linaro.org>
Date: Tue, 29 Aug 2023 15:18:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 10/12] gdbstub: refactor get_feature_xml
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20230829161528.2707696-1-alex.bennee@linaro.org>
 <20230829161528.2707696-11-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230829161528.2707696-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/29/23 09:15, Alex Bennée wrote:
> Try to bring up the code to more modern standards by:
> 
>    - use dynamic GString built xml over a fixed buffer
>    - use autofree to save on explicit g_free() calls
>    - don't hand hack strstr to find the delimiter
>    - fix up style of xml_builtin and invert loop
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> 
> ---
> v3
>    - also clean-up xml_builtin loop
>    - use strchr and defere copy for only xml case
> v2
>    - avoid needless g_strndup for copy of annex
> ---
>   gdbstub/internals.h |  2 +-
>   gdbstub/gdbstub.c   | 81 +++++++++++++++++++++++----------------------
>   2 files changed, 43 insertions(+), 40 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

