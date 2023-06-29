Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6A6742CE3
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 21:04:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEwvP-0006ck-He; Thu, 29 Jun 2023 15:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qEwvN-0006bB-2Q
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 15:03:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qEwvL-0005Pj-6p
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 15:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688065402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rjk8OjVMk9etjc5atmQILqE580kWp/fVcMfLA09FUlQ=;
 b=XDpQZBjuMTSkvMoxdNZrTC6EQn1fwFeFQdgaM1NRtNjwR09jnf6DXpD0GCsBCQetqojy3d
 EFXW1jLQcR3CFCMccdp+Lur9BKD5SedIxoSWHH5JWXRNHn4KDqFVNWDLdoJz3lYI/0EBF6
 XymhABGpn3u9SMlUpfiVFjDoJinnc3U=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-156-7jMFALZjOj-DbFgRbVBVLg-1; Thu, 29 Jun 2023 15:03:18 -0400
X-MC-Unique: 7jMFALZjOj-DbFgRbVBVLg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AEBDD1C07829;
 Thu, 29 Jun 2023 19:03:17 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D4235140E952;
 Thu, 29 Jun 2023 19:03:16 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 3/8] pc-bios/s390-ccw/Makefile: Use -z noexecstack to silence
 linker warning
Date: Thu, 29 Jun 2023 21:03:05 +0200
Message-Id: <20230629190310.337850-4-thuth@redhat.com>
In-Reply-To: <20230629190310.337850-1-thuth@redhat.com>
References: <20230629190310.337850-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

Recent versions of ld complain when linking the s390-ccw bios:

 /usr/bin/ld: warning: start.o: missing .note.GNU-stack section implies
              executable stack
 /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in
              a future version of the linker

We can silence the warning by telling the linker to mark the stack
as not executable.

Message-Id: <20230622130822.396793-1-thuth@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index 2e8cc015aa..acfcd1e71a 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -55,7 +55,7 @@ config-cc.mak: Makefile
 	    $(call cc-option,-march=z900,-march=z10)) 3> config-cc.mak
 -include config-cc.mak
 
-LDFLAGS += -Wl,-pie -nostdlib
+LDFLAGS += -Wl,-pie -nostdlib -z noexecstack
 
 build-all: s390-ccw.img s390-netboot.img
 
-- 
2.39.3


