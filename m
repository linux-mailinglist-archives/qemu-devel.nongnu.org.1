Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5313798859
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 16:14:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qecE4-0003C2-V1; Fri, 08 Sep 2023 10:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qecE2-0003BG-6L
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:12:46 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qecDw-0007sJ-KD
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:12:44 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-522dd6b6438so2701853a12.0
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 07:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694182359; x=1694787159; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EMjX/kHSnXNVNg5zStG4WLei+MWKXLmtPNdlEm4tYzo=;
 b=JbEh57zJhTfdXlo2ZpnsIcgqEJc6dp+YvY3QPP+qdjUhauBXOuVFlf+RAYqeTSDinZ
 iCNcZfmHfQDw40+wpMM+dvIw/1Z9j/pnQIX7prTMV+YbKrLE8/twwibVTvYdOjNGO/yR
 YseEvBTxC0e4E2alBwgOEa9gushnxRZRTAMV0zlENZxsOFb7bihr3M5eGsTDDBpq7Y1G
 ElwIZ/u6yiwgv02bE8LUmKDavu0PPA/IgsyW8TwjGUCjww6NuTbLzBpUi6Tw+boDEoun
 rK8aKC3gaW0B0ujjahLURZbV+lMI5rs4YpvG6HBoo4uGjfM+WwUOtdd3sMm5Foi5BvIY
 6N7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694182359; x=1694787159;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EMjX/kHSnXNVNg5zStG4WLei+MWKXLmtPNdlEm4tYzo=;
 b=AZ2wYEXJJf52urCKLlEG6pEo5w0xOrm1/7TQ8yVuy947GMBhISvQWpwR6EKIhUNrrt
 eowy+tMQOWaF1bJdQGycTwsEe+SukX8YK57OrM3igl8Sk433M5DqafDwvdhyeDOC/ycE
 mwdc4tnLN3IYbwMpBPQQcoVXBNoO5erTmSSjiGQ6WLF2dnuMXfzzD3rJX6LGTLoAI0n5
 auV4LkpzXQfqH6YgWggGG/oLoH0Xw4cDaWp7t7YtMAoedkLDcZvKxcLafszLqk1C9clQ
 Hblz/rW3AOc85jeI/XSku/sa9ed3cW40fDfNPV/mrmaIKsASr88im8BNz81NIDRz094S
 MfyQ==
X-Gm-Message-State: AOJu0YzEqRQsl6Jmq4G0HfBZHogM4IcZWQUwc/nStMMmoDfjYbsGWZU0
 8b/Y9HNqFGRCrU3ry3yvHWpW/Q==
X-Google-Smtp-Source: AGHT+IEq9KhS5TrE5HoNyD8hOIHyzkGuJMa9tRivm9XYoRreDHaKCz6sp6/6Cg/xC9t5u5QvrZRpvg==
X-Received: by 2002:aa7:c615:0:b0:52a:46a7:4592 with SMTP id
 h21-20020aa7c615000000b0052a46a74592mr2014603edq.3.1694182359079; 
 Fri, 08 Sep 2023 07:12:39 -0700 (PDT)
Received: from [192.168.69.115]
 (lfb24-h01-176-173-167-175.dsl.sta.abo.bbox.fr. [176.173.167.175])
 by smtp.gmail.com with ESMTPSA id
 r18-20020aa7cfd2000000b00527e7087d5dsm1070105edy.15.2023.09.08.07.12.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Sep 2023 07:12:38 -0700 (PDT)
Message-ID: <03ab3e29-9c5a-8121-44ac-4c1cc7e9b205@linaro.org>
Date: Fri, 8 Sep 2023 16:12:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 01/14] target/arm: Remove unused allocation_tag_mem()
 argument
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230907160340.260094-1-peter.maydell@linaro.org>
 <20230907160340.260094-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230907160340.260094-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 7/9/23 18:03, Peter Maydell wrote:
> The allocation_tag_mem() function takes an argument tag_size,
> but it never uses it. Remove the argument. In mte_probe_int()
> in particular this also lets us delete the code computing
> the value we were passing in.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/mte_helper.c | 42 +++++++++++++------------------------
>   1 file changed, 14 insertions(+), 28 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


