Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D43BBB3CD90
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Aug 2025 18:56:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNEr-0004Rf-IW; Sat, 30 Aug 2025 11:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1urwy5-0008QW-33
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 07:08:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1urwy2-0001gF-LH
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 07:08:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756465705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=og6ymulh9UmaMSIescETQPevhxzm1aJMZFMSGR8zlFk=;
 b=D/8xktZ+uMSswme4HwcTS4OiE3ea7TAHdymLW/BJJWSSyLVH5uA/1KUyjBprf2+Bplk3jT
 aGgwOzsI1wRJgdLlHqIUoI02p2tyzxU93vMfGGavLD78b8fTUg83TbBvsbxN5/3Tw/nvdh
 u1FaU/2pWQKpGigWIzxoADhw1oB7aGk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-dBgAec-gMnmw4UuDehncdg-1; Fri,
 29 Aug 2025 07:08:21 -0400
X-MC-Unique: dBgAec-gMnmw4UuDehncdg-1
X-Mimecast-MFC-AGG-ID: dBgAec-gMnmw4UuDehncdg_1756465700
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79CFD195608F; Fri, 29 Aug 2025 11:08:20 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.225.62])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF36A30001B5; Fri, 29 Aug 2025 11:08:18 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 1/9] qga: Fix ubsan warning
Date: Fri, 29 Aug 2025 14:08:05 +0300
Message-ID: <20250829110813.50286-2-kkostiuk@redhat.com>
In-Reply-To: <20250829110813.50286-1-kkostiuk@redhat.com>
References: <20250829110813.50286-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

When compiling QEMU with --enable-ubsan there is a undefined behavior
warning when running "make check":

 .../qga/commands-linux.c:452:15: runtime error: applying non-zero offset 5 to null pointer
 #0 0x55ea7b89450c in build_guest_fsinfo_for_pci_dev ..../qga/commands-linux.c:452:15

Fix it by avoiding the additional pointer variable here and use an
"offset" integer variable instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250730072709.27077-1-thuth@redhat.com
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-linux.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/qga/commands-linux.c b/qga/commands-linux.c
index 9dc0c82503..4a09ddc760 100644
--- a/qga/commands-linux.c
+++ b/qga/commands-linux.c
@@ -400,10 +400,10 @@ static bool build_guest_fsinfo_for_pci_dev(char const *syspath,
                                            Error **errp)
 {
     unsigned int pci[4], host, hosts[8], tgt[3];
-    int i, nhosts = 0, pcilen;
+    int i, offset, nhosts = 0, pcilen;
     GuestPCIAddress *pciaddr = disk->pci_controller;
     bool has_ata = false, has_host = false, has_tgt = false;
-    char *p, *q, *driver = NULL;
+    char *p, *driver = NULL;
     bool ret = false;
 
     p = strstr(syspath, "/devices/pci");
@@ -445,13 +445,13 @@ static bool build_guest_fsinfo_for_pci_dev(char const *syspath,
 
     p = strstr(syspath, "/ata");
     if (p) {
-        q = p + 4;
+        offset = 4;
         has_ata = true;
     } else {
         p = strstr(syspath, "/host");
-        q = p + 5;
+        offset = 5;
     }
-    if (p && sscanf(q, "%u", &host) == 1) {
+    if (p && sscanf(p + offset, "%u", &host) == 1) {
         has_host = true;
         nhosts = build_hosts(syspath, p, has_ata, hosts,
                              ARRAY_SIZE(hosts), errp);
-- 
2.50.1


