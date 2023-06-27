Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD14773F875
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 11:13:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE4kR-0002mA-MF; Tue, 27 Jun 2023 05:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qE4kP-0002cR-Lv
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:12:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qE4kN-0003G4-Nz
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687857145;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p0C+N0mYfr00PbbGKsS6NYlbaXOkctUTy8XgO0NcfDc=;
 b=gvA6RWPuIn2OuL8h6VLXen7V/xbjl+KJhHLfIdjqZ9bUSnskC/WM3+JVT0PGh+NDWShA/f
 sruiZQviy8maZWR8jWQx63+MEpHFjwFgJmcoYwOqma5TmPdkifYxmNQELtgwPMWF4Tr7Ci
 lrPDoPgUGHA40gvwyQfuGfl8PTlMi7k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-h10zmam9PN-d0DKe9bVVgA-1; Tue, 27 Jun 2023 05:12:23 -0400
X-MC-Unique: h10zmam9PN-d0DKe9bVVgA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fb8284465aso4587015e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 02:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687856841; x=1690448841;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p0C+N0mYfr00PbbGKsS6NYlbaXOkctUTy8XgO0NcfDc=;
 b=YMaTUk6bkaInDoSsPK5Nme2LdpJtrZjSHIWQjKsnKmoEOqjh5aT5GB+gJZ5H6LYTcL
 ywACchv1vesVgZaAPAY4HwhYrzXSAu5rvQ1gx4rioF9h5FYdQzhqAPBOIRFMN7RPUc6s
 Dzh3pdq+glRj1YkpUmUU5o2RcXmi0gAsHhAy9Aosri6IPKKCfQOLQOuju/pQU2zvaUN+
 V3Xcfcitog8RgXrafBkPfwwZ4p3WPWt7cV56/Mte+TMvpKS/m1F3JWNWhZk3jEd5c7pl
 l1Bcqj2WQ0n5tLdD9q7CO0CCCNp4Dh9B5pGIBzZUQYVx349jshcm4OSEIZI2I1QCrV2w
 2krw==
X-Gm-Message-State: AC+VfDym68PlDgtz/XQ0yZ5Dzx9cAjr8k35UAApLxBQSIOVfvBp+d+lh
 sSI91EEhEakzxBpHurwUfu6RInQ/MgHXrTIKPWZUTvQxJiTTway1hKzNiJYVXGjZDeqGkilFfsx
 12J5k4SoPVg615I0=
X-Received: by 2002:a05:600c:2041:b0:3f9:871:c2da with SMTP id
 p1-20020a05600c204100b003f90871c2damr22603534wmg.40.1687856841254; 
 Tue, 27 Jun 2023 02:07:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4t8InRg+h/QYSa9LyaKYle8segQXFljm370XqjWxrRzcjwqVN5BCcF7t8Opt4+qfP6FND0Ig==
X-Received: by 2002:a05:600c:2041:b0:3f9:871:c2da with SMTP id
 p1-20020a05600c204100b003f90871c2damr22603511wmg.40.1687856840821; 
 Tue, 27 Jun 2023 02:07:20 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 z26-20020a1c4c1a000000b003f91e32b1ebsm751671wmf.17.2023.06.27.02.07.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 02:07:20 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Thomas
 Huth <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Fam Zheng <fam@euphon.net>,  Leonardo Bras
 <leobras@redhat.com>,  Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>
