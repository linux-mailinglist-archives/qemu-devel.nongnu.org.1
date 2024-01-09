Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 071D0828169
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 09:31:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN7Vn-00042b-TR; Tue, 09 Jan 2024 03:31:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1rN7Vh-0003ua-I5; Tue, 09 Jan 2024 03:30:57 -0500
Received: from zoidberg.rfc1149.net ([195.154.227.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1rN7Vf-0004mz-Tf; Tue, 09 Jan 2024 03:30:57 -0500
Received: from 127.0.0.1 (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by zoidberg.rfc1149.net (Postfix) with ESMTPSA id 4AC0480027;
 Tue,  9 Jan 2024 09:30:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rfc1149.net; s=smtp;
 t=1704789054; bh=PwDUlGVDRbpp2DpJ68zo7HtCdP0SFMmWNO1Zlr4J64s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=pxo1XE5wXObzXXg1loNcc6n8S2FQIcYx3UBDfJtSi1TAT03vH5j2KKYfAU0QzIubf
 kWciuGn76J1TyCTzJI1AuXkMNpSDbt7JWZPgcUHM7sgX39b49RAUgF1l//Er66C0mX
 O/9sqLAdWUoQARzXhFgQBqKGqzrEl+wT932qV5vL9GrHwHq8r1DOWe+hl9VTwThtUE
 xE3ZvoUcTPIv1rC3/Hmvh9I1bdeKQke7QBLUEMr4CGDAw7U0IjxeE5I8H3d3upQheJ
 dVkEOU4AByarr5yNE8Dv62A6ImZQYnOXeKgG3fQa4TKcQF+ShxzqbejTun8jbJwlfz
 XbmOQSM4kEUsA==
From: Samuel Tardieu <sam@rfc1149.net>
To: qemu-devel@nongnu.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Hanna Reitz <hreitz@redhat.com>,
 devel@lists.libvirt.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Samuel Tardieu <sam@rfc1149.net>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 2/2] hw/block: Deprecate the TC58128 block device
Date: Tue,  9 Jan 2024 09:30:53 +0100
Message-ID: <20240109083053.2581588-3-sam@rfc1149.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240109083053.2581588-1-sam@rfc1149.net>
References: <20240109083053.2581588-1-sam@rfc1149.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.154.227.159; envelope-from=sam@rfc1149.net;
 helo=zoidberg.rfc1149.net
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

The 16MiB flash device is only used by the deprecated shix machine.
Its code it old and unmaintained, and has never been adapted to the
QOM architecture. It still contains debug statements and uses global
variables. It is time to deprecate it.

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 docs/about/deprecated.rst | 2 +-
 hw/block/tc58128.c        | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index e6a12c9077..15e39f8bbb 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -273,7 +273,7 @@ The Nios II architecture is orphan.
 ''''''''''''''''''''
 
 The machine is no longer in existence and has been long unmaintained
-in QEMU.
+in QEMU. This also holds for the TC51828 16MiB flash that it uses.
 
 Backend options
 ---------------
diff --git a/hw/block/tc58128.c b/hw/block/tc58128.c
index d350126b27..6944cf58fa 100644
--- a/hw/block/tc58128.c
+++ b/hw/block/tc58128.c
@@ -202,6 +202,7 @@ static sh7750_io_device tc58128 = {
 
 int tc58128_init(struct SH7750State *s, const char *zone1, const char *zone2)
 {
+    warn_report_once("The TC58128 flash device is deprecated");
     init_dev(&tc58128_devs[0], zone1);
     init_dev(&tc58128_devs[1], zone2);
     return sh7750_register_io_device(s, &tc58128);
-- 
2.42.0


