Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DDB762DD8
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 09:36:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOZ2k-00077V-8D; Wed, 26 Jul 2023 03:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qOZ26-00074n-Eo
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 03:34:08 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qOZ23-0007Jo-1P
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 03:34:05 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fd190065a8so65108445e9.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 00:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690356841; x=1690961641;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oV9OD4LgCHBjEGwRADbwZz9crfYxY6VhTKR0NoclFLA=;
 b=cAM7ndCjh4OoEP7ILaRbIjYCz/D0ypp4H+r1JdxcpE1220asiswoVKqE2zmvdgaQgE
 DB6tebQxrokfeOO2KFrUrYScdlwzbzPmcp1G54MAsobtiS8j06ZyPWsFtFVw1DW7GWh+
 SLtKZB58/0nBBOPJ2GSOQPArPFUYxATcM9z20eLujCT00MGUDfw481FgkyAtiyOp8+eb
 MDaYE3W52e2x5wDPJhF7Kgp9DINQIXHtmb3ElvBepDhRDOSb+nNr6VTZvVo2JLiYuKuj
 ntrRxtUGejiYhWTSDJkjGZ9+3QRB9AXzgUgjLvCbRWDqNdGW2/XSXJmnzxPZaOM9Uu4v
 popw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690356841; x=1690961641;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oV9OD4LgCHBjEGwRADbwZz9crfYxY6VhTKR0NoclFLA=;
 b=gkE7R1MKHi6O8FSA03/Dhyv5+YOtUT33plIGVtwJRwj8+dSvQm1bQzKj9HsoVH3D/a
 d3VBfPelaK2QaYob6kMIdiv+VTwwwP1oViptzxsSqpVsR0uYeRKd5O2uCD2C+AHU/zL/
 v5L8c1M62KLi1Xd6VDQSXmgrmQnG9aSmRtIIPM9WVXdM5QReRsFYnue5NjrGjDvJDB+l
 SbnPJZaIBD2ycJDdA+ZOF8zpGbzEkonDIPCN8/xrkF07OW2OKwQ3ISCvUxFQ18QWzB6e
 uPfK61y/ESz/9WRCx1AWPvKj4nA1XhOfCdyYhejdv4ijOhAXuz2mqZ9XV7nLqk09OKv/
 ecHQ==
X-Gm-Message-State: ABy/qLYLfidTCac06DDCfaL7UUQ2cvQt9hxiGz6ylWfjTR2FlRFoL9hl
 dAFMAxanaY7ADngXlA3XVqXy9A==
X-Google-Smtp-Source: APBJJlHkNi6nvVuuaDonixxNcE1i1dJREgWB8d2y115wgvdGATQSPekc2X07wLnfS1T472OYiFL7/A==
X-Received: by 2002:a5d:54cb:0:b0:314:33a2:78fe with SMTP id
 x11-20020a5d54cb000000b0031433a278femr885089wrv.29.1690356841210; 
 Wed, 26 Jul 2023 00:34:01 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-51.dsl.sta.abo.bbox.fr.
 [176.184.47.51]) by smtp.gmail.com with ESMTPSA id
 y4-20020a5d4704000000b00313f9085119sm6625810wrq.113.2023.07.26.00.33.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jul 2023 00:34:00 -0700 (PDT)
