Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A902C783A4C
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 09:06:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYLSg-0000RC-Ki; Tue, 22 Aug 2023 03:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLSc-0000R3-Qo
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:05:54 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLSa-0000hK-B0
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:05:54 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2bba6fc4339so64558711fa.2
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 00:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692687949; x=1693292749;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jz+sv7XtS2cnByhLN0sB9A8nkMbZWwyWq5pSZdAUCvc=;
 b=bb6P2WHmdazKl5KNyjvgqKtbaChX9P7xZkAcpsC9IoY8TZ5SQmcgAegdU+YoT6LnfX
 G9j29+aBTiHr4dJx38hm/xn3qdHjDftJ5/mlXpd7Q76qEfnqdRbL4yiIfkeYzJRH1WFy
 2JX+xZNB3bE9t5CIRNLC2JBM1dz8rdDKOw/IwStshTFKcw4Gu2uYxnhKjLA5gFiLuJ0X
 2hX2zV6riPbJINgWGwu3FbiEZ0pEdQr/Ui+GyWGp5TmACrtEa0e8bN5pQ9Q6wEiiYlB2
 fgWfUfD2RWYGcIvv6BoWCJBPY+vmEjO4wRfj71ZSo34rXWAFrQJGi7cQMBa7khIA5NiC
 lspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692687949; x=1693292749;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jz+sv7XtS2cnByhLN0sB9A8nkMbZWwyWq5pSZdAUCvc=;
 b=axGSctZ8mTf7ev9Ec/+MDlkKuwnPWjqp8HVkcNqwIz3alNDfskHpmswHmRtg/t6z4m
 aDigDPYpUojEfrPMg6OcWYW2gnekMqDPt1ctpaMCNafJKArUGRie6VeJQYxo06OCSjQt
 oldn+iEgS1R93AnBUteOVxWMFQ0ynsLz3xMPuR6MQCnuQYHQXsAB2gKRJD0fDEYpGVfw
 sWOSZoLkItQXtfnTfd5a+c+MfQR0w8N7BalGvG3bg0ssXYL59xDZiGG4D0e4C/Jum2cM
 KcExg/N8LU6MuLpRRwPiq+h6xEblBqoAP/Y1/XgRkG4MF9cRdr5j8zfYi3Ij0NXOxyw1
 rJcw==
X-Gm-Message-State: AOJu0YzoSc9KOl0uQ4jZAe2fiI3X5m3W8qPYnKyl5s7Aa5sZV4Eyrc6V
 xi9vksqHPYGZi16JVtFxF00R0g==
X-Google-Smtp-Source: AGHT+IEISFFCNLDQTGi8fiG6+3lSYP6ZWtLP8Bx/zMSg6YJpkym8/6yaEabA+H3kIejnFxART9kBeA==
X-Received: by 2002:a2e:9b8a:0:b0:2b9:581d:73bb with SMTP id
 z10-20020a2e9b8a000000b002b9581d73bbmr6026743lji.26.1692687949686; 
 Tue, 22 Aug 2023 00:05:49 -0700 (PDT)
Received: from [10.2.0.2] ([37.19.214.4]) by smtp.gmail.com with ESMTPSA id
 k15-20020a7bc40f000000b003feef9a6cb2sm6812842wmi.28.2023.08.22.00.05.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 00:05:49 -0700 (PDT)
Message-ID: <5990383e-e3f9-1377-3f52-f41395007346@linaro.org>
Date: Tue, 22 Aug 2023 09:05:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v4 06/15] target/loongarch: Sign extend results in VA32
 mode
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, c@jia.je, maobibo@loongson.cn,
 yangxiaojuan@loongson.cn, yijun@loongson.cn, shenjinyang@loongson.cn
References: <20230822032724.1353391-1-gaosong@loongson.cn>
 <20230822032724.1353391-7-gaosong@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230822032724.1353391-7-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
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
> From: Jiajie Chen <c@jia.je>
> 
> In VA32 mode, BL, JIRL and PC* instructions should sign-extend the low
> 32 bit result to 64 bits.
> 
> Signed-off-by: Jiajie Chen <c@jia.je>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/translate.c                   | 8 ++++++++
>   target/loongarch/insn_trans/trans_arith.c.inc  | 2 +-
>   target/loongarch/insn_trans/trans_branch.c.inc | 4 ++--
>   3 files changed, 11 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


