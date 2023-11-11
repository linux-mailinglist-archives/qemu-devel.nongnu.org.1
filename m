Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 250A97E86FE
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Nov 2023 01:50:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1cBq-0007uG-21; Fri, 10 Nov 2023 19:49:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r1cBn-0007u2-Ep
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 19:49:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r1cBl-00062i-BR
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 19:49:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699663768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fZEXeev0Pu3zxt0hW5Ak6+kYleHb0EwpcXixI2LDFE0=;
 b=FVNaaO+BDObnZgoMbz1k++MZwxMvFYzwtqA5gJZZ011NqvaxoOCyGhsZByiFP7+wzkOh44
 UsRrnXW0F6bbjRrkYVdaWUkYq0ny4SP0W0iCwKZHew4Q9LljrWOUzw0nspQ1l0uHFC1O1N
 +KUO2virslLXPLt2LvK0psLxSJZTxIE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-GM9x8lukPB68O-9lDrCe6Q-1; Fri, 10 Nov 2023 19:49:24 -0500
X-MC-Unique: GM9x8lukPB68O-9lDrCe6Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B97B8007B3;
 Sat, 11 Nov 2023 00:49:24 +0000 (UTC)
Received: from localhost (unknown [10.39.192.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 71CC11121306;
 Sat, 11 Nov 2023 00:49:23 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vivek Goyal <vgoyal@redhat.com>, German Maglione <gmaglione@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>
Subject: [PATCH] MAINTAINERS: update virtio-fs mailing list address
Date: Sat, 11 Nov 2023 08:49:20 +0800
Message-ID: <20231111004920.148348-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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

The old virtio-fs mailing list address is no longer in use. Switch to
the new mailing list address.

Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: German Maglione <gmaglione@redhat.com>
Cc: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e73a3ff544..c52df9f76c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2241,7 +2241,7 @@ M: Stefan Hajnoczi <stefanha@redhat.com>
 S: Supported
 F: hw/virtio/vhost-user-fs*
 F: include/hw/virtio/vhost-user-fs.h
-L: virtio-fs@redhat.com
+L: virtio-fs@lists.linux.dev
 
 virtio-input
 M: Gerd Hoffmann <kraxel@redhat.com>
-- 
2.41.0


