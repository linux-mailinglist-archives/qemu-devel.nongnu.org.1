Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DE298CE9A
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Oct 2024 10:18:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svuYp-0004vA-IY; Wed, 02 Oct 2024 04:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1svuYn-0004sU-En
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 04:18:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1svuYl-0003YT-Qs
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 04:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727857091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=PiL2w0xpzlRrpPuPaQPU1FyyLOrmeIbtOHnToSLfY5c=;
 b=MY6cfRLd9DR1iod9Xj2a338yZUP/yAjmZj3kIBItwXZbsEPytG8Ql0rj09GQ6jtopd32VK
 F2melXYQsYchpQXoBxl3eltTcD+h5Y+H626jeEnobdNMTk48XMnO42xHjyQ5G0gSy2S2U1
 jrzhi9boKPCLJi/o228w3pEXyefFLOA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-JQdXocVxO-euJ1V-KrOkTw-1; Wed,
 02 Oct 2024 04:18:09 -0400
X-MC-Unique: JQdXocVxO-euJ1V-KrOkTw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8123B1955F45; Wed,  2 Oct 2024 08:18:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.47])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44DCC3000198; Wed,  2 Oct 2024 08:18:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4036A21E6A28; Wed,  2 Oct 2024 10:18:05 +0200 (CEST)
Resent-To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Wed, 02 Oct 2024 10:18:05 +0200
Resent-Message-ID: <878qv66hqa.fsf@pond.sub.org>
X-From-Line: armbru@redhat.com  Wed Oct  2 09:44:04 2024
X-Original-To: armbru
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E6C5321E68B2; Wed,  2 Oct 2024 09:44:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 07/10] qapi/cxl: Supply missing member documentation
Date: Wed,  2 Oct 2024 09:44:01 +0200
Message-ID: <20241002074404.1983368-8-armbru@redhat.com>
In-Reply-To: <20241002074404.1983368-1-armbru@redhat.com>
References: <20241002074404.1983368-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Lines: 41
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Since we neglect to document a member of CxlCorErrorType, its
description in the QEMU QMP Reference manual is "Not documented".  Fix
that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240911112545.2248881-8-armbru@redhat.com>
---
 qapi/cxl.json    | 3 +++
 qapi/pragma.json | 1 -
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/qapi/cxl.json b/qapi/cxl.json
index e9315d5b4d..9f65589bce 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -326,6 +326,9 @@
 # @crc-threshold: Component specific and applicable to 68 byte Flit
 #     mode only.
 #
+# @retry-threshold: Retry threshold hit in the Local Retry State
+#     Machine, 68B Flits only.
+#
 # @cache-poison-received: Received poison from a peer on CXL.cache.
 #
 # @mem-poison-received: Received poison from a peer on CXL.mem
diff --git a/qapi/pragma.json b/qapi/pragma.json
index feb7981700..108e574678 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -46,7 +46,6 @@
         'BlockdevSnapshotSyncWrapper',
         'BlockdevSnapshotWrapper',
         'BlockdevVmdkAdapterType',
-        'CxlCorErrorType',
         'DisplayProtocol',
         'DriveBackupWrapper',
         'DummyBlockCoreForceArrays',
-- 
2.46.0



