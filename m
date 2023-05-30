Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E749716D0B
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:03:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44aP-00013K-Ey; Tue, 30 May 2023 15:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44Zu-0000uF-Pq
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:00:18 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44Zs-0000sb-QW
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:00:18 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-64fd7723836so2037979b3a.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685473214; x=1688065214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mpuLQvPVxoSrCp/Ta2mdl/Aq9ROqTlZL3minDuEWys8=;
 b=UkGjlJZDCQAacmofgnkrm8SCQ7iCfo0nfQqSrl+yiFIgiHK0g1ahz0NSe438PCoxeh
 ZWsMH0FHbA1YNACW3FyXmoROmsOYpccTnopfwWz62N3/wS6+ZoZfHwgeWPMuAoJLi9Dl
 NTTE+FNf0NgojzC7qQe4Od2NCh6A8M5bO7XlbAobrWlzed/r8IEph2hKpE9RKE/EqieE
 okgomLoOEphbJzEgHtG15rYpzbeNg7KH2g1SdiR5TxtMOeeA91ADoGa4DDQ5lpVRd7QC
 oAhlJM+7x42EP+iqmN5sKV/w1YtY4lMEl9Wu6zMQyAPNzGVfTCAU11Qb0CWgZNa2lRI1
 0A6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685473214; x=1688065214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mpuLQvPVxoSrCp/Ta2mdl/Aq9ROqTlZL3minDuEWys8=;
 b=EIkkK8NuSyd5/Ng5d0egi2PsesDptLQdybieE4WgsTPuY3hVGMlAcXLkyQtLjEWc3Z
 tuqWNQg9q/D5yh25vOLUyMGUeQgoGcPuWpVqtxLhTCbQnhpTw4kHeUv5jOTpKsNnWHzK
 zGKT/zKOQIBX4qNvA/3vdhCGs9RJd0KIocC9sHeE97tlAp6iHVZNSnQrfWjuzD1i9gU6
 encqfC6HoxaS9ixgoR44aqRI8z/kuXReOlxQqq2Vi/U7k4KeJYrkX9KsMV0qZoJsKuxS
 79N/bVPjAKY5B9eY2RtXRu4cU5ZBsn1mpBTDUspDVztomjdbdDzGdWxNFFj5ADXCjPPk
 thmQ==
X-Gm-Message-State: AC+VfDyhfXUF2cRH3kCHmbt3w0vLlDU9LYTPWHEtjypcpSQj9M1Z7ror
 z0K2KuuITFi+0+b50f4WK4HV2kqe9JabUXtUNsk=
X-Google-Smtp-Source: ACHHUZ7xbh/Z2lam1U2MSWNDplLpFgv4UCHv0N4NwA+Tb6GQiE7PDbO8F14A8FTte3bTD3L3i4S8Aw==
X-Received: by 2002:a05:6a20:9c8f:b0:110:9210:f6af with SMTP id
 mj15-20020a056a209c8f00b001109210f6afmr3303734pzb.27.1685473214574; 
 Tue, 30 May 2023 12:00:14 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a63fa52000000b0051f14839bf3sm9128496pgk.34.2023.05.30.12.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:00:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 27/27] tests/decode: Add tests for various named-field cases
Date: Tue, 30 May 2023 11:59:49 -0700
Message-Id: <20230530185949.410208-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530185949.410208-1-richard.henderson@linaro.org>
References: <20230530185949.410208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Add some tests for various cases of named-field use, both ones that
should work and ones that should be diagnosed as errors.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230523120447.728365-7-peter.maydell@linaro.org>
---
 tests/decode/err_field10.decode      |  7 +++++++
 tests/decode/err_field7.decode       |  7 +++++++
 tests/decode/err_field8.decode       |  8 ++++++++
 tests/decode/err_field9.decode       | 14 ++++++++++++++
 tests/decode/succ_named_field.decode | 19 +++++++++++++++++++
 tests/decode/meson.build             |  5 +++++
 6 files changed, 60 insertions(+)
 create mode 100644 tests/decode/err_field10.decode
 create mode 100644 tests/decode/err_field7.decode
 create mode 100644 tests/decode/err_field8.decode
 create mode 100644 tests/decode/err_field9.decode
 create mode 100644 tests/decode/succ_named_field.decode

