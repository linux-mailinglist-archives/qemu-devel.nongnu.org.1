Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BD77A02B8
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 13:34:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgkbD-0000mG-82; Thu, 14 Sep 2023 07:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qgkbB-0000l0-4S
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 07:33:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qgkb9-00088x-NS
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 07:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694691206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L+r5qzrhYvesklEk2YhZl0RS3GmsTkW23te839BKj8g=;
 b=gwNkiboDEUXEFv7GrfOU3o0ZsrnmJCDF52NYrixwducvr8c+I1HJiwIWXrxDr2ef1R6dbu
 1FZnvvBzq4CNL2RMgmjTA+sCVFFHp0m4SMvquzUu7RzDYBiub5g7riERoZxQb9cLGgHnio
 rma6K4Zco8dSwYom6D4PkGI1dsf9uZ0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-520-QCX6mu3CO6qJmnluRcR-2Q-1; Thu, 14 Sep 2023 07:33:22 -0400
X-MC-Unique: QCX6mu3CO6qJmnluRcR-2Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97EC381B194;
 Thu, 14 Sep 2023 11:33:21 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 976961054FC2;
 Thu, 14 Sep 2023 11:33:20 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [risu PATCH v3 6/7] build-all-archs: Add s390x to the script that
 builds all architectures
Date: Thu, 14 Sep 2023 13:33:10 +0200
Message-ID: <20230914113311.379537-7-thuth@redhat.com>
In-Reply-To: <20230914113311.379537-1-thuth@redhat.com>
References: <20230914113311.379537-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

To avoid regressions, let's check s390x also via this file.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 build-all-archs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/build-all-archs b/build-all-archs
index e5dcfc8..e89851b 100755
--- a/build-all-archs
+++ b/build-all-archs
@@ -91,7 +91,8 @@ program_exists() {
 for triplet in i386-linux-gnu i686-linux-gnu x86_64-linux-gnu \
                    aarch64-linux-gnu arm-linux-gnueabihf \
                    m68k-linux-gnu \
-                   powerpc64le-linux-gnu powerpc64-linux-gnu ; do
+                   powerpc64le-linux-gnu powerpc64-linux-gnu \
+                   s390x-linux-gnu ; do
 
     if ! program_exists "${triplet}-gcc"; then
         echo "Skipping ${triplet}: no compiler found"
-- 
2.41.0


