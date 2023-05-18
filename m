Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6CA7082E1
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 15:36:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzdXx-0006TM-IG; Thu, 18 May 2023 09:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzdXr-0006Rp-5j
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:19:51 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzdXp-0004J0-MX
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:19:50 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-64384274895so1455187b3a.2
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 06:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684415988; x=1687007988;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f9kKXTZhfvdboZpnmrKRJAGb3UUgNVNRb2e7/PAKMuc=;
 b=Uil26+XUwjaAM800CEPVVZi5CZ0MHo1YQvDWCmsGzyJzpHwL7Fh7NxXVQIuadHUwbp
 g58hb5gJuVPDtGC5yzePCNrvEDQoThAXeDX7VOWhImrsdA6UQlGVGsRJx+9xGX7f1IJy
 iFtn5iObZshLQS3DRWAkKDa5W2kK5aVu6TiO5HMMzadxitk1mxVTlffR1MNwS2yxQ73n
 0Ka7tDM1JI5lksiKxi9VY61jn5f8rFuAy9DvLh4kiOC+EsmTIlcDKCfkFL9bHaHvmpCa
 wvNbPH/PQ401H+dbtdR8r2HIwuQhSTezb0JFxvGn43W6RnTTidNKlsUFQtx32SHLzh6e
 NoKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684415988; x=1687007988;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f9kKXTZhfvdboZpnmrKRJAGb3UUgNVNRb2e7/PAKMuc=;
 b=PGGW/LipAOxTDYMDFCU8mKV1tOzYwJfBN3YdtZ8WqblOiF8w01J2v9YeOS98YzkWFi
 IQW5r7VMXo6KBXu74ysgUBDWa75MW0P5FK8lkttYKK6/7Vjy9GDRvfPRPfj8DfS7ygQL
 YrSDmMP/gYJsZka4H3DO2OKALAGnur+ZipoVhPQ58UFSqA3h/1byoMK3h7Fxc4Lic8rs
 UEaDGyTq0KwD+G0ptVOvl7asWaxGv+d31YlqVKZE7lZgPhGv2pB6+ccI/AkouQ+tfU0G
 tP/rzEe4YZo8mva6/QCVidAUadXe9fqtW9Ut1mWWKblAoUxGt8ldDMlsRBS4e+DhbfFF
 R0vw==
X-Gm-Message-State: AC+VfDwx3aES1Zcj3/TPvmWkUHlB+x2YZvG2SOx/OxXQds/UXdtph+Bw
 GwkO8l1RSBo4xL4EQr+orHkhR/17dkpcCmpe+xk=
X-Google-Smtp-Source: ACHHUZ664DSj1sIbzbmRp1VEl6VpzLWy0ClKy9c3spP1JUZOGd5wboN1j3DV+C8o4nnN+xtuRfsxWg==
X-Received: by 2002:a05:6a00:1acd:b0:63b:6149:7ad6 with SMTP id
 f13-20020a056a001acd00b0063b61497ad6mr3979865pfv.34.1684415988194; 
 Thu, 18 May 2023 06:19:48 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:5dd2:c230:399b:cdc1?
 ([2602:ae:1598:4c01:5dd2:c230:399b:cdc1])
 by smtp.gmail.com with ESMTPSA id
 s8-20020a62e708000000b0063b8d21be5asm1357523pfh.147.2023.05.18.06.19.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 May 2023 06:19:47 -0700 (PDT)
Message-ID: <146ff261-3367-e844-cfc2-822ee0d1d6e5@linaro.org>
Date: Thu, 18 May 2023 06:19:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] scripts: make sure scripts are invoked via $(PYTHON)
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230518113355.1006000-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230518113355.1006000-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.544,
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

On 5/18/23 04:33, Paolo Bonzini wrote:
> Some scripts are invoked via the first "python3" binary in the PATH,
> because they are executable and their shebang line is "#! /usr/bin/env
> python3".  To enforce usage of $(PYTHON), make them nonexecutable.
> Scripts invoked via meson need nothing else, and meson-buildoptions.py
> is already using $(PYTHON).  For probe-gdb-support.py however the
> invocation in the configure script has to be adjusted.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   configure                     | 2 +-
>   scripts/meson-buildoptions.py | 0
>   scripts/modinfo-collect.py    | 0
>   scripts/modinfo-generate.py   | 0
>   scripts/probe-gdb-support.py  | 0
>   5 files changed, 1 insertion(+), 1 deletion(-)
>   mode change 100755 => 100644 scripts/meson-buildoptions.py
>   mode change 100755 => 100644 scripts/modinfo-collect.py
>   mode change 100755 => 100644 scripts/modinfo-generate.py
>   mode change 100755 => 100644 scripts/probe-gdb-support.py

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

