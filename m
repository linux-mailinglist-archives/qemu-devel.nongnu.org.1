Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5638768271
	for <lists+qemu-devel@lfdr.de>; Sun, 30 Jul 2023 00:08:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPrKJ-0002hX-5z; Sat, 29 Jul 2023 17:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPrKF-0002gg-Fe
 for qemu-devel@nongnu.org; Sat, 29 Jul 2023 17:18:11 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPrKD-0001fe-Uk
 for qemu-devel@nongnu.org; Sat, 29 Jul 2023 17:18:11 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bbc06f830aso20711575ad.0
 for <qemu-devel@nongnu.org>; Sat, 29 Jul 2023 14:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690665488; x=1691270288;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2M9+soq9/vyWJ3xsv/OorLOQth0Z/WnuaAE3XOzrz1o=;
 b=zhk152XSUw4Q1SzJeuEnYiHJH4rEIbqvIja28vH/qGbWma9Zv5onhKtpiYTFuFu1si
 t1KHvNbDZshi2enzo2TXFf27pc5hnxOkrlS39CG+pJd1Q/mzLK2uP1xnsHGjjUzilZYD
 AuAs4I+TXACiWk1Kdgvv3bXbfcQvFKwNu3gKmuQafqDnYD+Y8e09HhAiN8OGomw8CoOC
 WS6/jKdrTo6efjVa2wv3wKW0MvS+t3Xu0QIltA5QdCYrmm92R4gGYN9nia1DO9HrX0Sf
 7CzY1fyDyi4k+1fDHRMkYaaf08VzcXKGb6aTXSQgNfWD3l2zOUtSpl/EPizFW6Ba0/2e
 YpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690665488; x=1691270288;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2M9+soq9/vyWJ3xsv/OorLOQth0Z/WnuaAE3XOzrz1o=;
 b=BvzHRWAul0l7mbIl2bQRUibZo8ousxjIQQRENYWtEOYN2duIv4c2iGjr5GO+Moa6Yk
 9m0e9Q7RClKwenHshYC3/RtNAtfzFYhOWrsFx2yOS37XEdR3B+70pGRsVhLDYinBkKLD
 FZUZJqd/0LSqKOKZfLmfDXBH9y09MkK9Ags9pqrohWaJIAadSetcqkORhYT58zjdqlCm
 YvFrX7jR3tUUVAtDfpYzdU5dxD3xN4pOUyV+vZit7KvB2D75wv6xlj5vEU1wVGhk4/71
 bbmttm6Rh5SW8C3/iGnRASmaTGKoF04nHF56A1/hTFYDKgnbFVbfXkuCRTucO+rWnhYg
 H8fw==
X-Gm-Message-State: ABy/qLZ8QL5qRuaZasXBRewGETgoTPhex3UvD8QPoc0BoT057mjHyaOV
 9rSSLL2DaZZRiaomUMVPtXivrw==
X-Google-Smtp-Source: APBJJlEJZD391X/wPvWnYlt4/6rKozvSbeuSUvNlZhtH88zrYnt78jLaN9siHAGTGtDEz63yWheIVA==
X-Received: by 2002:a17:902:ba96:b0:1b8:c6f8:d9b with SMTP id
 k22-20020a170902ba9600b001b8c6f80d9bmr6114607pls.34.1690665487598; 
 Sat, 29 Jul 2023 14:18:07 -0700 (PDT)
Received: from ?IPV6:2602:ae:154e:c001:3ba7:1297:fffe:e7cb?
 ([2602:ae:154e:c001:3ba7:1297:fffe:e7cb])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a170902c3c300b001bb40b880efsm4681915plj.101.2023.07.29.14.18.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Jul 2023 14:18:07 -0700 (PDT)
Message-ID: <4c8751cf-7e27-a5dc-e7e1-2074c2d5f09d@linaro.org>
Date: Sat, 29 Jul 2023 14:18:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] target/riscv: Fix page_check_range use in fault-only-first
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com, palmer@dabbelt.com, bin.meng@windriver.com,
 liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com, qemu-riscv@nongnu.org
References: <20230729031618.821-1-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230729031618.821-1-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 7/28/23 20:16, LIU Zhiwei wrote:
> Commit bef6f008b98(accel/tcg: Return bool from page_check_range) converts
> integer return value to bool type. However, it wrongly converted the use
> of the API in riscv fault-only-first, where page_check_range < = 0, should
> be converted to !page_check_range.
> 
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
>   target/riscv/vector_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

As far as it goes,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

though the test will never fail, because tlb_vaddr_to_host just succeeded.


r~

