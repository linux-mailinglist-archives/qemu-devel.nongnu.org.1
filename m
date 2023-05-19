Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F43709A6F
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:50:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01R5-0007FJ-C9; Fri, 19 May 2023 10:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01R2-0007Bj-HU
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:50:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01R1-0003WQ-16
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SJKuAz/JWMsZ+1DzNWbmPjnID9bsDA/kvaU7AtGkj/E=;
 b=feVv68OlFNzfnZYMHopd9KYcLXUjlqPYMTuJOZQ0ZXTbk4sz2wmUyQz0QVnrBgI85zUSzH
 5aVRuZwpx6Otpen6A3vMplNSqkOC6ilmbeCZg1bGUH4ajISHyPLnw4ZtEE+LTaWBlNjh2z
 IYE6PMv8apDBlcujqgqdUCRxockFxf4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-XowbH-SSNDqWIqs_y6BTgQ-1; Fri, 19 May 2023 10:50:20 -0400
X-MC-Unique: XowbH-SSNDqWIqs_y6BTgQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2af207a45bfso7173281fa.0
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507818; x=1687099818;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SJKuAz/JWMsZ+1DzNWbmPjnID9bsDA/kvaU7AtGkj/E=;
 b=CmTH4/6GPHBhe29lt2mqqFBIPalNDo28xhxNj8Zn0SpA0r+Y6aYMdBRXlBi6sATyyj
 fKAKFKee2ITkwhsvef0cvOdFu272RJ7cx8L03wOwWIHLTwpWODYGbkMY8G3qD+bsPSLz
 rhz5aM86tdubj2rBEolKYbGvNQCRJjwUwd5YNEIIPNMYTmKgYgWZyUHEJ4qF2MrwB/nJ
 z7tusl0GNO1OZhJjvclYBmMHAdDfeYnuVESxl9GLuzOa/+ikggsHcWTDPNDsceI8c1fd
 c6BbB/b4QgrQx1QSIB9Xs9oH9nJu0ExPwvCkd/Qt23mKknStAy0orviJXLzX4vALt4DM
 m8ww==
X-Gm-Message-State: AC+VfDxjS+9J69lOXIIWJ9RLMpGNIim5ZSf7oIOlDtOiXM0sSPNt0lxG
 kLKX8YBdqfxHinFd8WaGqJdANRpHctYpVJRp8zLaWMmltRhGXD0vQyx3er3Q3qXneOyg9CNxb8z
 cHwI95Q9//LF+ZldJe9pG5I7tE6hYaEghpi2j2y6XmILQR9tdWlkops6/HRuPZJq39QqC
X-Received: by 2002:a2e:320e:0:b0:2a6:1682:3a1e with SMTP id
 y14-20020a2e320e000000b002a616823a1emr903207ljy.31.1684507818716; 
 Fri, 19 May 2023 07:50:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Awntf+GiRpdvXky++sABqbqKt+gwpgE8xRk8JtERdugO8JJfuCyRhrUMBNooKwTmrpVze6A==
X-Received: by 2002:a2e:320e:0:b0:2a6:1682:3a1e with SMTP id
 y14-20020a2e320e000000b002a616823a1emr903198ljy.31.1684507818456; 
 Fri, 19 May 2023 07:50:18 -0700 (PDT)
Received: from redhat.com ([176.12.184.180]) by smtp.gmail.com with ESMTPSA id
 q5-20020a2e9145000000b002addd80bc8csm831276ljg.66.2023.05.19.07.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:50:17 -0700 (PDT)
Date: Fri, 19 May 2023 10:50:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fan Ni <fan.ni@samsung.com>
Subject: [PULL 08/40] hw/cxl: Fix endian handling for decoder commit.
Message-ID: <92ff7cabf97d9942ebaeafed6747dc18c8c1f697.1684507742.git.mst@redhat.com>
References: <cover.1684507742.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1684507742.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Not a real problem yet as all supported architectures are
little endian, but continue to tidy these up when touching
code for other reasons.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Message-Id: <20230421135906.3515-3-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-component-utils.c | 8 ++++----
 hw/mem/cxl_type3.c           | 9 ++++++---
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index 324be79b11..a3e6cf75cf 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -47,12 +47,12 @@ static void dumb_hdm_handler(CXLComponentState *cxl_cstate, hwaddr offset,
         break;
     }
 
-    stl_le_p((uint8_t *)cache_mem + offset, value);
     if (should_commit) {
-        ARRAY_FIELD_DP32(cache_mem, CXL_HDM_DECODER0_CTRL, COMMIT, 0);
-        ARRAY_FIELD_DP32(cache_mem, CXL_HDM_DECODER0_CTRL, ERR, 0);
-        ARRAY_FIELD_DP32(cache_mem, CXL_HDM_DECODER0_CTRL, COMMITTED, 1);
+        value = FIELD_DP32(value, CXL_HDM_DECODER0_CTRL, COMMIT, 0);
+        value = FIELD_DP32(value, CXL_HDM_DECODER0_CTRL, ERR, 0);
+        value = FIELD_DP32(value, CXL_HDM_DECODER0_CTRL, COMMITTED, 1);
     }
+    stl_le_p((uint8_t *)cache_mem + offset, value);
 }
 
 static void cxl_cache_mem_write_reg(void *opaque, hwaddr offset, uint64_t value,
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 7647122cc6..a2a9b17dbb 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -314,14 +314,17 @@ static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
 {
     ComponentRegisters *cregs = &ct3d->cxl_cstate.crb;
     uint32_t *cache_mem = cregs->cache_mem_registers;
+    uint32_t ctrl;
 
     assert(which == 0);
 
+    ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL);
     /* TODO: Sanity checks that the decoder is possible */
-    ARRAY_FIELD_DP32(cache_mem, CXL_HDM_DECODER0_CTRL, COMMIT, 0);
-    ARRAY_FIELD_DP32(cache_mem, CXL_HDM_DECODER0_CTRL, ERR, 0);
+    ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMIT, 0);
+    ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, ERR, 0);
+    ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 1);
 
-    ARRAY_FIELD_DP32(cache_mem, CXL_HDM_DECODER0_CTRL, COMMITTED, 1);
+    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL, ctrl);
 }
 
 static int ct3d_qmp_uncor_err_to_cxl(CxlUncorErrorType qmp_err)
-- 
MST


