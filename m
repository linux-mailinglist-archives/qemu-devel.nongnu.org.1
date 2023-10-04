Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6507B9710
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 00:04:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo9xE-0003zv-Cc; Wed, 04 Oct 2023 18:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qo9xB-0003zk-Bc
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 18:02:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qo9x9-0003rS-N3
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 18:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696456966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LzKZuZquPAsiKzUY2JHiaYVJqmKsq9gZ4aRLuK68dRY=;
 b=hMBYsaeVtSunviszex2n7szzhKeEcBNckgztoBNhVfBSeRpxBkI80viSlZpGFENzEiBkQx
 GneMfnGxymEAUWgmeHokPwlSPoPnHSbz63pVDKa1IHVt1wHqTljadIu+zuLKKQXXd2N3sd
 uvFPy42ztbcWuiApFrFePCMu3EDwe2Y=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-i6xxX3TLPimTfRhWtIm3nA-1; Wed, 04 Oct 2023 18:02:45 -0400
X-MC-Unique: i6xxX3TLPimTfRhWtIm3nA-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-59beab24599so727367b3.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 15:02:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696456964; x=1697061764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LzKZuZquPAsiKzUY2JHiaYVJqmKsq9gZ4aRLuK68dRY=;
 b=U8o5merpTBe/jUWP8GTlGa+RPUhkGRXMYozd4K6zlMdbsHDbfYY7PKon5bJph6Psp1
 EDkJ3LH6AkWzRW6ENx6AiLajEUCFPgYjgVd8l7dzB9IjbLROGXXp5g6CrfT9D+57Yh0/
 RCW/KOxGDeF6bRuSZgkaLQXGsV8aA8DNpF7hfW5319uzLbjj/DLdRF7ODpZUrkh1rHdO
 r5s94SUXb7IEvs7zazdQwWotFA46dBh8TFKkXcwj8a/78JrTzbuPZm0bifEZzpYgzItt
 IM+Ra1xyyTuDIu5bb8njExo+LalKiA+Svrr3E9qkx5Tl8FXUu10gQQHEnmFSDCDiKrUI
 mWZw==
X-Gm-Message-State: AOJu0YykxXCsRB+M/MojAXfbmewP/v7qbwtDOFhIkY1N6XPIcOTK1Bpr
 l4fHgoPiyqfWHMzDwyvMMtNpncnQlEff/YgFTmj3PRsAmk9S3n5hfSn5Ozc1EvcwCo6p19Zoq0Q
 DEknnU6hBJT71LYYe38VxrEuTGRCdDjHbodo/tyMQA0g4KGVoc2AW7hmJHFeD3iHFXyDivWAT
X-Received: by 2002:a25:69c8:0:b0:d7a:bcef:c2ab with SMTP id
 e191-20020a2569c8000000b00d7abcefc2abmr2829829ybc.4.1696456964476; 
 Wed, 04 Oct 2023 15:02:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbXPlHofG1fxzP/tV3uRRxNDybCQwJJuqUZ+OT+wyOZCJzfPe2TMrLouB4prb1BizU4WmMaw==
X-Received: by 2002:a25:69c8:0:b0:d7a:bcef:c2ab with SMTP id
 e191-20020a2569c8000000b00d7abcefc2abmr2829808ybc.4.1696456964000; 
 Wed, 04 Oct 2023 15:02:44 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 w17-20020a0cdf91000000b0063d162a8b8bsm10821qvl.19.2023.10.04.15.02.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 15:02:43 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH v3 02/10] migration: Introduce migrate_has_error()
Date: Wed,  4 Oct 2023 18:02:32 -0400
Message-ID: <20231004220240.167175-3-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004220240.167175-1-peterx@redhat.com>
References: <20231004220240.167175-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Introduce a helper to detect whether MigrationState.error is set for
whatever reason.

This is preparation work for any thread (e.g. source return path thread) to
setup errors in an unified way to MigrationState, rather than relying on
its own way to set errors (mark_source_rp_bad()).

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h | 1 +
 migration/migration.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/migration/migration.h b/migration/migration.h
index 972597f4de..4106a1dc54 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -476,6 +476,7 @@ bool  migration_has_all_channels(void);
 uint64_t migrate_max_downtime(void);
 
 void migrate_set_error(MigrationState *s, const Error *error);
+bool migrate_has_error(MigrationState *s);
 
 void migrate_fd_connect(MigrationState *s, Error *error_in);
 
diff --git a/migration/migration.c b/migration/migration.c
index 010056d6f3..4c6de8c2dd 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1231,6 +1231,13 @@ void migrate_set_error(MigrationState *s, const Error *error)
     }
 }
 
+bool migrate_has_error(MigrationState *s)
+{
+    /* The lock is not helpful here, but still follow the rule */
+    QEMU_LOCK_GUARD(&s->error_mutex);
+    return qatomic_read(&s->error);
+}
+
 static void migrate_error_free(MigrationState *s)
 {
     QEMU_LOCK_GUARD(&s->error_mutex);
-- 
2.41.0


