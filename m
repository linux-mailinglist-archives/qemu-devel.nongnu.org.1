Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB9F9F4DC1
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Dec 2024 15:31:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNYaa-0001oz-QX; Tue, 17 Dec 2024 09:30:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tNYZO-0000xg-6b
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 09:29:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tNYZM-0004wR-4w
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 09:29:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734445742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FPzOHjVETNGAqdsG7EQpmY5dkKRFCfWVL5M7/yQ1yDY=;
 b=cuNz9yVuRO175sODtCi2LMfvyL4Nw4HIhAK5MeOZNhT7fnd1tgNYFDWkEah2Ge3vCRopn9
 0YCmzBYa4+b2Bbo3qfHcxgJmXpOIw6/LQss+Hnl64Tv7BSWwKMIq20wa7kwFOtS0LZ3zLl
 DVfzFyZNxxFycCqVx2+UWSGNyrnkVHA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-WpNrUqLVOnmqvNvAdPjfNQ-1; Tue,
 17 Dec 2024 09:28:58 -0500
X-MC-Unique: WpNrUqLVOnmqvNvAdPjfNQ-1
X-Mimecast-MFC-AGG-ID: WpNrUqLVOnmqvNvAdPjfNQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9FE7919560A2; Tue, 17 Dec 2024 14:28:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60C1D1955F54; Tue, 17 Dec 2024 14:28:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0D2D921E6605; Tue, 17 Dec 2024 15:28:55 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	berrange@redhat.com,
	eduardo@habkost.net
Subject: [PATCH 2/6] qdev: Change qdev_prop_pci_devfn member @name from
 "int32" to "str"
Date: Tue, 17 Dec 2024 15:28:50 +0100
Message-ID: <20241217142855.3805068-3-armbru@redhat.com>
In-Reply-To: <20241217142855.3805068-1-armbru@redhat.com>
References: <20241217142855.3805068-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

Properties using qdev_prop_pci_devfn initially accepted a string of
the form "DEV.FN" or "DEV" where DEV and FN are in hexadecimal.
Member @name was "pci-devfn" initially.

Commit b403298adb5 (qdev: make the non-legacy pci address property
accept an integer) changed them to additionally accept integers: bits
3..7 are DEV, and bits 0..2 are FN.  This is inaccessible externally
in device_add so far.

The commit also changed @name to "int32", and set member @legacy-name
to "pci-devfn".  Together, this kept QMP command
device-list-properties unaffected: it used @name only when
@legacy_name was null.

Commit 07d09c58dbb (qmp: Print descriptions of object properties)
quietly dumbed that down to use @name always, and the next commit
18b91a3e082q (qdev: Drop legacy_name from qdev properties) dropped
member @legacy_name.  This changed the value of @type reported by QMP
command device-list-properties from "pci-devfn" to "int32".

But "int32" is misleading: device_add actually wants QAPI type "str".
So change @name to that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/core/qdev-properties-system.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 22ea1ed358..3177678861 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -882,7 +882,7 @@ static int print_pci_devfn(Object *obj, Property *prop, char *dest,
 }
 
 const PropertyInfo qdev_prop_pci_devfn = {
-    .name  = "int32",
+    .name  = "str",
     .description = "Slot and optional function number, example: 06.0 or 06",
     .print = print_pci_devfn,
     .get   = qdev_propinfo_get_int32,
-- 
2.47.0


