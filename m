Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34701706E34
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 18:32:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzK4m-0002hM-GH; Wed, 17 May 2023 12:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pzK4j-0002Ze-JR
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:32:29 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pzK4h-0005pA-PH
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:32:29 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3f4449fa085so6903285e9.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 09:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684341146; x=1686933146;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aSgV0j9ONlyJYGX3Yd5KoQbaVDstB22DGqb/T8FCvcE=;
 b=mL7e2uFoTivXK12wan1mDCuzqn49nyFJoDQhj1bBKpKVOBN2k5GRPG3k1Ulvj29Jnh
 961lyX+BY3dHwJr0S90sjoq+arkT2cpOEXRxv+s3KkKkZ1g5tV4aEXCHv4nYFsr9tE09
 q1ytnDhlSqONtSH31+SNkxJkQAqKaaLolOX2rnnjNXEQbAQGQ9vq120ZuSsR+RNUSCFm
 8CuKCl8K5YjC8cVPTGGDSc7K1NXc4gBBAnTi+jWgWAnx5nr6rg3djtmNwrIel4qzRFzf
 WCybODU2QMdYtHuCez7VtlehFJ6nHHcVsuILgtfKCIqncT0FRXwX5LcJKnvgbMlrfKOj
 2Cmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684341146; x=1686933146;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aSgV0j9ONlyJYGX3Yd5KoQbaVDstB22DGqb/T8FCvcE=;
 b=DtW3rkhwKZ6YRb0NrSyH8rGwlNzyBpx/2LbgNlmXsh5xFWRoOqQcO9QoqTxakSdoU7
 HgXwCiDb2cYWSD/kl7FyRbmKXM2/I5CpVLEt7Qdhoe/PTbeC3QXxGllSSuziiyUsTy9j
 SyZFW/Fb3lpCQ2t6VLyMo3jKi3mMRQ28b31doztXwA/Afz2wKgzyOx2lAMwuFYev/wSw
 +by6GYX9fBcvVQLzhHrJWf/HzIoqPe+r+FIMINR5jnHToHgKFDW4ApP+swVVMWwEzovi
 9cDfsvPr+EHxUbNSV6DmKofEtsoixIvGOm75WyXrnmaJ4qZHdfG4MPgSamGj+dtXBQG6
 uN6g==
X-Gm-Message-State: AC+VfDxRa/0bQ3KMQUhJP2RYeZqDmf1nrcv1I3w12cYlr8mQ9mIHElZl
 bNH4sKnKfqYh3XgduowSJlOhfUwY7k6tbKBQAzqc7g==
X-Google-Smtp-Source: ACHHUZ4TG5U9ayT8kJFiInAKy4ELCOfaCn55nGEcP4k+dBS74K8gT4Uey4Pqt6J6IksqiSKrHp/vnA==
X-Received: by 2002:a05:600c:2904:b0:3f4:2c21:b52c with SMTP id
 i4-20020a05600c290400b003f42c21b52cmr21078223wmd.39.1684341145908; 
 Wed, 17 May 2023 09:32:25 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 y14-20020a5d470e000000b002f6dafef040sm3315983wrq.12.2023.05.17.09.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 09:32:25 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 115461FFBB;
 Wed, 17 May 2023 17:32:25 +0100 (BST)
References: <20230517120751.14679-1-anisinha@redhat.com>
 <20230517101523-mutt-send-email-mst@kernel.org>
 <B6AD0FB1-CF05-4B4C-B58D-279422895E4D@redhat.com>
 <20230517103522-mutt-send-email-mst@kernel.org>
 <ED522229-5A71-40C2-AF2C-5D921B0B5D54@redhat.com>
 <87zg63m18g.fsf@linaro.org>
 <20230517112347-mutt-send-email-mst@kernel.org>
 <87r0rflzd4.fsf@linaro.org>
 <20230517120710-mutt-send-email-mst@kernel.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] acpi/tests/bios-tables-test: add an environment
 variable for iasl location
Date: Wed, 17 May 2023 17:20:51 +0100
In-reply-to: <20230517120710-mutt-send-email-mst@kernel.org>
Message-ID: <87ilcqnckm.fsf@linaro.org>
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


