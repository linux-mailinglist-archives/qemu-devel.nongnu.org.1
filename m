Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 685EB78CA41
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 19:08:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb2Cp-0002fO-Q6; Tue, 29 Aug 2023 13:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb2Ba-0001in-KR
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:07:28 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb2BT-0006TR-Sf
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:07:25 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bf55a81eeaso24306645ad.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 10:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693328834; x=1693933634;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HmKCeqvz50rZ/lp++bD9aEMD8tLeJlZdf7uYJMpTlc0=;
 b=gkWASnZ4939tsEN6L7fgC9n2XjcAkgSgLh1k+Pj/zVxQgqaV9IR5AUEOqyOv7ZQUT8
 DYD8U5qPsTmGsphS/ZiYpLGHXxA6RlpFEvb9RbhwwsPpuXxyihEn9yuMEbIIaR7X4XWW
 qtSQ4Afui3Tjz3g4Lo1Hq6v1+tXRCoOVzDgBHuAoIE4BXW7UHMRltL0erOptmPls8mnG
 Z90Ftk/H/4dc96pouc5iTXgio7WBoK9dUHCIOApJ+Qbsi6287HB4JVCS/7eVRdRVcxCr
 nue5NmgniU+eHAIJ+AqJb7yysmUDcg7sicpEPBYCM1xbRaeJTrpdMBUVKYdalcMFaTQi
 nbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693328834; x=1693933634;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HmKCeqvz50rZ/lp++bD9aEMD8tLeJlZdf7uYJMpTlc0=;
 b=cGik8x6L6CVLBMS7jyMOaa2xTsiT+G9qMfgWtl4G7+4AHpi2E41u7LCZlzxhmD6cai
 kt2m0k7utp6d/IwyLYDuAahhQDSevpy4r4gCs1FYInaM9W2ADd6f86tAUURPeRDeyoMT
 +b3iNe/SjqbiN6UjrE9JSiQPSTYu70CZJ9kerZPJriXFvJxaznzfs1uEIVd91RMRflBY
 5oFraTvL+iqMQ43kMoKORZ9qE16qS7bj0g/5Eu//ruAIQ7WBQOnQkwKsHn3NZb3jBazJ
 PfGEBVs7jAKaxqtvBoc6nFueCeLAtBKmYQ7JdV8/OhAZGsch2DhQqOVLZKfox8WYIFKv
 Rwug==
X-Gm-Message-State: AOJu0YzMM1roCMuynUq6vq1swYeGVOdC2FFqS4J460J4RgO/I/iZYsnv
 pdc4alBDHdLsjVrN4UiMjK4ANQ==
X-Google-Smtp-Source: AGHT+IHkoggaHObeQ2GBZLrQB4RRyjod44mImo3b4j9x0c1oc8v6ORRKuqAXbdQaxokBZ68u3duJjA==
X-Received: by 2002:a17:902:e546:b0:1bf:20dd:786b with SMTP id
 n6-20020a170902e54600b001bf20dd786bmr27985925plf.31.1693328833828; 
 Tue, 29 Aug 2023 10:07:13 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 a20-20020a170902ee9400b001bc676df6a9sm9600999pld.132.2023.08.29.10.07.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 10:07:13 -0700 (PDT)
Message-ID: <67e9f678-a27a-45ec-c660-2eacf1a29fd8@linaro.org>
Date: Tue, 29 Aug 2023 10:07:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 10/11] qemu/processor: Remove unused 'qemu/atomic.h'
 header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org
References: <20230828221314.18435-1-philmd@linaro.org>
 <20230828221314.18435-11-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230828221314.18435-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

On 8/28/23 15:13, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/qemu/processor.h | 2 --
>   1 file changed, 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

