Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA757AAFC6
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 12:42:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjdbd-0003hp-Tg; Fri, 22 Sep 2023 06:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1qjdbP-0003hH-6W
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 06:41:40 -0400
Received: from smtp-relay-services-0.canonical.com ([185.125.188.250])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1qjdbL-0001sb-E0
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 06:41:37 -0400
Received: from juju-98d295-prod-launchpad-16.localdomain (unknown
 [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id D10BD42CFA
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 10:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1695379280;
 bh=6fpjuSo9rT9pWm2IUo1vuCU1InRrxp9xzLYNwQQxW3Q=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=Ix4AlOAvRywSWGnr7wVHT1nzowrBFvXa1t1VyLZS5U9Cpbmm86RHM/byPODTPJrJ3
 niGYXsGCvlUHbqhCKtEmiszcCW39fdFLx6XlYtXlGgYSzwwYtBoUsPgOobGd4o4VKQ
 73MsC+JLBVYNdk7rJwUr1I8mzlTilbiJHdHMZi5I8FQIyMj3u88kAJHjoNd5S8sxrs
 mO256l5K4Y49T8L5tx4PYWk2pVg66Y9kgC/1WmA6LB8uKjnygbsq/DStdJX1HN8pXD
 dWRT2fFSb9ltp2ViPVuJ/Eh9hL39Zr8GQVv7o8HGk+WwdLldds4atdj2bjAdzXEMCf
 hF+SvP6Rmls/Q==
Received: from [10.131.215.246] (localhost [127.0.0.1])
 by juju-98d295-prod-launchpad-16.localdomain (Postfix) with ESMTP id
 68DB57E16C
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 10:40:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 Sep 2023 10:33:20 -0000
From: Michael Tokarev <1819289@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: mttcg
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: cbparker curryrice71 dgilbert-h mjt+launchpad-tls
 philmd pmaydell th-huth
X-Launchpad-Bug-Reporter: John M (curryrice71)
X-Launchpad-Bug-Modifier: Michael Tokarev (mjt+launchpad-tls)
References: <155216177409.9624.16357609956497374456.malonedeb@gac.canonical.com>
Message-Id: <169537880058.567449.11387712062645322172.malone@juju-98d295-prod-launchpad-7>
Subject: [Bug 1819289] Re: Windows 95 and Windows 98 will not install or run
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="d47b73632f1fccdd9fdd4e6145a4784874303779";
 Instance="launchpad-scripts"
X-Launchpad-Hash: e2fca51f6b06aa98970b9dcfe2e33aaae227b45b
Received-SPF: pass client-ip=185.125.188.250;
 envelope-from=noreply@launchpad.net; helo=smtp-relay-services-0.canonical.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
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
Reply-To: Bug 1819289 <1819289@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

I found a win98 iso image and gave this a try with qemu 8.1.  It works
here just fine - either kvm or tcg mode, either qemu x86_64 or i386.
Without any extra options, just this:


  qemu-system-i386 -cdrom w98.iso -drive file=3Dw98.img,format=3Draw

It also works fine with a few previous versions of qemu (tried 5.2 and
7.2).  Everything tested on debian bookworm (with various versions of
qemu debian packages).

--=20
You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1819289

Title:
  Windows 95 and Windows 98 will not install or run

Status in QEMU:
  Fix Released

Bug description:
  The last version of QEMU I have been able to run Windows 95 or Windows
  98 on was 2.7 or 2.8. Recent versions since then even up to 3.1 will
  either not install or will not run 95 or 98 at all. I have tried every
  combination of options like isapc or no isapc, cpu pentium  or cpu as
  486. Tried different memory configurations, but they just don't work
  anymore.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1819289/+subscriptions


