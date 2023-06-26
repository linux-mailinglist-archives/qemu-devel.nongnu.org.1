Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC71F73E02B
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:05:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDluB-0005yU-Vt; Mon, 26 Jun 2023 09:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qDluA-0005y5-1s
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:05:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qDlu7-0003WG-Vr
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687784715;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LYgvXwSo6PLsXiTDj5TKXdE/RXoujd+8Bg6x0ZyjD34=;
 b=iXg+2o0DsBSbQ+Q7VaMO8pZWviLgLnVab/mEWX32aUuSJcohE5NpIRx0fz/kffiNW0YcRb
 cYzooW1MTCknqp7MvEjptkR5AxNobsKBbTvXZzm9tEYtAcrEvJ04Op1U7kPMnhD85zn3uQ
 hiaRGxZXamDyah89qcHuq/UZz8cWxc4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-6OQ1hjC6Mw2NS6Mb1rlang-1; Mon, 26 Jun 2023 09:05:14 -0400
X-MC-Unique: 6OQ1hjC6Mw2NS6Mb1rlang-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fb40d90456so1562845e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 06:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687784713; x=1690376713;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LYgvXwSo6PLsXiTDj5TKXdE/RXoujd+8Bg6x0ZyjD34=;
 b=MVD9iQJHd0KOwTLPkD4v2nygDSBns07CLwwZqIIzRH53pb7jndFNGJ8VgHTP62IKl1
 iUySvei8zRok414RY4+13CeaCF8oGpc5bi6dZ0dHD8j+n/IZdlxAtkGchyYssLhuL1tO
 5yw0AaCjESofKTPQvXomlYwWORWUj025CUrchRdeln+E+HfHh9uMga2FJLHrG8QCMnGK
 N8r/cwnDjlZCvELQlP8j1F69kZhILxth5aCy99p5G5X45Usm8BFXT6+f3Uwxot9PwFM6
 eqDuKm3coeS0cPkkL8NqSETrwYURoIgPHjXMcBYymI5SDmI37krI7mpgXISzSaTuPDwv
 se6A==
X-Gm-Message-State: AC+VfDyfu68DoYqSWp6LAVWrsLM24WZNlraB6m2rdCJYUcLTRQCKx91/
 2FIjblJgXINGgl9ZuKlJtBqBR4Ja1xJlc7brhbG29enbBykBxwc978j9Etlmhh/vC7/DtwB+XUY
 PcZOKxux1Dx7pZSc=
X-Received: by 2002:a5d:6b92:0:b0:313:ef28:d3d6 with SMTP id
 n18-20020a5d6b92000000b00313ef28d3d6mr3274870wrx.6.1687784711700; 
 Mon, 26 Jun 2023 06:05:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4tfBfRDYagxov6VWBTK9bmyhtaGHqKxHzShqs6bzOPbA3Ewt2U5gHd/f1VauFZ6rRqyOXa/Q==
X-Received: by 2002:a5d:6b92:0:b0:313:ef28:d3d6 with SMTP id
 n18-20020a5d6b92000000b00313ef28d3d6mr3274839wrx.6.1687784711325; 
 Mon, 26 Jun 2023 06:05:11 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 w10-20020a1cf60a000000b003f9bd9e3226sm7668163wmc.7.2023.06.26.06.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 06:05:10 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Thomas
 Huth <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Fam Zheng <fam@euphon.net>,  Leonardo Bras
 <leobras@redhat.com>,  Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org
