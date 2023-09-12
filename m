Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 825F579D9A3
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 21:35:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg99V-0000Al-Ua; Tue, 12 Sep 2023 15:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qg99N-000084-SG
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 15:34:18 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qg99H-0006ut-MM
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 15:34:14 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-68fba57030fso2481444b3a.3
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 12:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694547249; x=1695152049; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nLqpuzkZtfbXyOnfPv+n76jEi24Gc3McEHGkWuwy3Nw=;
 b=DUXWhnSZEBJRDme8+TAxeSgH5kXaxqql3zKOSJVBZy68WS2GSN52ODwjUyo+zj1H7f
 7KP/72VskvQqRno/TbtFjgopBUcpzTp+Bbq/MYhMOORZqqgaN5dvlOnNOovplUbwCyOp
 TrexlVhvkUtp4jM3D5NFhdfTiDf7yCRVUbRY1CvH5fvquMo1ua0K8sIzd6NT3ABfeKcY
 wHfTB7pq2iq6gfnGG53qmp678gnUT2KOtb8ja8iOFktgSjrHEQvQbZs53h/tPuBhYm2J
 5fK+OUFjs5ZyqgA0oKBVu+vo38kiv9miGYE593SLzoJDC0vPVEvekdXbhdaWwjCiCTuy
 XfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694547249; x=1695152049;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nLqpuzkZtfbXyOnfPv+n76jEi24Gc3McEHGkWuwy3Nw=;
 b=XPpX2vitWK4eyCEeHCbNiBe/sAVCvfkE6z6fkTVdQb9knWZKpbgozoaB/TUhDyVQ1E
 wD3Uc2ePuLdid2GRnTaE6QKz1Yhuf8IwoAv/C+60Lfbn+tZn+TuDURLT1QPydD/zkgen
 h+tMnk0PQgI9ysX5o2gyQNSl9kD5lodcVvkNxHtoNsVjMux4NNZ73QW/aM1wZGxKbC+0
 ev6z1GWNsoYe1wuf43KHvetk45LacHryVNuqp26Ayl71Pg+7Y70jS23fDD1vCO5+W0om
 xyiZ+y/834gF6823nReRDreuDb11QN+xlKImAWlYegEz2r/iB2cVTBWHM+3NCk35y7Bl
 Ys+A==
X-Gm-Message-State: AOJu0YwWVYJz4ntwX6Bqj1gYYvizOv5RFAHWBMBeahp0eA3j9HsR2YYj
 F1PEwSYwZy0aq6OafeLwVxVirw==
X-Google-Smtp-Source: AGHT+IEYRf7FFF0C6CbbKUFptVo3mrD2Fu6wRcb5GAVDrA9wQAar2hpifirWaF6z0ZKuontBr/r+jQ==
X-Received: by 2002:a05:6a20:54a2:b0:153:6413:1089 with SMTP id
 i34-20020a056a2054a200b0015364131089mr399652pzk.46.1694547249178; 
 Tue, 12 Sep 2023 12:34:09 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a056a0026c400b0068fb8e18971sm4755558pfw.130.2023.09.12.12.34.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 12:34:08 -0700 (PDT)
Message-ID: <ef6f5d06-4dfc-e114-3f1b-52ccc125c34e@linaro.org>
Date: Tue, 12 Sep 2023 12:34:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 05/11] accel/tcg: Modifies memory access functions to use
 CPUState
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, pbonzini@redhat.com, philmd@linaro.org,
 peter.maydell@linaro.org
References: <20230912153428.17816-1-anjo@rev.ng>
 <20230912153428.17816-6-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230912153428.17816-6-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 9/12/23 08:34, Anton Johansson wrote:
> do_[ld|st]*() and mmu_lookup*() are changed to use CPUState over
> CPUArchState, moving the target-dependence to the target-facing facing
> cpu_[ld|st] functions.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   accel/tcg/cputlb.c | 324 ++++++++++++++++++++++-----------------------
>   1 file changed, 161 insertions(+), 163 deletions(-)

So... what's your ultimate plan here?

At the moment through patches 5-11, all you do is take CPUArchState, discard knowledge of 
it via CPUState, and then recover knowledge of it via cpu->tlb_ptr.

I agree that *something* has to happen in order to allow these entry points to be used by 
multiple cpu types simultaneously, but there must be a plan.

Is it to have tcg generated code perform env_cpu() inline before the call?  That's just 
pointer arithmetic, so it's certainly an easy option.


r~

