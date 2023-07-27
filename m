Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D30765768
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 17:24:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP2oZ-0001iD-AN; Thu, 27 Jul 2023 11:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1qP2oW-0001gI-Ot
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 11:22:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1qP2oU-0006UF-AZ
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 11:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690471321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QF/ESWBLoXrVmnkgHwloZTi9CYUA5+vhBU52yWPpx1M=;
 b=jDYl0BPv3+KoaxKLw++4RVpJ4YcsPNohMiYiFf6CONXknvS25Kev4F1WuqIypz2P7yp8xr
 xtQeGyG2Y/t67RTcl70B9dkw9gzscW2OZAvr/C4KHrcmaChlVniqhdPt6j9HFwlc+2FsIw
 IS9seU99Q8eh9CQjtBZoPgoymKOytbk=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-8P2vhDBCMiGAPsA1MJTuzw-1; Thu, 27 Jul 2023 11:20:25 -0400
X-MC-Unique: 8P2vhDBCMiGAPsA1MJTuzw-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-55bf2bf1cdeso875498a12.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 08:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690471223; x=1691076023;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QF/ESWBLoXrVmnkgHwloZTi9CYUA5+vhBU52yWPpx1M=;
 b=CMo8T0PpKGA5/5xb3X+fLfr2UHKOg/bn23sM2hFObsyTcGnlX9n0iZQgouCFCgP2md
 05+NpsAnujMsvXwN9AESPO91Qdors0nR01eC0UaLVVOu3d44EcbKGnBzHdP8jUyssoMl
 yC5vG/Rx27Oe9gMOJ6Y9Tq/oGjeroJsd6Og3nXTgFAPPl8Srl3G88YRn1fmcltXJTGcZ
 uP3kD1HhoPDJHnFqBZzTwXDKq8UgWKMOGYrn+2huv3H0dOHKDgf23t4+GARKDe8jD3Ct
 5AGQMKH0HwUVgbcYViQnFvXFJ1Q4J6OOdBLEVlWaIcy8bMOshvUxEOnXXYJtaO5zseap
 cY3g==
X-Gm-Message-State: ABy/qLZmknLpjkGh1g6gWMRDNK29YjZB3b/Up4vqML7+L9SeU+xEL6++
 fk24svoBAC+jr3lfidZ0BzLLJ7KBztWkPEu2yUX4jXCp+ERy6ZkBKSKnu2Gimy1IJgY9h8Gu8Pw
 tcyl3E55sSTrPtUhNjx4wa+k5HVHB0lKXyxCvDl5mMQ==
X-Received: by 2002:a17:902:dac4:b0:1bb:cd10:8209 with SMTP id
 q4-20020a170902dac400b001bbcd108209mr5360197plx.50.1690471223466; 
 Thu, 27 Jul 2023 08:20:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHxDDHx74WcVFvaYcFBpB5//EQO2dDTFVuHRwrwWJmY7IfNR3+qeqv0mfxvROAStxpm2Fwrxm483X9fqhnOBUs=
X-Received: by 2002:a17:902:dac4:b0:1bb:cd10:8209 with SMTP id
 q4-20020a170902dac400b001bbcd108209mr5360182plx.50.1690471223122; Thu, 27 Jul
 2023 08:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA--tJPhQO49W3BDO1MABQFHrr50MU=q54TFYpbkOxVWHw@mail.gmail.com>
