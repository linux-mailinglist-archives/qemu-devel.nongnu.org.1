Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D419F2E8A
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Dec 2024 11:52:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN8h6-0004Mf-2V; Mon, 16 Dec 2024 05:51:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tN8gz-0004J3-Vu
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 05:51:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tN8gy-0005Py-Iz
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 05:51:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734346271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WIYH6Sp+EN+igKgwxxY7yhzZhTsHqtzJmu4iOlR0uU8=;
 b=gSM+WyP23EcXkpg74g1SKnfOk5GU9wNwurL/nIT5PoRZYFFEyg4NCTJOCycbd2T+f6tHVU
 S3xNiVJkYi7zLb6iGFnJO4chvH5EVxeZHpmeedid31SI0e3Y7MtMHnrH6aJyHqcyS+nvYk
 H93JKvkJ8I0FHUZHBxfe57OpIu33VXM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-bqfmX50PMByzmNuKos8yRQ-1; Mon,
 16 Dec 2024 05:51:07 -0500
X-MC-Unique: bqfmX50PMByzmNuKos8yRQ-1
X-Mimecast-MFC-AGG-ID: bqfmX50PMByzmNuKos8yRQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4C6419560A6; Mon, 16 Dec 2024 10:51:05 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.88])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E94E195605A; Mon, 16 Dec 2024 10:51:05 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0D94318003BB; Mon, 16 Dec 2024 11:50:54 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
Subject: [PULL 5/7] pc-bios: Add amd-sev-es to edk2 json
Date: Mon, 16 Dec 2024 11:50:51 +0100
Message-ID: <20241216105053.246204-6-kraxel@redhat.com>
In-Reply-To: <20241216105053.246204-1-kraxel@redhat.com>
References: <20241216105053.246204-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.168,
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

From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>

With the default BIOS being compatible with amd-sev-es add the feature
to the json to indicate it's support

Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
Message-ID: <20241118161405.208437-1-pratikrajesh.sampat@amd.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 pc-bios/descriptors/60-edk2-x86_64.json | 1 +
 1 file changed, 1 insertion(+)

diff --git a/pc-bios/descriptors/60-edk2-x86_64.json b/pc-bios/descriptors/60-edk2-x86_64.json
index 968cb65cf973..4599c63f14ec 100644
--- a/pc-bios/descriptors/60-edk2-x86_64.json
+++ b/pc-bios/descriptors/60-edk2-x86_64.json
@@ -26,6 +26,7 @@
     "features": [
         "acpi-s3",
         "amd-sev",
+        "amd-sev-es",
         "verbose-dynamic"
     ],
     "tags": [
-- 
2.47.1


