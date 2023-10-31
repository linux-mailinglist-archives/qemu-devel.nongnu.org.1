Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAFB7DCB83
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 12:12:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxmeN-00041r-Kn; Tue, 31 Oct 2023 07:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qxmeL-0003xy-1Z
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 07:11:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qxmeJ-0006x8-4c
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 07:11:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698750665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/TLFhjLO9qG6HkbgDfhKSNWE9boy2U4CZ8WY0rw5Ee4=;
 b=d+R5EytC/d9fNfjbwgGwXE0V5cSTvfeDGnGoeTGr8IyG6gA9qYXcrqbyzPNACE1OxHQnSC
 dJ55G7FtSb54j/l/hUTk9ty7sWc5J/Q7CuGOOu8UP4PAcVZTvE2RcsJGMxs32TnTf/BVVR
 CSHr3W3aKnI1PK93wpnGoifnJe7wtPE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-wXMuqq-fMD2jOVWuGFoanQ-1; Tue, 31 Oct 2023 07:11:02 -0400
X-MC-Unique: wXMuqq-fMD2jOVWuGFoanQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 704B18820C3;
 Tue, 31 Oct 2023 11:11:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EC1D51C060B1;
 Tue, 31 Oct 2023 11:11:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E0B9B21E6A26; Tue, 31 Oct 2023 12:10:59 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, npiggin@gmail.com, danielhb413@gmail.com, clg@kaod.org,
 david@gibson.dropbear.id.au, harshpb@linux.ibm.com, dave@treblig.org,
 jasowang@redhat.com, michael.roth@amd.com, kkostiuk@redhat.com,
 mst@redhat.com, david@redhat.com, kraxel@redhat.com,
 marcandre.lureau@redhat.com, qemu-ppc@nongnu.org
Subject: [PATCH 1/7] spapr/pci: Correct "does not support hotplugging error
 messages
Date: Tue, 31 Oct 2023 12:10:53 +0100
Message-ID: <20231031111059.3407803-2-armbru@redhat.com>
In-Reply-To: <20231031111059.3407803-1-armbru@redhat.com>
References: <20231031111059.3407803-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

When dynamic-reconfiguration is off, hot plug / unplug can fail with
"Bus 'spapr-pci-host-bridge' does not support hotplugging".
spapr-pci-host-bridge is a device, not a bus.  Report the name of the
bus it provides instead: 'pci.0'.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/ppc/spapr_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 370c5a90f2..ebb32ad90b 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1551,7 +1551,7 @@ static void spapr_pci_pre_plug(HotplugHandler *plug_handler,
          */
         if (plugged_dev->hotplugged) {
             error_setg(errp, QERR_BUS_NO_HOTPLUG,
-                       object_get_typename(OBJECT(phb)));
+                       phb->parent_obj.bus->qbus.name);
             return;
         }
     }
@@ -1672,7 +1672,7 @@ static void spapr_pci_unplug_request(HotplugHandler *plug_handler,
 
     if (!phb->dr_enabled) {
         error_setg(errp, QERR_BUS_NO_HOTPLUG,
-                   object_get_typename(OBJECT(phb)));
+                   phb->parent_obj.bus->qbus.name);
         return;
     }
 
-- 
2.41.0


