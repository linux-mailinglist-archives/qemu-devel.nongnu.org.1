Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1640B810DC
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Sep 2025 18:38:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyvAt-0003tw-LQ; Wed, 17 Sep 2025 12:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uyv7t-0000zz-Jl
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 12:35:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uyv7q-0004ZJ-G2
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 12:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758126919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vP8H4e2hOK5O17yODFbPieyvwypurQ8G7UIjEXEKddE=;
 b=Y9ffEJ+BJSBDLrInaK5hA7nbm3ekDSlk3ltSGhM71q1qwGN2SxtlGp0OCAuxyQ0jEGb9TE
 AiPVtsbyc+fGr0Fh+VdSQyQPUjT83bAuu+dVQfFI+QPeZmrMnbYm4+pNuQnStaYxcudXJ3
 AzcelrDycKbj9tOCYgxBY3ytAtEQHdE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-xtTWvtI8Pli0PFosyU-Yew-1; Wed, 17 Sep 2025 12:35:18 -0400
X-MC-Unique: xtTWvtI8Pli0PFosyU-Yew-1
X-Mimecast-MFC-AGG-ID: xtTWvtI8Pli0PFosyU-Yew_1758126917
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3e95627b120so2682427f8f.1
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 09:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758126917; x=1758731717;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vP8H4e2hOK5O17yODFbPieyvwypurQ8G7UIjEXEKddE=;
 b=tlfkCGD6mqBh/jDbwOQGyef9vz6XvX1MmglgIX45eILxMqeRD68a5swXG8bJ1np4MK
 AkwwlLPLc4ECG5jGoastVxnwr0SouTJ0XdiwLf9Rmj/OYG2VXM8ebtukjDbvSvhBhNQR
 rBCxNd6BVpvWQczkfnJBgPjIYaWIN8/7iZa79/TNVLYn7upTGGfLGVWRiei7kT0igRiL
 g+Bct6BdjUu45c39dX2GWpnUVAt09WPIMARkR4zq4stcd/3H+vpd1QjPp7gPniH5ltFr
 znmFV0V4wLm3O8ujXpeCYHZjwUrM+jGqg98sYjoMYq5ovNF/Y3w9NQMPpgJKZ/hsX7u+
 1S0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuiOVMzHhnFqh3nKU6I+ssQQEsIU2ruvRzZw9ZKeb8GP5IklmJZHTidy5doYasDDH2lr9iS6jkY2+G@nongnu.org
X-Gm-Message-State: AOJu0YzQXTlEvnwdLIkmfaoya6udRNhEaSGHmKeFQGMktfPZ0WhqrTlM
 9bCsHPnlY6S1/1SFzVZyoMCb3gqYFW3quc4Yb2uIFKHVBsvoJw8v43qlfyq6C2jonmvqSCAC6qn
 4Kmp9BDBVOGofO6lTCkpQ7NqE1WK9fenJpQMUuQvq0WEb7P/M3+TMlltH
X-Gm-Gg: ASbGncuEyzMcmme/7ogd4CZCuiYm/R5cBRHnWVw9Hv5Ly5hUidhdZXvvGdAlcq6DDVP
 2uTMlxtkkeCd0XJa9XkFjBnRx0qpjpz+iyL0sAHJ9PWD4KKR2ionarpzLRDcCws7WeuU77bZYH9
 3B6hsPONgsNR3TI+umuk6wpwbwegmS84uLR1pPb0P8C5EenrVHTiNlHphkeYs6j1yh8gEaSvjKh
 f+U91iciYWVnOCUC0q9tlsqciRMuxX5YeXDpfgPZDff1syr1OJvWVQmx4nYXo2LkHnw7PPf1MSJ
 0VgOs5M7N/KXOW+4sespBN+UpYjtOG3gZSJmWMRox57B1K4sWxtArzZ/7jiyWD/9bLThAZFJZjp
 Nr0E=
X-Received: by 2002:a05:6000:2c10:b0:3ec:de27:aaae with SMTP id
 ffacd0b85a97d-3ecdfa3f9ebmr2520704f8f.38.1758126916974; 
 Wed, 17 Sep 2025 09:35:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFwDh43JEZ8alO49Nx+5iz4go9SMjxaMv4PmgxD9HqNBZb2KwUtBkj3e6Y56fEWT56go72YA==
X-Received: by 2002:a05:6000:2c10:b0:3ec:de27:aaae with SMTP id
 ffacd0b85a97d-3ecdfa3f9ebmr2520669f8f.38.1758126916477; 
 Wed, 17 Sep 2025 09:35:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-464f5a281f1sm2625955e9.17.2025.09.17.09.35.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Sep 2025 09:35:16 -0700 (PDT)
Message-ID: <66fb8c67-b04b-48d6-a33f-eda1cd24aeaf@redhat.com>
Date: Wed, 17 Sep 2025 18:35:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] target/ppc: Add IBM PPE42 special instructions
To: milesg@linux.ibm.com, Thomas Huth <thuth@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, rathc@linux.ibm.com,
 richard.henderson@linaro.org
References: <20250912164808.371944-1-milesg@linux.ibm.com>
 <20250912164808.371944-7-milesg@linux.ibm.com>
 <a419ef55-d0d5-4d88-8302-ebcc9a8c4bab@linux.ibm.com>
 <db99b84a-4d7c-49af-8185-97db09843006@redhat.com>
 <14ea64c1c7c2f9e154b0d607d88b737adb067127.camel@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <14ea64c1c7c2f9e154b0d607d88b737adb067127.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/17/25 16:38, Miles Glenn wrote:
