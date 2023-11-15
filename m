Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F827EBAAE
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 01:46:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3432-0001hW-MN; Tue, 14 Nov 2023 19:46:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r342z-0001h3-5L
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 19:46:26 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r342x-0001WH-N3
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 19:46:24 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3b2ec9a79bdso4233610b6e.3
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 16:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700009180; x=1700613980; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n5oWpp43rR0/831bEqevN/V+AjauLTlD4XWBVInqLH0=;
 b=uPu3z2dQvZ0BqDOID4zUsho/V916Cqrbvgby/4rykqulAVHHL9BR2UeIDP+LHohDyE
 1b3zfa0URv1HhkM2+cVF/+qLUG5hN6YSnTljaDQpLJaE3JPB+oaMDWFRJ9JG7FqDPUsf
 MqPidd1MM9ZhW4XWhUzfD4x1doo8q14j7pAiZBgbLUbHJI6J7qbPleheKWhBoFG8y8iT
 rl6n9IFwk9vNUREQEN7o4rmEfLESBrU25KcAdR75b1sNtQ4B0cSxiyyWs/6RDOgGnvhW
 uAVKt9pUFtzVbSRB8t9tZ8zMu06M/5OO3nlj+d+rznDAKS8Cw0mdRJCodWpNx5FOs/6C
 c/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700009180; x=1700613980;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n5oWpp43rR0/831bEqevN/V+AjauLTlD4XWBVInqLH0=;
 b=KNxHXuCreoOUaoXO1RaSvvfDzB06HkGBtyuHxMTAfpCLNIr0k3oeSvMYHZx29lb1Ro
 EX76OWfWbS/K3Ynr4V9W7yiADZTPzIQrDJctn9dhceKIQK5t2gDoTEwAUY4B+sXy2kbo
 ZWlNz/jG+V2x9MrJq18zvXc7TdVEQ2PEEK32+PBDvLu62FMhiQ61Vsyv6J0X26iPL5Hu
 UjlRKUKpGHZppsytU8YV6qG/PIN1Z3NZaR61QZnUjlaNXoGQE/QUT+SweRSarB8cf5t7
 3fOP0y2788TcolbH7/9poiwK8A/dSbmOfjYxvY0PlahJsRjCrGOPvF6OR0W2VVihvTm2
 LUtg==
X-Gm-Message-State: AOJu0YwSFb5tey9WbKRtyGA1Z0+Q2nvwxmEYGs86DGwVlimIGeKi696t
 YDnwBzP7ZrxPJee9QpIx20ni7bmrlG3KjL+djfM=
X-Google-Smtp-Source: AGHT+IEHb4PRKokb4c8IC9+xMDRXYuCFRdGc2MDZyt+HPjwubmXqrtgSj1QKoqr6JYS4707EGQv8HQ==
X-Received: by 2002:a05:6870:4994:b0:1e9:c224:bb91 with SMTP id
 ho20-20020a056870499400b001e9c224bb91mr14624552oab.38.1700009180569; 
 Tue, 14 Nov 2023 16:46:20 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 i20-20020aa787d4000000b006c4db182074sm1769511pfo.196.2023.11.14.16.46.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 16:46:20 -0800 (PST)
Message-ID: <b2329ec5-3f6e-4456-a0ea-e72efca0f0b5@linaro.org>
Date: Tue, 14 Nov 2023 16:46:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/31] target/hexagon: Use generic cpu_list()
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20231114235628.534334-1-gshan@redhat.com>
 <20231114235628.534334-12-gshan@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231114235628.534334-12-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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
> [gshan@gshan q]$ ./build/qemu-hexagon -cpu ?
> Available CPUs:
>    v67
>    v68
>    v69
>    v71
>    v73
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   target/hexagon/cpu.c | 20 --------------------
>   target/hexagon/cpu.h |  3 ---
>   2 files changed, 23 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

