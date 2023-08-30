Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC87378D4E8
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 11:48:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbHjF-0007nl-8U; Wed, 30 Aug 2023 05:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHjB-0007LH-8x
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:43:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHj9-00023H-35
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693388586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9bDzHmGv9X4GnRDreCiN5NxDpHzlwJDB1QUhkHJTirQ=;
 b=BdL+okN5s8Vv72d+uIv7bXEgvD1YgwPTILmE2bfACmt4sByl8UOUNDYPeMoyzr6WFzymBI
 VW8Ck9IW8Sy8UuFmJzHoMAq9Ppnu7Dxn0JZd0WkUd40bEdhdj9IkhU3srLsT5ITtE8K2Uh
 B5ONBMbXA83LhtyT2rL0+9FW6a565ds=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-7D5FkN1uMk2WvlTKwnCulw-1; Wed, 30 Aug 2023 05:43:04 -0400
X-MC-Unique: 7D5FkN1uMk2WvlTKwnCulw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3583C3C100B0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 09:43:04 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C2C3C15BAE;
 Wed, 30 Aug 2023 09:43:03 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 65/67] ppc/kconfig: make SAM460EX depend on PPC & PIXMAN
Date: Wed, 30 Aug 2023 13:38:39 +0400
Message-ID: <20230830093843.3531473-66-marcandre.lureau@redhat.com>
In-Reply-To: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

SM501 is going to depend on PIXMAN next.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 configs/devices/ppc-softmmu/default.mak | 2 +-
 hw/ppc/Kconfig                          | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/configs/devices/ppc-softmmu/default.mak b/configs/devices/ppc-softmmu/default.mak
index a887f5438b..603ed701ed 100644
--- a/configs/devices/ppc-softmmu/default.mak
+++ b/configs/devices/ppc-softmmu/default.mak
@@ -8,7 +8,7 @@ CONFIG_PPC440=y
 CONFIG_VIRTEX=y
 
 # For Sam460ex
-CONFIG_SAM460EX=y
+#CONFIG_SAM460EX=n
 
 # For Macs
 CONFIG_MAC_OLDWORLD=y
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 5dfbf47ef5..86d3f5cfca 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -58,6 +58,8 @@ config PPC4XX
 
 config SAM460EX
     bool
+    default y
+    depends on PPC && PIXMAN
     select PFLASH_CFI01
     select IDE_SII3112
     select M41T80
-- 
2.41.0


