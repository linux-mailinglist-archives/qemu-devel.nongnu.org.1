Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AF8C196D6
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Oct 2025 10:43:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE2g1-0002R1-Gv; Wed, 29 Oct 2025 05:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vE2fl-0002O7-G3
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:40:55 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vE2ff-0008Qf-Ro
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:40:52 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 54F75808B7;
 Wed, 29 Oct 2025 12:40:44 +0300 (MSK)
Received: from dtalexundeer-nx.yandex.net (unknown [2a02:6bf:8080:d37::1:31])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (smtpcorp/Yandex) with ESMTPSA id Rea6510FtiE0-p1B9ZxC3; 
 Wed, 29 Oct 2025 12:40:43 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761730843;
 bh=OuFWa9+MzavqJkI10h1F+5VsTtN4q5muV91G/8fFCZo=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=zp3pqaxDi0/05oCt+5+FfnRtJtAms2+1H5SWEWfJwfcHsf3LMCscJUda9oghzU92M
 VQ4EeYR+KgeCfVRpZw5iJZq+Yo7NAmscqN4Izu+9FHMTxh8hHaUwARibp7vBsjTHTN
 xNP7+5Bfo6wMTUD1qyQEOBBmtgf3bQzmM1oximTY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: Raphael Norwitz <raphael@enfabrica.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: [PATCH v2 1/3] vmstate: introduce VMSTATE_VBUFFER_UINT64
Date: Wed, 29 Oct 2025 14:39:39 +0500
Message-Id: <20251029093939.3251188-2-dtalexundeer@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029093939.3251188-1-dtalexundeer@yandex-team.ru>
References: <20251029093939.3251188-1-dtalexundeer@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is an analog of VMSTATE_VBUFFER_UINT32 macro, but for uint64 type.

Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
---
 include/migration/vmstate.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 7f1f1c166a..4c9e212d58 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -707,6 +707,16 @@ extern const VMStateInfo vmstate_info_qlist;
     .offset       = offsetof(_state, _field),                        \
 }
 
+#define VMSTATE_VBUFFER_UINT64(_field, _state, _version, _test, _field_size) { \
+    .name         = (stringify(_field)),                             \
+    .version_id   = (_version),                                      \
+    .field_exists = (_test),                                         \
+    .size_offset  = vmstate_offset_value(_state, _field_size, uint64_t),\
+    .info         = &vmstate_info_buffer,                            \
+    .flags        = VMS_VBUFFER | VMS_POINTER,                       \
+    .offset       = offsetof(_state, _field),                        \
+}
+
 #define VMSTATE_VBUFFER_ALLOC_UINT32(_field, _state, _version,       \
                                      _test, _field_size) {           \
     .name         = (stringify(_field)),                             \
-- 
2.34.1


