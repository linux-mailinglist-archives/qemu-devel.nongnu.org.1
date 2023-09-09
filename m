Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE28D799BE6
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 00:22:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf6L7-0001mE-CX; Sat, 09 Sep 2023 18:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf6L5-0001ln-Rb
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 18:22:03 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf6L3-0005w8-Mo
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 18:22:03 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c1e3a4a06fso23810845ad.3
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 15:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694298120; x=1694902920; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EQAXj1zbDQgSRN7egvtjnUGtspPGafRAIdxvz3oe/d8=;
 b=kVC2jU6ikYB9j47HtVHmytpX2f/he9+ll3CWMXoYEm0iKHSoVHF/DC+l3rmKZTALJV
 ztEQLjEx+e3l9XWK1F4RWIHdreusmXYBBS9QfrjCRTRWr7PkHth9eJ5KsODUDzx43+J8
 SfE2tZVWYHbDYNV9ZpQ/0SGcNuiPwoqRKLwtxZYozRn9wBvvcZcbUpuhUrQy75hX8o6k
 Q0UVuk6TC6jRXUFEYDS41SZZALr8mkGUgvaAoTi2vxwQwYQxtIIlbA8bjgMOYycnwRjm
 pm0TDqqHADeYRuLqWOk0ZSAtSiBRyI4tpe/YdHnOcJOBAzdt7Ld143iNpmLY+JPy+nq8
 kqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694298120; x=1694902920;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EQAXj1zbDQgSRN7egvtjnUGtspPGafRAIdxvz3oe/d8=;
 b=ISsNpUAQZNR8a7Tn45j7DiljtK/41mt7jYpN17SyoJtBINu2cRVZvCyvSeHoVccBy3
 9Qs0kzelu5k9MBRafyI6b2ghgf4hvYXwBHR2W+mSr93h0w1dgDL0pRxYFIxCxANeqC9o
 Dfd8XwpYpUl04RI7MOr9OpsNfeGK4+k3gBSaLFgYys1sFyw9cr0Wn5NSf5AMDItQonx/
 fB3kudHfl7H0CGQi1FHzA8nF/lm6PXHOHSkEHVxI7IZ9ARjjcC5jUjeUqBnNcFqJw0d7
 chi4h4hZS/W8/9sv5m/cIzzADGQSQcPg9+mk2ySAhmhvdDIBN0Wx7DbMppy9MUgqnfMi
 UKIQ==
X-Gm-Message-State: AOJu0YyrYBWmW+aYbHTjvl/G9UhurNPTFDAFn76szDmUmQO293UA+SbK
 Hto4j7C5V0p3ydlAfKWC6sDQ4g==
X-Google-Smtp-Source: AGHT+IGPpQR29iALn764gr+zxT9R/LmVL3gKRc8SfY0z8oTXdexhmV+fGv6ywJ2gL0JxnYKFuYc+cw==
X-Received: by 2002:a17:902:7489:b0:1bb:25bd:d09c with SMTP id
 h9-20020a170902748900b001bb25bdd09cmr5383323pll.1.1694298120332; 
 Sat, 09 Sep 2023 15:22:00 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 t9-20020a1709028c8900b001bb9883714dsm3678233plo.143.2023.09.09.15.21.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 15:21:59 -0700 (PDT)
Message-ID: <9c7a4379-1aac-fad6-163d-34c506586ed6@linaro.org>
Date: Sat, 9 Sep 2023 15:21:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/4] hw/cpu: Introduce CPUClass::cpu_resolving_type field
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230908112235.75914-1-philmd@linaro.org>
 <20230908112235.75914-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230908112235.75914-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 9/8/23 04:22, Philippe Mathieu-Daudé wrote:
> Add a field to return the QOM type name of a CPU class.

It isn't the type name of the cpu class, it's the name of the base class that one 
particular use case expects.

I don't think this is a good idea.


r~

