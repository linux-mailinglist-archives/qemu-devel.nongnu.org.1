Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABDE81FB8C
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 23:29:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIysN-0004bS-FO; Thu, 28 Dec 2023 17:29:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIysL-0004bG-CB
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 17:29:13 -0500
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIysJ-0002AT-Vu
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 17:29:13 -0500
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-35fe8a4b373so17113835ab.1
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 14:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703802550; x=1704407350; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H43LH6tPseKbqyZgazpyzrDbPP0mU75iKzhZQX9KBT4=;
 b=rw/8jEc15MwBiRu4EXnqzyRGINVqohgsjbzmYAGAEiKBxif3gG4BmW7ZY+wqOg7uVW
 T+qZlJyXaCT6GFvRrtkS136Z+bmbU0Z/WHv9hMpVxr/Aj8/msG8XWu8KcI8lxVDG0JyE
 qYfcNnSZgULob4NcT/ctSofo75dVe/l6KnnLgnFVIETybg2Hcqv8UpiA4RwKyUo6oYZO
 CcgR4MykbC7JPhKgrwdTMEauYb3kvmWzEX90wW3YWLQLZRsM/yPYrr7+mg3PIbGX3yqY
 0m/OsojuTgROzNVTJtFWJpPJI0D7Lt48l8geS+jBgzQ31hh5MYSSF0apA+g9S4G1BBcV
 KaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703802550; x=1704407350;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H43LH6tPseKbqyZgazpyzrDbPP0mU75iKzhZQX9KBT4=;
 b=Q0SHzkWm5ycV/W3uEhqkvUrMrBNrGJxpBLu/37V1syO/EuZuUf/3LkD8XPOyZNG0pr
 rimxFBnwTkt4TTA7PpkVB6kh/oUj8eo/9osDZOSHHDFMBFrhJxsPBJmXYmbhWdGJmZqh
 zNgZ86wMGrWZyzT6Fd7Unc4Izbkesu449TOezpxUubu32LkK8BCXynQ7Ej/ukMJUdacE
 tHqrdwDyBLsATKjkkh1f+UioO7kTZopGAzeZDscf8OQv1FSNm1OOuFYq6tZBUK6zpmBt
 xKbCRt5gKjc4QSg3cgMxbY81uEtvtFj+cPliQhTPEL1DfnTT11DGuBZSoT6Bf0PaLXgl
 8spw==
X-Gm-Message-State: AOJu0YxLwnb/9p4nCiGbFjaUsTqRPCwvFqVzGBibzBYMUf6BD4KnFEMf
 FuNWP9m9bOSCzUGYRpHr8TPesp5g83BF2Q==
X-Google-Smtp-Source: AGHT+IGJhHNJ/awtkHjaUbXY88xA/LUs6PwbtvhkojfcXy3K1JUTzQ/HQyjdWaLdsEgSiOXvKthDlg==
X-Received: by 2002:a05:6e02:20cd:b0:35d:4490:c886 with SMTP id
 13-20020a056e0220cd00b0035d4490c886mr13023599ilq.12.1703802550627; 
 Thu, 28 Dec 2023 14:29:10 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:324d:cbc2:5f8b:3a9d?
 ([2001:8003:c020:6900:324d:cbc2:5f8b:3a9d])
 by smtp.gmail.com with ESMTPSA id
 2-20020a630d42000000b005cd64ff9a42sm13240667pgn.64.2023.12.28.14.29.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Dec 2023 14:29:10 -0800 (PST)
Message-ID: <15589a13-9ac1-46cb-9a2e-d9ba25195216@linaro.org>
Date: Fri, 29 Dec 2023 09:29:05 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/22] target/i386: move operand load and writeback out of
 gen_cmovcc1
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231222181603.174137-1-pbonzini@redhat.com>
 <20231222181603.174137-20-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231222181603.174137-20-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::130;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x130.google.com
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

On 12/23/23 05:16, Paolo Bonzini wrote:
> Similar to gen_setcc1, make gen_cmovcc1 receive TCGv.  This is more friendly
> to simultaneous implementation in the old and the new decoder.
> 
> A small wart is that s->T0 of CMOV is currently the*second*  argument (which
> would ordinarily be in T1).  Therefore, the condition has to be inverted in
> order to overwrite s->T0 with cpu_regs[reg] if the MOV is not performed.
> 
> This only applies to the old decoder, and this code will go away soon.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 16 ++++++----------
>   1 file changed, 6 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

