Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4951272AC69
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 16:59:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q802U-0002ee-NF; Sat, 10 Jun 2023 10:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q802T-0002eO-Dl
 for qemu-devel@nongnu.org; Sat, 10 Jun 2023 10:58:01 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q802R-0003fq-VW
 for qemu-devel@nongnu.org; Sat, 10 Jun 2023 10:58:01 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-65131e85be4so2978309b3a.1
 for <qemu-devel@nongnu.org>; Sat, 10 Jun 2023 07:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686409078; x=1689001078;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oBQf8nXGr3S+qtVxEa2DAokslRw1PRUdmsnZXYHAc9Y=;
 b=D18LC5DR0CUwGnjcZ0cIq2oIacGkypP92QGYzfZA67HYiAhaK551vzmP0c4NQMTVN3
 8Dx3nEFfId2xQ/9JT6uMXxNRevjvx191jH0wbNFkP0KYRv7yyjmsqDYL+LDgm7P49eDJ
 JWC/JV+qRDgsCNTWmnSuDE6vO3WDKeOl2HFRPjc65Uhbd3mw5IZnLCRmfMEBQX8xIgo/
 5zBQatPWA/lJ2WTEaq6qGdmy6UM8Gm11Xw0V4NPtw61EqTXnn3RIqbCw0MbjbShJpI2F
 7iN8qYixUZNfxALhW/dnvwxh6S41VHvJ2rgNf1nw54XV7LzCt/wBkjhbz6MHiBQS/HkJ
 Q9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686409078; x=1689001078;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oBQf8nXGr3S+qtVxEa2DAokslRw1PRUdmsnZXYHAc9Y=;
 b=Cvo7TRprvmjL45oNmRq2b6BCNiIbThEzjdYstC5Asuo01uCAC4D2a40cFWoWP47UHH
 TwpMcIxoefEThN2hyglgHdi3fqns1bMS+Nl9C5ZPq6AYrM63PrOfaz5O/k0BHyQ0Rv62
 wcQLWhmsn6uGNNBMZy5u4wr5/jI+9FKKLi2sw92S1UdfsFH4CMSS2sybGumVtg+GYMcl
 CYqnqWvDH/DYK3Z0rF9+RZLWgRuAdReWYCq+UO1g8RwylySopzUHPDHCtVI+N/T71Mer
 ZqrnWJGK6JDRNBiUl//gQoh91vYsTR8fcEv4Wupc9QruahULt9MpR5R+XoL6IxwqH36B
 H8uw==
X-Gm-Message-State: AC+VfDxU9eKDSLqJx+3TtjCwoxwyrFZ9aGt/ZFU1g2CVqJkthDvhxeLo
 SdhJnF6jtczDV54c3iOQuPNK8A==
X-Google-Smtp-Source: ACHHUZ5irs//mzore5lX5u3XBQeMjOu8eDesN1EabH8BzwZ7U8SNyf3fossgAZE4v0s/14Zi1IdtCA==
X-Received: by 2002:aa7:8890:0:b0:657:e9ae:e022 with SMTP id
 z16-20020aa78890000000b00657e9aee022mr6015257pfe.5.1686409078074; 
 Sat, 10 Jun 2023 07:57:58 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:2db6:3c02:bd87:f559?
 ([2602:ae:1598:4c01:2db6:3c02:bd87:f559])
 by smtp.gmail.com with ESMTPSA id
 z3-20020aa785c3000000b0064fe9862ec2sm4253075pfn.116.2023.06.10.07.57.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Jun 2023 07:57:57 -0700 (PDT)
Message-ID: <ae6c1e05-eac0-f0bc-05b5-f04737bf4445@linaro.org>
Date: Sat, 10 Jun 2023 07:57:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/6] target/tricore: Introduce ISA 1.6.2 feature
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
References: <20230610105547.159148-1-kbastian@mail.uni-paderborn.de>
 <20230610105547.159148-2-kbastian@mail.uni-paderborn.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230610105547.159148-2-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/10/23 03:55, Bastian Koppelmann wrote:
> we also introduce the tc37x CPU that implements that ISA version.
> 
> Signed-off-by: Bastian Koppelmann<kbastian@mail.uni-paderborn.de>
> ---
>   target/tricore/cpu.c | 13 +++++++++++++
>   target/tricore/cpu.h |  1 +
>   2 files changed, 14

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

