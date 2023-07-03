Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE367454F1
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 07:36:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGCDg-0002cZ-9n; Mon, 03 Jul 2023 01:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1qGCDd-0002bL-C3
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 01:35:25 -0400
Received: from smtp-relay-services-0.canonical.com ([185.125.188.250])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1qGCDa-0000id-Lb
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 01:35:25 -0400
Received: from scripts-1.lp.internal (scripts.lp.internal [10.131.66.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 6F5453F6DB
 for <qemu-devel@nongnu.org>; Mon,  3 Jul 2023 05:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1688362510;
 bh=U6unwQLmHfiht6CyAOmX+ysxSEhhnpEgLQr4ChSr2+s=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=FultMdJgwYIYvEmlSL6GvRcSUWCCEg+hoDzOw4nXkp5oBJUip6PMgMR1RdFMKOt7j
 0SMA4g54vH7utzktWJ3/pzoUlK6Na5TO510oJwJboLaLZR8xkzi7Jk9QWgyPG0UFr5
 GyAbaIfLIOVK8N7yIQ80YIbflGK6CLDPPpMSCKsh+KwgZJCxZ9sJDA/4i/MuWfKBvL
 JeKKy6ExZtIGZ5xx4CwClzFKH/ffc22M63E/TxSSh1j/I1KloHSr75PgBAfIW3jiOc
 0XOdEI6uBbI1Mo8ULICIapOpWag/oPAEJpGDiFGocsoYo5684pB3jiaJmHfIKcrLpp
 e5/MaxXem6TDw==
Received: from
 juju-4112d9-prod-launchpad-manual-servers-36.openstack.prodstack5.lan
 (localhost [127.0.0.1])
 by scripts-1.lp.internal (Postfix) with ESMTP id 0F6D140496
 for <qemu-devel@nongnu.org>; Mon,  3 Jul 2023 05:35:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Jul 2023 05:28:34 -0000
From: "ChengEn, Du" <2025586@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided;
 assignee=chengen.du@canonical.com; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: chengendu
X-Launchpad-Bug-Reporter: ChengEn, Du (chengendu)
X-Launchpad-Bug-Modifier: ChengEn, Du (chengendu)
References: <168835545588.1156951.10472231677518810487.malonedeb@juju-98d295-prod-launchpad-7>
Message-Id: <168836211522.1871397.9886482108451875625.launchpad@juju-98d295-prod-launchpad-2>
Subject: [Bug 2025586] Re: Align the iov length to the logical block size
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="0574793d91fb0560c250e5488455be37b7fc4914"; Instance="production"
X-Launchpad-Hash: a8082d80ea462094ab571e3bef758d263bc1b6d8
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
Reply-To: Bug 2025586 <2025586@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

** Changed in: qemu
     Assignee: (unassigned) =3D> ChengEn, Du (chengendu)

--=20
You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/2025586

Title:
  Align the iov length to the logical block size

Status in QEMU:
  New

Bug description:
  [Impact]
  When the logical block size of the virtual block device is smaller than t=
he block device it is backed by on the host,
  qemu encounters a situation where it needs to bounce unaligned buffers du=
ring the use of direct IO.
  In the past, the logical block size happened to align with the memory pag=
e offset, leading qemu to mistakenly use the memory offset as the block siz=
e.
  However, a kernel commit b1a000d3b8ec resolved this issue by separating m=
emory alignment from the logical block size.
  As a result, qemu now has an incorrect understanding of the minimum vecto=
r size.

  [Fix]
  Upstream commit 25474d90aa50 fixed this issue.
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Author:     Keith Busch <kbusch@kernel.org>
  CommitDate: Fri Sep 30 18:43:44 2022 +0200

      block: use the request length for iov alignment

      An iov length needs to be aligned to the logical block size, which may
      be larger than the memory alignment.

      Tested-by: Jens Axboe <axboe@kernel.dk>
      Signed-off-by: Keith Busch <kbusch@kernel.org>
      Message-Id: <20220929200523.3218710-3-kbusch@meta.com>
      Reviewed-by: Kevin Wolf <kwolf@redhat.com>
      Signed-off-by: Kevin Wolf <kwolf@redhat.com>
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  [Test Plan]
  1. Get a ubuntu image and convert it to RAW format
  wget https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-=
amd64-disk-kvm.img
  qemu-img convert jammy-server-cloudimg-amd64-disk-kvm.img jammy-server-cl=
oudimg-amd64-disk-kvm.raw
  2. Set up a loop device with RAW image
  losetup -b 4096 -f jammy-server-cloudimg-amd64-disk-kvm.raw
  3. Get loop device number by `losetup -a` command
  4. Start the virtual machine
  qemu-system-x86_64 -enable-kvm -drive file=3D/dev/loopX,format=3Draw,cach=
e=3Dnone --nographic

  [Where problems could occur]
  The patch addressed the issue of misusing the memory offset as the block =
size.
  This problem only occurred when the cache option was set to "none" and th=
e Linux kernel being used had the commit b1a000d3b8ec.
  However, it is worth noting that the patch also worked effectively with o=
lder kernels.

  [Other Info]

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/2025586/+subscriptions


