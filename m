Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E1C740E99
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 12:24:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qESKx-0000EW-C3; Wed, 28 Jun 2023 06:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan@jankratochvil.net>)
 id 1qESKt-0000EI-Cr
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 06:23:43 -0400
Received: from host1.jankratochvil.net ([2a02:2b88:6:3b57::1f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan@jankratochvil.net>)
 id 1qESKq-0005In-Nq
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 06:23:42 -0400
Received: from host1.jankratochvil.net (localhost [127.0.0.1])
 by host1.jankratochvil.net (8.17.1/8.17.1) with ESMTPS id 35SANZ2s513237
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 12:23:35 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 host1.jankratochvil.net 35SANZ2s513237
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jankratochvil.net;
 s=default; t=1687947815;
 bh=0+VogAgADEYf6af9wO6y/AhSllhiHKKbrQ6NSShq9Nc=;
 h=Date:From:To:Subject:From;
 b=3kpz4u5opEjr/VRjRDfy3hoce3ccIyIw8txRXFLZnQgJhsEoc/K6tITgBZVFlowT3
 iqaNyjU0DvcvApvtNgToNVYnZ9K6nSw6x24HEi67nf4MhkRlqln17L5G4dp8yuEeSI
 TPTBf7qX4oHNUdngZYjx+Qf6ki+8g2CubUMvdsTw=
Received: (from lace@localhost)
 by host1.jankratochvil.net (8.17.1/8.17.1/Submit) id 35SANZYg513236
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 18:23:35 +0800
Date: Wed, 28 Jun 2023 18:23:35 +0800
From: Jan Kratochvil <jan@jankratochvil.net>
To: qemu-devel@nongnu.org
Subject: [patch] trivial: man page: document display::gtk::zoom-to-fit
Message-ID: <ZJwKJ0AFTtx5tR3v@host1.jankratochvil.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.7 (2022-08-07)
Received-SPF: pass client-ip=2a02:2b88:6:3b57::1f;
 envelope-from=jan@jankratochvil.net; helo=host1.jankratochvil.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Document display::gtk::zoom-to-fit.

info from: https://superuser.com/questions/1752209/qemu-zoom-to-fit-shortcut-or-cli-switch

Signed-off-by: Jan Kratochvil <jan@jankratochvil.net>

diff --git a/qemu-options.hx b/qemu-options.hx
index 88e93c6103..90acb31056 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2071,6 +2071,9 @@ SRST
         ``window-close=on|off`` : Allow to quit qemu with window close button
 
         ``show-menubar=on|off`` : Display the main window menubar, defaults to "on"
+
+        ``zoom-to-fit=on|off`` : Expand video output to the window size,
+                                 defaults to "off"
 
     ``curses[,charset=<encoding>]``
         Display video output via curses. For graphics device models

