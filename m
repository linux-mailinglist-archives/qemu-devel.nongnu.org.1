Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F33DB7A925B
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 09:57:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjEWq-0005GA-JQ; Thu, 21 Sep 2023 03:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjEWn-00052Q-Ek
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:55:13 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjEWi-0001Yc-Fc
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:55:13 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-577e62e2adfso445262a12.2
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 00:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1695282907; x=1695887707;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+WqIB3gVUWoV5tx6z3hTNmJPFl9aZDKmRqWqmbRKnMA=;
 b=FFIEwVfxYB+xKtooGZOVBfL3PkYJ07EVXtdeD/wexaDkpNM6eP7neCJxUVA4+8N/wi
 jBoo1qoHKqW8OMj9lV7CohyL6DAxssgXgIDuT0r679sUh5Him9uorQBzFpDPyQrJXwiu
 Z9CvHo6Mw3SzX/Cm0h2DaI71ZvCcuV2OElKKCnm3nvw2B9tASopQVZIXsihcwJEXQhgB
 ahcnfRflSMaqt1E2rW4U39o8hfHDZlV0mBxq8bxPI+NO91hsxuHim1CsPxfcXbFI7BzZ
 w9fCFPxBuqIlbRCbzeWh+dCe2Lp7YBJKYLc9byvlroR9JykuG/egNdt7guuBcaQm4AVH
 tclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695282907; x=1695887707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+WqIB3gVUWoV5tx6z3hTNmJPFl9aZDKmRqWqmbRKnMA=;
 b=PP2ws2yEJrbbdLwz8+R/kCayB1OJaSaZ8Bptw1F3ebWnKisqqVA5ROiK4sARAAdSaG
 aCkZzujYk29XCJtsTr3NXAkO6F26u244B0Vh7rh3EUXPsOTQZsoVBfpDjPRJK96Jeo06
 lPBhjp2MO7+3U+L73im42NGTYgiH99CW0hRQWJv3xVBbT7t9mkhgSO3FHzG0nlq2/6Qs
 x59WF4dXwpPITsvSd5MiyBJCPUNmzhJHYsnYPZ/hthbBk7qCkaTROqoWYAtivVtrc8Th
 yi6Z53W7i/23/uFRVfIv4zpH/d7IZJD093rjIwxStej7TpcGIesC3zkUTUkFkm8GabI2
 pPlA==
X-Gm-Message-State: AOJu0YyQwHH+ggHhK3Dt6+h7lLOlnWrfEUHCutk2Hjnv1GuFOtrpsoR5
 Sy6eHCVtzD4ix4Ezycf1QvGcXPcaYK8rxPTIlew=
X-Google-Smtp-Source: AGHT+IFHgpi8n1ftI8b8mX73/Pv7vz9W3FemR7w2fHwwL5FQ+bU4wAzGGFj7DblErRboprKwJ3dP1w==
X-Received: by 2002:a05:6a20:8e1c:b0:14b:8b82:867f with SMTP id
 y28-20020a056a208e1c00b0014b8b82867fmr5250370pzj.50.1695282907100; 
 Thu, 21 Sep 2023 00:55:07 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:a840:1e00:d54:e521:8bac:7bed])
 by smtp.gmail.com with ESMTPSA id
 p22-20020a170902a41600b001ae0152d280sm761928plq.193.2023.09.21.00.55.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 00:55:06 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, virtio-fs@redhat.com,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Yan Vugenfirer <yan@daynix.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 5/8] scsi: Use qemu_get_runtime_dir()
Date: Thu, 21 Sep 2023 16:54:19 +0900
Message-ID: <20230921075425.16738-6-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230921075425.16738-1-akihiko.odaki@daynix.com>
References: <20230921075425.16738-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

qemu_get_runtime_dir() is used to construct the default paths.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 scsi/qemu-pr-helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index c6c6347e9b..507f23357f 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -77,10 +77,10 @@ static int gid = -1;
 
 static void compute_default_paths(void)
 {
-    g_autofree char *state = qemu_get_local_state_dir();
+    g_autofree char *run = qemu_get_runtime_dir();
 
-    socket_path = g_build_filename(state, "run", "qemu-pr-helper.sock", NULL);
-    pidfile = g_build_filename(state, "run", "qemu-pr-helper.pid", NULL);
+    socket_path = g_build_filename(run, "qemu-pr-helper.sock", NULL);
+    pidfile = g_build_filename(run, "qemu-pr-helper.pid", NULL);
 }
 
 static void usage(const char *name)
-- 
2.41.0


