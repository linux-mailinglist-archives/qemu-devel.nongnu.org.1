Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B247E9A63
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 11:36:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2UI8-0005HU-Oj; Mon, 13 Nov 2023 05:35:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2UHZ-00056D-Mj
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 05:35:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2UHX-0003sD-Pn
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 05:35:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699871701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PEQIri7VdaFKnh39IYsyiZxjMYqUiG0TME3ZF3C0ddU=;
 b=XtZqA+f4+mEmihwc2yhuu0Pb7wg14OuZE0FrPUARfUwtALpfaDJURIqoQ1Ic/6RsdwLQEq
 8g2pFeC5qyL3RJhItkRJ2b3Eqvm4L92v+NbLKBH1xY2OyqHYUaxDzJnDe8OSk/988ROg+W
 KKEHyiQK/33uXV3paDR3wp1+ZF/RbDw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-fLUff882P5OvJH73P3bzQQ-1; Mon, 13 Nov 2023 05:34:59 -0500
X-MC-Unique: fLUff882P5OvJH73P3bzQQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-77893b0a2cdso500767685a.2
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 02:34:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699871699; x=1700476499;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PEQIri7VdaFKnh39IYsyiZxjMYqUiG0TME3ZF3C0ddU=;
 b=KgWmW7kKQOzbeaIMdieBJjnz4DCgtJOozP1X5D7DRxLE+vU0qNNALXH+7Ul2hYtdcy
 049lDTCeVXTiw14vTKePnAZM9IaJWdyCdep/d6dPdaOo3V0oDUh/WDQXt9uTu4HmvcKP
 Fh4l3qTBgRY3WTppfh2X9UWqYnxNAb2T6869IgzNPgDNYi5fr0b9FFHPJF3O31xPXHKm
 rajaBrMZla/JpJJBUOiZsFDNaMEOJusAWVQTy0HSqQHS0eHKTJxjQzNHuPE21k2T0Inb
 j/emSul/Gs+Dsb2kWRO3StEmYf/Bj6rFUVetZFDn6tLcPaFUE8s1u0j4HAe1ABhGRPmK
 c7EQ==
X-Gm-Message-State: AOJu0YwMvGhBByG87/TNj+TVFWVyaBj92X7WVsS642pvb+t6pyOG421E
 U7G6YhhuLdoODYH6cHy5UUJFoNdRQvTDnGp8zi9wGnybV7lFNr7wkeL0gj+6BrDrkMCrR0o3+S0
 EqlZUpvvSGqSvnpw=
X-Received: by 2002:a05:620a:468a:b0:77a:558:e579 with SMTP id
 bq10-20020a05620a468a00b0077a0558e579mr8187350qkb.28.1699871699113; 
 Mon, 13 Nov 2023 02:34:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEX8gA7EzZ18HHN4RV9un5sppit0sKldsuuPQ3gY2hxpZsLx8f3sevgxbjyNZ2mMv1sSrSxbQ==
X-Received: by 2002:a05:620a:468a:b0:77a:558:e579 with SMTP id
 bq10-20020a05620a468a00b0077a0558e579mr8187335qkb.28.1699871698755; 
 Mon, 13 Nov 2023 02:34:58 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-177-79.web.vodafone.de.
 [109.43.177.79]) by smtp.gmail.com with ESMTPSA id
 k21-20020a05620a07f500b007759e9b0eb8sm1787227qkk.99.2023.11.13.02.34.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 02:34:58 -0800 (PST)
Message-ID: <9b48b790-4705-4716-809f-1f24ced24833@redhat.com>
Date: Mon, 13 Nov 2023 11:34:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] host/include/generic/host/atomic128: Fix compilation
 problem with Clang 17
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
References: <20231108085954.313071-1-thuth@redhat.com>
 <b5945b9e-f696-4a71-b358-b95a5aaa7da9@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <b5945b9e-f696-4a71-b358-b95a5aaa7da9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 08/11/2023 18.57, Richard Henderson wrote:
> On 11/8/23 00:59, Thomas Huth wrote:
>> When compiling QEMU with Clang 17 on a s390x, the compilation fails:
>>
>> In file included from ../accel/tcg/cputlb.c:32:
>> In file included from /root/qemu/include/exec/helper-proto-common.h:10:
>> In file included from /root/qemu/include/qemu/atomic128.h:62:
>> /root/qemu/host/include/generic/host/atomic128-ldst.h:68:15: error:
>>   __sync builtin operation MUST have natural alignment (consider using __
>> atomic). [-Werror,-Wsync-alignment]
>>     68 |     } while (!__sync_bool_compare_and_swap_16(ptr_align, old, 
>> new.i));
>>        |               ^
>> In file included from ../accel/tcg/cputlb.c:32:
>> In file included from /root/qemu/include/exec/helper-proto-common.h:10:
>> In file included from /root/qemu/include/qemu/atomic128.h:61:
>> /root/qemu/host/include/generic/host/atomic128-cas.h:36:11: error:
>>   __sync builtin operation MUST have natural alignment (consider using __a
>> tomic). [-Werror,-Wsync-alignment]
>>     36 |     r.i = __sync_val_compare_and_swap_16(ptr_align, c.i, n.i);
>>        |           ^
>> 2 errors generated.
>>
>> It's arguably a bug in Clang since we already use __builtin_assume_aligned()
>> to tell the compiler that the pointer is properly aligned. But according to
>> https://github.com/llvm/llvm-project/issues/69146 it seems like the Clang
>> folks don't see an easy fix on their side and recommend to use a type
>> declared with __attribute__((aligned(16))) to work around this problem.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1934
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   host/include/generic/host/atomic128-cas.h  | 2 +-
>>   host/include/generic/host/atomic128-ldst.h | 2 +-
>>   include/qemu/int128.h                      | 1 +
>>   3 files changed, 3 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I just noticed that this new type needs to be declared for the #else part, 
too, otherwise the compilation breaks with --enable-tcg-interpreter :

diff --git a/include/qemu/int128.h b/include/qemu/int128.h
--- a/include/qemu/int128.h
+++ b/include/qemu/int128.h
@@ -225,6 +225,7 @@ static inline Int128 int128_rems(Int128 a, Int128 b)
  #else /* !CONFIG_INT128 */

  typedef struct Int128 Int128;
+typedef struct Int128 __attribute__((aligned(16))) Int128Aligned;

  /*
   * We guarantee that the in-memory byte representation of an

I'll add that when picking up the patch.

  Thomas


