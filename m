Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77291828160
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 09:31:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN7Vp-00048z-1M; Tue, 09 Jan 2024 03:31:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1rN7Vi-0003uw-LZ; Tue, 09 Jan 2024 03:30:59 -0500
Received: from zoidberg.rfc1149.net ([195.154.227.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1rN7Vg-0004mj-Oo; Tue, 09 Jan 2024 03:30:58 -0500
Received: from 127.0.0.1 (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by zoidberg.rfc1149.net (Postfix) with ESMTPSA id 2921180026;
 Tue,  9 Jan 2024 09:30:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rfc1149.net; s=smtp;
 t=1704789054; bh=EHiQGjec6QFK7MExqkhkOlwjNKmbWP2uDH2Ev+/wKds=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=dbFGZSvI13Ph4XaS4ZyZrxrm0j6VA8RZad82EnjLtKf+TfOqXHmBe2pXV6hlhOvuM
 hDZjlUNJ8GkpYKc8FkVam1woy/LB/Zt3qmB3MijhV0m5nOmjYjw1hnAa7y3wt0RfCi
 ol3lxrdELZzpvqv2oqA1FwFyx4BJH+daN6jZ+y1nWgqwUiFj2OUfZOAkiS1vs+tv9+
 bF29120rLyMFIoZkZ+/bJwkU5d7ylKNIgV5CNp1941vKEJIl9UBG0CxhNCPV7MIoXS
 gIqBaV8w5tBdWj5zgtF01adtNzz+5e1VNhariupwBIYiiNVrB+vghXKKTtcce9/ioz
 YfIIlYvBnhk8g==
From: Samuel Tardieu <sam@rfc1149.net>
To: qemu-devel@nongnu.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Hanna Reitz <hreitz@redhat.com>,
 devel@lists.libvirt.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Samuel Tardieu <sam@rfc1149.net>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 1/2] target/sh4: Deprecate the shix machine
Date: Tue,  9 Jan 2024 09:30:52 +0100
Message-ID: <20240109083053.2581588-2-sam@rfc1149.net>
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

The shix machine has been designed and used at Télécom Paris from 2003
to 2010. It had been added to QEMU in 2005 and has not been maintained
since. Since nobody is using the physical board anymore nor interested
in maintaining the QEMU port, it is time to deprecate it.

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 docs/about/deprecated.rst | 5 +++++
 hw/sh4/shix.c             | 1 +
 2 files changed, 6 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 2e15040246..e6a12c9077 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -269,6 +269,11 @@ Nios II ``10m50-ghrd`` and ``nios2-generic-nommu`` machines (since 8.2)
 
 The Nios II architecture is orphan.
 
+``shix`` (since 9.0)
+''''''''''''''''''''
+
+The machine is no longer in existence and has been long unmaintained
+in QEMU.
 
 Backend options
 ---------------
diff --git a/hw/sh4/shix.c b/hw/sh4/shix.c
index aa812512f0..eb3150b5bc 100644
--- a/hw/sh4/shix.c
+++ b/hw/sh4/shix.c
@@ -80,6 +80,7 @@ static void shix_machine_init(MachineClass *mc)
     mc->init = shix_init;
     mc->is_default = true;
     mc->default_cpu_type = TYPE_SH7750R_CPU;
+    mc->deprecation_reason = "old and unmaintained";
 }
 
 DEFINE_MACHINE("shix", shix_machine_init)
-- 
2.42.0


