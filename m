Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E907838D4
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 06:29:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYJ1C-0004jV-0m; Tue, 22 Aug 2023 00:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYJ19-0004jK-Rx
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 00:29:23 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYJ17-0008RO-MC
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 00:29:23 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bd9b4f8e0eso25290395ad.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 21:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692678560; x=1693283360;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uS1BgzbtcdFXzG4ZjinXJ7I9FM5m7G4Kc8PPWjpvT4A=;
 b=n6mQeG1hV/s1+PSkjevC1aQb6sEusWhYjV1GYXUmgcJL8k478JtdAieOWC0jcSsgmn
 EM/7VbDX3wOgyHCIjfVXj+Bz5XtRl9XtNqLV7yjCM5EryitlTL7pfpGhuRRNAHgc18HU
 sI/3gJ+pC9Jnqo35ZitbvXHZNHTgjsn/XnouxtSKLpJvgPmqqpbvf33ygzTu7rvifeVe
 Zjzi056nfWPVMfDVDoQcXE99FcIwUNBCivv61e9de8yZVkhmIoqStXYMpHw6qVdBaOyY
 kJBz5flAwpXn5a4U0BhsDVh8ZijG9jscGZ80me3L03/RtYV/otH7to0n2XzOtWtC9vNh
 YqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692678560; x=1693283360;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uS1BgzbtcdFXzG4ZjinXJ7I9FM5m7G4Kc8PPWjpvT4A=;
 b=Mfi5R0MP7T/ElOMAfnCRldvlSIqHrZMShvdPEM+NwAbMQUVd2LMAqxPCm+vdzm63ek
 Z6xlSeclA0/wEyOl1hycVF5FQuXoFM+ZzCDlvOpQlJzUjsd0KPFGJsA1rpDC3G+Y/qLL
 s0cEnilDwFGm/6FShO8hReiu6N3JRymc21TCytcEmZWxhbPTh6cj59eFkJoUao2/Snld
 jMDBb7Cb/JEmiCzzf2C48kpIP/Tco4lf7dpUA+qgUGX7aaG0iX40D5UaqCN/1b8f7ZCD
 RDls58eNPzLXJMsFFQyqZHwHdKF9NmyVqCCiBszRYi6h+IHYIYy7UAXYvsyMJ+GLI68A
 gg+Q==
X-Gm-Message-State: AOJu0YxGQ/hJnCC48kfqOP1cBQXp1Mxa/mqwIA1GSZYJb+MMDv5R6RFA
 5qUEKUAOQMK/rXL6VLmBhBPLeA==
X-Google-Smtp-Source: AGHT+IFucg5ZiZbmfN0CIrDS5snkyd04+HNXKZ8IRESaUrVA4RqtkY8oMNESHxCfm5TR6LGkBXrYKg==
X-Received: by 2002:a17:902:c3c5:b0:1b8:9b17:f63d with SMTP id
 j5-20020a170902c3c500b001b89b17f63dmr6372024plj.23.1692678560272; 
 Mon, 21 Aug 2023 21:29:20 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:2c08:e710:4459:46f1?
 ([2602:47:d483:7301:2c08:e710:4459:46f1])
 by smtp.gmail.com with ESMTPSA id
 s14-20020a170902ea0e00b001b891259eddsm2471353plg.197.2023.08.21.21.29.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 21:29:19 -0700 (PDT)
Message-ID: <c213a55e-7058-a5ec-8938-983839e98dd2@linaro.org>
Date: Mon, 21 Aug 2023 21:29:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 09/15] target/loongarch: Add LoongArch32 cpu la132
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: c@jia.je, philmd@linaro.org, maobibo@loongson.cn,
 yangxiaojuan@loongson.cn, yijun@loongson.cn, shenjinyang@loongson.cn
References: <20230822032724.1353391-1-gaosong@loongson.cn>
 <20230822032724.1353391-10-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230822032724.1353391-10-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 8/21/23 20:27, Song Gao wrote:
> From: Jiajie Chen<c@jia.je>
> 
> Add LoongArch32 cpu la132.
> 
> Due to lack of public documentation of la132, it is currently a
> synthetic LoongArch32 cpu model. Details need to be added in the future.
> 
> Signed-off-by: Jiajie Chen<c@jia.je>
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/cpu.c | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

