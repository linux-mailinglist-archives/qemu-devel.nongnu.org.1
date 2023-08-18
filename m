Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBC0780F1F
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 17:26:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX1MV-0007JP-LV; Fri, 18 Aug 2023 11:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX1MF-0007Iw-Rz
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:25:52 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX1MB-0003gZ-I7
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:25:50 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1bc5acc627dso7932085ad.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 08:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692372346; x=1692977146;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V+eItDmmvJWZ889dzwIBmPsDCxE3Rw/GR1w8s09KPm0=;
 b=IDkout1LkzJrBwl1DpbuqA3DFD9U1dY5sslzH2tCW5SG8zh/M4lDcP/UXGEkNmWuuu
 pJYTYilDfiEPuZaazOolddJUcnOh0tirxFJU/JKtbi/FlbjgSuCulDJcMsjNgzDGMZYm
 OxXsw1S1h1lCgW9Jw62Lj2R+s1AfL8WsFFzGCidnGCx/dYe0bm2s7WxqgLOLpxBBvsvs
 L+mqHzBR3UWgEd5K3Q8xo0beAzpkDufnzczS+tnWvkS3x1s48b/+NRisLLpIUAr+BdQE
 wEeviFTBGGEiXsxNonouxAIlYK6CZMhW+vSPT+AN8hM9aMJn1pv2ufxGPHq7wQvgi3fj
 88Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692372346; x=1692977146;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V+eItDmmvJWZ889dzwIBmPsDCxE3Rw/GR1w8s09KPm0=;
 b=BR5rV5I6QZVBbTJTXTQiP7O0/1gKvjThX7y801nLLR/7HlrG5LO7+MdBm+jilQQyRr
 XIM+SSSEu0iIDH/SCrAqOCtlY4yLFtljPgdPUiXYg1dJsOQrScfeZgNPeOIhughJYJp1
 PRXvVAgBRo3mozK1sBVjnZYP4FFVduSRIMT8EP2VYqzIAgMOTlNGuaIr/WJv6pWkujcr
 VggdNv3gfPf62CCPrPP3hSp2/d0HxJqjEih16vEVgmBACNAMXrqZdqJ3/+gkQNigFIs+
 0UMXPlmukwHEX8JmGu4AcEaOqyONoOjbbaCy3zRJhKzUz5N6OV7EYtZUXqzIU5FMRcZD
 Kwxw==
X-Gm-Message-State: AOJu0Yzw90NZjSEcj8UGVk3gGuPcvDsbNbArZcYpzszOSRxQVg1iUup5
 j8ZFGtvp0oJz4MPwdruzAr4ytw==
X-Google-Smtp-Source: AGHT+IEVVAtlY4g/cEsEZudjRNsYrHjAXUAF3bBwZQTkQS5wLMCcrlbsoC3SoohiU8znY0uelAKJrw==
X-Received: by 2002:a17:903:2306:b0:1b8:a720:f513 with SMTP id
 d6-20020a170903230600b001b8a720f513mr3679666plh.30.1692372345766; 
 Fri, 18 Aug 2023 08:25:45 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:cf24:6daf:2b9e:7972?
 ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 j13-20020a170902c3cd00b001bb9b5e86b7sm1914267plj.91.2023.08.18.08.25.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Aug 2023 08:25:45 -0700 (PDT)
Message-ID: <b03c7041-83c1-3a79-da4e-a2a5fd523c22@linaro.org>
Date: Fri, 18 Aug 2023 08:25:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 08/18] target/loongarch: Truncate high 32 bits of
 address in VA32 mode
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: c@jia.je, maobibo@loongson.cn, yangxiaojuan@loongson.cn,
 yijun@loongson.cn, shenjinyang@loongson.cn
References: <20230817093121.1053890-1-gaosong@loongson.cn>
 <20230817093121.1053890-9-gaosong@loongson.cn>
 <095e6d5a-a19d-abc0-4a9a-d23dddd33755@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <095e6d5a-a19d-abc0-4a9a-d23dddd33755@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.454,
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

On 8/18/23 02:41, Philippe Mathieu-Daudé wrote:
>> +static inline void set_pc(CPULoongArchState *env, uint64_t value)
>> +{
>> +    if (is_va32(env)) {
>> +        env->pc = (uint32_t)value;
> 
> That would become loongarch32_cpu_set_pc().
> 
>> +    } else {
>> +        env->pc = value;
> 
> This is the current loongarch_cpu_set_pc().

No, it would not.  LA64 has a 32-bit address mode, much like MIPS, Power, and others.


r~

