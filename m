Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1841278B636
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 19:19:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qafsb-0001rs-II; Mon, 28 Aug 2023 13:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qafsZ-0001qb-MY
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:18:19 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qafsX-0006U7-GY
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:18:19 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-68a56401b9aso2470214b3a.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 10:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693243096; x=1693847896;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OSJzbTkoM1OtA7cXRPjsiHLaN9T2V8kpqdz15N3UHIo=;
 b=qZRmkOrUMNHC1brHYB+4DFUM+I4MwcPrd/K4myHcgAdCFoB6nNcAA+00dnCkedwVLH
 mh+Lm+DhJMSH5eVbo+HnCVFRZv9l647odqUBPz8gDsTyY9N6UiwkcvD86uP+b2Q1mJLy
 U9kbt/HaCcvv0kfe48dp3wxUYMNHwosg2fPgBDCJor1Bqj4YH/k5qAOXyWG6cROiNHCF
 Ngo/x7SY3uLw6IUSPGvJaFlegZf8XAMSEr9jWeanUqghgS6cDJui4g6tWgh1+HsQwkIX
 1mkobDbKX01czArgPaPyXV7QxEcHQ5lywEDO6U9q/LY2nrbP+ORNDpXo5gdNJmdkOsfY
 p16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693243096; x=1693847896;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OSJzbTkoM1OtA7cXRPjsiHLaN9T2V8kpqdz15N3UHIo=;
 b=NQzk5y46EVRGK0wjZ5lS54Qj6IEumQfuqL9ZKTAtxYYl4LbcVBM5SPuRgrqW5EJH30
 7xtJdWd3dXwVlOEXZa1L0J7NmIbg5AIfd65crT5DA4uP8X9hPaETgPShMyQs/92NYg2P
 xt5d3dTH/qrtO0lp2LzaxDwWLKLJSGGMLRUu8BBPeVXzngjN5tHn7FuYv+RDbODEZiEa
 gsHpKHP3E05ZocxCq4ga8UChk66FnhLqEHj7j5HN8eTYbA2LGW6lZFA7pqDTRefR7NU8
 oVQTJBA1bQ1M9DXyeU/5XdX0MdRTKTSxfKap95OAc/ceyUvsXQDMsAcG6riMmFe40yEl
 6trg==
X-Gm-Message-State: AOJu0YwGC1+Uu7td8ot218IlxpXYbFbYRx1z8hJ/nWS9IsIc9JFgoG4L
 8ni2te375W2aJ2EDtCA7WTt1lnaiOdBVaBz0Lwc=
X-Google-Smtp-Source: AGHT+IHAMmkg3Ui0fAyWoJmcigIMHScA+CYV79KHLlmhn2zxMjuNvaibwGER2hCcRsy87l51H7K9rg==
X-Received: by 2002:a05:6a20:6d9d:b0:13d:ac08:6b79 with SMTP id
 gl29-20020a056a206d9d00b0013dac086b79mr17024936pzb.60.1693243095907; 
 Mon, 28 Aug 2023 10:18:15 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 f21-20020a170902e99500b001bdeb6bdfbasm7668330plb.241.2023.08.28.10.18.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 10:18:15 -0700 (PDT)
Message-ID: <9f72cfab-9f26-d951-49b5-1bbb5cf82d15@linaro.org>
Date: Mon, 28 Aug 2023 10:18:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 06/11] tcg/loongarch64: Lower neg_vec to vneg
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, WANG Xuerui <git@xen0n.name>
References: <20230828152009.352048-1-c@jia.je>
 <20230828152009.352048-7-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230828152009.352048-7-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.169,
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

On 8/28/23 08:19, Jiajie Chen wrote:
> Signed-off-by: Jiajie Chen<c@jia.je>
> ---
>   tcg/loongarch64/tcg-target-con-set.h |  1 +
>   tcg/loongarch64/tcg-target.c.inc     | 10 ++++++++++
>   tcg/loongarch64/tcg-target.h         |  2 +-
>   3 files changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

