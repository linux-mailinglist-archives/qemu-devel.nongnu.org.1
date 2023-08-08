Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99553774560
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 20:42:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTRej-00035o-If; Tue, 08 Aug 2023 14:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTReP-0002vG-44
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 14:41:51 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTReM-00030s-LF
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 14:41:48 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-317c1845a07so4508925f8f.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 11:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691520105; x=1692124905;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JEemCL7MCKBCZq5UhJ+qXSK5gfC8Hx5K/LOrzpkC8v0=;
 b=NXufMC8SOYoyrAtuJ0vJJEMtKa0uckd9n7CnaAJG7+LnCOqBbJpnefnM2Vso72Fgis
 2+9T6kuBtUDdi/NBF3F+imDH8tI+RrCuPQeZlAGj6n/2fEJ16bbWbxfHrRb15tVky+zP
 l84tDp4Ds7uWAwLcZ8UBnlLLtyYa6sR4kJx4TWRvJngve685YeTaVqu0pnDrISV+KsZN
 oYeqh14+9Um1NjlfhOUe1nmsXqQmN5p46WDvTK04PUu0a609xWWn/EZnFkjSqNi/n9JD
 U6Hq7jQRPoMnlzKJceSwh7cSuQte+F90S4lzP5zPRjYhspbc/lNTnqfc/5A6tDd4LmXR
 p0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691520105; x=1692124905;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JEemCL7MCKBCZq5UhJ+qXSK5gfC8Hx5K/LOrzpkC8v0=;
 b=BcJJQa/INiZSR50X52R6nPbhfRG5Ivq9XcSZEULSPgKGH8JOy1VqVPTHzNPkFs4ULr
 94hl5XFmcl/jm30OTkpXauHMk1qU1+CyxgugjkjDJNjxvmFv8h/DeIslSvfgvOBgrf9d
 dPs4wBKwJO3EfxwyfYmmHbTNH2CB5AlJ8mYE+THuHkRjIzTQKgZ/5FBY8hnZ1HC3deVM
 huBC7Vmb0IT2zEetkl1Vso81wYth4aERa5GGd7/pfwzzORFt3UFyVZWD5E8fOqpOeYrX
 Lt6l6ogH5Tst0jds6dLYhGD+6fuAok6U2LKkRC2Wfu80/Anghzgn7HZd/jisKrWf3qJU
 MpGA==
X-Gm-Message-State: AOJu0Yy7dr3axSMqWtGIWHLmrEdIsBZRzRqmnds8r2gLonMfw0jtGvPN
 UsZLyQDygMPbH21IMuTe3l9LwK7wlKsoTJ13OgU=
X-Google-Smtp-Source: AGHT+IEMbBuWz2vzGzwUZFNdddDKgsWzx4ACNiHfxffi2Po6YxjJAntulZ09uWPhyh3N+Kr39gHNCQ==
X-Received: by 2002:a5d:4acf:0:b0:317:6623:e33f with SMTP id
 y15-20020a5d4acf000000b003176623e33fmr224598wrs.14.1691520105039; 
 Tue, 08 Aug 2023 11:41:45 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 b7-20020a5d40c7000000b0031423a8f4f7sm14503628wrq.56.2023.08.08.11.41.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 11:41:44 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2F9041FFBB;
 Tue,  8 Aug 2023 19:41:44 +0100 (BST)
References: <20230808054315.3391465-1-c@jia.je>
 <70c07fd1-51c6-56cd-af40-04a8323b06c5@loongson.cn>
 <df8ba12d-684b-b379-6991-8e958b8bc311@jia.je>
 <dd5eb4b9-e274-7b7f-e988-9181df271189@jia.je>
 <3615d9c9-3a26-d80c-4964-01411c668be2@loongson.cn>
User-agent: mu4e 1.11.13; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: bibo mao <maobibo@loongson.cn>
Cc: Jiajie Chen <c@jia.je>, Tiezhu Yang <yangtiezhu@loongson.cn>, Song Gao
 <gaosong@loongson.cn>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH] target/loongarch: Split fcc register to fcc0-7 in gdbstub
