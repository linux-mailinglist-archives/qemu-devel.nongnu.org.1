Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED7A827627
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 18:17:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMtEu-0000tN-FD; Mon, 08 Jan 2024 12:16:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1rMtDq-0008NS-45; Mon, 08 Jan 2024 12:15:36 -0500
Received: from zoidberg.rfc1149.net ([195.154.227.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1rMtDm-0008GU-Ow; Mon, 08 Jan 2024 12:15:33 -0500
Received: from 127.0.0.1 (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by zoidberg.rfc1149.net (Postfix) with ESMTPSA id 0008280029;
 Mon,  8 Jan 2024 18:15:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rfc1149.net; s=smtp;
 t=1704734124; bh=JPKVhzhyPmGUf5AXgWgYQCprGi/I2YKo2RiNPs8vaeI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Z1rU1KAIVrSwtjkeCu2G5nmmlzPh4vp3Z6gRVbdzaXvp+pnD8pUQvrHaIl4mqNlZ2
 2WYE8xgUmCGsrSSDBxvDpnxhVYvZ+a7YyQnX6YswnFPO45q99O6dvbeqgt1ni64wsc
 ZW+4gp74M+tvWsP8spptHgaCd6k28QWGl+aZcpJYdBQvUlfNitGWZjqded/0xY7RFv
 gA5BTSn7uabfdj6/fJpx4/FJ1N5gOW4qjYnmpcky8QsqBSaDAlfrT1uTICrXhRrk7n
 AZQYdocb9yuyLyw48wuslq2zYlLKhZFqXapeHt4YePAgF1gWzhgvC+HWmpGqwEoRis
 3mYwdLOi1L6Rw==
From: Samuel Tardieu <sam@rfc1149.net>
To: qemu-devel@nongnu.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, devel@lists.libvirt.org,
 qemu-block@nongnu.org, Samuel Tardieu <sam@rfc1149.net>
Subject: [PATCH 2/2] hw/block: Deprecate the TC58128 block device
Date: Mon,  8 Jan 2024 18:15:22 +0100
Message-ID: <20240108171523.2487291-3-sam@rfc1149.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240108171523.2487291-1-sam@rfc1149.net>
References: <20240108171523.2487291-1-sam@rfc1149.net>
MIME-Version: 1.0
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
index d350126b27..354c13ccf0 100644
--- a/hw/block/tc58128.c
+++ b/hw/block/tc58128.c
@@ -202,6 +202,7 @@ static sh7750_io_device tc58128 = {
 
 int tc58128_init(struct SH7750State *s, const char *zone1, const char *zone2)
 {
+    warn_report_once("The TC58128 flash device is deprecated - use a newer component");
     init_dev(&tc58128_devs[0], zone1);
     init_dev(&tc58128_devs[1], zone2);
     return sh7750_register_io_device(s, &tc58128);
-- 
2.42.0


