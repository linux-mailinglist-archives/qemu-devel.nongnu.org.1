Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB84D861C9C
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Feb 2024 20:35:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdbIf-0008WN-4T; Fri, 23 Feb 2024 14:33:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rdawD-0005mL-0v
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 14:10:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rdaw3-0005Bd-Hl
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 14:10:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708715414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H4xvxkfYdM98uQaXkVrzMYveIOlmHEFn0bASNZa3zAw=;
 b=UP5rROSSr5bKdVYx8BGxasu0c1I7HFHLqUvaj/orzPJhdBlkncp6OjCU3bWnlsKNH6wQOZ
 mzLfHA1QZn+0xWZ09WvWzx6CI1I31HRepvlyN7mGx3svqYkIfMPl3L5S5xlPDIFOfW4e40
 Lpe9EEb4UkRcMo6g9ISGnd7j7WoFE40=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-reE7yC61NjiBjMPEXfL5xw-1; Fri,
 23 Feb 2024 14:10:12 -0500
X-MC-Unique: reE7yC61NjiBjMPEXfL5xw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5BBB338562C9;
 Fri, 23 Feb 2024 19:10:12 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF15E8CED;
 Fri, 23 Feb 2024 19:10:11 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 05/11] target/ppc/kvm: Replace variable length array in
 kvmppc_save_htab()
Date: Fri, 23 Feb 2024 20:09:57 +0100
Message-ID: <20240223191003.6268-6-thuth@redhat.com>
In-Reply-To: <20240223191003.6268-1-thuth@redhat.com>
References: <20240223191003.6268-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
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

To be able to compile QEMU with -Wvla (to prevent potential security
issues), we need to get rid of the variable length array in the
kvmppc_save_htab() function. Replace it with a heap allocation instead.

Message-ID: <20240221162636.173136-2-thuth@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/ppc/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 26fa9d0575..e7e39c3091 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2688,7 +2688,7 @@ int kvmppc_get_htab_fd(bool write, uint64_t index, Error **errp)
 int kvmppc_save_htab(QEMUFile *f, int fd, size_t bufsize, int64_t max_ns)
 {
     int64_t starttime = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
-    uint8_t buf[bufsize];
+    g_autofree uint8_t *buf = g_malloc(bufsize);
     ssize_t rc;
 
     do {
-- 
2.43.2


