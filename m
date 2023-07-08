Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE07274BEA1
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 19:40:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIBuw-00016L-Td; Sat, 08 Jul 2023 13:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIBus-00015v-Ua
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 13:40:19 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIBur-00013f-BV
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 13:40:18 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fbdfda88f4so31177235e9.1
 for <qemu-devel@nongnu.org>; Sat, 08 Jul 2023 10:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688838016; x=1691430016;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rMrnnZu2k8dkJHLAsFGUgtyZjJdyb+/K97puqYJs/U8=;
 b=GcE7Pcbc7varZD79Xp5uXFfT2syHTL4zrJ7AlwxAlREEeLWv39V24q5GrpL9y66Js+
 nNAYlWKzcjWceBHkWsrooL6GSjTH6ld5/hLorb/XIpg0gkIVl9vtMzYvc8fqTBTBuqpz
 NzzSW2W+mnNaM5eXB2V4y5bQhs5mebit+QE9LBMxiL0kyjNWLUXWDtSUrwWEsXS0wiwD
 auI9bsOgYZ1KG4oyzwvn84QoAGGaTI9HtjvlS6r9xRHDvBZXpxgyEh8tdRO/BE1Ml8AL
 7K4Hau0c88ODvKm9aLF1uVG9zh01+D7lgd7VNpVjGhZw9DSD2G+sML7IIX4kThbp9nV4
 2SCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688838016; x=1691430016;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rMrnnZu2k8dkJHLAsFGUgtyZjJdyb+/K97puqYJs/U8=;
 b=MWI4K1nxgJ/PNw1JbVpXQbBM5g8bubZ6OgwHRaYuCijTZhx2LRsXi6SnmeGJHtY7Y8
 EdOcdSTW6GVXQ4pxoSKW1O0BUbnpulj4OgSQ10qbOANos4DMRD6yWpzgOTqTPoNl7pBp
 42SEHIyCgdIrzBW3yFoV+MIN9ZNlLi92kO8pgnzYSBdxAqlmgO1Rr53/afrKI2J8Vqov
 JELap+AZEhcsv0eyF9REFh0hRj/YZvt3ycUTo40MPLnyy2lMFFYEoicMENT+gDHVa80E
 O/YuNHDVCbXLzeBJZNT1s+MSkasTspkkRTCt5NyLYvnTDg9aXH8KNbxO+lZOP7Tyk7ej
 lgrw==
X-Gm-Message-State: ABy/qLYZak+H72IEQWzD8ffhtS7YjlYkT7EdwwFDhSHh7yeteCKGfocU
 6PJ7Su47i1oelzowVLsDEbK9KiQ7M/eUON5YR8s=
X-Google-Smtp-Source: APBJJlEaaoXB2+vy4pjisJ8JWer+962lR4Znu7140POUOLjIxZbUzPg3ARwZMrOyAtCSGjyXKLeWFg==
X-Received: by 2002:a1c:f70a:0:b0:3fa:d167:5348 with SMTP id
 v10-20020a1cf70a000000b003fad1675348mr6442449wmh.1.1688838015897; 
 Sat, 08 Jul 2023 10:40:15 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.184.32])
 by smtp.gmail.com with ESMTPSA id
 e11-20020a05600c108b00b003fba137857esm5640076wmd.14.2023.07.08.10.40.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Jul 2023 10:40:15 -0700 (PDT)
Message-ID: <cc105ad0-d6a6-e05d-5ce2-f67e110f0650@linaro.org>
Date: Sat, 8 Jul 2023 19:40:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 21/24] accel/tcg: Accept more page flags in
 page_check_range
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, mjt@tls.msk.ru
References: <20230707204054.8792-1-richard.henderson@linaro.org>
 <20230707204054.8792-24-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230707204054.8792-24-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 7/7/23 22:40, Richard Henderson wrote:
> Only PAGE_WRITE needs special attention, all others can be
> handled as we do for PAGE_READ.  Adjust the mask.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/user-exec.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


