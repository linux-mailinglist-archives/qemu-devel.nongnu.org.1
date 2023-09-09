Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA379799A88
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 21:13:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf3NW-00081S-9z; Sat, 09 Sep 2023 15:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf3NU-00081F-KT
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:12:20 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf3NS-0007JT-GJ
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:12:20 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-56b2e689968so2289433a12.0
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 12:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694286737; x=1694891537; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OHWqqSzKGBhYB6VsjzWxz8Y25baFW55Y284+ryIr8QI=;
 b=ZQ3CAXVIPSZKDfIR6Ls07kNmf7Nwf/dSC/A75HX5JNOk7LvApt4wkbCJJTY20mxTf0
 +PUlskYsaD2HWbOj7RNxFi1agi3Z1eYEI3PgyGsUVK/FiVlaWYRdSdVEMEnFRRFsfy02
 CUkID9LRQLOogaf+f6mvueZsoX/4VOKLcjny7PFjOQbqJNXVpn45RjIfW30yGmg/3Duo
 4fJgdzzhpC9wwD04XM+wHhDH5w/uz45UuEpCrCBMjwJN6MFFDJT78xmyhzWBOc54jQ7u
 yleQ7Gr8kKTi/zPa5CANQgzn8Mi5UjEFBJBjtKQvTXZ2eDgoyLcoKWG1kJNdj7AWGBpG
 k1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694286737; x=1694891537;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OHWqqSzKGBhYB6VsjzWxz8Y25baFW55Y284+ryIr8QI=;
 b=XrR1O0Z/TRN0vQQCRE2x9mA/JkkCBWQz5u9LxEovDrcd4OkJQmiU7zfqyfbgZHztpR
 qsHRSeJP6LbtKr3aWqODMh1qjy3o2oRhFKBde/w1vVpRbpah727M2mx3FTv5dirWHDtX
 aJuiehsf3qZlaeUDW6JBBenWd3upXfExE8YCzOu2dyFyMKtKem4ONgqZqolNZZELXh6c
 nUltkZdvmb8V0DJ2YQIQwm2MgIo6DFG3fiuUU5dWKCGaZlYAb6h/PR+WuMWUsQgjSgWh
 5ioMbG0tZNOrzstSHiV0GpO6scL+1sORIbY7MO6B1QUjOLWvxaGzQTg7vfiseDzcWgPC
 6U9g==
X-Gm-Message-State: AOJu0Yx9Z8e8DGI5eMEf3dXhuWCt3CQYvsCxwUqbcqaVR/nRHQknEMW/
 hEXfXZtLw3R16YyZdkVBFEpqojNz2B+YA18acoU=
X-Google-Smtp-Source: AGHT+IEG//owvbSUmzwt8LvyshLrSm4/SBSMg81Dp6zsTEYJt5ZjlJjHcXw2/uCTXGMSMOzg29BiMA==
X-Received: by 2002:a05:6300:8005:b0:140:8537:85c1 with SMTP id
 an5-20020a056300800500b00140853785c1mr4614222pzc.28.1694286736950; 
 Sat, 09 Sep 2023 12:12:16 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 q25-20020a62e119000000b00686236718d8sm3058024pfh.41.2023.09.09.12.12.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 12:12:16 -0700 (PDT)
Message-ID: <d2e3266e-dbb8-07a6-07d7-008e788c3862@linaro.org>
Date: Sat, 9 Sep 2023 12:12:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 00/10] linux-user: Detect and report host crashes
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20230823051615.1297706-1-richard.henderson@linaro.org>
In-Reply-To: <20230823051615.1297706-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

Ping.

On 8/22/23 22:16, Richard Henderson wrote:
> More signal cleanups.  Mostly tested by temporarily adding an
> abort, divide by zero, undefined instruction, null dereference,
> within the implementation of a guest syscall to induce an error.
> 
> 
> r~
> 
> 
> Helge Deller (1):
>    linux-user: Detect and report host crashes
> 
> Richard Henderson (9):
>    linux-user: Split out die_with_signal
>    linux-user: Exit not abort in die_with_backtrace
>    linux-user: Use die_with_signal with abort
>    linux-user: Only register handlers for core_dump_signal by default
>    linux-user: Map unsupported signals to an out-of-bounds value
>    linux-user: Remap SIGPROF when CONFIG_GPROF
>    linux-user: Simplify signal_init
>    linux-user: Split out host_sig{segv,bus}_handler
>    linux-user: Detect and report host SIGILL, SIGFPE, SIGTRAP
> 
>   linux-user/signal.c | 400 ++++++++++++++++++++++++++------------------
>   1 file changed, 240 insertions(+), 160 deletions(-)
> 


