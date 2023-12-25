Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C088181DFBE
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 11:33:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHiFN-0004ng-6V; Mon, 25 Dec 2023 05:31:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHiFK-0004l9-MA
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 05:31:42 -0500
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHiFI-0004Zz-Cp
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 05:31:42 -0500
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-20451bc39b1so1654922fac.1
 for <qemu-devel@nongnu.org>; Mon, 25 Dec 2023 02:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1703500179; x=1704104979;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WeF3E7gf1g1svhMIpp3o+EpIDMjRXokZjkcxahDEHHA=;
 b=zVMmpfFqoLgEXzmbHpscHIzNOkr0f2pHBx1pzetrVwIQiQ/I2riMkPAUC2nEppPMAW
 LJA9eUg1jffS0cbQui+98KU9patvwOS7sOZ7glJAWchNsWGgIL+m+m6c1qND1EIEAs/t
 SI9QBsICYJZc0m200hbvzDkP8qPtJk6sUN3UbWaKnhpywXwuoNKIU+ON2A1E9sD3G5jx
 lbro+aU9GQSgEq5SQD127U4+7FpSdPV5O4ySnE9l9VUR02RcKw7i5El663r7ZnZQlEl8
 I221CKJ7Sc1DCt0DV6C0xDv8DTXlQkCZRjD3xosRlz97qOo+PtDyFk2c8TaJVNw7fMc+
 SdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703500179; x=1704104979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WeF3E7gf1g1svhMIpp3o+EpIDMjRXokZjkcxahDEHHA=;
 b=ND4O8OKMR2n42SIqRPlAZhU87hR6yL+OyXSi9WKA8gNrzSZHxR9LiTpNUPr+o9j/om
 ZuRmwbY5Empp7wJ4kB112ATkI7zSoRu8N0SoSWVWheJMoVdTW6Hju11/rsNlPYFrfblw
 jqCJWbM67wIFhHQGFCYvcH3SYYaijwGBkaNtuM2KA7aiNYj0Ee0kRUBbwVHk7cxuUVS4
 yhKAtoQbXUlNClHfb4m4kTN/dfKR71fxyAWx9sPWXFPbrljaYXYxUF7DuTzUBaC9C4wX
 +/Inmo1y7RYfJQhfSF6PNMAmm2ku0Lh8wbM7HNkYavbFJYhDmwyCid7yB8T9tDj7Y+Kn
 tVIQ==
X-Gm-Message-State: AOJu0YwR+7MGzURaVQcQLcq2utfL2FxQBdbLmxzur2D4f0OoWMmP9iOU
 mZ2cvMhm91OkZIlmxc6MGey8c6CclmxZgD5ksmAHW/3NMlPmwg==
X-Google-Smtp-Source: AGHT+IFZYDYGNoqv3FpnjF920Nw0+fZHbTH1Gpsl1NZEiz4McBevVlCju8V1cVVZlH7hNUQ16FCkJg==
X-Received: by 2002:a05:6871:8913:b0:1fb:75a:6d3c with SMTP id
 ti19-20020a056871891300b001fb075a6d3cmr7218264oab.99.1703500178227; 
 Mon, 25 Dec 2023 02:29:38 -0800 (PST)
Received: from localhost.localdomain ([118.114.58.28])
 by smtp.gmail.com with ESMTPSA id
 w2-20020a654102000000b005c21c23180bsm6139906pgp.76.2023.12.25.02.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Dec 2023 02:29:37 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: yong.huang@smartx.com,
	Wafer <wafer@jaguarmicro.com>
Subject: [PULL 1/1] migration/dirtyrate: Remove an extra parameter
Date: Mon, 25 Dec 2023 18:29:27 +0800
Message-Id: <4918712fb1c34ae43361b402642e426be85a789e.1703499705.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1703499705.git.yong.huang@smartx.com>
References: <cover.1703499705.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2001:4860:4864:20::31;
 envelope-from=yong.huang@smartx.com; helo=mail-oa1-x31.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Wafer <wafer@jaguarmicro.com>

vcpu_dirty_stat_collect() has an unused parameter so remove it.

Signed-off-by: Wafer <wafer@jaguarmicro.com>
Reviewed-by: Hyman Huang <yong.huang@smartx.com>
Message-Id: <20231204012230.4123-1-wafer@jaguarmicro.com>
---
 migration/dirtyrate.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 036ac017fc..62d86b8be2 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -129,8 +129,7 @@ static DirtyPageRecord *vcpu_dirty_stat_alloc(VcpuStat *stat)
     return g_new0(DirtyPageRecord, nvcpu);
 }
 
-static void vcpu_dirty_stat_collect(VcpuStat *stat,
-                                    DirtyPageRecord *records,
+static void vcpu_dirty_stat_collect(DirtyPageRecord *records,
                                     bool start)
 {
     CPUState *cpu;
@@ -158,7 +157,7 @@ retry:
     WITH_QEMU_LOCK_GUARD(&qemu_cpu_list_lock) {
         gen_id = cpu_list_generation_id_get();
         records = vcpu_dirty_stat_alloc(stat);
-        vcpu_dirty_stat_collect(stat, records, true);
+        vcpu_dirty_stat_collect(records, true);
     }
 
     duration = dirty_stat_wait(calc_time_ms, init_time_ms);
@@ -172,7 +171,7 @@ retry:
             cpu_list_unlock();
             goto retry;
         }
-        vcpu_dirty_stat_collect(stat, records, false);
+        vcpu_dirty_stat_collect(records, false);
     }
 
     for (i = 0; i < stat->nvcpu; i++) {
-- 
2.39.1


