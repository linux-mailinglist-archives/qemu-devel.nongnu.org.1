Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDCA70BC7F
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 13:56:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q144I-0005ar-JZ; Mon, 22 May 2023 07:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q143n-0005GO-Di
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:50:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q143l-0007dm-Fb
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684756240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hitrJqe+z/WFUUPtDgBsKkz9UeUd1fXKqgnzctdi1K4=;
 b=SxMluUOf/crcNSkZf/pXzhpy/MT4HUz64z2wCU3527gGLPj4JWmOGHvM4luSQOWM54TG/3
 rikQ0YP+LAdJxtOBGbBIBx2aADgFyLTst0P9fCVlbgCBuYdZs1NzRBHE0jK6+dJCfreOOU
 Wgbd1po2UfjT/vW+5hwXvyO09QdQ2MQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-137-qyWdwoH8MJ2_4g02_9KiIw-1; Mon, 22 May 2023 07:50:37 -0400
X-MC-Unique: qyWdwoH8MJ2_4g02_9KiIw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D7698007D9;
 Mon, 22 May 2023 11:50:37 +0000 (UTC)
Received: from thuth.com (unknown [10.39.195.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C8722166B26;
 Mon, 22 May 2023 11:50:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 18/20] .gitlab-ci.d/buildtest.yml: Run full "make check" with
 --without-default-devices
Date: Mon, 22 May 2023 13:50:12 +0200
Message-Id: <20230522115014.1110840-19-thuth@redhat.com>
In-Reply-To: <20230522115014.1110840-1-thuth@redhat.com>
References: <20230522115014.1110840-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Thanks to the fixes from the previous patches, we can now run
the full set of "make check" with all targets here.

Message-Id: <20230512124033.502654-19-thuth@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/buildtest.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 307cba1aab..0f1be14cb6 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -527,7 +527,7 @@ build-without-defaults:
       --disable-strip
     TARGETS: avr-softmmu mips64-softmmu s390x-softmmu sh4-softmmu
       sparc64-softmmu hexagon-linux-user i386-linux-user s390x-linux-user
-    MAKE_CHECK_ARGS: check-unit check-qtest-avr check-qtest-mips64
+    MAKE_CHECK_ARGS: check
 
 build-libvhost-user:
   extends: .base_job_template
-- 
2.31.1


