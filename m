Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A73E3AD8FAE
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Jun 2025 16:36:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ5V9-0002mi-Gz; Fri, 13 Jun 2025 10:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@randomman.co.uk>)
 id 1uQ5V5-0002m2-Ma
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:35:23 -0400
Received: from smtp-out-60.livemail.co.uk ([213.171.216.60]
 helo=dkim.livemail.co.uk)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@randomman.co.uk>)
 id 1uQ5V3-0005YL-IS
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:35:23 -0400
Received: from smtp.livemail.co.uk (unknown [10.44.132.84])
 by dkim.livemail.co.uk (Postfix) with ESMTPS id 6B314401DA;
 Fri, 13 Jun 2025 15:35:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=randomman.co.uk;
 s=livemail2; t=1749825318;
 bh=4wzFmIqJLDF3bsupyhMTUOQH5GKFecnztjCeomUpFbs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Hs4lDjfb5H2UeuH2oXUQlhDr4yXr6B5BiE7ut6tCdd1tYFGvGVaJTjKw0XKkQflzz
 ZDBdqG1sIGGVEA12NkR7YGzDRcxoEX7mlvz5MNmGmhzjsrBAP9eIVa/cGOvoKWPDBB
 guGMpHq9LNWC9UeZNpGgxSyZMZTnB77wAR6RMJaM=
Received: from localhost.localdomain (unknown [145.40.191.116])
 (Authenticated sender: roy.hopkins@randomman.co.uk)
 by smtp.livemail.co.uk (Postfix) with ESMTPSA id E95F6A0158;
 Fri, 13 Jun 2025 15:35:13 +0100 (BST)
From: Roy Hopkins <roy.hopkins@randomman.co.uk>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 Gerd Hoffman <kraxel@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v8 07/16] target/i386: Allow setting of R_LDTR and R_TR with
 cpu_x86_load_seg_cache()
Date: Fri, 13 Jun 2025 15:11:47 +0100
Message-ID: <78e48ebe9b96e9efcd0bb8dc43cf0757c993a98c.1749820158.git.roy.hopkins@randomman.co.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1749820158.git.roy.hopkins@randomman.co.uk>
References: <cover.1749820158.git.roy.hopkins@randomman.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.171.216.60;
 envelope-from=roy.hopkins@randomman.co.uk; helo=dkim.livemail.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The x86 segment registers are identified by the X86Seg enumeration which
includes LDTR and TR as well as the normal segment registers. The
function 'cpu_x86_load_seg_cache()' uses the enum to determine which
segment to set. However, specifying R_LDTR or R_TR results in an
out-of-bounds access of the segment array.

Possibly by coincidence, the function does correctly set LDTR or TR in
this case as the structures for these registers immediately follow the
array which is accessed out of bounds.

This patch adds correct handling for R_LDTR and R_TR in the function.

Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
Acked-by: Gerd Hoffman <kraxel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 target/i386/cpu.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 5910dcf74d..cc56f0e74f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2417,7 +2417,14 @@ static inline void cpu_x86_load_seg_cache(CPUX86State *env,
     SegmentCache *sc;
     unsigned int new_hflags;
 
-    sc = &env->segs[seg_reg];
+    if (seg_reg == R_LDTR) {
+        sc = &env->ldt;
+    } else if (seg_reg == R_TR) {
+        sc = &env->tr;
+    } else {
+        sc = &env->segs[seg_reg];
+    }
+
     sc->selector = selector;
     sc->base = base;
     sc->limit = limit;
-- 
2.43.0


