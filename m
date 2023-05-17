Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D30706C8E
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 17:23:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzIzH-0003Un-31; Wed, 17 May 2023 11:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pzIzE-0003UU-VT
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:22:45 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pzIzD-0008Dd-2y
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:22:44 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3f42bcf5df1so9094385e9.3
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 08:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684336961; x=1686928961;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oKC/hnfBNY4arxPmfaUzDmZdpILYCelpOsw4Us1SN1g=;
 b=pV5/1zMGOfBuJqZcX0TGHmrCLTj9ruWZZLbKl//zqMt7JRxL26yKCiPcFg1uEunl1I
 bcVDQlr1lzzYTJ7fHyQa/4dbcyp/VHvGcZN6jbMg1hPwy6r92A+aoxlw+CjH94HROz+1
 lawwtniu2fY5CZvTcKQlVWkzBY5MzSHVlgWBynJdyC2MQ3pdOEyZBEJtt+Fe8AQ8KBYL
 Iw7hZwYQ3VtF31yt1eNldc6wl9YeMMIwSDDz/68AY0wxfYnBndLuBXKjRDkqjWYPDBQQ
 B8jLteF7EfAvaJ9RUDMquQYhHUUuXXxKCA7//fBtyPn3wSjoG9UWxTQ20eZqmRYg/PNA
 Id6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684336961; x=1686928961;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oKC/hnfBNY4arxPmfaUzDmZdpILYCelpOsw4Us1SN1g=;
 b=QJ0tL4S5YZavcSj99B8/4KYkiGGE1DMB++cGQD9RGS2qXmA+08B3m46eQNF8ZOned6
 tCeSdnyPA8hynwFIO8X/XL84TBnVywAY4/qvdJ1b5w//4WXP/eVYOi+XNwvJWGLk7vzy
 /6qV0zEwsEBo0HWth+SGs55uhXq6e9dj1sFdS5ml4WSr6M/AEooEQ8FkJ4nwgsD153I5
 aCIciCEJfoPfLjwa2Or8BYWUjqdaPq3ty3MntnNFX3jwn8itUVcvSKqH1iM59REeyOX6
 pFtzX4NkgW+Js+4cQNcZRQoKNWfdEyqj4/0sJJE2eQlk44YJzTZcpUBAMOQU5/11p04a
 J9lA==
X-Gm-Message-State: AC+VfDxTBmaiLoKj3WelkMqtpApbfmury3PnZ8liOWh+Om6/IKO5Q1+/
 7PxNl0lwUu4sPcy3tdNWzlCqBNslEvRY4kvZCi0/aw==
X-Google-Smtp-Source: ACHHUZ6eob858RzdDAQxAtVSHfjDtS3Mbpq/W9eEqXOT7N49XqUkJhs1d4VQUAcq0DmVJq75LmR6zQ==
X-Received: by 2002:a7b:cb94:0:b0:3f4:ec32:69fd with SMTP id
 m20-20020a7bcb94000000b003f4ec3269fdmr13921419wmi.40.1684336960676; 
 Wed, 17 May 2023 08:22:40 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 a3-20020a05600c224300b003f17848673fsm2549018wmm.27.2023.05.17.08.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 08:22:40 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A11AE1FFBB;
 Wed, 17 May 2023 16:22:39 +0100 (BST)
References: <20230517120751.14679-1-anisinha@redhat.com>
 <20230517101523-mutt-send-email-mst@kernel.org>
 <B6AD0FB1-CF05-4B4C-B58D-279422895E4D@redhat.com>
 <20230517103522-mutt-send-email-mst@kernel.org>
 <ED522229-5A71-40C2-AF2C-5D921B0B5D54@redhat.com>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] acpi/tests/bios-tables-test: add an environment
 variable for iasl location
Date: Wed, 17 May 2023 16:16:47 +0100
In-reply-to: <ED522229-5A71-40C2-AF2C-5D921B0B5D54@redhat.com>
Message-ID: <87zg63m18g.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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


