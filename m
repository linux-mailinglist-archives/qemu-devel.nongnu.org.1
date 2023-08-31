Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 085D778E408
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 02:39:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbViD-0008Bt-Jl; Wed, 30 Aug 2023 20:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbViB-0008Bk-Ke
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 20:39:03 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbVi9-00053y-FQ
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 20:39:03 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c1ff5b741cso1966585ad.2
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 17:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693442338; x=1694047138; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8lJsoYHEXSMxqTYqNfj88o9kpS8w10+pZo17S079E+g=;
 b=Hqj5QclimFK4XdLbRv18HJWS9Rzb2HheX657hkiBHGPOXKlWaUD+SvzBdDHYjJKJSi
 gYJScsxZFd7zVXnRzsgu7tYUdNk1jIKiOYqTm+E17PG/wzkoexqG2CjVj7tOPU5998Rb
 I8yhgHt6Xm54u2V3z82pJh8XlZyWWJjcsOe7EpeewChSoiHZtMCMgC/wbHwc7eMftw8v
 pl61IBnh6fxBc2LcICS0l7ot9fsIQD2xAGDM6RxVRj3aRBW0nC4zR9Tk/NLYwjTGJCJs
 9cZTc/M5ST+iGTzbxCqRMXSv2sjiLwoT5yrMsZ/cbigyxwgzjKjYo4o2klUs4wpmvbGH
 XxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693442338; x=1694047138;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8lJsoYHEXSMxqTYqNfj88o9kpS8w10+pZo17S079E+g=;
 b=BuXxjfuVPFvHhV4VHHAI+7uSLXQ91/7cH7q9EqKtRNz8fSOuFEyVcXR0qEYw6qP5ur
 GDUYHAF22Z+1+SG9LWMrZN8BTtjdzc990s1VaWpNUGZKK9Ys/wlOv9zlUb8M5dsVAOSk
 BX3FjT4YNHR01xyZo7AV9n+ayG2PrpSp/ASgGbcWMWffPGPGEUwBPrcyCniOVNKU8hbP
 IPpNBd6JIPgKWuewtmt40FOz6yUscCU62zeLMSFKZ4hLhx+AF7kebrHg2PKNsB1IjHZh
 0Wu+1al/70gysr+uSE5fbtnbdwUaDJvOaoK9N9uSxnpBFPGVncx7nHK4mIXIM6AOXjGX
 7HUA==
X-Gm-Message-State: AOJu0YyPt0Ugya2GUQrijlpzeXwl0XilND9cSlt/zd4dNi6Xw31KuLWU
 e1KMuONZQ14nEbp5BTdw2/upUQ==
X-Google-Smtp-Source: AGHT+IE78xhoo06gItP5hzEM+/T0J3hvPYfdbB7G5ayirR2RVebYXxjHHlsBd4fM9n7o2SAya3Tesw==
X-Received: by 2002:a17:902:a414:b0:1c1:ecff:a637 with SMTP id
 p20-20020a170902a41400b001c1ecffa637mr3307279plq.15.1693442337708; 
 Wed, 30 Aug 2023 17:38:57 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 jw2-20020a170903278200b001b8943b37a5sm99420plb.24.2023.08.30.17.38.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 17:38:56 -0700 (PDT)
Message-ID: <72bc538d-2fe1-f825-23ca-e89a69bf17d7@linaro.org>
Date: Wed, 30 Aug 2023 17:38:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 48/48] target/loongarch: CPUCFG support LASX
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230830084902.2113960-1-gaosong@loongson.cn>
 <20230830084902.2113960-49-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230830084902.2113960-49-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/30/23 01:49, Song Gao wrote:
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/cpu.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

