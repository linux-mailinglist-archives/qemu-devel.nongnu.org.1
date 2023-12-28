Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5601381FB78
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 23:12:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIybh-0003Ju-QP; Thu, 28 Dec 2023 17:12:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIybe-0003Jd-8G
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 17:11:58 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIybb-0005gI-GR
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 17:11:56 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-28cb0c30768so21913a91.1
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 14:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703801514; x=1704406314; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PSkA/6cm0qIC6FJvN6DyGv7ooked5C2QWiK+3NTO4rQ=;
 b=GaUPevMQOvXhna3nPjN0mQHN67ZunG6Dqzns/+LSRO5ER3ayQ553gkviYJy6Onm2jy
 ZeIIsQlSMB/8YO1aNcq2L3X670geR2RhVfO91lkf5l1tMFFE8gL1aOU4OgiK9ls13GMS
 AL/fIMrk9DUOVqJASM66zLZy3vnHdsejlIzfHHwsSHBi908jELwqXHZmqb02IqiB64sT
 TsdswHlmYbTghQ1g/srO7NBypzKLCtR1neUzoqqD4xXVRGKgypcLJ5625Ii+loYDKi8r
 zatOw+Dy9KL99wgB/t2qqrOLM018UfMV/V4nboE/LFZYAJslMID4ka07bSibDOkIJQOp
 WGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703801514; x=1704406314;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PSkA/6cm0qIC6FJvN6DyGv7ooked5C2QWiK+3NTO4rQ=;
 b=kYZ2FuALWP9HDHK6uJ3W5GLPTSt86fWzRZodYowzC7utVC5lwQhAO88kO3mR2/bNyB
 ntbxqmWl/EHDgpe9Vm3k7Mi0q+lurwHcnqxEZT8QaBu3ztxEKlU2QyVZBzKsA5MLT0xs
 48ry4xyO0V0ITxJeNSJPgfKNColQUVpkBdlZEeI7mYOdqLqyKPHwcpV5cxvKAy0raM05
 1vHIP5P0D+r9qtcC13XoH31L5oNDvA0DVWtYssJTgYoJFnZZF1TmU42hYbmeaCY8IRcX
 rZYL1Z7SK0k4Xpgoru4/B1hu5iynWrog95Z5MB+GFw1Tlc62edSvwWPhtq8KwupWMFiq
 8TMg==
X-Gm-Message-State: AOJu0YxszVg0juALYWbcSP5TS1iO09DVnSHDVnUfadxOPNIMXc0RtART
 rYtVdW2MWXPBLkENpjpHNVdwRVori1QI9A==
X-Google-Smtp-Source: AGHT+IHM8nfJjDs18V82HUQ0FDZI8pfH4fIUYCbMzXFheINiJRPwsnSOMCCJY7fpV7eJz99BtmdpTA==
X-Received: by 2002:a17:90a:928e:b0:28b:e9c1:b81d with SMTP id
 n14-20020a17090a928e00b0028be9c1b81dmr13837655pjo.26.1703801513950; 
 Thu, 28 Dec 2023 14:11:53 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:324d:cbc2:5f8b:3a9d?
 ([2001:8003:c020:6900:324d:cbc2:5f8b:3a9d])
 by smtp.gmail.com with ESMTPSA id
 g6-20020a63f406000000b005c66e25497dsm13780300pgi.83.2023.12.28.14.11.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Dec 2023 14:11:53 -0800 (PST)
Message-ID: <495226b7-8306-44bd-a922-9e6c6daa66e1@linaro.org>
Date: Fri, 29 Dec 2023 09:11:48 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/22] target/i386: do not clobber T0 on string operations
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231222181603.174137-1-pbonzini@redhat.com>
 <20231222181603.174137-14-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231222181603.174137-14-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 12/23/23 05:15, Paolo Bonzini wrote:
> The new decoder would rather have the operand in T0 when expanding SCAS, rather
> than use R_EAX directly as gen_scas currently does.  This makes SCAS more similar
> to CMP and SUB, in that CC_DST = T0 - T1.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 45 ++++++++++++++++++++-----------------
>   1 file changed, 24 insertions(+), 21 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