Ani Sinha <anisinha@redhat.com> writes:

>> On 17-May-2023, at 8:06 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>>=20
>> On Wed, May 17, 2023 at 07:57:53PM +0530, Ani Sinha wrote:
>>>=20
>>>=20
>>>> On 17-May-2023, at 7:47 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>=20
>>>> On Wed, May 17, 2023 at 05:37:51PM +0530, Ani Sinha wrote:
>>>>> Currently the meson based QEMU build process locates the iasl binary =
from the
>>>>> current PATH and other locations [1] and uses that to set CONFIG_IASL=
 which is
>>>>> then used by the test.
>>>>>=20
>>>>> This has two disadvantages:
>>>>> - If iasl was not previously installed in the PATH, one has to instal=
l iasl
>>>>>  and rebuild QEMU in order to pick up the iasl location. One cannot s=
imply
>>>>>  use the existing bios-tables-test binary because CONFIG_IASL is only=
 set
>>>>>  during the QEMU build time by meson and then bios-tables-test has to=
 be
>>>>>  rebuilt with CONFIG_IASL set in order to use iasl.

Usually we work the other way by checking at configure time and skipping
the feature if the prerequisites are not in place. We do this with gdb:

  ../../configure --gdb=3D/home/alex/src/tools/binutils-gdb.git/builds/all/=
install/bin/gdb

which checks gdb is at least new enough to support the features we need:

  if test -n "$gdb_bin"; then
      gdb_version=3D$($gdb_bin --version | head -n 1)
      if version_ge ${gdb_version##* } 9.1; then
          echo "HAVE_GDB_BIN=3D$gdb_bin" >> $config_host_mak
          gdb_arches=3D$("$source_path/scripts/probe-gdb-support.py" $gdb_b=
in)
      else
          gdb_bin=3D""
      fi
  fi

>>>>> - Sometimes, the stock iasl that comes with distributions is simply n=
ot good
>>>>>  enough because it does not support the latest ACPI changes - newly
>>>>>  introduced tables or new table attributes etc. In order to test ACPI=
 code
>>>>>  in QEMU, one has to clone the latest acpica upstream repository and
>>>>>  rebuild iasl in order to get support for it. In those cases, one may=
 want
>>>>>  the test to use the iasl binary from a non-standard location.

I think configure should be checking if iasl is new enough and reporting
to the user at configure time they need to do something different. We
don't want to attempt to run tests that will fail unless the user has
added the right magic to their environment.

>>>>>=20
>>>>> In order to overcome the above two disadvantages, we introduce a new
>>>>> environment variable IASL_PATH that can be set by the tester pointing=
 to an
>>>>> possibly non-standard iasl binary location. Bios-tables-test then use=
s this
>>>>> environment variable to set its iasl location, possibly also overridi=
ng the
>>>>> location that was pointed to by CONFIG_IASL that was set by meson. Th=
is way
>>>>> developers can not only use this new environment variable to set iasl
>>>>> location to quickly run bios-tables-test but also can point the test =
to a
>>>>> custom iasl if required.
>>>>>=20
>>>>> [1] https://mesonbuild.com/Reference-manual_functions.html#find_progr=
am
>>>>>=20
>>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>>=20
>>>> Well I think the point was originally that meson can
>>>> also test the binary in a variety of ways.
>>>> Never surfaced so maybe never mind.
>>>>=20
>>>> Would it be easier to just look iasl up on path
>>>=20
>>> But that=E2=80=99s what meson is also doing, only QEMU build time.
>>=20
>>=20
>> So you were unhappy it's build time because it is not really
>> part of build and you want flexibility, right?
>
> Hmm, maybe in that case, we might want to resurrect iasl_installed(),
> basically reverting part of cc8fa0e80836c51ba644d910c.
>
> To me its ok if I had to set IASL_PATH=3D`which iasl` before running the
> test. I do not have strong opinions.

I don't think so - we should be using the tools configure found, after
all that is its job.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

