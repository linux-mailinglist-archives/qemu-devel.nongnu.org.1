Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3267837430
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 21:44:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS189-0004CG-Te; Mon, 22 Jan 2024 15:42:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1rS184-000478-WD
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 15:42:49 -0500
Received: from smtp-relay-services-1.canonical.com ([185.125.188.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1rS182-0004sD-Hh
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 15:42:48 -0500
Received: from juju-98d295-prod-launchpad-16.localdomain (scripts.lp.internal
 [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 335633F8DF
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 20:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1705956156;
 bh=0BTrjjoOaerh2v889sF2kraVlNioNbJ4IzrzQzJdffU=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=GH86wk0hmF4ApDuN+Su7EIUrSMlANkHPjtsznk/O4RfqCGMVBxWJuEj/1D7ueNfit
 8aFfcXpzYUdBnlaPRVj6XhxT4r+bZH+0DQNDJGiacXQuO/5Eh7qU9UFROqOk1JTMnU
 Bhyr8dGwjfpRqoiBsSyBNQMlNPUeo0jY6qtG2X6K93k4WP3wDYjF+Kz0m6kT7ryV3y
 V5nrjMvNlANuMQtJWBTSlyqAl2+RekWwRGoyygzGfu89DB74QPqQVwNmo4VGHU2dQU
 6kGZwANupTajwPO/iRpVPwr/EDIgSzM4Lkb4Y/DDc6QVllzlRHjG6HCtKfem4v2+Fk
 dkDM2D71RYR3g==
Received: from [10.131.215.246] (localhost [127.0.0.1])
 by juju-98d295-prod-launchpad-16.localdomain (Postfix) with ESMTP id
 933D67EA4D
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 20:40:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jan 2024 20:29:29 -0000
From: Jacob <1225187@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jacob11 janitor kavsrf th-huth
X-Launchpad-Bug-Reporter: alex (kavsrf)
X-Launchpad-Bug-Modifier: Jacob (jacob11)
References: <20130913204828.19236.78809.malonedeb@soybean.canonical.com>
Message-Id: <170595536926.413629.8452294576399738096.malone@juju-98d295-prod-launchpad-4>
Subject: [Bug 1225187] Re: qemu hangs in windows 7 host with -serial
 pipe:windbg
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="ff54b7050d99a0d84ff58e179f1b8e071713b594";
 Instance="launchpad-scripts"
X-Launchpad-Hash: 0ae165547720adc98eafcf3731fc951d76cbcc85
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
Reply-To: Bug 1225187 <1225187@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Tested and this issue still affects the latest version of QEMU (8.2.0)
compiled for Windows.

Instructions in original post are still sufficient to reproduce the problem=
 on Windows 7 x64.
Both i386 and x86_64 were tested and both result in a hung QEMU process, ex=
cept on my system the GUI for QEMU displayed a white screen when hung inste=
ad of black.

** Changed in: qemu
       Status: Expired =3D> New

--=20
You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1225187

Title:
  qemu hangs in windows 7 host with -serial pipe:windbg

Status in QEMU:
  New

Bug description:
  Execution line:
  qemu-system-i386.exe -m 512 c:\Disks\Qemu_XP_en.vhd  -serial pipe:windbg

  It waits for the pipe.
  Execute windbg
  c:\WINDDK\7600.16385.1\Debuggers\windbg.exe -k com:pipe,port=3D\\.\pipe\w=
indbg,resets=3D0,reconnect

  GUI black screen shown. QEMU hangs.

  qemu v1.5.3 (c0b1a7e207094dba0b37a892b41fe4cab3195e44). MinGW built.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1225187/+subscriptions


