Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCE3826BA3
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 11:37:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMn0C-0002Ac-G9; Mon, 08 Jan 2024 05:37:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rMn0A-0002A0-AS
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 05:37:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rMn08-0006OM-Gq
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 05:37:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704710219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R6kagi1UsyjtkoK22XW9IinQ7z9GXrHkWOuOWlCqdHI=;
 b=bS214NRrUN8gG8rCzqStDzSZOzcQENypDisZu3wi5dGpI5H6EuPAY4VnR2OR19Hw/nhwnp
 tPblQOa1TmDF3U1TYY66BMLdXHtXWI7uo8s5B+zpvo0w82q6vox0nBJlAQp83oicp4MWNB
 yvOlE70xEYcRLu52YTeRFeb9Wmmpezc=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-P3NJHcAfPIiykmJcZwmCmA-1; Mon, 08 Jan 2024 05:36:58 -0500
X-MC-Unique: P3NJHcAfPIiykmJcZwmCmA-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1d3fa1ff824so4121285ad.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 02:36:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704710216; x=1705315016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R6kagi1UsyjtkoK22XW9IinQ7z9GXrHkWOuOWlCqdHI=;
 b=NUPwW80+mOCmAM3i/AMFfHO0AunQRzQwj81Y3XX0fTVANwX+7SjeucDqaYF/ZgNpz9
 EeB8tLP4QWAel6HAVqnFQWU+nV8vammwC+CToPlx/fUbmp9O8WS6JCJ6ulG889IaiclO
 si+n+vfRd3tan1SCX27S//WcRx9SbKSu9kNqXsOoi7dmDx/gDBsDTHoN8xkQ17zoccmh
 /dDz5nIqI6B1TBTYWkmTYcRFjE9Hb8zzCucZfKSgwVHS8iAEwsk3s1QHUFWNSdBVhcaH
 YkjG9WnbljQGxWANy/WEkTf4YK0kDFb21RLW8cYG3NloPNcPOEnVcmLI7VbN0EmpeoN+
 tYEQ==
X-Gm-Message-State: AOJu0YzYRjT1wA9+LqL858/OT+A07Ct2wxE+IT+dEBKTWJTikBnNC2Fs
 xnlQgSQlublGsx9J2J/F0Gwk95bbXPin/Mh7KDWO2/yfGOukicIWMst7iyQp3A00995ghzL9uit
 UYeEYfPZVl28ylsl8ZsdftvRmQmorEIdn82x4
X-Received: by 2002:a17:902:e748:b0:1d4:c306:d8a8 with SMTP id
 p8-20020a170902e74800b001d4c306d8a8mr1186339plf.106.1704710215961; 
 Mon, 08 Jan 2024 02:36:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3lUzPWdEPhRJ7cxsgYwEqVEPCn4/rdyuw5ScIV58TjK04FceMXjMr7SMQKr+D8bhkY1wFIA==
X-Received: by 2002:a17:902:e748:b0:1d4:c306:d8a8 with SMTP id
 p8-20020a170902e74800b001d4c306d8a8mr1186336plf.106.1704710215693; 
 Mon, 08 Jan 2024 02:36:55 -0800 (PST)
Received: from localhost.localdomain ([116.73.134.99])
 by smtp.googlemail.com with ESMTPSA id
 u11-20020a17090282cb00b001d3563c87a6sm5899502plz.281.2024.01.08.02.36.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 02:36:55 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, peter.maydell@linaro.org, mst@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH 1/2] acpi/tests/avocado/bits: import smilatency test from bits
 in order to disable it
Date: Mon,  8 Jan 2024 16:06:42 +0530
Message-ID: <20240108103643.4434-2-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240108103643.4434-1-anisinha@redhat.com>
References: <20240108103643.4434-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.098,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Add smilatency test script in the bits avocado tests from bios-bits. No changes
have been made to the original test script. The test will be disabled in the
subsequent patch.

CC: peter.maydell@linaro.org
CC: crosa@redhat.com
CC: philmd@linaro.org
CC: bleal@redhat.com
CC: mst@redhat.com
CC: wainersm@redhat.com
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 .../acpi-bits/bits-tests/smilatency.py2       | 106 ++++++++++++++++++
 1 file changed, 106 insertions(+)
 create mode 100644 tests/avocado/acpi-bits/bits-tests/smilatency.py2

