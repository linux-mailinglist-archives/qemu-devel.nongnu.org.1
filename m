Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9627B2A12
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 03:06:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm1wF-0006sv-Jo; Thu, 28 Sep 2023 21:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qm1wD-0006sb-Bc
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 21:05:01 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qm1wB-0003na-Mn
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 21:05:01 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-690d9cda925so10902107b3a.3
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 18:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695949494; x=1696554294; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vSGMpOs0qaJ3qREHPLJ1FPZ05TeUVgqGZqkVLnZWgjo=;
 b=UWGyUF5aogwUTKW5MLXoAxENoT96kFHain1/hG1R6tcCo5CC7dKwH9gta5F6Vw8w56
 gaLQD3ls2lqsKBekXVLcWmQocMaYUd/nLAlS0wIRTfzMxx8auXvtB0glLWi+UTeEk722
 uN6+2HKhLqmzT+OzQVXfT6eBhDSf7NW8yqP7IsNw4hzgdHz5HTw88WaSrEMjzVXLGTxa
 IfrTtoGhCqWFhq1OiNzIv3sEI8fwb82OLqKjen3NUsUScXsolR4ovswD8IrOP/ywBwC8
 0gc9fTKsCuSW0DrLbJ0Yb7GexX7Xqez1hbdrMsaPAvYyVWW33RR42FPK2lsKrt3ctPxD
 J7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695949495; x=1696554295;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vSGMpOs0qaJ3qREHPLJ1FPZ05TeUVgqGZqkVLnZWgjo=;
 b=NdP99dakbOGhihhzf+20uiUfxuy6AbyzvGVxEq3xBoLEtuWkBB+Ibm3jGhl19z+1Y0
 nn5KC2hS3BKxsD+XTxlp3WsJC1sy2puuJCCLE0a5Rrf8FxQaPIHICKdsXr+fY/rbR2gu
 c+oRFKEh0TwkcpUMeOTx2Xw6Zg3jfgYqY0cn75zhB+yPtJF16fJpyMX5YuIs0M5jLaKj
 iucbmvCfS1cnPMxCHa2A2vuiS4+IeBL50g2+azOhnQBmr6sFPpum+DdByB3vZJSdYAg2
 T7MZra9YiaKCaigJagGAAr7MFaJKf6+9MmJZk+qYgw2w0jAjYBVaB0R9Ohv3T2H9NYds
 Nojg==
X-Gm-Message-State: AOJu0Yw/rMKSJbcX6VHE3m9me99AjqbBcDreeMFEWjHj55iuvjnZ9Rdo
 JqqMD9Q7EbBweiHkwvC1kgSMYw==
X-Google-Smtp-Source: AGHT+IHPL47cqCDAT9XGyG/F10WxJa1PHjiAyF5cpQX1fdIA5xNpcybEBXvJoMYueQKG+9oWKzlIAA==
X-Received: by 2002:a05:6a21:6da4:b0:14c:e4d9:de46 with SMTP id
 wl36-20020a056a216da400b0014ce4d9de46mr2250621pzb.39.1695949494604; 
 Thu, 28 Sep 2023 18:04:54 -0700 (PDT)
Received: from [192.168.0.4] (174-21-146-124.tukw.qwest.net. [174.21.146.124])
 by smtp.gmail.com with ESMTPSA id
 6-20020a17090a1a0600b00263dfe9b972sm226845pjk.0.2023.09.28.18.04.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Sep 2023 18:04:54 -0700 (PDT)
Message-ID: <4520374c-3b49-c0a5-d508-b18a1e33f697@linaro.org>
Date: Thu, 28 Sep 2023 18:04:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/8] target/sparc: Fix VIS fmul8x16au instruction.
To: Nick Bowler <nbowler@draconx.ca>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20230925050545.30912-1-nbowler@draconx.ca>
 <20230925050545.30912-3-nbowler@draconx.ca>
 <1cd9adb3-004c-7512-e587-085959296f03@linaro.org>
 <CADyTPEzpcKU3QXOQ7pSC_hkrD-BrhQ51K4WMCaYYgKuyfW09bw@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CADyTPEzpcKU3QXOQ7pSC_hkrD-BrhQ51K4WMCaYYgKuyfW09bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 9/28/23 17:41, Nick Bowler wrote:
> On 2023-09-28, Richard Henderson <richard.henderson@linaro.org> wrote:
>> Belated follow-up suggestion:
>>
>> -   if ((tmp & 0xff) > 0x7f) {
>> -       tmp += 0x100;
>> -   }
>> +   tmp += 0x80;
>>
>> 7 occurrences throughout vis_helper.c.
> 
> I agree with making this particular change but I think since it doesn't
> fix a bug, it should go in a separate patch.

Of course.  That's what I meant by followup.


r~

