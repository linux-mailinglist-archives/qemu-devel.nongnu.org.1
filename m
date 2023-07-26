Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF647635DD
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 14:08:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOdII-0004Dz-Ga; Wed, 26 Jul 2023 08:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qOdIB-0004Dd-VV
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 08:07:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qOdIA-0007eF-2Q
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 08:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690373215;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type: content-transfer-encoding:content-transfer-encoding;
 bh=y1T0bQC96dOc8wEjpEjg9UcwmHjNRqKXd1SHw/pnLjs=;
 b=XxfALhhdJnyXTjHcloKaIEsKnj/Gf4zekkIU/Q4H/OIDXXPjqrTDCcs8FcZzgUUkdX9yK3
 nfQOfV8/BqODsG2/idith+wXkgVc4NciGPsSqLLsrDaxPct6eauCqDUIXHCvTsuqXYDw7b
 /ZbA+wvNe6jnCVm8LuRG65DjZrEQ8Ls=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-vODsH7LoO_mu0jzZngNWSg-1; Wed, 26 Jul 2023 08:06:53 -0400
X-MC-Unique: vODsH7LoO_mu0jzZngNWSg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31400956ce8so3228128f8f.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 05:06:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690373212; x=1690978012;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:subject:to:from:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=y1T0bQC96dOc8wEjpEjg9UcwmHjNRqKXd1SHw/pnLjs=;
 b=HXW90QISMaEkOd01siJtxkfktw9qHHGHL9Hi461yWZ47F0dP2esq8Vww9bzqPdW4mV
 v2Lopjyi+qVkJBemWfFtKAm803q+ko8PL84o4PdLQ4rulHj72eIEiUrcFQlTMj80C4hX
 5tQb36MRh3DF/R+qIBN4w5ewyHxAL+tIneyem1IXmshLfzBSiH//zFha5YnSrSUh6KjZ
 j1rQduwlFgLaNMHy7YAZ0BN914+oj1Lq/QEov+7J3jCase5g4HvNiHTB3gLsVnYS6UYY
 4S3EA3h/8dB2KwUMpFTlS5yG4fwopluFDvyv0ZA8H6JZjOS42nvZ2/gWXAhIv60ETNtl
 lJlQ==
X-Gm-Message-State: ABy/qLbCpK3O4WZsKpmXWC7cjUZGGlS8ROBw3nfxUt+272t4ZqwneD5W
 KOxJod0yjYEo5SjaiJJ/JbSlbKYqtAOp5L/bH8us/B7FakIs9XIpJWA5j61MeKbv7lkafCVNbvZ
 5xV8zcQqpyYoxmshdg/fLh6Af8XxySLYW5zuydJ3MVltx/s7paBfeIqXvgvMOl/1o9opWTqIwN2
 ClYA==
X-Received: by 2002:adf:ce90:0:b0:313:f8c0:d5c9 with SMTP id
 r16-20020adfce90000000b00313f8c0d5c9mr1184908wrn.63.1690373212006; 
 Wed, 26 Jul 2023 05:06:52 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHVhqn3KceDB7YMK4miC5scG35PnwH2BcTZCKH6Jhs8q7KNJNN0bdJ+FPTSKTJNBjH98eqOag==
X-Received: by 2002:adf:ce90:0:b0:313:f8c0:d5c9 with SMTP id
 r16-20020adfce90000000b00313f8c0d5c9mr1184889wrn.63.1690373211530; 
 Wed, 26 Jul 2023 05:06:51 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 k8-20020a5d4288000000b003176a4394d7sm5840893wrq.24.2023.07.26.05.06.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 05:06:50 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, Daniel Berrange
 <berrange@redhat.com>, richard.henderson@linaro.org
Subject: How to tame CI?
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Wed, 26 Jul 2023 14:06:49 +0200
Message-ID: <87fs5aho6e.fsf@secure.mitica>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org


Hi

Now a not on CI, thas has been really bad.  After too many problems
with last PULLS, I decided to learn to use qemu CI.  On one hand, it
is not so difficult, even I can use it O:-)

On the other hand, the amount of problems that I got is inmense.  Some
of them dissapear when I rerun the checks, but I never know if it is
my PULL request, the CI system or the tests themselves.

So it ends going something like:

while (true); do
- git pull
- git rebase
- git push ci blah, blah
- Next day comes, and too many errors, so I rebase again

The last step takes more time than expected and not always trivial to
know how the failure is.

This (last) patch is not part of the PULL request, but I have found
that it _always_ makes gcov fail.  I had to use bisect to find where
the problem was.

https://gitlab.com/juan.quintela/qemu/-/jobs/4571878922

To make things easier, this is the part that show how it breaks (this is
the gcov test):

357/423 qemu:block / io-qcow2-copy-before-write                            =
ERROR           6.38s   exit status 1
>>> PYTHON=3D/builds/juan.quintela/qemu/build/pyvenv/bin/python3 MALLOC_PER=
TURB_=3D44 /builds/juan.quintela/qemu/build/pyvenv/bin/python3 /builds/juan=
.quintela/qemu/build/../tests/qemu-iotests/check -tap -qcow2 copy-before-wr=
ite --source-dir /builds/juan.quintela/qemu/tests/qemu-iotests --build-dir =
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

I could use help to know how a change in test/qtest/migration-test.c
can break block layer tests, I am all ears.

This is the commit:

https://gitlab.com/juan.quintela/qemu/-/commit/7455ee794c01662b5efa1ee67396=
d85943663ded

Yes, I tried several times.  It always fails on that patch.  The
previous commint passes CI with flying colors.

Later, Juan.


