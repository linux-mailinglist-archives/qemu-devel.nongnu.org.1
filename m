Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E687D12A0
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 17:27:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtrO9-0002qj-1y; Fri, 20 Oct 2023 11:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qtrO4-0002gw-Tz
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:26:08 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qtrO1-00060c-S5
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:26:08 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1ca74e77aecso15647035ad.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 08:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1697815443; x=1698420243;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IQwXPhv+suUODSVaOFT/uvjWZ0giK1V2oP5SwGbONBE=;
 b=RqJP9v+772MdWdjHpO4nozJWSE9vQ5J+xhrNy4ptLNqHjDY0hj0/2Z0YCDut2Xv1AJ
 aB/pw7Wz2w23WZq3C9GFdncRiOZQowaAt1B1H13MNxitoNM3FOKsvoZQ0h/ciwrNDGRS
 9/9LWdZZhg3koKIceYZ7CH5Ti+D6kZZUX08AurjYlit+ze0oNCOLspEQTc1tywvmTCdy
 uyZBvtB9EeW3CwAXcnoSrm39GBfvHZLzEy4ITQNWv21aJPIFv/q+oFE7XzxqA5Rm7t0A
 aEkwrmNkwnHOu5RY6RTgvcU2Sy+IelDLat5y++jCiVzvcl5oP0nsbMwQ5FsjtVT4yfyO
 cYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697815443; x=1698420243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IQwXPhv+suUODSVaOFT/uvjWZ0giK1V2oP5SwGbONBE=;
 b=DRfxeYvJDj+Yx9RHBuBqDalBC3EVGC9cICmoExUrxNmrmL2qEiNk/UiCsvkdoAiNbQ
 mqCZcBvKQY6970NIxIrvuGp87BhdnGXqbWIZT4FGoM1Eiu6WHXIZUo8b7pBazaGdvLGZ
 Dx/GmDbrngJBTEMf9bBNsg1nAHaR43AgL9agMbqADnHq4JUvnjPzkateTx+JlqM2AufJ
 I7vSxMjMgjFdnE8fECJrOhiPLhnVTnCEe0/vCPQzck+TMpL9KVP7sW91QCcleIrxs/CE
 4BS3rFgwqmRGbXsIR2U3Hg3WX1Ok47FGpkVkKH4AvaoOLYMewcmIInZTu48bF6JOsnOV
 oQfA==
X-Gm-Message-State: AOJu0Yxk9bgXGpR2IFSkaagUWhK3dKvhFP6cxp771Xr6c20Napwv5lt7
 ElX3szUnFimyfOLu+dPPD3npIycTpL5Pt5EsroyPcE4V
X-Google-Smtp-Source: AGHT+IHombyZ6D0T+fsB2qGSszQFtb8Ux1CIfsamDAyWx1cmZqAeFOuQ9q1d5NshrXxkcxOjAnD8/g==
X-Received: by 2002:a17:903:1c3:b0:1c7:22ae:4080 with SMTP id
 e3-20020a17090301c300b001c722ae4080mr2878261plh.0.1697815443264; 
 Fri, 20 Oct 2023 08:24:03 -0700 (PDT)
Received: from localhost.localdomain ([171.216.79.181])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a170902cec400b001c60d0a6d84sm1644824plg.127.2023.10.20.08.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 08:24:03 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [v2 1/6] system/dirtylimit: Fix a race situation
Date: Fri, 20 Oct 2023 23:23:43 +0800
Message-Id: <f25558b3d94083ce6909da5b5cfb922ae5935626.1697815117.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1697815117.git.yong.huang@smartx.com>
References: <cover.1697815117.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Fix a race situation for global variable dirtylimit_state.

Also, replace usleep by g_usleep to increase platform
accessibility to the sleep function.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 system/dirtylimit.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/system/dirtylimit.c b/system/dirtylimit.c
index fa959d7743..3666c4cb7c 100644
--- a/system/dirtylimit.c
+++ b/system/dirtylimit.c
@@ -411,12 +411,20 @@ void dirtylimit_set_all(uint64_t quota,
 
 void dirtylimit_vcpu_execute(CPUState *cpu)
 {
-    if (dirtylimit_in_service() &&
-        dirtylimit_vcpu_get_state(cpu->cpu_index)->enabled &&
-        cpu->throttle_us_per_full) {
-        trace_dirtylimit_vcpu_execute(cpu->cpu_index,
-                cpu->throttle_us_per_full);
-        usleep(cpu->throttle_us_per_full);
+    if (cpu->throttle_us_per_full) {
+        dirtylimit_state_lock();
+
+        if (dirtylimit_in_service() &&
+            dirtylimit_vcpu_get_state(cpu->cpu_index)->enabled) {
+            dirtylimit_state_unlock();
+            trace_dirtylimit_vcpu_execute(cpu->cpu_index,
+                    cpu->throttle_us_per_full);
+
+            g_usleep(cpu->throttle_us_per_full);
+            return;
+        }
+
+        dirtylimit_state_unlock();
     }
 }
 
-- 
2.39.1


