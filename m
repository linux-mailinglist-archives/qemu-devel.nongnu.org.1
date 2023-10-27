Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BA27D94AE
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 12:06:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwJiV-0003Dh-6I; Fri, 27 Oct 2023 06:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qwJiP-0003Cc-P7
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 06:05:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qwJiN-0002AP-Dh
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 06:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698401111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NXV5yiccgCtWbAwpjJPMg1VAWxIO6BfuvJPWxNh/94E=;
 b=hJAER2dafhdAVVL1fM2jY6WvQbNTdZCNbV8OaPG4CCtjMCE43aojdDWouCPlRGrx5jlBce
 Nz6PdQo+KhzIdrHYL5Z1mO0542wzpHvjlebvQEzmwV7BZD3MUmpzIsB7y1X1F9hxzualhM
 Q3qgmWlcO6wD3y/zCOtcoZYylGoqeXo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-H4p2KwgqOdWRRw0ljK5yXw-1; Fri,
 27 Oct 2023 06:05:08 -0400
X-MC-Unique: H4p2KwgqOdWRRw0ljK5yXw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 944FD29ABA1F;
 Fri, 27 Oct 2023 10:05:07 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5BCFD492BFC;
 Fri, 27 Oct 2023 10:05:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Sebastian Mitterle <smitterl@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>,
 Thomas Huth <thuth@redhat.com>
Subject: [risu PATCH 1/2] risugen: allow instructions with length > 32 bit
Date: Fri, 27 Oct 2023 12:04:40 +0200
Message-ID: <20231027100441.375223-2-thuth@redhat.com>
In-Reply-To: <20231027100441.375223-1-thuth@redhat.com>
References: <20231027100441.375223-1-thuth@redhat.com>
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

RISU currently only supports instructions with a length of
16 bit or 32 bit, however classical CISC systems like s390x
also have instructions that are longer than 32 bit. Thus let's
change the generator to support longer instructions, too.

This adds support for 48-bit instructions on s390x, while
the other architectures are just minimally changed to preserve
the current state.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 risugen                | 48 +++++++++++++++++++++++++++++-------------
 risugen_arm.pm         |  6 +++---
 risugen_common.pm      |  2 +-
 risugen_loongarch64.pm |  4 ++--
 risugen_m68k.pm        |  6 +++---
 risugen_ppc64.pm       |  4 ++--
 risugen_s390x.pm       | 17 +++++++++++----
 7 files changed, 57 insertions(+), 30 deletions(-)

diff --git a/risugen b/risugen
index fa94a39..833b459 100755
--- a/risugen
+++ b/risugen
@@ -105,6 +105,16 @@ sub read_tokenised_line(*)
     return @tokens;
 }
 
+sub check_bitmask($$)
+{
+    my ($fixedbits, $fixedbitmask) = @_;
+
+    if ((($fixedbits & $fixedbitmask) != $fixedbits)
+        || (($fixedbits & ~$fixedbitmask) != 0)) {
+        die "internal error: fixed bits not lined up with mask";
+    }
+}
+
 sub parse_config_file($)
 {
     # Read in the config file defining the instructions we can generate
@@ -160,10 +170,11 @@ sub parse_config_file($)
             exit(1);
         }
 
-        my $fixedbits = 0;
-        my $fixedbitmask = 0;
+        my @fixedbits = (0, 0, 0, 0);
+        my @fixedbitmask = (0, 0, 0, 0);
         my $bitpos = 32;
