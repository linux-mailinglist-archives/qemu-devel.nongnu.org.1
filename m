Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8529A73D978
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 10:17:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDhNA-0004P9-Kh; Mon, 26 Jun 2023 04:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qDhMw-00048d-Pd
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:14:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qDhMs-0000uf-Ve
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687767276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sy7UWUK6GUwC8Pc3h93C/TXboN9pbDKMNA8OcHzRSLE=;
 b=Mo5GZuaECvsNv8+YIVT9TiC/XvbQ3HDBWdp6N2wJ8t3KXkzPsQGgmCt+sHkqTQ+CvBBN/L
 6xllsbWegImr2Q7mYXAwGujRDNU3F6VYXE1gJP8oDTEWtvcGSBFCrnZtDV/9pRBQdB/0XK
 niFAa/3mni5gX7Y9PZdewFnDgOpFXus=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-358-hTa3_oU0OL6UDLPTsLI78w-1; Mon, 26 Jun 2023 04:14:34 -0400
X-MC-Unique: hTa3_oU0OL6UDLPTsLI78w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C6E3C104458F;
 Mon, 26 Jun 2023 08:14:33 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D13A7492B01;
 Mon, 26 Jun 2023 08:14:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 8/9] gitlab-ci: add msys2 meson test to junit report
Date: Mon, 26 Jun 2023 10:14:14 +0200
Message-Id: <20230626081415.64615-9-thuth@redhat.com>
In-Reply-To: <20230626081415.64615-1-thuth@redhat.com>
References: <20230626081415.64615-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230620153720.514882-3-marcandre.lureau@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/windows.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
index d45794463a..f889a468b5 100644
--- a/.gitlab-ci.d/windows.yml
+++ b/.gitlab-ci.d/windows.yml
@@ -16,6 +16,8 @@
     expire_in: 7 days
     paths:
       - build/meson-logs/testlog.txt
+    reports:
+      junit: "build/meson-logs/testlog.junit.xml"
   before_script:
   - If ( !(Test-Path -Path msys64\var\cache ) ) {
       mkdir msys64\var\cache
-- 
2.39.3


