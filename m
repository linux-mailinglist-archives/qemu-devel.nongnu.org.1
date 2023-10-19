Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 036667CFE8D
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 17:45:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtVCA-0008Fc-2t; Thu, 19 Oct 2023 11:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtVC8-00082S-9l
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 11:44:20 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtVC6-0003qb-DT
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 11:44:19 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1ca74e77aecso7200635ad.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 08:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697730256; x=1698335056; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RieWzMjgYMxs0gMO0nvrRoWcT440CMfFqIuzlEH3Kp8=;
 b=Emf1n53WHgxzlHCSmNl0jd7dAMgXVk/uPUBU2cZCaOPjsC0v0O5a3Teg2LsRFmcVD6
 3XStoEIw8Sv40d87vaMUXk7QNwuBzNS+aDGO4VUhXgdMJJAqjBZWKATJAFesBYsCen2R
 TGhR+f9y37qxtFMhVa/5NrnfVZl6B+6GBcN08G+IIf03iJby0IdTJb6bpy0SeKr5r3R+
 8lWmj5EBUbSPAuGntS8OvKu0nr1tS+bibwWNk1n6fS5PJIT4HSuSTTubjrGYlCexnBDK
 v1ZQ2FchhzZOEJC24gGDFoPRBMVsFlw+mfdMI4zASr2H1x4VyJa99SrL/ztdhuqJ6gwP
 x1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697730256; x=1698335056;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RieWzMjgYMxs0gMO0nvrRoWcT440CMfFqIuzlEH3Kp8=;
 b=tOQ38Fq5cQi1XFpPsMrDfMgngnbWpiLcsz3eJinRE3xBIQBBFYUE7WHXAtAYFg6kN4
 a7TS7L7o45WkFEUE+vy47ewSsvkPN8czXyTO/jaL2zfRqjQ13hAKgtK0eoldVPqV2Xg4
 pq/JhNmKlYwH7IZRfRwVH5VXnfj7eIbyW1OKIAaai6QwMoN4mJCY6FyLvsS9Cl/cW2LY
 Zkk8aRXXzVHUyrzy3GsA7pl8TTqspBtJAiAQQ5oqoGekgONDp0RgU0Km7GA6ttMmf7tl
 Zozow+3NGXe7fqfRua6E4HImkr92oeUAxrS/0msekBLurYk/nGC2jnVKJtb3nkSRHQ1E
 ujkg==
X-Gm-Message-State: AOJu0YwBNNBdWiZ94kD1itOHBAG2IvZJVT+mjHdFbmgs2jxtsL/LbJQ7
 eteX4us3h6RNJYskKyI0mrz5uA==
X-Google-Smtp-Source: AGHT+IHVX6jiIxp82r2Uom8LT7N+CFvijIeFSym5Kb+RnYI58YASTYGxtRx2BRuS3ecCRD+jJXMj5w==
X-Received: by 2002:a17:902:c404:b0:1c9:dff1:6de7 with SMTP id
 k4-20020a170902c40400b001c9dff16de7mr3964553plk.7.1697730256132; 
 Thu, 19 Oct 2023 08:44:16 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 j9-20020a170902da8900b001c62b9a51c0sm2094758plx.103.2023.10.19.08.44.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 08:44:15 -0700 (PDT)
Message-ID: <e311cf0d-04b8-42b4-977d-bfbf68a6cb6d@linaro.org>
Date: Thu, 19 Oct 2023 08:44:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/19] target/i386: decoder changes for 8.2
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231019104648.389942-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231019104648.389942-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 10/19/23 03:46, Paolo Bonzini wrote:
> This includes:
> 
> - implementing SHA and CMPccXADD instruction extensions
> 
> - introducing a new mechanism for flags writeback that avoids a
>    tricky failure
> 
> - converting the more orthogonal parts of the one-byte opcode
>    map, as well as the CMOVcc and SETcc instructions.
> 
> Tested by booting several 32-bit and 64-bit guests.
> 
> The new decoder produces roughly 2% more ops, but after optimization there
> are just 0.5% more and almost all of them come from cmp instructions.
> For some reason that I have not investigated, these end up with an extra
> mov even after optimization:
> 
>                                  sub_i64 tmp0,rax,$0x33
>   mov_i64 cc_src,$0x33           mov_i64 cc_dst,tmp0
>   sub_i64 cc_dst,rax,$0x33       mov_i64 cc_src,$0x33
>   discard cc_src2                discard cc_src2
>   discard cc_op                  discard cc_op
> 
> It could be easily fixed by not reusing gen_SUB for cmp instructions,
> or by debugging what goes on in the optimizer.  However, it does not
> result in larger assembly.

This is expected behaviour out of the tcg optimizer.  We don't forward-propagate outputs 
at that point.  But during register allocation of the "mov cc_dst,tmp0" opcode, we will 
see that tmp0 is dead and re-assign the register from tmp0 to cc_dst without emitting an 
host instruction.


r~

