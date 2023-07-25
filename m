Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F8D761F42
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 18:46:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOLAE-0006KO-Kz; Tue, 25 Jul 2023 12:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qOLA8-0006JU-R7
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 12:45:29 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qOLA5-0008E9-0c
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 12:45:27 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4f9fdb0ef35so9139980e87.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 09:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690303520; x=1690908320;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NM8mF9oVskAAzkCe0J9PRS7cdK4jSxpGU9j5XHKnEYM=;
 b=VZCYnBi3/EfFNS2QnJaZpjbBNWW49RpPgE4W/Ee1LGIYArrLBvwujNRP7cDs0IyjM6
 SJopYyvLiFGraPEJ2lXqKmVrTOzIY4/zDbLazgFe+qKnsnjzvytlK2ilJsn+0dt6ennh
 aBjDQnbfZD3YlKPjMiXOTP4l1cX/iR10c7E1nyw+UioHw0Mw9wnSoQXfopJrI9W0BljF
 TMJBALB0WUOrF4wJnc2LXIDxgseclmYI3PapZ10k22CBYmiMkT6aXkY/p3nvYAMX1DSE
 v2v6yCzIplwDn2No2TBXi29hyoFWAK/KxSgUL8pGKq1TjLGaF1R1MV2waAbQWF4yLTY7
 wfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690303520; x=1690908320;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NM8mF9oVskAAzkCe0J9PRS7cdK4jSxpGU9j5XHKnEYM=;
 b=NNBpYULB4F2jglUSFnBGeuCDRpCgojOy8wKMlR1bs9o0ls5d0w9GnBzmuffS37PJxd
 R81wqEriF1SmXiTuuE/ttfXvaFVdzmE4jvvsCR4hkpdGdAdk1RBQJefgFCJjL42dHLEo
 q2COpzg0yAEUfsTpdJ51qi0KG2YlFZ+d38NDCEBuZBBSl2iglRfJfMzXrcrb2PV30x6d
 SlQDUqKYZzm34naZu9uOmoaqZltkRxggEIAjtz4uS1pESVrzxXQM/dZ69u1dRKFo8K4k
 QCcsX3CyOpaOWSeGTDszQlilKIisrhp5vn/Z7jK2A0wl0SCAZ59iGsER34ykmH8nO3fE
 6J6g==
X-Gm-Message-State: ABy/qLZwj7MAJefKthefHuLgTSG3USEAKVwQ2Fxo1TbOgh1TQ8ko+dRA
 EYkBO+1LWdTrs2E0bU+gWdXbRJYzhOX51gQPWrdmmD/5Y1v2qhKN
X-Google-Smtp-Source: APBJJlHidNIVLiuEBH8xMSX5/mPlwdZzZGc92D0blZPL+WEZqQgzYFOOOXohQBUn+qEL2uWpA4HKCHDn9jReqB7kMqE=
X-Received: by 2002:a05:6512:3a95:b0:4fd:d9e0:4d79 with SMTP id
 q21-20020a0565123a9500b004fdd9e04d79mr8808422lfu.6.1690303520496; Tue, 25 Jul
 2023 09:45:20 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Jul 2023 17:45:09 +0100
Message-ID: <CAFEAcA--B6=JxOuy-55bvBmHDAkvHv5T-7K_kW_9JK0OQ4MPiA@mail.gmail.com>
Subject: s390 intermittent test failure in qemu:block /
 io-qcow2-copy-before-write
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Qemu-block <qemu-block@nongnu.org>, Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12d.google.com
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

There seems to be an intermittent failure on the s390 host in
the qemu:block / io-qcow2-copy-before-write test:
https://gitlab.com/qemu-project/qemu/-/jobs/4737819873

The log says the test was expecting to do some reading
and writing but got an unexpected 'permission denied'
error on the read. Any idea why this might happen ?

768/835 qemu:block / io-qcow2-copy-before-write ERROR 12.05s exit status 1
>>> PYTHON=3D/home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qemu/build/=
pyvenv/bin/python3 MALLOC_PERTURB_=3D101 /home/gitlab-runner/builds/-LCfcJ2=
T/0/qemu-project/qemu/build/pyvenv/bin/python3 /home/gitlab-runner/builds/-=
LCfcJ2T/0/qemu-project/qemu/build/../tests/qemu-iotests/check -tap -qcow2 c=
opy-before-write --source-dir /home/gitlab-runner/builds/-LCfcJ2T/0/qemu-pr=
oject/qemu/tests/qemu-iotests --build-dir /home/gitlab-runner/builds/-LCfcJ=
2T/0/qemu-project/qemu/build/tests/qemu-iotests
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80 =E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95
stderr:
--- /home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qemu/tests/qemu-iote=
sts/tests/copy-before-write.out
+++ /home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qemu/build/scratch/q=
cow2-file-copy-before-write/copy-before-write.out.bad
@@ -1,5 +1,21 @@
-....
+...F
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+FAIL: test_timeout_break_snapshot (__main__.TestCbwError)
+----------------------------------------------------------------------
+Traceback (most recent call last):
+ File "/home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qemu/tests/qemu-=
iotests/tests/copy-before-write",
line 210, in test_timeout_break_snapshot
+ self.assertEqual(log, """\
+AssertionError: 'wrot[195 chars]read 1048576/1048576 bytes at offset
0\n1 MiB,[46 chars]c)\n' !=3D 'wrot[195 chars]read failed: Permission
denied\n'
+ wrote 524288/524288 bytes at offset 0
+ 512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+ wrote 524288/524288 bytes at offset 524288
+ 512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
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

Same failure, previous job:

https://gitlab.com/qemu-project/qemu/-/jobs/4736463062

This one's a "Failed to get write lock" in io-qcow2-161:

https://gitlab.com/qemu-project/qemu/-/jobs/4734846533

(I'm not sure whether there's something up with the s390
at the moment -- it seems to be producing these odd
failures, not always in the iotests. I'm wondering if
it's just running too slowly and we're hitting race
conditions in test cases.)

thanks
-- PMM

