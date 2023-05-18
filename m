Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 236FC70833B
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 15:53:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzdX6-0005jU-Vf; Thu, 18 May 2023 09:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzdX5-0005iv-AC
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:19:03 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzdX3-00047Z-1a
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:19:02 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-52cb78647ecso1351391a12.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 06:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684415939; x=1687007939;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UjV8BGLVOcGHlPcMNZmM5FEDsLwD+20cb1mekw74Dfw=;
 b=BMM1MZswDQFmrEs5NDtjfXJzt5UZ2bUSDKu8GYig4FAK2WOfqZz/pC3AFPSL4YuspF
 QTZKU57Xza10UEDPuj7kEJnwFQVPg438AcZJkX1gQIKF7GoO1fyA8E2NiuWtxDM5WNAE
 QMdlBoitL+DpdTn3fnWcHBXkUsvNZAv1zRbsy8xMBVUaUOrMIdJrLk30LiDqGbjNqD4p
 cDY0sCktvX0dmDLgPbdvrbqCSimtPVh2BTEPnivRyPaIWNjqiN+rm5pC8ihywVTYd9uH
 s4ORMHaD/GoxME0QkERFv5eiwCkibFFymgIp0QNMKpOO7gJX/wGmDfWRwnGPI1GV0zKy
 qgXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684415939; x=1687007939;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UjV8BGLVOcGHlPcMNZmM5FEDsLwD+20cb1mekw74Dfw=;
 b=i1MVoTw07fJMsl10mWppjIspXeZVsuJSJSOABtdRWLZ3nzGwJhwx8BvY4pUmKcdt0J
 52RwJaVl3E/YQaXQzUqxESC/nGEso9/RYvjgKQxRiq0B1ThQs6dLnYkIyOW0A2N0U7Vs
 mYPp/3J2gFNSHZkSPh6sPdhYEZr1WN6EAog5AdcTmNCGgH5vC3vP2aoUKGARlx2bRTk6
 wbBb5PJ9EzqI0KgFXinSjqINaTir7e8VAVs3vDpw2h/tVKR3Blqrc3uLFE1c+Rybd6mW
 duUnJA3zy59wXmIBKw64tKq8Ca30pRbJp5D15G5GG4lRa0k8aAQsOU+E8i/XKlJ8uy0e
 iloQ==
X-Gm-Message-State: AC+VfDwrejqm7gzTKtXtbsvuBcUV7arQrTjnh6tBaEg6WvEktowizavD
 T0sYNOGLwErVH3Ouv1M8C8vIHP0CzJptwSDiMuI=
X-Google-Smtp-Source: ACHHUZ5v8XxwrJpwgAsTQXQz5BUx0c6GKzEhnobLof2ALFqPYA8I1iX9iVJXTwVOX/Y0MAtpFLiTQg==
X-Received: by 2002:a17:902:7e01:b0:1ae:1751:159 with SMTP id
 b1-20020a1709027e0100b001ae17510159mr2161460plm.23.1684415939539; 
 Thu, 18 May 2023 06:18:59 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:5dd2:c230:399b:cdc1?
 ([2602:ae:1598:4c01:5dd2:c230:399b:cdc1])
 by smtp.gmail.com with ESMTPSA id
 p10-20020a170902e74a00b001aae64e9b36sm1406840plf.114.2023.05.18.06.18.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 May 2023 06:18:59 -0700 (PDT)
Message-ID: <466a0b09-1900-0edb-1eeb-30b8d728d5ac@linaro.org>
Date: Thu, 18 May 2023 06:18:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/4] monitor: add more *_locked() functions
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com
References: <20230518101804.992085-1-pbonzini@redhat.com>
 <20230518101804.992085-4-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230518101804.992085-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.544,
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

On 5/18/23 03:18, Paolo Bonzini wrote:
> Allow flushing and printing to the monitor while mon->mon_lock is
> held.  This will help cleaning up the locking of mon->mux_out and
> mon->suspend_cnt.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   include/monitor/monitor.h |  3 +++
>   monitor/monitor.c         | 14 ++++++++------
>   2 files changed, 11 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

