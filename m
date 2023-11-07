Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D147E4568
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 17:08:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0ObC-00031Y-CF; Tue, 07 Nov 2023 11:06:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0Ob5-00030I-Bl
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 11:06:36 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0Ob1-0003pA-8w
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 11:06:33 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4083f613275so43152225e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 08:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699373188; x=1699977988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E5PFANun2lYtlNJY56HoiUF40vPWmbzDKqZ8HXBMz9k=;
 b=svEZnS44+3G+3NwawwBevFu51h6HONjbwHrPUbrrWq0IFX0o8L4OgCHOX3Tlgw0Siw
 PB6HOUSn1ZIOklYuJnkmjPrZDcwJGQQEjw3ot5WzeWzSZ2ubv1iKg4/fAJWLGVqtu0Fq
 lYXuywfjUj+8dSLhqg1ygYiLRNBxT9nECAAncDd+T5IFiFag/iRnhvu/Gp/srwdzFkV2
 Ig25HbG8YVG/TUNT1n7wTEr4bU1zfEulze/EP17e/c1Vr5nYAj4W0QkOhpLWNHEFIxhu
 d0uko4UVrLib8w8iG7v/DHjN/wtviiM0+eSuQFo2dLKfeoIRpt/sWmRju09PTPksfifY
 DNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699373188; x=1699977988;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E5PFANun2lYtlNJY56HoiUF40vPWmbzDKqZ8HXBMz9k=;
 b=to2Y2y9Zynj/OWUaozMn82eIl6pA/DsU+pyz0Zjtk/rRaGLhHVKwdTY2PoGc3fkA5v
 iJU0Qvago5Y43hJuJ0K26nSWHbBEe2BZnhnPQoqkks5Aqn0ucCFZa+pwZxWcglsfGOWe
 tPNJHyvdrBd70X8PRVhWRQ7h6P4D4ZkI61d0Oa1jjW0/Dfm1arfy8p7PadcH4jA4/dX8
 gVrEbAS0jpv8A7p7lM1+rwv1sl3VQv7Jw1Q1HL0rnph7zB/j4HjCoQZr8HPD5nzyl/H1
 VBkAysEcq2HwY7Nw6wKOn5aGYpSAQPXm+Nhiq5aC7vvyKu/ZSJwApmlPFPe9ruOe+q6X
 y9bA==
X-Gm-Message-State: AOJu0YzdH6wpTYxpJJaGTJSAY2TodJXCc5hopyhmzlB+kXglxgutOfPo
 hP2RHXxL0SpScaswS8G7fcyk0A==
X-Google-Smtp-Source: AGHT+IGs0qyv0ZOzPoqm3eXsWSpAMUDdRzt4kLQun4MX1nFjHJtAIlosnnJs0ENbHQr2gHGShAwInA==
X-Received: by 2002:a05:600c:1386:b0:40a:28b1:70f8 with SMTP id
 u6-20020a05600c138600b0040a28b170f8mr2684099wmf.21.1699373188322; 
 Tue, 07 Nov 2023 08:06:28 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 g20-20020a05600c4ed400b003fee8793911sm16524342wmq.44.2023.11.07.08.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 08:06:28 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 759E15F790;
 Tue,  7 Nov 2023 16:06:27 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org,  Jason Wang <jasowang@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  qemu-block@nongnu.org,
 Markus Armbruster
 <armbru@redhat.com>,  Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Stefan Hajnoczi <stefanha@redhat.com>,  Gerd Hoffmann
 <kraxel@redhat.com>,  "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 virtio-fs@redhat.com,  Hanna Reitz <hreitz@redhat.com>,  Fam Zheng
 <fam@euphon.net>,  Raphael Norwitz <raphael.norwitz@nutanix.com>,  Kevin
 Wolf <kwolf@redhat.com>,  Erik Schilling <erik.schilling@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,  Mathieu Poirier
 <mathieu.poirier@linaro.org>,  Eric Blake <eblake@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v6 1/6] virtio: split into vhost-user-base and
 vhost-user-device
In-Reply-To: <20231107020835-mutt-send-email-mst@kernel.org> (Michael S.
 Tsirkin's message of "Tue, 7 Nov 2023 02:15:20 -0500 (8 hours, 49
 minutes, 54 seconds ago)")
