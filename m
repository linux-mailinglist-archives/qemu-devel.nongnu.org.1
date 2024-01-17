Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AF6830C39
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 18:46:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ9ym-0007pY-Vv; Wed, 17 Jan 2024 12:45:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rQ9yZ-0007mE-Rw
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 12:45:19 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rQ9yW-0006tF-Uj
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 12:45:19 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-58962bf3f89so1628189a12.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 09:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705513515; x=1706118315; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ppy6lr1K8GU5rI/m7XUnum+A5RT4JsN6Ed0EaoQVToA=;
 b=ktuNszhNZ6YBytHEs+zJNpWH1e7dokDU8X92dnkyFz+Mz2XE80FcIFWKo5YSJCRF/q
 6rRlkhcoBp2Zs+yGYInA7dzyHCji8AKS0+PwPUL1bklj9ieKASl8i+7U/S8dyvRexnQz
 DCu02KGT/Emw+/3qTl2NM/pWEoak0s9a0LeJxfwJO65Em7JMHPlRP8CAYp5EF9UYUfbZ
 qJKy4KjAxRRVShNSnJgMBF0EZf4eEY/Neu9r3YuVWkFRWBowQ+KlGrRLZalH+HfVub6y
 kcZZOlrd4WcqSf8fWzPuWS2JJJ5UI22HfRHDyEi2SSBJwNPv4NKzaP2hKlEDN+eUwx1h
 2QAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705513515; x=1706118315;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ppy6lr1K8GU5rI/m7XUnum+A5RT4JsN6Ed0EaoQVToA=;
 b=i0deVA2hnSPa/VKaQlXptZosMFcC8ToRkVYdvFH/jnW7YPGGZjv7rtqkbmIjJX6BmG
 J7NNm3Bk7LdQLEA3wlbk0zT/o4ZU46rSdHDUSkGZQWUOWxJSTn0Odmq8HEAZEowAp0IL
 Kik24wz7oQV/V+wEUOC5tjr5hYuNG9JFu0stI+V+x2QttSEfuGFcE5MPYLgAt6xQMnpP
 JL6fAyLsffVbjDprqzicfOQS2tJcnsBFENuCzg7YZwlTcCkSFyuqD7p09v487PW+CePY
 eNvgAeSU4i48SyfPN3s50UZXsHGv/RblVbiOLzglkMsrtgCx/zLAnkPebGusccLKlFq/
 LN1w==
X-Gm-Message-State: AOJu0Yx7XN2s01NoSPpu6rz14r+keOTVGoQdjsAeV+219znCW+fO+75I
 ST15TpJaCfnCU67FuRUIoLXWg2A98GiiP9mlxgFhTEoil/A=
X-Google-Smtp-Source: AGHT+IG3Z/GK8IIzlC+KOfGfV2s7EKrt4Z94m2Tt+Hjl8Xfk596EUNkCd8KVJc6UjCxV/ueZ/zZ6sw==
X-Received: by 2002:a05:6a21:6da2:b0:19a:49c8:b9e6 with SMTP id
 wl34-20020a056a216da200b0019a49c8b9e6mr19578804pzb.0.1705513515234; 
 Wed, 17 Jan 2024 09:45:15 -0800 (PST)
Received: from smtpclient.apple ([2405:201:d019:cbd3:acb0:e027:e500:b68d])
 by smtp.gmail.com with ESMTPSA id
 ei5-20020a056a0080c500b006d9c1fb00c3sm1727912pfb.9.2024.01.17.09.45.12
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 Jan 2024 09:45:14 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH 0/2] Export debug triggers as an extension
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
In-Reply-To: <6f3a2208-e3dc-43fd-9783-0fad9f76c470@ventanamicro.com>
Date: Wed, 17 Jan 2024 23:14:50 +0530
Cc: Rob Bradford <rbradford@rivosinc.com>,
 Alistair Francis <alistair23@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Alvin Chang <alvinga@andestech.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EC762E99-2479-4F66-986E-98F9B9418F32@ventanamicro.com>
References: <20240110040203.1920924-1-hchauhan@ventanamicro.com>
 <e2763db2-fade-482d-b433-1bfce6acf7d3@ventanamicro.com>
 <CAKmqyKOA6OtixYoMJ_qtXj_u0t6rMdHawg0VEvq3-=mK4q6_XQ@mail.gmail.com>
 <3c091744cd4bafeb7c1d177455fa9789822e7209.camel@rivosinc.com>
 <6f3a2208-e3dc-43fd-9783-0fad9f76c470@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=hchauhan@ventanamicro.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



