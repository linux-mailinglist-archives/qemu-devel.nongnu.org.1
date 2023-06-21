Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD0373938D
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 02:09:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC7rM-0002FX-SV; Wed, 21 Jun 2023 20:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1qC7rK-0002EF-Fd
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 20:07:34 -0400
Received: from smtp-relay-services-1.canonical.com ([185.125.188.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1qC7rH-0004OA-Vj
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 20:07:34 -0400
Received: from scripts-1.lp.internal (scripts.lp.internal [10.131.66.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id A0B563F144
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 00:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1687392443;
 bh=erMzaroJ8woMr80KRFrU6riRubfFk32ARfVwyaVGiTk=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=I0nnGgzXORBpTvK4ICiaoEoOKSNlLAYc5ejtpmFd8L+oeq37MMilQViIlUACoAO29
 pWRTlVsa/v+Iahd5qy+upA6/9D1hs2837Nx247BrrioiIIoNucBZ2oRJR0CqxmXM+j
 OnthClP0LZ4SbGeE1/BEEFPu9g42gdDEA2QEwRo5yQl5g/h/Brhe9U2knBgxbDaHKp
 46NxP7fmJ1PDaU0RfcrmhP7QaYrIv94iQJc9KMaVCjhf7rOOkPV1+om5oeTfwgJihH
 jJasAwmj2eJmjQAkFb1RoyqxoToEBtOxcBriWuN3UwTGUnS9Z+ts7kBt55Rq59zYDW
 yVv0iXnEpP2Kw==
Received: from
 juju-4112d9-prod-launchpad-manual-servers-36.openstack.prodstack5.lan
 (localhost [127.0.0.1])
 by scripts-1.lp.internal (Postfix) with ESMTP id 090963F0C2
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 00:07:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Jun 2023 23:58:05 -0000
From: =?utf-8?b?5p6X5Y2a5LuBKEJ1by1yZW4sIExpbik=?= <1617385@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: buo-ren-lin dgilbert-h feuerkogel1 janitor
X-Launchpad-Bug-Reporter: feuerkogel1 (feuerkogel1)
X-Launchpad-Bug-Modifier: =?utf-8?b?5p6X5Y2a5LuBKEJ1by1yZW4sIExpbikgKGJ1by1yZW4tbGluKQ==?=
References: <20160826155556.27103.59439.malonedeb@gac.canonical.com>
Message-Id: <168739188505.439318.17942227405614014026.malone@juju-98d295-prod-launchpad-2>
Subject: [Bug 1617385] Re: No snapshot possible with virtio-gpu activated
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1a64fbf0a633b6c807613475aecca0f26ff240b3"; Instance="production"
X-Launchpad-Hash: 407086478901fa96cb90da66d98b10487b7eba93
Received-SPF: pass client-ip=185.125.188.251;
 envelope-from=noreply@launchpad.net; helo=smtp-relay-services-1.canonical.com
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
Reply-To: Bug 1617385 <1617385@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

I also have this problem, with the 3D acceleration enabled, it would be
great if the situation improves as the VM often not stable after the
host restores from sleep state.

** Changed in: qemu
       Status: Expired =3D> Confirmed

--=20
You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1617385

Title:
  No snapshot possible with virtio-gpu activated

Status in QEMU:
  Confirmed

Bug description:
  I'm using "Qemu" and "Virtual Machine Manager" on Debian-8-Stretch -
  both newest versions out of the Debian-testing-repository (state
  26.08.2016).

  If I try to save a virtual machine, it fails and I'll get the
  following error:

  libvirtError: internal error: unable to execute QEMU command
  'migrate': State blocked by non-migratable device
  '0000:00:02.0/virtio-gpu'

  This only happens, if I chose "Virtio" as graphics-driver (no matter
  if I use "Spice" or "Vnc" as Server by the way). If I switch to any
  other driver (Cirrus, Qxl, Vga, VMvga...) there is no problem to take
  a snapshot and save the virtual machine.

  Unfortunately "virtio-gpu" (together with "Spice-Server") is the only
  driver that provides proper working/running my virtual machines on my
  PC.

  feuerkogel1

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1617385/+subscriptions


