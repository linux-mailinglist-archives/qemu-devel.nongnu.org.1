Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 959BCA256D8
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Feb 2025 11:23:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tetbU-0002SQ-FT; Mon, 03 Feb 2025 05:22:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tetbQ-0002SF-0W
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 05:22:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tetbO-0007WG-Jf
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 05:22:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738578168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5LYvQ0nwxIRwJ389A3uM1hhmrhhshv9o13FotOu8Q9c=;
 b=XmevsyIGXxlLcyLjnCmdxo78mKIlmdMtj81GL2XxyvtH0pSbpm5NFiI4kEjUhh/u94HjpN
 1b30lUyJdG7DfinX6ZooPQ18MoH6+w2Fk9recLM4o2Rh0Fq04YHNMoM+wJ8XTfbgpc1aaB
 mkDmOxJ5VdrXJlFzX2DLewt2QfnPzjg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-h870gS2jN3idY5MMw-xJdw-1; Mon, 03 Feb 2025 05:22:47 -0500
X-MC-Unique: h870gS2jN3idY5MMw-xJdw-1
X-Mimecast-MFC-AGG-ID: h870gS2jN3idY5MMw-xJdw
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43625ceae52so21917675e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 02:22:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738578166; x=1739182966;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5LYvQ0nwxIRwJ389A3uM1hhmrhhshv9o13FotOu8Q9c=;
 b=Ezlr8bSdoR5Sdact9/mfj2FfgF4mMlsBR8AHwOEa4cN/Gk3AZkKCBQVnnzaM8QtZqG
 3G/rHp436SLEbLv+J3lK9WvDgkOjPfZua3hi4zgarqmJ8nuPSUliVgizviB76ESEvgKn
 Z8gTPwUjisbJWxe+9Dqshy6b2kGcAVq0b/cpklveGOlOU38k7lUcoIQC4Zj7UNG5Vp2J
 zu8bLgFJ/TRI1h8WhrAwQZWF2LQ3ilXYbJ037Dsf3FJ6R9uU7t9+hG1FPqiG8fbep90l
 X1ULduEfC/7vbyiOvhd8Xdt94vZKQSSsPB/PCTwnbzP0XZxOU3usBjpWYPXZL07Qi2vZ
 Fjaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVk2iB3wN5tX+4ceB0YW1VQr8JYtfVe8iy3FCd3CfJ1isuCjhDkAqYF82fbNlxjAyrAlfRFD7iqx283@nongnu.org
X-Gm-Message-State: AOJu0YzF/NTyUXCKVxMu9kt2kEBpR5joA+9r9qmKtDhcA0x9YcTFQcSR
 JSwP9nFS2erYmK8k0rzrw2dKkyQmlPUMQClm80DP1tfNDfye7CDMJGjfaLDM0UcQJyDIJ4YHg6G
 8GfWji4IqMtyAbKcOnGYErqSgPeziiaEok+c2v2EP4EXRIz3OiEQC
X-Gm-Gg: ASbGncuJevAArgSmz8CdvTPw0vDM18epGaiQa+P++LEdhuK0Vkzvu0/roN5JMCSCC/U
 QaYfQ1PzYIIDJQKbwzy6kI9Q8BAzYnQoqfWxllZAvNDaflW6Vlzh3py/vPb7K8zPyK8Aw9csttJ
 jF8u5/DEpM8nPCJ6uYy8vhEI2RvLsU17RibBA3FMNc+1eroX+rUrL9f+8T0ykTTgjN9du9xMOiq
 qIkR4wcf8fu6SF0HKR50mtQjL30ntRrOr7pBqwK9+EfTZlK+EQKfHeXmxkwA3ijU+eqeXbXXrSh
 342wkll5LjdKP2Wq8CpBeAWnrdEBww==
X-Received: by 2002:a05:600c:1d07:b0:436:aaf:7eb9 with SMTP id
 5b1f17b1804b1-438dc3fc344mr169116565e9.20.1738578166391; 
 Mon, 03 Feb 2025 02:22:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtH/malSVpIp3ZhUy8Q1N2g6Yk2IOMzgq+61OG/5KD13A+hxZ8A/Fh6MJWESMuSHWazSlMuQ==
X-Received: by 2002:a05:600c:1d07:b0:436:aaf:7eb9 with SMTP id
 5b1f17b1804b1-438dc3fc344mr169116375e9.20.1738578166024; 
 Mon, 03 Feb 2025 02:22:46 -0800 (PST)
Received: from [10.33.192.228] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23e6984sm149013845e9.22.2025.02.03.02.22.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 02:22:45 -0800 (PST)
Message-ID: <cb6859a5-f4fc-4f7a-8e32-5aa2be3ee7be@redhat.com>
Date: Mon, 3 Feb 2025 11:22:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] accel/stubs: Expand stubs for TCG
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org
References: <20250203031821.741477-1-richard.henderson@linaro.org>
 <20250203031821.741477-8-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250203031821.741477-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 03/02/2025 04.18, Richard Henderson wrote:
> Add tcg_allowed, qmp_x_query_jit, qmp_x_query_opcount.
> These are referenced when CONFIG_TCG is enabled globally,
> but not for a specific target.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/stubs/tcg-stub.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
> index 7f4208fddf..9c2e2dc6e1 100644
> --- a/accel/stubs/tcg-stub.c
> +++ b/accel/stubs/tcg-stub.c
> @@ -13,6 +13,18 @@
>   #include "qemu/osdep.h"
>   #include "exec/tb-flush.h"
>   #include "exec/exec-all.h"
> +#include "qapi/error.h"
> +
> +/*
> + * This file *ought* to be built once and linked only when required.
> + * However, it is built per-target, which means qemu/osdep.h has already
> + * undef'ed CONFIG_TCG, which hides the auto-generated declaration.

So why don't we only build this file once?

  Thomas


> + */
> +#define CONFIG_TCG
> +#include "qapi/qapi-commands-machine.h"
> +
> +
> +const bool tcg_allowed = false;
>   
>   void tb_flush(CPUState *cpu)
>   {
> @@ -27,3 +39,15 @@ G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc)
>   {
>       g_assert_not_reached();
>   }
> +
> +HumanReadableText *qmp_x_query_jit(Error **errp)
> +{
> +    error_setg(errp, "JIT information is only available with accel=tcg");
> +    return NULL;
> +}
> +
> +HumanReadableText *qmp_x_query_opcount(Error **errp)
> +{
> +    error_setg(errp, "Opcode count information is only available with accel=tcg");
> +    return NULL;
> +}


