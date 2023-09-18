Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B02BC7A4AA2
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 15:36:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiEOI-0000eG-Q7; Mon, 18 Sep 2023 09:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qiENv-0000CD-UJ
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 09:34:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qiENr-0004hZ-M6
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 09:33:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695044031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZTp8MihO8LnadKZiID3kWaU6teTLingfFW6b8/5zzcs=;
 b=G3bV/K8uW6G863Sm9cgZ81GH7dp/Cv0eQx7bqAOE71io6fd0vAdgvF/xgSAJlHYjZFHD4s
 amtxMw6PNV0baK0A3IC3U7drsRvtgCdiPH5QKnjsdfNu0o64DtdZiP2vCRnv4Qf9EyPTKM
 pXWJs7JJpRrP3YPm1rIdjAFc0cFu6sI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-Ujjj44IPNx6mUDAOIgeHoQ-1; Mon, 18 Sep 2023 09:33:49 -0400
X-MC-Unique: Ujjj44IPNx6mUDAOIgeHoQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 455703800E95;
 Mon, 18 Sep 2023 13:33:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EE399170EC;
 Mon, 18 Sep 2023 13:33:48 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B7E031800D6A; Mon, 18 Sep 2023 15:33:47 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 7/8] tests/acpi: update virt/SSDT.memhp
Date: Mon, 18 Sep 2023 15:33:29 +0200
Message-ID: <20230918133338.2399701-8-kraxel@redhat.com>
In-Reply-To: <20230918133338.2399701-1-kraxel@redhat.com>
References: <20230918133338.2399701-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
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

The edk2 update caused an address change:

 DefinitionBlock ("", "SSDT", 1, "BOCHS ", "NVDIMM", 0x00000001)
 {
     Scope (\_SB)
     {
         Device (NVDR)
         {
             Name (_HID, "ACPI0012" /* NVDIMM Root Device */)  // _HID: Hardware ID
             [ ... ]
         }
     }

-    Name (MEMA, 0x43D10000)
+    Name (MEMA, 0x43C90000)
 }

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 tests/data/acpi/virt/SSDT.memhp | Bin 1817 -> 1817 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/tests/data/acpi/virt/SSDT.memhp b/tests/data/acpi/virt/SSDT.memhp
index ef93c44464f1fe38f7e5babd5d67f345cc6363a6..31ff6ac46940a3e304a2d68efabe12bab50be0d7 100644
GIT binary patch
delta 22
dcmbQqH<OPmIM^jblAVEpaqUJfUUsIF&Hz2I1wsG-

delta 22
dcmbQqH<OPmIM^jblAVEpap^`bUUsI7&Hz1t1wsG-

-- 
2.41.0


