Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB837C7077
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 16:40:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqwoL-0002fU-OZ; Thu, 12 Oct 2023 10:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qqwoI-0002dD-Gr
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:37:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qqwoG-0005ew-5K
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697121427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/nYgaaLFdbl1Rxl5YYAwir4mGahnXoDTpBCl/4vbUwI=;
 b=FXbAG8BQzmp049canvFzcIm5ZFAGiKq3Uu1C7yFmFrIisbgICgCd1TJ39OLU7c7TJXin3W
 OZGoZUkMZZVu5CUsi/0i3l8XBnCGrPMiJ00xCc5PJpbLxlFT2DKSdJCscmrnwvDSqAOBhP
 RAl3AcNAfWGccK06hPiYuLmppOPm87s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-354-aOHSBBuuMxCFvOMf9sv_oQ-1; Thu, 12 Oct 2023 10:37:05 -0400
X-MC-Unique: aOHSBBuuMxCFvOMf9sv_oQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6DF3C28AC1D2;
 Thu, 12 Oct 2023 14:37:05 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.176])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F4FD1C06536;
 Thu, 12 Oct 2023 14:37:04 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [GIT PULL 07/18] stubs: Rename qmp_memory_device.c to memory_device.c
Date: Thu, 12 Oct 2023 16:36:44 +0200
Message-ID: <20231012143655.114631-8-david@redhat.com>
In-Reply-To: <20231012143655.114631-1-david@redhat.com>
References: <20231012143655.114631-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We want to place non-qmp stubs in there, so let's rename it. While at
it, put it into the MAINTAINERS file under "Memory devices".

Message-ID: <20230926185738.277351-8-david@redhat.com>
Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 MAINTAINERS                                    | 1 +
 stubs/{qmp_memory_device.c => memory_device.c} | 0
 stubs/meson.build                              | 2 +-
 3 files changed, 2 insertions(+), 1 deletion(-)
 rename stubs/{qmp_memory_device.c => memory_device.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index c3cc12dc29..0c585d093f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2876,6 +2876,7 @@ F: hw/mem/pc-dimm.c
 F: include/hw/mem/memory-device.h
 F: include/hw/mem/nvdimm.h
 F: include/hw/mem/pc-dimm.h
+F: stubs/memory_device.c
 F: docs/nvdimm.txt
 
 SPICE
diff --git a/stubs/qmp_memory_device.c b/stubs/memory_device.c
similarity index 100%
rename from stubs/qmp_memory_device.c
rename to stubs/memory_device.c
diff --git a/stubs/meson.build b/stubs/meson.build
index ef6e39a64d..cde44972bf 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -32,7 +32,7 @@ stub_ss.add(files('monitor.c'))
 stub_ss.add(files('monitor-core.c'))
 stub_ss.add(files('physmem.c'))
 stub_ss.add(files('qemu-timer-notify-cb.c'))
-stub_ss.add(files('qmp_memory_device.c'))
+stub_ss.add(files('memory_device.c'))
 stub_ss.add(files('qmp-command-available.c'))
 stub_ss.add(files('qmp-quit.c'))
 stub_ss.add(files('qtest.c'))
-- 
2.41.0


