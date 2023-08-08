Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6389A773AEA
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 17:16:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTOPq-0007aG-VJ; Tue, 08 Aug 2023 11:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTOPo-0007Zo-DW
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 11:14:32 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTOPk-00006j-Qz
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 11:14:32 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fe5eb84dceso15974455e9.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 08:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691507667; x=1692112467;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ae/XyI63fe3TVdwNO5Zn6orcpa+C1wdV+b0CWYX5L3w=;
 b=wv2fKXlj2orvC1GWl0lDOhF5YtMSMy4XA86vzrAs/KUx4lz90uUr8IjGJJM0a71Vuf
 gSFB8ZNXJaqB5ughbBqZZjHVVFFeI/sysWNERg/RmvhruI8NPaJ2gwoq4rgzHBWz+DPs
 aLGtTy0XNU//ECsetvL3dmLYcqQCHVz2uZj3kWoXL8hN2I/HuCpz2WZXytVe4IQxxDoU
 j3PF6a55mw03psBgsnYPGUUKn4YBK9Ukzs0CYTa0J4lQnJABeyc1v/w34y5EH5yQgVlO
 TDNF7d8MTQ1CpAmvMO21vZLBTOZYFOxzOlizibkae168Vu/PCK+koPiiNn6+yAz7Yy9b
 DSFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691507667; x=1692112467;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ae/XyI63fe3TVdwNO5Zn6orcpa+C1wdV+b0CWYX5L3w=;
 b=jCSavlkJP3onxRrvQAyzxdwZM3K4GdDvMtTA5mD1l34/rUYN8MCFBURSXcP6YT/f06
 j0+i8rSK9ue1AgFFu7rXYirqN+cfbTCJuqyifz8onyzmJcz5Q4ocnvInBHOB+XSTtjiF
 DAHsNcrtJ2DTYXPN8zEUZLKCWv0BoHcgonX6b74YWQ/iVIPxUWhGd5v4QQcu2xmZYDqW
 vHj/9EYxV2D3yOGovTkKNML+YR4Ugg4KagEOk33vVS+L7m/XEOlRyceKDAgPjqDJn6iY
 laYFNe6sfZ71lAxW5ZHgyztkSVnPNf87jbS9hhDqMUW0VeCZGf89gqHaE1Zo60rZvhiK
 KrDw==
X-Gm-Message-State: AOJu0YzJAFOrb7SS12lMp4KmSFbyy7Bm6jjuK+pEpo06Lx2vPWG0SdAO
 wJqVYMTRiIwYRvdKMi8oaqc1xA==
X-Google-Smtp-Source: AGHT+IHPIJo13JT+6QkLLRC+zuq7LigpgwZoo0bXulmvNHaI+22TeNACeYeRtt+yiCaAYeoQ74L18w==
X-Received: by 2002:a05:600c:2943:b0:3fc:d5:dc14 with SMTP id
 n3-20020a05600c294300b003fc00d5dc14mr92915wmd.5.1691507667145; 
 Tue, 08 Aug 2023 08:14:27 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f9-20020a7bc8c9000000b003fba92fad35sm18304033wml.26.2023.08.08.08.14.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 08:14:26 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 652021FFBB;
 Tue,  8 Aug 2023 16:14:26 +0100 (BST)
References: <20230807163705.9848-1-richard.henderson@linaro.org>
 <20230807163705.9848-5-richard.henderson@linaro.org>
 <87o7jh98bt.fsf@linaro.org>
 <9ad42b10-d1ae-4a60-9185-8f43534b818f@daynix.com>
 <87pm3x7iem.fsf@linaro.org>
 <3add5703-cbc9-436b-b361-8f593f4718ce@daynix.com>
User-agent: mu4e 1.11.13; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, pbonzini@redhat.com,
 philmd@linaro.org, laurent@vivier.eu, deller@gmx.de, qemu-devel@nongnu.org
Subject: Re: [PATCH for-8.1 v10 04/14] linux-user: Use MAP_FIXED_NOREPLACE
 for initial image mmap
Date: Tue, 08 Aug 2023 15:20:23 +0100
In-reply-to: <3add5703-cbc9-436b-b361-8f593f4718ce@daynix.com>
Message-ID: <87leel7ei5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