Date: Tue, 08 Aug 2023 19:40:42 +0100
In-reply-to: <3615d9c9-3a26-d80c-4964-01411c668be2@loongson.cn>
Message-ID: <87v8dp5qc7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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


bibo mao <maobibo@loongson.cn> writes:

> I think that it is problem of loongarch gdb, rather qemu.
> If so, everytime when gdb changes register layout, qemu need modify.
> There should be compatible requirements between gdb client and gdb server.
>
> Tiezhu,
>
> what is your opition?

You can always register additional custom regsets which is what we do
for the extended Aarch64 regs. See ->gdb_get_dynamic_xml

>
> Regards
> Bibo Mao
>
> =E5=9C=A8 2023/8/8 18:03, Jiajie Chen =E5=86=99=E9=81=93:
>>=20
>> On 2023/8/8 17:55, Jiajie Chen wrote:
>>>
>>> On 2023/8/8 14:10, bibo mao wrote:
>>>> I am not familiar with gdb, is there=C2=A0 abi breakage?
>>>> I do not know how gdb client works with gdb server with different vers=
ions.
>> There seemed no versioning in the process, but rather in-code xml
>> validation. In gdb, the code only allows new xml (fcc0-7) and
>> rejects old one (fcc), so gdb breaks qemu first and do not consider
>> backward compatibility with qemu.
>>>
>>> Not abi breakage, but gdb will complain:
>>>
>>> warning: while parsing target description (at line 1): Target
>>> description specified unknown architecture "loongarch64"
>>> warning: Could not load XML target description; ignoring
>>> warning: No executable has been specified and target does not support
>>> determining executable automatically.=C2=A0 Try using the "file" comman=
d.
>>> Truncated register 38 in remote 'g' packet
>>=20
>> Sorry, to be clear, the actual error message is:
>>=20
>> (gdb) target extended-remote localhost:1234
>> Remote debugging using localhost:1234
>> warning: Architecture rejected target-supplied description
>> warning: No executable has been specified and target does not support
>>=20
>> It rejects the target description xml given by qemu, thus using the
>> builtin one. However, there is a mismatch in fcc registers, so it
>> will not work if we list floating point registers.
>>=20
>> At the same time, if we are using loongarch32 target(I recently
>> posted patches to support this), it will reject the target
>> description and fallback to loongarch64, making gcc not usable.
>>=20
>>>
>>> And gdb can no longer debug kernel running in qemu. You can
>>> reproduce this error using latest qemu(without this patch) and
>>> gdb(13.1 or later).
>>>
>>>>
>>>> Regards
>>>> Bibo Mao
>>>>
>>>>
>>>> =E5=9C=A8 2023/8/8 13:42, Jiajie Chen =E5=86=99=E9=81=93:
>>>>> Since GDB 13.1(GDB commit ea3352172), GDB LoongArch changed to use
>>>>> fcc0-7 instead of fcc register. This commit partially reverts commit
>>>>> 2f149c759 (`target/loongarch: Update gdb_set_fpu() and gdb_get_fpu()`)
>>>>> to match the behavior of GDB.
>>>>>
>>>>> Note that it is a breaking change for GDB 13.0 or earlier, but it is
>>>>> also required for GDB 13.1 or later to work.
>>>>>
>>>>> Signed-off-by: Jiajie Chen <c@jia.je>
>>>>> ---
>>>>> =C2=A0 gdb-xml/loongarch-fpu.xml=C2=A0 |=C2=A0 9 ++++++++-
>>>>> =C2=A0 target/loongarch/gdbstub.c | 16 +++++++---------
>>>>> =C2=A0 2 files changed, 15 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/gdb-xml/loongarch-fpu.xml b/gdb-xml/loongarch-fpu.xml
>>>>> index 78e42cf5dd..e81e3382e7 100644
>>>>> --- a/gdb-xml/loongarch-fpu.xml
>>>>> +++ b/gdb-xml/loongarch-fpu.xml
>>>>> @@ -45,6 +45,13 @@
>>>>> =C2=A0=C2=A0=C2=A0 <reg name=3D"f29" bitsize=3D"64" type=3D"fputype" =
group=3D"float"/>
>>>>> =C2=A0=C2=A0=C2=A0 <reg name=3D"f30" bitsize=3D"64" type=3D"fputype" =
group=3D"float"/>
>>>>> =C2=A0=C2=A0=C2=A0 <reg name=3D"f31" bitsize=3D"64" type=3D"fputype" =
group=3D"float"/>
>>>>> -=C2=A0 <reg name=3D"fcc" bitsize=3D"64" type=3D"uint64" group=3D"flo=
at"/>
>>>>> +=C2=A0 <reg name=3D"fcc0" bitsize=3D"8" type=3D"uint8" group=3D"floa=
t"/>
>>>>> +=C2=A0 <reg name=3D"fcc1" bitsize=3D"8" type=3D"uint8" group=3D"floa=
t"/>
>>>>> +=C2=A0 <reg name=3D"fcc2" bitsize=3D"8" type=3D"uint8" group=3D"floa=
t"/>
>>>>> +=C2=A0 <reg name=3D"fcc3" bitsize=3D"8" type=3D"uint8" group=3D"floa=
t"/>
>>>>> +=C2=A0 <reg name=3D"fcc4" bitsize=3D"8" type=3D"uint8" group=3D"floa=
t"/>
>>>>> +=C2=A0 <reg name=3D"fcc5" bitsize=3D"8" type=3D"uint8" group=3D"floa=
t"/>
>>>>> +=C2=A0 <reg name=3D"fcc6" bitsize=3D"8" type=3D"uint8" group=3D"floa=
t"/>
>>>>> +=C2=A0 <reg name=3D"fcc7" bitsize=3D"8" type=3D"uint8" group=3D"floa=
t"/>
>>>>> =C2=A0=C2=A0=C2=A0 <reg name=3D"fcsr" bitsize=3D"32" type=3D"uint32" =
group=3D"float"/>
>>>>> =C2=A0 </feature>
>>>>> diff --git a/target/loongarch/gdbstub.c b/target/loongarch/gdbstub.c
>>>>> index 0752fff924..15ad6778f1 100644
>>>>> --- a/target/loongarch/gdbstub.c
>>>>> +++ b/target/loongarch/gdbstub.c
>>>>> @@ -70,10 +70,9 @@ static int loongarch_gdb_get_fpu(CPULoongArchState=
 *env,
>>>>> =C2=A0 {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (0 <=3D n && n < 32) {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return gdb_get=
_reg64(mem_buf, env->fpr[n].vreg.D(0));
>>>>> -=C2=A0=C2=A0=C2=A0 } else if (n =3D=3D 32) {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t val =3D read_fcc=
(env);
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return gdb_get_reg64(mem_=
buf, val);
>>>>> -=C2=A0=C2=A0=C2=A0 } else if (n =3D=3D 33) {
>>>>> +=C2=A0=C2=A0=C2=A0 } else if (32 <=3D n && n < 40) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return gdb_get_reg8(mem_b=
uf, env->cf[n - 32]);
>>>>> +=C2=A0=C2=A0=C2=A0 } else if (n =3D=3D 40) {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return gdb_get=
_reg32(mem_buf, env->fcsr0);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>> @@ -87,11 +86,10 @@ static int loongarch_gdb_set_fpu(CPULoongArchStat=
e *env,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (0 <=3D n && n < 32) {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->fpr[n].vr=
eg.D(0) =3D ldq_p(mem_buf);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 length =3D 8;
>>>>> -=C2=A0=C2=A0=C2=A0 } else if (n =3D=3D 32) {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t val =3D ldq_p(me=
m_buf);
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 write_fcc(env, val);
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 length =3D 8;
>>>>> -=C2=A0=C2=A0=C2=A0 } else if (n =3D=3D 33) {
>>>>> +=C2=A0=C2=A0=C2=A0 } else if (32 <=3D n && n < 40) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->cf[n - 32] =3D ldub_=
p(mem_buf);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 length =3D 1;
>>>>> +=C2=A0=C2=A0=C2=A0 } else if (n =3D=3D 40) {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->fcsr0 =3D=
 ldl_p(mem_buf);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 length =3D 4;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

