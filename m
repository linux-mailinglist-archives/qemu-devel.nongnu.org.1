Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA90B1FAFC
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Aug 2025 18:04:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ul8UZ-0001RS-H0; Sun, 10 Aug 2025 12:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ul8UR-0001MD-Em
 for qemu-devel@nongnu.org; Sun, 10 Aug 2025 12:01:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ul8UP-0008L1-UH
 for qemu-devel@nongnu.org; Sun, 10 Aug 2025 12:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754841701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=26yOYfRuSFtyz66jc7EJXKi2le0LA0hcVyp5ehTF0ZA=;
 b=hZAQUFR2xehQuqscyWvlJ6HQ/Zb6JkhaGHwt7hJqzQ2HweUdBnO3kbyhErjVqnGPTyCGMX
 d2iKpxQILh7tpcUcQq3XOlNa06QOFxaDtXCYrV92vmt1FmL+RQEatlP7YOm4jaQsX3RXSi
 1V7toM3S7V/2NhvOQdO1QRo0dR7uJbo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-wHoVT9GaPLGV5hKz31yKyQ-1; Sun,
 10 Aug 2025 12:01:31 -0400
X-MC-Unique: wHoVT9GaPLGV5hKz31yKyQ-1
X-Mimecast-MFC-AGG-ID: wHoVT9GaPLGV5hKz31yKyQ_1754841690
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D1911800359; Sun, 10 Aug 2025 16:01:30 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.11])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 204CB3001455; Sun, 10 Aug 2025 16:01:28 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 3/3] vfio: Document 'use-legacy-x86-rom' property
Date: Sun, 10 Aug 2025 18:01:18 +0200
Message-ID: <20250810160118.450430-4-clg@redhat.com>
In-Reply-To: <20250810160118.450430-1-clg@redhat.com>
References: <20250810160118.450430-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Commit 350785d41d8b ("ramfb: Add property to control if load the
romfile") introduced the `use-legacy-x86-rom` property for the
`vfio-pci-nohotplug` device. Add documentation for the property.

Fixes: d5fcf0d960d8 ("hw/i386: Add the ramfb romfile compatibility")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20250805065543.120091-1-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index d5ea4a5a8341c10abbcd1d3892b6add01efbd880..07257d0fa049b09fc296ac2279a6fafbdf93d277 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3901,6 +3901,9 @@ static void vfio_pci_nohotplug_dev_class_init(ObjectClass *klass,
                                           "x-ramfb-migrate",
                                           "Override default migration support for ramfb support "
                                           "(DEBUG)");
+    object_class_property_set_description(klass, /* 10.1 */
+                                          "use-legacy-x86-rom",
+                                          "Controls loading of a legacy VGA BIOS ROM");
 }
 
 static const TypeInfo vfio_pci_nohotplug_dev_info = {
-- 
2.50.1


