Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 784927DBE00
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 17:35:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxVDV-0003e1-D8; Mon, 30 Oct 2023 12:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxVDU-0003dU-6H
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 12:34:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxVDS-0002hQ-Gl
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 12:34:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698683654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pVnr5wFaay66KVUCJQ7STeYMkubTSR3EFWIQEUk4fwM=;
 b=eU++Bq7NO9QjaAGPe/SMrF1LXvuNvT7cOYadZ7np/y0Rfass36ia9lUUiW0ocpcsgHcZI3
 USufyufMDYpBFkMcrQRQBj7j2+eDqnTm3orLv8sFhlfm8cj96wM1Jtgc2heneUoiGHhY7U
 FzWmhbqFHbb3EyO47yAuHQ6xJwbjJLA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-UmzJ7G_lNr6b1ZUQ_kVFPA-1; Mon, 30 Oct 2023 12:33:56 -0400
X-MC-Unique: UmzJ7G_lNr6b1ZUQ_kVFPA-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-41e1899175eso11347661cf.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 09:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698683636; x=1699288436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pVnr5wFaay66KVUCJQ7STeYMkubTSR3EFWIQEUk4fwM=;
 b=MVSrfnEWw38cCYEIgt9tuzI2yi6iGQ7fHJhlDcEDJqIB5yAZ4+76PoiRn0CKknpeel
 MKCcvoTAVNyLrVaeSW6CX6r0XJnxvNmKh3y32k59/G9my0VM0EjFJgJ4PXlHC+uEQFfq
 85347ZgnUl5TWc7HAJqySr2aElt+pZArtALEf+3FxB2oSnLJ/ou+Gjy9G5EL+RBXYqIV
 jlK/V/3vrFPMthnt1sy+qHAAnMTVxzQC1JhwFuGa2nuNfLpcVxtQPovQy4WHmlARaqbu
 36ZVok5XPk+a/kLMmOsivF5oAp8SuMrMi8io4w7tQ9UjKNS6TBOGhP/XUp9bAk8odbzj
 AHsA==
X-Gm-Message-State: AOJu0YxijV7t/6wDz9hYOv3pdkKqlLq5Inh4bUGxX2s/aG1NTnePgzPY
 HwvTbPIWSwV1jCFLLok7bHVMUYmNWHabf3hJ74w+u1D3bycNm1CeHyBolXBqYM/25kwxT8QK6yJ
 KpPFPKSrNliyPvGRKAs5Knq6V25TpuDBqzFzgrkWRlqBIPN9OWkFAJPQ1g/7ydadnG2zgAdvc
X-Received: by 2002:a05:622a:148c:b0:41c:d528:6589 with SMTP id
 t12-20020a05622a148c00b0041cd5286589mr12742045qtx.4.1698683636281; 
 Mon, 30 Oct 2023 09:33:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkYpWAuy0odiGhiW6g70RRy57qBHQKCXECrCTuL1GOGzldNAUgeJW4Dp9DPF2Y1akytBjTng==
X-Received: by 2002:a05:622a:148c:b0:41c:d528:6589 with SMTP id
 t12-20020a05622a148c00b0041cd5286589mr12742020qtx.4.1698683635917; 
 Mon, 30 Oct 2023 09:33:55 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 l15-20020ac84ccf000000b004198ae7f841sm3531111qtv.90.2023.10.30.09.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 09:33:55 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Joao Martins <joao.m.martins@oracle.com>,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH v2 1/5] migration: Set downtime_start even for postcopy
Date: Mon, 30 Oct 2023 12:33:42 -0400
Message-ID: <20231030163346.765724-2-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231030163346.765724-1-peterx@redhat.com>
References: <20231030163346.765724-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Postcopy calculates its downtime separately.  It always sets
MigrationState.downtime properly, but not MigrationState.downtime_start.

Make postcopy do the same as other modes on properly recording the
timestamp when the VM is going to be stopped.  Drop the temporary variable
in postcopy_start() along the way.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 67547eb6a1..f8a54ff4d1 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2121,7 +2121,6 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     int ret;
     QIOChannelBuffer *bioc;
     QEMUFile *fb;
-    int64_t time_at_stop = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     uint64_t bandwidth = migrate_max_postcopy_bandwidth();
     bool restart_block = false;
     int cur_state = MIGRATION_STATUS_ACTIVE;
@@ -2143,6 +2142,8 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     qemu_mutex_lock_iothread();
     trace_postcopy_start_set_run();
 
+    ms->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+
     qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
     global_state_store();
     ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
@@ -2245,7 +2246,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     ms->postcopy_after_devices = true;
     migration_call_notifiers(ms);
 
-    ms->downtime =  qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - time_at_stop;
+    ms->downtime = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - ms->downtime_start;
 
     qemu_mutex_unlock_iothread();
 
-- 
2.41.0


