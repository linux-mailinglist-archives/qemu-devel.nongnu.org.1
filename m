Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EC881FB52
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 22:15:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIxhD-0008NZ-IN; Thu, 28 Dec 2023 16:13:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIxhB-0008Mp-Ij
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 16:13:37 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIxh9-0001tN-SM
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 16:13:37 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5ca5b61f101so1932973a12.0
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 13:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703798014; x=1704402814; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I7cTmzokPUtD0bGWQgYxBJ5rpyvHIVAXwgpWleXeGUY=;
 b=C0Hvj9c6yMc4MvqZcE6vOD+qTLZHq9mZmEWqoYWi1AnI9AfXN1yT//nA1KBuH570L+
 nmSnMUTJbXkIRjStexoBfRRZqcRvRDC1rSgqajqKkKJPDg4CjlXxjo343RA6rfLGpEAY
 EsnkWOf5WRV8ZFcWvnFD72QAVcJMBop8dMCwJ4Dm8uhuWgWYwIUq2eGtgks3XUG4MHeu
 mcZCCbZRJYhT8wcFtrPbDcwQfKcY+nHsuPUr+xdWDNL2ysGxQppvfstQlzms7De0mifq
 zuXyu+6LYWQ1odpIAgcT2sGrO+VqeSHCUe8ArZBk0NjHERHgLf5Qjr5NYNdreoxAci6l
 Qbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703798014; x=1704402814;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I7cTmzokPUtD0bGWQgYxBJ5rpyvHIVAXwgpWleXeGUY=;
 b=tylXKhv/Spbei+CbJHyn/bcGBc50D4K0h17cPZPBvbXTl8HbvmVATiY2eX+F3CM0wc
 81MBAQV/a7jhdli0aj+LuOCk0lqBr4sokcFkAaD+aTHTn3cUKqGVNnzRf1ai8oyY2Guo
 9tDxeKfFJO/ln51GeFc4cK7Bdk/CpRmUvFLUJvYa2fY1JPxQIT1Rww2xqI+CSRrf1We4
 cjzJ4dPZ25QcltoYeMwG1ke5gN+pAVppm2us9rwXV5fmMusqZvXmo/XMVBSAAMBARFqU
 pIOyXsoA3hNk7UXuGupSPbPhAsMQCMsu9V/hus7GuMibqEn1KeOqN0OiMT1ffWJgtvUU
 KO6w==
X-Gm-Message-State: AOJu0YwulT/J/J8eh3CCKzoYhaEGTkxU9SoGtfz3RdWGn7ZmlEStsV4O
 /u+ykjjoZEg8S/z41deBpxY7VtN0igHX3ZBVRnlK2oIXUVO5Muap
X-Google-Smtp-Source: AGHT+IGWf1j25CWsPOFxwsg0tMzK/Fun52mKJKo5j+PcJ5HVasJegmQ0Cw3iQ5D0KLF5R3RqsLWKHA==
X-Received: by 2002:a17:902:784c:b0:1d4:53cf:fbab with SMTP id
 e12-20020a170902784c00b001d453cffbabmr3266378pln.122.1703798014082; 
 Thu, 28 Dec 2023 13:13:34 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:324d:cbc2:5f8b:3a9d?
 ([2001:8003:c020:6900:324d:cbc2:5f8b:3a9d])
 by smtp.gmail.com with ESMTPSA id
 a17-20020a170902ee9100b001d0c418174fsm14296786pld.117.2023.12.28.13.13.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Dec 2023 13:13:33 -0800 (PST)
Message-ID: <ae7ee2fe-a559-491f-a71c-6659707845be@linaro.org>
Date: Fri, 29 Dec 2023 08:13:28 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/22] target/i386: remove unnecessary truncations
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231222181603.174137-1-pbonzini@redhat.com>
 <20231222181603.174137-5-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231222181603.174137-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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
> gen_lea_v_seg (called by gen_add_A0_ds_seg) already zeroes any
> bits of s->A0 beyond s->aflag.  It does so before summing the
> segment base and, if not in 64-bit mode, also after summing it.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/emit.c.inc  | 4 +---
>   target/i386/tcg/translate.c | 2 --
>   2 files changed, 1 insertion(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

