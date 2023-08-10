Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91454777E64
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 18:37:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU8dq-0005jI-61; Thu, 10 Aug 2023 12:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qU8do-0005il-7N
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:36:04 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qU8dm-0007V2-Dt
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:36:03 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bc7e65ea44so8169345ad.1
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 09:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691685361; x=1692290161;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/fB2jB8/Dp4ZCXvVFDjbyAyDrvHeNEfl9bPkIXNKtXc=;
 b=jnmVzGyR062CsZFVn8JxB0ZQAfcLot6frlE6YC61LGEmvaFqKoj2OdQCbsDNy9+fZ+
 A2h1T6yxZhUwnGSIAz/NQmMTg6c1vufKFEgpcN2sq9V03SmtvrZwfJMGusQBC/I6NGmg
 EkacUAb6SN1WoI/HEnBRg2gZYEdlQW0cAITIL8bSRfq4cRd+kfZVfnY0zIYt3ha7kcj9
 V+UfqQqxFp7FbSThbswO9Vf11b0jekPpR9DA4RamJ7Ki0nJAc0I40jd9tcBNqlYqbJuk
 FdujA46Law3+rsQAMmeX/xzB5RHsYadwhrTJZS0QMyqUu2E1uo7x9kQEKBSLVStT8gKP
 n+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691685361; x=1692290161;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/fB2jB8/Dp4ZCXvVFDjbyAyDrvHeNEfl9bPkIXNKtXc=;
 b=hIS6nfTEg/EKC/CP6h/FYskobOMunEfJiahabb+AdJavLoAG2s6SE++FS3tyBwtW7t
 e8b1QZ7GNqF7+0LiDfxSlfgh+gCRiJgstz+AEwyC0FHxJBDQ+6sZgwdOX3zsHuFk6bGH
 3MSwOBIu9MwgPhOi3gCa/ALnx93jaGnKa3aj/TUTcbmvyQNvTfmCPrzpj3exiMORRHk4
 K3nu5VMPzwnu0nUVT/d2xEeYdnAdIagNwrCjgWVuuvFH6YmFavvizR6oUE7R7Wq2Gyzk
 WBBRJtXLwNCetYB2yJ/YWzYPdkX6q1zgpbRA7XjBP645dIQ+mTceKcLPPMIKvURlPmAY
 GQbQ==
X-Gm-Message-State: AOJu0YxPESZ4l6tj5LvkZ32x6izozJZA+flBFnmO6DStJF1hY+xyIJ+b
 t76twgUDHvmIzATAAyevuJjy0g==
X-Google-Smtp-Source: AGHT+IGlm6Cha62z2DTFwWT1s1jAX6kGToO2ivmSpqyzJuEUq9jHo3GiF3Aq54bx/tBqUKTl3E+LWQ==
X-Received: by 2002:a17:902:d48a:b0:1b0:3ab6:5140 with SMTP id
 c10-20020a170902d48a00b001b03ab65140mr3235924plg.4.1691685360463; 
 Thu, 10 Aug 2023 09:36:00 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:9e4d:b830:d4fd:9164?
 ([2602:47:d483:7301:9e4d:b830:d4fd:9164])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a170902ab8200b001bbbc655ca1sm1984287plr.219.2023.08.10.09.35.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 09:36:00 -0700 (PDT)
Message-ID: <2773d29d-80cf-93db-ea09-06ba769cfdb6@linaro.org>
Date: Thu, 10 Aug 2023 09:35:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/8] some testing and gdbstub fixes
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
References: <20230810153640.1879717-1-alex.bennee@linaro.org>
 <CAFEAcA9bOS7tJDe_TRKOUGFcCDq_CjUfzAF7dYYRJbZA=5hvqw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA9bOS7tJDe_TRKOUGFcCDq_CjUfzAF7dYYRJbZA=5hvqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.156,
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

On 8/10/23 08:58, Peter Maydell wrote:
> On Thu, 10 Aug 2023 at 16:36, Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>> This is mostly gdbstub focused but I cleaned up some bits while I was
>> in the testing makefiles. This is mostly to make the "check-tcg"
>> output as clean as possible without ugly line wraps. I tried to
>> eliminate the gdbstub info() output but sadly this is harder than
>> expected.
>>
>> I've tweaked the gdbstub handling for Ctrl-c packets as suggested by
>> Matheus. While I was there I also noticed we were being a bit precious
>> about gdb sending preemptive ACKS so I fixed that as well.
>>
>> I don't know if this is all late 8.1-rc material but its fairly simple
>> testing updates and the ccache stuff from Daniel should help as well.
> 
> At this point in the cycle I would favour putting in
> the minimum that actually fixes bugs / test failure issues.

Indeed.  Which I think would be patches 7 and 8.


r~

