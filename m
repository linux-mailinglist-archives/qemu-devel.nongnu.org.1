Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDF5862683
	for <lists+qemu-devel@lfdr.de>; Sat, 24 Feb 2024 18:56:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdwFW-0007x3-Ab; Sat, 24 Feb 2024 12:55:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1rdwFR-0007u6-8R
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 12:55:41 -0500
Received: from smtp-relay-services-0.canonical.com ([185.125.188.250])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1rdwFO-0002IE-NC
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 12:55:40 -0500
Received: from juju-98d295-prod-launchpad-16.localdomain (scripts.lp.internal
 [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 45FD941A93
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 17:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1708797321;
 bh=KSdT8cUZw9aN25yhpNgQyWd/NC4C0W43D7ZXgoYoMGI=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:Message-Id:
 Subject;
 b=EUW8sa2oJoNm0bEYXJpMg7J97JDwoEY/Z1GwU6J3n58HWvgcvjJEWCIC2wPKCP1oQ
 iw6OGIGLMx2P4oPnu/9OJt8bqAps5z9jfS6kWyXfBOxlH9BrFwTH3ZQN2jYst2/yrh
 LpibkQ/fKFAGp+DAxQOqELS9SBYQjRjyPbPp4x3Y05jFqmBmWQK4Zc+ZoJwCFOnVgJ
 gbJeQUGw+M6hpG0bwLz9Hnsh97qvAzBcA2yW2Wis/B8ivclzCX2F2+YTyi+gzERpBx
 7u1H/8BcRRrNmyGTRT2KmWhhTK8GjR8QRzvL1RUlGcwN8w5nNXDLfwA9G5TVxtuJLx
 l2ReBc76iMTCg==
Received: from [10.131.215.246] (localhost [127.0.0.1])
 by juju-98d295-prod-launchpad-16.localdomain (Postfix) with ESMTP id
 5DC6D7E304
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 17:55:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Feb 2024 17:45:37 -0000
From: Benjamin David Lunt <2054889@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: pcap usb
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: fysnet
X-Launchpad-Bug-Reporter: Benjamin David Lunt (fysnet)
X-Launchpad-Bug-Modifier: Benjamin David Lunt (fysnet)
Message-Id: <170879673718.858735.7795185871522080358.malonedeb@juju-98d295-prod-launchpad-4>
Subject: [Bug 2054889] [NEW] pcap streams are text files which insert 0xD in
 Windows version
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="9643586c585856148a18782148972ae9c1179d06";
 Instance="launchpad-scripts"
X-Launchpad-Hash: 532f5a84b1d5c0467fb2133087bb7b2c9e71c8c3
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
Reply-To: Bug 2054889 <2054889@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Public bug reported:

Since Windows text files use CRLFs for all \n, the Windows version of
QEMU inserts a CR in the PCAP stream when a LF is encountered when using
USB PCAP files.

Starting at line 275 in hw/usb/bus (https://gitlab.com/qemu-
project/qemu/-/blob/master/hw/usb/bus.c?ref_type=3Dheads#L275), the file
is opened as text instead of binary.

I think the following patch would fix the issue:
    if (dev->pcap_filename) {
-       int fd =3D qemu_open_old(dev->pcap_filename, O_CREAT | O_WRONLY | O=
_TRUNC, 0666);
+       int fd =3D qemu_open_old(dev->pcap_filename, O_CREAT | O_WRONLY | O=
_TRUNC | O_BINARY, 0666);
        if (fd < 0) {
            error_setg(errp, "open %s failed", dev->pcap_filename);
            usb_qdev_unrealize(qdev);
            return;
        }
-       dev->pcap =3D fdopen(fd, "w");
+       dev->pcap =3D fdopen(fd, "wb");
        usb_pcap_init(dev->pcap);
    }

To show an example, when using a very common protocol to USB disks, the
BBB protocol uses a 10-byte command packet. For example, the
READ_CAPACITY(10) command (implemented at https://gitlab.com/qemu-
project/qemu/-/blob/master/hw/scsi/scsi-disk.c#L2068) will have a
command block length of 10 (0xA). When this 10-byte command (part of the
31-byte CBW) is placed into the PCAP file, the Windows file manager
inserts a 0xD before the 0xA, turning the 31-byte CBW into a 32-byte
CBW.

Actual CBW:
  0040   55 53 42 43 01 00 00 00 08 00 00 00 80 00 0a 25   USBC............
  0050   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00      %..............

PCAP CBW
  0040   55 53 42 43 01 00 00 00 08 00 00 00 80 00 0d 0a   USBC............
  0050   25 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   %..............

I believe simply opening the PCAP file as BINARY instead of TEXT will
fix this issue.

Thank you.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: pcap usb

--=20
You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/2054889

Title:
  pcap streams are text files which insert 0xD in Windows version

Status in QEMU:
  New

Bug description:
  Since Windows text files use CRLFs for all \n, the Windows version of
  QEMU inserts a CR in the PCAP stream when a LF is encountered when
  using USB PCAP files.

  Starting at line 275 in hw/usb/bus (https://gitlab.com/qemu-
  project/qemu/-/blob/master/hw/usb/bus.c?ref_type=3Dheads#L275), the file
  is opened as text instead of binary.

  I think the following patch would fix the issue:
      if (dev->pcap_filename) {
  -       int fd =3D qemu_open_old(dev->pcap_filename, O_CREAT | O_WRONLY |=
 O_TRUNC, 0666);
  +       int fd =3D qemu_open_old(dev->pcap_filename, O_CREAT | O_WRONLY |=
 O_TRUNC | O_BINARY, 0666);
          if (fd < 0) {
              error_setg(errp, "open %s failed", dev->pcap_filename);
              usb_qdev_unrealize(qdev);
              return;
          }
  -       dev->pcap =3D fdopen(fd, "w");
  +       dev->pcap =3D fdopen(fd, "wb");
          usb_pcap_init(dev->pcap);
      }

  To show an example, when using a very common protocol to USB disks,
  the BBB protocol uses a 10-byte command packet. For example, the
  READ_CAPACITY(10) command (implemented at https://gitlab.com/qemu-
  project/qemu/-/blob/master/hw/scsi/scsi-disk.c#L2068) will have a
  command block length of 10 (0xA). When this 10-byte command (part of
  the 31-byte CBW) is placed into the PCAP file, the Windows file
  manager inserts a 0xD before the 0xA, turning the 31-byte CBW into a
  32-byte CBW.

  Actual CBW:
    0040   55 53 42 43 01 00 00 00 08 00 00 00 80 00 0a 25   USBC..........=
..
    0050   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00      %..............

  PCAP CBW
    0040   55 53 42 43 01 00 00 00 08 00 00 00 80 00 0d 0a   USBC..........=
..
    0050   25 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   %..............

  I believe simply opening the PCAP file as BINARY instead of TEXT will
  fix this issue.

  Thank you.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/2054889/+subscriptions


