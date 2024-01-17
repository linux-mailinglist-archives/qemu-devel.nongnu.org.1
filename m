Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F34C1830E0A
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 21:34:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQCbl-0003wS-0H; Wed, 17 Jan 2024 15:33:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rQCbW-0003sr-9A
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 15:33:43 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rQCbU-0006FW-IZ
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 15:33:42 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6db9e52bbccso610074b3a.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 12:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705523619; x=1706128419; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=edFK2T0IKw0JtwdA2cX9drKNuxVDgqblc4JuFe2KsAQ=;
 b=XKUnWKs/XnyVIq/CHXHc3Ld043HBag9Wmlb63baeSrJXoY3VC+q8p8hRsXuZzVxwHh
 0w07HNf5JiKHU/OCPPj0lqmPmSOG9BlwdJ5JGG301bPunBmWVnREYkJ2JkQ+p/kEST9q
 T5wzfDQdDkpkjbVyqN0doLcyOYO6MTX/knvPZGmEya1c7aRWA7IIHGz6PSksBx56lum+
 owlyNU1OCweWoRXY85F05YRckGUYUbzPynXrS/GZXGGKSM1e9cWXTwWEywjYmhfDpWIX
 V6KqwfNiKkDIT4f19pzXPg39Lur7rnLOzr3NGpS+bcxY+BykQ/GC5dmt8ge7D+Dm7KcV
 c86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705523619; x=1706128419;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=edFK2T0IKw0JtwdA2cX9drKNuxVDgqblc4JuFe2KsAQ=;
 b=qgYnYReAkh9XKKyE96zpl0oEc55pmSnlellF4SYsEXQXeoc5dFENk7PvwpddUGufxR
 Mju0o685T5mwBlBmfaIY8GDSQkq7cwSvKiPcfpWtxSrmXXuH9n6G4cyN+eTIaUa0Fekt
 71MNdv6jkQj5uCG43Q0MpqKhmmgIbJW4lIKRzPeO8QFc4YNSwtJBLwWXG/2IFa22CC5A
 Oazp8bQ+CiSgQnPVqvcJzOKn1rW8Ci3dOnhebBzP8Z3AHov2PwprANAfLxMjfcPZ2h+n
 jYzImVIBNnXxvgzisqDvjzShLF0HXkBdBs+LClBbQSwhJQrM4beut7SjwD+tqFFh3CQM
 4MCw==
X-Gm-Message-State: AOJu0YzzKe0/VVNbqcuQrbHIKDEDP+2dytZYFMCMYV86E6Dyd8FnR7uT
 b86gQXMGfZAGQRHF/VEBeV1kdQAY+xQELA==
X-Google-Smtp-Source: AGHT+IFGdFii1F78coIL0rdeEdVZsYCSrFbzbXSZSwR2j5QQXjKNDdQL3Bs3ABVVHKl14qSwYUFrgA==
X-Received: by 2002:a62:d446:0:b0:6d0:8b0d:b8c6 with SMTP id
 u6-20020a62d446000000b006d08b0db8c6mr5354352pfl.34.1705523618929; 
 Wed, 17 Jan 2024 12:33:38 -0800 (PST)
Received: from ?IPV6:2001:8004:2728:321b:5fc1:fe4b:9b89:f799?
 ([2001:8004:2728:321b:5fc1:fe4b:9b89:f799])
 by smtp.gmail.com with ESMTPSA id
 lp18-20020a056a003d5200b006db0f35296esm1924219pfb.148.2024.01.17.12.33.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 12:33:38 -0800 (PST)
Message-ID: <189c08d6-77e1-4e53-a89e-7d47f03a226d@linaro.org>
Date: Thu, 18 Jan 2024 07:33:35 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] remove unnecessary casts from uintptr_t
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240117160500.176509-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240117160500.176509-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 1/18/24 03:05, Paolo Bonzini wrote:
> uintptr_t, or unsigned long which is equivalent on Linux I32LP64 systems,
> is an unsigned type and there is no need to further cast to __u64 which is
> another unsigned integer type; widening casts from unsigned integers
> zero-extend the value.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   block/io_uring.c      | 2 +-
>   hw/vfio/common.c      | 4 ++--
>   target/i386/sev.c     | 8 ++++----
>   util/fdmon-io_uring.c | 2 +-
>   4 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