"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Wed, May 17, 2023 at 04:58:06PM +0100, Alex Benn=C3=A9e wrote:
>>=20
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>>=20
>> > On Wed, May 17, 2023 at 04:16:47PM +0100, Alex Benn=C3=A9e wrote:
>> >>=20
>> >> Ani Sinha <anisinha@redhat.com> writes:
>> >>=20
>> >> >> On 17-May-2023, at 8:06 PM, Michael S. Tsirkin <mst@redhat.com> wr=
ote:
>> >> >>=20
>> >> >> On Wed, May 17, 2023 at 07:57:53PM +0530, Ani Sinha wrote:
>> >> >>>=20
>> >> >>>=20
>> >> >>>> On 17-May-2023, at 7:47 PM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
>> >> >>>>=20
>> >> >>>> On Wed, May 17, 2023 at 05:37:51PM +0530, Ani Sinha wrote:
>> >> >>>>> Currently the meson based QEMU build process locates the iasl b=
inary from the
>> >> >>>>> current PATH and other locations [1] and uses that to set CONFI=
G_IASL which is
>> >> >>>>> then used by the test.
>> >> >>>>>=20
>> >> >>>>> This has two disadvantages:
>> >> >>>>> - If iasl was not previously installed in the PATH, one has to =
install iasl
>> >> >>>>>  and rebuild QEMU in order to pick up the iasl location. One ca=
nnot simply
>> >> >>>>>  use the existing bios-tables-test binary because CONFIG_IASL i=
s only set
>> >> >>>>>  during the QEMU build time by meson and then bios-tables-test =
has to be
>> >> >>>>>  rebuilt with CONFIG_IASL set in order to use iasl.
>> >>=20
>> >> Usually we work the other way by checking at configure time and skipp=
ing
>> >> the feature if the prerequisites are not in place. We do this with gd=
b:
>> >>=20
>> >>   ../../configure --gdb=3D/home/alex/src/tools/binutils-gdb.git/build=
s/all/install/bin/gdb
>> >>=20
>> >> which checks gdb is at least new enough to support the features we ne=
ed:
>> >>=20
>> >>   if test -n "$gdb_bin"; then
>> >>       gdb_version=3D$($gdb_bin --version | head -n 1)
>> >>       if version_ge ${gdb_version##* } 9.1; then
>> >>           echo "HAVE_GDB_BIN=3D$gdb_bin" >> $config_host_mak
>> >>           gdb_arches=3D$("$source_path/scripts/probe-gdb-support.py" =
$gdb_bin)
>> >>       else
>> >>           gdb_bin=3D""
>> >>       fi
>> >>   fi
>> >>=20
>> >> >>>>> - Sometimes, the stock iasl that comes with distributions is si=
mply not good
>> >> >>>>>  enough because it does not support the latest ACPI changes - n=
ewly
>> >> >>>>>  introduced tables or new table attributes etc. In order to tes=
t ACPI code
>> >> >>>>>  in QEMU, one has to clone the latest acpica upstream repositor=
y and
>> >> >>>>>  rebuild iasl in order to get support for it. In those cases, o=
ne may want
>> >> >>>>>  the test to use the iasl binary from a non-standard location.
>> >>=20
>> >> I think configure should be checking if iasl is new enough and report=
ing
>> >> to the user at configure time they need to do something different. We
>> >> don't want to attempt to run tests that will fail unless the user has
>> >> added the right magic to their environment.
>> >
>> > iasl is a disassembler we trigger for user convenience in case tests
>> > fail. It will never cause tests to fail.
>>=20
>> Fair enough. But I still think the place to report it is in configure.
>> Maybe something like:
>>=20
>>     iasl                         : /usr/bin/iasl (version 20200925, migh=
t not handle all ACPI)=20=20=20=20=20=20=20=20=20=20=20
>>=20
>> in the Host Binaries section. Re-configuring shouldn't cause too much of
>> the build to be regenerated although we could certainly do better in
>> this regard.
>
> won't all of it be regenerated? a header everyone includes changes.

Ahh I see meson is doing:

  if iasl.found()
    config_host_data.set_quoted('CONFIG_IASL', iasl.full_path())
  endif

which causes the inclusion in config-host.h - this seems excessive. It
would seem simpler to get meson to apply CONFIG_IASL to the invocation
of bios-tables-test rather than embedding it in the binary, e.g.:

  ./tests/bios-tables-test --iasl-path ${CONFIG_IASL}

and then you have the best of both worlds. You can run manually with a
different path and you don't need to pollute config-host.h

Paolo,

I see we expand all the qtests with:

    test('qtest-@0@/@1@'.format(target_base, test),
         qtest_executables[test],
         depends: [test_deps, qtest_emulator, emulator_modules],
         env: qtest_env,
         args: ['--tap', '-k'],
         protocol: 'tap',
         timeout: slow_qtests.get(test, 30),
         priority: slow_qtests.get(test, 30),
         suite: ['qtest', 'qtest-' + target_base])

is there any easy way to add arguments to individual tests or do we need
an explicit test expansion for bios-tables-test?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

