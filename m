Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E107CECC0
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 02:27:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtGrf-00057M-KD; Wed, 18 Oct 2023 20:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtGrU-000575-Fl
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 20:26:05 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtGrR-00063s-SR
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 20:26:04 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c0ecb9a075so51878665ad.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 17:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697675160; x=1698279960; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b7nGm9TId67A63JZa52zJLQrSDoSOIUeGVReQ+P+IdM=;
 b=S/4qAJPnUE1+1O02hNTfhig5mXNgq6CfpIu4KQAx3JHRA0ju29n0P3xdGUhJOh9M7A
 /Ivn9qKVTTNK4FIXhC4+b4eWTJsOn3Tx21kbaKAtiuemaEu/zlC7z6XhCczeL5Lu3Zcj
 1Tux70vRF03XqWGTCuaEvQvteimx84H9hOHkh1I5CN18iiyB8MR4IY1NpQE3rE2OZNk3
 UPDcpLRaGzL1w1x6RMLHiS5BnOrfUpPgFqJKBtcxdFW1tdVqyXR505g0TPL48ZPmJPDu
 H9h/QDWb3Zw6BTXWewZbNbks9a167Ji32FsBe0Ayr9JmmLCf5cO4xzoZHyqRnyL7tarv
 0qRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697675160; x=1698279960;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b7nGm9TId67A63JZa52zJLQrSDoSOIUeGVReQ+P+IdM=;
 b=dkMe+Ktdte8YYU+aGKz5u+o/8I8F9J5EhrtTufiYrCAn0ZYq9J1HUBjrgPnoZTzBpH
 AH7lXdDz6zB7DDD0Rw6ZB/YaPxETsfsTPQIl0AzgykekEzDrDqXZBMJfL6ZqHAfpQ7R6
 UhyBRZalxGnYFpRS4hW1wRGPDsbdc7EmfLlPfrrJWBcyz3pIjgVq/X7w718Tzod/DnMK
 Yog8wuf8jgSJ4wreNQtRXzWTk1kzRxxXsakEE+7dQI0kQ0wBl+NfqWmW/vjcbRg36YSg
 0YCRVmZyZrSG4nJ5FusigkPxdm5kTNAUc+1FqH304v1m36C/C0dKQHSQ4tk4oetud3zQ
 EAqw==
X-Gm-Message-State: AOJu0YyYZe2PzBJhKRE3eEFs8uPkZxvFylkm1Kpa8gpwrz/N5L1zB9TQ
 oMA1l5UimskOLRCfS3vjFjufBg==
X-Google-Smtp-Source: AGHT+IGVs0LPgV/2N7sOhygG6bkByK4IE1UIZIbTo8i/A+pSnEB0VC6jlG5DPUhBrzn8YzTkkg4xDg==
X-Received: by 2002:a17:903:246:b0:1c5:bc83:557b with SMTP id
 j6-20020a170903024600b001c5bc83557bmr931357plh.51.1697675159916; 
 Wed, 18 Oct 2023 17:25:59 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a17090282cc00b001b86dd825e7sm517407plz.108.2023.10.18.17.25.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 17:25:59 -0700 (PDT)
Message-ID: <b473ebf0-f527-4f58-bc8e-03cb6a932108@linaro.org>
Date: Wed, 18 Oct 2023 17:25:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/18] target/i386: implement SHA instructions
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231014100121.109817-1-pbonzini@redhat.com>
 <20231014100121.109817-4-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231014100121.109817-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
> The implementation was validated with OpenSSL and with the test vectors in
> https://github.com/rust-lang/stdarch/blob/master/crates/core_arch/src/x86/sha.rs.
> 
> The instructions provide a ~25% improvement on hashing a 64 MiB file:
> runtime goes down from 1.8 seconds to 1.4 seconds; instruction count on
> the host goes down from 5.8 billion to 4.8 billion with slightly better
> IPC too.  Good job Intel. ;)
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/cpu.c                    |   2 +-
>   target/i386/ops_sse.h                | 128 +++++++++++++++++++++++++++
>   target/i386/tcg/decode-new.c.inc     |  11 +++
>   target/i386/tcg/decode-new.h         |   1 +
>   target/i386/tcg/emit.c.inc           |  54 +++++++++++
>   target/i386/tcg/ops_sse_header.h.inc |  14 +++
>   6 files changed, 209 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I don't immediately see anything that could be shared with arm and riscv, to be abstracted 
akin to include/crypto/aes-round.h.  But there's probably something there somewhere.

Something for later...


r~

