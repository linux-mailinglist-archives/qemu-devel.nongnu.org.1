Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5334A81F375
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 01:46:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIeWv-0006ga-Sl; Wed, 27 Dec 2023 19:45:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIeWa-0006dr-SS
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 19:45:25 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIeWZ-0006F9-Ap
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 19:45:24 -0500
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6dbf0561f8bso1559516a34.1
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 16:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703724322; x=1704329122; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=23Kb47gbskIVGHKopsn9npv8GdyP4mq+Lv1g1CusqYE=;
 b=BGdPZ2f+kjfFIuenVM0IGzT3piuun1FdrAiYd/LpCY5lswLvbgnvkQmS2rL+00dB56
 qb5Ks1C23Uz5JQzpO7Fr9LOBrQQut3lSL+Ob7B5mqHRt/wkOFj5pyF62zUvWZ0HOUH1T
 ODC/w+Q/O8uurubq/QDJs2QG8u4jiZ3Rgc12pNzWvRSzJz7Aomh8tUcje57Yf67YqGug
 otzL+iI6EUNkLzuOP+uNYyYg1QPADAiklca3ds4jezBlRAb9HAZ9YlK7ZlW3sle+QZHq
 Ywrhid3MbV13LeJW2F6rZztDX46wfobzvjUVmL+HTneKvRZw5jApeye+KdEDBuRLJgcn
 Ob6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703724322; x=1704329122;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=23Kb47gbskIVGHKopsn9npv8GdyP4mq+Lv1g1CusqYE=;
 b=fvy3Ht/UiDa4tvvG3LxGcwquxg5JWuRNMmeEZPofN6v04M0WL5WFhXYaZ5BcA9xwsN
 qzRHAG3Mk5r5HOGUX3+GF448ByMXL/PUjwCD22IepmTkCZicmnEs27zX6Y9BmG62QX5e
 zmLh5/5JerscoynG8EoqL10XTi9S86eskBlI00YJxphwcmCliwxGG5aRsCIAABbl0138
 j2zAZyQuBoo2q8jq4eQniqmuqYPN/JyqR5Qnya6rJNFfpgOWeiI+TpdYktwaV9X/7IvX
 iAkhyoLr5JM+BjDSWMXcGvhjLFVQDaowvYIXnHmk/fFXK42U4C7m1vGdktZIxkqjCncn
 8z9A==
X-Gm-Message-State: AOJu0YzWnjW9cCfpU1TYUatBaUabSrfZ2La1oFvdwidVzTBu31ilxKXR
 vBajSpal47I/brVWyUpKzPZAcKdHDPnc+A==
X-Google-Smtp-Source: AGHT+IEdlDlviY4aVQFh7ftXaQecloGKrCISP+C96rgUI3URw9LM8AdSC5+y8H7otRTkBX82n55J3w==
X-Received: by 2002:a9d:6c99:0:b0:6dc:143d:4a2d with SMTP id
 c25-20020a9d6c99000000b006dc143d4a2dmr304631otr.16.1703724322140; 
 Wed, 27 Dec 2023 16:45:22 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:12c1:9684:874a:fb3a?
 ([2001:8003:c020:6900:12c1:9684:874a:fb3a])
 by smtp.gmail.com with ESMTPSA id
 r18-20020a63e512000000b005b9288d51f0sm12044956pgh.48.2023.12.27.16.45.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 16:45:21 -0800 (PST)
Message-ID: <6d586de7-90ee-4a41-bed9-51c3603a1673@linaro.org>
Date: Thu, 28 Dec 2023 11:45:16 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/35] target/arm: Mark up VNCR offsets (offsets
 0x168..0x1f8)
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
 <20231218113305.2511480-31-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231218113305.2511480-31-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 12/18/23 22:33, Peter Maydell wrote:
> Mark up the cpreginfo structs to indicate offsets for system
> registers from VNCR_EL2, as defined in table D8-66 in rule R_CSRPQ in
> the Arm ARM.  This commit covers offsets 0x168 to 0x1f8.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

