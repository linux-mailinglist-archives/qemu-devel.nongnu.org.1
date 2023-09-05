Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4315792240
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 13:52:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdUZr-000801-FZ; Tue, 05 Sep 2023 07:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qdUZW-0007vp-1D
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 07:50:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qdUZR-0001o5-VK
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 07:50:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693914611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kt1wncbBqmPq7NlgspXJMfxjtBCDrRPO4IcfJMnIOGU=;
 b=HsaygAH8FkHby1fVFpY0wQirJbpj6eZj5UtvZ03CXnche/PCGaRWevhqV43WXD8rUzrvZ7
 338I+7tQ6e8TayC347fyqGzzw7QdFCPg0em9rLzZZk5H4m7Sd5V/AlQNI5jD+6JF5L7pim
 +ZS1C7rGO+nJisOrIuWt9LxLkYrGFXo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-QU985TOcMLuLaauInvyn-Q-1; Tue, 05 Sep 2023 07:50:09 -0400
X-MC-Unique: QU985TOcMLuLaauInvyn-Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F3F61C08967;
 Tue,  5 Sep 2023 11:50:09 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.241])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DDE1040CF8EA;
 Tue,  5 Sep 2023 11:50:07 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>
Subject: [risu PATCH v2 3/4] s390x: Add basic risugen perl module for s390x
Date: Tue,  5 Sep 2023 13:49:59 +0200
Message-Id: <20230905115000.53587-4-thuth@redhat.com>
In-Reply-To: <20230905115000.53587-1-thuth@redhat.com>
References: <20230905115000.53587-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

This implements support for simple 16-bit and 32-bit instructions.
Support for 48-bit instructions and support for load/store memory
instructions is not implemented yet.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 risugen_s390x.pm | 186 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 186 insertions(+)
 create mode 100644 risugen_s390x.pm