diff --git a/tests/avocado/acpi-bits/bits-tests/smilatency.py2 b/tests/avocado/acpi-bits/bits-tests/smilatency.py2
new file mode 100644
index 0000000000..48083bfb0d
--- /dev/null
+++ b/tests/avocado/acpi-bits/bits-tests/smilatency.py2
@@ -0,0 +1,106 @@
+# Copyright (c) 2015, Intel Corporation
+# All rights reserved.
+#
+# SPDX-License-Identifier: BSD-3-Clause
+
+# Redistribution and use in source and binary forms, with or without
+# modification, are permitted provided that the following conditions are met:
+#
+#     * Redistributions of source code must retain the above copyright notice,
+#       this list of conditions and the following disclaimer.
+#     * Redistributions in binary form must reproduce the above copyright notice,
+#       this list of conditions and the following disclaimer in the documentation
+#       and/or other materials provided with the distribution.
+#     * Neither the name of Intel Corporation nor the names of its contributors
+#       may be used to endorse or promote products derived from this software
+#       without specific prior written permission.
+#
+# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
+# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
+# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+# ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+
+# This script runs only from the biosbits VM.
+
+"""SMI latency test."""
+
+import bits
+from collections import namedtuple
+import testsuite
+import time
+import usb
+
+def register_tests():
+    testsuite.add_test("SMI latency test", smi_latency);
+    testsuite.add_test("SMI latency test with USB disabled via BIOS handoff", test_with_usb_disabled, runall=False);
+
+def smi_latency():
+    MSR_SMI_COUNT = 0x34
+
+    print "Warning: touching the keyboard can affect the results of this test."
+
+    tsc_per_sec = bits.tsc_per_sec()
+    tsc_per_usec = tsc_per_sec / (1000 * 1000)
+    bins = [long(tsc_per_usec * 10**i) for i in range(9)]
+    bin_descs = [
+        "0     < t <=   1us",
+        "1us   < t <=  10us",
+        "10us  < t <= 100us",
+        "100us < t <=   1ms",
+        "1ms   < t <=  10ms",
+        "10ms  < t <= 100ms",
+        "100ms < t <=   1s ",
+        "1s    < t <=  10s ",
+        "10s   < t <= 100s ",
+        "100s  < t         ",
+    ]
+
+    print "Starting test. Wait here, I will be back in 15 seconds."
+    (max_latency, smi_count_delta, bins) = bits.smi_latency(long(15 * tsc_per_sec), bins)
+    BinType = namedtuple('BinType', ("max", "total", "count", "times"))
+    bins = [BinType(*b) for b in bins]
+
+    testsuite.test("SMI latency < 150us to minimize risk of OS timeouts", max_latency / tsc_per_usec <= 150)
+    if not testsuite.show_detail():
+        return
+
+    for bin, desc in zip(bins, bin_descs):
+        if bin.count == 0:
+            continue
+        testsuite.print_detail("{}; average = {}; count = {}".format(desc, bits.format_tsc(bin.total/bin.count), bin.count))
+        deltas = (bits.format_tsc(t2 - t1) for t1,t2 in zip(bin.times, bin.times[1:]))
+        testsuite.print_detail(" Times between first few observations: {}".format(" ".join("{:>6}".format(delta) for delta in deltas)))
+
+    if smi_count_delta is not None:
+        testsuite.print_detail("{} SMI detected using MSR_SMI_COUNT (MSR {:#x})".format(smi_count_delta, MSR_SMI_COUNT))
+
+    testsuite.print_detail("Summary of impact: observed maximum latency = {}".format(bits.format_tsc(max_latency)))
+
+def test_with_usb_disabled():
+    if usb.handoff_to_os():
+        smi_latency()
+
+def average_io_smi(port, value, count):
+    def f():
+        tsc_start = bits.rdtsc()
+        bits.outb(port, value)
+        return bits.rdtsc() - tsc_start
+    counts = [f() for i in range(count)]
+    return sum(counts)/len(counts)
+
+def time_io_smi(port=0xb2, value=0, count=1000):
+    count_for_estimate = 10
+    start = time.time()
+    average_io_smi(port, value, count_for_estimate)
+    avg10 = time.time() - start
+    estimate = avg10 * count/count_for_estimate
+    if estimate > 1:
+        print "Running test, estimated time: {}s".format(int(estimate))
+    average = average_io_smi(port, value, count)
+    print "Average of {} SMIs (via outb, port={:#x}, value={:#x}): {}".format(count, port, value, bits.format_tsc(average))
-- 
2.42.0


