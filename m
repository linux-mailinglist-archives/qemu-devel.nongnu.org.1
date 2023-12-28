Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5023081FB7C
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 23:16:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIyfA-0005Sb-Gi; Thu, 28 Dec 2023 17:15:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIyew-0005Pr-LO
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 17:15:26 -0500
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIyet-0006UL-CL
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 17:15:22 -0500
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-35fd902c6b5so51623865ab.3
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 14:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703801718; x=1704406518; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YfQ+MEqzulURWidPrR74xw3u38S7kt1Po8WNeAFUL/I=;
 b=sjCTcKPq2XVZfQ65cw/ihqHtWh7oQAv93FfBxAOV5W2hh3o1MnH2FLS+2gCJSR9dyF
 Ur7AMPKo5JbJlwjZbn6yXl+1QumtQYJw0dDvImDf3lZwllzqxaeJLbRn2Evrdl2vIb1x
 fF5cZ+1xxId9vVAAe4Fs84HVn3d2XtUAEl/qQi5OKfR2OZ0e7kG1gHdiv1biJEnOmPem
 JkvjHKjOHRxICxMzBTOFOD/h7+zCWHjZVi3y4Dim2EBLx6qsYZw2j/0fZEvY5wofXv/c
 zYJmJnYpmPMbu3ndIMOEydm0kTJSK1wY/viMRihWwY58Zd5jHP2ZKDmD6q8Ey0NZ/R+f
 nVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703801718; x=1704406518;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YfQ+MEqzulURWidPrR74xw3u38S7kt1Po8WNeAFUL/I=;
 b=u3Apm+zVJ52MUzmT86pbVGyKYb2DouOXcDTstWu3qA3/hO7Vv6wuPx4AsB+OsvprSO
 lutiwtMKNCcxGrVqoIGdAQql8ONpTopDQrciehCnYDdjyhiF9Cxd+YU2Csnry31QywHS
 oBXgo4QaQXx+sRGBsow0Wh24MeQ+v8+5KB+cX7NhBg5/oaeGDHw2t+eSNQsyX1ScljQ8
 6oc1OpKhHwpfMMKpsfL6/YgYeiinwfO6OPCiJtoxtlJRDBpDAaLXjaSBojUEAr8IPns+
 k9Iab50JPWkzb8FnQcnTbjy3KjAibFt2IKWN6IT6GaCHEJTDHivIzUZC4PX+VtTAAfDV
 76rA==
X-Gm-Message-State: AOJu0YzDCCemcEfzI7kYIDjL4Y6eShNtEwtDnVXPVxMngGoPYdGkoPKV
 /IpWouaTxOXjoKvfEH60HKt5+q+tbkilyw==
X-Google-Smtp-Source: AGHT+IHX7Lc/9RaQqOk63ZYxMxCzDlUz8/vni+07AZBqCk37WMkQowyoT1+pCY1SsqC+ss/ptWuCLQ==
X-Received: by 2002:a05:6e02:1cae:b0:360:e6b:bc2e with SMTP id
 x14-20020a056e021cae00b003600e6bbc2emr6888782ill.22.1703801718251; 
 Thu, 28 Dec 2023 14:15:18 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:324d:cbc2:5f8b:3a9d?
 ([2001:8003:c020:6900:324d:cbc2:5f8b:3a9d])
 by smtp.gmail.com with ESMTPSA id
 g6-20020a63f406000000b005c66e25497dsm13780300pgi.83.2023.12.28.14.15.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Dec 2023 14:15:17 -0800 (PST)
Message-ID: <778b3409-4a60-487b-b767-9c5d8375f958@linaro.org>
Date: Fri, 29 Dec 2023 09:15:15 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/22] target/i386: do not use s->tmp0 for jumps on ECX
 ==/!= 0
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231222181603.174137-1-pbonzini@redhat.com>
 <20231222181603.174137-17-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231222181603.174137-17-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x132.google.com
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
> Create a new temporary, to ease the register allocator's work.
> 
> Creation of the temporary is pushed into gen_ext_tl, which
> also allows NULL as the first parameter now.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

