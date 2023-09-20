Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F39F07A8DF2
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 22:44:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj430-0002Z0-JX; Wed, 20 Sep 2023 16:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qj42z-0002Yj-4U
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 16:43:45 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qj42x-0003KG-DL
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 16:43:44 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-402d499580dso2829115e9.1
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 13:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695242621; x=1695847421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KFbWs/D6+GYDUAuGhgeVy8TLEfViSdIDnzF/QYEAbqA=;
 b=eZB820JfAjySjKJR38OJIxphWP76muwmk/r8N6ElAt05deWdu1MQOAtsiGGFelBGne
 EacZUvjIWeV/8yjCpkM+dT36EPIYrCOWMEAgUmnZOCB+61kFEW5Z2bTXrUX9rhObxQjc
 onp+Utn+NyH19syLB39zSInzatnxzC6q2zxQZuYKGJXyI8ZzW7q07O+ho6QNrobmOkas
 6A0SZO5XwpErdIRcT7lgdYx82OQ03yUzG9Yzq/wdpDWmuiae0zaJPykCohbNXvSIYWzE
 mj9Xd/4ziEx57K9rVN0QEHsnNFsJbjPL0qlWNWMDZMjwIUeHem8IVctqKcy5kRKmDvg0
 spbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695242621; x=1695847421;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KFbWs/D6+GYDUAuGhgeVy8TLEfViSdIDnzF/QYEAbqA=;
 b=l9nAzkstA354FWEIcJL1kYB8tzAMrnMX3EF5rN/VxdPoSPMaW4P8xSNX6t5xUht/iB
 Mh71sFGLgDmMqYmCsi4EVvQr/WXoyy8pV3ox/Y8oxS5HOrRX1DVbG5lybIY2PA9EEGko
 xob2nkUI6UHd8GnZsJEm9dM9vkifsWFf6xj4v/C7j7zzsruaEG3FppiYWsJ2YANhl8au
 VLECe5NXlS4Fb1irdpUAo+HMom68v00CYdedxRY3ykDhObuSs7DV7a/z25bAO1lhaScV
 dW1ZMHbq8tYwgTXzPDpjOCnKYOc8iRaMmzabsSn6QkEVJrSUhwWHwa3o97+zP96yDiXt
 FlxA==
X-Gm-Message-State: AOJu0YwRPakzORicg4peEHHH2iQwjEqEy0SLuXvx52tE1GOnS0KG5nBf
 rPp2d/+K3AwdEXpClN2fQL/v2A==
X-Google-Smtp-Source: AGHT+IH9Y9Hfwz4fgO4f/+MJ8tTuL3Tu+hq+d7Nac430+SqikBcBkulK7RN0PDC6mPS/c39dxTiCfg==
X-Received: by 2002:adf:e807:0:b0:321:6414:5869 with SMTP id
 o7-20020adfe807000000b0032164145869mr3156548wrm.58.1695242621069; 
 Wed, 20 Sep 2023 13:43:41 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 d10-20020a5d6dca000000b0031c5b380291sm19651547wrz.110.2023.09.20.13.43.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 13:43:40 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AD9E61FFBD;
 Wed, 20 Sep 2023 16:55:14 +0100 (BST)
References: <qemu-stable-8.1.1-20230909131531@cover.tls.msk.ru>
 <20230909102747.346522-11-mjt@tls.msk.ru>
 <5a617673-efe0-18b9-e3db-88277b09ba52@tls.msk.ru>
 <5bd5a600-e7a5-fe37-1a2f-d00aa7e84428@tls.msk.ru>
User-agent: mu4e 1.11.20; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [Stable-8.1.1 11/34] softmmu: Assert data in bounds in
 iotlb_to_section
Date: Wed, 20 Sep 2023 16:04:50 +0100
In-reply-to: <5bd5a600-e7a5-fe37-1a2f-d00aa7e84428@tls.msk.ru>
Message-ID: <87ttrovnz1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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


Michael Tokarev <mjt@tls.msk.ru> writes:

> 18.09.2023 12:19, Michael Tokarev wrote:
>> 09.09.2023 13:27, Michael Tokarev wrote:
>>> From: Richard Henderson <richard.henderson@linaro.org>
>>>
>>> Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> Suggested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> (cherry picked from commit 86e4f93d827d3c1efd00cd8a906e38a2c0f2b5bc)
>>> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
>>>
>>> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
>>> index 3df73542e1..7597dc1c39 100644
>>> --- a/softmmu/physmem.c
>>> +++ b/softmmu/physmem.c
>>> @@ -2413,9 +2413,15 @@ MemoryRegionSection *iotlb_to_section(CPUState *=
cpu,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int asidx =3D cpu_asidx_from_attrs(cpu, =
attrs);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUAddressSpace *cpuas =3D &cpu->cpu_ase=
s[asidx];
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AddressSpaceDispatch *d =3D qatomic_rcu_=
read(&cpuas->memory_dispatch);
>>> -=C2=A0=C2=A0=C2=A0 MemoryRegionSection *sections =3D d->map.sections;
>>> +=C2=A0=C2=A0=C2=A0 int section_index =3D index & ~TARGET_PAGE_MASK;
>>> +=C2=A0=C2=A0=C2=A0 MemoryRegionSection *ret;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 assert(section_index < d->map.sections_nb);
>> This assert now triggers on staging-8.1
>> https://ci.debian.net/data/autopkgtest/testing/amd64/d/dropbear/37993610=
/log.gz
>> https://ci.debian.net/data/autopkgtest/testing/amd64/c/cryptsetup/379936=
06/log.gz
>>=20
>>> +=C2=A0=C2=A0=C2=A0 ret =3D d->map.sections + section_index;
>>> +=C2=A0=C2=A0=C2=A0 assert(ret->mr);
>>> +=C2=A0=C2=A0=C2=A0 assert(ret->mr->ops);
>>> -=C2=A0=C2=A0=C2=A0 return &sections[index & ~TARGET_PAGE_MASK];
>>> +=C2=A0=C2=A0=C2=A0 return ret;
>>> =C2=A0 }
>>> =C2=A0 static void io_mem_init(void)
>> In this upload I removed
>> softmmu-Use-async_run_on_cpu-in-tcg_commit.patch (0d58c660689f6da1),
>> and the test run uses tcg and -smp 4, which is the configuration which 0=
d58c6606
>> was supposed to fix.
>
> So, should this change not be in 8.1.1 too (together with 0d58c6606),
> or is it just the "messenger"?

Sorry my previous reply was eaten by my MUA.

The main purpose of the asserts is to catch corruption to the Memory
Regions early so we don't see weird failures later on (c.f. the 3
separate bugs for crashes in slightly different places).

IOW is we are crashing on the asserts in this patch but it's booting
without it we are just getting lucky.

>
> Or both should go?
>
> Today is the deadline day for 8.1.1.
>
> Thanks!
>
> /mjt


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

