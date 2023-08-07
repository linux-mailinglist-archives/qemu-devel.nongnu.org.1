Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC19577293E
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 17:32:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT2D0-0005DN-HX; Mon, 07 Aug 2023 11:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qT2Cy-0005BT-1v
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:31:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qT2Cv-0005LU-Dz
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691422302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TeBfrkrR4kfqUCCXLt5kk6xEry0hEL/7eeOgRRIX/2U=;
 b=PZrrr416RkvvbFxPTSSEiODTDWl8cPosb8uxe+KnkYEbBt1v28bjRIrcUjOWyEcuX93m3k
 t4Sq5OiQuqdwGrMly3v/RHhPkEiFfjDj5OmB3HVXv1Vt0yzB5oXfYXo/ezCrywifxFIiiU
 9Nx2ge30m6myOSeEhlGEN8UjOyDHxq8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-p_xfhHSfP0-PAuXPM2p6gw-1; Mon, 07 Aug 2023 11:31:40 -0400
X-MC-Unique: p_xfhHSfP0-PAuXPM2p6gw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fe15547164so30653775e9.0
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 08:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691422299; x=1692027099;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TeBfrkrR4kfqUCCXLt5kk6xEry0hEL/7eeOgRRIX/2U=;
 b=DdSiCikwfejnksuw7VACLwdFuTl8m+gZGgvPGxQHUMvc9BPdwaRSsKlk8nPNzrbY7s
 uG1ygBqyEVVebuSJMGCZiBCx62kA99J4PW0a3wV7iFMBT5debVR1bPtvTi8f5GT1ufCa
 G4byHE0vjt1Rk8WNwevrHtQK4FLrnEDA2gHOi7x9CtIvc2FcIgJV/w65bCKkm5JoXeFl
 9gtePPaX66UWW9xSlB5bwQQLo/wnGBMe6PvO3DaNg9wRezU8ASgWrTwujVFE5zw40Tsh
 4Xr6Z3MBTe0Ybq6reWZIla2sFuoVVnuKYdkii/MyvEkf2Uk97NoaYOklz2TY7eRLDHml
 FNHg==
X-Gm-Message-State: AOJu0YyJMzFQsk4c7GP2Clr2XBmINd8F6TjCRBhwM+8jvPFO2COB8GiL
 p1fKCyeuVLi/VID0dqrgKyxaSi0mL7hwvxtVxac7RI+XCTYTvV59Bd7J2jcF9ORb+k2kyQQYU2K
 HCJ0Ytq+5iXhEK68=
X-Received: by 2002:a05:600c:2049:b0:3fe:2f31:8bf7 with SMTP id
 p9-20020a05600c204900b003fe2f318bf7mr7488887wmg.26.1691422299055; 
 Mon, 07 Aug 2023 08:31:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETijXTsu/kvxos39ALVw6o4lAtiyNThk/rpjyFfKZQ4S/8yjdjmkTrayH9u8Yr8G5g9pYXAw==
X-Received: by 2002:a05:600c:2049:b0:3fe:2f31:8bf7 with SMTP id
 p9-20020a05600c204900b003fe2f318bf7mr7488872wmg.26.1691422298649; 
 Mon, 07 Aug 2023 08:31:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c740:5d00:5143:1cd2:a300:ceff?
 (p200300cbc7405d0051431cd2a300ceff.dip0.t-ipconnect.de.
 [2003:cb:c740:5d00:5143:1cd2:a300:ceff])
 by smtp.gmail.com with ESMTPSA id
 c10-20020a05600c0aca00b003fe17e04269sm11039689wmr.40.2023.08.07.08.31.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Aug 2023 08:31:38 -0700 (PDT)
Message-ID: <6961d8e4-7b26-b205-1ffd-4d4b721fe2e2@redhat.com>
Date: Mon, 7 Aug 2023 17:31:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] target/s390x: Define TARGET_HAS_PRECISE_SMC
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20230807114921.438881-1-iii@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230807114921.438881-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.809, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 07.08.23 13:48, Ilya Leoshkevich wrote:
> PoP (Sequence of Storage References -> Instruction Fetching) says:
> 
>      ... if a store that is conceptually earlier is
>      made by the same CPU using the same effective
>      address as that by which the instruction is subse-
>      quently fetched, the updated information is obtained ...
> 
> QEMU already has support for this in the common code; enable it for
> s390x.


Figuring out what TARGET_HAS_PRECISE_SMC is all about, I only learned 
from git history

commit d720b93d0bcfe1beb729245b9ed1e5f071a24bd5
Author: Fabrice Bellard <fabrice@bellard.org>
Date:   Sun Apr 25 17:57:43 2004 +0000

     precise self modifying code support


     git-svn-id: svn://svn.savannah.nongnu.org/qemu/trunk@745 
c046a42c-6fe2-441c-8c8c-71466251a162



AFAIU, precise SMC is stricter compared to what we have right now. So i 
suspect that this patch is actually fixing SMC behavior: for example, 
when a basic block ends up modifying itself.

Were there any BUG reports? (does patch #2 test for that and can 
reproduce the original issue?)

> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   target/s390x/cpu.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index eb5b65b7d3a..304029e57cf 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -36,6 +36,8 @@
>   /* The z/Architecture has a strong memory model with some store-after-load re-ordering */
>   #define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL & ~TCG_MO_ST_LD)
>   
> +#define TARGET_HAS_PRECISE_SMC
> +
>   #define TARGET_INSN_START_EXTRA_WORDS 2
>   
>   #define MMU_USER_IDX 0

-- 
Cheers,

David / dhildenb


