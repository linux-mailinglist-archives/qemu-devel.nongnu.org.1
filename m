Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D22AF7A04AC
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 15:00:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qglw6-00057H-2J; Thu, 14 Sep 2023 08:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qglw3-0004ys-2J
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 08:59:07 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qglw0-0004c7-9g
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 08:59:06 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-99bf3f59905so129313166b.3
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 05:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694696342; x=1695301142; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p+NuhSF3Le8Nq+uO4lmcd8s14RzjPJKNocPiNse4GfY=;
 b=e0YQ09EGXDnHyphLVXMBry1PB9DCXpx8ODkdptDZpafjKLdVy5nL6jAnlPpKyYWUIq
 dTn1jdLyEgN8BZoI4gy743xpuF5DPrPUSkWFklwdfSr+w9hvmA6wVw7NuOmZ1er/onPN
 VvRehSelXtR8jzhqqjUU8AB32VL+8kE1J28tMNmm6mYbgCCXhWuIM8XHQCoPEunH1jZo
 lNUgqJ7QKiovpVt15cZwhAjCqs/Qys7YZvQYWKnhaZm0IUgbUqbb0VzVRvB72d2pXn5q
 vxqoONOhKjNi+4B0lQ4FFawrCk6FsVavXtbkHhvdlMMl+7qeKshmq1yUcR4WdyWDEt3R
 rdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694696342; x=1695301142;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p+NuhSF3Le8Nq+uO4lmcd8s14RzjPJKNocPiNse4GfY=;
 b=Otdi1AymOIqb+rE6j5ov/5vidZvO7IYrTObdPtEqFJAkeR2Q7vEcdKGLLGIFD4S0NZ
 Bjaa5fOE085E8+h6lniDhB7ACbDcbDTqwgjLexsz0v+XOs+atZ60+U9iTbCyaUA+rNAy
 0tp/2WdFFl+kgdHAS+bqhMRWR7PW3fqY9t4VczRsD176n0hDLszEEMIUn1H5bR8A5b5n
 UQe/yEv5oLyF2H+2a1gPXHRRyAZvrCtVr1ncEJAgkrKLvXexpsIAzmaBrYjyLLaCr8I7
 hRFmYGz7I7cnJ3ehwQbupO10ncifESQEjuQuGHHaVBuBcSJcI85CBizSiZbWXeH4fUQR
 /S4A==
X-Gm-Message-State: AOJu0Yxw5mMrQLZNdjBT+6oRghO2E9bkAcvxlA+CKdnZIdqbuiXAYeiy
 QE1V7io99daicb5a4I4yuubMrQ==
X-Google-Smtp-Source: AGHT+IFLQB0gT62qEeBCUqSk+iZE7oD3Zr7sPqQi/66Ycz16e7gDvo3vDLmqkVpZltcy7PqU36+0OQ==
X-Received: by 2002:a17:906:76d2:b0:9a9:ef41:e5a6 with SMTP id
 q18-20020a17090676d200b009a9ef41e5a6mr4727155ejn.1.1694696342623; 
 Thu, 14 Sep 2023 05:59:02 -0700 (PDT)
Received: from [192.168.69.115] (176-131-223-129.abo.bbox.fr.
 [176.131.223.129]) by smtp.gmail.com with ESMTPSA id
 cw17-20020a170906c79100b009a1a5a7ebacsm966109ejb.201.2023.09.14.05.59.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 05:59:02 -0700 (PDT)
Message-ID: <15f6d627-b88a-f6a0-abb8-70ec5198fd45@linaro.org>
Date: Thu, 14 Sep 2023 14:59:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] hw/cxl: Fix out of bound array access
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, Dmitry Frolov <frolov@swemel.ru>,
 jonathan.cameron@huawei.com, fan.ni@samsung.com, qemu-devel@nongnu.org
Cc: sdl.qemu@linuxtesting.org, qemu-stable <qemu-stable@nongnu.org>
References: <20230913101055.754709-1-frolov@swemel.ru>
 <fb3f6b07-3310-f008-a512-1d155e21c024@tls.msk.ru>
 <79f03e2f-4cc9-fd44-1101-0dd8a398ff42@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <79f03e2f-4cc9-fd44-1101-0dd8a398ff42@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 14/9/23 14:38, Michael Tokarev wrote:
> 14.09.2023 15:37, Michael Tokarev:
>> 13.09.2023 13:10, Dmitry Frolov wrote:
>>> According to cxl_interleave_ways_enc(),
>>> fw->num_targets is allowed to be up to 16.
>>> This also corresponds to CXL specs.
>>> So, the fw->target_hbs[] array is iterated from 0 to 15.
>>> But it is staticaly declared of length 8.
>>> Thus, out of bound array access may occur.
>>>
>>> Fixes: c28db9e000 ("hw/pci-bridge: Make PCIe and CXL PXB Devices 
>>> inherit from TYPE_PXB_DEV")
>>>
>>> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
>>
>> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
>> (with the extra empty line removed :)
> 
> Also,
> 
> Cc: qemu-stable@nongnu.org
> 
> for stable-8.1.

[not related to this particular patch]

Maybe this can help if we specify the releases range as a comment
in the Cc tag, for example here:

Cc: qemu-stable@nongnu.org # v8.1

and if it were a range:

Cc: qemu-stable@nongnu.org # v6.2 to v8.0

Michael would that help? If so feel free to modify
docs/devel/stable-process.rst :)

Regards,

Phil.

