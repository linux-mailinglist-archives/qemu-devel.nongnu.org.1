Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 554A37DA99B
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 23:21:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwqjZ-0004Ov-Do; Sat, 28 Oct 2023 17:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwqjX-0004ON-7n
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 17:20:39 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwqjU-0003qG-UD
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 17:20:39 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5b92b852390so2406038a12.2
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 14:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698528034; x=1699132834; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Dw+U3azjwpvU+lHybeqTTNjt4Fj98xGaQ08E2eRoTtQ=;
 b=eb90EiIxfq4EYddDyabotZ/tZ73stx1U7eLc1UyeP8XaVFklrlb+AHOCLpRC/dkNHI
 er18yCRp7q6GqQmMLTV2FwxNXnyZs8rUsRPBnOPa4obtoE5QP0sLLpWqO2eyCQDR+KO8
 KIiJQA94c98y3utdm2fPdIlPNuzvcY6xFpFyOKVRsNVCFbkmk5RFI6L06s4chniPtczH
 B1MgI3Oz7d4FGahIqt3GOiZRRHoRrgI/ytOKSpKcO2BtdCcx2+DIAiohDKX6Dc7VNsI3
 IF++HwsnSPRF77kAKWL4ak+6Zf/B0W3JfdNiP0nmX2wUMVekgyFu7cIkUACcy18ZWwez
 lsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698528034; x=1699132834;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dw+U3azjwpvU+lHybeqTTNjt4Fj98xGaQ08E2eRoTtQ=;
 b=xKGnwxKdbes714TutRroPl5s8eYX7/X6R/HERsY4O8DUHoW4275FmTtENYqdhSuYJl
 nAPYLB7N7MWkI7SsqKulP/BdGPrMZuhepbaX94oRk9n08vVt+lQ86niTU4bi15dG3ppr
 Ks4N72w/eEc0q9zK2DkMxhhcWH+rK5jOSDhDC6GupnWG2FogAk2YNvCoogjN+sEU2eET
 N/U0dlmZJ4Bxb+WFHY1CbYw9x8YXNRliU0Y4j4Eur/vA3XRDnylPXfwkqItMaaWP4/2x
 RAGkHfAXUictLQXA8tH7LdJOCB9AhDU6OckFSiXRpOaM0nJ7WBruGZGovXkQYys8scKW
 c+Ug==
X-Gm-Message-State: AOJu0YwebhxBFcfwaOU0PpFN49jbyS2iwN6Lw/UT+ck6Pmg2wa5tYdSt
 U/FZ/bP6MVGbCpEhzxD3n48djLytB5mlovwa/tI=
X-Google-Smtp-Source: AGHT+IEVfFszb57izXAUzyANVn1EdfUsKkzZr5OM/DmvWReTA6/pjJnMmKfHcrM4K+251hVBBuqhWQ==
X-Received: by 2002:a05:6a20:2589:b0:16b:c20d:f979 with SMTP id
 k9-20020a056a20258900b0016bc20df979mr8251016pzd.13.1698528034629; 
 Sat, 28 Oct 2023 14:20:34 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 j8-20020aa783c8000000b006bfb91ac2afsm3456985pfn.140.2023.10.28.14.20.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 14:20:34 -0700 (PDT)
Message-ID: <e6366a41-8d5a-464e-bc83-98f489786f5d@linaro.org>
Date: Sat, 28 Oct 2023 14:20:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/6] linux-user/loongarch64: setup_sigframe() set 'end'
 context size 0
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: philmd@redhat.com, laurent@vivier.e, maobibo@loongson.cn,
 yangxiaojuan@loongson.cn, laurent@vivier.eu
References: <20231010033701.385725-1-gaosong@loongson.cn>
 <20231010033701.385725-5-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231010033701.385725-5-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

On 10/9/23 20:36, Song Gao wrote:
> See:
>    https://github.com/torvalds/linux/blob/master/arch/loongarch/kernel/signal.c
> 
> The kernel setup_sigcontext() set end context size 0.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   linux-user/loongarch64/signal.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

