Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D408E98CE95
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Oct 2024 10:17:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svuX5-00029i-GK; Wed, 02 Oct 2024 04:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1svuWv-00029S-NP
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 04:16:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1svuWu-0003MI-7Y
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 04:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727856975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=RJin89XPIXkmM1E4OIXhKKg8uHQjwGmSKJcPoEppeOU=;
 b=BNxVIDvPjSEyYlwuhFO04QYk+KLX5BSO9kfjQMOqiPduMAIDMSWxmn8t/iJmNLIhCe5Oe/
 LMpNf9GPgSm44Gl+1MkZuCDeHs90sdjk/o/+SpESAJprUKkH+1nw+nxxaG6wzq0mc6gHfo
 Y0U3fJ92GDPBpmZ4vJ4/LXUXpLGhzEk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-W3-vnt6KM1me9RLXZerlbw-1; Wed,
 02 Oct 2024 04:16:12 -0400
X-MC-Unique: W3-vnt6KM1me9RLXZerlbw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CAABA19560A5; Wed,  2 Oct 2024 08:16:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.47])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6117F3000198; Wed,  2 Oct 2024 08:16:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EC05621E6A28; Wed,  2 Oct 2024 10:16:07 +0200 (CEST)
Resent-To: peter.maydell@linaro.org, philmd@linaro.org, qemu-devel@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Wed, 02 Oct 2024 10:16:07 +0200
Resent-Message-ID: <87ttdu6htk.fsf@pond.sub.org>
X-From-Line: armbru@redhat.com  Wed Oct  2 09:44:04 2024
X-Original-To: armbru
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E149D21E688F; Wed,  2 Oct 2024 09:44:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 05/10] qapi/pci: Supply missing member documentation
Date: Wed,  2 Oct 2024 09:43:59 +0200
Message-ID: <20241002074404.1983368-6-armbru@redhat.com>
In-Reply-To: <20241002074404.1983368-1-armbru@redhat.com>
References: <20241002074404.1983368-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Lines: 42
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Since we neglect to document a member of PciMemoryRegion, its
description in the QEMU QMP Reference manual is "Not documented".  Fix
that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240911112545.2248881-6-armbru@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 qapi/pci.json    | 2 ++
 qapi/pragma.json | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/qapi/pci.json b/qapi/pci.json
index 78bee57b77..dc85a41d28 100644
--- a/qapi/pci.json
+++ b/qapi/pci.json
@@ -33,6 +33,8 @@
 #     - 'io' if the region is a PIO region
 #     - 'memory' if the region is a MMIO region
 #
+# @address: memory address
+#
 # @size: memory size
 #
 # @prefetch: if @type is 'memory', true if the memory is prefetchable
diff --git a/qapi/pragma.json b/qapi/pragma.json
index 7b0e12f42b..baeae5bf52 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -62,7 +62,6 @@
         'MemoryDeviceInfoKind',
         'NetClientDriver',
         'ObjectType',
-        'PciMemoryRegion',
         'QCryptodevBackendServiceType',
         'QKeyCode',
         'RbdAuthMode',
-- 
2.46.0



