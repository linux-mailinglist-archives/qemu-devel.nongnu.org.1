Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 443897CC423
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 15:14:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsjtf-0003R0-Dl; Tue, 17 Oct 2023 09:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsjtd-0003OT-4f
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:14:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsjtb-0006oa-Bh
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:14:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697548442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=e4AEoBaVwriKRemVj3D5NyYzIfjLNSiVYdQVwzjJU68=;
 b=Q1R36bThQFn6qXyXp0A6tOEnz2xmmyh8U93h567M1vMY2BGK4jYNleWgZCf+IIe2tAqCDU
 HJVeMSMbzhg/su+mAQQoMSxWXNfNaDamidjk54lYVe7vyQBChim5vqoe8ILIHIoA02dVzI
 gdFaAWJNRtGRlXl4zzt+/hLXx2zavlE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-60-u-2xCcf8NbSn6CeGVVJaBg-1; Tue, 17 Oct 2023 09:13:46 -0400
X-MC-Unique: u-2xCcf8NbSn6CeGVVJaBg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B30B3827978;
 Tue, 17 Oct 2023 13:13:46 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 712A51C060AE;
 Tue, 17 Oct 2023 13:13:45 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Juan Quintela <quintela@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] ARM: Use normal types
Date: Tue, 17 Oct 2023 15:13:44 +0200
Message-ID: <20231017131344.19676-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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

A bit of history from Warner:

This has been that way the bsd-user sources were reorganized in
2015. I can find no good reason in the FreeBSD sources to do
this (we've been transitioning from the pre-standardized BSD
convention of u_intXX_t -> uintXX_t for 25 years now it seems). I
don't see any old or ancient usage as far back as I looked why they'd
be different. Up through FreeBSD 12.x, this was u_int32_t (for all of
them), but they switched to __uint32_t in FreeBSD 13 to avoid
namespace pollution.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by:  Warner Losh <imp@bsdimp.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>

---

It looks this got lost on previous release
---
 bsd-user/arm/target_arch_reg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bsd-user/arm/target_arch_reg.h b/bsd-user/arm/target_arch_reg.h
index 070fa24da1..5f1eea4291 100644
--- a/bsd-user/arm/target_arch_reg.h
+++ b/bsd-user/arm/target_arch_reg.h
@@ -32,7 +32,7 @@ typedef struct target_reg {
 typedef struct target_fp_reg {
     uint32_t        fp_exponent;
     uint32_t        fp_mantissa_hi;
-    u_int32_t       fp_mantissa_lo;
+    uint32_t       fp_mantissa_lo;
 } target_fp_reg_t;
 
 typedef struct target_fpreg {
-- 
2.41.0


