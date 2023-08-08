Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D7B774533
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 20:38:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTRae-0007Am-Fy; Tue, 08 Aug 2023 14:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTRad-0007Aa-Bp
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 14:37:55 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTRaa-0002Gh-M9
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 14:37:54 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6873a30d02eso4086041b3a.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 11:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691519871; x=1692124671;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cFElJw7x5UXj1jzVWtxUHckke+EAcGtODtpKZjC2jmQ=;
 b=yR45leVX7moe646RqlUCfwFxisLK4px+cVKFcm3C4Y7F4Hc2e+Z27LI2jc4AKBCj5S
 fOyuCKO2xNHNazRgyeLIRWVztwu2J5CyqpBpOrU47XcaVdljFEF08rdMznUaCNf3tx5Z
 8o9rnphY8xMpqS6dawoFYxzv/WonwgZ0MpbBPrw2T/4N8mUEf9OYF019UjwbPEJEBHzL
 MktIOzjjBZq+uvRcgUfHXwl7AgTlXxnhNrxt2RsKj9MM+PDyPS060IOHFUtMRQBqZTbC
 yGaZbuIYp/LFNDFISVwIwHlHGIRVgYJ0gOO8r59m2e2P3OvYBL/gAdmmRCVc9l35/0fE
 QJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691519871; x=1692124671;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cFElJw7x5UXj1jzVWtxUHckke+EAcGtODtpKZjC2jmQ=;
 b=QTJRy0c1fmXf1JkXfrGNKk7IcsJtA020kboEIIjF4WE4Eowf5VHCzVfV7wDE9zBy0U
 UQFcAFJRNho6VIMRhvr0kGfVlw98gNCoj+U6Jh5Li6jm5svKlHkkAAj0oQhNGtvdZIFq
 9dTS1iXYLOPRTaO4eLBApw8M3A502nhsmEaDAmDJ7mZkKdfdobxZeF3Zpyf86dQinnB1
 QaySkVUvVn/rRTagByGL+jsOPeHIUvNMvH/ro0DuisZVYGnwHE8LeEIAzBIYx4QLXhDe
 PLIGXgvBcuPaqWpViHAAk8UFnqPHsjAeKDmNs6uxBuN8XQheUxoIVUu0gVv56e3ZmOX6
 p+/w==
X-Gm-Message-State: AOJu0Yyj37MjExKjvXYZPJsKCUZYMv0wrQje95Q3HQaG0TtRUMgmGUuV
 C8wDFkKtwuWvReTTPIqAQjn8GQ==
X-Google-Smtp-Source: AGHT+IFx3BpGxv7vAlddSnn/Zorv4Oi00ZoJQoUFn+yginsK7tdpeBOTCqGlDndBA+0HqYoJUwZlHA==
X-Received: by 2002:a05:6a00:1682:b0:66d:263f:d923 with SMTP id
 k2-20020a056a00168200b0066d263fd923mr407020pfc.20.1691519871384; 
 Tue, 08 Aug 2023 11:37:51 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 a19-20020a62e213000000b006875be4163csm8704735pfi.17.2023.08.08.11.37.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 11:37:50 -0700 (PDT)
Message-ID: <38257fb2-cd1b-bf8a-f263-b7aa24d36704@linaro.org>
Date: Tue, 8 Aug 2023 11:37:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 05/11] target/loongarch: Support LoongArch32 DMW
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: yijun@loongson.cn, shenjinyang@loongson.cn, gaosong@loongson.cn,
 i.qemu@xen0n.name
References: <20230808015506.1705140-1-c@jia.je>
 <20230808015506.1705140-6-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808015506.1705140-6-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/7/23 18:54, Jiajie Chen wrote:
> LA32 uses a different encoding for CSR.DMW and a new direct mapping
> mechanism.
> 
> Signed-off-by: Jiajie Chen<c@jia.je>
> ---
>   target/loongarch/cpu-csr.h    |  7 +++----
>   target/loongarch/tlb_helper.c | 26 +++++++++++++++++++++++---
>   2 files changed, 26 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

