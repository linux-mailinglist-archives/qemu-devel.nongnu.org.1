Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 604077EBACA
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 02:06:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r34Lp-00075a-1u; Tue, 14 Nov 2023 20:05:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r34Lm-00071Z-Ie
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 20:05:50 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r34Ll-0006at-5w
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 20:05:50 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1cc30bf9e22so2978445ad.1
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 17:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700010348; x=1700615148; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=02BcouWMj5DeH8M8FfgzJguZ1M6C87+91F7uvv+qSyk=;
 b=lQl1GOOxD/F/RXPf1/MEMiOtN90nWbeUr3ME+tWn8i4yVFFtiajGBqIEloguh1o9pY
 mQYhegKlp4tw5L1sL0PDT7mZhfEu+rSqc1yJB1MW1loyHT+suZONwL0Q2plHcxWu0HZL
 FdB0rCwoL2zUk4kYRRnt3fg9o2GNNGHB13i3je85xHsLPYDqM1/yU1V/XL11XK1UQjb6
 v8m1bZVclsuxXhY909Bvqz73CiNBs3L8TpptFBZnvbmTXyNwVpzVFh+TD4bNACinmU5s
 hqMZBACnPG0g6Ij89Qc6q83p/2z3ow8NTEeSJ9RVyF77jPUKsPfop9m35Zc6ITKDyrdq
 2O5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700010348; x=1700615148;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=02BcouWMj5DeH8M8FfgzJguZ1M6C87+91F7uvv+qSyk=;
 b=q7aAn35vUyRzJPVB0/aVkJlUOH8IIohrDEoRDtYqqwX3WnlanMIk1u0qQLUYp+z8gq
 8Y+PLEJAjtqqKAUzG4pQvwmZDblV/LIJXwmTdW6gKqBlIH8+XH3AAGEdMzAp3YMCYOF6
 B0rT1XrmX0qbeIzEs2KJWWMyze+tObPYipu14didAWyAwkfgstqzbnyMwFl7RdemkKKx
 JqlFy/zCO2ZncWJC9L4AYwWSOeo9YsRJ5TcuHYDZK87ZEmb0QdSzVN6bvydJqQyJylbG
 HLt56gitdNf3qMFORbNNDkZyUn7U73NPA8SNXeBGWLNVadthyu4AT6rv73M+cjlUqbvo
 cmDA==
X-Gm-Message-State: AOJu0YxtOC8UzXmuaYIyOq6d7FFqicKMCZdkfN8+t4WyjVvgIoMBud+b
 fu9USMXwqdTAW7pgqatJWztMPxp7rcv5Mn5sOAw=
X-Google-Smtp-Source: AGHT+IHYWMh57cl93w6WJesgYq4Y2yfm5hXCyGZRcwt3zXFKpzQrRhlHeRdH99dZyw3ImDeF96MNiA==
X-Received: by 2002:a17:902:e892:b0:1cc:32df:8ebd with SMTP id
 w18-20020a170902e89200b001cc32df8ebdmr5749918plg.25.1700010347721; 
 Tue, 14 Nov 2023 17:05:47 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 26-20020a17090a001a00b0028105e3c7d8sm8707354pja.0.2023.11.14.17.05.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 17:05:47 -0800 (PST)
Message-ID: <843a34b2-4f61-44b4-88e7-94976ec907b1@linaro.org>
Date: Tue, 14 Nov 2023 17:05:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/31] target/riscv: Use generic cpu_list()
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20231114235628.534334-1-gshan@redhat.com>
 <20231114235628.534334-18-gshan@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231114235628.534334-18-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 11/14/23 15:56, Gavin Shan wrote:
> Before it's applied:
> 
> [gshan@gshan q]$ ./build/qemu-system-riscv64 -cpu ?
> any
> max
> rv64
> shakti-c
> sifive-e51
> sifive-u54
> thead-c906
> veyron-v1
> x-rv128
> 
> After it's applied:
> 
> [gshan@gshan q]$ ./build/qemu-system-riscv64 -cpu ?
> Available CPUs:
>    any
>    max
>    rv64
>    shakti-c
>    sifive-e51
>    sifive-u54
>    thead-c906
>    veyron-v1
>    x-rv128
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   target/riscv/cpu.c | 29 -----------------------------
>   target/riscv/cpu.h |  2 --
>   2 files changed, 31 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

