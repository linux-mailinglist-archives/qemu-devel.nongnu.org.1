Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32979716D23
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:06:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44aV-000173-8j; Tue, 30 May 2023 15:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44Zv-0000ug-8h
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:00:19 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44Zs-0001AV-QN
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:00:18 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-256931ec244so1868181a91.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685473214; x=1688065214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XAytWt2TseNM2Bn38JveeWKlHZTCU8XRMXbluB99Lc0=;
 b=Nyz5Y82zoDvtPO+z0tjCQUBQ9PWm9kAodpe668kEL/FLNUUa8agMqKWmFoiDWVI0qt
 7+zsK4AECgHGyRR3fzmJdxczbEeXMvz+eqPnFkCSCaTrIN87nR2y4LadUBPJwX59ix9E
 nOrDZJYOeNvlXgGxmS24oDRvn9VLDdQgv0nE3yX19Ow3l1tmXQcJiDxPHMyyZFYXPjHb
 6VWLIq/g/+aXUDJ0M9R9U5eRJw+HfuxYtha11DoaILXMKp/C1KRlEEwZGaUorqnm7Zc7
 ZCDxC8ER/AcnUMRLdOVQvpKgK633fyUIF7VHZfKt6W5y1NsKFFuJqCfy9XxjU89XD/SY
 BbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685473214; x=1688065214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XAytWt2TseNM2Bn38JveeWKlHZTCU8XRMXbluB99Lc0=;
 b=YSU4SRY8otx923fFvYHv+DRkTD5TmHQ7pXUVpqM+tpB/0szRusj5e7DJuS9j5knMhK
 G0v+GyYL4nmMk9huRLolNLalld/0li1FCbu8pIawG3AnnVQAmzA/q4AZ8lpF/ul7W5Dn
 q18BF+KE7jPy1z+MdkTkTdk08CQkJs/hL50pfkc9fzfQj5p6TLumPvhHBZmK4EPJKyWH
 WPt9LaVfPGKYPU5TJ2ehJoaafv+DbATRUIeTPmh7kjBFIHalqp90/UQROHTMI3e0B+FL
 +W3l6lFRkR6X5Aoa4KUHv9kn4ED4i1e1JA1YvolEk/gp3sWbFbWrNFyAv5uocoJwJZ29
 bV7Q==
X-Gm-Message-State: AC+VfDyoogGvJ3cG3iWQA88XfU+C0QU+LcfuYurbGiFVfKxlPik0qX9F
 uhO1NhHiJvDUIk9XNnBSNhrEFHcEIIX8LRGJ1dQ=
X-Google-Smtp-Source: ACHHUZ498WX9JIXaC8p/C9d72BiTOZ7YY+f21YrwC07gOTwxF4FbEXrNQwmKS+oD/eGoqWD38gyOlA==
X-Received: by 2002:a17:90a:a392:b0:256:257e:cba9 with SMTP id
 x18-20020a17090aa39200b00256257ecba9mr3264812pjp.13.1685473213806; 
 Tue, 30 May 2023 12:00:13 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a63fa52000000b0051f14839bf3sm9128496pgk.34.2023.05.30.12.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:00:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 26/27] scripts/decodetree: Implement named field support
Date: Tue, 30 May 2023 11:59:48 -0700
Message-Id: <20230530185949.410208-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530185949.410208-1-richard.henderson@linaro.org>
References: <20230530185949.410208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230523120447.728365-6-peter.maydell@linaro.org>
---
 scripts/decodetree.py | 145 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 139 insertions(+), 6 deletions(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index db019a25c6..13db585d04 100644
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -290,6 +290,9 @@ def str_extract(self, lvalue_formatter):
         s = 's' if self.sign else ''
         return f'{s}extract{bitop_width}(insn, {self.pos}, {self.len})'
 
+    def referenced_fields(self):
+        return []
+
     def __eq__(self, other):
         return self.sign == other.sign and self.mask == other.mask
 
@@ -321,6 +324,12 @@ def str_extract(self, lvalue_formatter):
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
@@ -347,6 +356,9 @@ def __str__(self):
     def str_extract(self, lvalue_formatter):
         return str(self.value)
 
+    def referenced_fields(self):
+        return []
+
     def __cmp__(self, other):
         return self.value - other.value
 # end ConstField
@@ -367,6 +379,9 @@ def str_extract(self, lvalue_formatter):
         return (self.func + '(ctx, '
                 + self.base.str_extract(lvalue_formatter) + ')')
 
+    def referenced_fields(self):
+        return self.base.referenced_fields()
+
     def __eq__(self, other):
         return self.func == other.func and self.base == other.base
 
@@ -388,6 +403,9 @@ def __str__(self):
     def str_extract(self, lvalue_formatter):
         return self.func + '(ctx)'
 
+    def referenced_fields(self):
+        return []
+
     def __eq__(self, other):
         return self.func == other.func
 
@@ -395,6 +413,32 @@ def __ne__(self, other):
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
@@ -418,7 +462,6 @@ def output_def(self):
             output('} ', self.struct_name(), ';\n\n')
 # end Arguments
 
-
 class General:
     """Common code between instruction formats and instruction patterns"""
     def __init__(self, name, lineno, base, fixb, fixm, udfm, fldm, flds, w):
@@ -432,6 +475,7 @@ def __init__(self, name, lineno, base, fixb, fixm, udfm, fldm, flds, w):
         self.fieldmask = fldm
         self.fields = flds
         self.width = w
+        self.dangling = None
 
     def __str__(self):
         return self.name + ' ' + str_match_bits(self.fixedbits, self.fixedmask)
@@ -439,10 +483,51 @@ def __str__(self):
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
 
 
@@ -477,10 +562,36 @@ def output_code(self, i, extracted, outerbits, outermask):
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
 
@@ -626,8 +737,10 @@ def output_code(self, i, extracted, outerbits, outermask):
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
@@ -749,6 +862,7 @@ def parse_field(lineno, name, toks):
     """Parse one instruction field from TOKS at LINENO"""
     global fields
     global insnwidth
+    global re_C_ident
 
     # A "simple" field will have only one entry;
     # a "multifield" will have several.
@@ -763,6 +877,25 @@ def parse_field(lineno, name, toks):
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


