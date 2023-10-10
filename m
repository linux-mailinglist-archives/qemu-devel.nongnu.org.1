Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 958817BF9B4
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 13:28:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqAt3-0002RY-CI; Tue, 10 Oct 2023 07:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qqAsV-0002Jp-4q
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 07:26:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qqAsS-0007v6-Fm
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 07:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696937174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v9ioXmtXUCXmXFH5s4hJ8sIJhPgBU2jVIA3zK8Ncg+Y=;
 b=f+QWPGZzE1zYJj8Ye8TlpG2EHQuHj8ajl804FHYsi+85yx/yrfsxx/mS/4kZ3kkEUtpzIo
 4DdLr8AMWUBwyK7K+Fim0/tTVUxzM5h3u8V8+VjEXmrntoC5ZnV+UD/ot+nOdM7Gz1YDzF
 ReZUt8NCCsuuCFDjITGBEKnip45NS3s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-rWldlSLhPr2DeVV-2LXZJA-1; Tue, 10 Oct 2023 07:26:12 -0400
X-MC-Unique: rWldlSLhPr2DeVV-2LXZJA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7CB3811E86
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 11:26:11 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A9F741B9C;
 Tue, 10 Oct 2023 11:26:11 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 7EC7318009A5; Tue, 10 Oct 2023 13:26:10 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 1/6] tests/bios-tables-test: tcg-emulate opteron for mmio64 test
Date: Tue, 10 Oct 2023 13:26:05 +0200
Message-ID: <20231010112610.2618091-2-kraxel@redhat.com>
In-Reply-To: <20231010112610.2618091-1-kraxel@redhat.com>
References: <20231010112610.2618091-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
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

seabios starts to make the placement of the 64bit mmio window
depend on the physical address space.  Run the testcase with
a fixed processor on tcg to avoid different results depending
on the host machine.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 tests/qtest/bios-tables-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index f8e03dfd4615..9f4bc15aaba9 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1082,11 +1082,13 @@ static void test_acpi_q35_tcg_mmio64(void)
     test_data data = {
         .machine = MACHINE_Q35,
         .variant = ".mmio64",
+        .tcg_only = true,
         .required_struct_types = base_required_struct_types,
         .required_struct_types_len = ARRAY_SIZE(base_required_struct_types)
     };
 
     test_acpi_one("-m 128M,slots=1,maxmem=2G "
+                  "-cpu Opteron_G1 "
                   "-object memory-backend-ram,id=ram0,size=128M "
                   "-numa node,memdev=ram0 "
                   "-device pci-testdev,membar=2G",
-- 
2.41.0


