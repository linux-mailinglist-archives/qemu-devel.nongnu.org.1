Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8637A47A6
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 12:55:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiBty-00053n-HL; Mon, 18 Sep 2023 06:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dxu@dxuuu.xyz>) id 1qiBtv-00052v-SC
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:54:47 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dxu@dxuuu.xyz>) id 1qiBtu-0000Hb-5e
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:54:47 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 8BA3B3200927;
 Mon, 18 Sep 2023 06:54:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Mon, 18 Sep 2023 06:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
 :cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm1; t=1695034484; x=
 1695120884; bh=/ReuUamhZrjRKCw+iB41h+4VD72/iNv6vEVay7pP8Oc=; b=W
 HpCh6d3vddZEzMJUzlZ90U9MteEH/ZFGIlYfEuuF+H9/tw4/ryoM7onqRjKZ4Xy2
 cRnWd6Wn9693fRkkviGjTsxxt9xUtw3vwmeohG9+x23y8Y5EpHSj5MS7C/GoqJJ6
 qUOJh5dLAadn1JYWzhLUrHlngAB3dti+hSohmPCFRK+q4eAwWXDq4eXk5B+WdMT5
 b3JozW7PBwACfz5PblWGEhCQGFS5rtApcS8yoK/XanefEiEFtNQx3oMPnKIeYoNC
 4n8NJ240DUXvLMzaQtr1AGXreFk482YiOMs9E5xBZkTn6u/zMi21Z2KIioGTk9Ru
 dvuSbPQVYlXHZrv9QnnUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1695034484; x=
 1695120884; bh=/ReuUamhZrjRKCw+iB41h+4VD72/iNv6vEVay7pP8Oc=; b=k
 Pb40ns2qwaC3YDTVbwqNRF3zYu9aW2BOphdxPQ/vOVPclz5UuGm0n8+F7kKRT3jq
 CwEV2WRvZkHs6X8EZOdUE5Db3odzRSHwrlrgVpmZmpnrkmDzhAnuOnwiwD9HoEJ1
 Bx3KiGOhpZVy3pe2wR57f4w85m8Ek1PFtRWsXKQgBGRxL4Alwbxy9R8rZLGTyBpW
 3bo2U5PMqctCGE/FZawXf13wg3pxJkP85ifTjZFJxk29qw+1Vl7PO9Za7NQC51Qt
 lJ3X2N1kaivzQJktKSZaLkACi5Ouh+LZHS+TelgwtObZ+IESsqN1hgiyWFSDnOt3
 DCq5NHKRCMo97l8V8f33A==
X-ME-Sender: <xms:cywIZb3qHaGW9hTPPjJMiljJ-XTPqpznYmTztWFk10RUWE88AT5pSg>
 <xme:cywIZaHc1A6kjjwdIj09h6bVCCS_KPGuaBvfbYBhbKB19ZieJ93laOYePNKcFLarg
 mtyLbsCpqfOqfP17w>
X-ME-Received: <xmr:cywIZb7upoiUjyhDgyBUmACMHs0PYxiQ9yRmijOnSBwZj9S_Bj1jTnWFXC6EaVWFf9sPKho>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejkedgfedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
 evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
 ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
 dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
 vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:cywIZQ3HnUmBt7EmbZbFyomKKWmWt6p45UQ_X5T5zR6lEDmNvVfNJg>
 <xmx:cywIZeEyQxvDI0LO3rzZa-LIVp7xTAjQmfJIRG0C_gKpkROb_nMzjQ>
 <xmx:cywIZR9spYEOHjpGFkefsxVJ2FvejIeBj5BfECgRQBsfGDQBW1sevA>
 <xmx:dCwIZaCWnTtPPcY8pS9LrdGLIQcm4AcUrgYLjeC440JLcCvMWl6PuA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Sep 2023 06:54:41 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: kkostiuk@redhat.com,
	michael.roth@amd.com,
	berrange@redhat.com
Cc: qemu-devel@nongnu.org,
	hmodi@aviatrix.com
