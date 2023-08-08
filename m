Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F105F773A91
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 15:51:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTN6g-0001ww-Eg; Tue, 08 Aug 2023 09:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTN6G-0001wa-Rk
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 09:50:18 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTN6D-0007z2-5Q
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 09:50:16 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-317744867a6so4350952f8f.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 06:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691502611; x=1692107411;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vp0MhQN1ilgfX3L5PM8yT1GHmY4p7GOO/2qsl1+Yy2c=;
 b=DJ6oMEnjCBjFBh0sCgwxKwqdyH6ICM7+vmOisxeien+7fbDxTHP69cQcJ5JpPGC+GT
 NbH8GmR1ecMV7N1R+ltxHOPjTnwk40LzqWrbzl5xCbcMmJReVObZRNAMtxhMpq/20AKq
 mE93EgqxXf32fqIaeNDkqr/wbALJm0U2n9WfKBiyRpsTgIWlYo0Br1E0d6Hjo4+2+vRL
 tFgy67kpvhFha2Us2kXpVbjr0YyxBOcJmKT4a8tR3On7j3BJGSaEuDordlaZ6ziL1N23
 9TiL0d1fqUZzPrB43F7atHL/raHM9grPbNJhA3MyYZoB6SIVmVmF+f5UqV96hXvL1DBw
 SrUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691502611; x=1692107411;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vp0MhQN1ilgfX3L5PM8yT1GHmY4p7GOO/2qsl1+Yy2c=;
 b=CKmSltdaz78jSMCL/j40o4zcL9kSR1qyvRxjQAsGoONObZ0syhfv72rTGeHM9QCfFO
 j+psbkYTEovNAI40rrAyMa0dE0lYg5Jppk6ROBmY1/7JEpUTlV1sMn4EddYBRH7Eb4WD
 d+Vt6KHyMDgkatqcLzPGjzTU1jKy0kfQxhR7EDcaMhm5HROETu+d4Ml8guW2X1pE6jp6
 S1LhLlAv5bIMlDt89tGoTjNRfDGFSXJkVQKajbrlqKn6ErHCTCfaQG8r7NCQXjuQMJAa
 2KdGbzCjNXV7j+Ba+bMyyujkpjirqUV1jJAHMTstBPkq0pjUU9ju+ACkT60u3NclG8lg
 KmaA==
X-Gm-Message-State: AOJu0YwGMh1sKRQYZTuW9OOJdID4AK4QvL/aaqRhh2GROQRm1NeAwB0l
 lxxHXmZZ96mP6Xk205slLnTguw==
X-Google-Smtp-Source: AGHT+IFFv1KxgY5PDjqX6BcTONJOSGo7AG+jvBSdGNAwtc/g0422YdkNi1Y1fW7NjFqm1RJqzHbOYA==
X-Received: by 2002:adf:f088:0:b0:307:7f38:37f with SMTP id
 n8-20020adff088000000b003077f38037fmr8590343wro.66.1691502611040; 
 Tue, 08 Aug 2023 06:50:11 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 k18-20020a7bc412000000b003fbbe41fd78sm13940441wmi.10.2023.08.08.06.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 06:50:10 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 08F881FFBB;
 Tue,  8 Aug 2023 14:50:10 +0100 (BST)
References: <20230807163705.9848-1-richard.henderson@linaro.org>
 <20230807163705.9848-5-richard.henderson@linaro.org>
 <87o7jh98bt.fsf@linaro.org>
 <9ad42b10-d1ae-4a60-9185-8f43534b818f@daynix.com>
User-agent: mu4e 1.11.13; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, pbonzini@redhat.com,
 philmd@linaro.org, laurent@vivier.eu, deller@gmx.de, qemu-devel@nongnu.org
Subject: Re: [PATCH for-8.1 v10 04/14] linux-user: Use MAP_FIXED_NOREPLACE
 for initial image mmap
Date: Tue, 08 Aug 2023 14:48:54 +0100
In-reply-to: <9ad42b10-d1ae-4a60-9185-8f43534b818f@daynix.com>
Message-ID: <87pm3x7iem.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> On 2023/08/08 18:43, Alex Benn=C3=A9e wrote:
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>=20
>>> Use this as extra protection for the guest mapping over
>>> any qemu host mappings.
>>>
>>> Tested-by: Helge Deller <deller@gmx.de>
>>> Reviewed-by: Helge Deller <deller@gmx.de>
>>> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   linux-user/elfload.c | 9 ++++++---
>>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>>> index 36e4026f05..1b4bb2d5af 100644
>>> --- a/linux-user/elfload.c
>>> +++ b/linux-user/elfload.c
>>> @@ -3147,8 +3147,11 @@ static void load_elf_image(const char *image_nam=
e, int image_fd,
>>>       /*
>>>        * Reserve address space for all of this.
>>>        *
>>> -     * In the case of ET_EXEC, we supply MAP_FIXED so that we get
>>> -     * exactly the address range that is required.
>>> +     * In the case of ET_EXEC, we supply MAP_FIXED_NOREPLACE so that w=
e get
>>> +     * exactly the address range that is required.  Without reserved_v=
a,
>>> +     * the guest address space is not isolated.  We have attempted to =
avoid
>>> +     * conflict with the host program itself via probe_guest_base, but=
 using
>>> +     * MAP_FIXED_NOREPLACE instead of MAP_FIXED provides an extra chec=
k.
>>>        *
>>>        * Otherwise this is ET_DYN, and we are searching for a location
>>>        * that can hold the memory space required.  If the image is
>>> @@ -3160,7 +3163,7 @@ static void load_elf_image(const char *image_name=
, int image_fd,
>>>        */
>>>       load_addr =3D target_mmap(loaddr, (size_t)hiaddr - loaddr + 1, PR=
OT_NONE,
>>>                               MAP_PRIVATE | MAP_ANON | MAP_NORESERVE |
>>> -                            (ehdr->e_type =3D=3D ET_EXEC ? MAP_FIXED :=
 0),
>>> +                            (ehdr->e_type =3D=3D ET_EXEC ? MAP_FIXED_N=
OREPLACE : 0),
>>>                               -1, 0);
>> We should probably also check the result =3D=3D load_addr for the places
>> where MAP_FIXED_NOREPLACE isn't supported as we have this in osdep.h:
>>    #ifndef MAP_FIXED_NOREPLACE
>>    #define MAP_FIXED_NOREPLACE 0
>>    #endif
>> See 2667e069e7 (linux-user: don't use MAP_FIXED in
>> pgd_find_hole_fallback)
>
> It assumes target_mmap() emulates MAP_FIXED_NOREPLACE when the host
> does not support it as commit e69e032d1a ("linux-user: Use
> MAP_FIXED_NOREPLACE for do_brk()") already does, but defining
> MAP_FIXED_NOREPLACE zero breaks such emulation. I wrote a fix:
> https://patchew.org/QEMU/20230808115242.73025-1-akihiko.odaki@daynix.com/

Hmm doesn't that push the problem to real mmap() calls to a host system
that doesn't support MAP_FIXED_NOREPLACE?

I wonder if we need an internal flag rather than overloading the host
flags?

>
>>=20
>>>       if (load_addr =3D=3D -1) {
>>>           goto exit_mmap;
>>=20


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

