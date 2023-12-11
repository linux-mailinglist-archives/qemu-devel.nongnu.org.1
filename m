Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A88CA80D945
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 19:52:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rClNw-0001j6-6R; Mon, 11 Dec 2023 13:52:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rClNt-0001ij-Pi
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 13:52:06 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rClNs-0002Qz-6B
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 13:52:05 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5bdbe2de25fso3993694a12.3
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 10:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702320722; x=1702925522; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VSHTPrTO1YDu+SYuuwmsfV8T4OVjkfuAl8wEZHyw7yw=;
 b=iI/JEZ+PIsFgHobS53rdvcEV5AA+r7UnfphRMRCi5RUKLZs8n6NCgpOqrPWDE94XlT
 8yMZUlKlIoW3xb4ubA9q0rVI2LASivxNsHh0tPNsjSJgBYhW3Cecg+kBjxXhLsBYqH7S
 Wib8FegxKOLVC0mwVPmwBXBmawe+kDL9OoNBJVvnglsyOpEZK8XbSaXtUZCPMc7fQo+6
 VL2unIq/kT1NxDb/W8U7IwjMqouMCLDZNT4I6s8IXdU5v+GqPKxPWhOda0hmwv0yc5n0
 QW7lj25Ngux+vq/vYezqOyQvegogdXUXrTqk97a0J4w8fLQFhhoglR9zSc8rYrMBE9yh
 KyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702320722; x=1702925522;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VSHTPrTO1YDu+SYuuwmsfV8T4OVjkfuAl8wEZHyw7yw=;
 b=P4BFkYWWnTFAP/3rsAThgpQsCdco2gQt1L241Hukp5XLrCvLnmLrAlAfkmxgTYqpoW
 HmY9CedPZZKgrWIbWsSuxsmCSMi1DpJlBUvKoipgdFqencg7Yw1ICx60O1I+XHT53BRu
 ktWoA0BrNCfbI04GQhQvTgmsE6dw5u0KNi4zhgQJW9lbDA76trVv+8OC0M8YT1EcZlF4
 ZsyBkLKQeXo7Y/UQVxYrl/zHJehrtEJ6jc8AAUqzRXudmvT9wLhz4SeouHIFoPYxH7MI
 1CqnBxyG7EZ1t3OcwhD9PL9nvdqjRVeje6Cbysux+vhEyiu1835rKNS8f2bA2MkezZYj
 tClA==
X-Gm-Message-State: AOJu0YzouRL5SyrUkFca01qdQyJdgzP+tNhvsCW1q83jcCPnKXD6FEY7
 SMheUe4yQyKfoumenueAfJ54Og==
X-Google-Smtp-Source: AGHT+IEn3Etw7pjYoyk2Tfp0fMBvM7SB9QF0fFh/TM4dwkDYuPAf2hws9EpvudknDfCCOvBNw1popg==
X-Received: by 2002:a17:90a:fd03:b0:286:8abe:4d42 with SMTP id
 cv3-20020a17090afd0300b002868abe4d42mr3903399pjb.21.1702320722369; 
 Mon, 11 Dec 2023 10:52:02 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 k6-20020a17090ad08600b00286117f8c15sm8802731pju.4.2023.12.11.10.52.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 10:52:02 -0800 (PST)
Message-ID: <689acd01-fbd5-44a2-a1c9-cef4ea2b734d@linaro.org>
Date: Mon, 11 Dec 2023 10:52:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] accel/tcg: Move perf and debuginfo support to tcg
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20231208003754.3688038-1-iii@linux.ibm.com>
 <20231208003754.3688038-5-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231208003754.3688038-5-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

On 12/7/23 16:35, Ilya Leoshkevich wrote:
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -63,7 +63,7 @@
>   #include "tb-context.h"
>   #include "internal-common.h"
>   #include "internal-target.h"
> -#include "perf.h"
> +#include "tcg/perf.h"
>   #include "tcg/insn-start-words.h"

Because this header is used outside of tcg/, the header should be include/tcg/perf.h.

> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index e7a9b3775bb..b8e52f3fb0f 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -62,7 +62,7 @@
>   #include "hw/boards.h"
>   #include "qemu/cutils.h"
>   #include "sysemu/runstate.h"
> -#include "accel/tcg/debuginfo.h"
> +#include "tcg/debuginfo.h"
>   
>   #include <zlib.h>
>   
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index cf9e74468b1..62120c76151 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -21,7 +21,7 @@
>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
>   #include "target_signal.h"
> -#include "accel/tcg/debuginfo.h"
> +#include "tcg/debuginfo.h"
>   
>   #ifdef TARGET_ARM
>   #include "target/arm/cpu-features.h"

Likewise.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


