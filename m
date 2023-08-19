Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15976781A31
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 16:40:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXN7h-0007Sy-BF; Sat, 19 Aug 2023 10:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXN7e-0007Sc-BS
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 10:40:14 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXN7Z-0004ck-4e
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 10:40:13 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1bdf98a6086so15345005ad.0
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 07:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692456006; x=1693060806;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DQCruXsvuQRYzofkl5y2s5K2Dmunh2MIcBPKGEH05nQ=;
 b=IJ7CE8yVBF1b/hH6A0VA6iEGa+mmV7qjVKVTdX1VaZHAxI0Pj2NVjrK3VgXHBNEtzf
 Kv/OxIeZHTaVgWspnJssVeSJjASIdEdGmZpesN4ZUo/edb+cMdTsmYwtcud9jlxDEhMs
 JjejZ+zHVGC0TIgzWzerXJ1cAge03pCe5Cwfb6ATjkFkNnfIDQC3rzZf9il+vDzuHb/Z
 1BcQEP2POjbpRFXm1GMsQUapacZ/hkg+weF9bBo5oW7q/fbRhgLwacrprELPhMvM4SLW
 AuGHUwGzHywF7llFHCUW0ZqpGhBq3POqqIsN2y9i80EHJsQYzrRyO9Icnw2sFZcyEWOg
 0JHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692456006; x=1693060806;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DQCruXsvuQRYzofkl5y2s5K2Dmunh2MIcBPKGEH05nQ=;
 b=bf5ifQM4JsUNVhg9YuRVTeoJlNCjAQDHbZsHY0uxe9lWsed3Uxjk1KSWZxQKXkDV+Q
 FeqjV5PoIi1NG+bf9eBhPg9HEzVJ/P6M4lQWa1fHNifw+GIUzHeEMOvtcTMvrvEjNhDO
 XuiWTJAb9Iego1q4vmqdZtG8Si4PgqfprXwjjonOkcIUKfRFlLplHgK/q6B4NhZrBYSf
 Eh1RlP4J9Smje2pR9sBRub9J2iRjLViwyEOfPTUMXwxu+GvGe+C73IwDBqKGPin/a2sI
 J3OjvGSBFjtw2v/k/2Xd98179NsbVehbwypj98aHjQ0vQGnr029JTrB7HswUcy/SQwiw
 OOug==
X-Gm-Message-State: AOJu0Yzyb6n2uMBJaHBjj5dBK8VvnLuSqbIhQ20HYN6uqqA+O+++8y1a
 xETe6eL27W3GEWYHCKLact41ig==
X-Google-Smtp-Source: AGHT+IGESNcaby9TFhYN4ocvVC60e29kiNKHtv7YOiJPFLhi8m2YyRnEfI4ENTN5iTQWfqgGKXUcPg==
X-Received: by 2002:a17:902:e5cc:b0:1b7:e355:d1ea with SMTP id
 u12-20020a170902e5cc00b001b7e355d1eamr2465977plf.24.1692456005919; 
 Sat, 19 Aug 2023 07:40:05 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:d058:ace4:c86a:5384?
 ([2602:47:d483:7301:d058:ace4:c86a:5384])
 by smtp.gmail.com with ESMTPSA id
 e3-20020a17090301c300b001acae9734c0sm3735901plh.266.2023.08.19.07.40.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Aug 2023 07:40:04 -0700 (PDT)
Message-ID: <a609b437-3492-f034-a040-1d8b5a64d428@linaro.org>
Date: Sat, 19 Aug 2023 07:40:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 03/22] Declarations for ipc_perm and shmid_ds conversion
 functions
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-4-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230819094806.14965-4-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.862,
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

On 8/19/23 02:47, Karim Taha wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/qemu-bsd.h | 45 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 45 insertions(+)
>   create mode 100644 bsd-user/qemu-bsd.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

