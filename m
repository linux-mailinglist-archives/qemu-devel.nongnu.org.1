Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD8370DBF0
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 14:06:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Ql5-0002Pa-MB; Tue, 23 May 2023 08:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q1Ql4-0002On-BZ
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:04:54 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q1Ql2-0008QY-1o
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:04:54 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f41dceb93bso47512135e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 05:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684843490; x=1687435490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xbN6BYbhg9Tc9GAYch8/jujIr0chTMGn9JipZlla0d0=;
 b=Qx3qIYWEErLGhZBj/GkloiSqv8yDf7Zclo7kTGmeddsHnwWysd9SDHZaK+ZJdqTR41
 Mm42oDfMglQjrhgZXSDbuOuXg+uE27H01cUjS1OfQRdG5Ts9h6TtqBiGnFIqgiGLYY2d
 35GmLoiJFT5WY46+y9T04mp59z0LBjup6jjOv8/JwE0ORe7PU6rYkb3pWtJ8d0kLpcvA
 FLvuryf2oUAagNpVIHcDakPf5qRvgRJrdzQHjhupCRM+N0dz7xt9BQoSVd40yl/eIY4v
 k/9Y1+IDC3U0d+JO/Kx6kXUdtmaDCS1JNR7yZLvq8Y+9OlcvATIxbMfhaj2NAi3O0maQ
 sc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684843490; x=1687435490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xbN6BYbhg9Tc9GAYch8/jujIr0chTMGn9JipZlla0d0=;
 b=l7iJfzhUuvzqiHkuG7K5QVolU5fnd2GDh7mdIY4JwIG4X5+vt+ylRYOKtYuaqj26HT
 kUQsiUDTYYrfv3KQ7wsNA60LqWJw9JWnDdXRG8jIg2Qrtu2Utr/d6+rGOFgKTouOdkfV
 8Wg7nbTL+TJ6vsYyYz9+WMEDrBkv2ZZp7toTFccXL7Ii4DgdwhDPsUWW8xYznD3hlyug
 tUivRpIiwur9SX+efZiaDAkgoWeJz73qfF3cqVHccF2kGt4XzBZSS0gKA8rEipjASNMP
 MGw8Vce65o/VOFUNB54Q8XnXPU3LUpeiEKW7Ml/ArznJfu6UXETHg+8QjiFnITJZ0T7D
 M1Uw==
X-Gm-Message-State: AC+VfDxPlSMcMa6nycRMZAejfpRZfY/wfRm4oZVSDnixWLaLDZ9fFWUM
 nImvgdCCcY1n6Bz+wSO0mlcKsXV4JCSTLgZFvo0=
X-Google-Smtp-Source: ACHHUZ4+MOTjQgpghsERQnZtYPmfoUFU2xP6yyUy8Frp0fO0BeLRGCRDlFPcmiQAKCzXid9fby4W0A==
X-Received: by 2002:a1c:6a09:0:b0:3f6:1e6:d5a2 with SMTP id
 f9-20020a1c6a09000000b003f601e6d5a2mr5789238wmc.4.1684843490616; 
 Tue, 23 May 2023 05:04:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 l17-20020adfe591000000b003079c402762sm10848778wrm.19.2023.05.23.05.04.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 05:04:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 3/6] scripts/decodetree: Pass lvalue-formatter function to
 str_extract()
Date: Tue, 23 May 2023 13:04:44 +0100
Message-Id: <20230523120447.728365-4-peter.maydell@linaro.org>
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

To support referring to other named fields in field definitions, we
need to pass the str_extract() method a function which tells it how
to emit the code for a previously initialized named field.  (In
Pattern::output_code() the other field will be "u.f_foo.field", and
in Format::output_extract() it is "a->field".)

Refactor the two callsites that currently do "output code to
initialize each field", and have them pass a lambda that defines how
to format the lvalue in each case.  This is then used both in
emitting the LHS of the assignment and also passed down to
str_extract() as a new argument (unused at the moment, but will be
used in the following patch).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/decodetree.py | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index a03dc6b5e3e..33f4252b4ee 100644
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -205,7 +205,7 @@ def __str__(self):
             s = ''
         return str(self.pos) + ':' + s + str(self.len)
 
-    def str_extract(self):
+    def str_extract(self, lvalue_formatter):
         global bitop_width
         s = 's' if self.sign else ''
         return f'{s}extract{bitop_width}(insn, {self.pos}, {self.len})'
@@ -228,12 +228,12 @@ def __init__(self, subs, mask):
     def __str__(self):
         return str(self.subs)
 
-    def str_extract(self):
+    def str_extract(self, lvalue_formatter):
         global bitop_width
         ret = '0'
         pos = 0
         for f in reversed(self.subs):
-            ext = f.str_extract()
+            ext = f.str_extract(lvalue_formatter)
             if pos == 0:
                 ret = ext
             else:
@@ -264,7 +264,7 @@ def __init__(self, value):
     def __str__(self):
         return str(self.value)
 
-    def str_extract(self):
+    def str_extract(self, lvalue_formatter):
         return str(self.value)
 
     def __cmp__(self, other):
@@ -283,8 +283,9 @@ def __init__(self, func, base):
     def __str__(self):
         return self.func + '(' + str(self.base) + ')'
 
-    def str_extract(self):
-        return self.func + '(ctx, ' + self.base.str_extract() + ')'
+    def str_extract(self, lvalue_formatter):
+        return (self.func + '(ctx, '
+                + self.base.str_extract(lvalue_formatter) + ')')
 
     def __eq__(self, other):
         return self.func == other.func and self.base == other.base
@@ -304,7 +305,7 @@ def __init__(self, func):
     def __str__(self):
         return self.func
 
-    def str_extract(self):
+    def str_extract(self, lvalue_formatter):
         return self.func + '(ctx)'
 
     def __eq__(self, other):
@@ -357,6 +358,11 @@ def __str__(self):
 
     def str1(self, i):
         return str_indent(i) + self.__str__()
+
+    def output_fields(self, indent, lvalue_formatter):
+        for n, f in self.fields.items():
+            output(indent, lvalue_formatter(n), ' = ',
+                   f.str_extract(lvalue_formatter), ';\n')
 # end General
 
 
@@ -370,8 +376,7 @@ def extract_name(self):
     def output_extract(self):
         output('static void ', self.extract_name(), '(DisasContext *ctx, ',
                self.base.struct_name(), ' *a, ', insntype, ' insn)\n{\n')
-        for n, f in self.fields.items():
-            output('    a->', n, ' = ', f.str_extract(), ';\n')
+        self.output_fields(str_indent(4), lambda n: 'a->' + n)
         output('}\n\n')
 # end Format
 
@@ -395,8 +400,7 @@ def output_code(self, i, extracted, outerbits, outermask):
         if not extracted:
             output(ind, self.base.extract_name(),
                    '(ctx, &u.f_', arg, ', insn);\n')
-        for n, f in self.fields.items():
-            output(ind, 'u.f_', arg, '.', n, ' = ', f.str_extract(), ';\n')
+        self.output_fields(ind, lambda n: 'u.f_' + arg + '.' + n)
         output(ind, 'if (', translate_prefix, '_', self.name,
                '(ctx, &u.f_', arg, ')) return true;\n')
 
-- 
2.34.1


