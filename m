Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CF2766FC2
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 16:47:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPORt-0002w4-PG; Fri, 28 Jul 2023 10:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPORr-0002vc-Vo
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 10:28:08 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPORq-0006yK-79
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 10:28:07 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bbd2761f1bso17199985ad.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 07:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690554484; x=1691159284;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VaCH+5qTDr0pJ887otRLgow+BGNKBhf92uhY/02eHfE=;
 b=n8qh8W52OT8DSom9GjrGYGXAT/Uy0m+U7rQvVfAnd0UVpXjQ5zisdGjNDn/sX3p9kE
 IvLHjgLfEgCVT9BrSh13HbelvWBDATmu0XbaSkNvcG6Dsr+s91sIjhtwtsnIKUrpU3VY
 4CYSp3xiq8WmtgX/pU8Z4voTQyQj3oTdHX+Jf3Z4NZxmGI6ddP87NhPcu/iCvNRrh6mD
 5aIPKor0Cq37L8HXhwRGFMQZVF9XneZaRrnEdY7h+3oIMt2jWDiWZRjYK6nTF+ZAMEAe
 ACBYvh0GcJgcAeXzahSBmPTM9p3d39B3GeqzfTYOQtqkGKI90CIK/h2/IVSk6aP9q2ld
 WMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690554484; x=1691159284;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VaCH+5qTDr0pJ887otRLgow+BGNKBhf92uhY/02eHfE=;
 b=D98vLS+aCZUvkJiW25YfUTQycnUKlxsBNhqst4W3QJMQIXFu5WMDBtyHlThYpkzh1g
 UxijNzGEDjpCxMb3DlG3BwRTCCSMlYYnZ7bG6MLShyysn/XqTMEjF74wVVGWoVPJs51q
 RmhJK0of2pIPSrDfDAwi1jetcWbjGP+pipKhPpgf+lJQ0SuhkHsJ9BP3Cv0jaGFzBPR+
 lVgEWQPvah4eulyPSTbm3jiT+fl1d91hy1M4+6Zr8MxLVwfvKYrEspCg0kHOS0uzL0w1
 W92MAG1il5M+amLKHXOnEcDTg2NY8wlPzC1gZAWb1LXrvoxJc1r/AUTIAr7HVXJjLD2A
 rDnA==
X-Gm-Message-State: ABy/qLbtj12M6JCwBB2d1yqaQ2DBVNAx+r/I9KHVxnwcNXtVvr5ybP3N
 0o/hQly85NcmisATzARH2BjI7EUFA7UgjnbU2b8=
X-Google-Smtp-Source: APBJJlGvooVNoOyLlI0Wdhsf4hNj6I+PrlR/COyoKIwwo83Ez86ZEu40VvlR7u4NwWlvUlYjQ3RZBQ==
X-Received: by 2002:a17:902:c94a:b0:1b9:e81f:fb08 with SMTP id
 i10-20020a170902c94a00b001b9e81ffb08mr2643952pla.55.1690554484536; 
 Fri, 28 Jul 2023 07:28:04 -0700 (PDT)
Received: from ?IPV6:2602:ae:154e:c001:cfba:2f6a:7070:67a9?
 ([2602:ae:154e:c001:cfba:2f6a:7070:67a9])
 by smtp.gmail.com with ESMTPSA id
 jh3-20020a170903328300b001b8b6a19bd6sm3676940plb.63.2023.07.28.07.28.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jul 2023 07:28:03 -0700 (PDT)
Message-ID: <a1004734-5eb1-032a-f597-c77aa32eee03@linaro.org>
Date: Fri, 28 Jul 2023 07:28:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: assert fails in s390x TCG
Content-Language: en-US
To: Claudio Fontana <cfontana@suse.de>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <eaec32e3-d56a-e6a7-fcbe-860948e79658@suse.de>
 <def2df0d-fb58-8e67-a0eb-7d646da3be42@linaro.org>
 <0e06f694-7aeb-66d1-48d8-317a93f8f741@suse.de>
 <2a417aaa-9ef9-6e24-cc54-e76e2d25b968@linaro.org>
 <77b0a57e-68f6-8515-b3fa-3ec9988894bc@suse.de>
 <16a9cdba-2f84-7d38-aadb-04524fee51e2@suse.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <16a9cdba-2f84-7d38-aadb-04524fee51e2@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 7/28/23 07:23, Claudio Fontana wrote:
>> It is a test environment for building packages, so the guest at the time of the error is running ./configure for the package swig-v4.1.1.tar.gz
>>
>> checking build system type... s390x-ibm-linux-gnu^M
>> checking host system type... s390x-ibm-linux-gnu^M
>> checking for a BSD-compatible install... /usr/bin/install -c^M
>> checking whether build environment is sane... [New Thread 0x7ffea3fff6c0 (LWP 116436)]
>> [New Thread 0x7ffec14e26c0 (LWP 116437)]
>> [New Thread 0x7ffecf73e6c0 (LWP 116438)]
>> [New Thread 0x7ffecde2c6c0 (LWP 116439)]
>> [New Thread 0x7ffec2beb6c0 (LWP 116440)]
>> yes^M
>> checking for a thread-safe mkdir -p... /usr/bin/mkdir -p^M
>> checking for gawk... gawk^M
>> checking whether make sets $(MAKE)... yes^M
>> checking whether make supports nested variables... yes^M
>> checking for s390x-ibm-linux-gnu-gcc... gcc^M
>> checking whether the C compiler works... **
>>
>> So I presume we are in:
>>
>> AC_PROG_CC
>>
> 
> 
> I am rerunning this over and over, and it seems it always aborts there in the same place.

You didn't say what the host is, only qemu-system-s390x.
Am I barking up the wrong tree looking at s390x host?


r~

