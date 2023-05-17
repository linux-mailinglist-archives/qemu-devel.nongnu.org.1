Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE23706D2E
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 17:49:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzJOj-0006u8-CW; Wed, 17 May 2023 11:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1pzJOI-0006Gm-GC
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:48:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1pzJOA-0004sh-HE
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684338509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ujy/7DA7zaNEYr1XrXM7cleJEibHuDmxiOzmkOP5/vY=;
 b=ZQG6SscL6fwbGYrRYBqI3bPwfp/FtAmvSS2vF/DJoLa3n9kJV2KekrxlOB0nxNk8w03ziO
 M4mCxrzU9hbt4iGQ284eeggcXnvyyGzgwqgGLvYahv5zIJ9J1UdIWdwr6l/wNGdbVsYHZz
 6AgPFRJRnwnYNHg/I/+k+eBcASxM0C0=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-MzylmPLJM_Wo6nDIMjaCdQ-1; Wed, 17 May 2023 11:48:28 -0400
X-MC-Unique: MzylmPLJM_Wo6nDIMjaCdQ-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1aaefadf45bso865225ad.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 08:48:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684338507; x=1686930507;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ujy/7DA7zaNEYr1XrXM7cleJEibHuDmxiOzmkOP5/vY=;
 b=IuRsskcSkrVcsJrTjfRpcB5WintD0mFHkGH60nc43WYSO2ZdX0VSEyD5AgmTeF3xR2
 6JCVqRG8Q8zQdTEbMTyKGU5IxdgcbRpukKr46CYP7vrT067qC0p8XlCigsPFoEpkdOlL
 E8evkbPdiRypa2rP8ndwR7rDHyJDfIQqYDybWKg7IfzOIblBnkxLxgRlBuTUHrVo1osN
 l71oQHm+pEiBX07w4HE66qqJbHeXZprbWTR2or4/RwY5+CyBY5SpGWZfKB3xWCQrpqmS
 NYV+ZRWj3gwJP8F4nhnJDpUdkUsCA//n/eBm2sgveT6HxlkbY6EN7Uo3sn7V10oDquXD
 8jDA==
X-Gm-Message-State: AC+VfDyMc9c0/5sv2DEWelIgHT/sMQbLVsyq1rvO0eaB8KdCWpnXH6Xh
 llKI3NPF0GM6O1aPxO7dEi57TMZGMoRY0I5Akci38PUmkUMdRZ59fddErDFDnCds/o9s27gZILJ
 g8+d4TItiylebmaclzfv837Y=
X-Received: by 2002:a17:903:1252:b0:1ae:10a5:8349 with SMTP id
 u18-20020a170903125200b001ae10a58349mr3309948plh.23.1684338506745; 
 Wed, 17 May 2023 08:48:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4NFG4F+X8DUcTOM+RCGGFWcDr7TaXxZI84R/hW5ia6Uhz8UNrPyJ06A7MjsfaNUVAuAaYMug==
X-Received: by 2002:a17:903:1252:b0:1ae:10a5:8349 with SMTP id
 u18-20020a170903125200b001ae10a58349mr3309920plh.23.1684338506429; 
 Wed, 17 May 2023 08:48:26 -0700 (PDT)
Received: from smtpclient.apple ([115.96.105.155])
 by smtp.gmail.com with ESMTPSA id
 c2-20020a170902b68200b001ae0152d280sm8849188pls.193.2023.05.17.08.48.23
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 May 2023 08:48:25 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH] acpi/tests/bios-tables-test: add an environment variable
 for iasl location
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <87zg63m18g.fsf@linaro.org>
Date: Wed, 17 May 2023 21:18:21 +0530
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A348B8F4-4F2E-4088-839E-270EB81066F2@redhat.com>
References: <20230517120751.14679-1-anisinha@redhat.com>
 <20230517101523-mutt-send-email-mst@kernel.org>
 <B6AD0FB1-CF05-4B4C-B58D-279422895E4D@redhat.com>
 <20230517103522-mutt-send-email-mst@kernel.org>
 <ED522229-5A71-40C2-AF2C-5D921B0B5D54@redhat.com> <87zg63m18g.fsf@linaro.org>
To: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



