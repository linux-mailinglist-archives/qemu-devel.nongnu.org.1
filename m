Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FBC766FDD
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 16:52:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPORt-0002w6-V9; Fri, 28 Jul 2023 10:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qPORr-0002vY-PD
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 10:28:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qPORp-0006xz-AK
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 10:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690554483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pKn8qZgM0+HTt4J6h+tKL2N1zvZKowBv/GfWd4sQipg=;
 b=hotMf0dlH6PdKBOE77bJXd6CW7gZFkaFLLKgPMuNeAiXZ1kzfcjvK9HGU93wheSN12wJMr
 onpzD7TFs139Wsn27FHnlWPcnC37pMi4Dj9ZrKdHDUXYt47xdkMM/72ekTQgB0GctB8Ycm
 qRN373xv8EqFOrF7xqOiNiToPbu5a+A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-463-hvJOUnSSO12LEhkK4lCt6Q-1; Fri, 28 Jul 2023 10:27:59 -0400
X-MC-Unique: hvJOUnSSO12LEhkK4lCt6Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28EFE8022EF;
 Fri, 28 Jul 2023 14:27:59 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A5E740C2063;
 Fri, 28 Jul 2023 14:27:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, Yonggang Luo <luoyonggang@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [RFC PATCH 5/6] include/qemu/compiler: Fix problem with gcc_struct
 and Clang
Date: Fri, 28 Jul 2023 16:27:47 +0200
Message-Id: <20230728142748.305341-6-thuth@redhat.com>
In-Reply-To: <20230728142748.305341-1-thuth@redhat.com>
References: <20230728142748.305341-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Clang on Windows does not seem to know the "gcc_struct" attribute
and emits a warning when we try to use it. Add an additional check
here with __has_attribute() to avoid this problem.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/qemu/compiler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index a309f90c76..5065b4447c 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -22,7 +22,7 @@
 #define QEMU_EXTERN_C extern
 #endif
 
-#if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
+#if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__)) && !defined(__clang__)
 # define QEMU_PACKED __attribute__((gcc_struct, packed))
 #else
 # define QEMU_PACKED __attribute__((packed))
-- 
2.39.3


