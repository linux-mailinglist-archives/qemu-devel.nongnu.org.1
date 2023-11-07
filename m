Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE3B7E4853
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:34:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Qsm-0002xg-5G; Tue, 07 Nov 2023 13:33:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r0Qsi-0002vk-TH
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:32:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r0Qsd-0007QV-T6
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:32:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699381971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DZ22M0ErlM+kwkIYMe4Wkn3BowRlG1ILztjN4wadLWU=;
 b=L6KuBmD/gttKQ1MNq00pSMrUzvTmTS3EuvMxyNEvhWvcbRpkoXn7is6WHg/BcToWEPjnIE
 rn/txJwiQW4h5DMSPpkVyr7/KZ2Aowa/QeSPQKB/+FvF3C39FSm/f19LlY2JyJxWalDw/S
 Jg4gehUzJS61J3eq5O6iaArR6fMaG84=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-WnGn5e7kOomBgqD25pzZzA-1; Tue,
 07 Nov 2023 13:32:49 -0500
X-MC-Unique: WnGn5e7kOomBgqD25pzZzA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C87638041C5;
 Tue,  7 Nov 2023 18:32:49 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A61C22166B26;
 Tue,  7 Nov 2023 18:32:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PULL 11/11] target/s390x/cpu topology: Fix ordering and creation of
 TLEs
Date: Tue,  7 Nov 2023 19:32:28 +0100
Message-ID: <20231107183228.276424-12-thuth@redhat.com>
In-Reply-To: <20231107183228.276424-1-thuth@redhat.com>
References: <20231107183228.276424-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

In case of horizontal polarization entitlement has no effect on
ordering.
Moreover, since the comparison is used to insert CPUs at the correct
position in the TLE list, this affects the creation of TLEs and now
correctly collapses horizontally polarized CPUs into one TLE.

Fixes: f4f54b582f ("target/s390x/cpu topology: handle STSI(15) and build the SYSIB")
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Message-ID: <20231027163637.3060537-1-nsg@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/kvm/stsi-topology.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/s390x/kvm/stsi-topology.c b/target/s390x/kvm/stsi-topology.c
index efd2aa71f1..c8d6389cd8 100644
--- a/target/s390x/kvm/stsi-topology.c
+++ b/target/s390x/kvm/stsi-topology.c
@@ -210,6 +210,9 @@ static S390TopologyId s390_topology_from_cpu(S390CPU *cpu)
 static int s390_topology_id_cmp(const S390TopologyId *l,
                                 const S390TopologyId *r)
 {
+    int l_polarization = l->vertical ? l->entitlement : 0;
+    int r_polarization = r->vertical ? r->entitlement : 0;
+
     /*
      * lexical order, compare less significant values only if more significant
      * ones are equal
@@ -219,9 +222,8 @@ static int s390_topology_id_cmp(const S390TopologyId *l,
            l->book - r->book ?:
            l->socket - r->socket ?:
            l->type - r->type ?:
-           /* logic is inverted for the next three */
-           r->vertical - l->vertical ?:
-           r->entitlement - l->entitlement ?:
+           /* logic is inverted for the next two */
+           r_polarization - l_polarization ?:
            r->dedicated - l->dedicated ?:
            l->origin - r->origin;
 }
-- 
2.41.0


