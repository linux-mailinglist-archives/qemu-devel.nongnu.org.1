Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEF07EAA29
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 06:42:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2mB8-0007AB-EX; Tue, 14 Nov 2023 00:41:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1r2mB5-00079S-GV
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 00:41:35 -0500
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1r2mB3-0001RO-Lb
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 00:41:34 -0500
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7789aed0e46so347374985a.0
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 21:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1699940493; x=1700545293; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Xr+ydM0w1ChiLZUK2AmzFF5aaNpk3nnn08+T2D9fxos=;
 b=gYG+oihFRbyXIlUjYeqK1xW72wxSkK+NIcWS8NjNRWhLz4D9wG1qjGj1whgU6lUYsP
 0eIyzYEHldNmR7LTvY1VfZ7SeQCe5SJDW8ONXvLHwX5rNcxQCvP4j/HucapY3ofzbsXx
 WYIbpfM4+pTkA7d0/9dPkCv7MONdH2R7cwmL3MzC74aYWoBPkFQSyc+JMuXJPRDebVau
 P0wPcmICJQaYhdiqgnk2o7ImmkFZ25ctLATqavy8yvcgRbnmCrk+Jlt83/v3+vAkPP+c
 WP/V7u2ho+SkNe4g9buKxnp6SI94OMYfo8bwFKu+DZLwvNmsVDP6I9Dud2/wCohDhg2E
 WAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699940493; x=1700545293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xr+ydM0w1ChiLZUK2AmzFF5aaNpk3nnn08+T2D9fxos=;
 b=j1bQchCSPYnUkcIspZbMIZfbxqX85n2w/r1CO1h4SkguGWXNoZIyWiUwFds/HaMiJC
 N12nOVRYVg11gQxjIBFVC4WbdTKzqgrQ4/ljQV2xjHIbmJ1v4NzDtC7DF+jUrxVsy/5F
 YycNvQxAv7CREJYE+E/rRCb/JAouKikDVDb26jazhJqbEjO7aUfQ5KP4QBkth5IIn4H0
 NXOrHEAwnWZZgL8vUHfdBHi6nPA/c/bL3NBTxvoGW4yRfsGAI8wKpQTdNd5fzRle9ihn
 WE8y2r13sES99nT6OMJnLVWB/zYXWbxtHQNN/A3EJvJFwF7Jx6teUsLUz8A+FM+/tWZD
 nl0Q==
X-Gm-Message-State: AOJu0Yw37DKPC2J6N5JvbGKuGVfLmEC0VC1iOh6E0xetV3pIqted4rbT
 /wQCUvX7yhPdW+JwL1qSJfs75g==
X-Google-Smtp-Source: AGHT+IEA9HBOdkrDJf774Pzi34f+3p9eGpWwXEG5+on5ufo70sFE/7fe9sZw2logv71cNshNiqPNFg==
X-Received: by 2002:a05:620a:3b06:b0:77b:c536:3722 with SMTP id
 tl6-20020a05620a3b0600b0077bc5363722mr1024227qkn.25.1699940492818; 
 Mon, 13 Nov 2023 21:41:32 -0800 (PST)
Received: from n231-230-216.byted.org ([130.44.212.104])
 by smtp.gmail.com with ESMTPSA id
 w2-20020a05620a094200b0077891d2d12dsm2400367qkw.43.2023.11.13.21.41.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 21:41:32 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: farosas@suse.de, peter.maydell@linaro.org, quintela@redhat.com,
 peterx@redhat.com, marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Subject: [PATCH v2 01/20] multifd: Add capability to enable/disable zero_page
Date: Tue, 14 Nov 2023 05:40:13 +0000
Message-Id: <20231114054032.1192027-2-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231114054032.1192027-1-hao.xiang@bytedance.com>
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qk1-x72f.google.com
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

From: Juan Quintela <quintela@redhat.com>

We have to enable it by default until we introduce the new code.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/options.c | 13 +++++++++++++
 migration/options.h |  1 +
 qapi/migration.json |  8 +++++++-
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/migration/options.c b/migration/options.c
index 8d8ec73ad9..00c0c4a0d6 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -204,6 +204,8 @@ Property migration_properties[] = {
     DEFINE_PROP_MIG_CAP("x-switchover-ack",
                         MIGRATION_CAPABILITY_SWITCHOVER_ACK),
     DEFINE_PROP_MIG_CAP("x-dirty-limit", MIGRATION_CAPABILITY_DIRTY_LIMIT),
+    DEFINE_PROP_MIG_CAP("main-zero-page",
+            MIGRATION_CAPABILITY_MAIN_ZERO_PAGE),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -284,6 +286,17 @@ bool migrate_multifd(void)
     return s->capabilities[MIGRATION_CAPABILITY_MULTIFD];
 }
 
+bool migrate_use_main_zero_page(void)
+{
+    //MigrationState *s;
+
+    //s = migrate_get_current();
+
+    // We will enable this when we add the right code.
+    // return s->enabled_capabilities[MIGRATION_CAPABILITY_MAIN_ZERO_PAGE];
+    return true;
+}
+
 bool migrate_pause_before_switchover(void)
 {
     MigrationState *s = migrate_get_current();
diff --git a/migration/options.h b/migration/options.h
index 246c160aee..c901eb57c6 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -88,6 +88,7 @@ int migrate_multifd_channels(void);
 MultiFDCompression migrate_multifd_compression(void);
 int migrate_multifd_zlib_level(void);
 int migrate_multifd_zstd_level(void);
+bool migrate_use_main_zero_page(void);
 uint8_t migrate_throttle_trigger_threshold(void);
 const char *migrate_tls_authz(void);
 const char *migrate_tls_creds(void);
diff --git a/qapi/migration.json b/qapi/migration.json
index 975761eebd..09e4393591 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -531,6 +531,12 @@
 #     and can result in more stable read performance.  Requires KVM
 #     with accelerator property "dirty-ring-size" set.  (Since 8.1)
 #
+#
+# @main-zero-page: If enabled, the detection of zero pages will be
+#                  done on the main thread.  Otherwise it is done on
+#                  the multifd threads.
+#                  (since 8.2)
+#
 # Features:
 #
 # @deprecated: Member @block is deprecated.  Use blockdev-mirror with
@@ -555,7 +561,7 @@
            { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
            'validate-uuid', 'background-snapshot',
            'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
-           'dirty-limit'] }
+           'dirty-limit', 'main-zero-page'] }
 
 ##
 # @MigrationCapabilityStatus:
-- 
2.30.2


