Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D285739816
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 09:32:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCEnD-0004Bj-Bv; Thu, 22 Jun 2023 03:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1qCEn3-00049h-3d
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:31:37 -0400
Received: from smtp-relay-services-1.canonical.com ([185.125.188.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1qCEn0-0007Pz-Ip
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:31:36 -0400
Received: from scripts-1.lp.internal (scripts.lp.internal [10.131.66.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 5A08B41747
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 07:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1687419088;
 bh=HODmGRYfvOV1sR8nyDYYgHgt7fLJP23FsdUxMnEiVXw=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=B5qjYEgknT/ce2qKnhRf+AElrs3SnXx1lxDDnuv1Oq91e7ss49E0UecXmpDcH/7bd
 Ps3OpUbwt8Tn41ggbcC48VJbulk1p0jJhNX0y8TVsDLLkOeRCQ2n2RfxAtW0uoLTDk
 /sd4iT1MZzCw1PZQNOdwgXu5HTja/n7zKQ+bWYWGn0g0bb1TBdU4zPxfqbbuU3GxGm
 hIZV8Jha6zrDUUnS7BbthCS5F+8llMB5v5Q2dBfXfua+uwGRLFZ8s8fw32LkDWk7u2
 XkiZdGdIFpuMkMlZDsukfFj+K/cQ/4rEO93bbLe5Jr6PZmeHS/TtUjCWb2BYAwrq80
 DscDrxIxu+RQw==
Received: from
 juju-4112d9-prod-launchpad-manual-servers-36.openstack.prodstack5.lan
 (localhost [127.0.0.1])
 by scripts-1.lp.internal (Postfix) with ESMTP id 2F835404EB
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 07:31:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Jun 2023 07:19:45 -0000
From: Thomas Huth <1617385@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Invalid; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: buo-ren-lin dgilbert-h feuerkogel1 janitor th-huth
X-Launchpad-Bug-Reporter: feuerkogel1 (feuerkogel1)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20160826155556.27103.59439.malonedeb@gac.canonical.com>
Message-Id: <168741838516.570544.9534137863162606287.malone@juju-98d295-prod-launchpad-4>
Subject: [Bug 1617385] Re: No snapshot possible with virtio-gpu activated
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1a64fbf0a633b6c807613475aecca0f26ff240b3"; Instance="production"
X-Launchpad-Hash: 9e11b4d74c9bb0626c60d2170c403ed48685612d
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

This bug tracker here is not active anymore. If you want to report bugs,
please open a new ticket at https://gitlab.com/qemu-
project/qemu/-/issues , thanks.

** Changed in: qemu
       Status: Confirmed =3D> Invalid

--=20
You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1617385

Title:
  No snapshot possible with virtio-gpu activated

Status in QEMU:
  Invalid

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


