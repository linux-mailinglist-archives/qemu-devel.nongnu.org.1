Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A83BC78E406
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 02:36:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbVeq-0006yu-Gy; Wed, 30 Aug 2023 20:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbVeo-0006wc-99
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 20:35:34 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbVel-0004gX-2y
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 20:35:33 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1bdbf10333bso1908615ad.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 17:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693442128; x=1694046928; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+c9tflrgWVaHxbiS10KzdtY5HxjGiJ0IIeX5VkJQyD4=;
 b=KEW4AYDnPw6bETEGY8Jo080iOcim5DbgSd/8GQ8jRajKd6gn/JwgfaA0ntf0mMzeZS
 CKbR0a1ql1QE0fgv6KQObr5CcadGGvt3CSO+miawsgR9BPQ4oiG4dB+ePExSuanW0Szm
 MlqsKzbEVlFc0yKgIVvHSBk6UWnx5gYnQ1XfcB+bWpcrc1W14S9KSunsxjKH17r8B+Sn
 eABMFUVbkO4p+fIQyyq6BGonSORvoAYy8hFnk92f+itFSS4lpKYfoJre4bEVPaeaOXLQ
 u5C5SoZO2cipNtgVp2bbbmOpYIDjqlYpMB48PhUHYhQ8e6hiigFCIo5GdJr8JsGqYZTt
 12DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693442128; x=1694046928;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+c9tflrgWVaHxbiS10KzdtY5HxjGiJ0IIeX5VkJQyD4=;
 b=MCpwXABA8HzJ3Yb5dyXkE6ZTB98zwzQL27xqO6xv6AonZpZD2TskzGsJnKK7+yfDmy
 XQD33yAPRGOC9Vw+dPEOVusogS61v4YNfjNAUUCMlgKqAJmdMe6ZxuSBBuniPyEGX/Iq
 /2AQwUUEneGuXfxPzC95KJjIbDMVfN6yKTipit3xy3hQmfsGs1q5jjYrTISzWLr6ROSr
 mzM+TT/cc+5rEFdowXhNDAllp8QzqxvHJD9wmOIUTvo8/tQNOlcCkKifNC1qZeOkabjy
 t9oNIEDenzgv+svY9N62ZBkcBKA1d4YzAiX85f2OlWCWQ08GnwFZzSthi6MmD7Uqu4Pn
 4xGA==
X-Gm-Message-State: AOJu0YxtHN7Adka8VDoNOsw78t7Fak4CxsJiSrXrbZUMrqasjCwDD1un
 df+HjUGty2iXj+Khw5FhpXlRUWSxj5Vv/NwdUq4=
X-Google-Smtp-Source: AGHT+IHJUkYdD+dZnEPrCjkewya4S5u+R2fFUg13XFeOp9QnLn4e3kf2LT0Wrhu1d9ZRzk8PgyEmog==
X-Received: by 2002:a17:903:22cd:b0:1b8:954c:1f6 with SMTP id
 y13-20020a17090322cd00b001b8954c01f6mr4408931plg.36.1693442128436; 
 Wed, 30 Aug 2023 17:35:28 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 g15-20020a1709029f8f00b001bba3a4888bsm96829plq.102.2023.08.30.17.35.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 17:35:27 -0700 (PDT)
Message-ID: <c54e25fd-f50f-b187-6d9d-a842bc77e246@linaro.org>
Date: Wed, 30 Aug 2023 17:35:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 45/48] target/loongarch: Implement xvpack xvpick
 xvilv{l/h}
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230830084902.2113960-1-gaosong@loongson.cn>
 <20230830084902.2113960-46-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230830084902.2113960-46-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 8/30/23 01:48, Song Gao wrote:
> This patch includes:
> - XVPACK{EV/OD}.{B/H/W/D};
> - XVPICK{EV/OD}.{B/H/W/D};
> - XVILV{L/H}.{B/H/W/D}.
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/insns.decode                |  27 ++++
>   target/loongarch/disas.c                     |  27 ++++
>   target/loongarch/vec_helper.c                | 138 +++++++++++--------
>   target/loongarch/insn_trans/trans_lasx.c.inc |  27 ++++
>   4 files changed, 159 insertions(+), 60 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