> On Wed, 2025-09-17 at 08:20 +0200, Thomas Huth wrote:
>> On 17/09/2025 06.57, Harsh Prateek Bora wrote:
>>>
>>> On 9/12/25 22:17, Glenn Miles wrote:
>>>> Adds the following instructions exclusively for
>>>> IBM PPE42 processors:
>>>>
>>>>     LSKU
>>>>     LCXU
>>>>     STSKU
>>>>     STCXU
>>>>     LVD
>>>>     LVDU
>>>>     LVDX
>>>>     STVD
>>>>     STVDU
>>>>     STVDX
>>>>     SLVD
>>>>     SRVD
>>>>     CMPWBC
>>>>     CMPLWBC
>>>>     CMPWIBC
>>>>     BNBWI
>>>>     BNBW
>>>>     CLRBWIBC
>>>>     CLRWBC
>>>>     DCBQ
>>>>     RLDICL
>>>>     RLDICR
>>>>     RLDIMI
>>>>
>>>> A PPE42 GCC compiler is available here:
>>>> https://github.com/open-power/ppe42-gcc
>>>>
>>>> For more information on the PPE42 processors please visit:
>>>> https://wiki.raptorcs.com/w/images/a/a3/PPE_42X_Core_Users_Manual.pdf
>>>>
>>>> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
>>>> ---
>>>> Changes from v3:
>>>>     - Removed copy of CHECK_VDR
>>>>     - Refactored ld/st instructions
>>>>
>>>>    target/ppc/insn32.decode            |  66 ++-
>>>>    target/ppc/translate.c              |  29 +-
>>>>    target/ppc/translate/ppe-impl.c.inc | 665 ++++++++++++++++++++++++++++
>>>>    3 files changed, 750 insertions(+), 10 deletions(-)
>>>>    create mode 100644 target/ppc/translate/ppe-impl.c.inc
>>>>
>>>
>>> <snip>
>>>
>>>> diff --git a/target/ppc/translate/ppe-impl.c.inc b/target/ppc/translate/
>>>> ppe-impl.c.inc
>>>> new file mode 100644
>>>> index 0000000000..792103d7c2
>>>> --- /dev/null
>>>> +++ b/target/ppc/translate/ppe-impl.c.inc
>>>> @@ -0,0 +1,665 @@
>>>> +/*
>>>> + * IBM PPE Instructions
>>>> + *
>>>> + * Copyright (c) 2025, IBM Corporation.
>>>> + *
>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>>> + */
>>>> +
>>>> +
>>>> +#if !defined(TARGET_PPC64)
>>>> +static bool vdr_is_valid(uint32_t vdr)
>>>> +{
>>>> +    const uint32_t valid_bitmap = 0xf00003ff;
>>>> +    return !!((1ul << (vdr & 0x1f)) & valid_bitmap);
>>>> +}
>>>> +
>>>> +static bool ppe_gpr_is_valid(uint32_t reg)
>>>> +{
>>>> +    const uint32_t valid_bitmap = 0xf00027ff;
>>>> +    return !!((1ul << (reg & 0x1f)) & valid_bitmap);
>>>> +}
>>>> +#endif
>>>> +
>>>> +#define CHECK_VDR(CTX, VDR)                             \
>>>> +    do {                                                \
>>>> +        if (unlikely(!vdr_is_valid(VDR))) {             \
>>>> +            gen_invalid(CTX);                           \
>>>> +            return true;                                \
>>>> +        }                                               \
>>>> +    } while (0)
>>>> +
>>>> +#define CHECK_PPE_GPR(CTX, REG)                         \
>>>> +    do {                                                \
>>>> +        if (unlikely(!ppe_gpr_is_valid(REG))) {         \
>>>> +            gen_invalid(CTX);                           \
>>>> +            return true;                                \
>>>> +        }                                               \
>>>> +    } while (0)
>>>> +
>>>> +#define VDR_PAIR_REG(VDR) (((VDR) + 1) & 0x1f)
>>>> +
>>>> +#define CHECK_PPE_LEVEL(CTX, LVL)                       \
>>>> +    do {                                                \
>>>> +        if (unlikely(!((CTX)->insns_flags2 & (LVL)))) { \
>>>> +            gen_invalid(CTX);                           \
>>>> +            return true;                                \
>>>> +        }                                               \
>>>> +    } while (0)
>>>> +
>>>> +static bool trans_LCXU(DisasContext *ctx, arg_LCXU *a)
>>>> +{
>>>> +#if defined(TARGET_PPC64)
>>>> +    return false;
>>>> +#else
>>>
>>> If we are building the PPE42 instructions only for !TARGET_PPC64, does
>>> it still make it usable with qemu-system-ppc64?
>>
>> As explained in an earlier thread already, qemu-system-ppc64 is a superset
>> of qemu-system-ppc. Thus the ppe42 stuff should work in qemu-system-ppc64, too.
>>
>>    Thomas
>>
> 
> Ah, yes, I don't think I fully understood the ramifications of Thomas's
> statements earlier.  Looks like I'll need to scrub the code to ensure
> that PPE42 can run even if TARGET_PPC64 is defined.
> 
> Cedric, this requires me to change my response to your request to add
> the check for TARGET_PPC64 inside the is_ppe() function.  I will need
> to leave that function as-is if we want PPE42 to be supported in both
> targets.  Will you be ok with that?
sure if it compiles. Try a clang  build.

C.


