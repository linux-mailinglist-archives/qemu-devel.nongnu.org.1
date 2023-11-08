Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AA97E5A90
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 16:56:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0ktC-0000oH-Nf; Wed, 08 Nov 2023 10:54:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <admin@xutaxkamay.com>)
 id 1r0YCR-0008AA-LD
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 21:21:47 -0500
Received: from xutaxkamay.com ([82.65.208.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <admin@xutaxkamay.com>)
 id 1r0YCP-0003c6-V1
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 21:21:47 -0500
Received: from localhost.localdomain (unknown [192.168.1.254])
 (Authenticated sender: admin@xutaxkamay.com)
 by xutaxkamay.com (Postfix) with ESMTPSA id B27E52455C;
 Wed,  8 Nov 2023 02:21:41 +0000 (GMT)
From: Kamay Xutax <admin@xutaxkamay.com>
To: qemu-devel@nongnu.org
Cc: Kamay Xutax <admin@xutaxkamay.com>
Subject: [PATCH RFC v1 0/1] clipboard sharing implementation for SDL
Date: Wed,  8 Nov 2023 03:21:38 +0100
Message-ID: <20231108022139.12503-1-admin@xutaxkamay.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=82.65.208.52; envelope-from=admin@xutaxkamay.com;
 helo=xutaxkamay.com
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_PBL=3.335,
 RCVD_IN_SORBS_DUL=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 08 Nov 2023 10:54:34 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hello,

This is my first try contributing to QEMU,
and I would like some advices before merging my patch into master branch.

Current implementation works with qemu-vdagent character device.
I decided to ignore QemuClipboardPeer's request function pointer
for my current implementation because I couldn't get any clipboard
requests from the host with,
so instead I've decided to use SDL event loop with SDL_CLIPBOARDUPDATE
and handle the request from here.
I suppose this is the normal behavior, but since I'm not entirely
sure I would like some confirmation or advices about it.

I'm getting also a wanring from the scripts/checkpatch.pl
since I've added a c file for the implementation,
it asks me to update MAINTAINERS, I would gladly put myself here
but I think this decision shouldn't be taken by me.

I'm also up to any corrections if there's errors or something you want
to change in the code.

Thank you.

Kamay Xutax (1):
  ui/sdl2: clipboard sharing implementation for SDL

 include/ui/sdl2.h   |   5 ++
 meson.build         |   1 +
 ui/meson.build      |   1 +
 ui/sdl2-clipboard.c | 147 ++++++++++++++++++++++++++++++++++++++++++++
 ui/sdl2.c           |   8 +++
 5 files changed, 162 insertions(+)
 create mode 100644 ui/sdl2-clipboard.c

-- 
2.41.0


