Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC652706D99
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 18:04:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzJcM-00058K-Po; Wed, 17 May 2023 12:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pzJcK-000566-UR
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:03:09 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pzJcJ-00009J-3t
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:03:08 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3f435658d23so9653085e9.3
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 09:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684339385; x=1686931385;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yrRioCD9fyyJJ4GNX0zvnYztbvt1l3d1Nm3lt147994=;
 b=G4nmtoVkO1dS47wZABBGqHSUOuJilRzmuLdOe2zWE7b30+vXGvshqkN6sCh0AXNUrF
 Jj5ENBcQt365ARuVBTgIKTlC+4pc5Gfr50aa3obKLqySdYneQI6qhqfEFdzN1/5ytSer
 +qtR+ftUEd/lNQp3UKaDMrlz+neMCyXwuNqC/rzOoOqfVNvxc1tGYDStCbs8kp0+0qxR
 CMHbDmOByLS4NAWrcoMPqHIaOF1toPMkhkNoHW0oPEK5jv0QcfHofbVNIlbP9OXqoZkH
 ih5dQ5jXeXRsvTPClA4Ygs9GLO7jV09XFekwatrcVNtiOKyfNhjs8AWtTTMPghyVamOd
 FIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684339385; x=1686931385;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yrRioCD9fyyJJ4GNX0zvnYztbvt1l3d1Nm3lt147994=;
 b=cv9KowDm/R1xSwCU1DWOHBKQrwh5Y8xvE+cK+jn3PM6FcDSXavP/oMmOMtON+g09W1
 NAYISLpMYsSu0pIMbBN3kKIYZfAq8Oc/mTxaColZbLfsvTpQ3FABxDE3L+TlU/lwt/1S
 O8s6B/dPoeMkYy+4S9VM0iH7yvw0HcseE2ht2ekZen4nlV/mBH65ycJH8pr9wu3Vmb1P
 mFnGipcKOKiqKgLv4NJWnmacC7CUQ8S+JXPLeaMr081bL9+Zoj9ghrQtYPnZdGitADr4
 HZLRgtC0YcTtZTfM+pKy43ttP53YpxZQvh3L2LJmx0tx4xjeMd+jtwS4EKjC3oKXSHkq
 3cMA==
X-Gm-Message-State: AC+VfDzVYqpZdqSvMIcz3dvZGQkvqq2WNuJbphg/PDmrTyf+egMwf2fK
 nnAryBIMVnsSpMON50S2kbh+ur5+b5tl/k/I07xB7g==
X-Google-Smtp-Source: ACHHUZ77uWo3eOT5fb9caaCZkoeuGNV2Oniugua3WlyTRsmMKRAFdGgkZr00exsFGB6jeuA2mCQq0g==
X-Received: by 2002:a7b:c4c3:0:b0:3f3:1cb7:b2a6 with SMTP id
 g3-20020a7bc4c3000000b003f31cb7b2a6mr29098216wmk.6.1684339384867; 
 Wed, 17 May 2023 09:03:04 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 u2-20020a05600c00c200b003f4fbd9cdb3sm2619574wmm.34.2023.05.17.09.03.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 09:03:04 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 08C321FFBB;
 Wed, 17 May 2023 17:03:04 +0100 (BST)
References: <20230517120751.14679-1-anisinha@redhat.com>
 <20230517101523-mutt-send-email-mst@kernel.org>
 <B6AD0FB1-CF05-4B4C-B58D-279422895E4D@redhat.com>
 <20230517103522-mutt-send-email-mst@kernel.org>
 <ED522229-5A71-40C2-AF2C-5D921B0B5D54@redhat.com>
 <87zg63m18g.fsf@linaro.org>
 <20230517112347-mutt-send-email-mst@kernel.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] acpi/tests/bios-tables-test: add an environment
 variable for iasl location
Date: Wed, 17 May 2023 16:58:06 +0100
In-reply-to: <20230517112347-mutt-send-email-mst@kernel.org>
Message-ID: <87r0rflzd4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

> On Wed, May 17, 2023 at 04:16:47PM +0100, Alex Benn=C3=A9e wrote:
>>=20
>> Ani Sinha <anisinha@redhat.com> writes:
>>=20
>> >> On 17-May-2023, at 8:06 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> >>=20
>> >> On Wed, May 17, 2023 at 07:57:53PM +0530, Ani Sinha wrote:
>> >>>=20
>> >>>=20
>> >>>> On 17-May-2023, at 7:47 PM, Michael S. Tsirkin <mst@redhat.com> wro=
te:
>> >>>>=20
>> >>>> On Wed, May 17, 2023 at 05:37:51PM +0530, Ani Sinha wrote:
>> >>>>> Currently the meson based QEMU build process locates the iasl bina=
ry from the
>> >>>>> current PATH and other locations [1] and uses that to set CONFIG_I=
ASL which is
>> >>>>> then used by the test.
>> >>>>>=20
>> >>>>> This has two disadvantages:
>> >>>>> - If iasl was not previously installed in the PATH, one has to ins=
tall iasl
>> >>>>>  and rebuild QEMU in order to pick up the iasl location. One canno=
t simply
>> >>>>>  use the existing bios-tables-test binary because CONFIG_IASL is o=
nly set
>> >>>>>  during the QEMU build time by meson and then bios-tables-test has=
 to be
>> >>>>>  rebuilt with CONFIG_IASL set in order to use iasl.
>>=20
>> Usually we work the other way by checking at configure time and skipping
>> the feature if the prerequisites are not in place. We do this with gdb:
>>=20
>>   ../../configure --gdb=3D/home/alex/src/tools/binutils-gdb.git/builds/a=
ll/install/bin/gdb
>>=20
>> which checks gdb is at least new enough to support the features we need:
>>=20
>>   if test -n "$gdb_bin"; then
>>       gdb_version=3D$($gdb_bin --version | head -n 1)
>>       if version_ge ${gdb_version##* } 9.1; then
>>           echo "HAVE_GDB_BIN=3D$gdb_bin" >> $config_host_mak
>>           gdb_arches=3D$("$source_path/scripts/probe-gdb-support.py" $gd=
b_bin)
>>       else
>>           gdb_bin=3D""
>>       fi
>>   fi
>>=20
>> >>>>> - Sometimes, the stock iasl that comes with distributions is simpl=
y not good
>> >>>>>  enough because it does not support the latest ACPI changes - newly
>> >>>>>  introduced tables or new table attributes etc. In order to test A=
CPI code
>> >>>>>  in QEMU, one has to clone the latest acpica upstream repository a=
nd
>> >>>>>  rebuild iasl in order to get support for it. In those cases, one =
may want
>> >>>>>  the test to use the iasl binary from a non-standard location.
>>=20
>> I think configure should be checking if iasl is new enough and reporting
>> to the user at configure time they need to do something different. We
>> don't want to attempt to run tests that will fail unless the user has
>> added the right magic to their environment.
>
> iasl is a disassembler we trigger for user convenience in case tests
> fail. It will never cause tests to fail.

Fair enough. But I still think the place to report it is in configure.
Maybe something like:

    iasl                         : /usr/bin/iasl (version 20200925, might n=
ot handle all ACPI)=20=20=20=20=20=20=20=20=20=20=20

in the Host Binaries section. Re-configuring shouldn't cause too much of
the build to be regenerated although we could certainly do better in
this regard.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