> On 17-May-2023, at 8:46 PM, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>=20
>=20
> Ani Sinha <anisinha@redhat.com> writes:
>=20
>>> On 17-May-2023, at 8:06 PM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
>>>=20
>>> On Wed, May 17, 2023 at 07:57:53PM +0530, Ani Sinha wrote:
>>>>=20
>>>>=20
>>>>> On 17-May-2023, at 7:47 PM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
>>>>>=20
>>>>> On Wed, May 17, 2023 at 05:37:51PM +0530, Ani Sinha wrote:
>>>>>> Currently the meson based QEMU build process locates the iasl =
binary from the
>>>>>> current PATH and other locations [1] and uses that to set =
CONFIG_IASL which is
>>>>>> then used by the test.
>>>>>>=20
>>>>>> This has two disadvantages:
>>>>>> - If iasl was not previously installed in the PATH, one has to =
install iasl
>>>>>> and rebuild QEMU in order to pick up the iasl location. One =
cannot simply
>>>>>> use the existing bios-tables-test binary because CONFIG_IASL is =
only set
>>>>>> during the QEMU build time by meson and then bios-tables-test has =
to be
>>>>>> rebuilt with CONFIG_IASL set in order to use iasl.
>=20
> Usually we work the other way by checking at configure time and =
skipping
> the feature if the prerequisites are not in place.

I think this is too hard a requirement for something that is only used =
for debugging aid. If iasl is absent, no big deal. We won=E2=80=99t get =
nice asl diffs but the test will fail and let the users know which blobs =
are in disagreement. For ACPI contributors and maintainers, in the =
previous incarnation, one could quickly install iasl and rerun the same =
bios-tables-test and get the asl diffs. Now we need an additional step =
of recompiling QEMU which is completely useless, confusing and =
burdensome.=20

> We do this with gdb:
>=20
>  ../../configure =
--gdb=3D/home/alex/src/tools/binutils-gdb.git/builds/all/install/bin/gdb
>=20
> which checks gdb is at least new enough to support the features we =
need:
>=20
>  if test -n "$gdb_bin"; then
>      gdb_version=3D$($gdb_bin --version | head -n 1)
>      if version_ge ${gdb_version##* } 9.1; then
>          echo "HAVE_GDB_BIN=3D$gdb_bin" >> $config_host_mak
>          gdb_arches=3D$("$source_path/scripts/probe-gdb-support.py" =
$gdb_bin)
>      else
>          gdb_bin=3D""
>      fi
>  fi
>=20
>>>>>> - Sometimes, the stock iasl that comes with distributions is =
simply not good
>>>>>> enough because it does not support the latest ACPI changes - =
newly
>>>>>> introduced tables or new table attributes etc. In order to test =
ACPI code
>>>>>> in QEMU, one has to clone the latest acpica upstream repository =
and
>>>>>> rebuild iasl in order to get support for it. In those cases, one =
may want
>>>>>> the test to use the iasl binary from a non-standard location.
>=20
> I think configure should be checking if iasl is new enough and =
reporting
> to the user at configure time they need to do something different. We
> don't want to attempt to run tests that will fail unless the user has
> added the right magic to their environment.

Iasl is not used directly for the test. It is used to provide =
disassembly of the acpi blobs when the test fails.
What version is new enough? There has been occasions when someone added =
tables that are new enough that only the upstream acpica git tree has =
support for it and no officially released version does. When we want to =
check their implementation in QEMU, we want to use that latest upstream =
iasl directly compiled from the git tree.

I think the current mechanism makes lives of ACPI contributors and =
maintainers harder, not easier.
 =20
>=20
>>>>>>=20
>>>>>> In order to overcome the above two disadvantages, we introduce a =
new
>>>>>> environment variable IASL_PATH that can be set by the tester =
pointing to an
>>>>>> possibly non-standard iasl binary location. Bios-tables-test then =
uses this
>>>>>> environment variable to set its iasl location, possibly also =
overriding the
>>>>>> location that was pointed to by CONFIG_IASL that was set by =
meson. This way
>>>>>> developers can not only use this new environment variable to set =
iasl
>>>>>> location to quickly run bios-tables-test but also can point the =
test to a
>>>>>> custom iasl if required.
>>>>>>=20
>>>>>> [1] =
https://mesonbuild.com/Reference-manual_functions.html#find_program
>>>>>>=20
>>>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>>>=20
>>>>> Well I think the point was originally that meson can
>>>>> also test the binary in a variety of ways.
>>>>> Never surfaced so maybe never mind.
>>>>>=20
>>>>> Would it be easier to just look iasl up on path
>>>>=20
>>>> But that=E2=80=99s what meson is also doing, only QEMU build time.
>>>=20
>>>=20
>>> So you were unhappy it's build time because it is not really
>>> part of build and you want flexibility, right?
>>=20
>> Hmm, maybe in that case, we might want to resurrect iasl_installed(),
>> basically reverting part of cc8fa0e80836c51ba644d910c.
>>=20
>> To me its ok if I had to set IASL_PATH=3D`which iasl` before running =
the
>> test. I do not have strong opinions.
>=20
> I don't think so - we should be using the tools configure found, after
> all that is its job.
>=20
> --=20
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro


