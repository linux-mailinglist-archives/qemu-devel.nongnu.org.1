Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22286723703
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 07:58:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Pgc-0004sK-Sf; Tue, 06 Jun 2023 01:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6PgY-0004rR-Dz
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 01:56:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6PgX-0004Aq-07
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 01:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686031008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=huSfNPp8zg1hWlnqaPD+jP2ndtJPMzf8twEx+oT9Jq0=;
 b=WNi+dIZveBOGNem7bzNN2p5q6DonwFyqn8VmHH9tF/iM7lOrhkI6Uc8xhICaSP7u5XiA9E
 fEEEFJY5oDprZCbB6Yjjl+uSWTX9UK2GpCJYfapXVAqHG7LVjO6orWVMsifhDJmQqmVJ+2
 n3ava4qmmSvQM6/YoJ03DH+kxyJdwK4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-308-rVESNpixNHq7QWTLAYgdZw-1; Tue, 06 Jun 2023 01:56:43 -0400
X-MC-Unique: rVESNpixNHq7QWTLAYgdZw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C955E185A78E;
 Tue,  6 Jun 2023 05:56:42 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ABA4C2166B25;
 Tue,  6 Jun 2023 05:56:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-stable@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 12/18] hw/mips/malta: Fix the malta machine on big endian hosts
Date: Tue,  6 Jun 2023 07:56:15 +0200
Message-Id: <20230606055621.523175-13-thuth@redhat.com>
In-Reply-To: <20230606055621.523175-1-thuth@redhat.com>
References: <20230606055621.523175-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Booting a Linux kernel with the malta machine is currently broken
on big endian hosts. The cpu_to_gt32 macro wants to byteswap a value
for little endian targets only, but uses the wrong way to do this:
cpu_to_[lb]e32 works the other way round on big endian hosts! Fix
it by using the same ways on both, big and little endian hosts.

Fixes: 0c8427baf0 ("hw/mips/malta: Use bootloader helper to set BAR registers")
Cc: qemu-stable@nongnu.org
Message-Id: <20230330152613.232082-1-thuth@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/mips/malta.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index e3be2eea56..47cb49f691 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -629,9 +629,9 @@ static void bl_setup_gt64120_jump_kernel(void **p, uint64_t run_addr,
 
     /* Bus endianess is always reversed */
 #if TARGET_BIG_ENDIAN
-#define cpu_to_gt32 cpu_to_le32
+#define cpu_to_gt32(x) (x)
 #else
-#define cpu_to_gt32 cpu_to_be32
+#define cpu_to_gt32(x) bswap32(x)
 #endif
 
     /* setup MEM-to-PCI0 mapping as done by YAMON */
-- 
2.31.1