diff --git a/tests/decode/err_field10.decode b/tests/decode/err_field10.decode
new file mode 100644
index 0000000000..3e672b7459
--- /dev/null
+++ b/tests/decode/err_field10.decode
@@ -0,0 +1,7 @@
+# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# See the COPYING.LIB file in the top-level directory.
+
+# Diagnose formats which refer to undefined fields
+%field1        field2:3
+@fmt ........ ........ ........ ........ %field1
+insn 00000000 00000000 00000000 00000000 @fmt
diff --git a/tests/decode/err_field7.decode b/tests/decode/err_field7.decode
new file mode 100644
index 0000000000..51fad7ccea
--- /dev/null
+++ b/tests/decode/err_field7.decode
@@ -0,0 +1,7 @@
+# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# See the COPYING.LIB file in the top-level directory.
+
+# Diagnose fields whose definitions form a loop
+%field1        field2:3
+%field2        field1:4
+insn 00000000 00000000 00000000 00000000 %field1 %field2
diff --git a/tests/decode/err_field8.decode b/tests/decode/err_field8.decode
new file mode 100644
index 0000000000..cc47c08a45
--- /dev/null
+++ b/tests/decode/err_field8.decode
@@ -0,0 +1,8 @@
+# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# See the COPYING.LIB file in the top-level directory.
+
+# Diagnose patterns which refer to undefined fields
+&f1 f1 a
+%field1        field2:3
+@fmt ........ ........ ........ .... a:4 &f1
+insn 00000000 00000000 00000000 0000 .... @fmt f1=%field1
diff --git a/tests/decode/err_field9.decode b/tests/decode/err_field9.decode
new file mode 100644
index 0000000000..e7361d521b
--- /dev/null
+++ b/tests/decode/err_field9.decode
@@ -0,0 +1,14 @@
+# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# See the COPYING.LIB file in the top-level directory.
+
+# Diagnose fields where the format refers to a field defined in the
+# pattern and the pattern refers to a field defined in the format.
+# This is theoretically not impossible to implement, but is not
+# supported by the script at this time.
+&abcd a b c d
+%refa        a:3
+%refc        c:4
+# Format defines 'c' and sets 'b' to an indirect ref to 'a'
+@fmt ........ ........ ........ c:8 &abcd b=%refa
+# Pattern defines 'a' and sets 'd' to an indirect ref to 'c'
+insn 00000000 00000000 00000000 ........ @fmt d=%refc a=6
diff --git a/tests/decode/succ_named_field.decode b/tests/decode/succ_named_field.decode
new file mode 100644
index 0000000000..e64b3f9356
--- /dev/null
+++ b/tests/decode/succ_named_field.decode
@@ -0,0 +1,19 @@
+# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# See the COPYING.LIB file in the top-level directory.
+
+# field using a named_field
+%imm_sz	8:8 sz:3
+insn 00000000 00000000 ........ 00000000 imm_sz=%imm_sz sz=1
+
+# Ditto, via a format. Here a field in the format
+# references a named field defined in the insn pattern:
+&imm_a imm alpha
+%foo 0:16 alpha:4
+@foo 00000001 ........ ........ ........ &imm_a imm=%foo
+i1   ........ 00000000 ........ ........ @foo alpha=1
+i2   ........ 00000001 ........ ........ @foo alpha=2
+
+# Here the named field is defined in the format and referenced
+# from the insn pattern:
+@bar 00000010 ........ ........ ........ &imm_a alpha=4
+i3   ........ 00000000 ........ ........ @bar imm=%foo
diff --git a/tests/decode/meson.build b/tests/decode/meson.build
index b4850562f9..38a0629d67 100644
--- a/tests/decode/meson.build
+++ b/tests/decode/meson.build
@@ -7,6 +7,10 @@ err_tests = [
     'err_field4.decode',
     'err_field5.decode',
     'err_field6.decode',
+    'err_field7.decode',
+    'err_field8.decode',
+    'err_field9.decode',
+    'err_field10.decode',
     'err_init1.decode',
     'err_init2.decode',
     'err_init3.decode',
@@ -37,6 +41,7 @@ succ_tests = [
     'succ_argset_type1.decode',
     'succ_function.decode',
     'succ_ident1.decode',
+    'succ_named_field.decode',
     'succ_pattern_group_nest1.decode',
     'succ_pattern_group_nest2.decode',
     'succ_pattern_group_nest3.decode',
-- 
2.34.1