In-Reply-To: <CAFEAcA--tJPhQO49W3BDO1MABQFHrr50MU=q54TFYpbkOxVWHw@mail.gmail.com>
From: Cleber Rosa <crosa@redhat.com>
Date: Thu, 27 Jul 2023 11:20:11 -0400
Message-ID: <CA+bd_6Krq9aCCQe01OjXxb+T-=3XrSnvVHrKs3F-3cwdZEGH8Q@mail.gmail.com>
Subject: Re: avocado test failing INTERRUPTED for "Missing asset"
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 25, 2023 at 1:13=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> Currently this CI job is failing:
>
> https://gitlab.com/qemu-project/qemu/-/jobs/4737819946
>
> because:
>
> (05/59) tests/avocado/boot_linux_console.py:BootLinuxConsole.test_arm_exy=
nos4210_initrd:
> INTERRUPTED: Missing asset
> https://snapshot.debian.org/archive/debian/20190928T224601Z/pool/main/l/l=
inux/linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb\nRunner
> error occurred: Timeout reached\nOriginal status: CANCEL\n{'name':
> '05-tests/avocado/boot_linux_console... (90.67 s)
>
> Why is a "Missing asset" causing a timeout after 90 seconds,
> rather than being accounted as a "SKIP" ("missing requirements
> in the test environment" sounds like what we have here) ?
>

Hi Peter,

First of all, I am sorry for the frustration you experienced while
trying to understand all of this.  It tooke me a while too. Anyways,
the 90 seconds timeout is set here[1].

> I don't understand the debug.log, because it says all of
>  * that it retrieved the URL

That happens here[2], because Python's urllib.request.urlopen()[3]
returned a response.  The message is clearly misleading, though,
because:

1. the response may not indicate that the request was successful (even
though the most common exception raised by unsuccessful operations,
HTTPError,  is being handled)
2. that the file's content being pointed at by the URL has been transferred=
.

I've opened an issue[4] to fix this misleading message.

>  * that it wanted to cancel the test

Yes, this is the default behavior set here[5] (cancel_on_missing=3DTrue).

>  * that the test timed out
>

My understanding, up to this point, is that:

Avocado signals to the test that it should be interrupted.  The
handling of the exception gets to the attempt to fetch the asset,
which fails and is thus considered missing.  Because of
cancel_on_missing=3DTrue, It sets the status of the test, up to that
point, to be CANCELed.

But, Avocado "knows better", because it triggered the interruption of
the test, so it overwrites that status of the test as INTERRUPTed.
The whole thing may be complex and confusing, but IMO it seems
coherent so far (minus the misleading "retrieved" message).

Your question (" Why is a "Missing asset" causing a timeout after 90
seconds, rather than being accounted as a "SKIP" ("missing
requirements in the test environment" sounds like what we have here)
?) is actually very important and up to the point.  For Avocado 88.1,
there are two things happening when it comes to requirements:

1. The "assets" plugin runs *before* the job, and attempts to identify
and cache all assets (best effort, and sometimes limited approach,
because it employs a static syntactic analysis of the source code to
identify assets to be retrieved.  This *usually* handles the
requirements before the tests.
2. The actual execution of the "fetch_asset()" code during the test
execution (including during setUp()).  This is *not* limited by the
static syntactic analysis mentioned earlier.

Ideally, step 2 would *not* happen, as it can violate the
"requirements before test" principle.  One way to achieve that is
simply to set find_only=3DTrue at the same place cancel_on_missing
defaults to True[5].  It's documented here[6].

For newer Avocado, there's a completely different requirement
mechanism[7], that is completely outside of the test execution.  I
hope that it will be leveraged by QEMU (it was designed to improve the
current design/implementation limitations mentioned previously).  But,
this is a bit out of the scope at this point, because the goal is to
have Avocado 103.0 addressing logging and properly cleaning up all
tests (like stray processes) which are the two high priority issues we
are tracking with the "customer:QEMU" label before proposing a bump in
Avocado version.

> Here it is:
>
> 16:03:16 DEBUG| PARAMS (key=3Darch, path=3D*, default=3Darm) =3D> 'arm'
> 16:03:16 DEBUG| PARAMS (key=3Dcpu, path=3D*, default=3DNone) =3D> None
> 16:03:16 DEBUG| PARAMS (key=3Dqemu_bin, path=3D*,
> default=3D./qemu-system-arm) =3D> './qemu-system-arm'
> 16:03:16 DEBUG| PARAMS (key=3Dmachine, path=3D*, default=3Dsmdkc210) =3D>=
 'smdkc210'
> 16:03:16 INFO | Asset not in cache, fetching it.
> 16:03:16 INFO | Fetching
> https://snapshot.debian.org/archive/debian/20190928T224601Z/pool/main/l/l=
inux/linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb
> -> /builds/qemu-project/qemu/avocado-cache/by_location/5f20376efeb69c8898=
caaff3edf7de45b4540163/linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.d=
eb.ooffovd_
> 16:04:05 DEBUG| Retrieved URL
> "https://snapshot.debian.org/archive/debian/20190928T224601Z/pool/main/l/=
linux/linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb":
> content-length 33882084, date: "Tue, 25 Jul 2023 16:03:16 GMT",
> last-modified: "Tue, 24 Sep 2019 22:31:23 GMT"
> 16:04:46 ERROR| RuntimeError: Test interrupted by SIGTERM
> 16:04:46 ERROR|
> 16:04:46 ERROR| Reproduced traceback from:
> /builds/qemu-project/qemu/build/tests/venv/lib/python3.9/site-packages/av=
ocado/core/test.py:767
> 16:04:46 ERROR| Traceback (most recent call last):
> 16:04:46 ERROR|   File
> "/builds/qemu-project/qemu/build/tests/venv/lib/python3.9/site-packages/a=
vocado/core/test.py",
> line 1043, in fetch_asset
> 16:04:46 ERROR|     return asset_obj.fetch()
> 16:04:46 ERROR|   File
> "/builds/qemu-project/qemu/build/tests/venv/lib/python3.9/site-packages/a=
vocado/utils/asset.py",
> line 381, in fetch
> 16:04:46 ERROR|     raise OSError("Failed to fetch %s (%s)." %
> (self.asset_name, error))
> 16:04:46 ERROR| OSError: Failed to fetch
> linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb (Test
> interrupted by SIGTERM).
> 16:04:46 ERROR|
> 16:04:46 ERROR| During handling of the above exception, another
> exception occurred:
> 16:04:46 ERROR|
> 16:04:46 ERROR| Traceback (most recent call last):
> 16:04:46 ERROR|   File
> "/builds/qemu-project/qemu/build/tests/avocado/boot_linux_console.py",
> line 514, in test_arm_exynos4210_initrd
> 16:04:46 ERROR|     deb_path =3D self.fetch_asset(deb_url, asset_hash=3Dd=
eb_hash)
> 16:04:46 ERROR|   File
> "/builds/qemu-project/qemu/build/tests/avocado/avocado_qemu/__init__.py",
> line 260, in fetch_asset
> 16:04:46 ERROR|     return super().fetch_asset(name,
> 16:04:46 ERROR|   File
> "/builds/qemu-project/qemu/build/tests/venv/lib/python3.9/site-packages/a=
vocado/core/test.py",
> line 1049, in fetch_asset
> 16:04:46 ERROR|     self.cancel("Missing asset {}".format(name))
> 16:04:46 ERROR|   File
> "/builds/qemu-project/qemu/build/tests/venv/lib/python3.9/site-packages/a=
vocado/core/test.py",
> line 988, in cancel
> 16:04:46 ERROR|     raise exceptions.TestCancel(message)
> 16:04:46 ERROR| avocado.core.exceptions.TestCancel: Missing asset
> https://snapshot.debian.org/archive/debian/20190928T224601Z/pool/main/l/l=
inux/linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb
> 16:04:46 ERROR|
> 16:04:46 ERROR| CANCEL
> 05-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_arm_exynos42=
10_initrd
> -> TestCancel: Missing asset
> https://snapshot.debian.org/archive/debian/20190928T224601Z/pool/main/l/l=
inux/linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb
> 16:04:46 INFO |
>
> Runner error occurred: Timeout reached
> Original status: CANCEL
> {'name': '05-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ar=
m_exynos4210_initrd',
> 'logdir': '/builds/qemu-project/qemu/build/tests/results/job-2023-07-25T1=
6.00-c6ec778/test-results/05-tests_avocado_boot_linux_console.py_BootLinuxC=
onsole.test_arm_exynos4210_initrd',
> 'logfile': '/builds/qemu-project/qemu/build/tests/results/job-2023-07-25T=
16.00-c6ec778/test-results/05-tests_avocado_boot_linux_console.py_BootLinux=
Console.test_arm_exynos4210_initrd/debug.log',
> 'status': 'CANCEL', 'running': False, 'paused': False, 'time_start':
> 1690300996.270224, 'time_elapsed': 90.66501116752625, 'time_end':
> 1690301086.9352353, 'fail_reason': 'Missing asset
> https://snapshot.debian.org/archive/debian/20190928T224601Z/pool/main/l/l=
inux/linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb',
> 'fail_class': 'TestCancel', 'traceback': 'Traceback (most recent call
> last):\n  File "/builds/qemu-project/qemu/build/tests/venv/lib/python3.9/=
site-packages/avocado/core/test.py",
> line 1043, in fetch_asset\n    return asset_obj.fetch()\n  File
> "/builds/qemu-project/qemu/build/tests/venv/lib/python3.9/site-packages/a=
vocado/utils/asset.py",
> line 381, in fetch\n    raise OSError("Failed to fetch %s (%s)." %
> (self.asset_name, error))\nOSError: Failed to fetch
> linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb (Test
> interrupted by SIGTERM).\n\nDuring handling of the above exception,
> another exception occurred:\n\nTraceback (most recent call last):\n
> File "/builds/qemu-project/qemu/build/tests/venv/lib/python3.9/site-packa=
ges/avocado/core/test.py",
> line 765, in _run_avocado\n    testMethod()\n  File
> "/builds/qemu-project/qemu/build/tests/avocado/boot_linux_console.py",
> line 514, in test_arm_exynos4210_initrd\n    deb_path =3D
> self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)\n  File
> "/builds/qemu-project/qemu/build/tests/avocado/avocado_qemu/__init__.py",
> line 260, in fetch_asset\n    return super().fetch_asset(name,\n  File
> "/builds/qemu-project/qemu/build/tests/venv/lib/python3.9/site-packages/a=
vocado/core/test.py",
> line 1049, in fetch_asset\n    self.cancel("Missing asset
> {}".format(name))\n  File
> "/builds/qemu-project/qemu/build/tests/venv/lib/python3.9/site-packages/a=
vocado/core/test.py",
> line 988, in cancel\n    raise
> exceptions.TestCancel(message)\navocado.core.exceptions.TestCancel:
> Missing asset https://snapshot.debian.org/archive/debian/20190928T224601Z=
/pool/main/l/linux/linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb\n=
',
> 'tags': {'arch': set(), 'machine': set(), 'accel': set()}, 'timeout':
> 90, 'whiteboard': '', 'phase': 'FINISHED', 'class_name':
> 'BootLinuxConsole', 'params': [], 'job_logdir':
> '/builds/qemu-project/qemu/build/tests/results/job-2023-07-25T16.00-c6ec7=
78',
> 'job_unique_id': 'c6ec77846be47fc859fe109c38c0932cc07fe04c'}
>

[1] - https://gitlab.com/qemu-project/qemu/-/blob/ccdd31267678db9d80578b5f8=
0bbe94141609ef4/tests/avocado/boot_linux_console.py#L98
[2] - https://github.com/avocado-framework/avocado/blob/1fba8042a8a4a83f534=
2138786240f676e58074d/avocado/utils/download.py#L46
[3] - https://docs.python.org/3/library/urllib.request.html#urllib.request.=
urlopen
[4] - https://github.com/avocado-framework/avocado/issues/5742
[5] - https://gitlab.com/qemu-project/qemu/-/blob/ccdd31267678db9d80578b5f8=
0bbe94141609ef4/tests/avocado/avocado_qemu/__init__.py#L259
[6] - https://avocado-framework.readthedocs.io/en/102.0/api/test/avocado.ht=
ml#avocado.Test.fetch_asset
[7] - https://avocado-framework.readthedocs.io/en/102.0/blueprints/BP004.ht=
ml

>
> thanks
> -- PMM
>


