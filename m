Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13ED0809286
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 21:39:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBL8Q-0005mU-Uv; Thu, 07 Dec 2023 15:38:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rBL8O-0005jS-VT
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 15:38:13 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rBL8M-00055u-TD
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 15:38:12 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40c26a45b2dso8354855e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 12:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701981488; x=1702586288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dCarwZwdEe/7GFF0ndcqH0Se3YSpnkEsBz7lQTD0Hx8=;
 b=Jkioa86yi4jKu7TeyD2+9A5NFncYDrZvjkKdLfWvSyWlIz+tKeHEFf5gbfLbAoRCWb
 ntlTILRIy4UGcOJ7bi63WSmI55tiaT8FaCA6OZhCxRWhLHhnpOUS//L5soPnJwqU9RPC
 Y2Aj8nvuDIQ5K1BidWYnr4sf7LBFf8/ty12cTAn1LrL0/jMMES6LSToBVvjjSy4PtI1U
 Kw0DvSYQPUEF9cHC9zj7mDXM7FYr6ejRCnLbuuldyoJ4OLf2/hVR3dfOSVW051/R7upW
 CeHnSc3suvM2TQO5pCoQz8t0eUu2E5TyVTP0SfCnToVGB3qk3kNqQzzUndn0ktxbJgKo
 WwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701981488; x=1702586288;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dCarwZwdEe/7GFF0ndcqH0Se3YSpnkEsBz7lQTD0Hx8=;
 b=JLH41eWgVXDKDISG2bF0wCvjP8W3z5FsfQxro1ivOylIr2PxEtOtOZEJ6iJ8PsaLoG
 wGuN/Ofcgdr3VHvFOqpDdsrTL9TFoKnDT9Ptn+7d+b4EqZM6Qi775ba8uV92dPCU5hbI
 763vK8goBB1F2WKrqrg3zDPAVjRh+123zcNg2d5PECZRS4j5Yu3Cqslxqh8UiK/STwb7
 03xLx7KO1K45pymGq9U++Jb0g3PvSPAJQI5vMI7021nKZq2UzupBxfm5L7mJ1H55/OG2
 mhVS7Lplqa4umWdNYYqc68FpdgR8GnPrVyD1r4taXKQFViciosymufFvCAODbKoiDVG1
 WnnQ==
X-Gm-Message-State: AOJu0YyKXgyAxvWfDxvkEhyBznR4v324u2JQiqDzGh+qTHHvAtKmo1Al
 iyzkssaiOl7TmFSTyLJixGGv1A==
X-Google-Smtp-Source: AGHT+IHVYQnDwHmPm5JMytiLT+qWHk5EkH4cdAF84UMOw/lnOBta24Fhf4RgMbpV27F2eeyoL+wIOg==
X-Received: by 2002:a05:600c:3093:b0:405:784a:d53e with SMTP id
 g19-20020a05600c309300b00405784ad53emr2970085wmn.20.1701981488289; 
 Thu, 07 Dec 2023 12:38:08 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 c17-20020a05600c0a5100b0040b4fca8620sm3003373wmq.37.2023.12.07.12.38.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 12:38:08 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 896295FBCC;
 Thu,  7 Dec 2023 20:38:07 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org,  vikram.garhwal@amd.com,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>
