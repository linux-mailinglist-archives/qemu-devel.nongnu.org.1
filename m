Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A797E3909
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:25:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0JDR-0001dw-Fi; Tue, 07 Nov 2023 05:21:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0JDB-000111-DN
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:21:33 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0JD7-000509-Hb
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:21:33 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4083f613275so40352055e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699352486; x=1699957286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OI9eKfcbyz/QMfMeBYcH7KTfBkFrI8n81OwgHknDM74=;
 b=APou6Nn0rIYEvWUU9j+UL7QLDIe4vOjbkE7DIH9ftI1uPda50nvZsXi621GvtLiBEa
 6jnXbSVzoEQjEq0tue1hvHUJWHRhx57TCYyp+XXLjrgE0WmRFwcKjiOyVceWyoe3MIXv
 EEhkH9XoXG6dzDe/d1HNHbM0fFdmvZuHvHeT9ckmiAgnzMbgB8XhMJoBxzjS3XbPRMAu
 8zBBd27vktl2hLsv1Y/YDiu+8aMG7D1esGO07M2T4IX3j94degh0QB2DvkEhfJXtbfAl
 Qq7AUWtWrhz4JvTjljGt2q49Xg7RklgepDIwZwFZE79vI2npuaRla/XHhn+MujV0ZeTd
 efnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699352486; x=1699957286;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OI9eKfcbyz/QMfMeBYcH7KTfBkFrI8n81OwgHknDM74=;
 b=nOa2EHODEzSxaV/vBqYzgVWq0IXwNPAsWMQXv7SdyFDZOlWtnPdcIMEgvDApteq1Ni
 laAp1xOIi3fbWwhaUGvQr536KWQoFe7N8HMl3p/OhVxcuGn/aO0p0nWynlSTqW3bW4MR
 CuGhbYwr4FDUfrWWPpH2PyWS2xdUWpRPi0I1WqubPxMim5PF5yzH7466Wn5Wpg/E99YA
 vp2kd5CIqoJlqo1TAwvjsB6h8nWt9HILBLvVeV4o56imPxNozC9ZQcU+lRnK2XaGntan
 s/udS/ocDN7P6O3bI+VwA0f76FEnFgMs/KBbieBovnkL/WuBF4YtRIvp2iud2X6sUplV
 WszA==
X-Gm-Message-State: AOJu0YwMDGrYoVWxSg6YDJg5eYjFcmAN/fmrMHn9L3K/a6FP8Wb/9c/i
 7xJGvE+ABN8mef8TfQ41gG9N4A==
X-Google-Smtp-Source: AGHT+IHGgTy42gMXLyyznDFkS5LrEHWn03TCkx1NqQD5C+sKqjFrKh9PjKH+jx+a1Da23/ULYoObKA==
X-Received: by 2002:a05:600c:4512:b0:405:dbe2:df10 with SMTP id
 t18-20020a05600c451200b00405dbe2df10mr1653715wmo.35.1699352485581; 
 Tue, 07 Nov 2023 02:21:25 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 r16-20020a05600c459000b003fefaf299b6sm15298090wmo.38.2023.11.07.02.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:21:25 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 901AA5F790;
 Tue,  7 Nov 2023 10:21:24 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Philippe =?utf-8?Q?Mathi?=
 =?utf-8?Q?eu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 03/22] target/arm: hide the 32bit version of PAR from
 gdbstub
In-Reply-To: <941e40a0-b235-4c31-8e0d-6a1ac868e72a@linaro.org> (Richard
 Henderson's message of "Mon, 6 Nov 2023 19:52:44 -0800 (6 hours, 23
 minutes ago)")
References: <20231106185112.2755262-1-alex.bennee@linaro.org>
 <20231106185112.2755262-4-alex.bennee@linaro.org>
 <941e40a0-b235-4c31-8e0d-6a1ac868e72a@linaro.org>
