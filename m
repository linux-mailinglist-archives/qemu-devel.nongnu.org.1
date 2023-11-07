Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0602E7E3899
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:15:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J5y-0005KV-VI; Tue, 07 Nov 2023 05:14:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J5s-0005Jn-L9
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:14:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J5q-0002yu-Vh
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:14:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699352038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T3yrgrl0RNeE158j1VrBs7i+P3sJ2jz/GXI+atYLlO4=;
 b=OG7RUJgLO89skzjk6rUIC+ruJ4mnqEKNfpyjw6XAS5CQIzwgbglH9faAsD+FlnxDD1ZJvE
 /H+2n0NEgO6wboZDuNoWy3+dlvCdh6Zh0n3sdfptBRhK//8TjfZSO5iPhmuhVg36Kz5/vB
 53vHSbQxPFS4TQAxcrJI8MBrH9tPVdY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-pmBxll1SPwi3QO5_JsyDwQ-1; Tue, 07 Nov 2023 05:13:56 -0500
X-MC-Unique: pmBxll1SPwi3QO5_JsyDwQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4091c9bdb8eso39683545e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:13:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699352035; x=1699956835;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T3yrgrl0RNeE158j1VrBs7i+P3sJ2jz/GXI+atYLlO4=;
 b=MpI3JsldpWnRrOUmtlTJC9luIq4mjQClhkyVds+hCH0wP4kjb4Cfuwyu/gXvId71z/
 2WDdHRoKN2NsAZOTqY/7C+6I9XLHmzq6Ldsr2ZFFrPiXnKy4TRfEq3s7xQU2+GG8Ol7M
 v+IAkKTjJr2GauoGvI5SxmPYufTxHreCKq7Jm9ItZVEB5h+TyE7w4tDlrlDGDw29A3m8
 mvdW1lX+n5Bq5N5Li7YUKGf06PhxMCtelh+JXPVnD/3/a0xtWeHVykPoQBc6oh7RP86r
 4d+XCyx7xKeozGkRk/hpdPuOWBeT9OQMYtqV9qb6Av2r9hIILfoAA10FptWKIpwZzkLt
 6ztg==
X-Gm-Message-State: AOJu0YxJJhY7mUzWEBegAiEUhP39lXjVIvjUeqDUk2Kzq2XGmVrkHbWw
 bddAV7EaCx8qFABNVZWH3Kvr2rmMA/Kg8nDGpk9X91lpEnxwBa6CZVNbDHr1wCunvqsX3vVGpun
 rBBxVNeL7LgF8T0FFaRmM7FWpHr2uQB8SKxZTKzfolD8k/sEFtssBuna9qNo3C989bJ4Q
X-Received: by 2002:a05:600c:1c88:b0:403:c70b:b688 with SMTP id
 k8-20020a05600c1c8800b00403c70bb688mr2508416wms.6.1699352035302; 
 Tue, 07 Nov 2023 02:13:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlOMJI+8W9imy3CGGC/+bkkM98TG1diHkXe09GmjgFY6NrcGfqSLsPaZ28CFGwUG+K1ye0EA==
X-Received: by 2002:a05:600c:1c88:b0:403:c70b:b688 with SMTP id
 k8-20020a05600c1c8800b00403c70bb688mr2508393wms.6.1699352034971; 
 Tue, 07 Nov 2023 02:13:54 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 z2-20020adfec82000000b003232380ffd5sm1923146wrn.106.2023.11.07.02.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:13:54 -0800 (PST)
Date: Tue, 7 Nov 2023 05:13:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 60/63] hw/cxl: Add dummy security state get
Message-ID: <44e4b316e4bf8f7327f3917c25aae38172695680.1699351720.git.mst@redhat.com>
References: <cover.1699351720.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1699351720.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Needed to allow the santize comamnds to be tested with proposed Linux Kernel
support.  Default value + no control of the security state will work for now.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20231023160806.13206-17-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-mailbox-utils.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 2b78136588..693c2cbdcd 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -73,6 +73,8 @@ enum {
     SANITIZE    = 0x44,
         #define OVERWRITE     0x0
         #define SECURE_ERASE  0x1
+    PERSISTENT_MEM = 0x45,
+        #define GET_SECURITY_STATE     0x0
     MEDIA_AND_POISON = 0x43,
         #define GET_POISON_LIST        0x0
         #define INJECT_POISON          0x1
@@ -886,6 +888,19 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
     }
 }
 
+static CXLRetCode cmd_get_security_state(const struct cxl_cmd *cmd,
+                                         uint8_t *payload_in,
+                                         size_t len_in,
+                                         uint8_t *payload_out,
+                                         size_t *len_out,
+                                         CXLCCI *cci)
+{
+    uint32_t *state = (uint32_t *)payload_out;
+
+    *state = 0;
+    *len_out = 4;
+    return CXL_MBOX_SUCCESS;
+}
 /*
  * This is very inefficient, but good enough for now!
  * Also the payload will always fit, so no need to handle the MORE flag and
@@ -1132,6 +1147,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
         ~0, IMMEDIATE_CONFIG_CHANGE | IMMEDIATE_DATA_CHANGE },
     [SANITIZE][OVERWRITE] = { "SANITIZE_OVERWRITE", cmd_sanitize_overwrite, 0,
         IMMEDIATE_DATA_CHANGE | SECURITY_STATE_CHANGE | BACKGROUND_OPERATION },
+    [PERSISTENT_MEM][GET_SECURITY_STATE] = { "GET_SECURITY_STATE",
+        cmd_get_security_state, 0, 0 },
     [MEDIA_AND_POISON][GET_POISON_LIST] = { "MEDIA_AND_POISON_GET_POISON_LIST",
         cmd_media_get_poison_list, 16, 0 },
     [MEDIA_AND_POISON][INJECT_POISON] = { "MEDIA_AND_POISON_INJECT_POISON",
-- 
MST


