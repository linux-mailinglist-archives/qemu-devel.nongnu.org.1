Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFA879DBD3
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 00:23:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgBlv-0007sJ-Hj; Tue, 12 Sep 2023 18:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgBlh-0007qR-Vq
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:22:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgBlf-0003Ig-R9
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:22:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694557319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2YRmi5xS8R6Y8O27D1OcsXYIDTkrmU2x5TZce/7eTOk=;
 b=VMcpmAvG2aKWEG9eBCCBKYfFFVtEi/n2bUvuquaQrxraYb5Fl5AXtP5A5QCHNlssl4O9fE
 5mrSIWK7W2Q5ULmwT6RV/dzFTxufecpncT4wTN2b6Ow/MDRqIeZho5n7iGKxZAslszpa1/
 KIaypUQoxwAdUlZM2YagJGzbjbDPMz0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-obAh2sMvOeeWcLQekQvW8Q-1; Tue, 12 Sep 2023 18:21:56 -0400
X-MC-Unique: obAh2sMvOeeWcLQekQvW8Q-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-655bc5ee855so8774026d6.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 15:21:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694557316; x=1695162116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2YRmi5xS8R6Y8O27D1OcsXYIDTkrmU2x5TZce/7eTOk=;
 b=T/VIZB5/vfhIHqr2BMWogpIusjwSBTJvHBZB/UOYtPRtbWVccasx81Lu353k7QGPKS
 9PJsDhPQ/R3uv8vt5Jfl1RxQ0LeGUHpbJJzYaxRch2Vb+la2S+l9963TNtsUc3htZMEx
 63GKApKvfkVgvJclEwes8M7vKVRs3Hbsk4htNTeuC1t7klF6IZ6x737K6jHoIdQ95l9d
 zzHfg7uALE195lHCLjxG3KwkqtSMZCUSwGR3jhTHcUdYpwg5X/KrQ6D0vqR+d5HvxKkX
 oU2fKJR1FQx4nXD/Olsb2V/KIvZu63prcZODIxkPNe/G2UNa4KyM4BnczvYQokQeRaXL
 cQwg==
X-Gm-Message-State: AOJu0YxU4d9C6zTF/08qcfhbQJ1x+fDy/2TUi/bO33Xlrlj41/fEft6r
 c3R3MtkYuSlk1TKxLnqfb5JirC7zhHbo30f5rbsdtfuA/E2GWK1/OKeuCVDYCLvqNkGWAlPYyK0
 eB5nrQN0gbFzR+HGmMTjvjxN6zsLXe1gpcX+syLhag+HcAK+DZjOK5E9CFKdrwx/7rjKUSa46
X-Received: by 2002:a05:6214:d0a:b0:655:ebd0:1fc2 with SMTP id
 10-20020a0562140d0a00b00655ebd01fc2mr742935qvh.5.1694557316316; 
 Tue, 12 Sep 2023 15:21:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS5jw99WrLfWRjLDQ3J5iwDZ8s/D6NGh+NdAd3zKjO6a69B/oEYBJUvCU4PPWnIlv2hImaBw==
X-Received: by 2002:a05:6214:d0a:b0:655:ebd0:1fc2 with SMTP id
 10-20020a0562140d0a00b00655ebd01fc2mr742921qvh.5.1694557316014; 
 Tue, 12 Sep 2023 15:21:56 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a05620a136500b0076f206cf16fsm3494272qkl.89.2023.09.12.15.21.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 15:21:55 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 10/11] migration: Allow RECOVER->PAUSED convertion for dest
 qemu
Date: Tue, 12 Sep 2023 18:21:44 -0400
Message-ID: <20230912222145.731099-11-peterx@redhat.com>
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

There's a bug on dest that if a double fault triggered on dest qemu (a
network issue during postcopy-recover), we won't set PAUSED correctly
because we assumed we always came from ACTIVE.

Fix that by always overwriting the state to PAUSE.

We could also check for these two states, but maybe it's an overkill.  We
did the same on the src QEMU to unconditionally switch to PAUSE anyway.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index bb3e99194c..422406e0ee 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2723,7 +2723,8 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
         qemu_mutex_unlock(&mis->postcopy_prio_thread_mutex);
     }
 
-    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
+    /* Current state can be either ACTIVE or RECOVER */
+    migrate_set_state(&mis->state, mis->state,
                       MIGRATION_STATUS_POSTCOPY_PAUSED);
 
     /* Notify the fault thread for the invalidated file handle */
-- 
2.41.0


