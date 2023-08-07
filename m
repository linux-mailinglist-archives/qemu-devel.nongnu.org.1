Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1204772981
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 17:41:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT2MS-0000UX-2O; Mon, 07 Aug 2023 11:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT2MQ-0000UC-LC
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:41:34 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT2MP-0007JB-2Y
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:41:34 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-686efb9ee3cso4482934b3a.3
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 08:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691422892; x=1692027692;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u8TyEUm+l5dTKQ9a+BX9bsAibNdKkRSKeL5q6ugjpdw=;
 b=haW0zUnq6RE6eAjqPNy/0fRlzCqYssXB2Jgo6sACSbITAXMCcu6rHT7XNyHqtosYe8
 1edjH18xuWSC7nWcMaTr3sfUhQNx9Hj1OfJPQfiMtsgnOJsqgtfKbMHdY0wUqDGhfYni
 T/9RMyrQq6B7Cz/Hg5AM8VyP2RYejceATVqrf6qLFSqWURAoAA4hMZot+fSnzDZoEl5m
 EDLKuxJ+wZ7X9LGiY4JbJASVQsDiZCR/xfI36Qx9+KHZwArDVbjVTzsxMQfAQLdpTNuS
 DJp+xHcx1t1zUAVoXqKH69/VlVc+qFhtZzDwMlTFBqU1ZHgUnpgCiy1a3EdMpMwaRwmv
 DlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691422892; x=1692027692;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u8TyEUm+l5dTKQ9a+BX9bsAibNdKkRSKeL5q6ugjpdw=;
 b=AB9Wlmk/3SiJJ3QwSKa6zVMPE3d/Y80ErH5UKsWgKIpB3810V0XiRo7+5VEcnPaQaW
 mU8gxhUrNATjPaTUPbFzdeO09WoBdPOo1YGpY9DlgGLAaG6sJYznh7GkYvsn856iGctl
 tP59MqO7Yleb1pA9SAVUDgywPOA6bZRMemEed9g3HJ+RsJqUh22Cl9L1l6Y16DVTFx4E
 woH2AgIHoZH/eUmgvZVXHEiEVbeZGXjJzkGZ8GlIBmTK7Jh+fqdn4h0IXRonQmyuOdZD
 fNmLco17iFVAQCliey+JgoOAaCiltClUq/chB6PikqkdzTnByxpzfT1i69ce0K9jXM9K
 P7cA==
X-Gm-Message-State: AOJu0YxwcDeO4IGQcEutbgUrqw0tcDbaS3Y3bpuCh96FWA73WBya7cMh
 i6enzHa2otN1tFLeQZcFgW1u/Q==
X-Google-Smtp-Source: AGHT+IEz5tf/xci+oMJ6ZhHlOuKTUvAS6bKtP3SmC4juwahaf+E3WfUNaP1WRoIswd/EjD7aFk0Xmg==
X-Received: by 2002:a17:902:a601:b0:1b8:4e00:96b with SMTP id
 u1-20020a170902a60100b001b84e00096bmr9058673plq.9.1691422891790; 
 Mon, 07 Aug 2023 08:41:31 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:e306:567a:e0a1:341?
 ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 b4-20020a170902b60400b001a95f632340sm7065888pls.46.2023.08.07.08.41.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Aug 2023 08:41:31 -0700 (PDT)
Message-ID: <43d6485b-919e-c0ba-a1ca-d620f9e11598@linaro.org>
Date: Mon, 7 Aug 2023 08:41:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 4/6] target/loongarch: Support LoongArch32 TLB entry
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: yijun@loongson.cn, shenjinyang@loongson.cn, Song Gao
 <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>
References: <20230807094505.2030603-1-c@jia.je>
 <20230807094505.2030603-5-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230807094505.2030603-5-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.809,
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

On 8/7/23 02:45, Jiajie Chen wrote:
> The TLB entry of LA32 lacks NR, NX and RPLV and they are hardwired to
> zero in LoongArch32.
> 
> Signed-off-by: Jiajie Chen<c@jia.je>
> ---
>   target/loongarch/cpu-csr.h    |  9 +++++----
>   target/loongarch/tlb_helper.c | 17 ++++++++++++-----
>   2 files changed, 17 insertions(+), 9 deletions(-)

With the test for LA64 vs LA32 corrected,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

