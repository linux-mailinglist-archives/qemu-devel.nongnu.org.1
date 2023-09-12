Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E85879DBDA
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 00:23:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgBlm-0007qU-99; Tue, 12 Sep 2023 18:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgBlb-0007ly-61
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:21:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgBlY-0003H6-Lo
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694557312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QyGgPIxjfkzAdNW/5xLbFjko/zMdiooGCeQtOGm9yC0=;
 b=EqJDx3uSIAwHa24XP1GB9Rl3UPGP9uITuLWo69+zBb70K+UqGl+N5dMKRbDJNhwY1iFiAR
 Uv0lEaD4ClOkC+xF22Qc79/ZgKwnmUsT8ad/EXbc9jN5mVwD1o6Gu+6qNL1fqFGmAYZnhy
 stDAVrm99y4jpChZChxDZtTE72pQxwg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-EbE1VlZxMBue9lq-eIAFVg-1; Tue, 12 Sep 2023 18:21:50 -0400
X-MC-Unique: EbE1VlZxMBue9lq-eIAFVg-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-76efdcb7be4so131975385a.1
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 15:21:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694557310; x=1695162110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QyGgPIxjfkzAdNW/5xLbFjko/zMdiooGCeQtOGm9yC0=;
 b=g3RzLayqRAzXIEHr7EhMOnNfWdEy/qntOe0tFsgtHhX3Q0AfUaZ7zDQ84mN4uGI+vK
 HbnnCHj/CcudCdXwiz4AnGSMbELaPjTKjCV9V3vjmZ36M8c/bHOZPVUA5gXCz5H+g1S3
 HxVOozzHlZaoHnQPQrtx3E4PdRoqSNonk6/TFmHStwYy/z6Dd+Ai/hvUlYUNM7eCQRU9
 mFTlbO9BSBQnhmjuqr3QGN4UtzlzAvG1naumMact2bt24yoqc4KTY8rUa2gKoNocoWgq
 ybEhpIRdfdWjZi+Nzx+JJ6fWB9Z50ZA23lCmnFsR4vrBf1jxIaOP/beGZSmg0KTJA+RK
 cDTQ==
X-Gm-Message-State: AOJu0YwdfgvPONntQSTIxxPoU1/do2FAxNm7BkofE6ZBLJQONGL9Cqkq
 Ro6zmAbmERwWAMAo2//x1izhFzcIcz6KR38VAuhcR8gVv3AbCNJvun+TzgOn2ZHbzvq5SH4GqnJ
 7i0laTCKpnBKk0gGekwTesyCurvjED0Ryu8QD1FrsFzHHTDAlEuY9CSgp4KblU1Qlryy7ZOIw
X-Received: by 2002:a05:620a:2485:b0:76d:1339:e871 with SMTP id
 i5-20020a05620a248500b0076d1339e871mr715071qkn.5.1694557310181; 
 Tue, 12 Sep 2023 15:21:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZYOFu/o3JXPn03bKiUebImVzjKfmCFAwBucaTjkz2/r66njjy8hqNa/QBjxX194kE1xb3kA==
X-Received: by 2002:a05:620a:2485:b0:76d:1339:e871 with SMTP id
 i5-20020a05620a248500b0076d1339e871mr715051qkn.5.1694557309828; 
 Tue, 12 Sep 2023 15:21:49 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a05620a136500b0076f206cf16fsm3494272qkl.89.2023.09.12.15.21.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 15:21:49 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 03/11] migration: Introduce migrate_has_error()
Date: Tue, 12 Sep 2023 18:21:37 -0400
Message-ID: <20230912222145.731099-4-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912222145.731099-1-peterx@redhat.com>
References: <20230912222145.731099-1-peterx@redhat.com>
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
whatever reason.  It is intended to not taking the error_mutex here because
neither do we reference the pointer, nor do we modify the pointer.  State
why it's safe to do so.

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
index 1eefa563c4..b50e97a098 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -466,6 +466,7 @@ bool  migration_has_all_channels(void);
 uint64_t migrate_max_downtime(void);
 
 void migrate_set_error(MigrationState *s, Error *error);
+bool migrate_has_error(MigrationState *s);
 
 void migrate_fd_connect(MigrationState *s, Error *error_in);
 
diff --git a/migration/migration.c b/migration/migration.c
index 4b4dba5b12..7bd056a4b5 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1237,6 +1237,13 @@ void migrate_set_error(MigrationState *s, Error *error)
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


