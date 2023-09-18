Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 288AA7A47A3
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 12:55:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiBtv-00052a-CG; Mon, 18 Sep 2023 06:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dxu@dxuuu.xyz>) id 1qiBts-000529-BQ
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:54:44 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dxu@dxuuu.xyz>) id 1qiBtq-0000E9-Mv
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:54:44 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 226E03200919;
 Mon, 18 Sep 2023 06:54:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Mon, 18 Sep 2023 06:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
 :cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm1; t=1695034480; x=
 1695120880; bh=VJ9GASl+fhQZvEW6RQqJ8ZOMhK5Q04EI7LzWsMFMn+Q=; b=e
 cxmr0z6OS9EU6pZfBvlyqO6oVD9Wktq2CCoMoX7tyYIsbzQa5cnqtKK3zdVQkoq3
 aJ5F48GqEA/9vYrnOcEy6A6qu2wFjN54CbqJQHUWc1N3BDCZmNdKqILOq1F0/vi1
 BJYUlSqcBRnzTP7z1gbIxuevFKVa2iBp0FUlRvVc0aM1B2a/pNkk8iTCJiP0Cpc8
 jO/5CfvAmRH+hmcjwCsmQ1bVnlfhneGjcrFCMjl6wzBlKV35HmNjeHEgsR5sTN1R
 YLBJG7kkv1Ra7TzH1hkR/4s/jE/sBJpKun+y+ahr+nwQqYC+iAc9IK/Pwk2g3f37
 m9Fa4ZikanrS7cGWe1Tpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1695034480; x=
 1695120880; bh=VJ9GASl+fhQZvEW6RQqJ8ZOMhK5Q04EI7LzWsMFMn+Q=; b=A
 h7N/HsosM2TKekJ0OaDQnAhhrd2gH5domWIRR2zF9vGsGxO4cgLt9T8bKkEUc6sY
 kyhyekjI2F8h78tcTqhC9CJM6GcTj9AQXq4lAMtK2hPp+EtsvQ+fdDeRkeps+uqw
 ikqy8LTOhdvVpCiX8ZXvd20v5nr1yU0OfaMrpfbb6iWGZiniGKNmSEDBLFNStXxY
 LcI2t2tiYyLpoFnu5xbuOmXeQCcL+qX9x5E+jjE1q4/56PFkNIv1k3F7qEeCYdLd
 6FR6RI0qMRN/TuFSVPsnEtRkjPrA9UETTZUB5/J9jwku7KkX6FfjEdczyedcH1kr
 DCjlyX8vP9v17znRDCCmA==
X-ME-Sender: <xms:cCwIZZ5TlcljfmoID3C-LPYMbJ21NRz_1ubqLSlXRGGeoyO7t2egpQ>
 <xme:cCwIZW6qUl_ql1Qrv8iGRRIQACojZrRGOIiueGstP-xDkOhdDKxBtxt862kblXi7k
 7sAkN8Yqry4k4HGwQ>
X-ME-Received: <xmr:cCwIZQe9GVSx-TlGLjcNbF3aIxN8Bml1XPenZcz_2EiPk9KD1it1V2-FDLW1wM0D4FCZoOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejkedgfeefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
 evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
 ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
 dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
 vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:cCwIZSIyIYiNcoRwMJI0a2vYLlegXj2BvddYreUgEsE0fcmZlk-CeQ>
 <xmx:cCwIZdKoyLj6u5bwU988W9HoF0U8rNx5myqCP2l2VJ7L8c24A3TRpg>
 <xmx:cCwIZbwpmzORo_59OjcRrPf35Ber6uxr1gv82546p0qfc6lsYEgWfQ>
 <xmx:cCwIZd2KwLeECBcJzInyb0bw0lhKG7b3byGchjJTO4fhyiR_c0efdA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Sep 2023 06:54:38 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: kkostiuk@redhat.com,
	michael.roth@amd.com,
	berrange@redhat.com
Cc: qemu-devel@nongnu.org,
	hmodi@aviatrix.com
Subject: [PATCH 2/3] qga: Add optional stream-output argument to guest-exec
Date: Mon, 18 Sep 2023 04:54:22 -0600
Message-ID: <604ef5fd5bda8acdb837b5d28ec405e9fb0332a3.1695034158.git.dxu@dxuuu.xyz>
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

Currently, commands run through guest-exec are "silent" until they
finish running. This is fine for short lived commands. But for commands
that take a while, this is a bad user experience.

Usually long running programs know that they will run for a while. To
improve user experience, they will typically print some kind of status
to output at a regular interval. So that the user knows that their
command isn't just hanging.

This commit adds support for an optional stream-output parameter to
guest-exec. This causes subsequent calls to guest-exec-status to return
all buffered output. This allows downstream applications to be able to
relay "status" to the end user.

If stream-output is requested, it is up to the guest-exec-status caller
to keep track of the last seen output position and slice the returned
output appropriately. This is fairly trivial for a client to do. And it
is a more reliable design than having QGA internally keep track of
position -- for the cases that the caller "loses" a response.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 qga/commands.c       | 12 ++++++++++++
 qga/qapi-schema.json |  7 ++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/qga/commands.c b/qga/commands.c
index ce172edd2d..8cabc2460f 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -97,6 +97,7 @@ struct GuestExecInfo {
     int64_t pid_numeric;
     gint status;
     bool has_output;
+    bool stream_output;
     bool finished;
     GuestExecIOData in;
     GuestExecIOData out;
@@ -218,6 +219,15 @@ GuestExecStatus *qmp_guest_exec_status(int64_t pid, Error **errp)
 
         QTAILQ_REMOVE(&guest_exec_state.processes, gei, next);
         g_free(gei);
+    } else if (gei->stream_output) {
+        if (gei->out.length > 0) {
+            ges->out_data = g_base64_encode(gei->out.data, gei->out.length);
+            ges->has_out_truncated = gei->out.truncated;
+        }
+        if (gei->err.length > 0) {
+            ges->err_data = g_base64_encode(gei->err.data, gei->err.length);
+            ges->has_err_truncated = gei->err.truncated;
+        }
     }
 
     return ges;
@@ -410,6 +420,7 @@ GuestExec *qmp_guest_exec(const char *path,
                        bool has_env, strList *env,
                        const char *input_data,
                        GuestExecCaptureOutput *capture_output,
+                       bool has_stream_output, bool stream_output,
                        Error **errp)
 {
     GPid pid;
@@ -485,6 +496,7 @@ GuestExec *qmp_guest_exec(const char *path,
 
     gei = guest_exec_info_add(pid);
     gei->has_output = has_output;
+    gei->stream_output = has_stream_output && stream_output;
     g_child_watch_add(pid, guest_exec_child_watch, gei);
 
     if (input_data) {
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index b720dd4379..0a76e35082 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1315,13 +1315,18 @@
 # @capture-output: bool flag to enable capture of stdout/stderr of
 #     running process.  defaults to false.
 #
+# @stream-output: causes future guest-exec-status calls to always
+#     return current captured output rather than waiting to return
+#     it all when the command exits. defaults to false. (since: 8.2)
+#
 # Returns: PID on success.
 #
 # Since: 2.5
 ##
 { 'command': 'guest-exec',
   'data':    { 'path': 'str', '*arg': ['str'], '*env': ['str'],
-               '*input-data': 'str', '*capture-output': 'GuestExecCaptureOutput' },
+               '*input-data': 'str', '*capture-output': 'GuestExecCaptureOutput',
+               '*stream-output': 'bool' },
   'returns': 'GuestExec' }
 
 
-- 
2.41.0


