Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84808A3C751
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Feb 2025 19:23:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkoiC-0005wB-BR; Wed, 19 Feb 2025 13:22:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1tkoi8-0005vh-Lh
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 13:22:16 -0500
Received: from smtp-relay-services-0.canonical.com ([185.125.188.250])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1tkoi6-0007YQ-3L
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 13:22:16 -0500
Received: from scripts.lp.internal (scripts.lp.internal [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 7F72C4367A
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 18:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1739989331;
 bh=ZCIfczu7CGea0DBSnapTPAJr5Di/1/etHPBISTZa2m0=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=oaG7ZjrRIzP5buARrrIpZp0twwDaQ1dln7LXcFXC3x+T2wiMhpHARGagsWH06gjyy
 4QooxDzmlvJgmpEGhUa/Qabowzdn3hspvusV/qDa0S+E0tkIEAd4qmTRJzA0Frqnu6
 soKEL4yk9UzFYgi3lLIVZgQQJoadsM9WRAyh6fGsjAS7IrAEpo38VjN590UUCXeWrs
 5Ls3s54kprBBDIsGyxX0YdXEQtVSoeIdYfEkPk8LB8fNHaY/ytzz51nm4hdJDOTo6H
 eGpKxYi9LwIKB8mELmVy5XhooOgEvRdCAgLZnAl8f9/bS3bA1CEcRpLE9Jwz+oQx2b
 gNZI+cqOLj2IA==
Received: from scripts.lp.internal (localhost [127.0.0.1])
 by scripts.lp.internal (Postfix) with ESMTP id 5B9287E87C
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 18:22:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Feb 2025 18:14:14 -0000
From: Bug Watch Updater <2072564@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Unknown;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=Triaged; importance=Undecided; assignee=lukas.maerdian@canonical.com; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dimitry.unified-streaming.com michal.fita paelzer
 sergiodj thir820
X-Launchpad-Bug-Reporter: Dimitry Andric (dimitry.unified-streaming.com)
X-Launchpad-Bug-Modifier: Bug Watch Updater (bug-watch-updater)
References: <172053137048.3332067.13534832802726064667.malonedeb@juju-98d295-prod-launchpad-7>
Message-Id: <173998885645.2534478.545690015909371819.launchpad@scripts.lp.internal>
Subject: [Bug 2072564] Re: qemu-aarch64-static segfaults running ldconfig.real
 (amd64 host)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="78860d903de6d6d7dd5a0ade63efaca45d3467e2";
 Instance="launchpad-scripts"
X-Launchpad-Hash: 22503e4404f1c2218b2599415f72a58312bad595
Received-SPF: pass client-ip=185.125.188.250;
 envelope-from=noreply@launchpad.net; helo=smtp-relay-services-0.canonical.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 2072564 <2072564@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

** Changed in: qemu
       Status: New =3D> Fix Released

--=20
You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/2072564

Title:
  qemu-aarch64-static segfaults running ldconfig.real (amd64 host)

Status in QEMU:
  Fix Released
Status in qemu package in Ubuntu:
  Triaged

Bug description:
  This affects the qemu-user-static 1:8.2.2+ds-0ubuntu1 package on
  Ubuntu 24.04, running on a amd64 host.

  When running docker containers with Ubuntu 22.04 in them, emulating
  arm64 with qemu-aarch64-static, invocations of ldconfig (actually
  ldconfig.real) segfault. For example:

  $ docker run -ti --platform linux/arm64/v8 ubuntu:22.04=20
  root@8861ff640a1c:/# /sbin/ldconfig.real
  Segmentation fault

  If you copy the ldconfig.real binary to the host, and run it directly
  via qemu-aarch64-static:

  $ gdb --args qemu-aarch64-static ./ldconfig.real=20
  GNU gdb (Ubuntu 15.0.50.20240403-0ubuntu1) 15.0.50.20240403-git
  Copyright (C) 2024 Free Software Foundation, Inc.
  License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.h=
tml>
  This is free software: you are free to change and redistribute it.
  There is NO WARRANTY, to the extent permitted by law.
  Type "show copying" and "show warranty" for details.
  This GDB was configured as "x86_64-linux-gnu".
  Type "show configuration" for configuration details.
  For bug reporting instructions, please see:
  <https://www.gnu.org/software/gdb/bugs/>.
  Find the GDB manual and other documentation resources online at:
      <http://www.gnu.org/software/gdb/documentation/>.

  For help, type "help".
  Type "apropos word" to search for commands related to "word"...
  Reading symbols from qemu-aarch64-static...
  Reading symbols from /home/dim/.cache/debuginfod_client/86579812b213be096=
4189499f62f176bea817bf2/debuginfo...
  (gdb) r
  Starting program: /usr/bin/qemu-aarch64-static ./ldconfig.real
  [Thread debugging using libthread_db enabled]
  Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
  [New Thread 0x7ffff76006c0 (LWP 28378)]

  Thread 1 "qemu-aarch64-st" received signal SIGSEGV, Segmentation fault.
  0x00007fffe801645b in ?? ()
  (gdb) disassemble=20
  No function contains program counter for selected frame.

  It looks like this is a known qemu regression after v8.1.1:
  https://gitlab.com/qemu-project/qemu/-/issues/1913

  Downgrading the package to qemu-user-
  static_8.0.4+dfsg-1ubuntu3_amd64.deb fixes the segfault.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/2072564/+subscriptions


