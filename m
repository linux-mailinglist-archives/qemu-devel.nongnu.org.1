Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 771DCAD3F9C
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Jun 2025 18:54:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP26v-0001r0-ER; Tue, 10 Jun 2025 12:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uP02O-0002AT-CW
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 10:33:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uP02M-00060N-Cl
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 10:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749565993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OGGjWV/AnA2+8v3700Mtz6kS/vWJbya6CYmVChAkRJI=;
 b=hy8ybPgLAHkrLcKXD1GSGwypQwtSxvKZG3ZVdqOrTMdFExytsdUlvr9etMw/hwZ/YgkJjG
 hjFPoEoVs5jehejzsNa0ywKBlP+jNK/L+mONVtzmG8EyrNBC4VQEjoOpl9JR65eczPyvE8
 fNLDK/oat+PoXczVIUACQ4ql8Q2bn/Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-szl0iZfBMFy-oJasQho1Vg-1; Tue,
 10 Jun 2025 10:33:10 -0400
X-MC-Unique: szl0iZfBMFy-oJasQho1Vg-1
X-Mimecast-MFC-AGG-ID: szl0iZfBMFy-oJasQho1Vg_1749565987
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EB5E18002E4
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 14:33:07 +0000 (UTC)
Received: from gondolin.str.redhat.com (dhcp-192-216.str.redhat.com
 [10.33.192.216])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 58ACD1956087; Tue, 10 Jun 2025 14:33:06 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org,
	Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 2/2] watchdog: generic name for i6300esb
Date: Tue, 10 Jun 2025 16:32:59 +0200
Message-ID: <20250610143259.1056400-3-cohuck@redhat.com>
In-Reply-To: <20250610143259.1056400-1-cohuck@redhat.com>
References: <20250610143259.1056400-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The Intel 6300 Enterprise SouthBridge is a south bridge for a more or
less obscure embedded Intel system; however, the i6300esb watchdog
device we implement in QEMU is a virtual watchdog device that should
work well on any PCI-based machine, is well supported by Linux guests,
and used in many examples on how to set up a virtual watchdog.

Let's use "virtual i6300ESB" in the description to make clear that
this device will work just fine on non-Intel platforms.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/watchdog/wdt_i6300esb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/watchdog/wdt_i6300esb.c b/hw/watchdog/wdt_i6300esb.c
index bb8a2766b69b..5e5d8c48cfd7 100644
--- a/hw/watchdog/wdt_i6300esb.c
+++ b/hw/watchdog/wdt_i6300esb.c
@@ -472,7 +472,7 @@ static void i6300esb_class_init(ObjectClass *klass, const void *data)
     device_class_set_legacy_reset(dc, i6300esb_reset);
     dc->vmsd = &vmstate_i6300esb;
     set_bit(DEVICE_CATEGORY_WATCHDOG, dc->categories);
-    dc->desc = "Intel 6300ESB";
+    dc->desc = "virtual i6300ESB";
 }
 
 static const TypeInfo i6300esb_info = {
-- 
2.49.0


