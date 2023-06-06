Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8C472491E
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 18:29:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6ZYa-0003gs-8e; Tue, 06 Jun 2023 12:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6ZYW-0003fe-Ii
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 12:29:12 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6ZYU-0002UJ-Se
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 12:29:12 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-650352b89f6so3287137b3a.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 09:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686068949; x=1688660949;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C3Fcsmarfd+RekiO8912tkVzRhQakcC4gX2K0ggl+iA=;
 b=J5x3yVVMAJciVEZEdOTXKCQyz4eIoX2gI86Bsxj8KIIyUdGllrB7jCkQWQFUbWxjfw
 PwVuT4o50qSUyUVtZ8qMEWM+cwdQjswvcXjVcu8VgHNE8B7MPklMqZPTZtVGETRaX5/s
 avss98FZWlSaMV1pPLI0KJwz1colDQ7rA62lCiAeSlgzakc9bn7o1vX425Q9Lg3khQxL
 lCdUGxYUnZTNefx+WjRKeMCGVjaCNeAOUvRyA9U0wvooZFxFNR5rp+IfKD6HhC5jsTW1
 Ofi4OxLMvUPsKKzoDHFmcDhvqrLRwRgiboI0q+jNO5pnHGAeihXzKSCMkDj3Y+jeVDCy
 c3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686068949; x=1688660949;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C3Fcsmarfd+RekiO8912tkVzRhQakcC4gX2K0ggl+iA=;
 b=KUcy2p7rmgdXRn5cr6ceJOSMqiqzYtoVBW1mSYvja2884JwT5MpiCdzGaUWFdwmgu2
 481ge1b0W7Ug1MwpDLMBjk2/Urd0E4nWcNGOdhf7+AClK5xDf8SdxlE8QZ0c9cFQt4/b
 sd6H09/TjxNo/F2DuS+gC7jRkob2R6SRBplvnuQzPyMbxW8N+XwXX6gMBkGsLHO8v9Sr
 hAzSkRcrFS9d7MU7XbIKHmBa/CiYztvUUpdOHTkvB546snOMx4s9d7A2tDRuH+eVFi0Y
 eByOC6x795qLxkOJQ/UDkfMVvclWnF9gJqKqz7FwX2oq+UnWrtDMsVbnk1WuSIKnAlYp
 WtuA==
X-Gm-Message-State: AC+VfDygYyL5JPzfXQOHVieFcptDHTqJqZfp1/ciiRFVhNfQE4lBjhx9
 glBKohTsnnb6rgzNWCg/4yckOsgXD439Rs00oGA=
X-Google-Smtp-Source: ACHHUZ72E1chsDLiYa4tMUcD0OsB5z4aBX/J0Tb9cvYZQf27/3uxKxh5oKdARzXklebbQJRaX5/yug==
X-Received: by 2002:a05:6a20:4295:b0:10f:1d52:93c2 with SMTP id
 o21-20020a056a20429500b0010f1d5293c2mr185616pzj.28.1686068949286; 
 Tue, 06 Jun 2023 09:29:09 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:b7fa:ce59:1445:805a?
 ([2602:ae:1598:4c01:b7fa:ce59:1445:805a])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a170902e54d00b001ae4d4d2676sm8748543plf.269.2023.06.06.09.29.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 09:29:08 -0700 (PDT)
Message-ID: <99c3f05e-0a4c-da22-36b0-ae84910ef4de@linaro.org>
Date: Tue, 6 Jun 2023 09:29:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH] exec/cpu-defs: Check for SOFTMMU instead of !USER_ONLY
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20230605230216.17202-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230605230216.17202-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 6/5/23 16:02, Philippe Mathieu-Daudé wrote:
> We want to check the softmmu tlb availability, not
> if we are targetting system emulation. Besides, this
> code could be used by user emulation in the future.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
> Based-on:<20230605222420.14776-1-philmd@linaro.org>
> 
> See also
> https://lore.kernel.org/qemu-devel/7913570a-8bf6-2ac9-6869-fab87273742c@linaro.org/
> ---
>   include/exec/cpu-defs.h | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

