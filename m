Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF5878D05F
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:23:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7nu-0001lD-27; Tue, 29 Aug 2023 19:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb5PB-0005gh-GU
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:33:41 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb5P9-0005FO-92
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:33:41 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-68a41035828so3459532b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 13:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693341218; x=1693946018; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gEgueKAEhPc4adZidRuM/Kwt6NHkFRGUEyQUOls9iP4=;
 b=FB6CF08oy9a/lheuS8Y5EXzG9y2sS8Q8QfYs2VwxSIweKbsX06dzKFaJkIhNAb7M6Q
 fv9G46AxHk5cEtObdLeuGfK3pThNcXA9CB7313EzgC1V+C8JjgDwWrO7oskgEMhtEfQk
 px218KhzH/yeLm+fMHEECV5+Os15pNW+qSkpxuKcFq9edK9TCcE7SBLE/JbStO3e74Yu
 1u7xg2W9GmCymzJWwzr4mWGGH7cS5q+I+UOxL2wfC0Bdx+3Kek5HYTN7RINEy/XZATRd
 z0NctSXc0tM6ZRJAIYZvn0DBPTtqTjh4QmtSJoEJYeOXynru6RVeppK/GVCZmVxlqU6Q
 IOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693341218; x=1693946018;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gEgueKAEhPc4adZidRuM/Kwt6NHkFRGUEyQUOls9iP4=;
 b=cDWH2ec5r8Ja4N6VZoCp+QnG5Pli6SEf+bZRs3M2AzbJcFMaSP9nj1tnEn3vM9xFCM
 /8AboO+Cmp/rl9RVnhO+5+UwdFmAn9EMzmwCSolaexrSFFovFimTwG/jvPndO4UAuGRw
 hh34yKrKwVEuBfgLF6Pbs4pAZwOpzZWE+jGCo7v0g1I1PiUaAaIeRkD4nNLxF54byVk3
 H2lIBphghA8hNUtCviyBos2pvm1fk/zKcGaWz6uAWKKWNnJOjcuiPsCnIQEn0dUhxr/C
 NijNVwLtYwLjWumyfXspprWLlK830KEYG8FEKwAUXl3sFQtjdoRDarlSExo5vbrKeNWU
 RYaQ==
X-Gm-Message-State: AOJu0YyEqB/WQxExFObJ9gaOTpOZPw9CxPbciigpP91tjLjfP1qZnLjj
 /RroeySAMiqKesEqdfC/hFMWYA==
X-Google-Smtp-Source: AGHT+IHnWpfjiSwWCz7vmDkySFnct9N0vA+n9jLNzNRThw843hrNfNWCtTeMzvccUmrwlRTOlzdr9g==
X-Received: by 2002:a05:6a00:1a8b:b0:68a:6cf0:cdf8 with SMTP id
 e11-20020a056a001a8b00b0068a6cf0cdf8mr333156pfv.21.1693341217778; 
 Tue, 29 Aug 2023 13:33:37 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 y1-20020aa78541000000b006879493aca0sm8878603pfn.26.2023.08.29.13.33.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 13:33:37 -0700 (PDT)
Message-ID: <555c5897-49aa-b04f-6977-3f1984730f82@linaro.org>
Date: Tue, 29 Aug 2023 13:33:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 28/32] bsd-user: Implement setloginclass(2) and
 getloginclass(2) system calls.
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-29-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230827155746.84781-29-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/27/23 08:57, Karim Taha wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/freebsd/os-proc.h    | 32 ++++++++++++++++++++++++++++++++
>   bsd-user/freebsd/os-syscall.c |  8 ++++++++
>   2 files changed, 40 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

