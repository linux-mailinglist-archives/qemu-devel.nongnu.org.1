Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E367FF938
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 19:22:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8lea-0006KF-Bh; Thu, 30 Nov 2023 13:20:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r8leY-0006K3-3x
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 13:20:46 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r8leK-0000oM-Go
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 13:20:45 -0500
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6d84ddd642fso756225a34.0
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 10:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701368424; x=1701973224; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lG+NiaU9ibgpEnaF0F2WIF+4GPkWbMKgIsMRhjaIPYA=;
 b=AvzKp8/3OQWXhUomvl9yAyEiHLF6SEgUgwlbi5GCkpx6rBAVPn6SrpteEy4ySTmEf6
 Hht2CtM6K3ufRzli97Jqk1rYp6eJnt9b17pcCy7txgTHsT9cmdePBn4yb4A3EoGOwHe4
 XzkaImpxVMU6C2ar+dl9ehhT+nGRXnZ6AQncgXfhIU1ihzUa6Kif0HIb5WvbdaCqj02U
 BfLJY1AwjN5l4gcPDsYKcmQyvN91UP2IFWhUOysVyjXj7sxxIq9XMlDygrYcOXOEf20Q
 O5Ihk5UG0NFZFvic6YBibi+aTVBnqPD79wdMbvm9DWGuaIzBp6oatvOb87Y6fbk+FtMH
 YOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701368424; x=1701973224;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lG+NiaU9ibgpEnaF0F2WIF+4GPkWbMKgIsMRhjaIPYA=;
 b=K0oTe+MaqASXoaqfy4mpoG17d/6szskprFnh5HclJvoRkiHoih49YMq8Hd/hJFPIF2
 4JiLnJJW/zlX44BAJ34t31ODW3vME2j+Jof50EZe1piFeE0mzcxtrXVAztY9p9YMKmtS
 MrP4okrldKA8SvHQRwCXjlgf8uiN3SDnLh6kdrVST/KQW2vZiR57A/caoQycpwHOtqW9
 mMQ5jOqE7tzv45jaMN05jGTfsKRZJPSwFh1Z4mcy1qpzhJ31ig7l5kcOQ3s3Bwec+DnD
 FtGzKDOUcN/U/BfkZ6C2A4KzFEFbr+ds91EXQ3tBeWRHW7/2nOxi70SVNUGR0sloNGjq
 BDAA==
X-Gm-Message-State: AOJu0YyEI/kGpatsXyy88IQ+Z8EkSB+NxSKvh5fZ8jLjlVR1B6tN/TVb
 RbSzl2okOmuvtYdCfMIrEq3NZw==
X-Google-Smtp-Source: AGHT+IFxCurO0HJzmXAYqLHyKitYgwJqUWgGdFF0S9DPYPDYDOdqhvEDtxbf4GLc1NgyATDmfnGNtA==
X-Received: by 2002:a05:6870:b155:b0:1fa:e1b0:ce25 with SMTP id
 a21-20020a056870b15500b001fae1b0ce25mr293008oal.8.1701368423983; 
 Thu, 30 Nov 2023 10:20:23 -0800 (PST)
Received: from ?IPV6:2607:fb90:f2e0:8450:be70:af46:b71a:41bf?
 ([2607:fb90:f2e0:8450:be70:af46:b71a:41bf])
 by smtp.gmail.com with ESMTPSA id
 fz26-20020a056870ed9a00b001f9e3731545sm375303oab.11.2023.11.30.10.20.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Nov 2023 10:20:23 -0800 (PST)
Message-ID: <55e34cbe-9bf3-40f1-aab9-12bf73287467@linaro.org>
Date: Thu, 30 Nov 2023 12:20:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/tcg/xtensa: add icount/ibreak priority test
Content-Language: en-US
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20231130171920.3798954-1-jcmvbkbc@gmail.com>
 <20231130171920.3798954-3-jcmvbkbc@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231130171920.3798954-3-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 11/30/23 11:19, Max Filippov wrote:
> When icount and ibreak exceptions are due to happen on the same address
> icount has higher precedence.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>   tests/tcg/xtensa/test_break.S | 25 ++++++++++++++++++++++++-
>   1 file changed, 24 insertions(+), 1 deletion(-)


Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

