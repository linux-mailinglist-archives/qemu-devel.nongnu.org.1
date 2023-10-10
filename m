Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C82007BF9B2
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 13:28:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqAt3-0002RQ-BZ; Tue, 10 Oct 2023 07:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qqAsZ-0002KH-ST
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 07:26:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qqAsY-0007vu-FT
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 07:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696937182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tmog/vf1quCbeeG8UxTqzDyrrFVfy3uCM9M5CV1yyKg=;
 b=J9v2RVDwfhuy8HEPDkjNEIbR26VfVdD7svhziHDwkkpzNRkE9x0M2jsrOWf5Xs0ECEwGb2
 8ssqJMslAfyedOKbaq+dTbBSn3jvl/tsiH1giUVFMYiD3bQhT40vFBTpv2yQv5OtrFMvAg
 8+rU0koHiRzj54kxzUOEOesEx8Oz8LM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-ERMuv4JpO0-Y4kTVdUhPHw-1; Tue, 10 Oct 2023 07:26:15 -0400
X-MC-Unique: ERMuv4JpO0-Y4kTVdUhPHw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D03B4101A58B
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 11:26:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A928401039;
 Tue, 10 Oct 2023 11:26:14 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D02B418009BD; Tue, 10 Oct 2023 13:26:10 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 5/6] tests/acpi: update expected data files
Date: Tue, 10 Oct 2023 13:26:09 +0200
Message-ID: <20231010112610.2618091-6-kraxel@redhat.com>
In-Reply-To: <20231010112610.2618091-1-kraxel@redhat.com>
References: <20231010112610.2618091-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

 DefinitionBlock ("", "DSDT", 1, "BOCHS ", "BXPC    ", 0x00000001)
 {
     Scope (\)
     {
         OperationRegion (DBG, SystemIO, 0x0402, One)
         Field (DBG, ByteAcc, NoLock, Preserve)
         {
             DBGB,   8
         }

             DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                 0x00000000,         // Granularity
                 0x08000000,         // Range Minimum
                 0xAFFFFFFF,         // Range Maximum
                 0x00000000,         // Translation Offset
                 0xA8000000,         // Length
                 ,, , AddressRangeMemory, TypeStatic)
             DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                 0x00000000,         // Granularity
                 0xC0000000,         // Range Minimum
                 0xFEBFFFFF,         // Range Maximum
                 0x00000000,         // Translation Offset
                 0x3EC00000,         // Length
                 ,, , AddressRangeMemory, TypeStatic)
             QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                 0x0000000000000000, // Granularity
-                0x0000000200000000, // Range Minimum
-                0x00000009FFFFFFFF, // Range Maximum
+                0x000000FF00000000, // Range Minimum
+                0x00000106FFFFFFFF, // Range Maximum
                 0x0000000000000000, // Translation Offset
                 0x0000000800000000, // Length
                 ,, , AddressRangeMemory, TypeStatic)
         })

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 tests/data/acpi/q35/DSDT.mmio64 | Bin 9485 -> 9485 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/tests/data/acpi/q35/DSDT.mmio64 b/tests/data/acpi/q35/DSDT.mmio64
index 8459b82c958b842cd7b92c2145977634fb9c6e5d..bdf36c4d575bfc4eb2eac3f00c9b7b4270f88677 100644
GIT binary patch
delta 35
pcmeD6>h<Ds33dtLRb^mce7TWJN{Q<~0|Uc<AYfzMtfzFJ2>`-Q3+n&?

delta 35
pcmeD6>h<Ds33dtLRb^mce6o>CN{Ne!fq~&a5O6YV)>FFA1OT%k3hMv>

-- 
2.41.0


