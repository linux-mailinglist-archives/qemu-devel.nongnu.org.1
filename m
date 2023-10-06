Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 868977BB6B9
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:42:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoj9H-000556-2V; Fri, 06 Oct 2023 07:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj8q-0004zq-M0
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj8j-00006s-Fz
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696592222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W1hnDXW2G2X0jAZGXXZDFrzGECJyj0Qbki6Nvcz3AA0=;
 b=We0HaNkn8iGdffPJ8r5CgENe7mOc6K4rwQY7DWz0hASI9ofTHQvAFd9dLhaDCsjUsvd6KQ
 6Dckp/G3YiBLN2vAdoxAa8/5ZcSouLFIDT+uBRVvBmSxwOPHS61sfGHjaY35t3oLiJxPem
 ybrXB1b1pBLf9PxOXQoCIrfi7bCIvTk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-388-ZOkZ6c17NgGHXmD9UnqjXg-1; Fri, 06 Oct 2023 07:37:01 -0400
X-MC-Unique: ZOkZ6c17NgGHXmD9UnqjXg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D78A518175A2;
 Fri,  6 Oct 2023 11:37:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B29061054FC3;
 Fri,  6 Oct 2023 11:37:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A002A21E688B; Fri,  6 Oct 2023 13:36:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 26/32] target/ppc: Clean up local variable shadowing in
 kvm_arch_*_registers()
Date: Fri,  6 Oct 2023 13:36:51 +0200
Message-ID: <20231006113657.3803180-27-armbru@redhat.com>
In-Reply-To: <20231006113657.3803180-1-armbru@redhat.com>
References: <20231006113657.3803180-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

From: Cédric Le Goater <clg@kaod.org>

Remove extra 'i' variable to fix this warning :

  ../target/ppc/kvm.c: In function ‘kvm_arch_put_registers’:
  ../target/ppc/kvm.c:963:13: warning: declaration of ‘i’ shadows a previous local [-Wshadow=compatible-local]
    963 |         int i;
        |             ^
  ../target/ppc/kvm.c:906:9: note: shadowed declaration is here
    906 |     int i;
        |         ^
  ../target/ppc/kvm.c: In function ‘kvm_arch_get_registers’:
  ../target/ppc/kvm.c:1265:13: warning: declaration of ‘i’ shadows a previous local [-Wshadow=compatible-local]
   1265 |         int i;
        |             ^
  ../target/ppc/kvm.c:1212:9: note: shadowed declaration is here
   1212 |     int i, ret;
        |         ^

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-ID: <20231006053526.1031252-1-clg@kaod.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 target/ppc/kvm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 51112bd367..d0e2dcdc77 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -960,8 +960,6 @@ int kvm_arch_put_registers(CPUState *cs, int level)
     }
 
     if (cap_one_reg) {
-        int i;
-
         /*
          * We deliberately ignore errors here, for kernels which have
          * the ONE_REG calls, but don't support the specific
@@ -1262,8 +1260,6 @@ int kvm_arch_get_registers(CPUState *cs)
     }
 
     if (cap_one_reg) {
-        int i;
-
         /*
          * We deliberately ignore errors here, for kernels which have
          * the ONE_REG calls, but don't support the specific
-- 
2.41.0


