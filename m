Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C77981EF96
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 15:51:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIVEw-0002ml-IE; Wed, 27 Dec 2023 09:50:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1rIVEt-0002mF-Fk
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 09:50:31 -0500
Received: from smtp-relay-services-0.canonical.com ([185.125.188.250])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1rIVEr-0000cK-2A
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 09:50:31 -0500
Received: from juju-98d295-prod-launchpad-16.localdomain (scripts.lp.internal
 [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 2C84541DD9
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 14:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1703688622;
 bh=yhwPQtgyRRYOQCcv6ndc+u87PXWHT6u/1BnY4qCvpG0=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=PfG0Veby5F6BYgPyWgruDaxmIJe7U6jzFYj4/FWhqSWX7OO2PpTb5j37xhVALsw2s
 71sREaJLswu5fom6IyilzbYdVtw0zP9+KVOcLkyKATF3NATu3v5n3BgxoEqd3SlKOO
 XUpwGLF5ZhLQ7u/4EdEOP0Ss19J7HXCtDTV3gmImNfDOXbDVl3XXPNAbngVQXQBGeA
 G9SJotPnvd7hVrcPWhZ44jdCo1kFjQqaYvpk28ZZTtj01aLawu35Vqg0tc+uA/5T6x
 jugPFKcZH0DdMb34q2lMMAE385hkT093FB+qpuJ5cyw5lqxW5R24CyFRlnUFIy9dPz
 S5OVGQzQcXqMw==
Received: from [10.131.215.246] (localhost [127.0.0.1])
 by juju-98d295-prod-launchpad-16.localdomain (Postfix) with ESMTP id
 F23287E391
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 14:50:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 Dec 2023 14:42:27 -0000
From: Not Applicable <1119281@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: cyberbeastie fgouget janitor notapplicable623
 stefanha th-huth
X-Launchpad-Bug-Reporter: Francois Gouget (fgouget)
X-Launchpad-Bug-Modifier: Not Applicable (notapplicable623)
References: <20130208104503.10940.77009.malonedeb@chaenomeles.canonical.com>
Message-Id: <170368814729.663276.15239647137935393187.malone@juju-98d295-prod-launchpad-2>
Subject: [Bug 1119281] Re: The virtio network device breaks
 UuidCreateSequential()
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e1eeab5b20e19239bd7d5f36676f7a52988db88b";
 Instance="launchpad-scripts"
X-Launchpad-Hash: 5d375df76155e68c29a6b7abeb2c684a56ba26b4
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
Reply-To: Bug 1119281 <1119281@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

For those encountered this problem:
This is not a bug. Instead, it is the exepected behaviour.
Refer to:
https://github.com/virtio-win/kvm-guest-drivers-windows/issues/1017

** Bug watch added: github.com/virtio-win/kvm-guest-drivers-windows/issues =
#1017
   https://github.com/virtio-win/kvm-guest-drivers-windows/issues/1017

--=20
You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1119281

Title:
  The virtio network device breaks UuidCreateSequential()

Status in QEMU:
  Expired

Bug description:
  UuidCreateSequential() usually creates version 1 UUIDs (1) which means
  they contain the main network card's MAC address. However when using a
  virtio network card and driver the UUIDs contain random data instead
  of the guest's MAC address. Changing the network card to either the
  default rtl8139 one or the e1000 one fixes the issue.

  Here is the software I have tested this with:
   * qemu 1.1.2+dfsg-5 and 1.4.0~rc0+dfsg-1exp (from Debian Testing and Exp=
erimental respectively)
   * The 0.1-49 and 0.1-52 Windows virtio drivers from https://alt.fedorapr=
oject.org/pub/alt/virtio-win/latest/images/bin/
   * Both a 32-bit Windows XP guest and a 64-bit Windows 7 one.

 =20
  Here is how to test for this issue:
  * Set up a Windows guest with a single network card(2), a virtio one and =
install the corresponding driver.

  * Boot the guest and copy the uuidtest.exe file (see attachement) to
  it

  * On the command line, type 'ipconfig /all'. Give you the correct
  network card's MAC address on a line like the one below:

          Physical Address. . . . . . . . . : 52-54-00-C7-0E-97

  * Run uuidtest.exe. It will show the VM returning a UUID with the
  wrong MAC address, and quite possibly even a multicast MAC address!
  (3). In the example below 'f75292c62787' should have been the MAC
  address. Note that on Windows XP UuidCreateSequential() returns
  RPC_S_UUID_LOCAL_ONLY for virtio cards but that on Windows 7 it
  returns 0.

          UuidCreateSequential() returned 0
          uuid=3D{56e1ffe4-71d8-11e2-b1cc-f75292c62787}
          Got a version 1 UUID
          The UUID does not contain a non-multicast MAC address

  * Reboot and notice uuidtest.exe now reports a different value where
  the MAC address should be.

  * Shut down the VM and switch the network card to rtl8139, install the
  drivers, run uuidtest.exe and notice that the last group of digits
  finally contains the correct MAC address.

 =20
  (1) https://en.wikipedia.org/wiki/Globally_unique_identifier#Algorithm
  (2) Best do it with a single card to avoid confusion over which is the pr=
imary one.
  (3) If the first byte of the address is odd then this is a multicast addr=
ess.
      https://en.wikipedia.org/wiki/MAC_address#Address_details

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1119281/+subscriptions