> On 17-Jan-2024, at 10:29=E2=80=AFPM, Daniel Henrique Barboza =
<dbarboza@ventanamicro.com> wrote:
>=20
>=20
>=20
> On 1/12/24 10:34, Rob Bradford wrote:
>> On Fri, 2024-01-12 at 13:52 +1000, Alistair Francis wrote:
>>> On Thu, Jan 11, 2024 at 5:20=E2=80=AFAM Daniel Henrique Barboza
>>> <dbarboza@ventanamicro.com> wrote:
>>>>=20
>>>> Himanshu,
>>>>=20
>>>> We spoke offline but let's make everyone aware:
>>>>=20
>>>> - 'sdtrig' should be marked with 'x-' and be an experimental
>>>> extension since
>>>> the spec isn't yet frozen;
>>>>=20
>>>> - Alvin sent a patch to the ML adding the 'mcontext' CSR for
>>>> 'sdtrig' some time
>>>> ago:
>>>>=20
>>>> "[PATCH v2] target/riscv: Implement optional CSR mcontext of debug
>>>> Sdtrig extension"
>>>>=20
>>>> It would be good to put his patch on top of this series to ease the
>>>> review for everyone.
>>>> The changes done in patch 2 would also be applicable to the
>>>> mcontext CSR;
>>>>=20
>>>>=20
>>>> - last but probably the most important: the existing 'debug' flag
>>>> seems to be acting as
>>>> the actual 'sdtrig' extension due to how the flag is gating trigger
>>>> code, e.g.:
>>>>=20
>>>>    if (cpu->cfg.debug) {
>>>>          riscv_trigger_realize(&cpu->env);
>>>>      }
>>>>=20
>>>> and
>>>>=20
>>>>      if (cpu->cfg.debug) {
>>>>          riscv_trigger_reset_hold(env);
>>>>      }
>>>>=20
>>>>=20
>>>> If that's really the case, all the checks with cpu->cfg.debug will
>>>> need to also include
>>>> cpu->cfg.ext_sdtrig (one or the other). And now we'll have to make
>>>> an option: do we leave
>>>> the debug triggers (i.e. the 'debug' flag) as always enabled?
>>>=20
>>> =46rom memory the "debug" property is for the original debug spec:
>>> =
https://github.com/riscv/riscv-debug-spec/releases/tag/task_group_vote
>>>=20
>>> That was ratified and is an official extension. AFAIK this is what =
is
>>> in physical hardware as well.
>>>=20
>>> The actual PDF says draft though, I'm not sure what's going on =
there.
>>>=20
>>> The debug spec doesn't have a Z* name, so it's just "debug", at =
least
>>> AFAIK.
>>>=20
>>> "sdtrig" seems to be a new backwards-incompatible extension doing
>>> basically the same thing. What a mess
>>>=20
>>>>=20
>>>> If it's up to me I would make 'debug' as default 'false' and
>>>> deprecate it. Users will need
>>>=20
>>> I don't think that's the right approach. It's a ratified extension
>>> that we are supporting and is in hardware. I think we are stuck
>>> supporting it
>>>=20
>>>=20
>> I've done a bit of digging and I agree things are quite messy. Here =
are
>> my discoveries:
>> The debug option and the code for triggers was added in these =
commits:
>> c9711bd778 target/riscv: cpu: Enable native debug feature
>> 38b4e781a4 target/riscv: machine: Add debug state description
>> b6092544fc target/riscv: csr: Hook debug CSR read/write
>> 1acdb3b013 target/riscv: cpu: Add a config option for native debug
>> 95799e36c1 target/riscv: Add initial support for the Sdtrig extension
>> In March 2022 - since the commit refers to the Sdtrig extension name
>> and from the date this was an implementation not of the ratified 0.13
>> debug spec (which did not have Sdtrig as a separate extension) but
>> rather a version of the in development 1.0 debug spec.
>> It's not trivial to tell if it's closer to the ratified 0.13 version =
or
>> the (hopefully soon to be frozen) 1.0 version.
>> As the only part of the debug specification to be implemented is the
>> triggers then effectively the debug option is x-sdtrig.
>> I don't think there is any way for code running on the machine to
>> identify what version of the debug is implemented - the appropriate
>> register is only available for external debug. Once 1.0 is frozen =
then
>> the presence of Sdtrig isa string would indicate 1.0 trigger support =
is
>> available.
>> According to JIRA - https://jira.riscv.org/browse/RVS-981 the debug
>> specification should freeze this month.
>> How about considering this as a solution:
>> - Add a new x-sdtrig option that defaults to false
>> - Deprecate debug option - but retain it with default on
>> - Add warning if triggers are used and x-sdtrig is not enabled
>> - Update the trigger implementation to match frozen spec
>=20
> If x-sdtrig is 'false' and 'debug' is on, and then we warn if =
debug=3Dtrue and x-sdtrig
> is false, we'll warn every time using the defaults.
>=20
> Given what you said here:
>=20
>> There is potentially a chance that some use cases will be broken but =
I
>> don't think triggers are being widely use - the SBI support only just
>> got merged:
>> =
https://github.com/riscv-software-src/opensbi/commit/97f234f15c9657c6ec69f=
a6ed745be8107bf6a>=20
>=20
> I believe we can deprecate 'debug' and simply ignore its existence. Do =
everything else with
> x-sdtrig. So if an user sets any 'debug' value we'll:
>=20
> - warn that the flag is deprecated
> - set x-sdtrig to whatever value the user set to 'debug'
>=20
> 'debug' will become just an alternate way to set x-sdtrig. The logic =
should just check for
> x-sdtrig.

My v2 patchset which I posted a few ours back, gets rid of =E2=80=98debug=E2=
=80=99. It is replaced with x-sdtrig. Keeping them both doesn=E2=80=99t =
make sense.

Here is v2:
https://mail.gnu.org/archive/html/qemu-riscv/2024-01/msg00570.html


Regards
Himanshu

>=20
>=20
> Thanks,
>=20
>=20
> Daniel
> =20
>> Hope this is helpful,
>> Rob



