Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CA4722FAF
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 21:21:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Fk5-0003X8-3h; Mon, 05 Jun 2023 15:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Fjc-0003Vs-DD
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 15:19:46 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Fja-0007nt-9w
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 15:19:20 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5428f63c73aso2526129a12.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 12:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685992755; x=1688584755;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wVjtOfdTTZieiEBPc31ngjfLd/3pzrP4j2rieJolwhg=;
 b=YlzjcuRFm40lq7zzuk9StRrSKosfEkaB+urvbpHZDf2np8baQJndsU6AYj6Q9xp+kg
 ZwqOjZeVr/QTM0emtRI9fkMuLLllnHo6FdyZ4dvCQ+5BWx5H5O20TKNsX/ipq68tgwsb
 pIsNGuD/9Kn9SSExbHAeVU+kos6fh/A8myzGz1w6x9ZPeM2rj+a1lXLHhqyUCgfMV8uF
 6jHifZ8+k4EiZ3E/c5/BDpfOzHUfsaPL7D2h/zvyDNjL+HKR1RgV03JyPeTvQxQOk70q
 XQw4En/G7BrDlGVMwIAi8Nu27naSLvuWAU76oyIT2xJflxG2C7KBBtxuq0EfoUQNwDOH
 Ygqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685992755; x=1688584755;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wVjtOfdTTZieiEBPc31ngjfLd/3pzrP4j2rieJolwhg=;
 b=CKy12FqhZt/mldV8u0Qgn7nuh7cRy3xgebtVU5l23QRDJF06/EopVAy9+XsmwFFHjR
 zR+yHVt5oYfBx9fL6tuqlL+VAIhiLe0aoUvUJ7az0qn2e0isDO76cHoPHSKAnjk+IG47
 dIfavGPMOpq0j+YMJL8a8xAt6UHfBg4X4+fuRiKXRT0Tsenw6IZ2uJzjs7prl+twot2e
 MqCK6W4HgSPlcAAv0GcTdEjZubCvwibmwvnFzwYkv80R6oypuuqtG/Zg0Pv/Xo1RbED3
 /YZSXxA9A8ARwBFZE6eQeJxSl0eirnEcPmIXh4aPM4E7Y0XvQnNRJotf7RNabKz4JBCE
 Q62w==
X-Gm-Message-State: AC+VfDxlJ+XV/+SP69tT11wkZhMuGKw7TV8sYoToKPk2vS0NxeurV4p7
 TFohJ2O5/+5nqSkZkE7ZfHQVVdj/S6DaDG8gdK0=
X-Google-Smtp-Source: ACHHUZ4bK0+xV7wXe36DUaTCrzs/aWornJAPQSBrSPY27/sBJc+miHLWyMt9pvDObAyL7qdUqkWMaA==
X-Received: by 2002:a17:902:d386:b0:1af:a2a4:8379 with SMTP id
 e6-20020a170902d38600b001afa2a48379mr4352503pld.17.1685992755612; 
 Mon, 05 Jun 2023 12:19:15 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3f85:a600:6a3e:e465?
 ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 o13-20020a170902778d00b001b024ee5f6esm6920789pll.81.2023.06.05.12.19.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 12:19:14 -0700 (PDT)
Message-ID: <1cc5a040-a82c-cffa-1e1e-9a3be004349f@linaro.org>
Date: Mon, 5 Jun 2023 12:19:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/5] util/cacheflush: Use declarations from
 <OSCacheControl.h> on Darwin
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, qemu-block@nongnu.org
References: <20230605175647.88395-1-philmd@linaro.org>
 <20230605175647.88395-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230605175647.88395-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/5/23 10:56, Philippe Mathieu-Daudé wrote:
> Per the cache(3) man page, sys_icache_invalidate() and
> sys_dcache_flush() are declared in <libkern/OSCacheControl.h>.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   util/cacheflush.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I'll note that a comment in OSCacheControl.h says that sys_icache_invalidate performs both 
dcache and icache flush, and so we don't need to call sys_dcache_flush.


r~

