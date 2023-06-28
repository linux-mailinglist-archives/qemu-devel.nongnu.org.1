Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 278B4741B29
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 23:51:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEd3U-0001LZ-2i; Wed, 28 Jun 2023 17:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEd3F-0001It-6N
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:50:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEd3D-0008Ok-EB
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687989010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vjJkYRz5EOF5MasTvu5YbiFs/LHS6Iesq9X7afvvyA0=;
 b=N6C8EaZ/LlxTwenBPW7JLMmTh53c4w2MMj+q+S1TtnfPAfrQDmFzlMfIo+eT9MYRQhN3UI
 RLTwX2Dj0eHFUuMYV2Ww3xjIOArUWcXztAnYfcmobcH327tJZGakb6sA+AzkugYsc0sGmr
 UPfOvOzQZ75/gdKCB4PRUwabg3n7KUE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-Zj-Y4xYPMPq0la3jFxVRxw-1; Wed, 28 Jun 2023 17:50:08 -0400
X-MC-Unique: Zj-Y4xYPMPq0la3jFxVRxw-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-40234d83032so14841cf.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 14:50:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687989008; x=1690581008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vjJkYRz5EOF5MasTvu5YbiFs/LHS6Iesq9X7afvvyA0=;
 b=Bh0e0aL3d4SnaTQ+BTEB2wrqN4FcdnkjSzHqCTpFVjpuUimC/kvdmcAGoKaIr/0yV5
 BcanVKseiVnCwVyWFW3kpKv7oBkqH4OmKHA4HF/ALJwfrtMZBgcmRdQ7su9nCfywxKfh
 67iQyeViz0+Yn3EmFb/CqYYkybZvgHazDYwya+nv93tAAtSidgf4gweNZWFkpMT6/pcY
 ilHfqYswaIhuaCHJRdziLnnGCyehrAZL+v+50VXDAi7pSQXaq3UC4pK+JcIkGaRrilur
 sWwmO6DR2U9Y3qg3h0LrzOrV5fr9h4xUyqPBR+Sz9CBLMsqowCbej3/mDGzhgUesH16s
 NtlQ==
X-Gm-Message-State: AC+VfDy48vFayyE/JrE7opDPHLTyMUWjLqDq4dnoD1FSs0vFCZuCNhpF
 6ZmkX0/TD5SoRhmqxkFsBiZIYTRsCAHKdFCUGc8g5Sb+ePTBblY/X4pBn/lTTQIBAcs8/BXk5Nr
 QElQdS+wYdeJoONy0xxuLitqfbYQCnOfaDRxst+vtSkKtgBqwk5Q5O1/swrh1RL1b0tmFCo71
X-Received: by 2002:ac8:7f83:0:b0:400:9ed9:7267 with SMTP id
 z3-20020ac87f83000000b004009ed97267mr11306046qtj.3.1687989008247; 
 Wed, 28 Jun 2023 14:50:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5LfU/9nt1CTzLVkQgXQlgdsc5pXUL7JrKgq5YmGxUoBuFrVDOZjC3YYwi2A0HBUvGMm68tmg==
X-Received: by 2002:ac8:7f83:0:b0:400:9ed9:7267 with SMTP id
 z3-20020ac87f83000000b004009ed97267mr11306031qtj.3.1687989007965; 
 Wed, 28 Jun 2023 14:50:07 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 w29-20020ac84d1d000000b004032d9209a0sm255552qtv.50.2023.06.28.14.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 14:50:07 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juan Quintela <quintela@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>
Subject: [PATCH 4/7] migration: Deliver return path file error to migrate
 state too
Date: Wed, 28 Jun 2023 17:49:59 -0400
Message-ID: <20230628215002.73546-5-peterx@redhat.com>
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

We've already did this for most of the return path thread errors, but not
yet for the IO errors happened on the return path qemufile.  Do that too.

Remember to reset "err" always, because the ownership is not us anymore,
otherwise we're prone to use-after-free later after recovered.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index f8c41c4d98..234dd3601d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1992,6 +1992,13 @@ out:
 
     res = qemu_file_get_error(rp);
     if (res) {
+        /* We have forwarded any error in "err" already, reuse "error" */
+        assert(err == NULL);
+        /* Try to deliver this file error to migration state */
+        qemu_file_get_error_obj(rp, &err);
+        migrate_set_error(ms, err);
+        err = NULL;
+
         if (res && migration_in_postcopy()) {
             /*
              * Maybe there is something we can do: it looks like a
-- 
2.41.0


