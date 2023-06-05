Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBF87226A6
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 14:57:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q69ls-0001BR-34; Mon, 05 Jun 2023 08:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q69ll-0001B6-EW
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 08:57:09 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q69li-0007BH-TJ
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 08:57:08 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-30af56f5f52so4160347f8f.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 05:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685969823; x=1688561823;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NaVy4ZUSmPjH4/wizEkn++avyldhkFJfDdNy61EYpKU=;
 b=niNIUJvCqrgsd6o7iqEt5TAS0xs3LDT4xqDpYnrnkzILv1LWz+dulxWrjlPKSjGyFF
 2Q6JCpaSp+QNHQ+vm1Q9gQlCdnY6zV/PtvqtfpqyEYSLF21m7tWkSQQ2Bw2lxGx/QZVU
 P2ttDKi3eKS4oKOqkC6brXC7xoz/46A54HD6ItATan8jkM/J5RGWF9CbYAWRrfwi3YNe
 jcU6htx4p1h2v7RUsrtFpSrsXe0JCO0r/uWHf9v6vWV5p10U37WmpAE7EUeXuNyR/tOG
 rwzYWUZfGQtIBAT4kO4OnHmQCrao0Ifcusqu8FiH/vnFemyrxu4hcX3+NZpADU7NP5pk
 lGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685969823; x=1688561823;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NaVy4ZUSmPjH4/wizEkn++avyldhkFJfDdNy61EYpKU=;
 b=EFkxDO3SgqszLzljUmxvvX6Ml73FpsZTVFmJHO5A5jp30gmb11g1ai/G6BBzRA3XHp
 hOdynp5pArXhHvvX3ZuLl3UmAJ53ZUOd3ir8WEdn3gHjmqRCUNTuMbjAqNTHEJA6dFmY
 /GuHuxU9/dCJ7K0xBorJW9QeaWYUmz8IYjiJSExZ69JttxYPF85V7qQOH2RR217dYTMz
 O0frFVBFilPAv2ruCrye5/d16wc2EcLsEfXXOryDMYSNKelNA+l6W15qJt1jjZG9L5Yh
 WYk8qQeyW275dwFpzjyqjcn0CNeLiNp5RlieNTJlchkKElltOSbRk99d0HVvzeKGepC9
 YYRQ==
X-Gm-Message-State: AC+VfDz2dSP2QLYFcyfIuMvmuqntn/74le4aBjjoX24LnRo9MgzWSdKg
 HUUorSmXFu2Ef3OS5a7mY6AoiA==
X-Google-Smtp-Source: ACHHUZ5EDXdUwnwMD6ZpZ/3fmfrNdqSXEHJMDrGqsNY8c2RxAW3KYr97D0GHCMMHtv6YPdweNIq8aQ==
X-Received: by 2002:adf:ef4a:0:b0:30e:4886:3533 with SMTP id
 c10-20020adfef4a000000b0030e48863533mr835348wrp.34.1685969823393; 
 Mon, 05 Jun 2023 05:57:03 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 k9-20020a056000004900b002c71b4d476asm9733720wrx.106.2023.06.05.05.57.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 05:57:03 -0700 (PDT)
Message-ID: <0e956c2d-14f0-2c65-73a6-5879f4ae58b8@linaro.org>
Date: Mon, 5 Jun 2023 14:57:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 11/15] linux-user: Use abi_ushort not unsigned short in
 syscall_defs.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu
References: <20230603222355.1379711-1-richard.henderson@linaro.org>
 <20230603222355.1379711-12-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230603222355.1379711-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 4/6/23 00:23, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/syscall_defs.h | 90 +++++++++++++++++++--------------------
>   1 file changed, 45 insertions(+), 45 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


