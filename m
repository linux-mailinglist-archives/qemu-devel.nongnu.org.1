Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0757D78D072
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:25:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7nu-0001mq-Ou; Tue, 29 Aug 2023 19:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qb6U4-0006L1-8D
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 17:42:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qb6U2-0000f7-4e
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 17:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693345364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FM2G6N8TTxn10FY7UisZKQrDckXBn6HpxC0g3RragwY=;
 b=U7PrNOTSatWCkmW6hMhYLXV/WKsz1hzbqVhKhuDvBY7NJNQ1sojlEq8z4ev9gBS17yWr6k
 hczaiTub/2wIyo9XW1U9stwnQ50fkZpDrSnzmPqL8HZ3bhhSuGlgZsez3I063pLdlMQZY2
 nYOntMg2kK5I6rwfZtXhnx4AgLpf/QY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-xGEJIytQOlSLzCGWMTQfRA-1; Tue, 29 Aug 2023 17:42:43 -0400
X-MC-Unique: xGEJIytQOlSLzCGWMTQfRA-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-410a3a86a88so14248071cf.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 14:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693345362; x=1693950162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FM2G6N8TTxn10FY7UisZKQrDckXBn6HpxC0g3RragwY=;
 b=da3MdPPKHO2UPJiXGCd/7qFsRLGIS4HZdcm9ErAB9LtQS8434XDOGxLvGmaNv5kzBQ
 lZWs7p94MTg43TYEQMaZxnosvxKQbbk/LQ4IG+x5EI33pCxIG7+HsUbXbQlU1IxWj+NY
 p3FPK07pPfg5PjjmiKLQNSW9svbfv7EtqMqonvklYenJycJ1O9LXY3fLQT9RbEb02eLv
 xGXaSiDAd9HbzfoEwXmq0B/phYi/Fh8hDcBt/fOgx+QptKoo2JDMzjiRpiXwEQaMS4Ot
 WZfXR2jvK7qRjb85oQXCnYVhdq8h+SsjS/AfKqIS7+cIp3zzA7Ylvl6Haawg31JZd3Gv
 GGHw==
X-Gm-Message-State: AOJu0YwZvXNetKvHn41TToejEeuXhG4quryw2k2N1dokvBURTk8Jh90i
 B9my10wu/jVKylJxiSUJt4Qk4eQek8N2pZRARTuKhXXaE2fyA6RIWbYReH2phIDhsZpsbFarNSJ
 l+EWZrNWq63bb5snTENDsv2BxpxWgt1tgMWcUA9ttdssPIjy0BvyJV9fE9JewBCtOCTGbDIMP
X-Received: by 2002:a05:622a:1a9a:b0:412:d46:a8df with SMTP id
 s26-20020a05622a1a9a00b004120d46a8dfmr336948qtc.1.1693345362595; 
 Tue, 29 Aug 2023 14:42:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4VT62JaFovTQ//w6Au11QVpHj50TsY8a0mEWat8GBpfC8IFQmFN5UVdYEMKUc+ZCUk6y8/Q==
X-Received: by 2002:a05:622a:1a9a:b0:412:d46:a8df with SMTP id
 s26-20020a05622a1a9a00b004120d46a8dfmr336928qtc.1.1693345362293; 
 Tue, 29 Aug 2023 14:42:42 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 b18-20020ac86bd2000000b0040f8ac751a5sm3260343qtt.96.2023.08.29.14.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 14:42:41 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH 3/9] migration: Introduce migrate_has_error()
Date: Tue, 29 Aug 2023 17:42:29 -0400
Message-ID: <20230829214235.69309-4-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829214235.69309-1-peterx@redhat.com>
References: <20230829214235.69309-1-peterx@redhat.com>
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
index 76e35a5ecf..1ba38eecfa 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -466,6 +466,7 @@ bool  migration_has_all_channels(void);
 uint64_t migrate_max_downtime(void);
 
 void migrate_set_error(MigrationState *s, Error *error);
+bool migrate_has_error(MigrationState *s);
 
 void migrate_fd_connect(MigrationState *s, Error *error_in);
 
diff --git a/migration/migration.c b/migration/migration.c
index 0f3ca168ed..84c17dfbbb 100644
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


