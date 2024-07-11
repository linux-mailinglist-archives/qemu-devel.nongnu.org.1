Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5E392E678
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jul 2024 13:24:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRrsy-00020R-Qw; Thu, 11 Jul 2024 07:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sRrsw-0001xO-Jx
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 07:22:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sRrsk-0000Hl-Nx
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 07:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720696956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=viR0ny/v2bN0I/B3BRJxlIFosN9ydnJSUgBurjxml5M=;
 b=VIBj34LNF5HMKJHrJkg0aIoYqOtlfRAOGd9DCQZoHn8+dz8tnIy0O3/KNJGd4RPzZ/YJLy
 v3cxGTEp555PIowcQy3iPGmHDz+X1CliMxiA/G+NAYH8XqADeFD6rWbDgfxWL4oygRb+wS
 6evXD9FU4lvlp5rhqjrwYLJKdRtZFuY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-Bm4MCkjfMniaZp_8NmHIRg-1; Thu,
 11 Jul 2024 07:22:32 -0400
X-MC-Unique: Bm4MCkjfMniaZp_8NmHIRg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 574231956048; Thu, 11 Jul 2024 11:22:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.4])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E3E21955E85; Thu, 11 Jul 2024 11:22:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BD2F621E6697; Thu, 11 Jul 2024 13:22:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, eblake@redhat.com, mst@redhat.com,
 berrange@redhat.com, marcandre.lureau@redhat.com, jsnow@redhat.com,
 imammedo@redhat.com
Subject: [PATCH 1/5] qapi/pci: Clean up documentation around PciDeviceClass
Date: Thu, 11 Jul 2024 13:22:24 +0200
Message-ID: <20240711112228.2140606-2-armbru@redhat.com>
In-Reply-To: <20240711112228.2140606-1-armbru@redhat.com>
References: <20240711112228.2140606-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

PciDeviceInfo's doc comment has a note on PciDeviceClass member @desc.
Since the note applies always, not just within PciDeviceInfo, merge it
into PciDeviceClass's description of member @desc.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/pci.json | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/qapi/pci.json b/qapi/pci.json
index 8287d15dd0..97179920fb 100644
--- a/qapi/pci.json
+++ b/qapi/pci.json
@@ -93,7 +93,8 @@
 #
 # Information about the Class of a PCI device
 #
-# @desc: a string description of the device's class
+# @desc: a string description of the device's class (not stable, and
+#     should only be treated as informational)
 #
 # @class: the class code of the device
 #
@@ -146,9 +147,6 @@
 #
 # @regions: a list of the PCI I/O regions associated with the device
 #
-# .. note:: The contents of @class_info.desc are not stable and should
-#    only be treated as informational.
-#
 # Since: 0.14
 ##
 { 'struct': 'PciDeviceInfo',
-- 
2.45.0


