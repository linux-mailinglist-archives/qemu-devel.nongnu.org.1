Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 860D871765A
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 07:47:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Eeh-0001CK-PL; Wed, 31 May 2023 01:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4EeQ-0001BF-FL
 for qemu-devel@nongnu.org; Wed, 31 May 2023 01:45:41 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4EeN-0001VO-9C
 for qemu-devel@nongnu.org; Wed, 31 May 2023 01:45:36 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-4f3bb395e69so6286732e87.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 22:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685511933; x=1688103933;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E1Fjff68RLbel21L6+5YmbzWPyCaYKjf/Kdwx6m8I3o=;
 b=EFmKx+tBz7eFOEtM+fqXfusI1VQ1RpKcy+DwYCCnQRAthj+fspzD10U69chRPMU6fl
 me5vuZ2/QRBzYXpPeki07cvQethG0ZczsNhlY+4PF8Gxoecz1WMUWo3nwBp6Iy7B399q
 DvthdOQMXMgMnHT5I9TBLA18gOjrxm6xXnEsP5a3CtFd7HAfR27Yq3s9lcwEjV3TpBgK
 6137IHwbuVGv2hwwPiNqIwdbxFxyIUTZpricrLcqQ8+o0Hm70zGsGanGJD9Ikt/fyr7y
 DLwoRgzYmgrJpnaMxjWZfhpF6jfiOoGDmCoBEIyZItY3wz9vukLLX8ctTm9irGeQX8b0
 xL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685511933; x=1688103933;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E1Fjff68RLbel21L6+5YmbzWPyCaYKjf/Kdwx6m8I3o=;
 b=lzLL4k1WcJr1mdnFPheAeD/IJvLQS+pygjTdE4RsKD9wAjp9n0b2msRY0l/nJJuiCu
 665IRZta1qKnMiVubaW0YUgd0tkbWQFAup3XTJs0ubX233L0/rKG33J0qFO9SVLK9GGS
 +LiEA8kyoICuozQ0eYXufxx9a9bMjabi3ZZOi5VPtwUBV+6q/U/k6YY0kTTHNf67UEBL
 Su0p6pf3cWuZiRR9ZkyY+xgfrcB7MIJeBET9Rc2YsQbVupVIt5PeDnjTxNBqgfiVFfp7
 oh37fcwUad/fKFzsrUPRto+48+45e2MhzIrhal4jJkn49PqIz7OC6YjDHHmh4gE6LKSX
 lAvA==
X-Gm-Message-State: AC+VfDwQxppTJMioCyA6HJ3al9cNa5GqOYan7HTbNyc+Wwoq4ac+m5/N
 DXd3izqsC0abfwwX4LJaCibthQ==
X-Google-Smtp-Source: ACHHUZ6WmxcukSwr3LHS4YGu/VUVE5dNkZeUF6QHsTFF93IBbFREDBs8sei3n8vvszlfFmes8ba8Lg==
X-Received: by 2002:a05:6512:70:b0:4f4:d710:12d4 with SMTP id
 i16-20020a056512007000b004f4d71012d4mr1860679lfo.17.1685511933448; 
 Tue, 30 May 2023 22:45:33 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 c7-20020a05600c0ac700b003f4fb5532a1sm19223663wmr.43.2023.05.30.22.45.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 22:45:33 -0700 (PDT)
Message-ID: <7edefdfa-04ca-dbf9-8292-e38f96c28c5b@linaro.org>
Date: Wed, 31 May 2023 07:45:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2] hw/cxl: Fix CFMW config memory leak
Content-Language: en-US
To: Li Zhijian <lizhijian@cn.fujitsu.com>, jonathan.cameron@huawei.com,
 fan.ni@samsung.com
Cc: qemu-devel@nongnu.org
References: <20230531023433.8732-1-lizhijian@cn.fujitsu.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531023433.8732-1-lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

Hi Li,

On 31/5/23 04:34, Li Zhijian wrote:
> Only 'fw' pointer is marked as g_autofree, so we shoud free other
> resource manually in error path.
> 
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
> V2: Delete unnecesarry check
> ---
>   hw/cxl/cxl-host.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index 034c7805b3e..787a2e779d2 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -48,7 +48,7 @@ static void cxl_fixed_memory_window_config(CXLState *cxl_state,
>       if (object->size % (256 * MiB)) {
>           error_setg(errp,
>                      "Size of a CXL fixed memory window must be a multiple of 256MiB");
> -        return;
> +        goto err_free;
>       }
>       fw->size = object->size;
>   
> @@ -57,7 +57,7 @@ static void cxl_fixed_memory_window_config(CXLState *cxl_state,
>               cxl_interleave_granularity_enc(object->interleave_granularity,
>                                              errp);
>           if (*errp) {
> -            return;
> +            goto err_free;
>           }
>       } else {
>           /* Default to 256 byte interleave */
> @@ -68,6 +68,12 @@ static void cxl_fixed_memory_window_config(CXLState *cxl_state,
>                                                g_steal_pointer(&fw));
>   
>       return;
> +
> +err_free:
> +    for (i = 0; i < fw->num_targets; i++) {
> +        g_free(fw->targets[i]);
> +    }
> +    g_free(fw->targets);
>   }

IIUC we don't need targets[] before checking errors. What about simply
allocate when we can't fail?

-- >8 --
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 034c7805b3..f0920da956 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -39,12 +39,6 @@ static void cxl_fixed_memory_window_config(CXLState 
*cxl_state,
          return;
      }

-    fw->targets = g_malloc0_n(fw->num_targets, sizeof(*fw->targets));
-    for (i = 0, target = object->targets; target; i++, target = 
target->next) {
-        /* This link cannot be resolved yet, so stash the name for now */
-        fw->targets[i] = g_strdup(target->value);
-    }
-
      if (object->size % (256 * MiB)) {
          error_setg(errp,
                     "Size of a CXL fixed memory window must be a 
multiple of 256MiB");
@@ -64,6 +58,12 @@ static void cxl_fixed_memory_window_config(CXLState 
*cxl_state,
          fw->enc_int_gran = 0;
      }

+    fw->targets = g_malloc0_n(fw->num_targets, sizeof(*fw->targets));
+    for (i = 0, target = object->targets; target; i++, target = 
target->next) {
+        /* This link cannot be resolved yet, so stash the name for now */
+        fw->targets[i] = g_strdup(target->value);
+    }
+
      cxl_state->fixed_windows = g_list_append(cxl_state->fixed_windows,
                                               g_steal_pointer(&fw));

---

