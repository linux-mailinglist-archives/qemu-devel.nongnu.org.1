Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8983982B3A2
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 18:05:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNyQm-0004BB-K2; Thu, 11 Jan 2024 12:01:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNyQe-0003zr-P2
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 12:01:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNyQd-0003iq-1V
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 12:01:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704992473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d8cb0BzMvSNrKKGB2firgofzOdxv5P92jVnpiy2Q61M=;
 b=EwN6MYmD7U1qkd/rFxZOEHZX/IxKQ5n+vquZrB/RFAeMw6S9jXQ1gKyeiHGHunQ48nEuTT
 8o/nS8QNFpTZ6RScylAv6NSewixXPKt7xPFepJsdpVyomHLFbWkux4L/vcDO5Fkg8t32H3
 2kay9zCO7v5GIGDPPPu0mkflPH1UFP4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-ynJs8SvJMOKli_TBxHRDYw-1; Thu, 11 Jan 2024 12:01:08 -0500
X-MC-Unique: ynJs8SvJMOKli_TBxHRDYw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AFA2C108BF33;
 Thu, 11 Jan 2024 17:01:05 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8AC9D51D5;
 Thu, 11 Jan 2024 17:01:04 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Samuel Tardieu <sam@rfc1149.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/17] tests/qtest/virtio-ccw: Fix device presence checking
Date: Thu, 11 Jan 2024 18:00:38 +0100
Message-ID: <20240111170047.909117-10-thuth@redhat.com>
In-Reply-To: <20240111170047.909117-1-thuth@redhat.com>
References: <20240111170047.909117-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Samuel Tardieu <sam@rfc1149.net>

An apparent copy-paste error tests for the presence of the
virtio-rng-ccw device in order to perform tests on the virtio-scsi-ccw
device.

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
Message-ID: <20240106130121.1244993-1-sam@rfc1149.net>
Fixes: 65331bf5d1 ("tests/qtest: Check for virtio-ccw devices before  using them")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/virtio-ccw-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/virtio-ccw-test.c b/tests/qtest/virtio-ccw-test.c
index f4f5858b84..7a5357c212 100644
--- a/tests/qtest/virtio-ccw-test.c
+++ b/tests/qtest/virtio-ccw-test.c
@@ -85,7 +85,7 @@ int main(int argc, char **argv)
     if (qtest_has_device("virtio-rng-ccw")) {
         qtest_add_func("/virtio/rng/nop", virtio_rng_nop);
     }
-    if (qtest_has_device("virtio-rng-ccw")) {
+    if (qtest_has_device("virtio-scsi-ccw")) {
         qtest_add_func("/virtio/scsi/nop", virtio_scsi_nop);
         qtest_add_func("/virtio/scsi/hotplug", virtio_scsi_hotplug);
     }
-- 
2.43.0


