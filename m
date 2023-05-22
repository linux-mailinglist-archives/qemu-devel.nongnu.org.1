Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3CA70BE6A
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 14:36:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q14lL-0001Ux-TS; Mon, 22 May 2023 08:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q14lJ-0001Um-7J
 for qemu-devel@nongnu.org; Mon, 22 May 2023 08:35:41 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q14lH-0008UC-FI
 for qemu-devel@nongnu.org; Mon, 22 May 2023 08:35:40 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-309382efe13so3710200f8f.2
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 05:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684758938; x=1687350938;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N2ItjaF5KYSE01tsDdGRxwHfsgFV3kyKxWeUutjJe3Q=;
 b=KVHRRi2Z7bD0COopJFLDmywWppPF584MA7wW8LojnrrY+9IcBDRoB9p0fYTHwu7zLp
 WqowbHdxaHeI/nY2fxREb1U8QfuO/9/F8EhsNZCmJCX3gc/bMDvuGUD4Avxf52/v5wN3
 tBsSxvzGndyxwuYnfBvuljni5Jh5eBdTJW5+X0Mque0GTmKyh6tWf3KE81xguxVDJF4o
 lx9X3vOAPpYdSULufL3N/tnoCnNguXhdhEgX30K9sXmyfdLbq/VxRQP/ICyy+ozo3SY6
 pBUzuQJAtzj+ZXbCDPRyrUPEcBgzRKM/aBEtfeXWUO4IaaDBEC5Uz9fJbXLbixS7fu0o
 bklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684758938; x=1687350938;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N2ItjaF5KYSE01tsDdGRxwHfsgFV3kyKxWeUutjJe3Q=;
 b=CqM7mMWy7UNMnnhjEaMkHV5QVc1NoleH0t7K4JGoC/aE0oO6C2RRGsvKuNYM9UBZf2
 Trd6MAwOmSPyMU36jlgy88WncReuQZNF6eSEfUuHQBbWyiU51OgYy+NwiEoNo1s61ZUt
 ROtwKpAVWjTYXOVfcO1mm2n4uMp9W6vSVTEEKV0OAUB+JUPeD8kVjiuRpaxtv8HIa96E
 BNVqt0WXmlHFZv3oXKkZZt+amVUoGMTCgRNq0fNES7NmWuh11d7CJYN1X/JZcAemiDxb
 SROB3rq8WJ2zem+y5xOCgwUx9wkptkbhz314jlIb9u4zZw8vzZ2XdyQS3/If0NcquI1I
 O0uA==
X-Gm-Message-State: AC+VfDxg9WFxDjfAc4bvmV3nWBnjH4gYgRAYqX99VhUh1CX2xEOOzG16
 8wOzRcC4eZ9XSwFXZk7Od4l2ySU090h+StdGEkE=
X-Google-Smtp-Source: ACHHUZ59rzkbZYh+zkLScYSn9bwdGXftNnqWQazIq3zzZuRJLF4Bf80REeZiduNEI7QjKkH4znjzfA==
X-Received: by 2002:adf:fa89:0:b0:307:6278:611a with SMTP id
 h9-20020adffa89000000b003076278611amr7521360wrr.21.1684758937857; 
 Mon, 22 May 2023 05:35:37 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.153.164])
 by smtp.gmail.com with ESMTPSA id
 f18-20020adfdb52000000b002f7780eee10sm7675725wrj.59.2023.05.22.05.35.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 May 2023 05:35:37 -0700 (PDT)
Message-ID: <865a9b78-0fd7-2cc8-8e51-0b8b1b34e514@linaro.org>
Date: Mon, 22 May 2023 14:35:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH] crypto: Always initialize splitkeylen
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
References: <20230522114737.32686-1-akihiko.odaki@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230522114737.32686-1-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 22/5/23 13:47, Akihiko Odaki wrote:
> When _FORTIFY_SOURCE=2, glibc version is 2.35, and GCC version is
> 12.1.0, the compiler complains as follows:
> 
> In file included from /usr/include/string.h:535,
>                   from /home/alarm/q/var/qemu/include/qemu/osdep.h:99,
>                   from ../crypto/block-luks.c:21:
> In function 'memset',
>      inlined from 'qcrypto_block_luks_store_key' at ../crypto/block-luks.c:843:9:
> /usr/include/bits/string_fortified.h:59:10: error: 'splitkeylen' may be used uninitialized [-Werror=maybe-uninitialized]
>     59 |   return __builtin___memset_chk (__dest, __ch, __len,
>        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     60 |                                  __glibc_objsize0 (__dest));
>        |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../crypto/block-luks.c: In function 'qcrypto_block_luks_store_key':
> ../crypto/block-luks.c:699:12: note: 'splitkeylen' was declared here
>    699 |     size_t splitkeylen;
>        |            ^~~~~~~~~~~
> 
> It seems the compiler cannot see that splitkeylen will not be used
> when splitkey is NULL. Suppress the warning by initializing splitkeylen
> even when splitkey stays NULL.

What about using splitkeylen instead?

-- >8 --
diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 5688783ab1..dfba98fdc1 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -696,7 +696,7 @@ qcrypto_block_luks_store_key(QCryptoBlock *block,
      QCryptoBlockLUKS *luks = block->opaque;
      QCryptoBlockLUKSKeySlot *slot;
      g_autofree uint8_t *splitkey = NULL;
-    size_t splitkeylen;
+    size_t splitkeylen = 0;
      g_autofree uint8_t *slotkey = NULL;
      g_autoptr(QCryptoCipher) cipher = NULL;
      g_autoptr(QCryptoIVGen) ivgen = NULL;
@@ -839,7 +839,7 @@ cleanup:
      if (slotkey) {
          memset(slotkey, 0, luks->header.master_key_len);
      }
-    if (splitkey) {
+    if (splitkeylen) {
          memset(splitkey, 0, splitkeylen);
      }
      return ret;
---

> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   crypto/block-luks.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> index 5688783ab1..2f59c3a625 100644
> --- a/crypto/block-luks.c
> +++ b/crypto/block-luks.c
> @@ -706,14 +706,14 @@ qcrypto_block_luks_store_key(QCryptoBlock *block,
>   
>       assert(slot_idx < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS);
>       slot = &luks->header.key_slots[slot_idx];
> +    splitkeylen = luks->header.master_key_len * slot->stripes;
> +
>       if (qcrypto_random_bytes(slot->salt,
>                                QCRYPTO_BLOCK_LUKS_SALT_LEN,
>                                errp) < 0) {
>           goto cleanup;
>       }
>   
> -    splitkeylen = luks->header.master_key_len * slot->stripes;
> -
>       /*
>        * Determine how many iterations are required to
>        * hash the user password while consuming 1 second of compute