Subject: Re: [PULL 00/30] Next patches
In-Reply-To: <1f5c4a38-6ae2-53dd-d739-65accb1d86a8@linaro.org> (Richard
 Henderson's message of "Fri, 23 Jun 2023 07:45:43 +0200")
References: <20230622165527.2417-1-quintela@redhat.com>
 <1f5c4a38-6ae2-53dd-d739-65accb1d86a8@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Tue, 27 Jun 2023 11:07:19 +0200
Message-ID: <87cz1hclyw.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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
> On 6/22/23 18:54, Juan Quintela wrote:
>> The following changes since commit b455ce4c2f300c8ba47cba7232dd03261368a=
4cb:
>>    Merge tag 'q800-for-8.1-pull-request'
>> ofhttps://github.com/vivier/qemu-m68k  into staging (2023-06-22
>> 10:18:32 +0200)
>> are available in the Git repository at:
>>    https://gitlab.com/juan.quintela/qemu.git  tags/next-pull-request
>> for you to fetch changes up to
>> 23e4307eadc1497bd0a11ca91041768f15963b68:
>>    migration/rdma: Split qemu_fopen_rdma() into input/output
>> functions (2023-06-22 18:11:58 +0200)
>> ----------------------------------------------------------------
>> Migration Pull request (20230621) take 2
>> In this pull request the only change is fixing 32 bits complitaion
>> issue.
>> Please apply.
>> [take 1]
>> - fix for multifd thread creation (fabiano)
>> - dirtylimity (hyman)
>>    * migration-test will go on next PULL request, as it has failures.
>> - Improve error description (tejus)
>> - improve -incoming and set parameters before calling incoming (wei)
>> - migration atomic counters reviewed patches (quintela)
>> - migration-test refacttoring reviewed (quintela)
>
> New failure with check-cfi-x86_64:
>
> https://gitlab.com/qemu-project/qemu/-/jobs/4527202764#L188
>
> /builds/qemu-project/qemu/build/pyvenv/bin/meson test  --no-rebuild -t
> 0  --num-processes 1 --print-errorlogs
>   1/350 qemu:qtest+qtest-x86_64 / qtest-x86_64/qom-test
>   OK 6.55s   8 subtests passed
> =E2=96=B6   2/350 ERROR:../tests/qtest/migration-test.c:320:check_guests_=
ram:
> assertion failed: (bad =3D=3D 0) ERROR
>   2/350 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test
>   ERROR 151.99s   killed by signal 6 SIGABRT
>>>>
>     G_TEST_DBUS_DAEMON=3D/builds/qemu-project/qemu/tests/dbus-vmstate-dae=
mon.sh
>     MALLOC_PERTURB_=3D3 QTEST_QEMU_IMG=3D./qemu-img
>     QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qemu-storage-daem=
on
>     QTEST_QEMU_BINARY=3D./qemu-system-x86_64
>     /builds/qemu-project/qemu/build/tests/qtest/migration-test --tap
>    -k
> =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95
> stderr:
> qemu-system-x86_64: Unable to read from socket: Connection reset by peer
> Memory content inconsistency at 4f65000 first_byte =3D 30 last_byte =3D 2f
> current =3D 88 hit_edge =3D 1
> **
> ERROR:../tests/qtest/migration-test.c:320:check_guests_ram: assertion fai=
led: (bad =3D=3D 0)
>
> (test program exited with status code -6)
> =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95

Still running in bisect mode (this takes forever).

[cc'ing stefan and kevin]

And now I get this problem with gcov:

https://gitlab.com/juan.quintela/qemu/-/jobs/4546094720

357/423 qemu:block / io-qcow2-copy-before-write                            =
ERROR           6.23s   exit status 1
>>> PYTHON=3D/builds/juan.quintela/qemu/build/pyvenv/bin/python3 MALLOC_PER=
TURB_=3D154 /builds/juan.quintela/qemu/build/pyvenv/bin/python3 /builds/jua=
n.quintela/qemu/build/../tests/qemu-iotests/check -tap -qcow2 copy-before-w=
rite --source-dir /builds/juan.quintela/qemu/tests/qemu-iotests --build-dir=
 /builds/juan.quintela/qemu/build/tests/qemu-iotests
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
--- /builds/juan.quintela/qemu/tests/qemu-iotests/tests/copy-before-write.o=
ut
+++ /builds/juan.quintela/qemu/build/scratch/qcow2-file-copy-before-write/c=
opy-before-write.out.bad
@@ -1,5 +1,21 @@
-....
+...F
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+FAIL: test_timeout_break_snapshot (__main__.TestCbwError)
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "/builds/juan.quintela/qemu/tests/qemu-iotests/tests/copy-before-wr=
ite", line 210, in test_timeout_break_snapshot
+    self.assertEqual(log, """\
+AssertionError: 'wrot[195 chars]read 1048576/1048576 bytes at offset 0\n1 =
MiB,[46 chars]c)\n' !=3D 'wrot[195 chars]read failed: Permission denied\n'
+  wrote 524288/524288 bytes at offset 0
+  512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+  wrote 524288/524288 bytes at offset 524288
+  512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
++ read failed: Permission denied
+- read 1048576/1048576 bytes at offset 0
+- 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+
 ----------------------------------------------------------------------
 Ran 4 tests
-OK
+FAILED (failures=3D1)
(test program exited with status code 1)
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95

I have no clue how I can make qtests to fail with my changes.

Specially with a read permission.

Any clue?

Later, Juan.

PD. Yeap, continuing the bisect.


