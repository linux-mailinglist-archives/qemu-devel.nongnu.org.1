Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6623E788861
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 15:23:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZWlk-0001ll-Sb; Fri, 25 Aug 2023 09:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qZWli-0001lL-22
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 09:22:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qZWlf-0001mV-4A
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 09:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692969746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ax0lwKbEAmHF95XuUfVMmzoQFryg8rMSnkG+atSR+Yc=;
 b=NOaqR0O+hx8+F22rYNM53A04YDQwaSzVs5FqUZwc0DcXyXAH9ympYEpjH9+JIl/JulB1Wc
 EeafpGIQXNWbMgpvQ/ZdPJiz/rj9jhlGY/sNeZPKZX5MeEolaW4XRA5OnGepM0k4pRq/7P
 crCczGgA98u6CeDd8nAz3HN702lnn5o=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-Mp_0jSz3NG6YNK0Q8HegyA-1; Fri, 25 Aug 2023 09:22:21 -0400
X-MC-Unique: Mp_0jSz3NG6YNK0Q8HegyA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 538EB3811F41;
 Fri, 25 Aug 2023 13:22:21 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 07C62140E950;
 Fri, 25 Aug 2023 13:22:17 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Michal Privoznik <mprivozn@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gavin Shan <gshan@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>, kvm@vger.kernel.org
Subject: [PATCH v2 07/16] stubs: Rename qmp_memory_device.c to memory_device.c
Date: Fri, 25 Aug 2023 15:21:40 +0200
Message-ID: <20230825132149.366064-8-david@redhat.com>
In-Reply-To: <20230825132149.366064-1-david@redhat.com>
References: <20230825132149.366064-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

We want to place non-qmp stubs in there, so let's rename it. While at
it, put it into the MAINTAINERS file under "Memory devices".

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 MAINTAINERS                                    | 1 +
 stubs/{qmp_memory_device.c => memory_device.c} | 0
 stubs/meson.build                              | 2 +-
 3 files changed, 2 insertions(+), 1 deletion(-)
 rename stubs/{qmp_memory_device.c => memory_device.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6111b6b4d9..aee6d36966 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2860,6 +2860,7 @@ F: hw/mem/pc-dimm.c
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


