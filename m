Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E82D709AA8
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:57:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01Tn-00075x-RW; Fri, 19 May 2023 10:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01Tj-0006uL-Sb
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:53:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01Tf-0003tT-Pp
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RNlRLeBH0sdjVgB3c/rYKTW280v9Im/ZQre+6tEqB58=;
 b=VX77f6oRITFABemHU16KE5DkQk1twvWwyikf9JdsEsaVz/OMrTuxlmtJkD9Cj5ZHetTIh9
 6TqPzDaftRkuxLDYTYrYeZfTYIfqH9MWLl859Ofut2HKN/t8VEGHLzEDVf8Buy1Jx9BlAB
 R1cEpwCMQGwUDscHDO5pXbIa+pouzjs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-EczBs_2kOzKYyvkWhlKaVg-1; Fri, 19 May 2023 10:53:06 -0400
X-MC-Unique: EczBs_2kOzKYyvkWhlKaVg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4f251247084so2217543e87.3
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507984; x=1687099984;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RNlRLeBH0sdjVgB3c/rYKTW280v9Im/ZQre+6tEqB58=;
 b=KxglCQaBcxMhp1wYKbBEsl42maR030pkE0ta4UNQ5+GRkwLRjIEOw01H8q1EiEdqkK
 oYBWzcmEeupgbQEevM453lk8u6BYwdEdmeo1gygxZRHPbBL4I1fbyhuy7TvM9AoxP4xA
 zesJ2NSgKLsECPILwHmE1D7iICkV5/b0tPUsLCAhzxLM67fZUL/0jfhsHAVLuRWajB6q
 Wb+0zZ1rOCAL1e5X88JIG90Oqd3dbJRyuDg7HxXpDosN+LjtemUcrcnGhH6vCluOaLNI
 KClo65oILvaTqnPodGRU30p8PIGA7FmsQV3EJOgHoUF8lCwOvINf8cgOlGWlv3mlbNDr
 BmFQ==
X-Gm-Message-State: AC+VfDznkU+wgZgtax4kdhcQWSFK3iiS8Ell5CHhffj27vtMxSGusWlv
 mepVoY5TzuFENYImNkq6x5h/0fPPIkvAvm1SgWBFick5K8LuxQSF3+jfL4RsSGRL7C8N74k4J33
 MvQbgex882gZly9U+soO0ATHkRKCwOjBPdER3aHwMv5ND7/K9muOYoo0aGadddA69u9LM
X-Received: by 2002:ac2:5503:0:b0:4ec:8816:f4fc with SMTP id
 j3-20020ac25503000000b004ec8816f4fcmr870740lfk.6.1684507984052; 
 Fri, 19 May 2023 07:53:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4RKWZNi97LwlIa55UseygQIS9nIJ+Ri1wNFQcNQ5qyG6ZbMb5+hcmKTKUPURdOcj3ZcIvPPQ==
X-Received: by 2002:ac2:5503:0:b0:4ec:8816:f4fc with SMTP id
 j3-20020ac25503000000b004ec8816f4fcmr870731lfk.6.1684507983771; 
 Fri, 19 May 2023 07:53:03 -0700 (PDT)
Received: from redhat.com ([176.12.184.180]) by smtp.gmail.com with ESMTPSA id
 q11-20020ac25a0b000000b004f3b0cf4925sm181248lfn.142.2023.05.19.07.53.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:53:03 -0700 (PDT)
Date: Fri, 19 May 2023 10:52:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ira Weiny <ira.weiny@intel.com>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL 38/40] hw/cxl: Introduce cxl_device_get_timestamp() utility
 function
Message-ID: <547a652fd1e10c2b6a2b9b91084e4c1cea8665a2.1684507742.git.mst@redhat.com>
References: <cover.1684507742.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684507742.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Ira Weiny <ira.weiny@intel.com>

There are new users of this functionality coming shortly so factor
it out from the GET_TIMESTAMP mailbox command handling.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Message-Id: <20230423162013.4535-3-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h |  2 ++
 hw/cxl/cxl-device-utils.c   | 15 +++++++++++++++
 hw/cxl/cxl-mailbox-utils.c  | 11 +----------
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index edb9791bab..02befda0f6 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -287,4 +287,6 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
 MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
                             unsigned size, MemTxAttrs attrs);
 
+uint64_t cxl_device_get_timestamp(CXLDeviceState *cxlds);
+
 #endif
diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 4c5e88aaf5..86e1cea8ce 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -269,3 +269,18 @@ void cxl_device_register_init_common(CXLDeviceState *cxl_dstate)
 
     cxl_initialize_mailbox(cxl_dstate);
 }
+
+uint64_t cxl_device_get_timestamp(CXLDeviceState *cxl_dstate)
+{
+    uint64_t time, delta;
+    uint64_t final_time = 0;
+
+    if (cxl_dstate->timestamp.set) {
+        /* Find the delta from the last time the host set the time. */
+        time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        delta = time - cxl_dstate->timestamp.last_set;
+        final_time = cxl_dstate->timestamp.host_set + delta;
+    }
+
+    return final_time;
+}
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 7b2aef0d67..702e16ca20 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -163,17 +163,8 @@ static CXLRetCode cmd_timestamp_get(struct cxl_cmd *cmd,
                                     CXLDeviceState *cxl_dstate,
                                     uint16_t *len)
 {
-    uint64_t time, delta;
-    uint64_t final_time = 0;
+    uint64_t final_time = cxl_device_get_timestamp(cxl_dstate);
 
-    if (cxl_dstate->timestamp.set) {
-        /* First find the delta from the last time the host set the time. */
-        time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-        delta = time - cxl_dstate->timestamp.last_set;
-        final_time = cxl_dstate->timestamp.host_set + delta;
-    }
-
-    /* Then adjust the actual time */
     stq_le_p(cmd->payload, final_time);
     *len = 8;
 
-- 
MST