References: <20231106191515.2801863-1-alex.bennee@linaro.org>
 <20231106191515.2801863-2-alex.bennee@linaro.org>
 <20231107020835-mutt-send-email-mst@kernel.org>
User-Agent: mu4e 1.11.24; emacs 29.1
Date: Tue, 07 Nov 2023 16:06:27 +0000
Message-ID: <87il6dbla4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Mon, Nov 06, 2023 at 07:15:10PM +0000, Alex Benn=C3=A9e wrote:
>> Lets keep a cleaner split between the base class and the derived
>> vhost-user-device which we can use for generic vhost-user stubs. This
>> includes an update to introduce the vq_size property so the number of
>> entries in a virtq can be defined.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-Id: <20231009095937.195728-2-alex.bennee@linaro.org>
>>=20
>> ---
>> v5
>>   - s/parent/parent_obj/
>>   - remove left over vhost-user-device.h
>>   - use DEFINE_TYPES
>> v6
>>   - rebase and set .abstrace =3D true for vhost-user-device
>
> abstract :)

How do I stop the PCI device being instantiated by qtest?

# Testing device 'vhost-user-device-pci'
Bail out! ERROR:../../qom/object.c:524:object_initialize_with_type: asserti=
on failed: (type->abstract =3D=3D false)
----------------------------------- stderr --------------------------------=
---
**
ERROR:../../qom/object.c:524:object_initialize_with_type: assertion failed:=
 (type->abstract =3D=3D false)
Broken pipe
../../tests/qtest/libqtest.c:204: kill_qemu() detected QEMU death from sign=
al 6 (Aborted)

(test program exited with status code -6)

>
>
> ...
>
>
>> +static const TypeInfo vub_types[] =3D {
>> +    {
>> +        .name =3D TYPE_VHOST_USER_BASE,
>> +        .parent =3D TYPE_VIRTIO_DEVICE,
>> +        .instance_size =3D sizeof(VHostUserBase),
>> +        .class_init =3D vub_class_init,
>> +        .class_size =3D sizeof(VHostUserBaseClass),
>> +        .abstract =3D true
>
> I suspect it's this change that breaks CI:=20
>
> https://gitlab.com/mstredhat/qemu/-/jobs/5472898562
>
> WARNING: qemu received signal 6; command: "./qemu-system-ppc -display non=
e -vga none -chardev socket,id=3Dmon,fd=3D3 -mon chardev=3Dmon,mode=3Dcontr=
ol -S -machine g3beige,accel=3Dtcg -device vhost-user-device-pci"
> CRITICAL: failed: binary=3D./qemu-system-ppc accel=3Dtcg machine=3Dg3beig=
e device=3Dvhost-user-device-pci
> CRITICAL: cmdline: ./qemu-system-ppc -S -machine g3beige,accel=3Dtcg -dev=
ice vhost-user-device-pci
> CRITICAL: log: **
> CRITICAL: log: ERROR:../qom/object.c:524:object_initialize_with_type: ass=
ertion failed: (type->abstract =3D=3D false)
> CRITICAL: log: Bail out! ERROR:../qom/object.c:524:object_initialize_with=
_type: assertion failed: (type->abstract =3D=3D false)
> CRITICAL: exit code: -6
>
> 146/395 qemu:qtest+qtest-mips / qtest-mips/device-introspect-test        =
     ERROR           1.27s   killed by signal 6 SIGABRT
> 153/395 qemu:qtest+qtest-xtensa / qtest-xtensa/device-introspect-test    =
     ERROR           1.56s   killed by signal 6 SIGABRT
> 171/395 qemu:qtest+qtest-riscv32 / qtest-riscv32/device-introspect-test  =
     ERROR           1.40s   killed by signal 6 SIGABRT
> 184/395 qemu:qtest+qtest-ppc / qtest-ppc/device-introspect-test          =
     ERROR           1.51s   killed by signal 6 SIGABRT
> 195/395 qemu:qtest+qtest-sparc64 / qtest-sparc64/device-introspect-test  =
     ERROR           1.35s   killed by signal 6 SIGABRT
>
> I dropped this .abstract =3D true line for now and the part about it in
> docs.  Pls send patch on top once pull is merged.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

