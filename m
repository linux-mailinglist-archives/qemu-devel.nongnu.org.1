Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11140786ADC
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 10:58:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6AL-0007Ko-FS; Thu, 24 Aug 2023 04:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qZ6AJ-0007J0-5m
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 04:58:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qZ6AG-0003iO-AD
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 04:58:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692867483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k5sAtDEYg+mO6cON5OI5+MehGdtsWzoCUYJ9hGXaCQY=;
 b=QWmY5m4BaNZt8KJymkdgQaJ1+pxh/w4xijoWYYj9zvxoNld0S1T/siN6M5HAq6RtJle9DT
 PZkLKuxOI1IoiWEeo0X3nBFKFWTcMVgHGfT1Ca2aVDT+nUF2ElI2WhENd6IBvNdJv68NPA
 gow2kzQxSoXruT9uH1yT+nb6/ZTSGHI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-210-oAhONjC8Npqrw8hFloPX4A-1; Thu, 24 Aug 2023 04:58:01 -0400
X-MC-Unique: oAhONjC8Npqrw8hFloPX4A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E59F3800CB4;
 Thu, 24 Aug 2023 08:58:00 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.155])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B28B4C1602B;
 Thu, 24 Aug 2023 08:58:00 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C1E9B180092F; Thu, 24 Aug 2023 10:57:56 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: seabios@seabios.org
Cc: qemu-devel@nongnu.org,
	Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v4 5/6] qemu: log reservations in fw_cfg e820 table
Date: Thu, 24 Aug 2023 10:57:55 +0200
Message-ID: <20230824085756.66732-6-kraxel@redhat.com>
In-Reply-To: <20230824085756.66732-1-kraxel@redhat.com>
References: <20230824085756.66732-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
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

With loglevel 1 (same we use for RAM entries),
so it is included in the firmware log by default.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 src/fw/paravirt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/fw/paravirt.c b/src/fw/paravirt.c
index 3aee4c0d4e6b..e5d4eca0cb5a 100644
--- a/src/fw/paravirt.c
+++ b/src/fw/paravirt.c
@@ -765,7 +765,7 @@ static int qemu_early_e820(void)
         switch (table.type) {
         case E820_RESERVED:
             e820_add(table.address, table.length, table.type);
-            dprintf(3, "qemu/e820: addr 0x%016llx len 0x%016llx [reserved]\n",
+            dprintf(1, "qemu/e820: addr 0x%016llx len 0x%016llx [reserved]\n",
                     table.address, table.length);
             break;
         case E820_RAM:
-- 
2.41.0


