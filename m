Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA44170DBF6
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 14:06:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Ql7-0002QV-Db; Tue, 23 May 2023 08:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q1Ql5-0002Pk-K0
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:04:55 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q1Ql3-0008Qv-7e
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:04:55 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f60ec45314so1659025e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 05:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684843492; x=1687435492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FK0kwEu4kzUizKTcdb7b9atTVcQCpq+2RRFxmoaG+cE=;
 b=OmcTKVpOVUmpDvdSuuQxk0GxJN+kvscNCYn9/wUDjCKkB4TvSWlhF6hweCMNtLXd4M
 TfZUrE7UPIoWwAkgD2R5oxDdK6Q1CXuUPXAPagj0MFMxKgdXBYi8v9PzpPq5s84w72Lx
 i3JDY/iFF3W/TRyS7boB2tViQtF+xYoaK8YcFwFPrW8nsr1EM9OBKE8dYEJwf8j+DHYD
 73ce2ltSLe/sZxDE1cQHZ4am/eHRlRC6CjzquALAqdPxInyTlkyEVJ7q8iRvqu7d3DXE
 /HJH5VWU/vWWGR8ud8q9hHZQMpiU4vrOvrEme5iZgigoC5B2ezzBjEEAa7PZcRo2BgcM
 l0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684843492; x=1687435492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FK0kwEu4kzUizKTcdb7b9atTVcQCpq+2RRFxmoaG+cE=;
 b=h2w0V6M0QnJO0TM9wshIMG0Illw3o/yEsPVV4iv/kGwKUQt6J5G2l5eVwhgrI5RN5X
 pnagZ/XUud5MUaof6U7duXQ+cVfT4+vfIzdQjZZt4ld0cfpbu0c85Vv3vuTt4MpYWgIT
 nN9so3vWt169MJu0vFK96zN9MqcQr6mFc0s0F0WuoHcpYSVop8RPknu2hNtf+sWjioMJ
 Dd6h/qeLgIA9ff3Wy+QWVyrsd0nOG3YnpbvF/FHmef+gcEBF8xVOgd0S1RXb/8slKrt5
 GkkQDlnhQ1mXhFH8SRQMc24tXZTBryc6FgHIV+eZTW6UwIY5HC4eTmY4CU2dvvxWOXkP
 mPyA==
X-Gm-Message-State: AC+VfDxY5mvauKo/USrJ8XZrv3tyMCfxMCJcKMoTdh4MTNV9yq1/x03E
 wp0E8R7fOpLYFhiC6Crgvqa7noY+iwWxnJzHXm8=
X-Google-Smtp-Source: ACHHUZ4fpN68I7rnfmZE/cK2Rq5pa5gCszbF7H4uNr5iIRRYLksDu2bVhLmvl23kjXAbwHsbpuwcJQ==
X-Received: by 2002:a7b:c7cb:0:b0:3f5:d313:db68 with SMTP id
 z11-20020a7bc7cb000000b003f5d313db68mr9933647wmk.5.1684843491765; 
 Tue, 23 May 2023 05:04:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 l17-20020adfe591000000b003079c402762sm10848778wrm.19.2023.05.23.05.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 05:04:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 5/6] scripts/decodetree: Implement named field support
Date: Tue, 23 May 2023 13:04:46 +0100
Message-Id: <20230523120447.728365-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523120447.728365-1-peter.maydell@linaro.org>
References: <20230523120447.728365-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Implement support for named fields, i.e.  where one field is defined
in terms of another, rather than directly in terms of bits extracted
from the instruction.

The new method referenced_fields() on all the Field classes returns a
list of fields that this field references.  This just passes through,
except for the new NamedField class.

