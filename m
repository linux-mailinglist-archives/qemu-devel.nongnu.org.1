Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B5182C84C
	for <lists+qemu-devel@lfdr.de>; Sat, 13 Jan 2024 01:23:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rORmy-0007ph-Hf; Fri, 12 Jan 2024 19:22:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vineetg@rivosinc.com>)
 id 1rORmw-0007oT-78
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 19:22:14 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vineetg@rivosinc.com>)
 id 1rORmu-0004Bq-6t
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 19:22:13 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6db0c49e93eso4145612b3a.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 16:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705105330; x=1705710130;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=60qHu+HlCMeY9Ng7xoNIpstDT9yHoXXvrzsvyZAGfSQ=;
 b=Xc2DoSaAZFtxat6CzCt3nVyDRKGucKQ6yXBanW0MRUPm8X4dJxL6EhfL2gxEidz7wJ
 LB9Dtu9ArK+jPwZ9R9W6D2IvxwlijiE8iRkc3X63HxitAeUyRvUeSWpYqbnuwtPoxtcf
 E4OadwGX5X2J5JI/cl1X3voSLU902ihimW4LOYPZdsyfqzZI5XXneISz1tWJG9hoXeSO
 E6ZG3eNTlJoFl8G4gdH1RRCmGK8hnijWXv6bUGloV24c6EIaq6zTx+3stRyi/6IU1Ckn
 G+LMa4MVjb5uMLITl3MSSGOtl9hCmhl4LP9sXu6kA0HDF0fbk3xruLkPwKoxT/JCUxrC
 vGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705105330; x=1705710130;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=60qHu+HlCMeY9Ng7xoNIpstDT9yHoXXvrzsvyZAGfSQ=;
 b=H4Z/j3erhlIlHKPcejLJPHfryY0mLTROVHKLwwfoI2YqlsWpqi8UyXWHc7nj4QljuS
 byu2qDrAk5kFZMfP0Ve/cjgrG9+EYt+j3MQWetwVMO1WZXhbwCRIU3gKiGwoLmtWymCE
 tg7yshQD6ScNLWI6u4wn1VNNg4qzR65VuFDbzZdPWeLijU6tNtQJ/GNAXLzPCJyPYMri
 368+yWewtlKvnewnndO9dqG3OUT2KOCUKMRNzFvdMFm2nTjQMpLtyKns3A9RuRKMQnK5
 25IqSyYEbu2vAsFAwZIWeNi+CygdvJPZJ9SfZ+GFCxdF+feb2swMakS6HjuRw5KAoMPD
 u7zQ==
X-Gm-Message-State: AOJu0YwLgwzW9lJ093eRSWTcyRpMMgtvWYvtVLBC60sB17Zc2CICOsjO
 DqjotlJImljtNcqRuDKd0YU+UKdDBfvrCw==
X-Google-Smtp-Source: AGHT+IH+KSaaa4TIa98K2WPrZNr43b/TqFfA/CSi2F+Ptj0kI7Apy7T6CW2HxAqpt1ry7gAeu9xY6w==
X-Received: by 2002:a05:6a00:2d16:b0:6d9:a32b:a27f with SMTP id
 fa22-20020a056a002d1600b006d9a32ba27fmr2617531pfb.45.1705105330345; 
 Fri, 12 Jan 2024 16:22:10 -0800 (PST)
Received: from [192.168.50.117] (c-24-5-188-125.hsd1.ca.comcast.net.
 [24.5.188.125]) by smtp.gmail.com with ESMTPSA id
 bm3-20020a056a00320300b006d9a9727a8esm3862074pfb.178.2024.01.12.16.22.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jan 2024 16:22:09 -0800 (PST)
Message-ID: <6a328673-c30f-4947-8d2f-0c70441c55ce@rivosinc.com>
Date: Fri, 12 Jan 2024 16:22:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 15/21] linux-user/riscv: Add vdso
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Edwin Lu <ewlu@rivosinc.com>, gnu-toolchain <gnu-toolchain@rivosinc.com>,
 Palmer Dabbelt <palmer@rivosinc.com>
References: <20231030211727.165090-1-richard.henderson@linaro.org>
 <20231030211727.165090-16-richard.henderson@linaro.org>
 <d5265d3a-7df7-4f93-93c4-a5d3a6251372@rivosinc.com>
 <119848b9-0cd7-4d33-bc43-385c86069388@linaro.org>
 <b84e0809-669f-49c9-8163-847485cfe7e4@rivosinc.com>
 <db63ee9b-901a-48ab-beca-4275e12a88d0@linaro.org>
From: Vineet Gupta <vineetg@rivosinc.com>
In-Reply-To: <db63ee9b-901a-48ab-beca-4275e12a88d0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=vineetg@rivosinc.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 1/12/24 16:05, Richard Henderson wrote:
>>>> So by default qemu ships the vdso binary. How can one rebuild it ?
>>>>
>>>>   From skimming the build files it seems following ought to do it
>>>>       make update-linux-vdso
>>>>
>>>> with a prior configure cmd like below with PATH pointing to the cross
>>>> compiler.
>>>> ../configure  --target-list=riscv64-linux-user
>>>> --cross-cc-riscv64=riscv64-unknown-linux-gnu-gcc
>>> Yes, that should do it.
>>>
>>>> But it doesn't, I'm sure we are missing something basis here.
>>> Do you get an error message?
>>> Did $(BUILD_DIR)/tests/tcg/riscv64-linux-user/config-target.mak get created properly?
>> It was indeed, but invoking make wasn't doing anything.
> Odd.  It Just Works here...
>
> What do you have in the "Cross compilers" section of the configure output?
>
> I would expect '--cross-prefix-riscv64=...' to be a better option that just gcc.  And if 
> you have it installed as "riscv64-linux-gnu-", I would not expect you to need to provide 
> any configure option at all -- it should be auto-detected.

This is really embarrassing but indeed build is working now. I swear
Edwin and I spent over several hours fighting the build and getting nowhere.
I also see how the vdso binary is subsumed into elfload.c so all of that
is good. Sorry for the noise

But not everything was a snafu. The gcc testsuite cleanup* failure issue
remains.

I applied the reg_size fix and that doesn't cure the cleanup failures.
Reverting the riscv vdso change, does fix them.

    2021-07-06 468c1bb5cac9 linux-user/riscv: Add vdso 

Now we just need to debug what in the vdso call frame information is
wrong and any pointers to debug that would be appreciated, even if you
are able to fix it right away ;-)

Thx,
-Vineet


