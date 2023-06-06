Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 267ED725029
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 00:50:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6fVI-00082z-II; Tue, 06 Jun 2023 18:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6fVG-00082X-DC
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 18:50:14 -0400
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6fVE-0002id-GX
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 18:50:14 -0400
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-33b1da9a8acso1317305ab.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 15:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686091811; x=1688683811;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nM6O12g6TizGQOEtVMbmIHoScoGK2YgQ959ZR0ukAKI=;
 b=rNunSLH1Wt8Ez1HCDKnh+1RDcJNClMANrcPpalmS6uR2Xf6jNFGgwoOqVuXBrhjMV+
 sN1BqTl6CW8qOHJ6goNCOAZ5KQKE+q8BqEG7YymFxVzTMEEP74VDrq8Lu01YzKRW36D8
 Sf9qJ1rb2bhuBpe61ZUIjau36wAv0SKS1fIQdv+XKIE9n48fA7/0169IOnFaf7nAacEb
 XRUqML8qQJkqvfBJv2dp7/7KyhgFNrXEaEOzVL3UbtVB7pc11ofVA3+2fPRNackYetI3
 hTlvh327nyCc9SZjy/W6wbYkbsGg+WRliqNf2aWby4PT0pJETZYkfPIAgSVpc+pKBNpm
 L7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686091811; x=1688683811;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nM6O12g6TizGQOEtVMbmIHoScoGK2YgQ959ZR0ukAKI=;
 b=icRp50gL9kYZVrXUMQnfk+Tx1NvL+N3JYGvlQIMn4vkDZ+TFhhOcCcqrgWMZppiz4Q
 A9mkkAqB065wgIci/qfbgozpB1nNQNOaPD7cjKvYMEeVpqaWzha1DngWrzf8SnbmKPXf
 FROq3aM8GKxCAnhGY/twm6Hio1dDGr0BFzS82JmgroOuNnkFJWeksKPdVtDoMOHZ6TVd
 gXbcxHNr3MHJDXN4e386mV02ASA8LppGwMG6LWbzxrTgZV/hmk3CWVWRPihWk8EWaV0E
 iCMd+voGqSEvn0fgsx7QoEiWyFP50eN0D+IxCQ9qQiW0W9fcJkiTolotuQDKNtjgFfvN
 K9uQ==
X-Gm-Message-State: AC+VfDx1svLwwsY1Zhi/8ojUTVX1McaP/NUwiYX4OIoIuu3M3LDACUhA
 Xb9EuRDvf+UWnqpQ4SMfYDoZ7w==
X-Google-Smtp-Source: ACHHUZ5LKWy8Ndotva50+xhjCUqFNenhCUi1y9isrQ27U4JOirze+mxJkWnT3ueHRyJvKqEMPIBDMw==
X-Received: by 2002:a92:c505:0:b0:338:f770:ccc3 with SMTP id
 r5-20020a92c505000000b00338f770ccc3mr4650985ilg.21.1686091810859; 
 Tue, 06 Jun 2023 15:50:10 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:b7fa:ce59:1445:805a?
 ([2602:ae:1598:4c01:b7fa:ce59:1445:805a])
 by smtp.gmail.com with ESMTPSA id
 x23-20020a62fb17000000b0064fe06fe712sm7256548pfm.129.2023.06.06.15.50.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 15:50:10 -0700 (PDT)
Message-ID: <7465b3c6-ecf9-bf17-2504-2338bbef27b7@linaro.org>
Date: Tue, 6 Jun 2023 15:50:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL v3 0/10] xenpvh3-tag
Content-Language: en-US
To: "Garhwal, Vikram" <vikram.garhwal@amd.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <alpine.DEB.2.22.394.2305021708010.974517@ubuntu-linux-20-04-desktop>
 <a01d5ddf-b6b3-7fc7-daef-44debf48ca77@linaro.org>
 <1f6b3666-fc7e-083a-50fb-b2e91ac2c012@amd.com>
 <dd7325e0-7db1-3b1f-7ce1-319aa58ebd1f@linaro.org>
 <MN2PR12MB440877291659B9B55ADC0CF79F52A@MN2PR12MB4408.namprd12.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <MN2PR12MB440877291659B9B55ADC0CF79F52A@MN2PR12MB4408.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::129;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x129.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 6/6/23 11:51, Garhwal, Vikram wrote:
> Hi Richard,
> 
> I fixed the tsan-build issue but now seeing another issue with “—disable-tcg” option for 
> cross builds xen. Here is the build failure message:
> "include/tcg/oversized-guest.h:10:10: fatal error: tcg-target-reg-bits.h: No such file or 
> directory
> 
> 10 | #include "tcg-target-reg-bits.h”
> 
> 
> 
> Full log for build fail: https://gitlab.com/Vikram.garhwal/qemu-ioreq/-/jobs/4416773231 
> <https://gitlab.com/Vikram.garhwal/qemu-ioreq/-/jobs/4416773231>.
> 
> This is my last patch which enables xen build for ARM: 
> https://gitlab.com/Vikram.garhwal/qemu-ioreq/-/commit/6f6667217bfc14ff5504ee5fdee23a948d60fb7f <https://gitlab.com/Vikram.garhwal/qemu-ioreq/-/commit/6f6667217bfc14ff5504ee5fdee23a948d60fb7f>.
> 
> This seems something missing in disable-tcg config for ARM builds. Any hints on what might 
> be causing this TCG issue?
> 
> Thanks in advance for your help!

I meant to cc you, but fix here:

https://patchew.org/QEMU/20230606224609.208550-1-richard.henderson@linaro.org/


r~

