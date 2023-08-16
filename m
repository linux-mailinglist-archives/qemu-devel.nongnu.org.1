Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9409577EBF9
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 23:38:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWOCa-000628-GF; Wed, 16 Aug 2023 17:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWOCU-0005yY-O2
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 17:37:10 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWOCQ-0007LV-PR
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 17:37:08 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-99357737980so928526566b.2
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 14:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692221825; x=1692826625;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VZsPmh3euSheMWIDgUIopUjXqOluereIHAZc7FTWXy8=;
 b=QwmjxkaBuwO0Kpu97iAiO2wCF/vYSZ1sN5rHPr/8PITRM/83qjbfw8EXhZ/EtLf+Bo
 Iwo7YHEXBB1iu6d6ENkWmLuNSxldYZaWmXKPSPT139sSozkM4etH07lrmG+KQOx0Yg2S
 QTp0Rc2GMh7a9PfTSGNdT7OJh1gnYYcfbgl689l0Rx1EpZ9t61apoSzYmpWKF53Zelxx
 SkgFgV3d4nYtBbTqB3ymuSGxjsQ4uDD/S6d9VFvoRe0xQ9L7Y5hTulJVMLsidkbvDpDk
 wZF3BFYQ3+NiiLuWKp6V3WnMpJVrcLw1r5AwbsEWbbPn42euwFJW0/MKZjlXx0bSQbNU
 jWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692221825; x=1692826625;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VZsPmh3euSheMWIDgUIopUjXqOluereIHAZc7FTWXy8=;
 b=bz9OWfLTwdfVThRLn0kj2EtlTtXQsdBaTYLA/mvh+vsVPUHVog/uQelu/tbubLRUh4
 zAmX48SG8pRMAd3yMsSemQwVBiRbMXGKnNHPwCWxDDjarg1e9PxnOwJRSZrcF6FK/V2Q
 RANSQFU2AjHduob3ugG7ahasUCTkTLpe49nRP+BxoWN+a15u/67XKahasoplYRU4he92
 GEZHdcMCpIWeFKVqpm3ybQOZEWc4WC2u+2RF1kBCapMnC++W9jVcPzVFDAxmWMsq2oWk
 74X8FQapWvtrALF1pG9xzWIqtPg0Im0QnDN9oKTP4qA/B3uijMMw0hhzPRU5goIHSX0/
 colg==
X-Gm-Message-State: AOJu0Yzhc8U4hzf+kKPBLMeK/lbBYTOrFg30301mfg/L+8d+fr9wAoJk
 2RQfI1eOQoyM06BpYNKwbKp06Q==
X-Google-Smtp-Source: AGHT+IFaW7rWI4lq8CA2OKUG6SU0qrzdOVUAc2yyRSoCL1ekt8HWqSwFS5ccoaYYlwAeQaXvSr9XYQ==
X-Received: by 2002:a17:907:7709:b0:993:d47f:3c84 with SMTP id
 kw9-20020a170907770900b00993d47f3c84mr2873316ejc.7.1692221825134; 
 Wed, 16 Aug 2023 14:37:05 -0700 (PDT)
Received: from [192.168.69.115] (mna75-h02-176-184-40-35.dsl.sta.abo.bbox.fr.
 [176.184.40.35]) by smtp.gmail.com with ESMTPSA id
 ks19-20020a170906f85300b0098733a40bb7sm9087018ejb.155.2023.08.16.14.37.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Aug 2023 14:37:04 -0700 (PDT)
Message-ID: <8fdd9ed6-64aa-c4f3-6136-3363193f200b@linaro.org>
Date: Wed, 16 Aug 2023 23:37:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 2/4] util/cpuinfo-aarch64: Add CPUINFO_BTI
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20230816142516.469743-1-richard.henderson@linaro.org>
 <20230816142516.469743-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230816142516.469743-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.165,
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

On 16/8/23 16:25, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   host/include/aarch64/host/cpuinfo.h | 1 +
>   util/cpuinfo-aarch64.c              | 4 ++++
>   2 files changed, 5 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


