Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 228E882E2B5
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 23:46:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPVhn-00074n-LC; Mon, 15 Jan 2024 17:45:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rPVhj-000749-6M
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:45:15 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rPVhg-0001dJ-8F
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:45:14 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d4a980fdedso82006945ad.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 14:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705358710; x=1705963510; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C9agEiFTHYWkykdP4XkibFsAGWWHQHzV7HVsDZ178cU=;
 b=b7SLe3ymJE2I+2sGNoOVksU9COaGvua85flGj20vjoe8IiQCzz9jJ639VkEJIwBXi0
 CHl6qsAb3F1r5pEDGhFAEJDwxx8HPi3/whsxrREHy3+PFM0zkvF2Vyu9/v3OfWSephXs
 go8bE9F9T4r4RDuIi0cIrU2O2gBHBQi+GI5u5JwFQkqu1qpoRyf2fIIW/bHNRlJ2H/b4
 WSgXfEjRXoWcqx7hOvAt/T4OS2VPj/w/Igcgh9DwZwvpbqpCcicVqyWBKPs+osvJaGR1
 J4p719HkUNhA4CtbJqXyb+loRTm6GCdn43PQey7uI0rnqUztzbOYOVp5ekzdtRrBxPuH
 WvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705358710; x=1705963510;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C9agEiFTHYWkykdP4XkibFsAGWWHQHzV7HVsDZ178cU=;
 b=bNKw8LctTrRyJup1fnZKGJasJRieN4HAJMnOrJfswHHUjMf2RTtBtnuN8ag/FKmG7g
 AjJy7cJ1TwOCYi2V6QwY57XgyzHaQmHN4CN8qZVSTn2ZKgraff7dOGpRtYRCro3OYNV9
 KY8i0ueFPoAydGznhFK95k1lftm2VOXAijMUa0VAx3Rbo9y4z7vcRoRT+ana5ZzHx/CF
 2zoWJSDWt+M0Ip0llnWv6w+ViPTT0LPletuIoHLRNRaoRIwXGw+mgSr47ceAVOakvyKN
 SPALfkFiXULGWrLszG0DudskN/47g2vyuTNsXUjtEoEUAwPXZ7n28SDt8yRyta4EJIeY
 AuLQ==
X-Gm-Message-State: AOJu0YyqTYRiK1tsSKf/p0tvDBXFjXE4Y1whd47bhB9ZmL472GJIMZ3n
 u1JIkjNnM91l9uL45qwulHo9HmXSPmojXg==
X-Google-Smtp-Source: AGHT+IFFvED7cBvTFjdUJhi23jxBZIKhvcCjo2cJCf4r207dLJECfZKQdqDkPG+mt8rAL0h5l7OGIQ==
X-Received: by 2002:a17:903:41ce:b0:1d4:25d5:5a75 with SMTP id
 u14-20020a17090341ce00b001d425d55a75mr8983014ple.74.1705358710667; 
 Mon, 15 Jan 2024 14:45:10 -0800 (PST)
Received: from ?IPV6:2001:8004:2738:1dd9:85fe:4dd3:358e:ec4?
 ([2001:8004:2738:1dd9:85fe:4dd3:358e:ec4])
 by smtp.gmail.com with ESMTPSA id
 j5-20020a170902c3c500b001d5e7afe97csm10743plj.152.2024.01.15.14.45.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 14:45:10 -0800 (PST)
Message-ID: <4cab81dc-9fc5-4aa4-98bd-ebc7bab41f4a@linaro.org>
Date: Tue, 16 Jan 2024 09:45:03 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/12] target/riscv/insn_trans/trans_rvv.c.inc: use
 'vlenb'
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 max.chou@sifive.com
References: <20240115222528.257342-1-dbarboza@ventanamicro.com>
 <20240115222528.257342-6-dbarboza@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240115222528.257342-6-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/16/24 09:25, Daniel Henrique Barboza wrote:
> Use s->cfg_ptr->vlenb instead of "s->cfg_ptr->vlen / 8"  and
> "s->cfg_ptr->vlen >> 3".
> 
> Signed-off-by: Daniel Henrique Barboza<dbarboza@ventanamicro.com>
> ---
>   target/riscv/insn_trans/trans_rvv.c.inc | 140 ++++++++++++------------
>   1 file changed, 70 insertions(+), 70 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

