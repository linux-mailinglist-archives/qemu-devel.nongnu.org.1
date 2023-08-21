Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7008782957
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 14:45:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY4HE-0002mp-LO; Mon, 21 Aug 2023 08:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qY4HC-0002mg-A6
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 08:44:58 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qY4HA-0005iD-59
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 08:44:58 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fee17aebc8so19525665e9.0
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 05:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692621894; x=1693226694;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7CPhcEEDrIHh5aulSbenvf9MDZEgUM/0Fw3DuBe24y8=;
 b=quEgcOpQSiKLxATl7GrNxj2uSG3M8VieBg4BWbk2exsb8DmngsC/P6ykK94HtSMU6U
 b5WjftTryQPIGIVbu8a5VWj3Q5PR4E0LXbC9fY+/Fwf3fSdbV9stYTsOV+L88PiOpFHP
 jOC5n8zgjME/x2e3fp1S52Or/c+ffyOYswyVnyWeOJVOSImcRXgTOgV/oXiB98oHLy9h
 8zz9JaZfgLOSIiob6P8PDlO6zm40jaWXZ3ZJLW6tPc7LNSry6GpRm3ncTvmPeFeRp6Sb
 rFBbzThCVqZ8jO4Mo2U6UwhjKE88ZYWh8e/0/kB8LAb0ZiCvszPbhhB6BFJE6dGAoeDE
 EvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692621894; x=1693226694;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7CPhcEEDrIHh5aulSbenvf9MDZEgUM/0Fw3DuBe24y8=;
 b=F3vJ5acJ7RhlQMfKPxEFj23XO5Q7o/GOhOfUKYp0ai2KRszQpeZVygxQi85mDuwV8D
 3W9KHOisVdtGEuFSuTmjvX2e0dQC0On6HgXVYekmZiUlfI6tS5+FrENHE18LgNjnxQeC
 qXDx8G+H9dgS++Qc++eAoM1vTSkSg0+aovTHH9cFNCx6IpU1cI9tPVYt22J5CfM7TmM2
 sE2hOM1mo+O2jISev1YTzfNrA19nTsV0bjKqhNgRi+1H/Ihz7uIF/IDnFFlhDoXkSsDK
 a7LjZpvg7h0ZbVNSh5al+UZ+4ivvCOUqPDAfTE/YnGqPOIj/glv7qa1RthaVR/7AwmW6
 XCQQ==
X-Gm-Message-State: AOJu0Yw5SLjDUYMG63b+tvB9l7FDpFh57Bx90gFGRufYDpz8XfBz5ol5
 hsDMxlMd2Kzf4CJ8NwuePwa06A==
X-Google-Smtp-Source: AGHT+IEyfoD8KtudjxTQ6MjFBqpX0rZZ734DR6S2TyaO+Wk66S3R9Yva9W/2thk37oFrbMl14Qjt2A==
X-Received: by 2002:a05:600c:2218:b0:3fe:2b8c:9f07 with SMTP id
 z24-20020a05600c221800b003fe2b8c9f07mr4893970wml.1.1692621894474; 
 Mon, 21 Aug 2023 05:44:54 -0700 (PDT)
Received: from [192.168.69.115] (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 m25-20020a7bcb99000000b003fee7b67f67sm7481673wmi.31.2023.08.21.05.44.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 05:44:54 -0700 (PDT)
Message-ID: <bf373dd3-6f59-1a1c-339b-b3e32db5dede@linaro.org>
Date: Mon, 21 Aug 2023 14:44:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 07/18] target/s390x: Use clmul_16* routines
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, ardb@kernel.org
References: <20230819010218.192706-1-richard.henderson@linaro.org>
 <20230819010218.192706-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230819010218.192706-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 19/8/23 03:02, Richard Henderson wrote:
> Use generic routines for 16-bit carry-less multiply.
> Remove our local version of galois_multiply16.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/vec_int_helper.c | 27 ++++++++++++++++++++++++---
>   1 file changed, 24 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


