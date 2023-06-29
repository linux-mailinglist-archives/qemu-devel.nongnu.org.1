Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D417F7421B9
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 10:03:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEmcF-0002SB-BK; Thu, 29 Jun 2023 04:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qEmc2-0002Rp-H9
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 04:02:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qEmc0-0004et-Qe
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 04:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688025762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=13rFAIH10RO17ngNLWtxUYtLWmIbc0QCu3eg9xgI7SI=;
 b=JVhbCytzKaT1E9fLyH7ODBHmwH5PpZ4ENuBwBNyL2uhOep6UMxYxNVl/Ml6fWAP/WPEx2Q
 aiF2z6MLZQ1Bcc18K8nEpNO8XKDUi99Ont65WoeOZXKF+nY8/z6uUN/kHEkV/tcUjWQN+n
 +rccCyjAgUhzY79fl/xF2k9gExjILkc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-327-AZwNcXEdNDSzpqUiiYSXjw-1; Thu, 29 Jun 2023 04:02:39 -0400
X-MC-Unique: AZwNcXEdNDSzpqUiiYSXjw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3AF93185A78F;
 Thu, 29 Jun 2023 08:02:39 +0000 (UTC)
Received: from thuth.com (dhcp-192-205.str.redhat.com [10.33.192.205])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B0A3AC09A07;
 Thu, 29 Jun 2023 08:02:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [qemu-web PATCH] Fix installation instructions for Debian/Ubuntu
Date: Thu, 29 Jun 2023 10:02:34 +0200
Message-Id: <20230629080234.179687-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

There is no package called "qemu" here - thus use the two meta-packages
"qemu-system" and "qemu-user" instead.

Resolves: https://gitlab.com/qemu-project/qemu-web/-/issues/8
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 _download/linux.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/_download/linux.md b/_download/linux.md
index 11ed695..bb76425 100644
--- a/_download/linux.md
+++ b/_download/linux.md
@@ -2,7 +2,7 @@ QEMU is packaged by most Linux distributions:
 
 * <strong>Arch:</strong> `pacman -S qemu`
 
-* <strong>Debian/Ubuntu:</strong> `apt-get install qemu`
+* <strong>Debian/Ubuntu:</strong> `apt-get install qemu-system qemu-user`
 
 * <strong>Fedora:</strong> `dnf install @virtualization`
 
-- 
2.39.3


