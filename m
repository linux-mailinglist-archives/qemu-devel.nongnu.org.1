Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4D4704D2C
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 13:56:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pytGq-0006t1-QL; Tue, 16 May 2023 07:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1pytGn-0006sl-Jg
 for qemu-devel@nongnu.org; Tue, 16 May 2023 07:55:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1pytGj-0003OA-1U
 for qemu-devel@nongnu.org; Tue, 16 May 2023 07:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684238104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p8s4rW0YzekuCFsDuPriZP/9do+Pry4JL54Kvao8QoI=;
 b=cdY0olpULKaNcIp+65OUZqAvvxTWd+JxuwPRrAhz2PzPK1gjlQjIdQgFVDKG2c3bkQCq7x
 H4xedsb+G8e9FFhujvV7vE/TE3qEG0rYcVgnwGJecbEiuLX0JE5I8lFhyE0BlsBY2dIQej
 MESDjyqzxwWqvtZaMcmXHemhOxyC17g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-507-1ewadyONN0KwrA_a-d-k3Q-1; Tue, 16 May 2023 07:55:01 -0400
X-MC-Unique: 1ewadyONN0KwrA_a-d-k3Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E5A584AF36;
 Tue, 16 May 2023 11:54:58 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9FEE7C15BA0;
 Tue, 16 May 2023 11:54:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 02/21] sysemu/kvm: Remove unused headers
Date: Tue, 16 May 2023 13:54:55 +0200
Message-Id: <20230516115455.599584-2-thuth@redhat.com>
In-Reply-To: <20230516115455.599584-1-thuth@redhat.com>
References: <20230516115455.599584-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

All types used are forward-declared in "qemu/typedefs.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230405160454.97436-2-philmd@linaro.org>
[thuth: Add hw/core/cpu.h to migration/dirtyrate.c to fix compile failure]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/sysemu/kvm.h  | 3 ---
 migration/dirtyrate.c | 1 +
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index c8281c07a7..88f5ccfbce 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -14,9 +14,6 @@
 #ifndef QEMU_KVM_H
 #define QEMU_KVM_H
 
-#include "qemu/queue.h"
-#include "hw/core/cpu.h"
-#include "exec/memattrs.h"
 #include "qemu/accel.h"
 #include "qom/object.h"
 
diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index c06f12c39d..0220db82ec 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include <zlib.h>
+#include "hw/core/cpu.h"
 #include "qapi/error.h"
 #include "exec/ramblock.h"
 #include "exec/target_page.h"
-- 
2.31.1


