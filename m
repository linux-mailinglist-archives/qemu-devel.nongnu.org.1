Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8039822D0A
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 13:31:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL0Ot-0007OJ-5a; Wed, 03 Jan 2024 07:31:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rL0OY-0007M7-En
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 07:30:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rL0OV-0003Lr-Se
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 07:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704285045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6/KGp6dNIa+l1BZc/Kgdn3y7H2ebnf706fk8ATlDqkA=;
 b=cImvgFTvZIaSLkkmj+WifSD5O7Lds2Gl7l4wpsIJKuewfb03F20Bc31lek0V+H+l3cpXb3
 vtlYgkmqhnrbVKG3vK0QH7mVkjxHT4g3I/yOhZ7U284B9SgBH5kWLNksrow22dLnfPK9WZ
 hU6sS9/HuJ4o8IlIDNEUsgp7CEJW934=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-7qY_H1hxN9G5KQb-E5PH5Q-1; Wed, 03 Jan 2024 07:30:44 -0500
X-MC-Unique: 7qY_H1hxN9G5KQb-E5PH5Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 12155185A78F
 for <qemu-devel@nongnu.org>; Wed,  3 Jan 2024 12:30:44 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C3442026D66;
 Wed,  3 Jan 2024 12:30:43 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] softmmu: remove obsolete comment about libvirt timeouts
Date: Wed,  3 Jan 2024 12:30:42 +0000
Message-ID: <20240103123042.2400677-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

For a long time now, libvirt has pre-created the monitor connection
socket and passed the pre-opened FD into QEMU during startup. Thus
libvirt does not have any timeouts waiting for the monitor socket
to appear, it is immediately connected.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 system/vl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/system/vl.c b/system/vl.c
index 6b87bfa32c..1d1508e28f 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1911,7 +1911,6 @@ static bool object_create_early(const char *type)
      * Allocation of large amounts of memory may delay
      * chardev initialization for too long, and trigger timeouts
      * on software that waits for a monitor socket to be created
-     * (e.g. libvirt).
      */
     if (g_str_has_prefix(type, "memory-backend-")) {
         return false;
-- 
2.43.0


