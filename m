Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DB0969965
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Sep 2024 11:42:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slQ1s-0004mS-4h; Tue, 03 Sep 2024 05:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1slQ1l-0004Y7-E2
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 05:40:45 -0400
Received: from smtp-relay-services-1.canonical.com ([185.125.188.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1slQ1h-0005fF-S0
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 05:40:43 -0400
Received: from scripts.lp.internal (scripts.lp.internal [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 62E0C40FDD
 for <qemu-devel@nongnu.org>; Tue,  3 Sep 2024 09:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1725356439;
 bh=OIKsO8a/Ji3TYcQ00bilEoaMg12/NBOeid94ZEHW/GQ=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=Qc5IUYM9J/G1VLabzZaH7s3wD+vM/1loPTE4w6X2o/Fq160M4T/nvLgi9yq9pacpo
 BVlaESaTNsDUj/QobAQGwzx55aC1TN+ZK7VyFwIqTD4LW/9qMtlaTBkwJ2deZdJmM4
 hWVcYy/Jn8U9xvilfsb8dMwaTGjXsSWIQ0oq3ICl3BQMeWZlzBkWp/OzGCi8rgzDeB
 il8SpfZJbnMi9RzzcRYN9Nt1NJDjY2aqQctxUrM2l+/SE7JGnnkkeRxCBkVJAP5/CZ
 hNr5KXA+faqKYqHksKvmv3F/vnRXuF9Wo5YtrNEexC8JFfrOH6zx/eBz7dFKeTDbAD
 C8AjgtVw3u7cA==
Received: from scripts.lp.internal (localhost [127.0.0.1])
 by scripts.lp.internal (Postfix) with ESMTP id 5939E7E396
 for <qemu-devel@nongnu.org>; Tue,  3 Sep 2024 09:40:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Sep 2024 09:35:08 -0000
From: Mehmet Basaran <2078790@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=linux-lowlatency-hwe-6.8;
 component=main; status=New; importance=Undecided;
 assignee=mehmet.basaran@canonical.com; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=New; importance=Undecided; assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: mehmetbasaran
X-Launchpad-Bug-Reporter: Mehmet Basaran (mehmetbasaran)
X-Launchpad-Bug-Modifier: Mehmet Basaran (mehmetbasaran)
References: <172535521411.2600491.6207708752026464339.malonedeb@juju-98d295-prod-launchpad-3>
Message-Id: <172535610933.1159921.6138904713448565637.malone@juju-98d295-prod-launchpad-7>
Subject: [Bug 2078790] Re: jammy qemu x86 int3: 0000 [#1] SMP NOPTI 
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1b1ed1ad2dbfc71ee62b5c5491c975135a771bf0";
 Instance="launchpad-scripts"
X-Launchpad-Hash: 9bf1eab28aca44fe7ab4d1f9ddd5f7d113e8b5a3
Received-SPF: pass client-ip=185.125.188.251;
 envelope-from=noreply@launchpad.net; helo=smtp-relay-services-1.canonical.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Bug 2078790 <2078790@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Only seen this with x86.

--=20
You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/2078790

Title:
  jammy qemu x86 int3: 0000 [#1] SMP NOPTI

Status in linux-lowlatency-hwe-6.8 package in Ubuntu:
  New
Status in qemu package in Ubuntu:
  New

Bug description:
  jammy:linux-lowlatency-hwe-6.8 6.8.0-44.44.1~22.04.1 qemu-x86 QEMU
  Standard PC (i440FX + PIIX, 1996)

 =20
  Recently (2024.08.05), I have been seeing this issue with ADT:systemd:ups=
tream-1/2 test in which kernel panics/prints a stack. I have seen this with=
 jammy:linux-lowlatency-hwe-6.8 and jammy:linux-ibm-6.8. Stack trace is dif=
ferent everytime because kernel receives an interrupt, drop what it is doin=
g, and crash when handling the interrupt.

  I think this is an issue with qemu and not kernel. For jammy, we are
  using qemu 6.2 and there are some fixes related to x86 interrupt
  handling in 8.x
  (https://lore.kernel.org/lkml/20230705215008.GD17440@redhat.com/T/). I
  propose we create a launchpad bug and trace the issue. If I am
  correct, we shouldn't see this in noble. And we should occasionally
  see this in 5.15 jammy kernels (and more frequently with lowlantecy
  kernels).

 =20
  Meanwhile see comments below for some stack traces;

To manage notifications about this bug go to:
https://bugs.launchpad.net/ubuntu/+source/linux-lowlatency-hwe-6.8/+bug/207=
8790/+subscriptions


