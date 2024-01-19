Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7BD832D4B
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 17:36:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQrpx-0000m1-6F; Fri, 19 Jan 2024 11:35:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQrpv-0000l4-8b
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 11:35:19 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQrpt-0004m2-8T
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 11:35:18 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40e80046246so6126805e9.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 08:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705682115; x=1706286915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MYGIrHOejkd+TofSo5x+fRzzFA+cgX19jZT/zdJeLDM=;
 b=egGM0n7W9XpUmX/dzkHLLd8hXL3xw3SFZLTDJVo4v9LF0eqLD0kzyVYc8frJwVewBe
 pqbHKgKiBp/v5rmbbl/l3pT+qbhi8PwsqF300obrsiqK73CxEzTkWyv1B2Bx8hGDrrMI
 HNGWLPVU0FMstANtTE2JiiOvMXVWWfm5IPt2G+rnLINGIaeFAXiFRDl6vE/0Ig7Y41jp
 7p5C/XHmPmcWerh/qjXQQeTiiP3ZAogaaEEDngF/OcOp70upJZ5Jmy9IoChp3bM2lC8v
 dr7PX9GYeeySQCQtGOneR16S2D8vKWnQM3ITZhri0x3TY1zB5pOD+zfOM8UjfJxA+vcV
 EkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705682115; x=1706286915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MYGIrHOejkd+TofSo5x+fRzzFA+cgX19jZT/zdJeLDM=;
 b=jhWBS+KEAoIVPAzQzcRK8/MrWXbv3AptlJXYBwCFkUtVLS/CAq1ge1/sW2UqjVh1PK
 p0MZt5FvoRXjWqLnwZuUy0dRs2HvB8x6DN3c2KpBCIXw/M1UzDpJEOEKb6NsYSsM2Uk9
 HqJh+vKhP0+p0lc0Hmf/qjGaAX6pSiacF1QN6ibMqFpJfbMQktxdMPL+tbg+k6ZGeo05
 3V0vEDoFN07iIniyT60/R2JtJdFoyQE54eR5GgvV91aGWQvx/04kYqtYD4oPAzlYxoJr
 9otZKnTnx8mRt5i/zkLR4fT+KJ6sTLYuhlCRjqOH7VU9qaMxAkiJdh3Qpp7xJxYfixpn
 IWhw==
X-Gm-Message-State: AOJu0YxJIuhQJrJZWKJ7On6tXdObOAjkniot5npVINgQ/5XAH9bhWU2m
 N9QVHZOV9arib43hDxhKt6KNeakSULMGnDPyLp1kZ0S3X2EwfLJJrqDEoq61pqQI5gohlLtxKJA
 t
X-Google-Smtp-Source: AGHT+IHk6XwwYUwnuq4FdBlD+opHdPAQLyyXaET6Tz3ZtYndE1LHA1FwknIvmcLYTWkJcSHDagjtBQ==
X-Received: by 2002:a7b:c3d5:0:b0:40e:59e9:98d0 with SMTP id
 t21-20020a7bc3d5000000b0040e59e998d0mr91544wmj.154.1705682115808; 
 Fri, 19 Jan 2024 08:35:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 fc11-20020a05600c524b00b0040e86fbd772sm10979260wmb.38.2024.01.19.08.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 08:35:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/5] adb: Switch bus reset to 3-phase-reset
Date: Fri, 19 Jan 2024 16:35:10 +0000
Message-Id: <20240119163512.3810301-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119163512.3810301-1-peter.maydell@linaro.org>
References: <20240119163512.3810301-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Switch the ADB bus from using BusClass::reset to the Resettable
interface.

This has no behavioural change, because the BusClass code to support
subclasses that use the legacy BusClass::reset will call that method
in the hold phase of 3-phase reset.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/input/adb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/input/adb.c b/hw/input/adb.c
index 0f3c73d6d00..98f39b4281a 100644
--- a/hw/input/adb.c
+++ b/hw/input/adb.c
@@ -231,9 +231,9 @@ static const VMStateDescription vmstate_adb_bus = {
     }
 };
 
-static void adb_bus_reset(BusState *qbus)
+static void adb_bus_reset_hold(Object *obj)
 {
-    ADBBusState *adb_bus = ADB_BUS(qbus);
+    ADBBusState *adb_bus = ADB_BUS(obj);
 
     adb_bus->autopoll_enabled = false;
     adb_bus->autopoll_mask = 0xffff;
@@ -262,10 +262,11 @@ static void adb_bus_unrealize(BusState *qbus)
 static void adb_bus_class_init(ObjectClass *klass, void *data)
 {
     BusClass *k = BUS_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     k->realize = adb_bus_realize;
     k->unrealize = adb_bus_unrealize;
-    k->reset = adb_bus_reset;
+    rc->phases.hold = adb_bus_reset_hold;
 }
 
 static const TypeInfo adb_bus_type_info = {
-- 
2.34.1


