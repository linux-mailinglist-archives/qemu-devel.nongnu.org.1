Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95833716D17
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:05:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44aP-00013J-H0; Tue, 30 May 2023 15:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44Zr-0000t9-L6
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:00:16 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44Zp-00019t-KA
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:00:15 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-256931ec244so1868028a91.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685473212; x=1688065212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HBGAS5XdEwro+M6k2K5XROrSVcXoal4ICsVpLYB3WDc=;
 b=QWgvWtEa8JXZEx5gPyTloa5hk9NHHmDHtMoBy2W4vYIE6r2YTk8OV7wJ04CSrrOD6k
 KJ475UhSL62zqmfG6HrERISpdJ7anog9zgiMELMjn++fkf2kNj/keYoeUiss4suunQr5
 sDKhxDmBelVRC+bvOmtwE+64rg4kv3Rt0i/rmyjpF1VxAlVOvb0Xekj4QWXU/Qjvmhy2
 zWeKg/kCXt6vTwLJX+jbMAn5L6t7QxBGKQvQ0CC00VN1M99LCGluRMI453DsHHM43ORe
 wOmPT/DGrg+S0lhwSGulEq48rxtJH55+L/jbAx+ynFFcnfz2pNYt+N1Hjc9MfnHlfrKf
 aRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685473212; x=1688065212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HBGAS5XdEwro+M6k2K5XROrSVcXoal4ICsVpLYB3WDc=;
 b=EuaEp2BIJU9K2AmOmOX8dJsZEcQ1kZzEzlU+S++OO0bkXi1+ZTegD47mCMiX/TzJuZ
 QCDGHdX5FF8McJ2GGHLKBrpl3/+tJspDYjLhI+e+qqO6GD/HVjXLuEJbPJ0K1h6/ImHj
 AboD7DKEfEx6EbN9+VlQ3Uj169kCGFlDXHTXe29vDcR4AunNCrTVacTEjgepfkIgQIUH
 FbXPkK0duaM7V1c0UEtXWFcWCfjZsCT6s5BLIWnUPc4DBVvmFTY7ZxGEcZzaJ3BXO9/e
 A5bWUC44mwSWiKcB48xTb8Tr2xxWIcqDKlCldUu5HUebDnqjGeScCxDbCVaKIumaWi/p
 xQ6A==
X-Gm-Message-State: AC+VfDyYcCyO/I435dfNcxplh1hTz1a/UTrWYk+7oC3dBD76oGB+kn9b
 ccOf2lx8Obg9/jbN3m/yysU7yp3evdPhCUkylAU=
X-Google-Smtp-Source: ACHHUZ4crKkddtm/lKvKSSk/h+sVK+Wd+h3HDeL/coc5pKZtp7OJG8rMCtyvIJmhRiEEe/hAyEFzIQ==
X-Received: by 2002:a17:90a:1a0b:b0:258:6d28:cd02 with SMTP id
 11-20020a17090a1a0b00b002586d28cd02mr67586pjk.49.1685473212135; 
 Tue, 30 May 2023 12:00:12 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a63fa52000000b0051f14839bf3sm9128496pgk.34.2023.05.30.12.00.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:00:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 24/27] scripts/decodetree: Pass lvalue-formatter function to
 str_extract()
Date: Tue, 30 May 2023 11:59:46 -0700
Message-Id: <20230530185949.410208-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530185949.410208-1-richard.henderson@linaro.org>
References: <20230530185949.410208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230523120447.728365-4-peter.maydell@linaro.org>
---
 scripts/decodetree.py | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index a9a0cd0fa3..73d569c128 100644
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -211,7 +211,7 @@ def __str__(self):
             s = ''
         return str(self.pos) + ':' + s + str(self.len)
 
-    def str_extract(self):
+    def str_extract(self, lvalue_formatter):
         global bitop_width
         s = 's' if self.sign else ''
         return f'{s}extract{bitop_width}(insn, {self.pos}, {self.len})'
@@ -234,12 +234,12 @@ def __init__(self, subs, mask):
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
@@ -270,7 +270,7 @@ def __init__(self, value):
     def __str__(self):
         return str(self.value)
 
-    def str_extract(self):
+    def str_extract(self, lvalue_formatter):
         return str(self.value)
 
     def __cmp__(self, other):
@@ -289,8 +289,9 @@ def __init__(self, func, base):
     def __str__(self):
         return self.func + '(' + str(self.base) + ')'
 
-    def str_extract(self):
-        return self.func + '(ctx, ' + self.base.str_extract() + ')'
+    def str_extract(self, lvalue_formatter):
+        return (self.func + '(ctx, '
+                + self.base.str_extract(lvalue_formatter) + ')')
 
     def __eq__(self, other):
         return self.func == other.func and self.base == other.base
@@ -310,7 +311,7 @@ def __init__(self, func):
     def __str__(self):
         return self.func
 
-    def str_extract(self):
+    def str_extract(self, lvalue_formatter):
         return self.func + '(ctx)'
 
     def __eq__(self, other):
@@ -363,6 +364,11 @@ def __str__(self):
 
     def str1(self, i):
         return str_indent(i) + self.__str__()
+
+    def output_fields(self, indent, lvalue_formatter):
+        for n, f in self.fields.items():
+            output(indent, lvalue_formatter(n), ' = ',
+                   f.str_extract(lvalue_formatter), ';\n')
 # end General
 
 
@@ -376,8 +382,7 @@ def extract_name(self):
     def output_extract(self):
         output('static void ', self.extract_name(), '(DisasContext *ctx, ',
                self.base.struct_name(), ' *a, ', insntype, ' insn)\n{\n')
-        for n, f in self.fields.items():
-            output('    a->', n, ' = ', f.str_extract(), ';\n')
+        self.output_fields(str_indent(4), lambda n: 'a->' + n)
         output('}\n\n')
 # end Format
 
@@ -401,8 +406,7 @@ def output_code(self, i, extracted, outerbits, outermask):
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


