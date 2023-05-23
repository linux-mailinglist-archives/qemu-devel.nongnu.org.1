Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 499D470DBF3
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 14:06:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Ql6-0002QN-NU; Tue, 23 May 2023 08:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q1Ql5-0002Pe-FJ
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:04:55 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q1Ql3-0008R6-Hm
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:04:55 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f50020e0f8so32223425e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 05:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684843492; x=1687435492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gB3R2llxQU+c9Ja3BYRkfIk0uQTzezpbeFI9jfQINrc=;
 b=ESU/2A9Ff+jkff+xg9bmhoN5ahH5bp4o+8/fWF0xfLA17HhbVqKBRdeOx0GWFLsufP
 4cHhC64Yild5ED5L0M12Ubv3hYyIl2ZiMRgPOM30seJkWCVV6lHP5FY3T45A3+ii/QiW
 9ijVZYVtdxM/8xi3N77oEPf0qg1Ic8+aAxDqqywpMTKzm4CyirokL6cXfcOb6dZOm37r
 9OsI84xQMEGX28gX2cOTQF+DULhCCkzhvl/XvhpYUVcQpK0Z+oppqZRNiAQFNG1ckOPM
 yaQf6K1/lnyyj8we8QFGyO2lkSlwHux/KFZNa9XpgdkdisyQJA2CrRw70mEvRhrKVFRf
 Kl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684843492; x=1687435492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gB3R2llxQU+c9Ja3BYRkfIk0uQTzezpbeFI9jfQINrc=;
 b=ampIbd1OZEBQ2+mKe/rotjBukJ1PimgrFHOCmpT9MemOZZpqjInkflRGoPmwSM5vnd
 rczbI4UHandSR1ZRNmEknHJtDl6awst+pOQkDWnIdycvzVyO6iNZkas8+v6uKMiSRxUU
 KdwD4vtD0epa1fFEICw9faOU3Tu4t7HRYTPMdI2Em5/36ittOUJzdzDxRNwOqTdXzBT0
 9K5u+HI397wkBDr6f+HhYwq89nEJECpWs/QjKMRvbB0ZW0gF5OJ/vPnIJcsewZasxvr7
 bQ350aJ1JkjQAs70S6+z2Hezcb0yqzMRIflL56TL/JrbcTrwfvN7T4i2WpaY6JQBBIkS
 Tm1A==
X-Gm-Message-State: AC+VfDzkXge/KWZutVeLZYcgC8mlCYlEAy7JJC0gZXRwy9tlKS/LgEEf
 S+c4/6zTgO8K1Ps9hwey30HhLueQeZ1WKqW3RLM=
X-Google-Smtp-Source: ACHHUZ6q483OuQhJyTMeAZyP6w0GCop9AkevoABookHkYXsMQOFlS1M2Ei6/6oDE9qcT2wjKjAAO7A==
X-Received: by 2002:a05:600c:450c:b0:3f6:eb:20fc with SMTP id
 t12-20020a05600c450c00b003f600eb20fcmr6174873wmo.6.1684843492177; 
 Tue, 23 May 2023 05:04:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 l17-20020adfe591000000b003079c402762sm10848778wrm.19.2023.05.23.05.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 05:04:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 6/6] tests/decode: Add tests for various named-field cases
Date: Tue, 23 May 2023 13:04:47 +0100
Message-Id: <20230523120447.728365-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523120447.728365-1-peter.maydell@linaro.org>
References: <20230523120447.728365-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

Add some tests for various cases of named-field use, both ones that
should work and ones that should be diagnosed as errors.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/decode/err_field1.decode       |  2 +-
 tests/decode/err_field10.decode      |  7 +++++++
 tests/decode/err_field7.decode       |  7 +++++++
 tests/decode/err_field8.decode       |  8 ++++++++
 tests/decode/err_field9.decode       | 14 ++++++++++++++
 tests/decode/succ_named_field.decode | 19 +++++++++++++++++++
 6 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 tests/decode/err_field10.decode
 create mode 100644 tests/decode/err_field7.decode
 create mode 100644 tests/decode/err_field8.decode
 create mode 100644 tests/decode/err_field9.decode
 create mode 100644 tests/decode/succ_named_field.decode

diff --git a/tests/decode/err_field1.decode b/tests/decode/err_field1.decode
index e07a5a73e0e..85c3f326d07 100644
--- a/tests/decode/err_field1.decode
+++ b/tests/decode/err_field1.decode
@@ -2,4 +2,4 @@
 # See the COPYING.LIB file in the top-level directory.
 
 # Diagnose invalid field syntax
-%field	asdf
+%field	1asdf
diff --git a/tests/decode/err_field10.decode b/tests/decode/err_field10.decode
new file mode 100644
index 00000000000..3e672b7459e
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
index 00000000000..51fad7cceaf
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
index 00000000000..cc47c08a459
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
index 00000000000..e7361d521ba
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
index 00000000000..e64b3f93568
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
-- 
2.34.1