Subject: Re: [PATCH for 8.2] docs: clean-up the xenpvh documentation
In-Reply-To: <CAJSP0QU0x6Kds74LOzbfRy0X2igxS_7XydwL68Sfy3ypT_=j8A@mail.gmail.com>
 (Stefan Hajnoczi's message of "Thu, 7 Dec 2023 14:29:18 -0500")
References: <20231207130623.360473-1-alex.bennee@linaro.org>
 <CAJSP0QU0x6Kds74LOzbfRy0X2igxS_7XydwL68Sfy3ypT_=j8A@mail.gmail.com>
User-Agent: mu4e 1.11.26; emacs 29.1
Date: Thu, 07 Dec 2023 20:38:07 +0000
Message-ID: <87v899yci8.fsf@draig.linaro.org>
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

Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Thu, 7 Dec 2023 at 08:07, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>> I noticed the code blocks where not rendering properly so thought I'd
>> better fix things up. So:
>>
>>   - Use better title for the machine type
>>   - Explain why Xen is a little different
>>   - Add a proper anchor to the tpm-device link
>>   - add newline so code block properly renders
>>   - add some indentation to make continuation clearer
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  docs/specs/tpm.rst         |  2 ++
>>  docs/system/arm/xenpvh.rst | 39 +++++++++++++++++++++-----------------
>>  2 files changed, 24 insertions(+), 17 deletions(-)
>
> QEMU 8.2.0-rc3 has already been tagged. At this stage only critical
> bugs (crashes during startup, security issues, serious memory leaks,
> etc).
>
> This patch looks like a nice documentation fix but it has a limited
> scope and I don't think it warrants rolling an -rc4 tag next week.
>
> Do you agree with deferring this patch until after the 8.2 release?

Sure - but if you do end up rolling an rc4 it would be a low risk fix.

>
> Stefan
>
>>
>> diff --git a/docs/specs/tpm.rst b/docs/specs/tpm.rst
>> index efe124a148..c96776a369 100644
>> --- a/docs/specs/tpm.rst
>> +++ b/docs/specs/tpm.rst
>> @@ -1,3 +1,5 @@
>> +.. _tpm-device:
>> +
>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>  QEMU TPM Device
>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> diff --git a/docs/system/arm/xenpvh.rst b/docs/system/arm/xenpvh.rst
>> index e1655c7ab8..430ac2c02e 100644
>> --- a/docs/system/arm/xenpvh.rst
>> +++ b/docs/system/arm/xenpvh.rst
>> @@ -1,34 +1,39 @@
>> -XENPVH (``xenpvh``)
>> +Xen Device Emulation Backend (``xenpvh``)
>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> -This machine creates a IOREQ server to register/connect with Xen Hyperv=
isor.
>>
>> -When TPM is enabled, this machine also creates a tpm-tis-device at a us=
er input
>> -tpm base address, adds a TPM emulator and connects to a swtpm applicati=
on
>> -running on host machine via chardev socket. This enables xenpvh to supp=
ort TPM
>> -functionalities for a guest domain.
>> +This machine is a little unusual compared to others as QEMU just acts
>> +as an IOREQ server to register/connect with Xen Hypervisor. Control of
>> +the VMs themselves is left to the Xen tooling.
>>
>> -More information about TPM use and installing swtpm linux application c=
an be
>> -found at: docs/specs/tpm.rst.
>> +When TPM is enabled, this machine also creates a tpm-tis-device at a
>> +user input tpm base address, adds a TPM emulator and connects to a
>> +swtpm application running on host machine via chardev socket. This
>> +enables xenpvh to support TPM functionalities for a guest domain.
>> +
>> +More information about TPM use and installing swtpm linux application
>> +can be found in the :ref:`tpm-device` section.
>>
>>  Example for starting swtpm on host machine:
>> +
>>  .. code-block:: console
>>
>>      mkdir /tmp/vtpm2
>>      swtpm socket --tpmstate dir=3D/tmp/vtpm2 \
>> -    --ctrl type=3Dunixio,path=3D/tmp/vtpm2/swtpm-sock &
>> +      --ctrl type=3Dunixio,path=3D/tmp/vtpm2/swtpm-sock &
>>
>>  Sample QEMU xenpvh commands for running and connecting with Xen:
>> +
>>  .. code-block:: console
>>
>>      qemu-system-aarch64 -xen-domid 1 \
>> -    -chardev socket,id=3Dlibxl-cmd,path=3Dqmp-libxl-1,server=3Don,wait=
=3Doff \
>> -    -mon chardev=3Dlibxl-cmd,mode=3Dcontrol \
>> -    -chardev socket,id=3Dlibxenstat-cmd,path=3Dqmp-libxenstat-1,server=
=3Don,wait=3Doff \
>> -    -mon chardev=3Dlibxenstat-cmd,mode=3Dcontrol \
>> -    -xen-attach -name guest0 -vnc none -display none -nographic \
>> -    -machine xenpvh -m 1301 \
>> -    -chardev socket,id=3Dchrtpm,path=3Dtmp/vtpm2/swtpm-sock \
>> -    -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm -machine tpm-base-addr=
=3D0x0C000000
>> +      -chardev socket,id=3Dlibxl-cmd,path=3Dqmp-libxl-1,server=3Don,wai=
t=3Doff \
>> +      -mon chardev=3Dlibxl-cmd,mode=3Dcontrol \
>> +      -chardev socket,id=3Dlibxenstat-cmd,path=3Dqmp-libxenstat-1,serve=
r=3Don,wait=3Doff \
>> +      -mon chardev=3Dlibxenstat-cmd,mode=3Dcontrol \
>> +      -xen-attach -name guest0 -vnc none -display none -nographic \
>> +      -machine xenpvh -m 1301 \
>> +      -chardev socket,id=3Dchrtpm,path=3Dtmp/vtpm2/swtpm-sock \
>> +      -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm -machine tpm-base-add=
r=3D0x0C000000
>>
>>  In above QEMU command, last two lines are for connecting xenpvh QEMU to=
 swtpm
>>  via chardev socket.
>> --
>> 2.39.2
>>
>>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

