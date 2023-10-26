Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DAC7D8653
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 17:55:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw2gQ-0005sY-CJ; Thu, 26 Oct 2023 11:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qw2gO-0005sO-D8
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 11:54:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qw2gM-0000tF-Su
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 11:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698335642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pVnr5wFaay66KVUCJQ7STeYMkubTSR3EFWIQEUk4fwM=;
 b=ZS3h1aE7pbhdWdfdl/AAdhENaqpfTqrNeqq6CuNOcPFEkiv7osvTjTw9qBs87WfCbo3KZE
 PG0WENijEPIsuTP054188jLOphyL1/27A4dWHJXoh7pRKgHRepgfKqo8oxIcwPkS4GcX+r
 9PsjJpmvUC4EB3ol+968994+VvJeQeo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-1HGANl37M8SPhnpOjweGmA-1; Thu, 26 Oct 2023 11:53:45 -0400
X-MC-Unique: 1HGANl37M8SPhnpOjweGmA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-41e1ecf3350so2448031cf.1
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 08:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698335625; x=1698940425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pVnr5wFaay66KVUCJQ7STeYMkubTSR3EFWIQEUk4fwM=;
 b=RrImI0JvIGiwKhbkPQrYcKGiUzIwXY1XVBKXjsXqj04X19qoOiP4Vt1QoB9VGkTe45
 pO86fM2VzSFnhaqS3rnPjJFwiu2PiF7XyaSciS3BA9huTI/qeE6Cqos/Q5sDXaDiQjoB
 4m7rBt+XP7dAFgZ0AQWNY+6opEKfrDlsdOnsglJcxlbDCykmDW6QiW/6ab+pY04UkjXj
 Lmh1VQ7RT1L6NqwaFE8V+NiZjUodhbw/6s7fgW/HF6o48nJb6t8UepTBqb81xTVBoRcV
 hR65cYgt8ERmJjyKbmEtq3SclvLO6HXT7UBWNVdHXz/2GPbQkpuu1DgSP7mx+y4mdJUf
 /71Q==
X-Gm-Message-State: AOJu0Yw4KDz1C/JBAKigeGK7b71J0UUPZiCqGPfbUDih0WK0NAoUMjD1
 so1busghHZa5OOM9X7dymztd9GwdGiQLttLNHN18miF48QFHlQrMijHL+HvAHDnB4S6KY6yO4JT
 C68r6SNOR/O6UtBdtThQ5sxQj5+9sDKHMKb79WN4p/UIKM2U1D5Js5nVOaHV0/LR5mtdC811W
X-Received: by 2002:a05:622a:1a05:b0:403:c2fa:83b with SMTP id
 f5-20020a05622a1a0500b00403c2fa083bmr20194647qtb.4.1698335625096; 
 Thu, 26 Oct 2023 08:53:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4zIbwUKNnmdkDLw7CYaroIPih/iPd9tlAom09vRlxkmDlBp3+fg+NcuDAVwuiDlUyLsRZ4A==
X-Received: by 2002:a05:622a:1a05:b0:403:c2fa:83b with SMTP id
 f5-20020a05622a1a0500b00403c2fa083bmr20194623qtb.4.1698335624743; 
 Thu, 26 Oct 2023 08:53:44 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 f15-20020ac840cf000000b004181f542bcbsm5066580qtm.11.2023.10.26.08.53.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 08:53:41 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH 1/3] migration: Set downtime_start even for postcopy
Date: Thu, 26 Oct 2023 11:53:35 -0400
Message-ID: <20231026155337.596281-2-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231026155337.596281-1-peterx@redhat.com>
References: <20231026155337.596281-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


