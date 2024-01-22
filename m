Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84ED48374C9
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 22:02:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS1Q6-0005G9-AI; Mon, 22 Jan 2024 16:01:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1rS1Ps-0005DA-QB
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 16:01:16 -0500
Received: from smtp-relay-services-1.canonical.com ([185.125.188.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1rS1Po-000804-7L
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 16:01:11 -0500
Received: from juju-98d295-prod-launchpad-16.localdomain (scripts.lp.internal
 [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 3118F40FA5
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 21:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1705957255;
 bh=khI7Hy+zsYJJqTG6VCwmh9s5Zj3xS9yEzBUFYc0QQhs=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=gxuBDbg8JLZGRo7O8q7hmdZcaAHk7LZogafpD5oFRWVNFj9RESFjzopvKhvfoXkF/
 6IKsPfywoStjICzKrWDNDldwOnD5Hb+KSapLEACHHURz5CKZygDONsEQyfQxmhCF5c
 7hnavKgQg/adaPL7unSgcFgGLEl/gpZSHpAodGVrDFmRwZ8KlU5mpOUZ1h9ZdaEOrH
 oyCi4MyJi0tDS2eFEAsChWjfDes4NuID44mGSnsc5JchOWUqgvxwzVMFAHk3ra+N4p
 +LBx0G8NJy1qJqyJknoKUktlQyG7ODeMBo+l8YDPFVwAB19jziQsPPAE6dW1VPPMBP
 3HwJqYynCShiA==
Received: from [10.131.215.246] (localhost [127.0.0.1])
 by juju-98d295-prod-launchpad-16.localdomain (Postfix) with ESMTP id
 9F1D97EA95
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 21:00:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jan 2024 20:51:20 -0000
From: Peter Maydell <1225187@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jacob11 janitor kavsrf pmaydell th-huth
X-Launchpad-Bug-Reporter: alex (kavsrf)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <20130913204828.19236.78809.malonedeb@soybean.canonical.com>
Message-Id: <170595668066.434189.14155600381968605002.malone@juju-98d295-prod-launchpad-4>
Subject: [Bug 1225187] Re: qemu hangs in windows 7 host with -serial
 pipe:windbg
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="ff54b7050d99a0d84ff58e179f1b8e071713b594";
 Instance="launchpad-scripts"
X-Launchpad-Hash: 82bd2da7349a803897fbba888298dabec798b7e7
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

This bug tracker for QEMU has been obsolete for years. If you think
there's a problem with QEMU, please file a full report in the gitlab
bugtracker: https://gitlab.com/qemu-project/qemu/-/issues . Thanks.

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


