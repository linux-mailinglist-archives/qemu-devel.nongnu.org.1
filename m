Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5AD8239CD
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 01:47:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLBs2-0008Gw-Sv; Wed, 03 Jan 2024 19:46:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLBrh-0008GP-Kk
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 19:45:42 -0500
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLBrf-0007Od-AX
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 19:45:41 -0500
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7815547f2c5so1846185a.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 16:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1704329136; x=1704933936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6tU+4AECWTT+Mya1MsxF+8R7H2AZk4/hzoQ12e2uxd4=;
 b=cMV2ha9Rp8aTQwRG6VMR29gxJNBQbyGzrnxMFNXuhrP0mEBqvSKgs0/KqGmlbISGgF
 W6cyS7g5m7J+fPbnI7+b7IcEtMEQA5gKYjwmuQ8QplsSaKhxGQdc1IrSuxskTI4br7pm
 p/aphxJke5B3521L5dH2vFsDgke4S5ZaNasyu6gNOvxJs9vXqK65Ej0ErjCbZGLkQWNU
 XagGakiNb/OUe4Vi2LqSowsPjJ/FZyE7019qY4nrOfqUxvEmMdrAxxSGiCc7lO5tyL3M
 E32Ex7FjgTbpqtN4O6eYovOARfv6wYIxS8BQSYmfbeXSh8r6QZOtLqbqeA78JHLbUEMA
 pM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704329136; x=1704933936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6tU+4AECWTT+Mya1MsxF+8R7H2AZk4/hzoQ12e2uxd4=;
 b=BjWxvEzt895w+GFLWcMyPV3hrvktjd+Kb/Vsp2sQuQ7QgDjYLCbHBhaeqrpJ9GXmTF
 sixGulNXdWk2O+6wBpii30amebmOqEwXiO/nNe7Hqx1b96Svsm4XWdIHjUr3GvnLo+Tt
 6KWSK1zDwVPVFA22Xj+KQlcxS2LaZuKKX3EuPYrQ21BWWBROsh+yUkS/kxoQfU1FOywD
 LqZuVC4Qp++YwOa/ldRbxUDtrCY08eszsQzpSnDI++oKqg+f5eemgF7z0ljQhtKjetPY
 y7efRj40sRp01N7hSl8O7d6oLIRpxRLSsJJD5bI3C5OBRHyQW5ifhQEIjhQQU9qNDzjg
 ydng==
X-Gm-Message-State: AOJu0YyA9oZ5+uvezmA+tXyIh+cYYQ0WXTFMffvVWsYLu0dCk3BsXhAj
 0MUGb04HPbJHLG8kUG6DPS/jmoVMqA5Vfw==
X-Google-Smtp-Source: AGHT+IGn+HFvgIiaag/a/8hzo2bex/S36IIyaj138l/jM8wi6f1o8Zz9UO6ynILgre/73MqYU29Klw==
X-Received: by 2002:a05:620a:1362:b0:781:5f2e:7f47 with SMTP id
 d2-20020a05620a136200b007815f2e7f47mr10235788qkl.89.1704329136234; 
 Wed, 03 Jan 2024 16:45:36 -0800 (PST)
Received: from n231-230-216.byted.org ([147.160.184.87])
 by smtp.gmail.com with ESMTPSA id
 x19-20020ae9f813000000b0077d66e5b2e6sm10646087qkh.3.2024.01.03.16.45.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 16:45:35 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: farosas@suse.de, peter.maydell@linaro.org, peterx@redhat.com,
 marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>
Subject: [PATCH v3 01/20] multifd: Add capability to enable/disable zero_page
Date: Thu,  4 Jan 2024 00:44:33 +0000
Message-Id: <20240104004452.324068-2-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240104004452.324068-1-hao.xiang@bytedance.com>
References: <20240104004452.324068-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qk1-x72b.google.com
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
 migration/options.c | 15 +++++++++++++++
 migration/options.h |  1 +
 qapi/migration.json |  8 +++++++-
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/migration/options.c b/migration/options.c
index 8d8ec73ad9..0f6bd78b9f 100644
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
 
@@ -284,6 +286,19 @@ bool migrate_multifd(void)
     return s->capabilities[MIGRATION_CAPABILITY_MULTIFD];
 }
 
+bool migrate_use_main_zero_page(void)
+{
+    /* MigrationState *s; */
+
+    /* s = migrate_get_current(); */
+
+    /*
+     * We will enable this when we add the right code.
+     * return s->enabled_capabilities[MIGRATION_CAPABILITY_MAIN_ZERO_PAGE];
+     */
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
index eb2f883513..80c4b13516 100644
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


