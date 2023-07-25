Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFAE761FE6
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 19:14:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOLbV-0007o1-8f; Tue, 25 Jul 2023 13:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qOLbT-0007nn-6f
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 13:13:43 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qOLbR-0006J9-AR
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 13:13:42 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5221ee899a0so4651952a12.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 10:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690305219; x=1690910019;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7Dikighqt8pQ92DjbQhQaWY4GRAH5zV8SvW2IuDXFdE=;
 b=nbiLWB2UiMdpCk5Mp965IsbaqmG78DkNMB3PUg3y1M4XAl0mw8+wyv5ifyg6+zFjGu
 jk/dLY/lkww2Pvnrb92JWzQqn0khIAU6TWqMQFBNN3uXbK+IIWZe8MNElAw0RRDeedo5
 0zTNePzO8WwAvbXcRraG0r5q5M1BtkUogTL+tvb7eBUdWCuPhtdH3KekrIZ2JDepzV9N
 O9uESIf1mtnM/CmOrB6ZoQkJH4hxqmQzB5Mn8Ktak5ZPeets0mtjaHwMZ42bH6Ibgdvz
 zETKf3IAfCnZCtOQxK54kj38ybMP8DYwq+/4gfOs5AqBmZmGp/a3boEJDvkIwAs4GO6/
 8VVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690305219; x=1690910019;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7Dikighqt8pQ92DjbQhQaWY4GRAH5zV8SvW2IuDXFdE=;
 b=HenjHG7TC1Vle8NCa6sGNM6yXB+IL3nOH/2UHhF5y6tqp44oPMPrIJP/vL2p2Qx14o
 +Yfe7K4YhI5KyqFYZCo/gMB4afvIyQZ6tSEzJDpg9hPvxA3e7AczmYcdQtPhfBAM0buN
 x+m0Xfxq2LSf2QtLOUxj8X6dcoi3DfOe1sAkm5hvAvhbted8X746jULjMwkxY/TzsNV0
 DvTJaZx1yNPmYsWHXB+C3R42EFcMqSCZDvITqRjz4G6jHwHexLpjDljFDbzPdX6rEP9F
 eXZfVPrrlKmQ1BH+/zteoe0Hppl1ub32D6/rsFaTz+n3RvPOBv8sVntFMJlLOkXsOI6N
 zPaQ==
X-Gm-Message-State: ABy/qLaobyVHYFhVTIhYGiGWCglfENk8Q29CIU9S1ANFeUnuOjPbJzR6
 L5GEXZurTqlLJ1ciqepDwKZQ3eB4rTITlRaF1EDUv7Wo8g8EdU9e
X-Google-Smtp-Source: APBJJlHE+8QsFmEuLytf8z1YEV6WypztlGA2mz79AFJWf595LK57GC6REuDuXNaLSWjl+iLBf+4frv0LQybslUD5g/8=
X-Received: by 2002:aa7:d6cb:0:b0:522:38cb:d8cb with SMTP id
 x11-20020aa7d6cb000000b0052238cbd8cbmr4061346edr.20.1690305219319; Tue, 25
 Jul 2023 10:13:39 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Jul 2023 18:13:28 +0100
Message-ID: <CAFEAcA--tJPhQO49W3BDO1MABQFHrr50MU=q54TFYpbkOxVWHw@mail.gmail.com>
Subject: avocado test failing INTERRUPTED for "Missing asset"
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

Currently this CI job is failing:

https://gitlab.com/qemu-project/qemu/-/jobs/4737819946

because:

