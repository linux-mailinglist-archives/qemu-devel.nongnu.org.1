Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 276187D4332
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 01:28:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv4Jn-0007EB-Un; Mon, 23 Oct 2023 19:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qv4Ji-0007DI-Vd
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 19:26:38 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qv4Jh-0007oP-FQ
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 19:26:38 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c9d407bb15so32380335ad.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 16:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698103595; x=1698708395; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SHD2uqvsnkkfFGMjWismOkHOlDnmLMHJCfKcUfbTomY=;
 b=Xvw7SE5zZSiRISY9TSYgNf7ZugXFP7DoOsdBg6S+3qdBMvK1SW/rBxymlo0+HZMade
 9uQcMcXUhFjb9H7ctj6mD3zJt/a0MJMWVkbKKiWkYVc9GuKKvizoLLxAqwCnK4XIQraD
 IsLqYsGEFpTHlup4HKl6fGjudpxFBk9MVmS0RoP3KtqwILolJvqshw+pLtqIWGGIalj/
 h4TkjdMWhinIPxHK/JRHEzDDopAxV8wXTuFr3jQeA4oBu8DVZzdT6yYQNGMAUwuUXuMq
 CvDV4pDCA6P7l4mEDhrivSs5d9+3pRjERfOfjXujPDcaum6ytmgbSRzQn/oiWqrA4p7B
 kzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698103595; x=1698708395;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SHD2uqvsnkkfFGMjWismOkHOlDnmLMHJCfKcUfbTomY=;
 b=u19l0o6q9rM+l4Oyh7vHUntvU9rcypu8mLOXBVVtMC2Top7HON0Q/b+2U8EN7X51Tc
 oc8eup/8iSU0CSWBXjhCJQ++0JYe3MGG/HBHYnVjOQLJMDF+B//bI9Hoa1UBL64qbODe
 wYZvjFKCVs/U6o5j6h6cVEQCoVYAxTQrJgQJy1nD2M88ZoHdqm2QqUtSR9NmAoHsyMl0
 FGUZYxDxrpRDht47J+pf/JXxZF4zQn7s/TbW24Hzgcam6w9KO7o8bJhO2xgY81b8YCJ7
 t8JQVgfGIlRuyA6ZZklL3Ezj9o+5PsiUHxIHgiA/Q4K/X60a8QnQNR7DVMAMUncb1z+J
 4zBg==
X-Gm-Message-State: AOJu0YzLong0NBtSSfUMS0ginOiz42qhnmbreD59Txc32YUBD/JzVkqC
 Cy+8yYF/04FpWeHf7Dtj9emhTw==
X-Google-Smtp-Source: AGHT+IHkqkHAm8QhRPa85vHPGt+0WAtjSb+/08o3J0yv2tYqUi3tusy0ibK5KBaaSMKEMW577KDbhg==
X-Received: by 2002:a17:903:27d0:b0:1c9:ccb3:2352 with SMTP id
 km16-20020a17090327d000b001c9ccb32352mr10236877plb.12.1698103595465; 
 Mon, 23 Oct 2023 16:26:35 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 o2-20020a170902d4c200b001c9d011581dsm6401451plg.164.2023.10.23.16.26.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 16:26:35 -0700 (PDT)
Message-ID: <bce33bc2-60f9-41ee-856c-d76682c185f0@linaro.org>
Date: Mon, 23 Oct 2023 16:26:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Add LoongArch v1.1 instructions
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, git@xen0n.name
References: <20231023153029.269211-2-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231023153029.269211-2-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 10/23/23 08:29, Jiajie Chen wrote:
> This patch series implements the new instructions except sc.q, because I do not know how 
> to match a pair of ll.d to sc.q.

There are a couple of examples within the tree.

See target/arm/tcg/translate-a64.c, gen_store_exclusive, TCGv_i128 block.
See target/ppc/translate.c, gen_stqcx_.


r~

