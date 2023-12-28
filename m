Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D80E81FB77
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 23:10:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIyYG-0001ap-Ex; Thu, 28 Dec 2023 17:08:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIyYE-0001ZR-If
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 17:08:26 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIyYC-0004pw-Un
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 17:08:26 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d49ba98456so1197125ad.3
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 14:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703801303; x=1704406103; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T11bKiu1ql3jcldkmOd6gD29SkPzfY/xpHlb+9JTy5s=;
 b=J9YdQwLeGdIU4tDzrAYa269CL1jKUSiowzaiIvZBWVXQtxMBs+A6zf9jVGA9SKeKfh
 o5mCjVAa+y77XKkj+tbY/dAb9Wp4JcwNczwZqDAQcqAAKd4B5rmTOPkNRQoN7QzmJMTF
 xCIgRara4ame7ISsQoMT1m6HAc06N3KmW82iQ3c926DvJo3YKdwqrnUbjBYHUrCiyPzH
 OzUj2oOrDSGtVkQ10OsjJ2gY5p84bcaUj6lhlJpaUaSfqfCIwlcdtwF9X8YQOTxv32SH
 afpaKDg9gzSTfJYUsyJJj7dGcbqeVuih4j8JEzUiQwqFZW83coZvH8kbE8yN8lMoE7LZ
 4VRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703801303; x=1704406103;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T11bKiu1ql3jcldkmOd6gD29SkPzfY/xpHlb+9JTy5s=;
 b=JE0S5lUDjQHYoqnA+drXw6grLUyDSnID59IYeYhFQZMPhy/IwgQrxIkeepW9L6wgyN
 6eurHtmz/sZFfK5nfBhG1LzuThycrXoBaJE6x3JRgDkwAXHumBvJtAbblFmrtEEX04LY
 iZMJWxmxCEN6wl1cPaQdcp1s9zECmqPy3OEX9iOzxD4zY4wPdfC1aaaVXGWg+XTnqVr/
 FEbYvENqkZatSusdQF5Goe2hflNG5MK1NB0BVs0e/brY8dSyGRQTfymr00uoL4omaJDV
 38LyJNpu8wn81wze6wKpLPODg6epZEucpdrR71MnnehS+X/VK7dZ4GY+svjzhXUft9nZ
 Vomg==
X-Gm-Message-State: AOJu0YyVs7ePXL6URmUtzxF+DEg+xLQG2hZlNQZ/tC3CUciwIGM6bgt3
 bz+p56t75e3HYTSqaeIF/kZ/htInsSl0ZA==
X-Google-Smtp-Source: AGHT+IH5eoTa6TuhK6yCS0UQyhJqF9KLAfW6hdjyRGOcvmJowhB2ZAfVHr2YLojbq4ORVJHA2HFFEw==
X-Received: by 2002:a17:903:25cf:b0:1d3:f203:6110 with SMTP id
 jc15-20020a17090325cf00b001d3f2036110mr5416555plb.75.1703801303188; 
 Thu, 28 Dec 2023 14:08:23 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:324d:cbc2:5f8b:3a9d?
 ([2001:8003:c020:6900:324d:cbc2:5f8b:3a9d])
 by smtp.gmail.com with ESMTPSA id
 b5-20020a170902ed0500b001cfd0ddc5b9sm14375918pld.262.2023.12.28.14.08.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Dec 2023 14:08:22 -0800 (PST)
Message-ID: <c2f29852-567b-440d-9921-86478551a95d@linaro.org>
Date: Fri, 29 Dec 2023 09:08:18 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/22] target/i386: add X86_SPECIALs for MOVSX and MOVZX
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231222181603.174137-1-pbonzini@redhat.com>
 <20231222181603.174137-11-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231222181603.174137-11-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
> Usually the registers are just moved into s->T0 without much care for
> their operand size.  However, in some cases we can get more efficient
> code if the operand fetching logic syncs with the emission function
> on what is nicer.
> 
> All the current uses are mostly demonstrative and only reduce the code
> in the emission functions, because the instructions do not support
> memory operands.  However the logic is generic and applies to several
> more instructions such as MOVSXD (aka movslq), one-byte shift
> instructions, multiplications, XLAT, and indirect calls/jumps.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.c.inc | 18 ++++++++++----
>   target/i386/tcg/decode-new.h     |  4 +++
>   target/i386/tcg/emit.c.inc       | 42 +++++++++++++++++---------------
>   3 files changed, 40 insertions(+), 24 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

