Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA28781FB72
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 23:05:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIyUE-0000Ds-US; Thu, 28 Dec 2023 17:04:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIyUD-0000Cb-DT
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 17:04:17 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIyUB-0004HH-Me
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 17:04:17 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d3ec3db764so17647365ad.2
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 14:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703801054; x=1704405854; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F0yZkJBfVS7uiQWHVwZ/uENOp9+Jh+s0GhtQyX4Z7P4=;
 b=YAkD8Ulo1lwzBaM4aGG538ts+iGVBz/IrHleeu4bcnpVxuPw6x7hdCyIMYVNw9v7V4
 8TgdYNvi+bDH5PzejL4DYJnsaAQbxXxq+TWgDDYOnnjElFuQxpEVaW08la5BNZ0mPzar
 qUu4vw4Atv665AmHKkdSjM3f22qEdg5lMhJhwGE+mb0MGBuDCqFsRC6LmAMZFANk4nJy
 zo9ede46viPsstT+jX7LnNs29IMFF4YX93Y30AdcSTQ+9onGheBWUmkte9A1NyohhWnd
 TWaBV87qfoJ7bGy7PIhVPlI/ecT8p1XW0GmKM3t7HIUw7KPTXPKNuPik+Ei9LnPXnR5U
 uoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703801054; x=1704405854;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F0yZkJBfVS7uiQWHVwZ/uENOp9+Jh+s0GhtQyX4Z7P4=;
 b=Dz0CJLBG0u0qTIL5HlEQfTQJN0q4CHC5WcOoJu7laUmaWsu0l4g9Y6mgZOQ2sJtpy3
 qLV3lHZo4CY8ANQXiGwTxg+OwIMN8f9s4/SRGRFXwLIDca3Z1rc6CmZ12DLjlIvXcG3a
 76KoW/nhdIVlXFpRfM1TudxKK0tm38rI7hZlZd2G/b1Q3idw05VXgoceREtdKWh8IprQ
 9IIqND+kKaBmYfPYSpQ7QcnPNYwcnMDfUyYBu80fQxdq40viDEzNosHQ4+nMqnrcxrSX
 ayubmb/fHNUAqSY3pjaxIrw+0K6e3s7wwcNAHKsFZvFqTpK5/XtLLpulFKuKpk/iEya7
 m6Qg==
X-Gm-Message-State: AOJu0YzvD926c8iFCejxtNvYcnCaxwZ48tV9Gp7Mtgj3iyzooOXcFdQ8
 hFx4268PZTHxIqoWPgXO7UxP90Z4qIa+rQ==
X-Google-Smtp-Source: AGHT+IGC0356jSvv+0V83Ja8/PWaHmRNKprYShvPEKJuZHs4XULRBXzfKkKJjqP1jJjMg8Dt+C2isg==
X-Received: by 2002:a17:902:6805:b0:1d4:3e87:d481 with SMTP id
 h5-20020a170902680500b001d43e87d481mr3776277plk.43.1703801053691; 
 Thu, 28 Dec 2023 14:04:13 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:324d:cbc2:5f8b:3a9d?
 ([2001:8003:c020:6900:324d:cbc2:5f8b:3a9d])
 by smtp.gmail.com with ESMTPSA id
 c1-20020a170903234100b001cc8cf4ad16sm14352214plh.246.2023.12.28.14.04.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Dec 2023 14:04:13 -0800 (PST)
Message-ID: <97b9df30-841b-41cc-9eb6-2625393be16a@linaro.org>
Date: Fri, 29 Dec 2023 09:04:08 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/22] target/i386: rename zext0/zext2 and make them
 closer to the manual
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231222181603.174137-1-pbonzini@redhat.com>
 <20231222181603.174137-10-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231222181603.174137-10-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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
> X86_SPECIAL_ZExtOp0 and X86_SPECIAL_ZExtOp2 are poorly named; they are a hack
> that is needed by scalar insertion and extraction instructions, and not really
> related to zero extension: for PEXTR the zero extension is done by the generation
> functions, for PINSR the high bits are not used at all and in fact are*not*
> filled with zeroes when loaded into s->T1.
> 
> Rename the values to match the effect described in the manual, and explain
> better in the comments.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.c.inc | 16 ++++++++--------
>   target/i386/tcg/decode-new.h     | 17 +++++++++++++----
>   2 files changed, 21 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

