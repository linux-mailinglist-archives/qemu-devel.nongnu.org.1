Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DCE7B53D0
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 15:24:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnIsd-0004eU-7H; Mon, 02 Oct 2023 09:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnIsb-0004eI-0G
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 09:22:33 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnIsY-0003NU-T5
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 09:22:32 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4060b623e64so18806825e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 06:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696252947; x=1696857747; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8fH7JKzZgtYTRblnXZK7SNppE/oNJnCP3m7ZuHLCc4g=;
 b=bISTJOZfe47ZKPGe8/XnLxkDJQ+A3lPvq2yxQ9re2Gr2je30BgWqzEfW+4VKMtkFmi
 guZOfFTrNzj3XmgzNSPwnkHfTKihWZpdElYAQgtCc23U+/GcqubvL5rtkQ0NipM7oWGB
 37tq8phEuH1ob5zBr9P0R0I6fY4ExrcWNXyYq4um5/r24hG5ZxRwkzOtGy6bnS2nwM8i
 5fjwAn5iyDjdfsvdb5NrZbnWVBvWUV0BcmQkOOgetDY4CRxxvquanGNOeMRec2Ur9N8Q
 SW2MuT16yhQ7GtkgHTq7Ud6A+ScB6gd0rc9uJs0G5SAII36CnnNeXmEqaLCLXM886mdf
 ypWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696252947; x=1696857747;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8fH7JKzZgtYTRblnXZK7SNppE/oNJnCP3m7ZuHLCc4g=;
 b=ictO6426xIjxaMlWyc7TUy0liSPGCG/ZNbRn1SIvJvzKkCNDbsqEoCPo43ucver/Zt
 h64A9kUSqFIMP6ONqdZvwWhsM2eYPfksE9PjNUtCg4M0nnefjsXSYd73ZVGSjHJ0NRZg
 ps6/a4Zr/MlTzqAxQsnTO7MMn2UxDn8rzAJp9fxsqe9PKKBluwDR4Yw2DIubenJjO86M
 D9VamPQC19YVue2mL4JPnVnUMjwxdztwTmPRTz4s0Xv4ahmavIeW/aNLyeMtR1cc05Pm
 9yTWa0278Gt5/7cwqckrRBrnh+OIDwqkou7II3Ky+25dcRDQzDc8aK6IWyvdv1HDSZg+
 dQsQ==
X-Gm-Message-State: AOJu0Yx+lHIf8FaZd6WGb2/wGXbSIS79BGoeJKrM7L4Y+kiykkwJx4GI
 AeApRpv92Ly2YsVTzS+XqgYSEUgifR23kt6p4HyOIw==
X-Google-Smtp-Source: AGHT+IFf0DfQ18edQOG2BvV99L2vNbxDdNw44LIgk9vLU5DqUV9jOlSc4eNvWyPHyCbybcfHHTv9oA==
X-Received: by 2002:a05:600c:b90:b0:405:3941:ce2c with SMTP id
 fl16-20020a05600c0b9000b004053941ce2cmr10373187wmb.6.1696252946843; 
 Mon, 02 Oct 2023 06:22:26 -0700 (PDT)
Received: from [192.168.69.115] (sto93-h06-176-172-7-203.dsl.sta.abo.bbox.fr.
 [176.172.7.203]) by smtp.gmail.com with ESMTPSA id
 17-20020a05600c029100b004064cd71aa8sm7280317wmk.34.2023.10.02.06.22.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 06:22:26 -0700 (PDT)
Message-ID: <376e58fa-7d52-4674-db63-503c4186f6a6@linaro.org>
Date: Mon, 2 Oct 2023 15:22:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v6 04/19] linux-user: Use ImageSource in load_elf_image
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, laurent@vivier.eu
References: <20230930021529.987950-1-richard.henderson@linaro.org>
 <20230930021529.987950-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230930021529.987950-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.321,
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

On 30/9/23 04:15, Richard Henderson wrote:
> Change parse_elf_properties as well, as the bprm_buf argument
> ties the two functions closely.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/elfload.c | 128 +++++++++++++++++--------------------------
>   1 file changed, 49 insertions(+), 79 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