Subject: Re: [PULL 00/30] Next patches
In-Reply-To: <a614493f-1e3e-1d6b-13df-702be2b1bd8e@linaro.org> (Richard
 Henderson's message of "Mon, 26 Jun 2023 08:37:10 +0200")
References: <20230622165527.2417-1-quintela@redhat.com>
 <1f5c4a38-6ae2-53dd-d739-65accb1d86a8@linaro.org>
 <87leg719rs.fsf@secure.mitica>
 <a614493f-1e3e-1d6b-13df-702be2b1bd8e@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Mon, 26 Jun 2023 15:05:09 +0200
Message-ID: <874jmue5mi.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Richard Henderson <richard.henderson@linaro.org> wrote:
> On 6/26/23 00:01, Juan Quintela wrote:
>> Richard Henderson <richard.henderson@linaro.org> wrote:
>>> On 6/22/23 18:54, Juan Quintela wrote:
>>>> The following changes since commit b455ce4c2f300c8ba47cba7232dd0326136=
8a4cb:
>>>>     Merge tag 'q800-for-8.1-pull-request'
>>>> ofhttps://github.com/vivier/qemu-m68k  into staging (2023-06-22
>>>> 10:18:32 +0200)
>>>> are available in the Git repository at:
>>>>     https://gitlab.com/juan.quintela/qemu.git  tags/next-pull-request
>>>> for you to fetch changes up to
>>>> 23e4307eadc1497bd0a11ca91041768f15963b68:
>>>>     migration/rdma: Split qemu_fopen_rdma() into input/output
>>>> functions (2023-06-22 18:11:58 +0200)
>>>> ----------------------------------------------------------------
>>>> Migration Pull request (20230621) take 2
>>>> In this pull request the only change is fixing 32 bits complitaion
>>>> issue.
>>>> Please apply.
>>>> [take 1]
>>>> - fix for multifd thread creation (fabiano)
>>>> - dirtylimity (hyman)
>>>>     * migration-test will go on next PULL request, as it has failures.
>>>> - Improve error description (tejus)
>>>> - improve -incoming and set parameters before calling incoming (wei)
>>>> - migration atomic counters reviewed patches (quintela)
>>>> - migration-test refacttoring reviewed (quintela)
>>>
>>> New failure with check-cfi-x86_64:
>>>
>>> https://gitlab.com/qemu-project/qemu/-/jobs/4527202764#L188
>> First of all, is there a way to get to the test log?  In particular,
>> I
>> am interested in knowing at least what test has failed (yes,
>> migration-test don't tell you much more).
>> After a bit more wrestling, I have been able to get things compiling
>> with this command:
>> $ /mnt/code/qemu/full/configure --enable-cfi
>> --target-list=3Dx86_64-softmmu --enable-cfi-debug --cc=3Dclang --cxx=3Dc=
lang++
>> --disable-docs --enable-safe-stack --disable-slirp
>> It should basically be the one that check-cfi-x86_64 is using if I
>> understand the build recipes correctly (that is a BIG IF).
>> And it passes for me with flying colors.
>> Here I have Fedora38, builder has F37.
>>=20
>>> /builds/qemu-project/qemu/build/pyvenv/bin/meson test  --no-rebuild -t
>>> 0  --num-processes 1 --print-errorlogs
>>>    1/350 qemu:qtest+qtest-x86_64 / qtest-x86_64/qom-test
>>>    OK 6.55s   8 subtests passed
>>> =E2=96=B6   2/350 ERROR:../tests/qtest/migration-test.c:320:check_guest=
s_ram:
>>> assertion failed: (bad =3D=3D 0) ERROR
>>>    2/350 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test
>>>    ERROR 151.99s   killed by signal 6 SIGABRT
>>>>>>
>>>      G_TEST_DBUS_DAEMON=3D/builds/qemu-project/qemu/tests/dbus-vmstate-=
daemon.sh
>>>      MALLOC_PERTURB_=3D3 QTEST_QEMU_IMG=3D./qemu-img
>>>      QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qemu-storage-d=
aemon
>>>      QTEST_QEMU_BINARY=3D./qemu-system-x86_64
>>>      /builds/qemu-project/qemu/build/tests/qtest/migration-test --tap
>>>     -k
>>> =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95
>>> stderr:
>>> qemu-system-x86_64: Unable to read from socket: Connection reset by peer
>> This is the interesting bit, why is the conection closed.
>>=20
>>> Memory content inconsistency at 4f65000 first_byte =3D 30 last_byte =3D=
 2f
>>> current =3D 88 hit_edge =3D 1
>>> **
>>> ERROR:../tests/qtest/migration-test.c:320:check_guests_ram: assertion f=
ailed: (bad =3D=3D 0)
>>>
>>> (test program exited with status code -6)
>> This makes zero sense, except if we haven't migrated all the guest
>> state, that it is what it has happened.
>> Is there a place on the web interface to see the full logs?  Or that
>> is
>> the only thing that the CI system stores?
>
> The "full logs" are
>
> https://gitlab.com/qemu-project/qemu/-/jobs/4527202764/artifacts/download=
?file_type=3Dtrace

Not useful.  I was hoping that there is something like when one runs
./tests/qtest/migration-test

Anyways, to make things faster:

- created
  /mnt/code/qemu/full/configure --enable-cfi
    --target-list=3Dx86_64-softmmu --enable-cfi-debug --cc=3Dclang --cxx=3D=
clang++
    --disable-docs --enable-safe-stack --disable-slirp

  worked as a charm.

- Your test run:

   qemu-system-x86_64: Unable to read from socket: Connection reset by peer
   one of the sides die, so anything else after that don't matter.

  And I don't understand what CFI is (and I don't rule out that
  posibility) or I can't understand how checking indirect functions call
  can make migration-test die without a single CFI error message?

