Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F39741B27
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 23:51:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEd3O-0001Jg-1J; Wed, 28 Jun 2023 17:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEd3D-0001IP-9i
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:50:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEd3B-0008OA-2K
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687989008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N4b41QtUM2fY9wK0ZryMneMjNxm7tkASb6Nvu1VQtcE=;
 b=d+QMqrBZ3xsGJGG/KS3cTcrA64+sN9XtB7bDQoXAIJ6DPiUHputFGarHunfrLYUVzpjzqC
 R6wH8JVvLO7qX2P1oJvk0ePK8DxZ9fK/s+Ix6kGmNnEXaahkU/t1lUz4CiRV/Pex8Fa75B
 PuD9zN/RMs8o7DdegoKbqdwhGtgFuMo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-E5PiDrPJMK-Naw82TgLLxg-1; Wed, 28 Jun 2023 17:50:07 -0400
X-MC-Unique: E5PiDrPJMK-Naw82TgLLxg-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-401df9d2dc4so49251cf.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 14:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687989006; x=1690581006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N4b41QtUM2fY9wK0ZryMneMjNxm7tkASb6Nvu1VQtcE=;
 b=C56KcjzpWlCXDVf2FdVStQuEQ/SrB7gizUumiGioXxL1ppu6QB+MTNUCekqGXrNNvv
 BpcBOWVo874EsBvt0VF7qJ5TaM+kV5C7niv+6+irTaUUpYgi0yvD+SgjesgaPKIhWxr7
 IVx/WEZxz5OnjAhMV1+yzZ/bXwhVjKgDr96NsXs1B8j+/pr3L5sRs/TmtWbvvGwAKqIV
 xmku/jmNP42rZQGjbyGCvudjPcqARt6PDGunvIXF9eXJWRAIsDQeiHWElHFrOCHCMavd
 YuBQR51TOGADHYEqbyJF5CJ3p+frC+ge4HFlIgBIGSKvGSgBgh/oqVsWXLsV6AzQra3B
 yn4w==
X-Gm-Message-State: AC+VfDwn2HSV+woI93ZaoosmUhm8XdZLUq4JlLOS2qDxCsFZYk+6ht1J
 Tdgvq6/AlPlSxahSi5PCqRmixUrXdkv/lAMNRurHRYbZ2XPXttL5ajmHWb20H1y4XM8l1UWc5qw
 f+QRUsIKSsL9+NEU7kz4DOWJRGVqPVJOLTZoG1W9GNdWcSvKU8BbT/c6nlXXOperNWr39TD3n
X-Received: by 2002:ac8:5712:0:b0:400:cdbb:a755 with SMTP id
 18-20020ac85712000000b00400cdbba755mr9949819qtw.1.1687989006354; 
 Wed, 28 Jun 2023 14:50:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6nvxGmwWcGJ/E5U4eysGE0d3lpBQSHqbXLAD0/9YNcrPgHtkbJy1GioCIUW7WnXDSX+qrSwA==
X-Received: by 2002:ac8:5712:0:b0:400:cdbb:a755 with SMTP id
 18-20020ac85712000000b00400cdbba755mr9949793qtw.1.1687989005892; 
 Wed, 28 Jun 2023 14:50:05 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 w29-20020ac84d1d000000b004032d9209a0sm255552qtv.50.2023.06.28.14.50.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 14:50:05 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juan Quintela <quintela@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>
Subject: [PATCH 2/7] migration: Introduce migrate_has_error()
Date: Wed, 28 Jun 2023 17:49:57 -0400
Message-ID: <20230628215002.73546-3-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628215002.73546-1-peterx@redhat.com>
References: <20230628215002.73546-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 32f87e3834..e48317ca97 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -469,6 +469,7 @@ bool  migration_has_all_channels(void);
 uint64_t migrate_max_downtime(void);
 
 void migrate_set_error(MigrationState *s, Error *error);
+bool migrate_has_error(MigrationState *s);
 void migrate_fd_error(MigrationState *s, Error *error);
 
 void migrate_fd_connect(MigrationState *s, Error *error_in);
diff --git a/migration/migration.c b/migration/migration.c
index 13dccc4c12..39674a3981 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1214,6 +1214,21 @@ void migrate_set_error(MigrationState *s, Error *error)
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


