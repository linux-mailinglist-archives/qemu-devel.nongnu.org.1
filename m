Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7967CFDA1
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 17:16:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtUkN-0003QM-Qi; Thu, 19 Oct 2023 11:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtUkE-0003OT-TL
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 11:15:37 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtUkB-0007ev-Tc
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 11:15:30 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-581d487f8dbso1646750eaf.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 08:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697728524; x=1698333324; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+YAh5yqrWTAaX6Bi/8N4uS88qtaIbH/5KsDodf00cyg=;
 b=iGqbobmU3NOSj3JfBo02H7UIhaRKcQc821+DEtLLoznkYRSYkKHJTSKBVaw+zbkvZo
 85EyRBZcFM/t6L4bR/puGxQbc0+yppRn/u3r4UQyd40byeGNLPbQ8y9mvcSk4qe2gj/O
 BGDVHLiVKm/TYrycLU4QNZPWPjzVpl8WpD1q+qeAMcdv0U0YkhE7josebOYtbH33DudQ
 adXPZxTuIm/p0mrI7loBqa4pnQxZRlpeg0J0OmnL82ZuEsAc8h2VW3Bd7CgpTD9G6Xof
 XCwKZHywnAG0LYmsylTQTeaiYxlJMztYtqR0+U/VtkRFIGvNv+eY2MrmvPmAOtgnJfwt
 /gQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697728524; x=1698333324;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+YAh5yqrWTAaX6Bi/8N4uS88qtaIbH/5KsDodf00cyg=;
 b=VitV0iWUFsW15zMlXMRBP9qlWDX9PB5Oo2yCjthwJGVzJew+ziijgXp5x9xYiH0XP/
 wdhID95eLi4oiPb8Z4rnm1AoqMaEX4iuLRK10kyEKrIYrvVSBTMLO340zyGFx/PqXbVd
 dO35afXhfzQOfb4FGoFvloghh46mkM9ZKY7u+S7eiQVC7NgbEW96JxL09FrkDXZDPigU
 Ch/ks1Xbu87L3SoWHTYuvIJJqN6PnhDII3/fALVD6yciIhYVzgyUeixPFcqlMZzIg8Ry
 kIknO0tDhuGaB2Vc3sLKOAORaQqQ5yKrs91bSqrt6ux9lUOUgIQ+HZRXUOm598q6Y2yl
 Ef0A==
X-Gm-Message-State: AOJu0YyVrceUUfmrgXGXiGsF3XT15gaDk3tZEZqJQWazqsjbHd5+Hw15
 iJkcgjAeHQlQZLGIBwoZpWQHLw==
X-Google-Smtp-Source: AGHT+IExzD7dkm4Yu6sRXXyXx4RpkzP30ntRzyoqBeV6TspCmwM7Mf4IgbDGB9XGZf4xMpcVNkEYFw==
X-Received: by 2002:a05:6359:3015:b0:166:dcf6:cd82 with SMTP id
 rf21-20020a056359301500b00166dcf6cd82mr2089580rwb.14.1697728524475; 
 Thu, 19 Oct 2023 08:15:24 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 z13-20020a62d10d000000b0068e49cb1692sm5400716pfg.1.2023.10.19.08.15.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 08:15:24 -0700 (PDT)
Message-ID: <6949786d-b5f3-4be8-a561-0b659c4e86f8@linaro.org>
Date: Thu, 19 Oct 2023 08:15:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/18] target/i386: remove now converted opcodes from old
 decoder
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231014100121.109817-1-pbonzini@redhat.com>
 <20231014100121.109817-18-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231014100121.109817-18-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc35.google.com
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
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 705 +-----------------------------------
>   1 file changed, 4 insertions(+), 701 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