User-Agent: mu4e 1.11.24; emacs 29.1
Date: Tue, 07 Nov 2023 10:21:24 +0000
Message-ID: <87edh17tjv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 11/6/23 10:50, Alex Benn=C3=A9e wrote:
>> This is a slightly hacky way to avoid duplicate PAR's in the system
>> register XML we send to gdb which causes an alias. However the other
>> alternative would be to post process ARMCPRegInfo once all registers
>> have been defined looking for textual duplicates. And that seems like
>> overkill.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-Id: <20231103195956.1998255-4-alex.bennee@linaro.org>
>> ---
>>   target/arm/helper.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index 5dc0d20a84..104f9378b4 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -3727,7 +3727,7 @@ static const ARMCPRegInfo vapa_cp_reginfo[] =3D {
>>         .access =3D PL1_RW, .resetvalue =3D 0,
>>         .bank_fieldoffsets =3D { offsetoflow32(CPUARMState, cp15.par_s),
>>                                offsetoflow32(CPUARMState, cp15.par_ns) },
>> -      .writefn =3D par_write },
>> +      .writefn =3D par_write, .type =3D ARM_CP_NO_GDB },
>>   #ifndef CONFIG_USER_ONLY
>>       /* This underdecoding is safe because the reginfo is NO_RAW. */
>>       { .name =3D "ATS", .cp =3D 15, .crn =3D 7, .crm =3D 8, .opc1 =3D 0=
, .opc2 =3D CP_ANY,
>
> If the implementation includes LPAE, this is an alias of the full
> 64-bit register (the "other PAR", and so type should contain
> ARM_CP_ALIAS.
>
> If the implementation does not include LPAE, this should not be
> ARM_CP_NO_GDB because there is no 64-bit alternate.

I did discuss with Peter on IRC but its a lot of hoop jumping for very
little benefit. But I guess I can add some logic to do that.

  [17:58:51] <pm215> no, those are different registers. the PAR in lpae_cp_=
reginfo is ARM_CP_64BIT, and the one in vapa_cp_reginfo is not
  [17:59:51] > ah yes slightly different opcs
  [17:59:54] >     { .name =3D "PAR", .cp =3D 15, .crm =3D 7, .opc1 =3D 0,
  [18:00:07] > vs
  [18:00:09] >     { .name =3D "PAR", .cp =3D 15, .crn =3D 7, .crm =3D 4, .=
opc1 =3D 0, .opc2 =3D 0,
  [18:00:18] <pm215> the important bit is the ARM_CP_64BIT
  [18:00:20] > pm215 should they have differnt names then?
  [18:00:39] <pm215> historically we have said that the .name field is pure=
ly for debug purposes and not worried too much about overlap
  [18:01:27] <pm215> architecturally these are considered two different acc=
ess methods for getting at the same PAR register
  [18:01:54] <pm215> (unlike the AArch64 PAR_EL1, which is considered a sep=
arate register whose bits are 'architecturally mapped' to the AArch32 PAR)
  [18:02:51] > PAR_A32 and PAR_A64?
  [18:03:19] <pm215> no
  [18:03:20] > afterall these are extra registers we report to gdb so we ca=
n control the naming
  [18:03:24] <pm215> the AArch64 register is PAR_EL1
  [18:03:43] > or so PAR and PAR_EL1
  [18:03:58] <pm215> the AArch32 register is PAR, and there are two differe=
nt ways to read it, with the 32-bit MRC/MCR insns, or with the 64-bit MCRR/=
MRRC insns
  [18:04:23] > oh we define PAR_EL1 as well
  [18:04:26] >     { .name =3D "PAR_EL1", .state =3D ARM_CP_STATE_AA64,
  [18:04:26] >       .type =3D ARM_CP_ALIAS,
  [18:04:26] >       .opc0 =3D 3, .opc1 =3D 0, .crn =3D 7, .crm =3D 4, .opc=
2 =3D 0,
  [18:04:29] <pm215> yep
  [18:05:08] > PAR, PAR_A64 and PAR_El1?
  [18:05:20] <pm215> PAR_A64 implies AArch64, which it is not
  [18:05:34] > PAR_64?
  [18:05:49] <pm215> what are you trying to achieve here? that every cpreg =
has a distinct name string?
  [18:06:22] > pm215 yes - as we expose them to gdb and hence are over writ=
ing one definition with the other
  [18:06:40] <pm215> the correct way to expose them to the user would be to=
 only present one PAR, which is 64 bits
  [18:06:56] <pm215> i.e. if the 64-bit version is present, ignore the 32-b=
it version
  [18:07:09] * stsquad2 has also fixed a duplicate q10 in arm-neon.xml
  [18:07:39] <pm215> duplicate q10> I wonder if that's in gdb's copy too?
  [18:09:14] > this is qemu-arm so
  [18:09:36] <pm215> yes, qemu-arm will have both the 32-bit and 64-bit PAR
  [18:09:40] <pm215> (depending on cpu type)
  [18:10:20] > *sigh*
  [18:10:33] > I suspect this will be messy to fix...=20
  [18:11:02] <pm215> the gdb exposure of sysregs was always a bit of a "thi=
s basically works" hack
  [18:11:36] <pm215> ideally for an AArch64 vcpu we would expose them with =
the correct-for-AArch64 names, but we don't in many cases where the regdef =
is shared with AArch32
  [18:12:24] > so I could split vapa_cp_reginfo into two parts and do a che=
ck on if the 64 bit feature exits before adding it?
  [18:13:00] <pm215> that won't really help you, because on a CPU with FEAT=
_LPAE we need both regdefs
  [18:13:42] * stsquad2 does not want to add a .dont_expose_to_gdb field to=
 ARMCPRegInfo
  [18:14:21] <pm215> stsquad2: we already have ARM_CP_NO_GDB :-)
  [18:17:19] > pm215 we have logic that applies         r2->type |=3D ARM_C=
P_ALIAS | ARM_CP_NO_GDB;
  [18:19:40] <pm215> stsquad2: yeah, that's for the CP_ANY wildcarding. But=
 there's no inherent reason you couldn't mark a regdef with ARM_CP_NO_GDB b=
y hand
  [18:19:51] > pm215 looking at the commit that added it: "This bit could b=
e enabled manually for any register we want to remove from the
  [18:19:51] > dynamic XML description."=20
  [18:20:32] <pm215> (ARM_CP_NO_RAW registers also don't get exposed to gdb)
  [18:20:49] > pm215 so I'll just add it to the 32 bit register and wait fo=
r the 1 user in the future to complain they can't see it out of the 100s of=
 sysregs we expose
  [18:21:28] <pm215> that breaks reading PAR from gdbstub for any pre-v7VE =
CPU
  [18:22:05] > pm215 we can argue the case on the review ;-)
  [18:22:33] > in the current case its failing a linux-user test which is e=
xplicitly -cpu max anyway
  [18:30:52] * stsquad2 looks at DBGDSAR next


>
>
> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