-        my $insnwidth = 32;
+        my $wordpos = 0;
+        my $insnwidth = 0;
         my $seenblock = 0;
 
         while (@bits) {
@@ -217,36 +228,43 @@ sub parse_config_file($)
 
             my $bitmask = oct("0b". '1' x $bitlen);
             $bitpos -= $bitlen;
+            $insnwidth += $bitlen;
             if ($bitpos < 0) {
                 print STDERR "$file:$.: ($insn $enc) too many bits specified\n";
                 exit(1);
             }
 
             if (defined $bitval) {
-                $fixedbits |= ($bitval << $bitpos);
-                $fixedbitmask |= ($bitmask << $bitpos);
+                $fixedbits[$wordpos] |= ($bitval << $bitpos);
+                $fixedbitmask[$wordpos] |= ($bitmask << $bitpos);
             } else {
-                push @fields, [ $var, $bitpos, $bitmask ];
+                push @fields, [ $var, $bitpos, $bitmask, $wordpos ];
+            }
+
+            if ($bitpos == 0) {
+                check_bitmask($fixedbits[$wordpos], $fixedbitmask[$wordpos]);
+
+                $wordpos += 1;
+                if (@bits) {
+                    $bitpos = 32;
+                }
             }
         }
         if ($bitpos == 16) {
             # assume this is a half-width thumb instruction
             # Note that we don't fiddle with the bitmasks or positions,
             # which means the generated insn will be in the high halfword!
-            $insnwidth = 16;
-        } elsif ($bitpos != 0) {
-            print STDERR "$file:$.: ($insn $enc) not enough bits specified\n";
+            check_bitmask($fixedbits[$wordpos], $fixedbitmask[$wordpos]);
+        } elsif ($bitpos != 0 && $bitpos != 32) {
+            print STDERR "$file:$.: ($insn $enc) not enough bits specified ($bitpos)\n";
             exit(1);
         }
-        if ((($fixedbits & $fixedbitmask) != $fixedbits)
-            || (($fixedbits & ~$fixedbitmask) != 0)) {
-            die "internal error: fixed bits not lined up with mask";
-        }
         #  Stick the fixedbit info on the front of the array now we know it
         $insnrec->{name} = $insnname;
         $insnrec->{width} = $insnwidth;