We can then use referenced_fields() to:
 * construct a list of 'dangling references' for a format or
   pattern, which is the fields that the format/pattern uses but
   doesn't define itself
 * do a topological sort, so that we output "field = value"
   assignments in an order that means that we assign a field before
   we reference it in a subsequent assignment
 * check when we output the code for a pattern whether we need to
   fill in the format fields before or after the pattern fields, and
   do other error checking

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/decodetree.py | 145 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 139 insertions(+), 6 deletions(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index e1fd995eaab..70629b37646 100644
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -284,6 +284,9 @@ def str_extract(self, lvalue_formatter):
         s = 's' if self.sign else ''
         return f'{s}extract{bitop_width}(insn, {self.pos}, {self.len})'
 
+    def referenced_fields(self):
+        return []
+
     def __eq__(self, other):
         return self.sign == other.sign and self.mask == other.mask
 
@@ -315,6 +318,12 @@ def str_extract(self, lvalue_formatter):
             pos += f.len
         return ret
 
+    def referenced_fields(self):
+        l = []
+        for f in self.subs:
+            l.extend(f.referenced_fields())
+        return l
+
     def __ne__(self, other):
         if len(self.subs) != len(other.subs):
             return True
@@ -341,6 +350,9 @@ def __str__(self):
     def str_extract(self, lvalue_formatter):
         return str(self.value)
 
+    def referenced_fields(self):
+        return []
+
     def __cmp__(self, other):
         return self.value - other.value
 # end ConstField
@@ -361,6 +373,9 @@ def str_extract(self, lvalue_formatter):
         return (self.func + '(ctx, '
                 + self.base.str_extract(lvalue_formatter) + ')')
 
+    def referenced_fields(self):
+        return self.base.referenced_fields()
+
     def __eq__(self, other):
         return self.func == other.func and self.base == other.base
 
@@ -382,6 +397,9 @@ def __str__(self):
     def str_extract(self, lvalue_formatter):
         return self.func + '(ctx)'
 
+    def referenced_fields(self):
+        return []
+
     def __eq__(self, other):
         return self.func == other.func
 
@@ -389,6 +407,32 @@ def __ne__(self, other):
         return not self.__eq__(other)
 # end ParameterField
 
+class NamedField:
+    """Class representing a field already named in the pattern"""
+    def __init__(self, name, sign, len):
+        self.mask = 0
+        self.sign = sign
+        self.len = len
+        self.name = name
+
+    def __str__(self):
+        return self.name
+
+    def str_extract(self, lvalue_formatter):
+        global bitop_width
+        s = 's' if self.sign else ''
+        lvalue = lvalue_formatter(self.name)
+        return f'{s}extract{bitop_width}({lvalue}, 0, {self.len})'
+
+    def referenced_fields(self):
+        return [self.name]
+
+    def __eq__(self, other):
+        return self.name == other.name
+
+    def __ne__(self, other):
+        return not self.__eq__(other)
+# end NamedField
 
 class Arguments:
     """Class representing the extracted fields of a format"""
@@ -412,7 +456,6 @@ def output_def(self):
             output('} ', self.struct_name(), ';\n\n')
 # end Arguments
 
-
 class General:
     """Common code between instruction formats and instruction patterns"""
     def __init__(self, name, lineno, base, fixb, fixm, udfm, fldm, flds, w):
@@ -426,6 +469,7 @@ def __init__(self, name, lineno, base, fixb, fixm, udfm, fldm, flds, w):
         self.fieldmask = fldm
         self.fields = flds
         self.width = w
+        self.dangling = None
 
     def __str__(self):
         return self.name + ' ' + str_match_bits(self.fixedbits, self.fixedmask)
@@ -433,10 +477,51 @@ def __str__(self):
     def str1(self, i):
         return str_indent(i) + self.__str__()
 
+    def dangling_references(self):
+        # Return a list of all named references which aren't satisfied
+        # directly by this format/pattern. This will be either:
+        #  * a format referring to a field which is specified by the
+        #    pattern(s) using it
+        #  * a pattern referring to a field which is specified by the
+        #    format it uses
+        #  * a user error (referring to a field that doesn't exist at all)
+        if self.dangling is None:
+            # Compute this once and cache the answer
+            dangling = []
+            for n, f in self.fields.items():
+                for r in f.referenced_fields():
+                    if r not in self.fields:
+                        dangling.append(r)
+            self.dangling = dangling
+        return self.dangling
+
     def output_fields(self, indent, lvalue_formatter):
+        # We use a topological sort to ensure that any use of NamedField
+        # comes after the initialization of the field it is referencing.
+        graph = {}
         for n, f in self.fields.items():
-            output(indent, lvalue_formatter(n), ' = ',
-                   f.str_extract(lvalue_formatter), ';\n')
+            refs = f.referenced_fields()
+            graph[n] = refs
+
+        try:
+            ts = TopologicalSorter(graph)
+            for n in ts.static_order():
+                # We only want to emit assignments for the keys
+                # in our fields list, not for anything that ends up
+                # in the tsort graph only because it was referenced as
+                # a NamedField.
+                try:
+                    f = self.fields[n]
+                    output(indent, lvalue_formatter(n), ' = ',
+                           f.str_extract(lvalue_formatter), ';\n')
+                except KeyError:
+                    pass
+        except CycleError as e:
+            # The second element of args is a list of nodes which form
+            # a cycle (there might be others too, but only one is reported).
+            # Pretty-print it to tell the user.
+            cycle = ' => '.join(e.args[1])
+            error(self.lineno, 'field definitions form a cycle: ' + cycle)
 # end General
 
 
@@ -471,10 +556,36 @@ def output_code(self, i, extracted, outerbits, outermask):
         ind = str_indent(i)
         arg = self.base.base.name
         output(ind, '/* ', self.file, ':', str(self.lineno), ' */\n')
+        # We might have named references in the format that refer to fields
+        # in the pattern, or named references in the pattern that refer
+        # to fields in the format. This affects whether we extract the fields
+        # for the format before or after the ones for the pattern.
+        # For simplicity we don't allow cross references in both directions.
+        # This is also where we catch the syntax error of referring to
+        # a nonexistent field.
+        fmt_refs = self.base.dangling_references()
+        for r in fmt_refs:
+            if r not in self.fields:
+                error(self.lineno, f'format refers to undefined field {r}')
+        pat_refs = self.dangling_references()
+        for r in pat_refs:
+            if r not in self.base.fields:
+                error(self.lineno, f'pattern refers to undefined field {r}')
+        if pat_refs and fmt_refs:
+            error(self.lineno, ('pattern that uses fields defined in format '
+                                'cannot use format that uses fields defined '
+                                'in pattern'))
+        if fmt_refs:
+            # pattern fields first
+            self.output_fields(ind, lambda n: 'u.f_' + arg + '.' + n)
+            assert not extracted, "dangling fmt refs but it was already extracted"
         if not extracted:
             output(ind, self.base.extract_name(),
                    '(ctx, &u.f_', arg, ', insn);\n')
-        self.output_fields(ind, lambda n: 'u.f_' + arg + '.' + n)
+        if not fmt_refs:
+            # pattern fields last
+            self.output_fields(ind, lambda n: 'u.f_' + arg + '.' + n)
+
         output(ind, 'if (', translate_prefix, '_', self.name,
                '(ctx, &u.f_', arg, ')) return true;\n')
 
@@ -614,8 +725,10 @@ def output_code(self, i, extracted, outerbits, outermask):
         ind = str_indent(i)
 
         # If we identified all nodes below have the same format,
-        # extract the fields now.
-        if not extracted and self.base:
+        # extract the fields now. But don't do it if the format relies
+        # on named fields from the insn pattern, as those won't have
+        # been initialised at this point.
+        if not extracted and self.base and not self.base.dangling_references():
             output(ind, self.base.extract_name(),
                    '(ctx, &u.f_', self.base.base.name, ', insn);\n')
             extracted = True
@@ -737,6 +850,7 @@ def parse_field(lineno, name, toks):
     """Parse one instruction field from TOKS at LINENO"""
     global fields
     global insnwidth
+    global re_C_ident
 
     # A "simple" field will have only one entry;
     # a "multifield" will have several.
@@ -751,6 +865,25 @@ def parse_field(lineno, name, toks):
             func = func[1]
             continue
 
+        if re.fullmatch(re_C_ident + ':s[0-9]+', t):
+            # Signed named field
+            subtoks = t.split(':')
+            n = subtoks[0]
+            le = int(subtoks[1])
+            f = NamedField(n, True, le)
+            subs.append(f)
+            width += le
+            continue
+        if re.fullmatch(re_C_ident + ':[0-9]+', t):
+            # Unsigned named field
+            subtoks = t.split(':')
+            n = subtoks[0]
+            le = int(subtoks[1])
+            f = NamedField(n, False, le)
+            subs.append(f)
+            width += le
+            continue
+
         if re.fullmatch('[0-9]+:s[0-9]+', t):
             # Signed field extract
             subtoks = t.split(':s')
-- 
2.34.1


