Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C867CFD68
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 16:57:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtURt-00089p-Vy; Thu, 19 Oct 2023 10:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtURr-000849-TN
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:56:31 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtURo-0007mN-MZ
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:56:31 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-694ed847889so6686759b3a.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 07:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697727387; x=1698332187; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VBz7fh+niNpIfFTKr4YltqId9B6aODAxLDxZKiwpaws=;
 b=OXOEfRchKbu8ezkskqwYQVZyCDVAVboRHYxh8A+fwAzPJXfcwibpaY/YU8RZMP9+bT
 BOW2uwPNEDJGqYq/ckRYTac/Z5gIOYgz5h74+oaxzQkMIdMnP5/vY+271bVjc5N3Yl3m
 4Px0O7xfYtCA3X464EfUPaAgny2+/LKbiaAWkbkbycYPuH5tPIs2+nZgHuE8u6mU6fz2
 q21x+TNcXW2ZpY5fLzp2y2aWu82PE4wXn2D9UpMpx4Nvt/SHA5qXbgRfb2zTcfV+5q4J
 lSW/wry747/+hgibmURrGzxF8E64Ml45kkAcTdE/uhnjiw8iJe3HOP0NC7fPSKz/N77q
 3nzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697727387; x=1698332187;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VBz7fh+niNpIfFTKr4YltqId9B6aODAxLDxZKiwpaws=;
 b=Yncmbv4HKYi/YAdtbNVA7tKmNBOggDEcPLHe1sWRhUGyS5Li+5OQO/Jvyfkp4gzfk5
 yRJX3ICcsUd4jbKo+xagFCjjPhe13qfoVwP2aiiZuQ77KEZYk99EtFBuiF451Oo1SW4V
 r0FjUwApzTLlsrI0qOZDjpAMXX/0OakJoRFUI5l4QsIO2PXp5YHl0n7Yedn2IWY/5zYU
 ATxxUMjXZ7e+CtLhhyVCCBdn34V9Xrli9O0yBeU+UtsTYhbOl5/OUU8dEJtaBC/FhihX
 BTZ7Q4TIkr0qZzXZZxR0MU/bgRnwe9D3MiswGsjBp4lO40LmYuFgxwUKOCvRiZWGnSvo
 TqkA==
X-Gm-Message-State: AOJu0YwIdOL+C1yY5Tsl++p77P3oCO6SRJL+o9LkZrbJOWOrNsTVqTYm
 sBwjDUjMjH2h3MQ7bYttKFoKQEMK9YlOyqGH54k=
X-Google-Smtp-Source: AGHT+IFPHb6c4ndER8r9ye+2dRE5fGwn1y5YFn7qz6Rtek05TcD04WvrjS0FqYxaBWtP5idMz9WUAQ==
X-Received: by 2002:a05:6a20:7fa5:b0:15b:c800:48af with SMTP id
 d37-20020a056a207fa500b0015bc80048afmr3054257pzj.23.1697727386882; 
 Thu, 19 Oct 2023 07:56:26 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 l28-20020a63ba5c000000b0057825bd3448sm3074818pgu.51.2023.10.19.07.56.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 07:56:26 -0700 (PDT)
Message-ID: <c98ed118-a6f9-40dd-919a-cb3b719cf67b@linaro.org>
Date: Thu, 19 Oct 2023 07:56:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/18] target/i386: move operand load and writeback out of
 gen_cmovcc1
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231014100121.109817-1-pbonzini@redhat.com>
 <20231014100121.109817-16-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231014100121.109817-16-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/14/23 03:01, Paolo Bonzini wrote:
> Similar to gen_setcc1, make gen_cmovcc1 receive TCGv.  This is more friendly
> to simultaneous implementation in the old and the new decoder.
> 
> A small wart is that s->T0 of CMOV is currently the *second* argument (which
> would ordinarily be in T1).  Therefore, the condition as to be inverted in
> order to overwrite s->T0 with cpu_regs[reg] if the MOV is not performed.
> 
> This only applies to the old decoder, and this code will go away soon.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 20 ++++++++------------
>   1 file changed, 8 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

