Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7D67B9711
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 00:04:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo9xZ-000571-T6; Wed, 04 Oct 2023 18:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qo9xX-0004yx-UW
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 18:03:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qo9xW-0003xh-CL
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 18:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696456989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/HwT+zMcpoZEFUPWctUoS6yoeEKIEIcZgfW9Ak1oe+M=;
 b=Jygi8Booiev9dahYBE+8uU/fQe4BHfvH/qPQbup8HB9n08hS3y5OwLd1/2KPuNQmYvsOYP
 FZcNkmZTlMpM2oHVMLJvTjMtkadlQ3boHE6YK59HL1cBpVT2NY5L0nCQgZCEqnOE3lPNtO
 MJWvEFNrbd7bpWHVVyFKAaVckCsaV6Y=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-rp-UjmZaPqSt2wz4kSI7mg-1; Wed, 04 Oct 2023 18:02:53 -0400
X-MC-Unique: rp-UjmZaPqSt2wz4kSI7mg-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-d818fe59cacso78580276.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 15:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696456972; x=1697061772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/HwT+zMcpoZEFUPWctUoS6yoeEKIEIcZgfW9Ak1oe+M=;
 b=s5/ZWj2ZaPdiqpHlcVOlWnixIfdviHljTvNwCF7NKQXeU8nALHg53C60+lJr1qF7dQ
 oUy6pvygkPDLqmD3ICpJcNDKpEIUEFCOZ6v1VuyFTLwMqNugUhGgIIgj/4BlYpi5c9Q5
 pD8Db03RAnqcQQGsfp+9v5IKN1E3P1L1HQThNaJ2XgcZ1UwnpTWZcHvmQpIJCuWhundC
 KPVSbjB+eSTlmsbH02SFQHlJx/l0dscmios3cqXVuOoEDa6ZXT1QXO8RRp1bYFRmKu7p
 lbpkcS0UA0m+IsYCovo56v/jzeCYTWaNThWXWmnsP9ICA7Pd9d/m0OFqPhV3pnevi8mq
 IrVg==
X-Gm-Message-State: AOJu0YyhTS6frjbs00uAL2vQVGEngAtPG7MoSoQJxFqjOehrwilnIhtC
 9yc1dO5lIfRidW6/8i12cyvtUeU1I6Aa3piaiLBMjE0JEoQ9yJd4xQILOBGYldZci8PrTMel5nE
 uoOshM31VnEyaJDiveyn+3oUgtBn/h6RKReRRhUZCGRZrgVoAxvxMTtLzq6A2F/fSiAtCYrBL
X-Received: by 2002:a25:aad0:0:b0:d36:4892:998b with SMTP id
 t74-20020a25aad0000000b00d364892998bmr2621812ybi.5.1696456972638; 
 Wed, 04 Oct 2023 15:02:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0NuNqFtG1SCVV1hm7R/eTesN2sU+0T2PmirLTlc5CMv2XuzD2yRUqQ1uxsJZHj1S99CYVog==
X-Received: by 2002:a25:aad0:0:b0:d36:4892:998b with SMTP id
 t74-20020a25aad0000000b00d364892998bmr2621791ybi.5.1696456972254; 
 Wed, 04 Oct 2023 15:02:52 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 w17-20020a0cdf91000000b0063d162a8b8bsm10821qvl.19.2023.10.04.15.02.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 15:02:51 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH v3 09/10] migration: Allow RECOVER->PAUSED convertion for dest
 qemu
Date: Wed,  4 Oct 2023 18:02:39 -0400
Message-ID: <20231004220240.167175-10-peterx@redhat.com>
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

There's a bug on dest that if a double fault triggered on dest qemu (a
network issue during postcopy-recover), we won't set PAUSED correctly
because we assumed we always came from ACTIVE.

Fix that by always overwriting the state to PAUSE.

We could also check for these two states, but maybe it's an overkill.  We
did the same on the src QEMU to unconditionally switch to PAUSE anyway.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 60eec7c31f..497ce02bd7 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2734,7 +2734,8 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
         qemu_mutex_unlock(&mis->postcopy_prio_thread_mutex);
     }
 
-    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
+    /* Current state can be either ACTIVE or RECOVER */
+    migrate_set_state(&mis->state, mis->state,
                       MIGRATION_STATUS_POSTCOPY_PAUSED);
 
     /* Notify the fault thread for the invalidated file handle */
-- 
2.41.0


