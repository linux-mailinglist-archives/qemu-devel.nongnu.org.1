Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B52877DDB0
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 11:47:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWD6T-00065A-Gd; Wed, 16 Aug 2023 05:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWD6L-00063E-3o
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 05:46:06 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWD6H-0004Bf-MQ
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 05:46:04 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2b9b904bb04so101126831fa.1
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 02:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692179159; x=1692783959;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BPFHlSjDax4ciW5MMuba6GnuqI0s6L3pFh75MXEBTXA=;
 b=iQiVHPvLUH6kFyDQDSHYfU3FaJVCwKOnzaaRS5q4CrdzxJ8hbFRELmlw1gVZr2RQsN
 xZFqPIhstgBkIx4fKkVZYyKkJA0RwgeoWMCnx5qiHxIqUMc0yC4Upl8RCe49/TpYQoHe
 UWp+Gn5nx83CLAkDhlrpqsSvvSrrU2V/F80gwZg3EQrFoSl+feYbluEc783m6bOb8+jX
 GF6JRHEv0U2qHI9NY4MeqQrY5sd0mTBd6xT3HgOtWwYzh8gvaXXzUUBvWnGTSdPWeWEM
 P20GnRYGWkmdfB/sOT069kuGiyxIQN2eJ6XgRlwe6gnFnSk9Cm16pHS/CQdohFxzfv1w
 532g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692179159; x=1692783959;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BPFHlSjDax4ciW5MMuba6GnuqI0s6L3pFh75MXEBTXA=;
 b=SjKbkwTJG+ppGz9gzZLQODTxNJfZHX+IgJcDgnv+EbeVC1P8IUeK6mqW45l/22tm/J
 0YSXCJzgGoQ5+wgyCbJGP9EWpR/ryKzkNHnWLYv+7NLW+ugj/vnExP7lZksNqvjuTWOe
 EvoaLoEAzz0/iioEF3JX+rczvoKp8IUliuF2675CSWLxgARlagUiTPu3H0CKhy9rqjI2
 5MpcNSQdTZJuRdw8DfihUe0FHff86C4/pCPVqjHaBLYNszFduOM8WhwDqdnHCv6Y/KZ2
 bxc0fnYghzYNko/j0zvurwVwpEGNvrJdYJYMUN4U3P0tYZKlJZit7ZRYowbkQshgOJIV
 t35w==
X-Gm-Message-State: AOJu0Yy2yyWnwc2fRvgRJUTBoQLqflrzBRHBNkwMbZ2T29Ka6ERiGdYy
 64sX7WiSMcHig6AO6z7rKYlWMw==
X-Google-Smtp-Source: AGHT+IFWF9hiLV3kCxjOfJjTpkQXIRFXHXixuscpy7yE501VSYt7tNwBVJl4LTtUk0GIoqgDrqsasw==
X-Received: by 2002:a2e:97c8:0:b0:2b9:cf47:ce69 with SMTP id
 m8-20020a2e97c8000000b002b9cf47ce69mr1066217ljj.48.1692179159552; 
 Wed, 16 Aug 2023 02:45:59 -0700 (PDT)
Received: from [192.168.69.115] (mna75-h02-176-184-40-35.dsl.sta.abo.bbox.fr.
 [176.184.40.35]) by smtp.gmail.com with ESMTPSA id
 i11-20020a05600c290b00b003fba6709c68sm20402731wmd.47.2023.08.16.02.45.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Aug 2023 02:45:59 -0700 (PDT)
Message-ID: <bab2e366-d821-3ca1-ed2a-a46f3f2a1afd@linaro.org>
Date: Wed, 16 Aug 2023 11:45:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH for-8.2] target/m68k: Use tcg_gen_deposit_i32 in
 gen_partset_reg
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu
References: <20230813155425.341598-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230813155425.341598-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.045,
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

On 13/8/23 17:54, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/m68k/translate.c | 11 ++---------
>   1 file changed, 2 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



