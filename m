Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 960037B33F7
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 15:47:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmDov-0001wR-20; Fri, 29 Sep 2023 09:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qmDom-0001vy-IJ
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 09:46:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qmDog-0003jr-2R
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 09:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695995155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=GsuXEh6bWMGHNQUXAsUnTZljHIGwUss0GAlCMqkxxFA=;
 b=ERLdk5grEekZYITWji9WNXCk1ucKGTUuWWoLrf4SeHrk64NoBHwki/tmmMcHXXDF000KfV
 xDP2ztk4WTJlDN7tj3Y0BNyns8WhjBAH5+ZGQT3WJmYtWF1cLFbORMDU3SNyp7d1jkM7dn
 EeZgYZ+b//Cu/EROVRaKkoE9u+TrRho=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-Q0P4epRXNH23GU3Nwk2u8w-1; Fri, 29 Sep 2023 09:45:54 -0400
X-MC-Unique: Q0P4epRXNH23GU3Nwk2u8w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8ABE82810D5D;
 Fri, 29 Sep 2023 13:45:53 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.194])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A177614171CD;
 Fri, 29 Sep 2023 13:45:52 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH] MAINTAINERS: Add a general architecture section for x86
Date: Fri, 29 Sep 2023 15:45:51 +0200
Message-ID: <20230929134551.395438-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

It's a little bit weird that the files in target/i386/ which
are not in a subfolder there do not have any associated
maintainer (and thus nobody might be CC:-ed on changes to
these files). We should have a general x86 section for these
files, similar to what we already have for s390x and mips.
Since Paolo is already listed as maintainer for both, the
x86 KVM and TCG CPUs, I'd like to suggest him as maintainer
for the general files, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Richard, being listed as x86 TCG CPU maintainer, do you
 want to be listed here, too?

 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3914bbd85b..5b4ab7d142 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -131,6 +131,17 @@ K: ^Subject:.*(?i)mips
 F: docs/system/target-mips.rst
 F: configs/targets/mips*
 
+X86 general architecture support
+M: Paolo Bonzini <pbonzini@redhat.com>
+S: Maintained
+F: configs/devices/i386-softmmu/default.mak
+F: configs/targets/i386-softmmu.mak
+F: configs/targets/x86_64-softmmu.mak
+F: docs/system/target-i386*
+F: target/i386/*.[ch]
+F: target/i386/Kconfig
+F: target/i386/meson.build
+
 Guest CPU cores (TCG)
 ---------------------
 Overall TCG CPUs
-- 
2.41.0


