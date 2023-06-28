Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19795741651
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 18:27:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEY0F-00031c-Bk; Wed, 28 Jun 2023 12:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anton.kochkov@proton.me>)
 id 1qEY07-0002xy-Dl
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 12:26:39 -0400
Received: from mail-40134.protonmail.ch ([185.70.40.134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anton.kochkov@proton.me>)
 id 1qEY05-0005ah-Pm
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 12:26:39 -0400
Date: Wed, 28 Jun 2023 16:26:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1687969595; x=1688228795;
 bh=YTHGwutzeM+eVoKJRrhQxHJXdTuUQEKkOF6ZSxkfavo=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=Dq3sWjOGEPqAYVfGHWei4HAI9nGLcUQPTmaIWUAbda8xNmWibjxxfJLhGrqWkOuX+
 J0Rc7FHouyuWOBqPsTrii4+tsxwAO3IgL4mrCSQ7ZjHWmRw322UzE2llujdNGweAN8
 tqPb48oqAZi/ifKDyFzhoUSafhJwTI7c74OL3xm6aHdr3S/mTUsHDp+DEv34tTtimV
 BxDf4AhUzy3vTzPB197p7foMUFBczQ5LWvLc10iVcdonc2El1HcrvUCs+vAQKC2iGy
 t0IK79qpTaxgXEzSmeznfTRULuJZ4ixZiaHOINX7Lpiw+8bmNUmv1lvQeujsWfThZo
 +qrR2SkIbbo4Q==
To: qemu-devel@nongnu.org
From: Anton Kochkov <anton.kochkov@proton.me>
Cc: Anton Kochkov <anton.kochkov@proton.me>
Subject: [PATCH v2 2/2] contrib/plugins: remove Makefile
Message-ID: <20230628162451.147419-3-anton.kochkov@proton.me>
In-Reply-To: <20230628162451.147419-1-anton.kochkov@proton.me>
References: <20230628162451.147419-1-anton.kochkov@proton.me>
Feedback-ID: 53490844:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.40.134;
 envelope-from=anton.kochkov@proton.me; helo=mail-40134.protonmail.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

Signed-off-by: Anton Kochkov <anton.kochkov@proton.me>
---
 contrib/plugins/Makefile | 46 ----------------------------------------
 1 file changed, 46 deletions(-)
 delete mode 100644 contrib/plugins/Makefile

diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
deleted file mode 100644
index b2b9db9f51..0000000000
--- a/contrib/plugins/Makefile
+++ /dev/null
@@ -1,46 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# This Makefile example is fairly independent from the main makefile
-# so users can take and adapt it for their build. We only really
-# include config-host.mak so we don't have to repeat probing for
-# programs that the main configure has already done for us.
-#
-
-BUILD_DIR :=3D $(CURDIR)/../..
-
-include $(BUILD_DIR)/config-host.mak
-
-VPATH +=3D $(SRC_PATH)/contrib/plugins
-
-NAMES :=3D
-NAMES +=3D execlog
-NAMES +=3D hotblocks
-NAMES +=3D hotpages
-NAMES +=3D howvec
-NAMES +=3D lockstep
-NAMES +=3D hwprofile
-NAMES +=3D cache
-NAMES +=3D drcov
-
-SONAMES :=3D $(addsuffix .so,$(addprefix lib,$(NAMES)))
-
-# The main QEMU uses Glib extensively so it's perfectly fine to use it
-# in plugins (which many example do).
-CFLAGS :=3D $(shell $(PKG_CONFIG) --cflags glib-2.0)
-CFLAGS +=3D -fPIC -Wall
-CFLAGS +=3D $(if $(CONFIG_DEBUG_TCG), -ggdb -O0)
-CFLAGS +=3D -I$(SRC_PATH)/include/qemu
-
-all: $(SONAMES)
-
-%.o: %.c
-=09$(CC) $(CFLAGS) -c -o $@ $<
-
-lib%.so: %.o
-=09$(CC) -shared -Wl,-soname,$@ -o $@ $^ $(LDLIBS)
-
-clean:
-=09rm -f *.o *.so *.d
-=09rm -Rf .libs
-
-.PHONY: all clean
--
2.41.0



