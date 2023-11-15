Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2955A7EBABB
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 01:58:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r34Dp-0000t2-Fb; Tue, 14 Nov 2023 19:57:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r34Dm-0000pi-Bh
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 19:57:34 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r34Dk-0004EZ-QU
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 19:57:34 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-28120aa1c24so9716a91.0
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 16:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700009850; x=1700614650; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=78qTd9dPDmND6v7vOhTGI4zagNWlQ0vvZk2MG/YqvJw=;
 b=sy8ueFPdb3VKzj15HRapkMB86wQbdDV4kx6SBubjdcwl0im/dzhuHYiWDi15Iw2jlt
 iZb0ZPqy23aj3gnWGD/Kx5ggwVdC6vOBBTYnOu1YiY8EVyf39x9SCpcseQ+YwyKssM19
 LkWdomMFI1mABc4Rbrcs2WNS73UsQqoUGstDoFlVIvR3nOzyT26QvLWM3ss9Od+MVhc/
 hGxVqceY2K1E+/i16SFMFrES1rzqgDFOtsm+bkj+8PEJ/ML2M8/6I6LirlziOaQgTLUg
 c8jpcZJj5cHwv/lkY3o1TGkMFwvZaKv4RXI5Fs05Hes4QpqSCIfIETvLvuwCxT9Je3n7
 Sgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700009850; x=1700614650;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=78qTd9dPDmND6v7vOhTGI4zagNWlQ0vvZk2MG/YqvJw=;
 b=TqNwsutz+e1rHqahAgKrKcaeMdNwFZbS0Gu/XlfxKl162QHOvY6VONHD38SwPIq9kL
 I4MwrmxHyVfyhDGacXdjz3vbJ4gtqrPA2AAe5wRr7crTxLzV63pd1CpNXJAwugBonBOu
 dPDzurhn8jzqbDSVVdXmWOl/ZOvwWAv8FOwhBlXqlFuIBjhi7Ur/ap8hq4ggJilCM27S
 Z/KF+voeg8jZ407HSzF2jCcWdGTBlQFVPV8OMzEMqH8Ko42NYNvRGNbVNAhyL3a5ufvF
 HC4Rzy9xD3p4N9qbJBV212SuGYMusXFimcjLsLzBQmD2MSO03y3ItAipD7OLYwVjHiYt
 gpCQ==
X-Gm-Message-State: AOJu0YwS4OokYy8i7Z6CvkY8Xki2fRmBQaEfVW0STIunNP6ttgBNzwkr
 XVxQ1RMh37NrH8SQIMRZroQ4mZBH64QVHIOAioQ=
X-Google-Smtp-Source: AGHT+IE2OvJBivHzNpxqDBCMHnq9pwBd3D0mhGrI3GHcCQ557gcrzGm7I6JCNLW+ZfDsWQ2L8sciBg==
X-Received: by 2002:a17:90b:4f48:b0:281:3a2:80ee with SMTP id
 pj8-20020a17090b4f4800b0028103a280eemr9035779pjb.14.1700009849910; 
 Tue, 14 Nov 2023 16:57:29 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 ge24-20020a17090b0e1800b00282eb74ec9esm5773472pjb.51.2023.11.14.16.57.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 16:57:29 -0800 (PST)
Message-ID: <4f647251-b6db-400d-aa1a-d6d869933b43@linaro.org>
Date: Tue, 14 Nov 2023 16:57:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/31] target/hppa: Use generic cpu_list()
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20231114235628.534334-1-gshan@redhat.com>
 <20231114235628.534334-13-gshan@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231114235628.534334-13-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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
> No changes in the output from the following command.
> 
> [gshan@gshan q]$ ./build/qemu-system-hppa -cpu ?
> Available CPUs:
>    hppa
>    hppa64
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   target/hppa/cpu.c | 24 ------------------------
>   target/hppa/cpu.h |  3 ---
>   2 files changed, 27 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

