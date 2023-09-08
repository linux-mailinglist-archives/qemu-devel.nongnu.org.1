Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4A2799149
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 22:52:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeiRu-0004wu-Q0; Fri, 08 Sep 2023 16:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qeiRr-0004wF-9j
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 16:51:27 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qeiRl-0006Vz-Bf
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 16:51:25 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-68a3082c771so1785813b3a.0
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 13:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694206277; x=1694811077; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E3h1NzWZ+PlVyRsy8pJqbgheTOeQsn8cWPj3t42ko4E=;
 b=GwqRXyNevtKZCsu4UydPBuL69xcycUWD24sfnvhzPMYYX8TsW/ZByXep+vqccZWJbW
 yYKb1nybZCt4YThPURgPMYMgcIusJXxiXKN+GCwzE9zrl3sH61rDNfviht2W+MI+JIrS
 fRJYPNWzjtQQF88MJkJyZb4qQx0wsDR7c36JgEz6eogNH0f6rBYNW93A+s36RgQGpI6J
 q98enlno+gFLdpDXonTyiGrrVO74J9HdqxY/mDNX2aH10YgLbuQBtR1tozWOxE18gsAk
 tWmk0fOiqjHiyuAhuk/IuGCm78PsVMHRjSAcSQlozC6fIZoO661YWneQrKaok2tQvCwr
 j/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694206277; x=1694811077;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E3h1NzWZ+PlVyRsy8pJqbgheTOeQsn8cWPj3t42ko4E=;
 b=Gf4XBdnSY7FIyQbElu87ePytjDibUtWFouSx0vEJueaOBsYlZfM+Ux+Ilg/8HpqRV7
 eb6q8mIEdIuzC+FCVlrK61MHPcZZl6rIuKyXHUtbisDmYApowN8kDw2RHiLOkXEDrHnL
 HEB5ElkJ5QIobOD69K0BbILXIX/MWM3Ru/2rZ7W9Wnv8Ha5J1ilbhlBwumXGmrBynwGE
 JJGk4wpULRtMPCt4JBoeyZBvs6takp0q87y95b8ZizYX2VviPuuH0OITwKneSL9YRJca
 b9ffxNkNMKElkoLH8nASWuUgNMthRnLqy51uyEqOYLclpHLheqg4vdpBfJrFF+Yp0Zsn
 Tbyw==
X-Gm-Message-State: AOJu0YxrxV/JYVlWqTO5nd2poDlB/uKIf4VjUy4nojzwRx9t/BmXkqh+
 aDA5d2uANIXQg11F0Sa5cpA5rg==
X-Google-Smtp-Source: AGHT+IF2F+dUYYjVHHJo7i6J2N/mA0tgH3XxTkMXWDqr/EViwX37P8XUBMt5X5oURD9DZ9AUT6raMQ==
X-Received: by 2002:a05:6a21:338e:b0:13f:13cb:bc50 with SMTP id
 yy14-20020a056a21338e00b0013f13cbbc50mr4629136pzb.25.1694206277042; 
 Fri, 08 Sep 2023 13:51:17 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 p6-20020a62ab06000000b006870721fcc5sm1741553pff.175.2023.09.08.13.51.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Sep 2023 13:51:16 -0700 (PDT)
Message-ID: <0b19d3d2-8798-1641-152a-e86d979edd67@linaro.org>
Date: Fri, 8 Sep 2023 13:51:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 07/14] target/arm: New function allocation_tag_mem_probe()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230907160340.260094-1-peter.maydell@linaro.org>
 <20230907160340.260094-8-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230907160340.260094-8-peter.maydell@linaro.org>
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

On 9/7/23 09:03, Peter Maydell wrote:
> @@ -198,6 +215,14 @@ static uint8_t *allocation_tag_mem(CPUARMState *env, int ptr_mmu_idx,
>       return memory_region_get_ram_ptr(mr) + xlat;
>   #endif
>   }
> +static uint8_t *allocation_tag_mem(CPUARMState *env, int ptr_mmu_idx,

Missed spacing.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

