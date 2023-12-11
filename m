Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A31B780DF7C
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 00:30:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCpiH-0003If-Oc; Mon, 11 Dec 2023 18:29:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rCpi9-0003IS-HX
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 18:29:17 -0500
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rCpi7-0001T0-MO
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 18:29:17 -0500
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-35d624b0415so21025795ab.2
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 15:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702337354; x=1702942154; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9LAgOCJzV1zKms2/puspUVIUxsQMmV3RKT+mTycpwmE=;
 b=NhRdIUG0HYy3SdfxC6IK/ya+VxfJ5nta/wERW1nho+1aoqEvDfy4oBz1Tnk3ONA1vV
 k25qt6A4u0KSxc+lKvHZq16CaCt9pXs5fvSfbh2/dHRd2/uS8c97QXFSC4H/HTwvdN/l
 QarhaR1i5nsAL7qtLye3o4sLZWcAR6dto3jkqYjyatP1LmXF2NsY1opp+IPPDP+nztQl
 xcMeIwEWnEOqCkXfVEdtbitC9EM3ZdEi7IhgM8Qh+/MQSugVWL3U0rrQIglaZdvetMgA
 IZMwFQmuGlu5a02Nzne6jPpZGBKqWVzhpzfzl8lGUMp0rRbACQcPcjwVwA0LPvafXgWV
 eEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702337354; x=1702942154;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9LAgOCJzV1zKms2/puspUVIUxsQMmV3RKT+mTycpwmE=;
 b=NDHZee+EjQxTXUdJh5nPwbAbI+Sohcv1QL5ZsOVSDlwUqN9uWT5VhdupbTMnmuUiwl
 4eZpvrptcitJLVNPl/wZkUlCNmp65mX9O6Dyxb5rNT36yoZY4dIXk0KApLUk5D2CjtrB
 GkFACdRbF3fNI5ykVH9w6hE5rh4Ydym62bHC59KWQmbH9E1xmExFQ5oLaIKPENLmMNJY
 d4ZXctSW5lTw9o7z9bAg1h/P+O3EZ0Buslq0i3s9X0iC5DMYeEYL7AA0LusFDwvGxg4E
 1f8iiSiEDZAP9BI3CUuoMV/TN7ZC7gJV9BsWewg84A3jCRN2bNeK9+znv1GTF8UoY0n6
 lJ5w==
X-Gm-Message-State: AOJu0YxcmyVjNm8EuktBM91iKztsY7cp5DNeJfZWMwj1fZBObj61nyUC
 ZkXwXUNydrau9OZ3cAnX8922PQ==
X-Google-Smtp-Source: AGHT+IF5gkYcZXyrMKC8qrzHP/XworVaf5sW5PaI9Q6S2U3dYap033PJXassQ29prnAnsZsjwXE/Kw==
X-Received: by 2002:a05:6e02:12ce:b0:35d:689b:de92 with SMTP id
 i14-20020a056e0212ce00b0035d689bde92mr9502289ilm.18.1702337353759; 
 Mon, 11 Dec 2023 15:29:13 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 n16-20020a170903111000b001d3320f6143sm365383plh.269.2023.12.11.15.29.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 15:29:13 -0800 (PST)
Message-ID: <89f702e5-2991-4423-be9e-1630af6c5134@linaro.org>
Date: Mon, 11 Dec 2023 15:29:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/24] exec/user: Do not include 'cpu.h' in 'abitypes.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231211212003.21686-1-philmd@linaro.org>
 <20231211212003.21686-20-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231211212003.21686-20-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::135;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x135.google.com
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

On 12/11/23 13:19, Philippe Mathieu-Daudé wrote:
> First, "exec/user/abitypes.h" is missing the following
> includes (they are included by "cpu.h"):
>   - "exec/target_long.h"
>   - "exec/cpu-all.h"
>   - "exec/tswap.h"
> Second, it only requires the definitions from "cpu-param.h",
> not the huge "cpu.h".
> 
> In order to avoid "cpu.h", pick the minimum required headers.
> 
> Assert this user-specific header is only included from user
> emulation.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Why is cpu-all.h required?


r~

