Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDBC782932
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 14:34:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY46D-0003Hg-5N; Mon, 21 Aug 2023 08:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qY469-0003HQ-Vd
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 08:33:34 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qY467-0003No-7Y
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 08:33:33 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-317f1c480eeso2969573f8f.2
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 05:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692621209; x=1693226009;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LQ4DQSK2k4i7nCWSTdJeAP26NvvjUmpdLWOkc/YlIBI=;
 b=lHTkRyJJlD3vbK9rsbgf9ngLSZ/geKwh6swLloaCkGCYhZ7H79QksqWYuQTl1vBr8I
 BHRd4cURi+PMbva45cfjuAC2hj1+bB/cN3H5U91OzbeaWAnXfHN9VDaGmWRp7kIE6duN
 Px4Eswr2vBKwt9SHq3ex+5Kip0/ZkoPtGMWAfeWSS7yVRujfKAefNUjGKYfTrX7aLA7R
 /1jW1Cij3Qdg29exS8jmogchqiQy9IvV8AbEk5IOa14/D1Ae2e/oU9CB8ZCynvpo0d8P
 v/ZJt5Mu5Mv6QXlUCCrMn5kkVToDgAzaGZJ6gwfTnEmqIVbH5EzXcxVAY/+zv77gsIRh
 CmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692621209; x=1693226009;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LQ4DQSK2k4i7nCWSTdJeAP26NvvjUmpdLWOkc/YlIBI=;
 b=MxJP3kTA9kcellEiiPuKFwDMbYaWzdD9V6TO9UL+EcQ7MgEdE2WOA/1C0Htgy4XqUG
 huqzM1ra2gr6B0J3I6A1M0ytYWsfCbI3rNYN4eTMxbHUk3gKpjvVeRCcJTcwajbfC4aB
 pUTK0/RQz4Z0ibkipeRmjIzJjxsJc2UhWweA+wj9mbOtlPkoFC2veXxq62LbT9O3SPHZ
 0gq6uraRHHJeIvbmCmTz+nuo5nKWx5fhOh6q5ATkBWdHaNwSLYVCqbh9z6RP2aFy27vM
 elDuzHGKFLESio8fjikieqOI25D27TVy0vRI7gm6DyMke4IUd1IgfktHI5FN/wyU8G4C
 oNiA==
X-Gm-Message-State: AOJu0YzemEcPTI8W2oUDjhHt73DphjGLVwdwnclU+WK4GO2jHBfHSZCM
 LMKBxi3JVQHE0JXlmo+e6Mrbkg==
X-Google-Smtp-Source: AGHT+IHsK5wHAUK14rJAqrfznKpdTLBRkgtnK+zUhdefXA4U/2bYndMX8c+BOCKkvDU7CrixU9EInA==
X-Received: by 2002:a5d:508e:0:b0:314:10d8:b491 with SMTP id
 a14-20020a5d508e000000b0031410d8b491mr4629451wrt.67.1692621209565; 
 Mon, 21 Aug 2023 05:33:29 -0700 (PDT)
Received: from [192.168.69.115] (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 s8-20020a5d4ec8000000b00317f3fd21b7sm12522931wrv.80.2023.08.21.05.33.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 05:33:29 -0700 (PDT)
Message-ID: <9166df67-ed7e-934a-0a1e-dcb2d924ce41@linaro.org>
Date: Mon, 21 Aug 2023 14:33:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 15/18] target/s390x: Use clmul_64
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, ardb@kernel.org
References: <20230819010218.192706-1-richard.henderson@linaro.org>
 <20230819010218.192706-16-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230819010218.192706-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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
> Use the generic routine for 64-bit carry-less multiply.
> Remove our local version of galois_multiply64.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/vec_int_helper.c | 58 +++++++------------------------
>   1 file changed, 12 insertions(+), 46 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


