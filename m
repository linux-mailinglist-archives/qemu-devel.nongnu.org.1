Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E83981C711
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 10:02:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGbPA-0005CZ-C8; Fri, 22 Dec 2023 04:01:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <42.hyeyoo@gmail.com>)
 id 1rGbP8-0005CR-R8
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 04:01:14 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <42.hyeyoo@gmail.com>)
 id 1rGbP7-0002Va-7n
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 04:01:14 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6d7395ab92cso1070345b3a.2
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 01:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703235672; x=1703840472; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W2onsigAzJZV8OA9wsWeUj+BIGS+8SDO0C+tc8HGOhY=;
 b=RRYjoOaniViuTlPY5MinFrVurQSIuzE3HhzJoOX54x7rbcW/D0MMuWhIZ5m7PLaBea
 gn5KJZHEUgEeMwC2zFZuahj24md4ELyxnrcWif0Vap2gOHEc36pGfiovBNXKTlAAv/X3
 7i+fzUMtmCSdIOYwIP8NLZ8l/wdSP0Tfs8Z7u+GZvqZbzU4lETk0wpaMjwLBO7Zts1YU
 LQXA/uaWjKYwW9ElIOjeaOQ6Vl9/Z1QRsgPNM5G4eQvH6VsY4EaTiF3D/OtDFDYXchrx
 QNd3mAMcW70uRYpAXPgQp6OYAoodj+Pp7Q25936YWQYKFadbBs0kPtEDtiSfdlSFhV6T
 Ja+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703235672; x=1703840472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W2onsigAzJZV8OA9wsWeUj+BIGS+8SDO0C+tc8HGOhY=;
 b=kyAexb8Un3PbJYVGV8N2vQD78h4kwO9cdbXAOZLXI9A8EO171TdV2H1zEKwI+nNaLQ
 JrN2ki8RkEY7e9rtwUCFgnqjizXvTy9DrH63BA/WWeQfDCmvOe5dpZgsemxfu6deWVxy
 R0ga2xCyYGr2if6at5M+oClfrw49OhhazQ0alfw7n0s7uRX3l9Wy06xQ4jZc2/G2yQwI
 /MbaKLPDqXtfrqiDBBYqJoKnOpwYnb1wtWYyieDnliTy7hDg2xVgnhHmKNFZPutyDfjZ
 GF+BzY5UFi17PhWQe9DZSnXMDm+Jj44BDFlWOjsZq+SwXfA8L3qvrCensYjSsnAD57Bd
 3x8w==
X-Gm-Message-State: AOJu0YwZ1AdiGnPspCo5t94fHUQlNIJV+3XfHf9sCt/8IG0H+YL6+Iff
 OkC5IHwEp65EZ/2JanUBdLU=
X-Google-Smtp-Source: AGHT+IEQy6RlE35SipM9nNEMtU2PXXoNbifceNoOLuT+BPwv1mrmvRkw2/FTJSVF4OtWawIMnyR29g==
X-Received: by 2002:a05:6a00:e07:b0:6d0:89be:e4a8 with SMTP id
 bq7-20020a056a000e0700b006d089bee4a8mr834227pfb.37.1703235671523; 
 Fri, 22 Dec 2023 01:01:11 -0800 (PST)
Received: from localhost.localdomain ([1.245.180.67])
 by smtp.gmail.com with ESMTPSA id
 f23-20020a056a000b1700b006d990040342sm400560pfu.155.2023.12.22.01.01.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 01:01:10 -0800 (PST)
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <fan.ni@samsung.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-cxl@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 4/4] hw/cxl/events: discard all event records during
 sanitation
Date: Fri, 22 Dec 2023 18:00:51 +0900
Message-Id: <20231222090051.3265307-5-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231222090051.3265307-1-42.hyeyoo@gmail.com>
References: <20231222090051.3265307-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=42.hyeyoo@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Per spec 8.2.9.9.5.1 Sanitize (Opcode 4400h), sanitize command should
delete all event logs. Introduce cxl_discard_all_event_logs() and call
this in __do_sanitization().

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 hw/cxl/cxl-events.c         | 13 +++++++++++++
 hw/cxl/cxl-mailbox-utils.c  |  1 +
 include/hw/cxl/cxl_device.h |  1 +
 3 files changed, 15 insertions(+)

diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
index bee6dfaf14..837b18ab47 100644
--- a/hw/cxl/cxl-events.c
+++ b/hw/cxl/cxl-events.c
@@ -141,6 +141,19 @@ bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
     return cxl_event_count(log) == 1;
 }
 
+void cxl_discard_all_event_records(CXLDeviceState *cxlds)
+{
+    CXLEventLogType log_type;
+    CXLEventLog *log;
+
+    for (log_type = 0; log_type < CXL_EVENT_TYPE_MAX; log_type++) {
+        log = &cxlds->event_logs[log_type];
+        while (!cxl_event_empty(log)) {
+            cxl_event_delete_head(cxlds, log_type, log);
+        }
+    }
+}
+
 CXLRetCode cxl_event_get_records(CXLDeviceState *cxlds, CXLGetEventPayload *pl,
                                  uint8_t log_type, int max_recs,
                                  size_t *len)
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index efeb5f8174..2ade351d82 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1150,6 +1150,7 @@ static void __do_sanitization(CXLType3Dev *ct3d)
             memset(lsa, 0, memory_region_size(mr));
         }
     }
+    cxl_discard_all_event_records(&ct3d->cxl_dstate);
 }
 
 /*
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 5618061ebe..8f05dd9beb 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -604,6 +604,7 @@ CXLRetCode cxl_event_get_records(CXLDeviceState *cxlds, CXLGetEventPayload *pl,
                                  size_t *len);
 CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds,
                                    CXLClearEventPayload *pl);
+void cxl_discard_all_event_records(CXLDeviceState *cxlds);
 
 void cxl_event_irq_assert(CXLType3Dev *ct3d);
 
-- 
2.39.3


