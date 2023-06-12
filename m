Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2395E72D41E
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 00:07:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8pfn-000490-WD; Mon, 12 Jun 2023 18:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1q8pfk-00048V-5d
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 18:06:00 -0400
Received: from smtp-relay-services-1.canonical.com ([185.125.188.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1q8pfg-0002xu-Np
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 18:05:59 -0400
Received: from scripts-1.lp.internal (scripts.lp.internal [10.131.66.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id C4D5C3F1D8
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 22:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1686607547;
 bh=CTG/dkcecfCYjthr2Y7MtVB1Px44j4Lcd75TbLZharE=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=gee+FHMwcp/08H3BMTHR6ble2WaV4sJMQr+hGRXod+D5r8X32IvrAUWS3NOQu1Cks
 Doc3+l8TAdl2k1uXtD1IuP9ya7tVEikyPYgv3YmDddZrAdNAxvCoBcZ5GKUsdQ+8Nj
 LjIyWrMeoxBdKN63BJs7ATaqmggmKCW/4l9n2zgpTV+Bzly1V9I0vSquil6PQjoJYB
 1zLs/CTRltfPz5TQdIqL0ovBoyoV03/TLpERj+94iJko13dA1ZJrf+j8NXqFz6og80
 dmUqHzRZgEQuQ0MsiMAsmcZYvf2omCAmwco3J6P+W6kpFR+pnZJcbT6YPmfTrz+Rv9
 Syc1fkFhbBFCg==
Received: from
 juju-4112d9-prod-launchpad-manual-servers-36.openstack.prodstack5.lan
 (localhost [127.0.0.1])
 by scripts-1.lp.internal (Postfix) with ESMTP id 8058D404E4
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 22:05:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Jun 2023 21:57:00 -0000
From: Evren <1180923@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: anthony-codemonkey evren320 janitor luoyonggang
 me-davidglover oubattler panie pmaydell stefanha th-huth
X-Launchpad-Bug-Reporter: TC1988 (panie)
X-Launchpad-Bug-Modifier: Evren (evren320)
References: <20130516173422.20571.91890.malonedeb@gac.canonical.com>
Message-Id: <168660702027.2616538.9508167043385233563.malone@juju-98d295-prod-launchpad-7>
Subject: [Bug 1180923] Re: unused memory filled with 0x00 instead of 0xFF
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="620cd5280e3a973662e263ebf9346837ed657a46"; Instance="production"
X-Launchpad-Hash: 71ab6c4311f8711dfa46f0e37951f838ebec03f3
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
Reply-To: Bug 1180923 <1180923@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

I am using Qemu 8.0.0 and this issue happens only when kvm is enabled, tcg =
initialized the unused bytes to 0xFF as a real machine and works normally, =
so a question in my mind, does kvm use those umb area for increased perform=
ance?
If emm386 M5 is used for using area D000-D7FF as frame page, emm386 gives a=
 warning that there is an option rom in this location but it still uses thi=
s area, seems like a workaround, i do not know if it will have any side eff=
ect

--=20
You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1180923

Title:
  unused memory filled with 0x00 instead of 0xFF

Status in QEMU:
  Expired

Bug description:
  Qemu, ever since it was made (so, since 2003), has this problem in DOS
  (either PC-DOS or MS-DOS and partly Windows 9x) not recognizing the
  memory available when the memory is filled with 0x00 but when it is
  filled with 0xFF it gets recognized properly, where should I patch
  qemu to solve this memory problem?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1180923/+subscriptions


