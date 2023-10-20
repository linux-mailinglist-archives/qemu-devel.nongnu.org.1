Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 389297D1834
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 23:34:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtx5t-00055H-Eq; Fri, 20 Oct 2023 17:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtx5l-000536-Ii
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 17:31:37 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtx5V-0002Xo-JJ
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 17:31:36 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9c3aec5f326so506523666b.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 14:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697837476; x=1698442276; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=891EOWHoVF3maRNwEY4z2GxQHRfqrIU4DL+QdWbAKe0=;
 b=V41alRY+PFGkvCdZKSPh3YtUB3xXEGD1KEbPrMYL2IMCWKUqKI7Ui/tWkG+rU/rwyr
 19sY+rfvFa0506YrriuSdOYjys6tgIACGfQaCWCCWMTh/BhAtofTfkUtNN0+Jtbd60Rl
 sYRV8q3vVMe0/3fv1aSQYajcZv9H3aP5W2ZEayNx9k+DyR39FTt6v/RpHlYR0107zTBN
 tTs6xZKBe5fT9ddrDpyavu4DLtWvhvRDWZbNiux+iIXTVRQSyXnRGeDuuUj2wIF3bGR9
 Yzl9Dg9dkKuwiUejhVBwBKqkrZnuDhC8UaxcKmLnhb83AlNBTxGjEhzY4BigwlB9tcDO
 53VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697837476; x=1698442276;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=891EOWHoVF3maRNwEY4z2GxQHRfqrIU4DL+QdWbAKe0=;
 b=w54m4M1xsPWcWL5iKdUv6g9PvtX4a9rTSf+xzjrUY1D4K3nRgD9ZV3+Ho6c+Tof0Qn
 i/A5nQQIqkorHHO/mh9OOfVzJo39ffb4MxdgarqXYIxp/bpq+CZhfJznwnTjyGN+/5n+
 J2VdK4DrhizHVNPuo9a6RXAVi3SOTwpud2uHKrvWJfDa2vCr7feGTCSZ06UWYTDxwetG
 pDZ4nhtyJp1xXdmM7xMCzGyRsrLcoAEF2trddJ+7IVYPDnrOhTzSSLTFlQaXztTDKliB
 FcGLTYMmE111lAau5FzQhDDpHKP7Pv8/wY8H0Hspw0XGA101ZjvoU9aaHNx0TufJ1V7x
 X0EQ==
X-Gm-Message-State: AOJu0YwxbdwiNe4ej4hD7hUxRRCb7GbfdQojJVb76ad3UdaUARL4hx4D
 4fZTk2biLNVnfqZxPQ/77xS5JQ==
X-Google-Smtp-Source: AGHT+IFZMIQ05t2m4K9fUf3kgz59LCnc1TyOvoSHTgMCo24fT5caHJ1wXBYzwAQNBvhmKvAHQRlUOg==
X-Received: by 2002:a17:907:3da9:b0:9bd:a66a:a22 with SMTP id
 he41-20020a1709073da900b009bda66a0a22mr2402840ejc.15.1697837475812; 
 Fri, 20 Oct 2023 14:31:15 -0700 (PDT)
Received: from [192.168.69.115] (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 sd26-20020a170906ce3a00b009a5f1d15644sm2209794ejb.119.2023.10.20.14.31.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Oct 2023 14:31:15 -0700 (PDT)
Message-ID: <c8b85257-01da-95c9-1622-909a67522437@linaro.org>
Date: Fri, 20 Oct 2023 23:31:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 47/65] target/hppa: Remove TARGET_REGISTER_BITS
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20231020204331.139847-1-richard.henderson@linaro.org>
 <20231020204331.139847-48-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231020204331.139847-48-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

Hi Richard,

On 20/10/23 22:43, Richard Henderson wrote:
> Rely only on TARGET_LONG_BITS, fixed at 64, and hppa_is_pa20.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hppa/cpu-param.h  |   1 -
>   target/hppa/cpu.h        |  50 ++++-------
>   target/hppa/helper.h     |  49 +++++------
>   target/hppa/cpu.c        |   2 +-
>   target/hppa/helper.c     |  34 +++-----
>   target/hppa/int_helper.c |  17 ++--
>   target/hppa/machine.c    |   9 --
>   target/hppa/mem_helper.c |  10 +--
>   target/hppa/op_helper.c  |  30 +++----
>   target/hppa/sys_helper.c |   4 +-
>   target/hppa/translate.c  | 184 ++++++++-------------------------------
>   11 files changed, 119 insertions(+), 271 deletions(-)

A bit tedious to review, but very nice!

> diff --git a/target/hppa/machine.c b/target/hppa/machine.c
> index 0c0bba68c0..ab34b72910 100644
> --- a/target/hppa/machine.c
> +++ b/target/hppa/machine.c
> @@ -21,21 +21,12 @@
>   #include "cpu.h"
>   #include "migration/cpu.h"
>   
> -#if TARGET_REGISTER_BITS == 64
>   #define qemu_put_betr   qemu_put_be64
>   #define qemu_get_betr   qemu_get_be64
>   #define VMSTATE_UINTTR_V(_f, _s, _v) \
>       VMSTATE_UINT64_V(_f, _s, _v)
>   #define VMSTATE_UINTTR_ARRAY_V(_f, _s, _n, _v) \
>       VMSTATE_UINT64_ARRAY_V(_f, _s, _n, _v)

Total 6 uses, let's use in place, removing the
definitions.

> -#else
> -#define qemu_put_betr   qemu_put_be32
> -#define qemu_get_betr   qemu_get_be32
> -#define VMSTATE_UINTTR_V(_f, _s, _v) \
> -    VMSTATE_UINT32_V(_f, _s, _v)
> -#define VMSTATE_UINTTR_ARRAY_V(_f, _s, _n, _v) \
> -    VMSTATE_UINT32_ARRAY_V(_f, _s, _n, _v)
> -#endif

IIUC for TARGET_REGISTER_BITS == 32 we need:

-- >8 --
  static const VMStateDescription vmstate_env = {
      .name = "env",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
      .fields = vmstate_env_fields,
  };
---

(or better, keeping back-compat).

But to simplify I'd do it generically, regardless
of TARGET_REGISTER_BITS.

Regards,

Phil.

