Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E38A80C7C8
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 12:17:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCeGt-0003Pr-LO; Mon, 11 Dec 2023 06:16:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1rCeGp-0003PU-G9
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 06:16:21 -0500
Received: from smtp-relay-services-0.canonical.com ([185.125.188.250])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1rCeGm-0001MZ-Sz
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 06:16:19 -0500
Received: from juju-98d295-prod-launchpad-16.localdomain (scripts.lp.internal
 [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id E2E7F4230C
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 11:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1702293367;
 bh=MRhdVVOqf75oq/+BzsFQl1X9VSm9OhvSPV3R1lXhC9U=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=KfmRMCBnda1mPpBSPV2+6uCoISVv89TmKx8qw9rrsaJW2KSqiLP7Htcz2LVx61gfY
 pfPHhWWo0S46MB8jDYhvgRTDGoyn/LRf3kQ/lVxDFulW0/6Ws/AbVKu4hIw2J8QI5M
 GTTDnd4EkyjSXwB+llGvLyFMULkkAVFUW3xdZor77UL4H1rx+9y06PwCKVxBaQJJ6X
 lWT7p00rJIlnEGLoWhMjf4vFzxGCFL6oDTnY2ZOMB6TAGK3ykk9GQB0Mh9af4aVxED
 XGG+nwToJvZ/Wfo+GJ4kNde31bm4hcTSq11zhKTkrZtZgslQXWcn1l0TX24moVdWpW
 r3005VS//2I5Q==
Received: from [10.131.215.246] (localhost [127.0.0.1])
 by juju-98d295-prod-launchpad-16.localdomain (Postfix) with ESMTP id
 E61A482215
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 11:15:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 Dec 2023 11:09:07 -0000
From: Ken Sharp <1254672@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu-linaro;
 component=universe; status=Fix Released; importance=Undecided; assignee=None; 
X-Launchpad-Bug-Tags: amd64 apport-bug i386 precise saucy
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: kennybobs pmaydell
X-Launchpad-Bug-Reporter: Ken Sharp (kennybobs)
X-Launchpad-Bug-Modifier: Ken Sharp (kennybobs)
References: <20131125110930.28105.36332.malonedeb@chaenomeles.canonical.com>
Message-Id: <170229294779.1129703.11758789758438386633.malone@juju-98d295-prod-launchpad-3>
Subject: [Bug 1254672] Re: ps segfaults with qemu-{arm, armel, mips,
 powerpc}-static
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e1eeab5b20e19239bd7d5f36676f7a52988db88b";
 Instance="launchpad-scripts"
X-Launchpad-Hash: ba4777a971714128a192a65de71a0d5d72e6eac0
Received-SPF: pass client-ip=185.125.188.250;
 envelope-from=noreply@launchpad.net; helo=smtp-relay-services-0.canonical.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1254672 <1254672@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Tested ps in a bunch of arm* mips* and powerpc chroots with a Jammy host
to check and it seems fine.

Releases above are EOL, so can assume fixed. qemu-linaro is no more.

** Changed in: qemu-linaro (Ubuntu)
       Status: Fix Committed =3D> Fix Released

** No longer affects: qemu-linaro

--=20
You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1254672

Title:
  ps segfaults with qemu-{arm,armel,mips,powerpc}-static

Status in QEMU:
  Fix Released
Status in qemu-linaro package in Ubuntu:
  Fix Released

Bug description:
  Host: Ubuntu Precise AMD64
  Guest: Debian Testing armhf (or armel)

  After running a debootstrap for Debian testing/armhf and entering the
  chroot, simply running "ps" causes a segmentation fault.

  $ sudo qemu-debootstrap --arch=3Darmhf testing armhf http://ftp.uk.debian=
.org/debian/
  [...]
  $ sudo chroot armhf
  # ps
  Signal 11 (SEGV) caught by ps (procps-ng version 3.3.4).
  /bin/ps:display.c:59: please report this bug

  I couldn't find a bug report for procps, which would be unusual if
  such a bug existed, so I'm assuming the bug is in qemu.

  Unfortunately trying to run debootstrap for an Ubuntu variant fails to
  find the release file.

  ps is used a lot, as you can imagine, but specifically it fails when
  trying to install some packages via "apt-get install" and no attempt
  is made to recover.

  ProblemType: Bug
  DistroRelease: Ubuntu 12.04
  Package: qemu-user-static 1.0.50-2012.03-0ubuntu2.1
  ProcVersionSignature: Ubuntu 3.8.0-33.48~precise1-generic 3.8.13.11
  Uname: Linux 3.8.0-33-generic x86_64
  NonfreeKernelModules: wl
  ApportVersion: 2.0.1-0ubuntu17.6
  Architecture: amd64
  Date: Mon Nov 25 10:43:12 2013
  Dependencies:

  InstallationMedia: Ubuntu 12.04.3 LTS "Precise Pangolin" - Release amd64 =
(20130820.1)
  MarkForUpload: True
  ProcEnviron:
  =C2=A0LANGUAGE=3Den_GB:en
  =C2=A0TERM=3Dxterm
  =C2=A0PATH=3D(custom, no user)
  =C2=A0LANG=3Den_GB.UTF-8
  =C2=A0SHELL=3D/bin/bash
  SourcePackage: qemu-linaro
  UpgradeStatus: No upgrade log present (probably fresh install)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1254672/+subscriptions


