Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFA670BF35
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 15:08:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q15Gs-00034n-Ji; Mon, 22 May 2023 09:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q15Gp-00034N-Ej
 for qemu-devel@nongnu.org; Mon, 22 May 2023 09:08:15 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q15Gl-0006mU-0n
 for qemu-devel@nongnu.org; Mon, 22 May 2023 09:08:14 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2553f2706bfso1335948a91.1
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 06:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684760888; x=1687352888;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EVXJnOLI0hplD0jQu5lL5VXYWcNwPBPx9yXB/7ap7pI=;
 b=cgO1tFTAVK4NVwTNtsgAGTFK+gzTHbYchr9rHE/NSHm3P41zf2E3skBw8azLEbmbfP
 EBrI2eTetckGIulWiMT7Ty97NOEY0s/qnp9TDMyN6jmAD/Rr7/uLRWKDuYHk7/eL/S6Z
 jTY08bewpTM0TUWSWvi2mWUb6bCSN95m+WSTiy1+nWPEnCzxQ9CmbM849S5BM5X/P42u
 WQEbre1RSOEOn+Es5uwg6Z/1N5aEMExMS0h3kCH1LPP5SvS1u1t2Zdf18kksg7Js1GMQ
 Y947Jj1COOepsu1q1YKq117oRRPbTbI1TxQ3QjjgPd3g9okDTIdVkG3T+CFc3jKI/QOq
 zHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684760888; x=1687352888;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EVXJnOLI0hplD0jQu5lL5VXYWcNwPBPx9yXB/7ap7pI=;
 b=Ucxz1+JZN4WJivRW7SP8lb4OvQIXxJ9SURo5KK1hxbvxR40K+DihwBq4Ngpb3IJ/MK
 puCBq0vNklDHc0CrmJUciqfp4mmJraGvyXzrdh19vWduwc0AHA1VvLqohgN+53fFwnLl
 nnQo0Xjcg0nsld4zrX1c8MyGLFybaLSpOBpaHofj8us1ob+c6i+/qFaTSda9Db9W/OJo
 u4CYArWK6GyUr/DkNK4ItFSdIy6m8XhPSj0o2h1M9g07Gn46A7zsKrGX0rVIVnlY+6dQ
 rvY4d1Vov/RMlg4ndurzHh00KloEay88pYoLTqx07VnRHwhYRp7+faB6AacSrXOH4/gI
 gWCA==
X-Gm-Message-State: AC+VfDwoZSOV8qdA+yiTvhLfTUQVKC9dwK1I+O3zorAs5M6Ny864wGM+
 zjRf3RRcCjN2d51b81YkvQWjew==
X-Google-Smtp-Source: ACHHUZ7iM7dI6nqeh4y1llgXICf9UWsj/LkpTfPEdf2P8U+7Zc2S7haC37ExGqrSb+EGhR3TkOxdmA==
X-Received: by 2002:a17:90a:b902:b0:24e:201e:dcbd with SMTP id
 p2-20020a17090ab90200b0024e201edcbdmr11335374pjr.21.1684760888142; 
 Mon, 22 May 2023 06:08:08 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 mr15-20020a17090b238f00b0025289bc1ce4sm5764500pjb.17.2023.05.22.06.08.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 May 2023 06:08:07 -0700 (PDT)
Message-ID: <9600b1f2-1be8-60cd-abd0-d73868866b34@daynix.com>
Date: Mon, 22 May 2023 22:08:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] crypto: Always initialize splitkeylen
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
References: <20230522114737.32686-1-akihiko.odaki@daynix.com>
 <865a9b78-0fd7-2cc8-8e51-0b8b1b34e514@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <865a9b78-0fd7-2cc8-8e51-0b8b1b34e514@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On 2023/05/22 21:35, Philippe Mathieu-Daudé wrote:
