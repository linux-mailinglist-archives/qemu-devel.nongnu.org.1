Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4A47B6BDC
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 16:39:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qngY6-0000Gb-16; Tue, 03 Oct 2023 10:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qngY3-0000GE-2Q
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 10:38:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qngY1-0000DE-K8
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 10:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696343931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=NZjRsetpvfM5QVsVtqHHO1lSLSDnYvYSciVL7xAwjaY=;
 b=g6LL6h6tog6cd7qmtMU1fIRCqfyvcAMCXGAT3P507Yu+Kjem6sDnXm3rWcdgK496z8pOaS
 xV3msLqQ1k+O610LhaH4cNFvbGTxgukxnzflJb47XWPczUc32qrlgheyH2M6SI8Y/uHgvL
 sIGIiUAvJ6RZv8eUHMxWUU6z0wjib4c=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-fTqfxIOkPVmvR_NErC-OnQ-1; Tue, 03 Oct 2023 10:38:49 -0400
X-MC-Unique: fTqfxIOkPVmvR_NErC-OnQ-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4197b919ba2so2260561cf.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 07:38:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696343929; x=1696948729;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NZjRsetpvfM5QVsVtqHHO1lSLSDnYvYSciVL7xAwjaY=;
 b=uIcR89GpZ9pf7/gRmSXEvKcFSUGTdvd4tWjmcPoszkYMEKZ7Ij+nldSXJpd7MNwZ8Q
 e0spiFOvtCyHQwySkuK5eiFO9TgzqPQDJg1cCk+x4ajgKGoUQXkz/fqPr+6krdyLNPHJ
 B7sPsMCNaAeRCNu6CGEC1lq4t5KDIxNw1wB7DUcAgCAE0KsgdEoQcGeidbN+28w04k0E
 kJyFnuj9KlqLgIUpiGcjjY/BbZkjxyJhZb07goY6E1nJlBMdj1dIITuTSL5s6KVkpkS8
 OLWdp+aEAVQGk7O1ooAXP99QA52NCABs/U7CUah9I9AnWhEjgQ/ckTq5iJD6M5Nyp7yA
 9QXQ==
X-Gm-Message-State: AOJu0Yzrhqv/d8gmPtuXU9dESRo3RgduwVY0Kcob99apnPrqOjzmHRm9
 7Q1RlSHu2QvrMXFMF2Hbjvq/BWNAnFQhix3tNazi7BfRlDEXVkOa1Y3MNssDZ++PIqaQ5+hd+n6
 G77JY3crDtTmAFB8fU4LQJjN40HIFiuWFJL+pWCKBGi4IJweerkfIFL6S7NiAMFIrLre3BdHb
X-Received: by 2002:ac8:7d0f:0:b0:412:12e8:8538 with SMTP id
 g15-20020ac87d0f000000b0041212e88538mr18240334qtb.1.1696343929005; 
 Tue, 03 Oct 2023 07:38:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEJlyk0+FIcAJd+OHxcct1M8/vyje0GcOwz/IvMgybyo3ecx6G68r9XNgenk4uv4r4b5mowQ==
X-Received: by 2002:ac8:7d0f:0:b0:412:12e8:8538 with SMTP id
 g15-20020ac87d0f000000b0041212e88538mr18240311qtb.1.1696343928597; 
 Tue, 03 Oct 2023 07:38:48 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 f19-20020ac840d3000000b00419b0dbec73sm413435qtm.67.2023.10.03.07.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 07:38:48 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH] migration: Add co-maintainers for migration
Date: Tue,  3 Oct 2023 10:38:47 -0400
Message-ID: <20231003143847.9245-1-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
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

Per the qemu upstream call a few hours ago, proposing Fabiano and myself as
the co-maintainer for migration subsystem to help Juan.

Cc: Fabiano Rosas <farosas@suse.de>
Cc: Juan Quintela <quintela@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---

Fabiano, would you please ack here publically to acknowledge that you're
fine with it?  Thank you!

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 81625f036b..fc6e09aa31 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3207,7 +3207,8 @@ F: scripts/checkpatch.pl
 
 Migration
 M: Juan Quintela <quintela@redhat.com>
-R: Peter Xu <peterx@redhat.com>
+M: Peter Xu <peterx@redhat.com>
+M: Fabiano Rosas <farosas@suse.de>
 R: Leonardo Bras <leobras@redhat.com>
 S: Maintained
 F: hw/core/vmstate-if.c
-- 
2.41.0


