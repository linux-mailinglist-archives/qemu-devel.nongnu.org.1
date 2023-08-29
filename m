Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 973F378CA2C
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 19:06:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb293-0004zq-Kp; Tue, 29 Aug 2023 13:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb28g-0003tx-3v
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:04:28 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb28c-0005Mx-0Z
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:04:25 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bf7a6509deso24122285ad.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 10:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693328660; x=1693933460;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TiB6ubqPsy3z0PuFkp7234GAkXg8zqYSxGbl9JAIdeE=;
 b=WyQGrPJM3pI5ZDNJmXorCKQf7bvdpujBZx+yt6r8Szo5b7Rri342n/JBWRzZfU1H0k
 GZmbfkp+FFo2srOldLW8R3hGZxjeZ3/XDd8hB9LE4xAKh1gmSwV7Yb8z7sCCVRRLiWU8
 ATBZ6Amo8xV+25wF9svPYjWEbRWswhvekJ+CMi44uX6Gsr5mS1JGYjIKKIf1SgTl1SDa
 KxYXG49D7MGcBggK7dPcY7Zta1GQWv/Xk/Nzmvs0QeVwj58O9UFIjEEig7/1yyK+o4/X
 IPGhV2uMT8XszNRnMyJuNNKdj/+5q6i/O6zaOqYxV/OyiQKDI2qG64WVjsDSQz3NrE2y
 sU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693328660; x=1693933460;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TiB6ubqPsy3z0PuFkp7234GAkXg8zqYSxGbl9JAIdeE=;
 b=XdMFApxj4HcMuNXJ5vVMBELDzXJYr94OWGQfMY7W3EvO/coLlHIHzAmcZ7a9jmoVng
 fq484qBohsRmr0Y5f4AfXDLL/F6AH+frypSGQMgiLkddj6zZ6MVgTsV9PRoKUTrhPWyb
 VAGqACVxQY3BtZnC8GeWP4jpfVhaao+pcj7QMT2IAKOTTGhLJvxB5GRKUmav7xQrac7j
 9a36uAINj86sc29cv7O1M6LetDX73bzP1Gt+e5hiJfha1gHUyyPGfQKyXpLEEDHURoZk
 2tFje4Fgis31wxTMCPfPMfmqjzKNrqO8GX2VzMRRhLx6Eq7fNGPb6WbncaNCG+gKN2Yn
 ZXlg==
X-Gm-Message-State: AOJu0Yyb888kvsZ2OIeszM0JORo8UBlfnewtugMS7w1Ks+yFxwaFMX+B
 xNJYRZkb0FugzOaTx0flKHHio/vYEhvs5XXCFVk=
X-Google-Smtp-Source: AGHT+IHzaMNNRDU+q3XdEvRg1zmdcG3MZKsRc7KwXDwgWBtVYbePLeMGLqsKa7HOwO2MnPKN1BsPxg==
X-Received: by 2002:a17:903:4cd:b0:1bb:b855:db3c with SMTP id
 jm13-20020a17090304cd00b001bbb855db3cmr21738192plb.41.1693328660136; 
 Tue, 29 Aug 2023 10:04:20 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 jw6-20020a170903278600b001ab2b4105ddsm9595725plb.60.2023.08.29.10.04.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 10:04:19 -0700 (PDT)
Message-ID: <57992cba-6230-2bd1-be85-cf7b78e31f2e@linaro.org>
Date: Tue, 29 Aug 2023 10:04:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 02/11] target/riscv/pmu: Restrict 'qemu/log.h' include
 to source
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org
References: <20230828221314.18435-1-philmd@linaro.org>
 <20230828221314.18435-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230828221314.18435-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

On 8/28/23 15:13, Philippe Mathieu-Daudé wrote:
> Declarations from "riscv/pmu.h" don't need anything from "qemu/log.h",
> reduce it's inclusion to the source.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/riscv/pmu.h | 1 -
>   target/riscv/pmu.c | 1 +
>   2 files changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

