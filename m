Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5F3A98165
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Apr 2025 09:42:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Uf0-000399-9W; Wed, 23 Apr 2025 03:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7Uet-00035r-TD
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:36:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7Uer-0003D5-Ks
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745393796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BZ/eXcpCCsGiVTk4N5coU9eooUkh5nCsv6FjPS3I6To=;
 b=CzAWrfnHzbrt7lO+y9nMDt4zhFI5nFGo0sa7sp7HcCK0or3jg564ZQ4PT96rrOiK0N1IEw
 wK7t9U8N+v3nMxxW3P4ply1njMyeQ+4jE9s24gR4BMy9bcRc/7xlht92EuR/icOFSptNPU
 8eZAeeTaFCcNqF2filpoQE6LjwVRU8A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-KphQ_9pFNX6U97b4_WrgIw-1; Wed,
 23 Apr 2025 03:36:32 -0400
X-MC-Unique: KphQ_9pFNX6U97b4_WrgIw-1
X-Mimecast-MFC-AGG-ID: KphQ_9pFNX6U97b4_WrgIw_1745393791
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 83366180034A; Wed, 23 Apr 2025 07:36:31 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-219.str.redhat.com
 [10.33.192.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 79D331955BCB; Wed, 23 Apr 2025 07:36:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 07/29] hw/s390x/ccw: Have CCW machine implement a
 qmp_dump_skeys() callback
Date: Wed, 23 Apr 2025 09:35:47 +0200
Message-ID: <20250423073610.271585-8-thuth@redhat.com>
In-Reply-To: <20250423073610.271585-1-thuth@redhat.com>
References: <20250423073610.271585-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

In preparation to make @dump-skeys command generic,
extract s390_qmp_dump_skeys() out of qmp_dump_skeys().
Register it as CCW qmp_dump_skeys() callback.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Message-ID: <20250310151414.11550-4-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/s390x/storage-keys.h | 1 +
 hw/s390x/s390-skeys.c           | 7 ++++++-
 hw/s390x/s390-virtio-ccw.c      | 3 +++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/hw/s390x/storage-keys.h b/include/hw/s390x/storage-keys.h
index fb766d4631b..ac303001f57 100644
--- a/include/hw/s390x/storage-keys.h
+++ b/include/hw/s390x/storage-keys.h
@@ -122,6 +122,7 @@ int s390_skeys_set(S390SKeysState *ks, uint64_t start_gfn,
 
 S390SKeysState *s390_get_skeys_device(void);
 
+void s390_qmp_dump_skeys(const char *filename, Error **errp);
 void hmp_dump_skeys(Monitor *mon, const QDict *qdict);
 void hmp_info_skeys(Monitor *mon, const QDict *qdict);
 
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index 0d3d4f74b4c..fd1123b0f35 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -142,7 +142,7 @@ void hmp_dump_skeys(Monitor *mon, const QDict *qdict)
     }
 }
 
-void qmp_dump_skeys(const char *filename, Error **errp)
+void s390_qmp_dump_skeys(const char *filename, Error **errp)
 {
     S390SKeysState *ss = s390_get_skeys_device();
     S390SKeysClass *skeyclass = S390_SKEYS_GET_CLASS(ss);
@@ -219,6 +219,11 @@ out:
     fclose(f);
 }
 
+void qmp_dump_skeys(const char *filename, Error **errp)
+{
+    s390_qmp_dump_skeys(filename, errp);
+}
+
 static bool qemu_s390_skeys_are_enabled(S390SKeysState *ss)
 {
     QEMUS390SKeysState *skeys = QEMU_S390_SKEYS(ss);
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 72de2bd8dc9..910dab08319 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -810,6 +810,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
     NMIClass *nc = NMI_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
     S390CcwMachineClass *s390mc = S390_CCW_MACHINE_CLASS(mc);
+    DumpSKeysInterface *dsi = DUMP_SKEYS_INTERFACE_CLASS(oc);
 
     s390mc->hpage_1m_allowed = true;
     s390mc->max_threads = 1;
@@ -835,6 +836,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
     nc->nmi_monitor_handler = s390_nmi;
     mc->default_ram_id = "s390.ram";
     mc->default_nic = "virtio-net-ccw";
+    dsi->qmp_dump_skeys = s390_qmp_dump_skeys;
 
     object_class_property_add_bool(oc, "aes-key-wrap",
                                    machine_get_aes_key_wrap,
@@ -876,6 +878,7 @@ static const TypeInfo ccw_machine_info = {
     .interfaces = (InterfaceInfo[]) {
         { TYPE_NMI },
         { TYPE_HOTPLUG_HANDLER},
+        { TYPE_DUMP_SKEYS_INTERFACE},
         { }
     },
 };
-- 
2.49.0


