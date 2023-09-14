Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9197A02C3
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 13:35:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgkbA-0000kK-Bw; Thu, 14 Sep 2023 07:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qgkb7-0000ib-6y
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 07:33:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qgkb5-00085t-6o
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 07:33:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694691202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GwPVnHHTOLYOMUUbYZji+0+kiIsfxZliLnFx0YDA63k=;
 b=JwYB5ZUoHxYofQ//iY6Ow21b5b75ARdaHeS2PE7qk/XmKYvFluYU2jnJGIZ49PXUAdrP2F
 ra+YOb9VUtHD9EASMt1avUrIEIicPo9fIba1ouEe16SCHVEV51FKkrnuLW9wK0y5B6Zc4K
 oe5xMEZXkhAbXVUokJR32OUCaI3Q8YE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-iT6Tk-zeNnazWE9txJtVsQ-1; Thu, 14 Sep 2023 07:33:19 -0400
X-MC-Unique: iT6Tk-zeNnazWE9txJtVsQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2B78857A9D;
 Thu, 14 Sep 2023 11:33:18 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E33D21054FC0;
 Thu, 14 Sep 2023 11:33:17 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [risu PATCH v3 4/7] s390x: Add basic risugen perl module for s390x
Date: Thu, 14 Sep 2023 13:33:08 +0200
Message-ID: <20230914113311.379537-5-thuth@redhat.com>
In-Reply-To: <20230914113311.379537-1-thuth@redhat.com>
References: <20230914113311.379537-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 0000000..260e2dd
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
+    write_mov_ri(0, 0, (rand(0xffffffff) & 0x00fcff77));
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
2.41.0