diff --git a/risugen_s390x.pm b/risugen_s390x.pm
new file mode 100644
index 0000000..f0d03c4
--- /dev/null
+++ b/risugen_s390x.pm
@@ -0,0 +1,186 @@
+#!/usr/bin/perl -w
+###############################################################################
+# Copyright 2023 Red Hat Inc.
+# All rights reserved. This program and the accompanying materials
+# are made available under the terms of the Eclipse Public License v1.0
+# which accompanies this distribution, and is available at
+# http://www.eclipse.org/legal/epl-v10.html
+#
+# Contributors:
+#     Thomas Huth - initial implementation (based on risugen_ppc64.pm etc.)
+###############################################################################
+
+# risugen -- generate a test binary file for use with risu
+# See 'risugen --help' for usage information.
+package risugen_s390x;
+
+use strict;
+use warnings;
+
+use risugen_common;
+
+require Exporter;
+
+our @ISA    = qw(Exporter);
+our @EXPORT = qw(write_test_code);
+
+my $periodic_reg_random = 1;
+
+# Maximum alignment restriction permitted for a memory op.
+my $MAXALIGN = 64;
+
+sub write_mov_ri($$$)
+{
+    my ($r, $imm_h, $imm_l) = @_;
+
+    # LGFI
+    insn16(0xc0 << 8 | $r << 4 | 0x1);
+    insn32($imm_l);
+    # IIHF r,imm_high
+    insn16(0xc0 << 8 | $r << 4 | 0x8);
+    insn32($imm_h);
+}
+
+sub write_mov_fp($$)
+{
+    my ($r, $imm) = @_;
+
+    write_mov_ri(0, ~$imm, $imm);
+    # LDGR
+    insn32(0xb3c1 << 16 | $r << 4);
+}
+
+sub write_random_regdata()
+{
+    # Floating point registers
+    for (my $i = 0; $i < 16; $i++) {
+        write_mov_fp($i, rand(0xffffffff));
+    }
+
+    # Load FPC (via r0)
+    write_mov_ri(0, 0, (rand(0xffffffff) & 0xfcfcff77));
+    insn32(0xb3840000);
+
+    # general purpose registers
+    for (my $i = 0; $i < 16; $i++) {
+        write_mov_ri($i, rand(0xffffffff), rand(0xffffffff));
+    }
+}
+
+my $OP_COMPARE = 0;        # compare registers
+my $OP_TESTEND = 1;        # end of test, stop
+
+sub write_random_register_data()
+{
+    write_random_regdata();
+    write_risuop($OP_COMPARE);
+}
+
+sub gen_one_insn($$)
+{
+    # Given an instruction-details array, generate an instruction
+    my $constraintfailures = 0;
+
+    INSN: while(1) {
+        my ($forcecond, $rec) = @_;
+        my $insn = int(rand(0xffffffff));
+        my $insnname = $rec->{name};
+        my $insnwidth = $rec->{width};
+        my $fixedbits = $rec->{fixedbits};
+        my $fixedbitmask = $rec->{fixedbitmask};
+        my $constraint = $rec->{blocks}{"constraints"};
+        my $memblock = $rec->{blocks}{"memory"};
+
+        $insn &= ~$fixedbitmask;
+        $insn |= $fixedbits;
+
+        if (defined $constraint) {
+            # user-specified constraint: evaluate in an environment
+            # with variables set corresponding to the variable fields.
+            my $v = eval_with_fields($insnname, $insn, $rec, "constraints", $constraint);
+            if (!$v) {
+                $constraintfailures++;
+                if ($constraintfailures > 10000) {
+                    print "10000 consecutive constraint failures for $insnname constraints string:\n$constraint\n";
+                    exit (1);
+                }
+                next INSN;
+            }
+        }
+
+        # OK, we got a good one
+        $constraintfailures = 0;
+
+        my $basereg;
+
+        if (defined $memblock) {
+            die "memblock handling has not been implemented yet."
+        }
+
+        if ($insnwidth == 16) {
+            insn16(($insn >> 16) & 0xffff);
+        } else {
+            insn32($insn);
+        }
+
+        return;
+    }
+}
+
+sub write_risuop($)
+{
+    my ($op) = @_;
+    insn32(0x835a0f00 | $op);
+}
+
+sub write_test_code($)
+{
+    my ($params) = @_;
+
+    my $condprob = $params->{ 'condprob' };
+    my $numinsns = $params->{ 'numinsns' };
+    my $outfile = $params->{ 'outfile' };
+
+    my %insn_details = %{ $params->{ 'details' } };
+    my @keys = @{ $params->{ 'keys' } };
+
+    set_endian(1);
+
+    open_bin($outfile);
+
+    # convert from probability that insn will be conditional to
+    # probability of forcing insn to unconditional
+    $condprob = 1 - $condprob;
+
+    # TODO better random number generator?
+    srand(0);
+
+    print "Generating code using patterns: @keys...\n";
+    progress_start(78, $numinsns);
+
+    if (grep { defined($insn_details{$_}->{blocks}->{"memory"}) } @keys) {
+        write_memblock_setup();
+    }
+
+    # memblock setup doesn't clean its registers, so this must come afterwards.
+    write_random_register_data();
+
+    for my $i (1..$numinsns) {
+        my $insn_enc = $keys[int rand (@keys)];
+        #dump_insn_details($insn_enc, $insn_details{$insn_enc});
+        my $forcecond = (rand() < $condprob) ? 1 : 0;
+        gen_one_insn($forcecond, $insn_details{$insn_enc});
+        write_risuop($OP_COMPARE);
+        # Rewrite the registers periodically. This avoids the tendency
+        # for the VFP registers to decay to NaNs and zeroes.
+        if ($periodic_reg_random && ($i % 100) == 0) {
+            write_random_register_data();
+        }
+        progress_update($i);
+    }
+    write_risuop($OP_TESTEND);
+    progress_end();
+    close_bin();
+}
+
+1;
-- 
2.39.3


