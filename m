Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5226473DF26
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 14:28:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlKA-0000pe-0n; Mon, 26 Jun 2023 08:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlK8-0000od-0y
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:28:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlK6-0002Y8-C7
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M8S9j0Q9MSKKbWjgTlZzkGY9Jb2O2eOGPudQd2ZsdWw=;
 b=bZ4yx4eT+xGahgkcObN+5c8DR8srXJzITwJEqTWEu2wal/8EZ7MZi36bioNKxZLx1MvWdR
 NNQnRZ5pcfkFWfPZLBBEHlVHvsD+Frq/Bovsg/slXVdPSCzkotaHRcbfqOG816cPXMOvVG
 B8ScrlKPjkNaeBIkTfNCMbmxUDwSp+w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-tqY2jBx0OESPQEXQv7xKOA-1; Mon, 26 Jun 2023 08:28:00 -0400
X-MC-Unique: tqY2jBx0OESPQEXQv7xKOA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31283f7f2d1so1851183f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782479; x=1690374479;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M8S9j0Q9MSKKbWjgTlZzkGY9Jb2O2eOGPudQd2ZsdWw=;
 b=higLN6648f5kkmZ2ATltIhl/z+uz6piDrliu5B/N6k+P7E3In26OwydBabsZrKUUV4
 NeeXEMszqogvEE67VnOSEQDFssUeQTV3IMl987pE+gjksaIODjqE7oQntHlbSbWSwHfn
 lauyzi8mQA+OV1a0toNlwY59G7RX7jan75je+GVzeU+OW0zDpygxcT1+pkQ5JRuGCtsx
 zsS+lTkEp4yXjziT65ZUtqeUWv23znsFTHK/S+mkhP2sC4lNWYdBH3eW16X/15aNWf1S
 MG1VjCklucwpnmRe44XQ20T4qYHvLgIwCDLAc92yh6Z2FzMjLBJvu+jrWYiIt7StF5il
 afPw==
X-Gm-Message-State: AC+VfDwH+y9JdAwek3eBiNy590PqT5Ej7qVkdV3LganteRmPT5vPw9H7
 P0KE2JSQni69BoO0ErUQJeya7VrP0HahSy62qv8gQY3j1rtGhKOSp7DJICnq20LKehfK11khey9
 ZLXQ7xUvJEAn2nycxAMBMrgsBFpJMcSs7dvFxcDLSCXtppE/1SLFJ9RA2XAAkUUMChElt
X-Received: by 2002:adf:e441:0:b0:313:f45f:74a1 with SMTP id
 t1-20020adfe441000000b00313f45f74a1mr1321502wrm.51.1687782478846; 
 Mon, 26 Jun 2023 05:27:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7rGrrCEZ+E2ktxrZVeu9ZadTeEiMbcT3rnI+FQhNcLqfnf0PEr2kwZmnoABi3YrFTbLWR0wg==
X-Received: by 2002:adf:e441:0:b0:313:f45f:74a1 with SMTP id
 t1-20020adfe441000000b00313f45f74a1mr1321490wrm.51.1687782478477; 
 Mon, 26 Jun 2023 05:27:58 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 f2-20020a5d5682000000b00313ec7dd652sm4406617wrv.44.2023.06.26.05.27.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:27:58 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:27:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ira Weiny <ira.weiny@intel.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 03/53] hw/cxl: Add poison injection via the mailbox.
Message-ID: <ff04b207a0525b3f77b6352ce3a2e610b11ea34f.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687782442.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Very simple implementation to allow testing of corresponding
kernel code. Note that for now we track each 64 byte section
independently.  Whilst a valid implementation choice, it may
make sense to fuse entries so as to prove out more complex
corners of the kernel code.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20230526170010.574-4-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-mailbox-utils.c | 42 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 1f74b26ea2..6c476ad7f4 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -64,6 +64,7 @@ enum {
         #define SET_LSA       0x3
     MEDIA_AND_POISON = 0x43,
         #define GET_POISON_LIST        0x0
+        #define INJECT_POISON          0x1
 };
 
 /* 8.2.8.4.5.1 Command Return Codes */
@@ -472,6 +473,45 @@ static CXLRetCode cmd_media_get_poison_list(struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static CXLRetCode cmd_media_inject_poison(struct cxl_cmd *cmd,
+                                          CXLDeviceState *cxl_dstate,
+                                          uint16_t *len_unused)
+{
+    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
+    CXLPoisonList *poison_list = &ct3d->poison_list;
+    CXLPoison *ent;
+    struct inject_poison_pl {
+        uint64_t dpa;
+    };
+    struct inject_poison_pl *in = (void *)cmd->payload;
+    uint64_t dpa = ldq_le_p(&in->dpa);
+    CXLPoison *p;
+
+    QLIST_FOREACH(ent, poison_list, node) {
+        if (dpa >= ent->start &&
+            dpa + CXL_CACHE_LINE_SIZE <= ent->start + ent->length) {
+            return CXL_MBOX_SUCCESS;
+        }
+    }
+
+    if (ct3d->poison_list_cnt == CXL_POISON_LIST_LIMIT) {
+        return CXL_MBOX_INJECT_POISON_LIMIT;
+    }
+    p = g_new0(CXLPoison, 1);
+
+    p->length = CXL_CACHE_LINE_SIZE;
+    p->start = dpa;
+    p->type = CXL_POISON_TYPE_INJECTED;
+
+    /*
+     * Possible todo: Merge with existing entry if next to it and if same type
+     */
+    QLIST_INSERT_HEAD(poison_list, p, node);
+    ct3d->poison_list_cnt++;
+
+    return CXL_MBOX_SUCCESS;
+}
+
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_DATA_CHANGE (1 << 2)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -501,6 +541,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
         ~0, IMMEDIATE_CONFIG_CHANGE | IMMEDIATE_DATA_CHANGE },
     [MEDIA_AND_POISON][GET_POISON_LIST] = { "MEDIA_AND_POISON_GET_POISON_LIST",
         cmd_media_get_poison_list, 16, 0 },
+    [MEDIA_AND_POISON][INJECT_POISON] = { "MEDIA_AND_POISON_INJECT_POISON",
+        cmd_media_inject_poison, 8, 0 },
 };
 
 void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
-- 
MST


