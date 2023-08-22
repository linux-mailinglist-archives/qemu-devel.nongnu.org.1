Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4C0783A37
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 08:56:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYLJe-0006Ks-Kt; Tue, 22 Aug 2023 02:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLJc-0006Jm-L7
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 02:56:36 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLJa-0007AU-Fh
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 02:56:36 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2bc63e0d8cdso39497551fa.2
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 23:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692687392; x=1693292192;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wYuXXSwlT89QLQ7vwE/B0hC/Hk6e0NK10S7omuNBCro=;
 b=XkzSCO7buh+A5vPv/F6K9dS6JSi6YyWJp5PgPKhYt5fs57yTwHscNlMpQQ0tgrvA5K
 vyfVWLMvEoBod4DqHY/NqjfdLCx6iqmZa/sHMSW3osJrBpUvY5QWjFXbvOQ8PsS5SPYE
 xJSIQJSxPPQlAiqiEqjRhx5M1cZvl2D+yb/q3jhVcpQvm3MwVrvfDRV/vzITd6bBYBRo
 zHIgdNOlXxOwg9iEBSnpjLa7SI5IJjuxLdfprk0sHuVS1LHrQwVQeqWuvCwBPSY5Ut1G
 UZv+WB6OC8FfCgnXwL0o9FxWLOj4zWblyTuBwVcqE0bSejmxrDDFhNH73Ten8SvSuGKW
 GxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692687392; x=1693292192;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wYuXXSwlT89QLQ7vwE/B0hC/Hk6e0NK10S7omuNBCro=;
 b=CluS/A1QOQfzwptMuJVapQZM1dsdmp5p4txvK4HgJPRiaNYmRop6NZFy0F2A3VpFWl
 SoDFNlwegDPTTqgjKa85opPrdHaUtlX8ZpqH/dI549Vc7pasqNcBT0WNtT3CR3+kuXLL
 tIG1cKP3rbneTlJsyER5JoWQFFXFbMmaTgU1j+su59S7GlfGKlxTVX4Ke3h2rQzjC3xZ
 yTvtoj+cPHoRNAubnykgndU2YFM8FWLUq/hC7STRR5WMarlRGtINGjJkd34lM8KkFHCt
 mK3tW1xWS9jr7+HjGGW6bJfFZJrX2XDlsI2/qhu6NdeWP2zKAyujQ7XGpzOseSpoykqr
 HdLQ==
X-Gm-Message-State: AOJu0YzJvG2OZLBCiu3YJPFD72d5X0eXM02DhhrKYeI5p/O/cW47iY80
 gqXPcaappEzvQrCZRgcoYGlI4Q==
X-Google-Smtp-Source: AGHT+IH3md7r+IwYdlg59lSCmfrM/jZbKKNBTi3P++n33fUEzMVLMZSpw2B7+5gkuK/XdIW5dSmSmg==
X-Received: by 2002:a2e:7c0e:0:b0:2bc:39f5:ecb4 with SMTP id
 x14-20020a2e7c0e000000b002bc39f5ecb4mr5846963ljc.25.1692687392575; 
 Mon, 21 Aug 2023 23:56:32 -0700 (PDT)
Received: from [10.2.0.2] ([37.19.214.4]) by smtp.gmail.com with ESMTPSA id
 c1-20020a7bc001000000b003fee567235bsm10723774wmb.1.2023.08.21.23.56.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 23:56:32 -0700 (PDT)
Message-ID: <63e8846f-90e4-2f6c-c0b9-7c8880f78d19@linaro.org>
Date: Tue, 22 Aug 2023 08:56:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v4 10/15] hw/loongarch: Remove restriction of la464 cores
 in the virt machine
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, c@jia.je, maobibo@loongson.cn,
 yangxiaojuan@loongson.cn, yijun@loongson.cn, shenjinyang@loongson.cn
References: <20230822032724.1353391-1-gaosong@loongson.cn>
 <20230822032724.1353391-11-gaosong@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230822032724.1353391-11-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.374,
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

On 22/8/23 05:27, Song Gao wrote:
> Allow virt machine to be used with la132 instead of la464.
> 
> Co-authored-by: Jiajie Chen <c@jia.je>
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/loongarch/virt.c | 5 -----
>   1 file changed, 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