-        $insnrec->{fixedbits} = $fixedbits;
-        $insnrec->{fixedbitmask} = $fixedbitmask;
+        $insnrec->{fixedbits} = [ @fixedbits ];
+        $insnrec->{fixedbitmask} = [ @fixedbitmask ];
+        $insnrec->{words} = $wordpos;
         $insnrec->{fields} = [ @fields ];
         if (@insn_groups) {
             $insnrec->{groups} = [ @insn_groups ];
diff --git a/risugen_arm.pm b/risugen_arm.pm
index 8d423b1..9dd6139 100644
--- a/risugen_arm.pm
+++ b/risugen_arm.pm
@@ -964,15 +964,15 @@ sub gen_one_insn($$)
         my $insn = int(rand(0xffffffff));
         my $insnname = $rec->{name};
         my $insnwidth = $rec->{width};
-        my $fixedbits = $rec->{fixedbits};
-        my $fixedbitmask = $rec->{fixedbitmask};
+        my $fixedbits = (@{ $rec->{fixedbits} })[0];
+        my $fixedbitmask = (@{  $rec->{fixedbitmask} })[0];
         my $constraint = $rec->{blocks}{"constraints"};
         my $memblock = $rec->{blocks}{"memory"};
 
         $insn &= ~$fixedbitmask;
         $insn |= $fixedbits;
         for my $tuple (@{ $rec->{fields} }) {
-            my ($var, $pos, $mask) = @$tuple;
+            my ($var, $pos, $mask, $wordpos) = @$tuple;
             my $val = ($insn >> $pos) & $mask;
             # XXX (claudio) ARM-specific - maybe move to arm.risu?
             # Check constraints here:
diff --git a/risugen_common.pm b/risugen_common.pm
index 71ee996..c816895 100644
--- a/risugen_common.pm
+++ b/risugen_common.pm
@@ -116,7 +116,7 @@ sub eval_with_fields($$$$$) {
     my $calling_package = caller;
     my $evalstr = "{ package $calling_package; ";
     for my $tuple (@{ $rec->{fields} }) {
-        my ($var, $pos, $mask) = @$tuple;
+        my ($var, $pos, $mask, $wordpos) = @$tuple;
         my $val = ($insn >> $pos) & $mask;
         $evalstr .= "my (\$$var) = $val; ";
     }
diff --git a/risugen_loongarch64.pm b/risugen_loongarch64.pm
index 5394fdc..8c74b6e 100644
--- a/risugen_loongarch64.pm
+++ b/risugen_loongarch64.pm
@@ -390,8 +390,8 @@ sub gen_one_insn($$)
         my $insn = int(rand(0xffffffff));
         my $insnname = $rec->{name};
         my $insnwidth = $rec->{width};
-        my $fixedbits = $rec->{fixedbits};
-        my $fixedbitmask = $rec->{fixedbitmask};
+        my $fixedbits = (@{ $rec->{fixedbits} })[0];
+        my $fixedbitmask = (@{  $rec->{fixedbitmask} })[0];
         my $constraint = $rec->{blocks}{"constraints"};
         my $memblock = $rec->{blocks}{"memory"};
         my $safefloat = $rec->{blocks}{"safefloat"};
diff --git a/risugen_m68k.pm b/risugen_m68k.pm
index 7d62b13..49f3100 100644
--- a/risugen_m68k.pm
+++ b/risugen_m68k.pm
@@ -111,8 +111,8 @@ sub gen_one_insn($$)
         my $insn = int(rand(0xffffffff));
         my $insnname = $rec->{name};
         my $insnwidth = $rec->{width};
-        my $fixedbits = $rec->{fixedbits};
-        my $fixedbitmask = $rec->{fixedbitmask};
+        my $fixedbits = (@{ $rec->{fixedbits} })[0];
+        my $fixedbitmask = (@{  $rec->{fixedbitmask} })[0];
         my $constraint = $rec->{blocks}{"constraints"};
         my $memblock = $rec->{blocks}{"memory"};
 
@@ -120,7 +120,7 @@ sub gen_one_insn($$)
         $insn |= $fixedbits;
 
         for my $tuple (@{ $rec->{fields} }) {
-            my ($var, $pos, $mask) = @$tuple;
+            my ($var, $pos, $mask, $wordpos) = @$tuple;
             my $val = ($insn >> $pos) & $mask;
             # Check constraints here:
             # not allowed to use or modify sp (A7) or fp (A6)
diff --git a/risugen_ppc64.pm b/risugen_ppc64.pm
index b241172..d1d3fc9 100644
--- a/risugen_ppc64.pm
+++ b/risugen_ppc64.pm
@@ -300,8 +300,8 @@ sub gen_one_insn($$)
         my $insn = int(rand(0xffffffff));
         my $insnname = $rec->{name};
         my $insnwidth = $rec->{width};
-        my $fixedbits = $rec->{fixedbits};
-        my $fixedbitmask = $rec->{fixedbitmask};
+        my $fixedbits = (@{ $rec->{fixedbits} })[0];
+        my $fixedbitmask = (@{  $rec->{fixedbitmask} })[0];
         my $constraint = $rec->{blocks}{"constraints"};
         my $memblock = $rec->{blocks}{"memory"};
 
diff --git a/risugen_s390x.pm b/risugen_s390x.pm
index 260e2dd..04ea6fb 100644
--- a/risugen_s390x.pm
+++ b/risugen_s390x.pm
@@ -84,15 +84,21 @@ sub gen_one_insn($$)
     INSN: while(1) {
         my ($forcecond, $rec) = @_;
         my $insn = int(rand(0xffffffff));
+        my $insn48 = int(rand(0xffff0000));
         my $insnname = $rec->{name};
         my $insnwidth = $rec->{width};
-        my $fixedbits = $rec->{fixedbits};
-        my $fixedbitmask = $rec->{fixedbitmask};
+        my @fixedbits = (@{ $rec->{fixedbits} });
+        my @fixedbitmask = (@{  $rec->{fixedbitmask} });
         my $constraint = $rec->{blocks}{"constraints"};
         my $memblock = $rec->{blocks}{"memory"};
 
-        $insn &= ~$fixedbitmask;
-        $insn |= $fixedbits;
+        $insn &= ~$fixedbitmask[0];
+        $insn |= $fixedbits[0];
+
+        if ($insnwidth == 48) {
+            $insn48 &= ~$fixedbitmask[1];
+            $insn48 |= $fixedbits[1];
+        }
 
         if (defined $constraint) {
             # user-specified constraint: evaluate in an environment
@@ -121,6 +127,9 @@ sub gen_one_insn($$)
             insn16(($insn >> 16) & 0xffff);
         } else {
             insn32($insn);
+            if ($insnwidth == 48) {
+                insn16(($insn48 >> 16) & 0xffff);
+            }
         }
 
         return;
-- 
2.41.0


