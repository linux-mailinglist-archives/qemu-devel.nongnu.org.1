Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D14E98CEDA
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Oct 2024 10:37:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svur9-00016A-7s; Wed, 02 Oct 2024 04:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1svur7-000162-I4
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 04:37:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1svur6-0005fL-5k
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 04:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727858227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SqNBt+U5WXfjV8ANAT5H4qqOi6cJpF903jrqT6hq03c=;
 b=KVHnxoNMi0dpKHuJ4YDrq+GlBLKJxohtwiESeAMJ6coD9xDTGfjDTXi9iKdlVabr6hv94y
 MfmZG1lGCd0sZWD0LNzpsaexDtNvb5E3hS0eAyXnoDsaT3Dy8gXGQliWcng+oOADHbEfd5
 jykWC9A9BZODZDVjXThxn3mWc7vbBnU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-5zRzRiuKOguxnYfjXHqIBg-1; Wed,
 02 Oct 2024 04:37:05 -0400
X-MC-Unique: 5zRzRiuKOguxnYfjXHqIBg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE851195423A; Wed,  2 Oct 2024 08:37:04 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 937391956056; Wed,  2 Oct 2024 08:37:03 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 03/22] hw/qxl: fix -Werror=maybe-uninitialized false-positives
Date: Wed,  2 Oct 2024 12:36:26 +0400
Message-ID: <20241002083646.2893078-4-marcandre.lureau@redhat.com>
In-Reply-To: <20241002083646.2893078-1-marcandre.lureau@redhat.com>
References: <20241002083646.2893078-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

../hw/display/qxl.c:1352:5: error: ‘pci_region’ may be used uninitialized [-Werror=maybe-uninitialized]
../hw/display/qxl.c:1365:22: error: ‘pci_start’ may be used uninitialized [-Werror=maybe-uninitialized]

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/display/qxl.c | 4 ++--
 roms/openbios    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 3c2b5182ca..0c4b1c9bf2 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -1301,8 +1301,8 @@ static int qxl_add_memslot(PCIQXLDevice *d, uint32_t slot_id, uint64_t delta,
     };
     uint64_t guest_start;
     uint64_t guest_end;
-    int pci_region;
-    pcibus_t pci_start;
+    int pci_region = -1;
+    pcibus_t pci_start = PCI_BAR_UNMAPPED;
     pcibus_t pci_end;
     MemoryRegion *mr;
     intptr_t virt_start;
diff --git a/roms/openbios b/roms/openbios
index c3a19c1e54..af97fd7af5 160000
--- a/roms/openbios
+++ b/roms/openbios
@@ -1 +1 @@
-Subproject commit c3a19c1e54977a53027d6232050e1e3e39a98a1b
+Subproject commit af97fd7af5e7c18f591a7b987291d3db4ffb28b5
-- 
2.45.2.827.g557ae147e6