Message-ID: <ad623dea-4ed8-6e06-3c70-60fcf863a79e@linaro.org>
Date: Wed, 26 Jul 2023 09:33:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: avocado test failing INTERRUPTED for "Missing asset"
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Jan Richter <jarichte@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <CAFEAcA--tJPhQO49W3BDO1MABQFHrr50MU=q54TFYpbkOxVWHw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA--tJPhQO49W3BDO1MABQFHrr50MU=q54TFYpbkOxVWHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 25/7/23 19:13, Peter Maydell wrote:
> Currently this CI job is failing:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/4737819946
> 
> because:
> 
> (05/59) tests/avocado/boot_linux_console.py:BootLinuxConsole.test_arm_exynos4210_initrd:
> INTERRUPTED: Missing asset
> https://snapshot.debian.org/archive/debian/20190928T224601Z/pool/main/l/linux/linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb\nRunner
> error occurred: Timeout reached\nOriginal status: CANCEL\n{'name':
> '05-tests/avocado/boot_linux_console... (90.67 s)
> 
> Why is a "Missing asset" causing a timeout after 90 seconds,
> rather than being accounted as a "SKIP" ("missing requirements
> in the test environment" sounds like what we have here) ?

Maybe something to report to upstream Avocado.


That said, we want CI to be reproducible. If we fetch assets from
unreliable sources, we can't be reproducible. If we are unable to
provide a assets cache, we'll keep hitting this problem. If we can
not find a way to have assets stored (requiring sysadmin time setting
up some infra, possibly only for GitLab), then I'd consider stopping
running tests depending on external assets on CI; otherwise at some
point we'll get tired to waste time figuring out the same problem.

As a maintainer I'm happy to run the avocado tests using my local
assets cache, and I would rather keep using the framework. But then
my cache is likely different from others (users, maintainers, CI).
Similarly few users/maintainers end up having the same cache and
running the same set of tests.

$ du -chs ~/avocado/data/cache/
5.7G    /Users/philmd/avocado/data/cache/

Some files are older than 3 years, and I'm happy to still run the
tests depending on them (although they disappeared from their
original http server).

> I don't understand the debug.log, because it says all of
>   * that it retrieved the URL
>   * that it wanted to cancel the test
>   * that the test timed out
> 
> Here it is:
> 
> 16:03:16 DEBUG| PARAMS (key=arch, path=*, default=arm) => 'arm'
> 16:03:16 DEBUG| PARAMS (key=cpu, path=*, default=None) => None
> 16:03:16 DEBUG| PARAMS (key=qemu_bin, path=*,
> default=./qemu-system-arm) => './qemu-system-arm'
> 16:03:16 DEBUG| PARAMS (key=machine, path=*, default=smdkc210) => 'smdkc210'
> 16:03:16 INFO | Asset not in cache, fetching it.
> 16:03:16 INFO | Fetching
> https://snapshot.debian.org/archive/debian/20190928T224601Z/pool/main/l/linux/linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb
> -> /builds/qemu-project/qemu/avocado-cache/by_location/5f20376efeb69c8898caaff3edf7de45b4540163/linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb.ooffovd_
> 16:04:05 DEBUG| Retrieved URL
> "https://snapshot.debian.org/archive/debian/20190928T224601Z/pool/main/l/linux/linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb":
> content-length 33882084, date: "Tue, 25 Jul 2023 16:03:16 GMT",
> last-modified: "Tue, 24 Sep 2019 22:31:23 GMT"
> 16:04:46 ERROR| RuntimeError: Test interrupted by SIGTERM
> 16:04:46 ERROR|
> 16:04:46 ERROR| Reproduced traceback from:
> /builds/qemu-project/qemu/build/tests/venv/lib/python3.9/site-packages/avocado/core/test.py:767
> 16:04:46 ERROR| Traceback (most recent call last):
> 16:04:46 ERROR|   File
> "/builds/qemu-project/qemu/build/tests/venv/lib/python3.9/site-packages/avocado/core/test.py",
> line 1043, in fetch_asset
> 16:04:46 ERROR|     return asset_obj.fetch()
> 16:04:46 ERROR|   File
> "/builds/qemu-project/qemu/build/tests/venv/lib/python3.9/site-packages/avocado/utils/asset.py",
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
> 16:04:46 ERROR|     deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
> 16:04:46 ERROR|   File
> "/builds/qemu-project/qemu/build/tests/avocado/avocado_qemu/__init__.py",
> line 260, in fetch_asset
> 16:04:46 ERROR|     return super().fetch_asset(name,
> 16:04:46 ERROR|   File
> "/builds/qemu-project/qemu/build/tests/venv/lib/python3.9/site-packages/avocado/core/test.py",
> line 1049, in fetch_asset
> 16:04:46 ERROR|     self.cancel("Missing asset {}".format(name))
> 16:04:46 ERROR|   File
> "/builds/qemu-project/qemu/build/tests/venv/lib/python3.9/site-packages/avocado/core/test.py",
> line 988, in cancel
> 16:04:46 ERROR|     raise exceptions.TestCancel(message)
> 16:04:46 ERROR| avocado.core.exceptions.TestCancel: Missing asset
> https://snapshot.debian.org/archive/debian/20190928T224601Z/pool/main/l/linux/linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb
> 16:04:46 ERROR|
> 16:04:46 ERROR| CANCEL
> 05-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_arm_exynos4210_initrd
> -> TestCancel: Missing asset
> https://snapshot.debian.org/archive/debian/20190928T224601Z/pool/main/l/linux/linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb
> 16:04:46 INFO |
> 
> Runner error occurred: Timeout reached
> Original status: CANCEL
> {'name': '05-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_arm_exynos4210_initrd',
> 'logdir': '/builds/qemu-project/qemu/build/tests/results/job-2023-07-25T16.00-c6ec778/test-results/05-tests_avocado_boot_linux_console.py_BootLinuxConsole.test_arm_exynos4210_initrd',
> 'logfile': '/builds/qemu-project/qemu/build/tests/results/job-2023-07-25T16.00-c6ec778/test-results/05-tests_avocado_boot_linux_console.py_BootLinuxConsole.test_arm_exynos4210_initrd/debug.log',
> 'status': 'CANCEL', 'running': False, 'paused': False, 'time_start':
> 1690300996.270224, 'time_elapsed': 90.66501116752625, 'time_end':
> 1690301086.9352353, 'fail_reason': 'Missing asset
> https://snapshot.debian.org/archive/debian/20190928T224601Z/pool/main/l/linux/linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb',
> 'fail_class': 'TestCancel', 'traceback': 'Traceback (most recent call
> last):\n  File "/builds/qemu-project/qemu/build/tests/venv/lib/python3.9/site-packages/avocado/core/test.py",
> line 1043, in fetch_asset\n    return asset_obj.fetch()\n  File
> "/builds/qemu-project/qemu/build/tests/venv/lib/python3.9/site-packages/avocado/utils/asset.py",
> line 381, in fetch\n    raise OSError("Failed to fetch %s (%s)." %
> (self.asset_name, error))\nOSError: Failed to fetch
> linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb (Test
> interrupted by SIGTERM).\n\nDuring handling of the above exception,
> another exception occurred:\n\nTraceback (most recent call last):\n
> File "/builds/qemu-project/qemu/build/tests/venv/lib/python3.9/site-packages/avocado/core/test.py",
> line 765, in _run_avocado\n    testMethod()\n  File
> "/builds/qemu-project/qemu/build/tests/avocado/boot_linux_console.py",
> line 514, in test_arm_exynos4210_initrd\n    deb_path =
> self.fetch_asset(deb_url, asset_hash=deb_hash)\n  File
> "/builds/qemu-project/qemu/build/tests/avocado/avocado_qemu/__init__.py",
> line 260, in fetch_asset\n    return super().fetch_asset(name,\n  File
> "/builds/qemu-project/qemu/build/tests/venv/lib/python3.9/site-packages/avocado/core/test.py",
> line 1049, in fetch_asset\n    self.cancel("Missing asset
> {}".format(name))\n  File
> "/builds/qemu-project/qemu/build/tests/venv/lib/python3.9/site-packages/avocado/core/test.py",
> line 988, in cancel\n    raise
> exceptions.TestCancel(message)\navocado.core.exceptions.TestCancel:
> Missing asset https://snapshot.debian.org/archive/debian/20190928T224601Z/pool/main/l/linux/linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb\n',
> 'tags': {'arch': set(), 'machine': set(), 'accel': set()}, 'timeout':
> 90, 'whiteboard': '', 'phase': 'FINISHED', 'class_name':
> 'BootLinuxConsole', 'params': [], 'job_logdir':
> '/builds/qemu-project/qemu/build/tests/results/job-2023-07-25T16.00-c6ec778',
> 'job_unique_id': 'c6ec77846be47fc859fe109c38c0932cc07fe04c'}
> 
> 
> thanks
> -- PMM


