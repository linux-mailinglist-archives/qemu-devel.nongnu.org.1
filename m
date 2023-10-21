Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD987D1BB3
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 10:00:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu6tN-0004Iu-7Q; Sat, 21 Oct 2023 03:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qu6tL-0004Gw-6U
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 03:59:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qu6tJ-0000mW-Qp
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 03:59:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697875164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UFfh7Mym3N1f59nnB/Tc9AbogyzZF0uImQqbCQhOZA8=;
 b=D56cz/TfmZOBV/3b3Bk9dwpmub6lJs5At4rL1d+utKb0OX6SQmoWWFEVcmuYjrMioTLMvb
 hCLv2MR7ZDq6bPBDLOwd7xIFmot3b+V9FL43Dvod0EupzAzAdh+DZ299Es8L1D6XOg5kde
 llYSrML6SbxRhF9Jw1+jRmq9x4mOjkM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-mSax1mIUNtuWD9QJKr59jQ-1; Sat, 21 Oct 2023 03:59:22 -0400
X-MC-Unique: mSax1mIUNtuWD9QJKr59jQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9c778321afdso63130666b.1
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 00:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697875160; x=1698479960;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UFfh7Mym3N1f59nnB/Tc9AbogyzZF0uImQqbCQhOZA8=;
 b=JHqQQhXmJzaHEWJFOT0jhA6yckDuYpf4iZNsDaO1ieO+lVpQfNkZFgzHGt6NLC3Qgu
 hH3fPdSl10mzDZGCaUzbO2fZ4pJTO59jttfnVnNslitItM3cpSBPeb2fhtmBa/Bkvobi
 HUMIQ2rAW6tXNDDlxn5QT/1qQWOqa/z6ttB9k3GUPvQFKzM+XEFXJ3v5AAst31/dJzxv
 sc30zh+wP9W/ldXZd5X37p9hIzWzDR6yUL4i5VZ2DdwxvkRMaZQT0NVB5cYwJaPinKPI
 Ihz7K+RN1QHk99wn8BcwsmEIwwceL2ED2/sH8WHGBV9zd0Zu9jPdxWxcDZM90hgVM90D
 R6Ag==
X-Gm-Message-State: AOJu0Yzcz5+LXjBeVJGsAi1YKtd4Elz07gmjhvNBPHvpQBR5vr7FVYnl
 4LZbYJr6NY7/svQzEsrBJNV9gopSis646DzlUFJS+YgLM/Gmjncg+hr9kVdTIcUIjcx1hI8KHuG
 ZaznBkvH+QiNa8SU=
X-Received: by 2002:a17:906:dc8b:b0:9bf:f20:8772 with SMTP id
 cs11-20020a170906dc8b00b009bf0f208772mr3492553ejc.26.1697875160682; 
 Sat, 21 Oct 2023 00:59:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwowrL60ls83tLo9pe2ZakHLzIXaPmDhknM0xrZdZD3tO/4ScNlYhieiSp9nR6nGAFZDmyjA==
X-Received: by 2002:a17:906:dc8b:b0:9bf:f20:8772 with SMTP id
 cs11-20020a170906dc8b00b009bf0f208772mr3492546ejc.26.1697875160359; 
 Sat, 21 Oct 2023 00:59:20 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:48f9:bea:a04c:3dfe?
 ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.googlemail.com with ESMTPSA id
 k2-20020a1709067ac200b0099bcf1c07c6sm3114093ejo.138.2023.10.21.00.59.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Oct 2023 00:59:19 -0700 (PDT)
Message-ID: <03ba02fd-fade-4409-be16-2f81a5690b4c@redhat.com>
Date: Sat, 21 Oct 2023 09:59:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] target/i386: Use tcg_gen_ext_tl
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, laurent@vivier.eu, ysato@users.sourceforge.jp,
 kbastian@mail.uni-paderborn.de, jcmvbkbc@gmail.com
References: <20231019182921.1772928-1-richard.henderson@linaro.org>
 <20231019182921.1772928-4-richard.henderson@linaro.org>
 <5f54e3e1-1c90-0249-04f4-df522e292abe@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <5f54e3e1-1c90-0249-04f4-df522e292abe@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/19/23 23:57, Philippe Mathieu-Daudé wrote:
> On 19/10/23 20:29, Richard Henderson wrote:
>> -    default:
>> +    if (memop_size(size) == TARGET_LONG_BITS) {
>>           return src;
>>       }

Any opinions about adding something like this on top?

------------------------- 8< -------------------------------
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] include, target/i386: define and use MO_TL

This will also come in handy later for "less than" comparisons.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/include/exec/target_long.h b/include/exec/target_long.h
index 93c9472971f..3cd8e26a23f 100644
--- a/include/exec/target_long.h
+++ b/include/exec/target_long.h
@@ -29,12 +29,14 @@ typedef uint32_t target_ulong;
  #define TARGET_FMT_lx "%08x"
  #define TARGET_FMT_ld "%d"
  #define TARGET_FMT_lu "%u"
+#define MO_TL MO_32
  #elif TARGET_LONG_SIZE == 8
  typedef int64_t target_long;
  typedef uint64_t target_ulong;
  #define TARGET_FMT_lx "%016" PRIx64
  #define TARGET_FMT_ld "%" PRId64
  #define TARGET_FMT_lu "%" PRIu64
+#define MO_TL MO_64
  #else
  #error TARGET_LONG_SIZE undefined
  #endif
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index b0d62e83445..7bf7406dd8e 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -701,7 +701,7 @@ static inline void 
gen_op_movl_T0_Dshift(DisasContext *s, MemOp ot)

  static TCGv gen_ext_tl(TCGv dst, TCGv src, MemOp size, bool sign)
  {
-    if (memop_size(size) == TARGET_LONG_BITS) {
+    if (size == MO_TL) {
          return src;
      }
      tcg_gen_ext_tl(dst, src, size | (sign ? MO_SIGN : 0));
-----------------------------------------------------------

I can add it in my x86 series if desirable (I also have an
occurrence of memop_size(ot) < TARGET_LONG_BITS there, and it
can become just "ot < MO_TL").

>> +    tcg_gen_ext_tl(dst, src, size | (sign ? MO_SIGN : 0));
>> +    return dst;
>>   }
> 
> While here, I'd rename 'size' -> 'mop'. Regardless,

Not sure about that, because "size" should be just the low bits of MemOp 
(the MO_SIGN bit is passed separately).

Paolo


