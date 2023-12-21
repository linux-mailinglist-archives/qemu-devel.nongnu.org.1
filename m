Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B65DC81BE05
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 19:19:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGNcj-00058G-Aa; Thu, 21 Dec 2023 13:18:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rGNce-00057k-Sh
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 13:18:16 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rGNcd-0006Gx-8q
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 13:18:16 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40c3ceded81so10946075e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 10:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703182693; x=1703787493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jo71qxPcEd0ZuVzFN747fzDXzvAe6V98P2BaKxwYX6Q=;
 b=q0Ks44JjOSf2k+kDiove61uPtoi718KjA8qsdPjgI0g5wN34mSbIP28CjaPLIIl9AJ
 NJQ+qI02WncxUqygA+vHJFRLVFA8iGAMrYqnsvxr7pEw1mZ19BHv6CNRnUJh1a1ChjsE
 CzJ9uCpQrPqzb2s0BDh1Dx9xxYiaX+uoVdYOIEm5rYKyEpi0yJBkHZxSU3d3t2vL/5N8
 nq0OFuJTHxiaQT3nWnJPakk0budQbKtu+lxACaxgQwrCWr4+98MUzYlR8CedjijPXlX+
 58yjl7RUiW5y59XaL4aMbw6uPHySEo2UlCv5J4nmjpHznEk0SNJv5T5qPkq4fpN0gMIp
 2GyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703182693; x=1703787493;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jo71qxPcEd0ZuVzFN747fzDXzvAe6V98P2BaKxwYX6Q=;
 b=IA5ux7qmlLeVc4YyDs9DxdlFfNmuB42XO7C3xaa+4nbXHrvqMGeOvDy/jsxS364CmJ
 hh+HbkJwY0R6K3pbWNtA4lESeSxrgk4AvVRHYYZjNkE5jAeZAB6Uy0VtjVX1hBdjiegv
 /4bBYzOcaz0Mbscqn9g9ZXR6BA+D8ozqyDxjMxqVsJ/E//kCKWBKTDoFjkouYL/7BKB6
 BC6hf7iyx4+NOtA+L9MyY/sFvIzlPjPKZtalejxD7SX4qJ+g8jTxxsvAMa3Wyit84Hoy
 RQ7gSobdSMdJsEHqC0VhL26xrx6ix7E10+6nctnzdSFCW62fwW9rgW62Fa5EUCN7TGQG
 97ew==
X-Gm-Message-State: AOJu0YwAdO5OaMW5yWAYClx6rkTzp7Wg1Y2+7vgScytaMP/Ow2bzifss
 /JOv/v9OO5fRU8OkUNVAJ/ahTctjCir/noD4Lzzyt5WO42w=
X-Google-Smtp-Source: AGHT+IF1hjbkfjXqfBwXG4H3oxjsh7HwS8fuE7aS1pkiHYWXpxE25UjSGFUjOQIA6CmA2DDTED67Ow==
X-Received: by 2002:a05:600c:4e92:b0:40b:5e21:ec15 with SMTP id
 f18-20020a05600c4e9200b0040b5e21ec15mr78781wmq.71.1703182693467; 
 Thu, 21 Dec 2023 10:18:13 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 fl6-20020a05600c0b8600b0040b30be6244sm4282215wmb.24.2023.12.21.10.18.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 10:18:13 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A047B5F8B5;
 Thu, 21 Dec 2023 18:18:12 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>,  Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: virtio-pci in qemu-system-arm is broken in 8.2
In-Reply-To: <90d7351c-2680-4ab6-95ee-5dac4e3f21c5@tls.msk.ru> (Michael
 Tokarev's message of "Thu, 21 Dec 2023 14:51:38 +0300")
References: <90d7351c-2680-4ab6-95ee-5dac4e3f21c5@tls.msk.ru>
User-Agent: mu4e 1.11.26; emacs 29.1
Date: Thu, 21 Dec 2023 18:18:12 +0000
Message-ID: <87frzvzafv.fsf@draig.linaro.org>
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

Michael Tokarev <mjt@tls.msk.ru> writes:

> It looks like virtio-pci is entirely broke in qemu-system-arm, at least i=
n tcg
> mode running on x86.  The guest (current linux system) just does not dete=
ct
> any virtio-pci devices at all.
>
> When 8.1 is booting, the following messages are displayed (debian initram=
fs):
>
> Loading, please wait...
> Starting systemd-udevd version 255-1
> [    6.455941] virtio-pci 0000:00:01.0: enabling device (0100 -> 0103)
> [    6.929155] virtio-pci 0000:00:02.0: enabling device (0100 -> 0103)
> [    7.764652] virtio_blk virtio1: 2/0/0 default/read/poll queues
> [    7.783216] virtio_blk virtio1: [vda] 2097026 512-byte logical blocks =
(1.07 GB/1024 MiB)
> [    8.636453] virtio_net virtio0 enp0s1: renamed from eth0
>
> But when 8.2 is booting, it ends up at:
>
> Loading, please wait...
> Starting systemd-udevd version 255-1
> ..and nothing.  here it waits for the root fs to appear, and drops into t=
he shell
>
> git bisect points at this commit:
>
> commit b8f7959f28c4f36496bc0a694fa28bf5078152c5
> Author: Peter Maydell <peter.maydell@linaro.org>
> Date:   Mon Jul 24 18:43:33 2023 +0100
>
>     target/arm: Do all "ARM_FEATURE_X implies Y" checks in post_init
>
> Reverting this commit on top of 8.2.0 (or current qemu master)
> makes things works again.
>
> It's interesting how we missed this out entirely, as it's been applied
> at the beginning of 8.2 development cycle, it's 228th commit after
> 8.1.0.
>
> It looks like we've quite a bit more regressions like this in 8.2.0..
> :(

We have at least one test that does use virtio-pci on qemu-system-arm
and passes. From:

  ./pyvenv/bin/avocado run ./tests/avocado --filter-by-tags=3Darch:arm

We can see:

  grep "virtio" /home/alex/avocado/job-results/job-2023-12-21T18.11-8dc03b2=
/job.log | grep pci
  2023-12-21 18:14:31,294 machine          L0470 DEBUG| VM launch command: =
'./qemu-system-arm -display none -vga none -chardev socket,id=3Dmon,fd=3D5 =
-mon chardev=3Dmon,mode=3Dcontrol -machine versatilepb -chardev socket,id=
=3Dconsole,fd=3D19 -serial chardev:console -cpu arm926 -kernel /home/alex/a=
vocado/data/cache/by_location/a8e6fbd14f0270fef06aaef9fc413c5a6ed71120/zIma=
ge -append printk.time=3D0 root=3D/dev/vda console=3DttyAMA0 -blockdev driv=
er=3Draw,file.driver=3Dfile,file.filename=3D/home/alex/avocado/job-results/=
job-2023-12-21T18.11-8dc03b2/test-results/tmp_dir1mqewwjv/40-._tests_avocad=
o_tuxrun_baselines.py_TuxRunBaselineTest.test_armv5/rootfs.ext4,node-name=
=3Dhd0 -device virtio-blk-pci,drive=3Dhd0 -dtb /home/alex/avocado/data/cach=
e/by_location/a8e6fbd14f0270fef06aaef9fc413c5a6ed71120/versatile-pb.dtb'
  2023-12-21 18:14:31,722 __init__         L0153 DEBUG| virtio-pci 0000:00:=
0d.0: enabling device (0100 -> 0103)

But obviously not enough coverage to catch this regression.=20

>
> /mjt

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

