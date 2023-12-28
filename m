Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B6881FB76
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 23:10:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIyYw-0001pO-N1; Thu, 28 Dec 2023 17:09:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIyYt-0001gM-7c
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 17:09:07 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIyYr-0004wB-Pn
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 17:09:06 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5cddfe0cb64so2095554a12.0
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 14:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703801344; x=1704406144; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UTMkP22GeqW1FmKN8W5Nown0yRjGGB0hCSVikZr0tqs=;
 b=yEzdtywtp50fC+mxQXq0YRLxl8WQTRvKOU5NTqeAbOkr9x/SovtfEhHNCg0Eo0Nk/7
 OHOe7yyaN3syiVEsTj9K5XD/D4spK3QOpwbYWHCDfIyA7AmZ21FuFL6cSL0ZBriK8sdd
 iFGhdNXfcgKcrBlMemNQexJVVHmt7vabsDQK7DnNZuYRymoDbr6ro/W/+EKQsYjD/Bw5
 EpNtWdcYCAXLaTYLia3+RBid2aYovybHFoVFiGdDucIK08ba0DHGyhtZnv31TyQDTGie
 poQRxxBMZJDPKWiC+TyiG92+2awuDeP/hHNPOhhMTPdJVq5j6jxeBeuOtwbIZL/De/bP
 48Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703801344; x=1704406144;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UTMkP22GeqW1FmKN8W5Nown0yRjGGB0hCSVikZr0tqs=;
 b=cbxfuke8BNr9+ekGrBD4Qg8o+5Wf/Ep9A3syHiULVY8afxnU8cREy0RMGReymV/UFf
 gHm+yr+r3YJtq2xAPBzPK5/biReZE3xHy3l+Gsj8cMaToJFWjnZys2Sa+5m2uIHvXtrG
 cE01jS+tWRH7mY3d+ejnxnHzwQmkYlbEChN6+tJfa4u7RzVWPAqEOoa2pmaZrb48iIWd
 5l3ak/xitpRG9N0reNqHlQ84Cr1qDbIEqhUBPhSbAaHZfL7Z9vypiGMDaYIr06eCvl2v
 tA/dR79ojKT27thfCZdJXjjrxMQX0La1gAGzVTb1ijHoBGmf3BGIS8LF1I1wzW8CaXgb
 Twdw==
X-Gm-Message-State: AOJu0YzXaVSeeaNIhlvYHa+tCETEHUxTNUOQtkqS7Av/W4ulTo6XK96G
 XQYw1u+9h9ktYj6zkdGmshkouao1CWNM9Q==
X-Google-Smtp-Source: AGHT+IFMSLSUecJguV5/sdIC6Z9UkOnqYEBHcer/KSFGn9k/MCwyw5XsFLq+hLMSYMLJqsWMu8aRCA==
X-Received: by 2002:a05:6a21:6da2:b0:196:5696:e054 with SMTP id
 wl34-20020a056a216da200b001965696e054mr938534pzb.52.1703801344376; 
 Thu, 28 Dec 2023 14:09:04 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:324d:cbc2:5f8b:3a9d?
 ([2001:8003:c020:6900:324d:cbc2:5f8b:3a9d])
 by smtp.gmail.com with ESMTPSA id
 b5-20020a170902ed0500b001cfd0ddc5b9sm14375918pld.262.2023.12.28.14.09.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Dec 2023 14:09:03 -0800 (PST)
Message-ID: <ad976888-c6b5-4e0d-baac-4cccaee1cccd@linaro.org>
Date: Fri, 29 Dec 2023 09:09:01 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/22] target/i386: do not decode string
 source/destination into decode->mem
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231222181603.174137-1-pbonzini@redhat.com>
 <20231222181603.174137-12-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231222181603.174137-12-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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
> decode->mem is only used if one operand has has_ea == true.  String
> operations will not use decode->mem and will load A0 on their own, because
> they are the only case of two memory operands in a single instruction.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.c.inc | 20 ++------------------
>   1 file changed, 2 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

