Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD6F911EA1
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jun 2024 10:25:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKZZj-0008PS-N2; Fri, 21 Jun 2024 04:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sKZZg-0008Ox-LM
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:24:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sKZZf-0003Ix-BH
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:24:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718958286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gJAuN/MJIKkZkJLsxF/L2OIAthjDl8A7pQXerPTdKjA=;
 b=atlNEupbgrRK1JVC85Y16H2rySjS6Mj8NFbUuBMi0l10O4vfBhOtyljlfHwSFWBQgi6rAa
 wurTj0IdbXKcl0PVrJYsxZlTnosW37GPlB5w6Bc0wo9CY24XAF3YH1BcTH0UVJt0VHjK88
 JH1Vf/bG5a/XvOCtsjiky3vHBZ8rjqA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-cx6WTd_VPQmMKdokVqEBSQ-1; Fri,
 21 Jun 2024 04:24:41 -0400
X-MC-Unique: cx6WTd_VPQmMKdokVqEBSQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 086E61955E87; Fri, 21 Jun 2024 08:24:40 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.213])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8CF911956087; Fri, 21 Jun 2024 08:24:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 "Collin L . Walling" <walling@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Jason J . Herne" <jjherne@linux.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: [PATCH 2/7] hw/s390x/ipl: Provide more memory to the s390-ccw.img
 firmware
Date: Fri, 21 Jun 2024 10:24:17 +0200
Message-ID: <20240621082422.136217-3-thuth@redhat.com>
In-Reply-To: <20240621082422.136217-1-thuth@redhat.com>
References: <20240621082422.136217-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

We are going to link the SLOF libc into the s390-ccw.img, and this
libc needs more memory for providing space for malloc() and friends.
Thus bump the memory size that we reserve for the bios to 3 MiB
instead of only 2 MiB. While we're at it, add a proper check that
there is really enough memory assigned to the machine before blindly
using it.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/ipl.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index e934bf89d1..9362de0b6f 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -45,6 +45,7 @@
 #define INITRD_PARM_START               0x010408UL
 #define PARMFILE_START                  0x001000UL
 #define ZIPL_IMAGE_START                0x009000UL
+#define BIOS_MAX_SIZE                   0x300000UL
 #define IPL_PSW_MASK                    (PSW_MASK_32 | PSW_MASK_64)
 
 static bool iplb_extended_needed(void *opaque)
@@ -144,7 +145,14 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
      * even if an external kernel has been defined.
      */
     if (!ipl->kernel || ipl->enforce_bios) {
-        uint64_t fwbase = (MIN(ms->ram_size, 0x80000000U) - 0x200000) & ~0xffffUL;
+        uint64_t fwbase;
+
+        if (ms->ram_size < BIOS_MAX_SIZE) {
+            error_setg(errp, "not enough RAM to load the BIOS file");
+            return;
+        }
+
+        fwbase = (MIN(ms->ram_size, 0x80000000U) - BIOS_MAX_SIZE) & ~0xffffUL;
 
         bios_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, ipl->firmware);
         if (bios_filename == NULL) {
-- 
2.45.2


