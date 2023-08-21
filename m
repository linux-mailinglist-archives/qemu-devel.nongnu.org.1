Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F9778295C
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 14:46:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY4IK-0003Vn-Jm; Mon, 21 Aug 2023 08:46:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qY4I4-0003QD-JZ
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 08:46:00 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qY4I2-00067p-6b
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 08:45:52 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fe1a17f983so31067705e9.3
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 05:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692621948; x=1693226748;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pD1h1PuJN5SUyvg8jz3bO0gvW4qxvkXn4yHCAGRVyJ4=;
 b=uAPwHMnQCHdn4iGzDjHoY/SdX++v3Civ/q+lzzA6RX366YjQAevHNzOvFWAnPFtCxx
 A0KXAVMfHQNcZSjw1CnrzTPcu7VEE2EihHhyCxySTfNRQqPpZz0m4T+pvD26tKvGvTQ8
 3OmtE3P9oHhAq6fVVYt68pFRXHDpbLZgC2R630K48BOIGUrwehMRlPAvPzedCb9pYmnt
 Yrfa6929PYh3CplSty82WmFKRQlwRBdqLKfm2IjWfuZx3gZSXKNkWaarQV5Sa11ermOw
 56ewDoOsMuqtinJi4FQcloIY9YZqrW/9qemgj5kgYURKFFks+LHAhYGsSQhVp4K4giHR
 Ue6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692621948; x=1693226748;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pD1h1PuJN5SUyvg8jz3bO0gvW4qxvkXn4yHCAGRVyJ4=;
 b=Cn6N3aZ2R4l2zE945/L1Q+FQ5/aAfcerZmdgC1MtmKsVrFv3azlfZNjR5tYVRbX2bF
 fdW0Njqr2Za1NaOmK3Vq7fbIF3DaLUPxkhATl1h4pg8t3fTQkU/py9yjCC5CDx2Wlzz8
 1Xlejt8jpNfIIbuTc9MyRbZtIL20NDwGhFbvRXKvGvJJlp3LvxVjXnURCBbkQs+glRBQ
 ILweGZPOyJFheRhAiaj6eteVxhMAnY7tC4KzST4RFAe68aA9PbtRQRu7bNM9DP/0KP8X
 xS/JNM+lwhRUZePimexlnO3/wY6Coz+c/IOd5f5wxh6J+slAqdNo3BFCH6X9qKqAmRwO
 B/9Q==
X-Gm-Message-State: AOJu0YwUePNqI3a0BhyZKInaZ0PUMaiuGUfupV83tiHhXXihYnh1LSKP
 86qORAHG/e/+W8O37L9vUvsE/Q==
X-Google-Smtp-Source: AGHT+IHq3c6b+Mj8sldP6lpXsF/DvwYv4TXhXqyTv60+/P3eW/b6Uw8ZCpShsuzIRCQMrs6AZBr/zg==
X-Received: by 2002:a1c:7908:0:b0:3fe:22a9:907 with SMTP id
 l8-20020a1c7908000000b003fe22a90907mr4783087wme.20.1692621948512; 
 Mon, 21 Aug 2023 05:45:48 -0700 (PDT)
Received: from [192.168.69.115] (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 x9-20020adfffc9000000b00319756d5b80sm12533767wrs.29.2023.08.21.05.45.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 05:45:48 -0700 (PDT)
Message-ID: <fec23d98-4257-b2ee-382f-6793793558d6@linaro.org>
Date: Mon, 21 Aug 2023 14:45:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 03/18] target/s390x: Use clmul_8* routines
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, ardb@kernel.org
References: <20230819010218.192706-1-richard.henderson@linaro.org>
 <20230819010218.192706-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230819010218.192706-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
> Use generic routines for 8-bit carry-less multiply.
> Remove our local version of galois_multiply8.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/vec_int_helper.c | 32 ++++++++++++++++++++++++++++---
>   1 file changed, 29 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