- I tried myself CI pipeline, some exact source:

  https://gitlab.com/juan.quintela/qemu/-/commit/23e4307eadc1497bd0a11ca910=
41768f15963b68/pipelines?ref=3Dsent%2Fmigration-20230621b

This is what fails:

https://gitlab.com/juan.quintela/qemu/-/jobs/4527782025
16/395 ERROR:../tests/qtest/qos-test.c:191:subprocess_run_one_test: child p=
rocess (/x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-net-pci/virtio-=
net/virtio-net-tests/vhost-user/reconnect/subprocess [4569]) failed unexpec=
tedly ERROR=20=20=20=20=20=20=20=20=20
 16/395 qemu:qtest+qtest-x86_64 / qtest-x86_64/qos-test                    =
ERROR          27.46s   killed by signal 6 SIGABRT
>>> MALLOC_PERTURB_=3D92 QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemo=
n/qemu-storage-daemon QTEST_QEMU_BINARY=3D./qemu-system-x86_64 QTEST_QEMU_I=
MG=3D./qemu-img G_TEST_DBUS_DAEMON=3D/builds/juan.quintela/qemu/tests/dbus-=
vmstate-daemon.sh /builds/juan.quintela/qemu/build/tests/qtest/qos-test --t=
ap -k
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95
stderr:
Vhost user backend fails to broadcast fake RARP
qemu-system-x86_64: -chardev socket,id=3Dchr-reconnect,path=3D/tmp/vhost-te=
st-8XUX61/reconnect.sock,server=3Don: info: QEMU waiting for connection on:=
 disconnected:unix:/tmp/vhost-test-8XUX61/reconnect.sock,server=3Don
qemu-system-x86_64: Failed to set msg fds.
qemu-system-x86_64: vhost VQ 0 ring restore failed: -22: Invalid argument (=
22)
qemu-system-x86_64: Failed to set msg fds.
qemu-system-x86_64: vhost VQ 1 ring restore failed: -22: Invalid argument (=
22)
**
ERROR:../tests/qtest/vhost-user-test.c:890:wait_for_rings_started: assertio=
n failed (ctpop64(s->rings) =3D=3D count): (1 =3D=3D 2)
**
ERROR:../tests/qtest/qos-test.c:191:subprocess_run_one_test: child
process
(/x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-net-pci/virtio-net/vir=
tio-net-tests/vhost-user/reconnect/subprocess
[4569]) failed unexpectedly

vhost?  virtio-queue?  in a non migration test?

I don't know what is going on, but this is weird.

Do we have a way to run on that image:

./tests/qtest/migration-test

in a loop until it fails, and at least see what test is failing?

Later, Juan.


