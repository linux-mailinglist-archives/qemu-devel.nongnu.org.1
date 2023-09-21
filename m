Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C72FA7A9254
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 09:56:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjEWs-0005MU-5P; Thu, 21 Sep 2023 03:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjEWp-0005Do-Iy
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:55:15 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjEWo-0001bZ-4F
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:55:15 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1c43b4b02c1so4863655ad.3
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 00:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1695282912; x=1695887712;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XX44FJTRZg1+PqvDSJfTem/Daafu9UBqtypGiG20los=;
 b=Xiu58dMx0B9Fc/r5Z3RdTkehv/FiFaR6zcLtX2sVpFyPSQLfFMaz17Izc0A1cjQP8N
 er26ahePyCLEU1phXB4Bxiws+c/zGLwOQiOmCjt1gvNXJPPvp7TYWYitehW1M3O9pwGm
 S2lLNBsJ9imR8QPnhFh0eLmlPD3vywOBympuDkwAcBhHNowTpBmJiExyck7H6hA8pQ3O
 qNmpOmz2MvBXNbtQgSKThcZ/BRxCpKQ6+CUARMxn0iSkd9tYCkPQ9/DysxAhiB7tUWu6
 xtvhVjtaQh0cjVPA9e4bcC86sYOP4craluE+RVcnTfEi5bAS6Sq8mjHpS+JfLw7KsikA
 0efg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695282912; x=1695887712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XX44FJTRZg1+PqvDSJfTem/Daafu9UBqtypGiG20los=;
 b=iCBWki62W7KImPGcqVh8IyZvAG3v0FGFc+ZXTOySb08m7HpEQE2v8tTOy515mGETTG
 pIYB2z1zOacwFlZh1wMnhtaCHNj46oQ3jvqqfyTa0c0/JVCFw1ud3Jm99/v34FzXVDPw
 BQ143mnoLruF4C4XOSwenMelIijRSiJkB+cdqQeGoKHoCyWG3FBep2RogeidWt1jjhiv
 4/88YNMorevvMba2x/6bU0c2elJHC2i7uVfCkJiFfiomC2JsZpobr5dY8Ue1/13iUWtT
 mShPhjaL1x0G3dnQKpU6gbR0k75m5XBJyAFPq/4aoG2UwqldCTPS48/T5Yp+9ATC/26D
 lugg==
X-Gm-Message-State: AOJu0YxPizOJCtvz6X9AgXx6oy1MqR8AQYcYXDh2FiWu3CJ9dLMml0Xh
 UAjSqM19KTV6VNK66M1z7VecJNcVN2ipnOufZM4=
X-Google-Smtp-Source: AGHT+IFaMWHOap2ToMQvy7EHn6kd0Y5gSGrQAOHSWgcsq1JpvrbwAPPU3om6Od7R1Po2vNL5tOG/xQ==
X-Received: by 2002:a17:902:76ca:b0:1b8:94e9:e7cb with SMTP id
 j10-20020a17090276ca00b001b894e9e7cbmr3865066plt.21.1695282912682; 
 Thu, 21 Sep 2023 00:55:12 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:a840:1e00:d54:e521:8bac:7bed])
 by smtp.gmail.com with ESMTPSA id
 p22-20020a170902a41600b001ae0152d280sm761928plq.193.2023.09.21.00.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 00:55:12 -0700 (PDT)
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
Subject: [PATCH v3 6/8] module: Use qemu_get_runtime_dir()
Date: Thu, 21 Sep 2023 16:54:20 +0900
Message-ID: <20230921075425.16738-7-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230921075425.16738-1-akihiko.odaki@daynix.com>
References: <20230921075425.16738-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
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

qemu_get_runtime_dir() is used to construct the path to module upgrades.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 util/module.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/util/module.c b/util/module.c
index 32e263163c..580658edf4 100644
--- a/util/module.c
+++ b/util/module.c
@@ -242,7 +242,8 @@ int module_load(const char *prefix, const char *name, Error **errp)
     version_dir = g_strcanon(g_strdup(QEMU_PKGVERSION),
                              G_CSET_A_2_Z G_CSET_a_2_z G_CSET_DIGITS "+-.~",
                              '_');
-    dirs[n_dirs++] = g_strdup_printf("/var/run/qemu/%s", version_dir);
+    g_autofree char *run = qemu_get_runtime_dir();
+    dirs[n_dirs++] = g_build_filename(run, "qemu", version_dir, NULL);
 #endif
     assert(n_dirs <= ARRAY_SIZE(dirs));
 
-- 
2.41.0


