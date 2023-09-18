Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A1A7A4AA8
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 15:40:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiETx-0007iq-EP; Mon, 18 Sep 2023 09:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qiETu-0007iU-9J
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 09:40:07 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qiETs-0005wD-4q
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 09:40:05 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-31ad779e6b3so4348933f8f.2
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 06:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695044401; x=1695649201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2nUulJ5/mze7DWwNLRLCNKjjikODq6xGe1A7j7MTl78=;
 b=PJ26J6r+Yqprb8RrknaCs2ZISq4iUmwGrysF2FM/sh1UgbgCCrq5h4Iw72VMGduTLh
 duNgsU5TvkT6OswxVPCUsF2vMElLp4EL43BkiRBw6EUWRq4SpDEBeywdjn/SEDyLLuzK
 cpUWlb/Md0t/IKqaFnuUF7Y3bFOpV7solvdz3HVea4HmiRa6yPyVPn+zUFcxQmhLElLK
 f/MFUouLxDJZDTNMG7/KbzM8irM6zQfRnDvmW0pOwcdNiz8w7AGmCQvvCgRhIHKQTK3u
 7L9CtB6S23cRzygkkwLuARlRkHyEMECsQ0EENB51dPUPswXxWMDbNxAHPxr37zf4vkwu
 n4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695044401; x=1695649201;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2nUulJ5/mze7DWwNLRLCNKjjikODq6xGe1A7j7MTl78=;
 b=d9/IZXX2XFhoW05bVI5UFky51+m/OhqQtB3Eau8o1dp5Hts5gYbznz6G6SxDomV/F/
 anqYO/CD4XqWia4KI4/HMqCDR19sacOxcq3tWmYLXh506y6hHkmkX6KJECW+TsnJK8P5
 5c63JzBF7PsgEXSdI1eG19A3525VTzSmQNFs6+M2twSi4ZFAX3Py78dMW/FlIie9W4xQ
 ren1TvMDr18eP4S3RLJCHNVFchxjaSKhdDTOe/Cu0Oi6vnWCpYgBBs6d8fKxeUQH1c8q
 vU1ChQvb5sWpoPTliwGxRFnNWGUcuHN0FRORICylLEejZoI7FW0u3BEm5BaLCcVl9Jkq
 uflg==
X-Gm-Message-State: AOJu0YzyPWOzZb3mBskBjQsHRdRGnadDS8DeOgmM8qSjzSzgU59k8TvX
 EVT2KdH2r1pDecZ8SYF0vi6CAzvN99B+EVg5oPw=
X-Google-Smtp-Source: AGHT+IH60e4NW+odhsORa5KTz9VnoMyxMuKcnPXx9APrEvMzZYFnt1yGMrpvs3F7l7IsF2YVAmhzdg==
X-Received: by 2002:adf:b197:0:b0:320:7272:8fbe with SMTP id
 q23-20020adfb197000000b0032072728fbemr2809598wra.17.1695044400729; 
 Mon, 18 Sep 2023 06:40:00 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 y14-20020a5d4ace000000b003176eab8868sm12954645wrs.82.2023.09.18.06.40.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Sep 2023 06:40:00 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BA80F1FFBB;
 Mon, 18 Sep 2023 14:39:59 +0100 (BST)
References: <20230916033011.479144-1-richard.henderson@linaro.org>
 <20230916033011.479144-2-richard.henderson@linaro.org>
 <CVLU8T2IALFW.1BIYIZ1T0NEJ6@wheely> <87v8c7x668.fsf@linaro.org>
 <CVLZJR0IZQHP.2SLPV8WML9QJ0@wheely>
User-agent: mu4e 1.11.20; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Ivan Warren
 <ivan@vmfacility.fr>, qemu-devel@nongnu.org
Subject: Re: [PULL 01/39] accel/tcg: mttcg remove false-negative halted
 assertion
Date: Mon, 18 Sep 2023 13:19:48 +0100
In-reply-to: <CVLZJR0IZQHP.2SLPV8WML9QJ0@wheely>
Message-ID: <87jzsnwqfk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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


"Nicholas Piggin" <npiggin@gmail.com> writes:

> On Mon Sep 18, 2023 at 5:59 PM AEST, Alex Benn=C3=A9e wrote:
>>
>> "Nicholas Piggin" <npiggin@gmail.com> writes:
>>
>> > On Sat Sep 16, 2023 at 1:29 PM AEST, Richard Henderson wrote:
>> >> From: Nicholas Piggin <npiggin@gmail.com>
>> >>
>> >> mttcg asserts that an execution ending with EXCP_HALTED must have
>> >> cpu->halted. However between the event or instruction that sets
>> >> cpu->halted and requests exit and the assertion here, an
>> >> asynchronous event could clear cpu->halted.
>> >>
>> >> This leads to crashes running AIX on ppc/pseries because it uses
>> >> H_CEDE/H_PROD hcalls, where H_CEDE sets self->halted =3D 1 and
>> >> H_PROD sets other cpu->halted =3D 0 and kicks it.
>> >>
>> >> H_PROD could be turned into an interrupt to wake, but several other
>> >> places in ppc, sparc, and semihosting follow what looks like a similar
>> >> pattern setting halted =3D 0 directly. So remove this assertion.
>> >>
>> >> Reported-by: Ivan Warren <ivan@vmfacility.fr>
>> >> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> >> Message-Id: <20230829010658.8252-1-npiggin@gmail.com>
>> >> [rth: Keep the case label and adjust the comment.]
>> >
>> > Hey Richard,
>> >
>> > Thanks for picking this up.
>> >
>> > I think EXCP_HLT and EXCP_HALTED are effectively the same, so they cou=
ld
>> > be merged after this.
>> >
>> > I couldn't quite decipher the intended difference between them, HLT is
>> > "hlt instruction reached", but it does tend to go into a mode where it
>> > is halted waiting for external event. Is there some useful difference =
in
>> > semantics we should retain (and at least try to find a way to assert)?
>>
>> I always thought HALTED was where the system was halted (e.g. during a
>> shutdown) but I agree its less than clear.
>
> Maybe that was so. I didn't manage to track down the original intention
> of them, but now they are not different, HALTED does just wait for event
> too. EXCP_HALTED did previously require the operation set ->halted =3D 1
> before calling (the assert only breaks due to concurrent wakeup clearing
> it). But some ops that use EXCP_HLT also set ->halted.
>
> So nowadays halted =3D=3D 1 means to check ->cpu_has_work() before running
> the CPU again (and otherwise wait on io event as you say). And
> EXCP_HLT/HALTED are both just ways to return from the cpu exec loop.
>
> One thing I'm not sure of is why you would set EXCP_HLT without setting
> halted. In some cases it could be a bug (e.g., avr helper_sleep()), but
> there are a few ops that use it after a CPU reset or shutdown which
> might be valid. Could call those ones something like EXCP_RESET or
> EXCP_REEXEC.

Reading the comments:

#define EXCP_HLT        0x10001 /* hlt instruction reached */
#define EXCP_HALTED     0x10003 /* cpu is halted (waiting for external even=
t) */

makes me think HLT covers instructions like WFI which we didn't use to
fully model (and architecturally can just be NOPs). Might be worth
splerlunking in the commit log to find when they were introduced.

>
> Thanks,
> Nick


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

