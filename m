Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDB9819B97
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 10:43:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFt58-0002XZ-UT; Wed, 20 Dec 2023 04:41:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rFt4w-0002TW-FO
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 04:41:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rFt4u-0005iI-0P
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 04:41:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703065283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=plZTCwfkAEYyqpWVV14qLoexU9Y3bfvtxvbRmdbjnwU=;
 b=dcGpH1rjqMjDSFkgrRNCshJtwQVf1BVlEKMsraHnAAbbfX5BRl1x23WE2fXNo3EGlHtKba
 8UIiq7AAHp2vGI1uEsEiL3B08ceZdF67Ag+O5ZsUt0wDpyTGDxYTMmvCbTOfqSNvKMSAgn
 UAc2osdx/0Yd4rhT3yWk6aFjNpc0+gk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-358-NqrZlmMhPEWTztcuqhDFNg-1; Wed,
 20 Dec 2023 04:41:19 -0500
X-MC-Unique: NqrZlmMhPEWTztcuqhDFNg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D22D1C05EAF;
 Wed, 20 Dec 2023 09:41:19 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.167])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 96CA12166B31;
 Wed, 20 Dec 2023 09:41:17 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/19] hw/misc/mips_itu: Remove unnecessary 'exec/exec-all.h'
 header
Date: Wed, 20 Dec 2023 10:40:52 +0100
Message-ID: <20231220094105.6588-7-thuth@redhat.com>
In-Reply-To: <20231220094105.6588-1-thuth@redhat.com>
References: <20231220094105.6588-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

mips_itu.c only requires declarations from "hw/core/cpu.h"
and "cpu.h". Avoid including the huge "exec/exec-all.h" header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231212113640.30287-3-philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/misc/mips_itu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index 5a83ccc4e8..37aea0e737 100644
--- a/hw/misc/mips_itu.c
+++ b/hw/misc/mips_itu.c
@@ -22,9 +22,10 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "exec/exec-all.h"
+#include "hw/core/cpu.h"
 #include "hw/misc/mips_itu.h"
 #include "hw/qdev-properties.h"
+#include "target/mips/cpu.h"
 
 #define ITC_TAG_ADDRSPACE_SZ (ITC_ADDRESSMAP_NUM * 8)
 /* Initialize as 4kB area to fit all 32 cells with default 128B grain.
-- 
2.43.0


