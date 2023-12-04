Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9DE802CC0
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 09:09:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA40r-0000rn-67; Mon, 04 Dec 2023 03:09:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rA40n-0000rc-9r
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 03:09:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rA40l-0005pE-TF
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 03:09:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701677343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cbx0CbRPmpK3iZsn5VbZb3ke1ETeDjA0AGw38OyRxS8=;
 b=bCXbR8BxdiGu8L2PQGEajDCM0qOio6fwjjvce6T7Je8wo7tDc/Nj501pQEYUPBn756yHMk
 oYYiVXxDlbk6t0gzc5x43e3EZrDegN6bYg4wOAeoKbZZoTqTzLlDBugdOuJ3X3WbJFXxgg
 oZLT5JC0uE0B1iBUA5b5oizadbkKNKg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-DMBUjQ-mP0Ob3HqOwt0wsw-1; Mon,
 04 Dec 2023 03:09:01 -0500
X-MC-Unique: DMBUjQ-mP0Ob3HqOwt0wsw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3C54D1C06364;
 Mon,  4 Dec 2023 08:09:01 +0000 (UTC)
Received: from localhost (unknown [10.39.208.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F016419E91;
 Mon,  4 Dec 2023 08:08:59 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>
Subject: [PULL 2/3] ui/vnc-clipboard: fix inflate_buffer
Date: Mon,  4 Dec 2023 12:08:49 +0400
Message-ID: <20231204080850.4068242-3-marcandre.lureau@redhat.com>
In-Reply-To: <20231204080850.4068242-1-marcandre.lureau@redhat.com>
References: <20231204080850.4068242-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Fiona Ebner <f.ebner@proxmox.com>

Commit d921fea338 ("ui/vnc-clipboard: fix infinite loop in
inflate_buffer (CVE-2023-3255)") removed this hunk, but it is still
required, because it can happen that stream.avail_in becomes zero
before coming across a return value of Z_STREAM_END in the loop.

This fixes the host->guest direction of the clipboard with noVNC and
TigerVNC as clients.

Fixes: d921fea338 ("ui/vnc-clipboard: fix infinite loop in inflate_buffer (CVE-2023-3255)")
Reported-by: Friedrich Weber <f.weber@proxmox.com>
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20231122125826.228189-1-f.ebner@proxmox.com>
---
 ui/vnc-clipboard.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ui/vnc-clipboard.c b/ui/vnc-clipboard.c
index c759be3438..124b6fbd9c 100644
--- a/ui/vnc-clipboard.c
+++ b/ui/vnc-clipboard.c
@@ -69,6 +69,11 @@ static uint8_t *inflate_buffer(uint8_t *in, uint32_t in_len, uint32_t *size)
         }
     }
 
+    *size = stream.total_out;
+    inflateEnd(&stream);
+
+    return out;
+
 err_end:
     inflateEnd(&stream);
 err:
-- 
2.43.0


