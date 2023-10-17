Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9547CC74D
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 17:21:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qslrI-0007Yl-D2; Tue, 17 Oct 2023 11:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qslrC-0007Wp-4i
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:19:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qslr9-00052f-Ou
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697555978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=TRLNDSq+1weHDzB9aN5IRG9nShjNEis4UvQgjL5m/HQ=;
 b=KIBiWqfcoxbbDnsx/dffUu6TnfCt1espK5DBgd/tLpqFhyvxyG9DSQGqPzUy6yIm4OypDu
 YRwz+7WJqiUpD70qibfnr+LqvDPXbfREUGn1bnzFqaTR7ZBxwuIZSMaBzxPLzmaTP/S0Xm
 i+ECOaRR+Xzy855sYEpPAhBCslQ2td4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-n07pviRpMUWu5qpHTEvTaQ-1; Tue, 17 Oct 2023 11:19:35 -0400
X-MC-Unique: n07pviRpMUWu5qpHTEvTaQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BD8F3381259A;
 Tue, 17 Oct 2023 15:19:34 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.155])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F0C35492BFA;
 Tue, 17 Oct 2023 15:19:33 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-trivial@nongnu.org
Subject: [PATCH] MAINTAINERS: Add hw/input/lasips2.c to the HPPA machine
 section
Date: Tue, 17 Oct 2023 17:19:33 +0200
Message-ID: <20231017151933.213780-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

hw/input/lasips2.c and the corresponding header include/hw/input/lasips2.h
are only used by the HPPA machine, so add them to the corresponding section
in the MAINTAINERS file.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b0416d473e..a0ad23b9b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1199,9 +1199,11 @@ R: Helge Deller <deller@gmx.de>
 S: Odd Fixes
 F: configs/devices/hppa-softmmu/default.mak
 F: hw/hppa/
+F: hw/input/lasips2.c
 F: hw/net/*i82596*
 F: hw/misc/lasi.c
 F: hw/pci-host/dino.c
+F: include/hw/input/lasips2.h
 F: include/hw/misc/lasi.h
 F: include/hw/net/lasi_82596.h
 F: include/hw/pci-host/dino.h
-- 
2.41.0