> On 22/5/23 13:47, Akihiko Odaki wrote:
>> When _FORTIFY_SOURCE=2, glibc version is 2.35, and GCC version is
>> 12.1.0, the compiler complains as follows:
>>
>> In file included from /usr/include/string.h:535,
>>                   from /home/alarm/q/var/qemu/include/qemu/osdep.h:99,
>>                   from ../crypto/block-luks.c:21:
>> In function 'memset',
>>      inlined from 'qcrypto_block_luks_store_key' at 
>> ../crypto/block-luks.c:843:9:
>> /usr/include/bits/string_fortified.h:59:10: error: 'splitkeylen' may 
>> be used uninitialized [-Werror=maybe-uninitialized]
>>     59 |   return __builtin___memset_chk (__dest, __ch, __len,
>>        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>     60 |                                  __glibc_objsize0 (__dest));
>>        |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ../crypto/block-luks.c: In function 'qcrypto_block_luks_store_key':
>> ../crypto/block-luks.c:699:12: note: 'splitkeylen' was declared here
>>    699 |     size_t splitkeylen;
>>        |            ^~~~~~~~~~~
>>
>> It seems the compiler cannot see that splitkeylen will not be used
>> when splitkey is NULL. Suppress the warning by initializing splitkeylen
>> even when splitkey stays NULL.
> 
> What about using splitkeylen instead?

splitkey won't be allocated soon after initializing splitkeylen so using 
splitkeylen can result in NULL dereference.

Besides I think it's better not to initialize splitkeylen with 0 because 
the compiler will not warn even if you mistakenly used the value; if you 
leave the variable uninitialized, the compiler can warn of such a 
mistake. The same logic also applies to the NULL initialization of 
splitkey, but NULL is somewhat safer as dereferencing it results in 
segfault and automatically behaves like an assertion. It seems splitkey 
needs to be initialized anyway because it has g_autofree as you pointed 
out for another patch.

> 
> -- >8 --
> diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> index 5688783ab1..dfba98fdc1 100644
> --- a/crypto/block-luks.c
> +++ b/crypto/block-luks.c
> @@ -696,7 +696,7 @@ qcrypto_block_luks_store_key(QCryptoBlock *block,
>       QCryptoBlockLUKS *luks = block->opaque;
>       QCryptoBlockLUKSKeySlot *slot;
>       g_autofree uint8_t *splitkey = NULL;
> -    size_t splitkeylen;
> +    size_t splitkeylen = 0;
>       g_autofree uint8_t *slotkey = NULL;
>       g_autoptr(QCryptoCipher) cipher = NULL;
>       g_autoptr(QCryptoIVGen) ivgen = NULL;
> @@ -839,7 +839,7 @@ cleanup:
>       if (slotkey) {
>           memset(slotkey, 0, luks->header.master_key_len);
>       }
> -    if (splitkey) {
> +    if (splitkeylen) {
>           memset(splitkey, 0, splitkeylen);
>       }
>       return ret;
> ---
> 
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   crypto/block-luks.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/crypto/block-luks.c b/crypto/block-luks.c
>> index 5688783ab1..2f59c3a625 100644
>> --- a/crypto/block-luks.c
>> +++ b/crypto/block-luks.c
>> @@ -706,14 +706,14 @@ qcrypto_block_luks_store_key(QCryptoBlock *block,
>>       assert(slot_idx < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS);
>>       slot = &luks->header.key_slots[slot_idx];
>> +    splitkeylen = luks->header.master_key_len * slot->stripes;
>> +
>>       if (qcrypto_random_bytes(slot->salt,
>>                                QCRYPTO_BLOCK_LUKS_SALT_LEN,
>>                                errp) < 0) {
>>           goto cleanup;
>>       }
>> -    splitkeylen = luks->header.master_key_len * slot->stripes;
>> -
>>       /*
>>        * Determine how many iterations are required to
>>        * hash the user password while consuming 1 second of compute
> 

