Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D41167C56A6
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:21:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqa4o-000200-Od; Wed, 11 Oct 2023 10:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qqa4l-0001zV-IV
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:20:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qqa4h-0001pW-Qj
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697034035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DWaUsX5xhnfap4EOOK/undTJV2jlrdAiGktAOSyl5gM=;
 b=hrwep7KE1AIKCyuSiSCC2A/B4TwNm8ywaO3LWZYMSn2Lt8yvSQ3Mn3I5ybCiHDyru+xsVu
 Yn1jrArlX+XjMTOL1x0Slc77X97pbf7JNRE2X2kTGYd6XnWJqGN/WP7Z0Up1d+oMjYbdDh
 BiNhcZcPMpDoe3oEsiHaIqruKJtXkRo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-531-sDO828cTOHub7yU1ibP8tQ-1; Wed, 11 Oct 2023 10:20:33 -0400
X-MC-Unique: sDO828cTOHub7yU1ibP8tQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3659E2825E9F;
 Wed, 11 Oct 2023 14:20:33 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.133])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 98EC9111CD23;
 Wed, 11 Oct 2023 14:20:32 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/3] qga: Remove platform GUID definitions
Date: Wed, 11 Oct 2023 17:20:28 +0300
Message-ID: <20231011142030.112018-2-kkostiuk@redhat.com>
In-Reply-To: <20231011142030.112018-1-kkostiuk@redhat.com>
References: <20231011142030.112018-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

GUID_DEVINTERFACE_DISK and GUID_DEVINTERFACE_STORAGEPORT are already
defined by MinGW-w64. They are not only unnecessary, but can lead to
duplicate definition errors at link time with some unknown condition.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-win32.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 6beae659b7..697c65507c 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -501,13 +501,6 @@ static GuestDiskBusType find_bus_type(STORAGE_BUS_TYPE bus)
     return win2qemu[(int)bus];
 }
 
-DEFINE_GUID(GUID_DEVINTERFACE_DISK,
-        0x53f56307L, 0xb6bf, 0x11d0, 0x94, 0xf2,
-        0x00, 0xa0, 0xc9, 0x1e, 0xfb, 0x8b);
-DEFINE_GUID(GUID_DEVINTERFACE_STORAGEPORT,
-        0x2accfe60L, 0xc130, 0x11d2, 0xb0, 0x82,
-        0x00, 0xa0, 0xc9, 0x1e, 0xfb, 0x8b);
-
 static void get_pci_address_for_device(GuestPCIAddress *pci,
                                        HDEVINFO dev_info)
 {
-- 
2.42.0


