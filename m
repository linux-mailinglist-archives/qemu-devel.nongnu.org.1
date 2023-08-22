Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A347E784BC1
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 23:02:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYYV3-0001c0-07; Tue, 22 Aug 2023 17:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYYUO-0001Ww-7S
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 17:00:36 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYYUJ-0001vM-HR
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 17:00:34 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bf55a81eeaso21362885ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 14:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692738028; x=1693342828;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NG9qe/IwC9AH5QGOSFN6JBEq8U38bU0YfV3QgAnrpv8=;
 b=XnCP60ToZk93xDWVjT1t1DoGVn4rGkuY+rFIje4hSPpsALHmZH+ta7HaDUFEPZDAGB
 rjaVESP5UfWhtE8uPWcvO2HL4E3bWmg8KsCJthVGvjFog+uiAiSnB4Yv+qkMycIAkpVf
 jSK0PtSDupFXFD+PCW8CvU1HPZwipyc9WTM41DW5y5CuESB2H07T3wzqxNg7cjuN19b5
 RlTjZ6zdAX0aRc3rHBs1QTRelIQ7YQVC4WsDK/slkUXHux6mcLvfvs7bp/g/8LhNNfWH
 Urv3lR3MZPxeKcuCoA5h+x8A8F6LnhhPhcddKGNLAN/LSUJl1M+X2gldNV8m1WYFpPoA
 0BJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692738028; x=1693342828;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NG9qe/IwC9AH5QGOSFN6JBEq8U38bU0YfV3QgAnrpv8=;
 b=APDR2spDccfZ5mbhYztygHWTXmLBVQKpRZh0mP9RNOhZ2+l/OJ5mu7cHxn51MX+/i7
 WeMjzJlAs3lQunUaywngVK1tAtXUKY9jX3KQuZyJZwhezgnH0gEh/0f7FnRWSTWlhi6J
 /ERRg8DGx32Z3N3077/V3FoJQPZRvo/42Jrwzp27Iw57JWarr6VvaxYbWInIyL/X4lfw
 aLjGuUFLZ4xLl4glCAqPNdWVSpAuCIx0jFIG+Zw/tL4pmCp1K3UqpVMNpPYXrPGT6nBe
 4pNvbbnd+e5EKk5739R8UayASkEX/9Kyo4fK1/rMzJ89manVOB9D6HRG+BnIJmCCrnIR
 BEBQ==
X-Gm-Message-State: AOJu0Yy2AoSZiCYdBBZrcKvWlCurBrY9vvFN4PJnmN/tDD9pwkrSZNfC
 HnWUkuX7bsP2koeWvanY0AOhSw==
X-Google-Smtp-Source: AGHT+IHMI8AuC8mPuloeE8ZF2sxPtJtYpoJ8yMUUPUYgaUf7VuacfmjKm35GxGMzn01d6/X9H9J+Vw==
X-Received: by 2002:a17:902:d2c6:b0:1bf:1052:f28f with SMTP id
 n6-20020a170902d2c600b001bf1052f28fmr9468914plc.52.1692738028486; 
 Tue, 22 Aug 2023 14:00:28 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:4e3c:f4a4:b92a:b5ab?
 ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 q6-20020a170902a3c600b001b89045ff03sm9592433plb.233.2023.08.22.14.00.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 14:00:28 -0700 (PDT)
Message-ID: <0c8347bf-7865-88b7-7c84-584a924b57ac@linaro.org>
Date: Tue, 22 Aug 2023 14:00:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 21/22] Implement shmat(2) and shmdt(2)
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>
Cc: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org,
 Stacey Son <sson@freebsd.org>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-22-kariem.taha2.7@gmail.com>
 <eb0506c6-f9bd-5a1f-870b-b6d07dd337ea@linaro.org>
 <CANCZdfrmw6c9kxFTUrWegaU78SHBjqVMEHuO8VVsPN=7hGQb0Q@mail.gmail.com>
 <c7dbf551-f833-c5e3-302e-fcea2d411bb5@linaro.org>
 <CANCZdfpROK+m4B3-0NiN4uwpV+4pUd7dWwec-_f5_VWNjwpEKg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CANCZdfpROK+m4B3-0NiN4uwpV+4pUd7dWwec-_f5_VWNjwpEKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.767,
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

On 8/22/23 12:54, Warner Losh wrote:
> As a practical matter, they both consume about the same resources until the MAP_ANON
> region starts to get populated with data...
> 
> With PROT_NONE, I think they would have the same effect. If it is to be a backing store for
> something like malloc, then MAP_ANON would be best. If you are replacing it with a lot of
> things, like a mix of files, devices and/or anon memory, then MAP_GUARD and replace it
> with MAP_FIXED later. Most likely you'll want MAP_GUARD to reserve the area, and then
> MAP_FIXED to use it for mmap'd memory, shared memory, executable pages, etc.
> 
> Does that tell you what you need to know?

Yes.

The reserved_va area is replaced with a mix of files, anon, etc, based on whatever the 
guest requires.  So it might be reasonable to adjust bsd-user/mmap.c to use MAP_GUARD for 
managing the reserved_va area instead of MAP_ANON.  No rush, of course.


r~