Subject: [PATCH 3/3] qga: test: Add test for guest-exec stream-output
Date: Mon, 18 Sep 2023 04:54:23 -0600
Message-ID: <ab964777763448df2e792dd3f53cd2a2a0470e92.1695034158.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695034158.git.dxu@dxuuu.xyz>
References: <cover.1695034158.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.24; envelope-from=dxu@dxuuu.xyz;
 helo=wout1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a test that simulates a long running process (by using a named pipe
to synchronize). This test ensures that full output is returned with
each call to guest-exec-status.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tests/unit/test-qga.c | 77 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/tests/unit/test-qga.c b/tests/unit/test-qga.c
index 671e83cb86..455183e60b 100644
--- a/tests/unit/test-qga.c
+++ b/tests/unit/test-qga.c
@@ -952,6 +952,81 @@ static void test_qga_guest_exec_merged(gconstpointer fix)
 }
 #endif
 
+#if defined(G_OS_WIN32)
+static void test_qga_guest_exec_stream(gconstpointer fix)
+{
+}
+#else
+static void test_qga_guest_exec_stream(gconstpointer fix)
+{
+    const TestFixture *fixture = fix;
+    g_autoptr(QDict) ret = NULL;
+    g_autofree char *fifo_path = NULL;
+    g_autofree char *cmd = NULL;
+    QDict *val;
+    const gchar *out;
+    g_autofree guchar *decoded = NULL;
+    int64_t pid, exitcode;
+    bool exited;
+    gsize len;
+    int fifo;
+
+    fifo_path = g_strdup_printf("%s/fifo", fixture->test_dir);
+    g_assert_cmpint(mkfifo(fifo_path, 0644), ==, 0);
+
+    /* Echo two lines with a fifo barrier in between */
+    cmd = g_strdup_printf("echo line1; cat %s; echo line2;", fifo_path);
+    ret = qmp_fd(fixture->fd, "{'execute': 'guest-exec', 'arguments': {"
+                 " 'path': '/bin/bash',"
+                 " 'arg': [ '-c', %s ],"
+                 " 'capture-output': 'stdout',"
+                 " 'stream-output': true } }",
+                 cmd);
+    g_assert_nonnull(ret);
+    qmp_assert_no_error(ret);
+    val = qdict_get_qdict(ret, "return");
+    pid = qdict_get_int(val, "pid");
+    g_assert_cmpint(pid, >, 0);
+    qobject_unref(ret);
+
+    /* Give bash some time to run */
+    usleep(G_USEC_PER_SEC / 20);
+
+    /* Check first line comes out */
+    ret = qmp_fd(fixture->fd,
+                 "{'execute': 'guest-exec-status',"
+                 " 'arguments': { 'pid': %" PRId64 " } }", pid);
+    g_assert_nonnull(ret);
+    val = qdict_get_qdict(ret, "return");
+    exited = qdict_get_bool(val, "exited");
+    g_assert_false(exited);
+    out = qdict_get_str(val, "out-data");
+    decoded = g_base64_decode(out, &len);
+    g_assert_cmpint(len, ==, 6);
+    g_assert_cmpstr((char *)decoded, ==, "line1\n");
+    g_free(decoded);
+    qobject_unref(ret);
+
+    /* Trigger second line */
+    fifo = open(fifo_path, O_WRONLY);
+    g_assert_cmpint(fifo, >=, 0);
+    close(fifo);
+    ret = wait_for_guest_exec_completion(fixture->fd, pid);
+
+    /* Check second line comes out after process exits */
+    val = qdict_get_qdict(ret, "return");
+    exited = qdict_get_bool(val, "exited");
+    g_assert_true(exited);
+    exitcode = qdict_get_int(val, "exitcode");
+    g_assert_cmpint(exitcode, ==, 0);
+    out = qdict_get_str(val, "out-data");
+    decoded = g_base64_decode(out, &len);
+    g_assert_cmpint(len, ==, 12);
+    g_assert_cmpstr((char *)decoded, ==, "line1\nline2\n");
+    g_assert_cmpint(unlink(fifo_path), ==, 0);
+}
+#endif
+
 static void test_qga_guest_exec_invalid(gconstpointer fix)
 {
     const TestFixture *fixture = fix;
@@ -1127,6 +1202,8 @@ int main(int argc, char **argv)
                          test_qga_guest_exec_separated);
     g_test_add_data_func("/qga/guest-exec-merged", &fix,
                          test_qga_guest_exec_merged);
+    g_test_add_data_func("/qga/guest-exec-stream", &fix,
+                         test_qga_guest_exec_stream);
     g_test_add_data_func("/qga/guest-exec-invalid", &fix,
                          test_qga_guest_exec_invalid);
     g_test_add_data_func("/qga/guest-get-osinfo", &fix,
-- 
2.41.0


