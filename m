Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B2F7E4856
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:34:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Qsd-0002tL-09; Tue, 07 Nov 2023 13:32:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r0Qsb-0002ss-EH
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:32:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r0QsZ-0007Pg-Ts
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:32:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699381967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IW47soXfphW+eoV4lhxIi411QoI1SQPgtHMfVAKYB7Q=;
 b=CEWXdmDTP1nPDvqpVljCaAcNAVoCo0TVfgr9D/OHsO78WDqT5/OBPiu3RYJTirtQkzf/Of
 B+svwX2VmrIlT6mK9HQ74JbN/Ap+HsB6YONFEwvrSX7meusyrk5Bu1JC1Kqu0KXfXHKmDQ
 Hiv2zlBkeXcE5DjXOfwCTlQHTp+Me3E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-BXnGAFTdNrKP7Kpvx2V92g-1; Tue, 07 Nov 2023 13:32:45 -0500
X-MC-Unique: BXnGAFTdNrKP7Kpvx2V92g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4EFCF85A5B5;
 Tue,  7 Nov 2023 18:32:45 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9224C2166B26;
 Tue,  7 Nov 2023 18:32:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 08/11] target/s390x: Fix LAALG not updating cc_src
Date: Tue,  7 Nov 2023 19:32:25 +0100
Message-ID: <20231107183228.276424-9-thuth@redhat.com>
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

LAALG uses op_laa() and wout_addu64(). The latter expects cc_src to be
set, but the former does not do it. This can lead to assertion failures
if something sets cc_src to neither 0 nor 1 before.

Fix by introducing op_laa_addu64(), which sets cc_src, and using it for
LAALG.

Fixes: 4dba4d6fef61 ("target/s390x: Use atomic operations for LOAD AND OP")
Cc: qemu-stable@nongnu.org
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20231106093605.1349201-4-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/tcg/insn-data.h.inc |  2 +-
 target/s390x/tcg/translate.c     | 19 +++++++++++++++++--
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 0bfd88d3c3..2f07f39d9c 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -442,7 +442,7 @@
     D(0xebe8, LAAG,    RSY_a, ILA, r3, a2, new, in2_r1, laa, adds64, MO_TEUQ)
 /* LOAD AND ADD LOGICAL */
     D(0xebfa, LAAL,    RSY_a, ILA, r3_32u, a2, new, in2_r1_32, laa, addu32, MO_TEUL)
-    D(0xebea, LAALG,   RSY_a, ILA, r3, a2, new, in2_r1, laa, addu64, MO_TEUQ)
+    D(0xebea, LAALG,   RSY_a, ILA, r3, a2, new, in2_r1, laa_addu64, addu64, MO_TEUQ)
 /* LOAD AND AND */
     D(0xebf4, LAN,     RSY_a, ILA, r3_32s, a2, new, in2_r1_32, lan, nz32, MO_TESL)
     D(0xebe4, LANG,    RSY_a, ILA, r3, a2, new, in2_r1, lan, nz64, MO_TEUQ)
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index a0d6a2a35d..62ab2be8b1 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2677,17 +2677,32 @@ static DisasJumpType op_kxb(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-static DisasJumpType op_laa(DisasContext *s, DisasOps *o)
+static DisasJumpType help_laa(DisasContext *s, DisasOps *o, bool addu64)
 {
     /* The real output is indeed the original value in memory;
        recompute the addition for the computation of CC.  */
     tcg_gen_atomic_fetch_add_i64(o->in2, o->in2, o->in1, get_mem_index(s),
                                  s->insn->data | MO_ALIGN);
     /* However, we need to recompute the addition for setting CC.  */
-    tcg_gen_add_i64(o->out, o->in1, o->in2);
+    if (addu64) {
+        tcg_gen_movi_i64(cc_src, 0);
+        tcg_gen_add2_i64(o->out, cc_src, o->in1, cc_src, o->in2, cc_src);
+    } else {
+        tcg_gen_add_i64(o->out, o->in1, o->in2);
+    }
     return DISAS_NEXT;
 }
 
+static DisasJumpType op_laa(DisasContext *s, DisasOps *o)
+{
+    return help_laa(s, o, false);
+}
+
+static DisasJumpType op_laa_addu64(DisasContext *s, DisasOps *o)
+{
+    return help_laa(s, o, true);
+}
+
 static DisasJumpType op_lan(DisasContext *s, DisasOps *o)
 {
     /* The real output is indeed the original value in memory;
-- 
2.41.0


