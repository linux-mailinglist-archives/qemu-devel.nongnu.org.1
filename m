Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D75D4748950
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 18:36:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH5TK-0001bQ-BQ; Wed, 05 Jul 2023 12:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qH5TE-0001Vq-8I
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 12:35:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qH5TC-0003bM-4p
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 12:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688574908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XoXI2u60Rfd6U/07kOVks6txLlPvzpf0qHa8kUjUOZk=;
 b=cxCuPQhBX/zNq/AqQq2Hh/Rqnsr9pWDrcEOa2gK8IPTIjNQMbnt+WomeEFjgWcgLJZ4QuV
 SepTNe6yNSa4wA38H6fnw2fqp5nU2dUv/GRSHRIMHiNWm6XyY6xOTiCnYxQTRKJrerb71Q
 jAu5rZOMOm3eBStLn0IGITa5Mh6Smis=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-4mrD0ptMP9GAfLZ_Fjg75g-1; Wed, 05 Jul 2023 12:35:07 -0400
X-MC-Unique: 4mrD0ptMP9GAfLZ_Fjg75g-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-74faf5008bbso128202785a.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 09:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688574907; x=1691166907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XoXI2u60Rfd6U/07kOVks6txLlPvzpf0qHa8kUjUOZk=;
 b=KpkiRnJQS5WQe44DSdgwMRHAtoVWzA7zxwKVVj3Re2EVRZ3QruEPg/NRBHARaVUXtL
 ImhhXnwZb4K4o1+6DeDBRewIFCIvIvtYS8k15qm7SCSyJYyBDhJlvPU1cGp4dFZnoEWB
 7VPaiBakuZFd8bTvpsNIcf7SxuAZgfhmDDg0dxQyUmLOyeBSWKSyogUaoZ+ZG/rN0iV+
 gvq30bInjd8dSUnED6yUi0q4Z03716bBxkx0pvsrsdDwfO0OxtKgp8h5OTItLL63QKGp
 uExhf/yM3m8YCcre3WvBua63lhIGMEg3Jg0hnbxaZsVwfQSM/m85w75M8Ad5MMxGKcs7
 kaCw==
X-Gm-Message-State: AC+VfDxOGxD1D+oqDVmBltNypXL6CidH2fjLfl6wl3Yt7Y00QWg41mxp
 i5OZvRPLnz5rE+799JoLdXLP5xpuXGtNp1Dn+l1v+HgvDFkcXMNCN2lJa349EguG1ZUqihDJ9bg
 0qe4Z/i+Mt2PuDzRpZINjyLNeqrqTgRrGPrrBqgN3S640rnCVP+cFnK6A3XrlX+1fN01Gkadq
X-Received: by 2002:a05:620a:468f:b0:763:c764:577c with SMTP id
 bq15-20020a05620a468f00b00763c764577cmr24148056qkb.5.1688574907102; 
 Wed, 05 Jul 2023 09:35:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5P6DjMIlpZXsWRPYWHaDsfR8lA3EefNtDpylanKXMC95Jh00vSv6mniTKuHhAKGaqteUFqOw==
X-Received: by 2002:a05:620a:468f:b0:763:c764:577c with SMTP id
 bq15-20020a05620a468f00b00763c764577cmr24148026qkb.5.1688574906693; 
 Wed, 05 Jul 2023 09:35:06 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 x19-20020a05620a12b300b007620b03ee65sm6760094qki.37.2023.07.05.09.35.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 09:35:06 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juan Quintela <quintela@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Laszlo Ersek <lersek@redhat.com>,
 peterx@redhat.com
Subject: [PATCH v2 3/7] migration: Introduce migrate_has_error()
Date: Wed,  5 Jul 2023 12:34:58 -0400
Message-ID: <20230705163502.331007-4-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705163502.331007-1-peterx@redhat.com>
References: <20230705163502.331007-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Introduce a helper to detect whether MigrationState.error is set for
whatever reason.  It is intended to not taking the error_mutex here because
neither do we reference the pointer, nor do we modify the pointer.  State
why it's safe to do so.

This is preparation work for any thread (e.g. source return path thread) to
setup errors in an unified way to MigrationState, rather than relying on
its own way to set errors (mark_source_rp_bad()).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h |  1 +
 migration/migration.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/migration/migration.h b/migration/migration.h
index 507f2f111e..7d916e13e1 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -483,6 +483,7 @@ bool  migration_has_all_channels(void);
 uint64_t migrate_max_downtime(void);
 
 void migrate_set_error(MigrationState *s, Error *error);
+bool migrate_has_error(MigrationState *s);
 void migrate_fd_error(MigrationState *s, Error *error);
 
 void migrate_fd_connect(MigrationState *s, Error *error_in);
diff --git a/migration/migration.c b/migration/migration.c
index e5d207699b..c54c195603 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1222,6 +1222,21 @@ void migrate_set_error(MigrationState *s, Error *error)
     }
 }
 
+/*
+ * Whether the migration state has error set?
+ *
+ * Note this function explicitly didn't use error_mutex, because it only
+ * reads the error pointer for a boolean status.
+ *
+ * As long as the Error* is set, it shouldn't be freed before migration
+ * cleanup, so any thread can use this helper to safely detect whether
+ * there's anything wrong happened already.
+ */
+bool migrate_has_error(MigrationState *s)
+{
+    return qatomic_read(&s->error);
+}
+
 static void migrate_error_free(MigrationState *s)
 {
     QEMU_LOCK_GUARD(&s->error_mutex);
-- 
2.41.0