(05/59) tests/avocado/boot_linux_console.py:BootLinuxConsole.test_arm_exynos4210_initrd:
INTERRUPTED: Missing asset
https://snapshot.debian.org/archive/debian/20190928T224601Z/pool/main/l/linux/linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb\nRunner
error occurred: Timeout reached\nOriginal status: CANCEL\n{'name':
'05-tests/avocado/boot_linux_console... (90.67 s)

Why is a "Missing asset" causing a timeout after 90 seconds,
rather than being accounted as a "SKIP" ("missing requirements
in the test environment" sounds like what we have here) ?

I don't understand the debug.log, because it says all of
 * that it retrieved the URL
 * that it wanted to cancel the test
 * that the test timed out

Here it is:

16:03:16 DEBUG| PARAMS (key=arch, path=*, default=arm) => 'arm'
16:03:16 DEBUG| PARAMS (key=cpu, path=*, default=None) => None
16:03:16 DEBUG| PARAMS (key=qemu_bin, path=*,
default=./qemu-system-arm) => './qemu-system-arm'
16:03:16 DEBUG| PARAMS (key=machine, path=*, default=smdkc210) => 'smdkc210'
16:03:16 INFO | Asset not in cache, fetching it.
16:03:16 INFO | Fetching
https://snapshot.debian.org/archive/debian/20190928T224601Z/pool/main/l/linux/linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb
-> /builds/qemu-project/qemu/avocado-cache/by_location/5f20376efeb69c8898caaff3edf7de45b4540163/linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb.ooffovd_
16:04:05 DEBUG| Retrieved URL
"https://snapshot.debian.org/archive/debian/20190928T224601Z/pool/main/l/linux/linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb":
content-length 33882084, date: "Tue, 25 Jul 2023 16:03:16 GMT",
last-modified: "Tue, 24 Sep 2019 22:31:23 GMT"
16:04:46 ERROR| RuntimeError: Test interrupted by SIGTERM
16:04:46 ERROR|
16:04:46 ERROR| Reproduced traceback from:
/builds/qemu-project/qemu/build/tests/venv/lib/python3.9/site-packages/avocado/core/test.py:767
16:04:46 ERROR| Traceback (most recent call last):
16:04:46 ERROR|   File
"/builds/qemu-project/qemu/build/tests/venv/lib/python3.9/site-packages/avocado/core/test.py",
line 1043, in fetch_asset
16:04:46 ERROR|     return asset_obj.fetch()
16:04:46 ERROR|   File
"/builds/qemu-project/qemu/build/tests/venv/lib/python3.9/site-packages/avocado/utils/asset.py",
line 381, in fetch
16:04:46 ERROR|     raise OSError("Failed to fetch %s (%s)." %
(self.asset_name, error))
16:04:46 ERROR| OSError: Failed to fetch
linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb (Test
interrupted by SIGTERM).
16:04:46 ERROR|
16:04:46 ERROR| During handling of the above exception, another
exception occurred:
16:04:46 ERROR|
16:04:46 ERROR| Traceback (most recent call last):
16:04:46 ERROR|   File
"/builds/qemu-project/qemu/build/tests/avocado/boot_linux_console.py",
line 514, in test_arm_exynos4210_initrd
16:04:46 ERROR|     deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
16:04:46 ERROR|   File
"/builds/qemu-project/qemu/build/tests/avocado/avocado_qemu/__init__.py",
line 260, in fetch_asset
16:04:46 ERROR|     return super().fetch_asset(name,
16:04:46 ERROR|   File
"/builds/qemu-project/qemu/build/tests/venv/lib/python3.9/site-packages/avocado/core/test.py",
line 1049, in fetch_asset
16:04:46 ERROR|     self.cancel("Missing asset {}".format(name))
16:04:46 ERROR|   File
"/builds/qemu-project/qemu/build/tests/venv/lib/python3.9/site-packages/avocado/core/test.py",
line 988, in cancel
16:04:46 ERROR|     raise exceptions.TestCancel(message)
16:04:46 ERROR| avocado.core.exceptions.TestCancel: Missing asset
https://snapshot.debian.org/archive/debian/20190928T224601Z/pool/main/l/linux/linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb
16:04:46 ERROR|
16:04:46 ERROR| CANCEL
05-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_arm_exynos4210_initrd
-> TestCancel: Missing asset
https://snapshot.debian.org/archive/debian/20190928T224601Z/pool/main/l/linux/linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb
16:04:46 INFO |

Runner error occurred: Timeout reached
Original status: CANCEL
{'name': '05-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_arm_exynos4210_initrd',
'logdir': '/builds/qemu-project/qemu/build/tests/results/job-2023-07-25T16.00-c6ec778/test-results/05-tests_avocado_boot_linux_console.py_BootLinuxConsole.test_arm_exynos4210_initrd',
'logfile': '/builds/qemu-project/qemu/build/tests/results/job-2023-07-25T16.00-c6ec778/test-results/05-tests_avocado_boot_linux_console.py_BootLinuxConsole.test_arm_exynos4210_initrd/debug.log',
'status': 'CANCEL', 'running': False, 'paused': False, 'time_start':
1690300996.270224, 'time_elapsed': 90.66501116752625, 'time_end':
1690301086.9352353, 'fail_reason': 'Missing asset
https://snapshot.debian.org/archive/debian/20190928T224601Z/pool/main/l/linux/linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb',
'fail_class': 'TestCancel', 'traceback': 'Traceback (most recent call
last):\n  File "/builds/qemu-project/qemu/build/tests/venv/lib/python3.9/site-packages/avocado/core/test.py",
line 1043, in fetch_asset\n    return asset_obj.fetch()\n  File
"/builds/qemu-project/qemu/build/tests/venv/lib/python3.9/site-packages/avocado/utils/asset.py",
line 381, in fetch\n    raise OSError("Failed to fetch %s (%s)." %
(self.asset_name, error))\nOSError: Failed to fetch
linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb (Test
interrupted by SIGTERM).\n\nDuring handling of the above exception,
another exception occurred:\n\nTraceback (most recent call last):\n
File "/builds/qemu-project/qemu/build/tests/venv/lib/python3.9/site-packages/avocado/core/test.py",
line 765, in _run_avocado\n    testMethod()\n  File
"/builds/qemu-project/qemu/build/tests/avocado/boot_linux_console.py",
line 514, in test_arm_exynos4210_initrd\n    deb_path =
self.fetch_asset(deb_url, asset_hash=deb_hash)\n  File
"/builds/qemu-project/qemu/build/tests/avocado/avocado_qemu/__init__.py",
line 260, in fetch_asset\n    return super().fetch_asset(name,\n  File
"/builds/qemu-project/qemu/build/tests/venv/lib/python3.9/site-packages/avocado/core/test.py",
line 1049, in fetch_asset\n    self.cancel("Missing asset
{}".format(name))\n  File
"/builds/qemu-project/qemu/build/tests/venv/lib/python3.9/site-packages/avocado/core/test.py",
line 988, in cancel\n    raise
exceptions.TestCancel(message)\navocado.core.exceptions.TestCancel:
Missing asset https://snapshot.debian.org/archive/debian/20190928T224601Z/pool/main/l/linux/linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb\n',
'tags': {'arch': set(), 'machine': set(), 'accel': set()}, 'timeout':
90, 'whiteboard': '', 'phase': 'FINISHED', 'class_name':
'BootLinuxConsole', 'params': [], 'job_logdir':
'/builds/qemu-project/qemu/build/tests/results/job-2023-07-25T16.00-c6ec778',
'job_unique_id': 'c6ec77846be47fc859fe109c38c0932cc07fe04c'}


thanks
-- PMM

