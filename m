Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D57782411
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 08:55:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXyoN-0004OD-Ns; Mon, 21 Aug 2023 02:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXyoL-0004Nj-PW
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 02:54:49 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXyoJ-0004cZ-9t
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 02:54:49 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fef34c33d6so2140975e9.3
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 23:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692600884; x=1693205684;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Zes5+ncKjkMbUECMvmg4ZwRVxgm05krrW8645IZ5Z2g=;
 b=sdfef4aLpqFHoC4IwV7qcWBAq/nPf/iyNfr/9zwHvszSEYCU+CjfePMyR4YkouZM4z
 ZxeMQymsY75fPpP1UX4l//Y+LP2EtVNjV3J23EK+KVjhb61ZuWTqphVn4m4tKY3bGYAu
 W5vSLY70EqQGwMl+GfqlQe1twD/ZkiNlDQPqAka8WWNUUt4hRlMUJGsLhfrFHEthO3kP
 XDDqWfTxYSRk22mKnEb9MqD5pKQGAF0v3UG9TsKOc0ukzoOcp+z81VKsvEbbEZmxuPAB
 +mfy3McW7LGYwyxgHFNXUOizTsOFDtbTyqOLZg/7DvD8WnVVCIACqZjdqTo5DF/61zpa
 IK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692600884; x=1693205684;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zes5+ncKjkMbUECMvmg4ZwRVxgm05krrW8645IZ5Z2g=;
 b=ItFnDQ6ZZ5gMjJ5WWWEm4qS8tAQDESmFOdVqwtYnew6nTiNAXyKLE/onBS0gc8F/mu
 1PzuLricFLXbiz5rKLuBTbga/pkVB5KPFQ9J/V0E8HapZTFbftglTbih7Lhx1s4bbRe3
 Kil1GcMJGAL5cC2DJsqy1ruG7FMoxksztVQ9nAJih2BNcDJdMiYBg+dB7X7vOmj3oZ9F
 s42exQK35SjhItadKrpVyOhBO8y8wZonb18ekT1g9l1lTSIouwRIKvS3jKxs9wrnniaY
 iyfVS9lQyVQxHtOqKzzgIJeCNRLG8lCVZNeYMXBGsHbt8U+/q1yqIxNhCX6yDWixd1nE
 3JNQ==
X-Gm-Message-State: AOJu0YzBoGx6tg15rpghG9E5Nu/b5LsDBZHUgMaBCaphHWALHb1Pw5mX
 rtXLBk/0UFZFNghZvKzoE0JF13HSSibxOA9jtWM=
X-Google-Smtp-Source: AGHT+IEje+pFPowkPXL+bFRfkRkTwC8VkqTV7OhanvFeZvAn9rP/oveIBWpqVNEJVQz/r0qb/9Ee4g==
X-Received: by 2002:adf:dd90:0:b0:315:9e1b:4ea6 with SMTP id
 x16-20020adfdd90000000b003159e1b4ea6mr3993093wrl.58.1692600884690; 
 Sun, 20 Aug 2023 23:54:44 -0700 (PDT)
Received: from [192.168.69.115] (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 l13-20020a5d526d000000b00317ca89f6c5sm11218413wrc.107.2023.08.20.23.54.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Aug 2023 23:54:44 -0700 (PDT)
Message-ID: <0cd9059c-88e5-f39b-2dd9-0838db2d494f@linaro.org>
Date: Mon, 21 Aug 2023 08:54:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 25/33] tests/tcg: Extend file in linux-madvise.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230818171227.141728-1-richard.henderson@linaro.org>
 <20230818171227.141728-26-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230818171227.141728-26-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.279,
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

On 18/8/23 19:12, Richard Henderson wrote:
> When guest page size > host page size, this test can fail
> due to the SIGBUS protection hack.  Avoid this by making
> sure that the file size is at least one guest page.
> 
> Visible with alpha guest on x86_64 host.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tests/tcg/multiarch/linux/linux-madvise.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



