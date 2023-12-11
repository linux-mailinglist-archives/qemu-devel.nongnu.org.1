Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A3F80D905
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 19:50:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rClLG-0007sx-Ns; Mon, 11 Dec 2023 13:49:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rClLD-0007s8-S9
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 13:49:20 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rClLA-0001yG-Re
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 13:49:19 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d307cf18fdso7967875ad.3
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 10:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702320551; x=1702925351; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MHZbE015AUtA7YmXpmIoLETCcKzfCXQMdDw/dg4RUec=;
 b=ZGqi/NDAFTH0pCgCCi3aeqCZ0ipQB2kRkA4kpwzMoy4ukeqAqtZh2LFhcIf3Zq2NiL
 k8n+Gn5AT8/EgYLYDnCHwwyoZXc9niWXWiZi8RbNcCwZh4nVr6nylw9r9AGG6wbZpbo5
 VFyXQuYSsb/HikuJLenrmd/1I8IPdL3zEv4nR/tS7bjDPWCdTM5f9Uh3XRqw3Zqcfv2Z
 xvYfYnDoD0BHXySARVG9CbBDeW6N+7+3v99Iwl49JJfEXd+czbOXWFyhDpmHGjqqZhGH
 RJ8hu/byyOc4lo/Zle7GmfJ687yxKltOgxtIQ4H02GbNd6xLuxUNRHIJhyQUXxuyctgF
 4KPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702320551; x=1702925351;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MHZbE015AUtA7YmXpmIoLETCcKzfCXQMdDw/dg4RUec=;
 b=Yh/XTEaxT8qmzfvjUNm0xnZwJykS8Z5b1XtlkBjITPdMEvhKDwrbs66u3nVIJOYMpZ
 JjpZvCKRlSKMB9RoqXbRGwntLf1U0UuviKmUZXQG0CGFW5PyuFMfhx2RIcwrq8y4dNLC
 DFkzlz4WmZMoO4hN9C+o9bna+cCnbnvDTeWaSlcUNc+nUuPdHMeWBXau5P7xPSmChQHE
 0kMskBcbJtvIjwC+KUoY0W/7JL1vJlecYwaHuSkhxW7pkRdxC75x1m++MNrnNQZtqE97
 SwA0cpyGCwOJy3/PqKmTe/zN4osw60oyc7/1UAOR9oYqWp2khQIksIzlI6bRcqTeaPFH
 mL1g==
X-Gm-Message-State: AOJu0YzCwTOtECDAdkHcOszV29Tie5gOtIatjQ8SbSTjfY+UNe778YmU
 4/v8o55UNuvJS6O1Uc/aD+5uUA==
X-Google-Smtp-Source: AGHT+IGcb1m8MKfZFRbNwziM1V8Amg2Y7JQjNoT3E6FMmH94wWMrizF2PhDan3tZMYvotNGHPw0Dwg==
X-Received: by 2002:a17:902:680b:b0:1d2:e6ed:934f with SMTP id
 h11-20020a170902680b00b001d2e6ed934fmr2251380plk.24.1702320551510; 
 Mon, 11 Dec 2023 10:49:11 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 bh12-20020a170902a98c00b001cfc3f73927sm6963465plb.9.2023.12.11.10.49.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 10:49:10 -0800 (PST)
Message-ID: <7dffe9e8-605f-4560-b872-f0783944bb6a@linaro.org>
Date: Mon, 11 Dec 2023 10:49:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] accel/tcg: Remove #ifdef TARGET_I386 from perf.c
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20231208003754.3688038-1-iii@linux.ibm.com>
 <20231208003754.3688038-4-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231208003754.3688038-4-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 12/7/23 16:35, Ilya Leoshkevich wrote:
> Preparation for moving perf.c to tcg/.
> 
> This affects only profiling guest code, which has code in a non-0 based
> segment, e.g., 16-bit code, which is not particularly important.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   accel/tcg/perf.c | 4 ----
>   1 file changed, 4 deletions(-)
> 


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