> On 2023/08/08 22:48, Alex Benn=C3=A9e wrote:
>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>=20
>>> On 2023/08/08 18:43, Alex Benn=C3=A9e wrote:
>>>> Richard Henderson <richard.henderson@linaro.org> writes:
>>>>
>>>>> Use this as extra protection for the guest mapping over
>>>>> any qemu host mappings.
>>>>>
>>>>> Tested-by: Helge Deller <deller@gmx.de>
>>>>> Reviewed-by: Helge Deller <deller@gmx.de>
>>>>> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>>>> ---
>>>>>    linux-user/elfload.c | 9 ++++++---
>>>>>    1 file changed, 6 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>>>>> index 36e4026f05..1b4bb2d5af 100644
>>>>> --- a/linux-user/elfload.c
>>>>> +++ b/linux-user/elfload.c
>>>>> @@ -3147,8 +3147,11 @@ static void load_elf_image(const char *image_n=
ame, int image_fd,
>>>>>        /*
>>>>>         * Reserve address space for all of this.
>>>>>         *
>>>>> -     * In the case of ET_EXEC, we supply MAP_FIXED so that we get
>>>>> -     * exactly the address range that is required.
>>>>> +     * In the case of ET_EXEC, we supply MAP_FIXED_NOREPLACE so that=
 we get
>>>>> +     * exactly the address range that is required.  Without reserved=
_va,
>>>>> +     * the guest address space is not isolated.  We have attempted t=
o avoid
>>>>> +     * conflict with the host program itself via probe_guest_base, b=
ut using
>>>>> +     * MAP_FIXED_NOREPLACE instead of MAP_FIXED provides an extra ch=
eck.
>>>>>         *
>>>>>         * Otherwise this is ET_DYN, and we are searching for a locati=
on
>>>>>         * that can hold the memory space required.  If the image is
>>>>> @@ -3160,7 +3163,7 @@ static void load_elf_image(const char *image_na=
me, int image_fd,
>>>>>         */
>>>>>        load_addr =3D target_mmap(loaddr, (size_t)hiaddr - loaddr + 1,=
 PROT_NONE,
>>>>>                                MAP_PRIVATE | MAP_ANON | MAP_NORESERVE=
 |
>>>>> -                            (ehdr->e_type =3D=3D ET_EXEC ? MAP_FIXED=
 : 0),
>>>>> +                            (ehdr->e_type =3D=3D ET_EXEC ? MAP_FIXED=
_NOREPLACE : 0),
>>>>>                                -1, 0);
>>>> We should probably also check the result =3D=3D load_addr for the plac=
es
>>>> where MAP_FIXED_NOREPLACE isn't supported as we have this in osdep.h:
>>>>     #ifndef MAP_FIXED_NOREPLACE
>>>>     #define MAP_FIXED_NOREPLACE 0
>>>>     #endif
>>>> See 2667e069e7 (linux-user: don't use MAP_FIXED in
>>>> pgd_find_hole_fallback)
>>>
>>> It assumes target_mmap() emulates MAP_FIXED_NOREPLACE when the host
>>> does not support it as commit e69e032d1a ("linux-user: Use
>>> MAP_FIXED_NOREPLACE for do_brk()") already does, but defining
>>> MAP_FIXED_NOREPLACE zero breaks such emulation. I wrote a fix:
>>> https://patchew.org/QEMU/20230808115242.73025-1-akihiko.odaki@daynix.co=
m/
>> Hmm doesn't that push the problem to real mmap() calls to a host
>> system
>> that doesn't support MAP_FIXED_NOREPLACE?
>
> That can happen even without that patch if you run QEMU built with a
> new libc on old Linux so we should have prepared for that kind of
> situation.
>
> The man page also says:
>> Note that older kernels which do not recognize the MAP_FIXED_NOREPLACE
>> flag will typically (upon detecting a collision with a preexisting
>> mapping) fall back to a =E2=80=9Cnon-MAP_FIXED=E2=80=9D type of behavior=
: they will
>> return an address that is different from the requested address.
>> Therefore, backward-compatible software should check the returned
>> address against the requested address.
> https://man7.org/linux/man-pages/man2/mmap.2.html
>
> It basically means MAP_FIXED_NOREPLACE has no effect on a host that
> doesn't support it, and the existing code checking the returned
> address should continue to work.

OK - as long as it doesn't barf on unknown flags.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

