Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA00A7C737C
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 18:52:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqyuM-0004z6-I7; Thu, 12 Oct 2023 12:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qqyuE-0004to-Vh
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:51:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qqyuC-0005cX-NN
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697129484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QBp9SQy70BeIQioz1+qToQIt7aTnm8qeJI+SDVB71sQ=;
 b=Mzn3L5COouH823KDuQ5QS2oJoia5AaBJkgGLTf1B3ujJJoTtc98qeG/DuB0SVkHnla29gA
 83gaMZRSwLRK65ZVsl0XWlRPwSKm9U1B7iicAxdZO5WZSDob+PLLdG0I8dGGo2WX+yaH3S
 iBo31p2kxDWCIckkgK7OLxI6FsHbM1M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-rFtlnPSCMYCJKygV-nz1JQ-1; Thu, 12 Oct 2023 12:51:22 -0400
X-MC-Unique: rFtlnPSCMYCJKygV-nz1JQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F67D88B7A6;
 Thu, 12 Oct 2023 16:51:22 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 79ECA25C0;
 Thu, 12 Oct 2023 16:51:21 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 7/7] gitlab-ci: Disable the riscv64-debian-cross-container by
 default
Date: Thu, 12 Oct 2023 18:51:08 +0200
Message-ID: <20231012165108.913443-8-thuth@redhat.com>
In-Reply-To: <20231012165108.913443-1-thuth@redhat.com>
References: <20231012165108.913443-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

This job is failing since weeks. Let's mark it as manual until
it gets fixed.

Message-Id: <82aa015a-ca94-49ce-beec-679cc175b726@redhat.com>
Acked-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/container-cross.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index e0d75d5824..2848166ba3 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -95,6 +95,7 @@ riscv64-debian-cross-container:
   allow_failure: true
   variables:
     NAME: debian-riscv64-cross
+    QEMU_JOB_OPTIONAL: 1
 
 # we can however build TCG tests using a non-sid base
 riscv64-debian-test-cross-container:
-- 
2.41.0


