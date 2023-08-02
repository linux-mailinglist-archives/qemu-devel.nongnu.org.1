Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1150E76D841
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 21:56:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRHwq-0005Yz-Cy; Wed, 02 Aug 2023 15:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qRHwj-0005Yn-KJ
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 15:55:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qRHwh-0003Mi-6x
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 15:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691006145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sLBgWbpQm5lKyNDiiEOuZqOJ5usiHSvGrZDOpcz//NE=;
 b=SOvm+KLeqU54cIyy1nehpxOBNCSZ6L99fkuEJKaYtQgnXOEbs+r7zlrgXg1wAOTPuDcgcr
 2Yp8S3+bAZnn8PJc33EmlGRfL49ZsE8FmC5wS+PHjP3JtrpkLuylfa/orElD3UauUO2WGh
 dBoUDY4g/hL/wnGcIhX3L5Xfx9n5XMA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-jdu0GXM_Ms6y0HWKgWaA8w-1; Wed, 02 Aug 2023 15:55:41 -0400
X-MC-Unique: jdu0GXM_Ms6y0HWKgWaA8w-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-40831789e55so2026651cf.1
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 12:55:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691006141; x=1691610941;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sLBgWbpQm5lKyNDiiEOuZqOJ5usiHSvGrZDOpcz//NE=;
 b=KGtaboAro7oIGqk/ebfHuDWAdrRZiSKlHtSdUDUcaQ4Lxn+Jk0OyKwLq+ATFvUKT5u
 LvfmQdhxhfUPnv110MMdCKm+8Zqu3zEE883X7CMwRv14mbnetHlj656zyuwaz53oCmCG
 SHa3oMQh7lJlUUD9FNyIhAhF+TueaP7NLsuMJqSNxDidfckeeQEfTBsQjlDTlnZ4mqf6
 nOrDN/lMPLDOifIq0juuAh+qcw7Sq6frswsOtsCYKukkgX2UJeHeq+4TeCj3+qb3JmlU
 XsIZqRWoR4+DZ2yWpcguwC/rRKfBfx9GqPIQxwIu0Ai8eS19LWylZlySisjgx+dQSr6H
 Jbmw==
X-Gm-Message-State: ABy/qLa2+JDeVWlczo6OKu4aRwQgv2RFgxk0XVcNHZgefhdOTWel3Tgu
 Jn2oCpKjIWA8WSgdQSJ1USo2RvjNaGJwAIMZFbtp99qiyaxcic8erh45Hb+Y33oVNnG/rUvySSM
 eGNO46lb4Zym5niI=
X-Received: by 2002:a05:622a:302:b0:403:ae9e:2a6d with SMTP id
 q2-20020a05622a030200b00403ae9e2a6dmr25480695qtw.43.1691006141204; 
 Wed, 02 Aug 2023 12:55:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGF7MBZVKVxojC2rLM3VF49KNkPNnXRiNZIoFAqKHhQUCJKE4HCRYou1ZwGlFhk0u9jhfGXwg==
X-Received: by 2002:a05:622a:302:b0:403:ae9e:2a6d with SMTP id
 q2-20020a05622a030200b00403ae9e2a6dmr25480681qtw.43.1691006140941; 
 Wed, 02 Aug 2023 12:55:40 -0700 (PDT)
Received: from [192.168.8.105] (tmo-081-137.customers.d1-online.com.
 [80.187.81.137]) by smtp.gmail.com with ESMTPSA id
 z1-20020ac83e01000000b003e3918f350dsm5635752qtf.25.2023.08.02.12.55.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Aug 2023 12:55:40 -0700 (PDT)
Message-ID: <f5fac2cd-04ee-f12d-fcf7-cd443016c957@redhat.com>
Date: Wed, 2 Aug 2023 21:55:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Luca Bonissi <qemu@bonslack.org>, Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <750c569e-a922-d3bb-1f97-1698960d5b05@bonslack.org>
 <CAFEAcA9vkyO_kivpSGV7jPW+DCbSD1BNA+SsLixViamXRi61CQ@mail.gmail.com>
 <fa561a63-991a-329e-d9f2-5b334d94516b@bonslack.org>
 <29cd5218-a9be-1947-e075-b892023213e8@vivier.eu>
 <38f8621c-98e7-53c4-ac1b-7ff4c569ed18@bonslack.org>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] Wrong unpacked structure for epoll_event on qemu-or1k
 (openrisc user-space)
In-Reply-To: <38f8621c-98e7-53c4-ac1b-7ff4c569ed18@bonslack.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.102, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 19/07/2023 14.38, Luca Bonissi wrote:
> On 19/07/23 10:49, Laurent Vivier wrote:
>>
>> According to linux/glibc sourced, epoll is only packed for x86_64.
> 
> And, in recent glibc, also for i386, even it seems not necessary: even if 
> the __alignof__(long long) is 8, structures like epoll_event are only 12 
> bytes, maybe "packed" for historical reasons. Ancient i386 gcc[s] (<3.0.0) 
> have 4 bytes for __alignof__(long long).
> 
>> Perhaps the default alignment of long is not correctly defined in qemu for 
>> openrisc?
> 
> __alignof__(long long):
> - 8 bytes: all 64 bit targets + arm, hppa, mips, ppc, sparc, xtensa, x86
> - 4 bytes: microblaze, nios2, or1k, sh4
> - 2 bytes: m68k
> - 1 byte : cris
> 
> offsetof(struct epoll_event,data):
> - 8: all 64 bit targets + arm, hppa, mips, ppc, sparc, xtensa
> - 4: cris, m68k, microblaze, nios2, or1k, sh4, x86
> 
> So, epoll_event is "naturally" packed on the following targets (checked in 
> linux-user container and/or with cross-compiler):
> - cris, m68k, microblaze, nios2, or1k, sh4, x86 (32bit)
> 
>> See include/exec/user/abitypes.h to update the value.
> 
> OK, abitypes.h should be updated with the following patch (discard the 
> previous patch on syscall_defs.h):
> 
> Signed-off-by: Luca Bonissi <qemu@bonslack.org>
> ---
> 
> diff -up a/include/exec/user/abitypes.h b/include/exec/user/abitypes.h
> --- a/include/exec/user/abitypes.h    2023-03-27 15:41:42.511916232 +0200
> +++ b/include/exec/user/abitypes.h    2023-07-19 12:09:03.001687788 +0200
> @@ -15,7 +15,15 @@
>   #define ABI_LLONG_ALIGNMENT 2
>   #endif
> 
> +#ifdef TARGET_CRIS
> +#define ABI_SHORT_ALIGNMENT 1
> +#define ABI_INT_ALIGNMENT 1
> +#define ABI_LONG_ALIGNMENT 1
> +#define ABI_LLONG_ALIGNMENT 1
> +#endif
> +
> -#if (defined(TARGET_I386) && !defined(TARGET_X86_64)) || defined(TARGET_SH4)
> +#if (defined(TARGET_I386) && !defined(TARGET_X86_64)) || 
> defined(TARGET_SH4) || \
> +    defined(TARGET_OPENRISC) || defined(TARGET_NIOS2) || 
> defined(TARGET_MICROBLAZE)
>   #define ABI_LLONG_ALIGNMENT 4
>   #endif

Hi! Thanks for the patch - but could you please send this as a new patch 
mail with a proper subject and patch description, so that it could be 
applied with "git am" ? Thanks!

  Thomas



