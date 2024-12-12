Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A21A9EE805
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Dec 2024 14:47:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLjVz-0007Wk-48; Thu, 12 Dec 2024 08:46:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1tLjVN-0007TB-MG
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 08:45:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1tLjVK-0003cC-F0
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 08:45:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734011121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=81cVUqQuOeY7z2nPcKsGnCBnf66r+iuJcrd9VyY4oB4=;
 b=EtmDYhW0Y7oUSMJFVrm2cB6lYW1ci7cJadgxJjh7k+OyzQhIjRHUNbsWLGFes9PUNzwyA0
 cb+TY6DgxFE7f0Ws/7VfC7+THaV3xyCLL6yYeHawhEPDQPF9AUEX1ye62lbWvKi4HZOScc
 iaoURoqPEmHQ+eOoozhARE2btpSKXPM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-bKXjqWweP0W4JssFiaa84A-1; Thu,
 12 Dec 2024 08:45:15 -0500
X-MC-Unique: bKXjqWweP0W4JssFiaa84A-1
X-Mimecast-MFC-AGG-ID: bKXjqWweP0W4JssFiaa84A
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 57EBD1955E7A; Thu, 12 Dec 2024 13:45:14 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.198])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4B43A1955F41; Thu, 12 Dec 2024 13:45:12 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Philippe Mathieu-Daude <philmd@linaro.org>
Subject: [PATCH v4 2/2] vpc: Read images exported from Azure correctly
Date: Thu, 12 Dec 2024 14:45:04 +0100
Message-ID: <20241212134504.1983757-3-vkuznets@redhat.com>
In-Reply-To: <20241212134504.1983757-1-vkuznets@redhat.com>
References: <20241212134504.1983757-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

It was found that 'qemu-nbd' is not able to work with some disk images
exported from Azure. Looking at the 512b footer (which contains VPC
metadata):

00000000  63 6f 6e 65 63 74 69 78  00 00 00 02 00 01 00 00  |conectix........|
00000010  ff ff ff ff ff ff ff ff  2e c7 9b 96 77 61 00 00  |............wa..|
00000020  00 07 00 00 57 69 32 6b  00 00 00 01 40 00 00 00  |....Wi2k....@...|
00000030  00 00 00 01 40 00 00 00  28 a2 10 3f 00 00 00 02  |....@...(..?....|
00000040  ff ff e7 47 8c 54 df 94  bd 35 71 4c 94 5f e5 44  |...G.T...5qL._.D|
00000050  44 53 92 1a 00 00 00 00  00 00 00 00 00 00 00 00  |DS..............|
00000060  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|

we can see that Azure uses a different 'Creator application' --
'wa\0\0' (offset 0x1c, likely reads as 'Windows Azure') and QEMU uses this
field to determine how it can get image size. Apparently, Azure uses 'new'
method, just like Hyper-V.

Overall, it seems that only VPC and old QEMUs need to be ignored as all new
creator apps seem to have reliable current_size. Invert the logic and make
'current_size' method the default to avoid adding every new creator app to
the list.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 block/vpc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/block/vpc.c b/block/vpc.c
index fb0ded1c4344..a5f626baf04a 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -237,6 +237,7 @@ static void vpc_parse_options(BlockDriverState *bs, QemuOpts *opts,
  *      'd2v '  :  current_size     Disk2vhd
  *      'tap\0' :  current_size     XenServer
  *      'CTXS'  :  current_size     XenConverter
+ *      'wa\0\0':  current_size     Azure
  *
  *  The user can override the table values via drive options, however
  *  even with an override we will still use current_size for images
@@ -244,11 +245,8 @@ static void vpc_parse_options(BlockDriverState *bs, QemuOpts *opts,
  */
 static bool vpc_ignore_current_size(VHDFooter *footer)
 {
-    return !!strncmp(footer->creator_app, "win ", 4) &&
-           !!strncmp(footer->creator_app, "qem2", 4) &&
-           !!strncmp(footer->creator_app, "d2v ", 4) &&
-           !!strncmp(footer->creator_app, "CTXS", 4) &&
-           !!memcmp(footer->creator_app, "tap", 4));
+    return !strncmp(footer->creator_app, "vpc ", 4) ||
+           !strncmp(footer->creator_app, "qemu", 4);
 }
 
 static int vpc_open(BlockDriverState *bs, QDict *options, int flags,
-- 
2.47.0


