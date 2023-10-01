Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC64A7B4938
	for <lists+qemu-devel@lfdr.de>; Sun,  1 Oct 2023 20:40:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qn1LL-0002m3-C4; Sun, 01 Oct 2023 14:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dxu@dxuuu.xyz>) id 1qn1LJ-0002ls-Og
 for qemu-devel@nongnu.org; Sun, 01 Oct 2023 14:39:01 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dxu@dxuuu.xyz>) id 1qn1LI-0006OW-AX
 for qemu-devel@nongnu.org; Sun, 01 Oct 2023 14:39:01 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id BEAC83200EB8;
 Sun,  1 Oct 2023 14:38:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Sun, 01 Oct 2023 14:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
 :cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm1; t=1696185538; x=
 1696271938; bh=Fk1bg7pCh2iGJ3mNqVOFCielk9qFNKxDe70Z8Ragk3E=; b=P
 yShKqubcFhwAiIIJuzriLXXZ5E/0nyrDguCnf/fMPt+QDv0yQhtRmF883ImBYfsS
 iOalqO2t89UjBGccqaS7TcDGi6lkxufbpj99w3uC9y8GXLh/iF7gnPzZ/dAzS4bE
 Eaivu/YjuCas49z4MDaeZijCOQj6+gu7gY+T8ZI1muFAJilQYk7Eb5j9cIVCZcb2
 t1DSvyFQT5ICDsEp5BEfK+qaCZtAmLpzCDGu4CaDI2egrZE5QgMoUK8zYhsWvVkY
 wvHIHeZO3griZDzd7E2KcvepHaRAhaLWEWuHGmjZ0BVTG5lOD/3/wcMnqDY7gqkR
 x379JLwKcUauQGeP4bUwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1696185538; x=
 1696271938; bh=Fk1bg7pCh2iGJ3mNqVOFCielk9qFNKxDe70Z8Ragk3E=; b=C
 r337AGhvZU3jtNAaBlS+BasyedukfdeSOY6YIwGFGNYeBUvR4VIJftcAJIVp8zOZ
 fuis0JYozNeFL++ECZm7rv5LW5oUf8ujCvzk8Wx3PE0o7+N+QfLhPoCcO4efJ9zH
 iupXq2TofP+eEnbz7m14dxQLQG6N/gTbfI2B0GoEoiksYJjJux9DHbh+BdD7gxaE
 RqF+qdundFFAhaYrux2ZivQGwYDZULZDY9Byb5N07MaPkv0TCoAOeSWA83VPqnEN
 8djfF69QGOQ7vdv0UcfAlHKqJwJ9qRILYpxIt6FdNgEyJMHJvq4xL57SBbjB1udk
 BO1hA3LjG6DDeTsUP/iRw==
X-ME-Sender: <xms:wrwZZVzdpOqcbpZvaxh_hCLfwEI1-Ow6SKK6fuNT_X_8ILzgQ5Pq5w>
 <xme:wrwZZVQE2SeZdubOoJoZl0jssyIYa0-uQ-b8wiYo95BNtUu69TG7wUgHa0nt_iW4q
 SZCLKWWHs5u-EEeRA>
X-ME-Received: <xmr:wrwZZfWnGr4V_v7HZ-qinLdLZef6m5OHcHbHoN4LXZqQILhZJ453qU8dAdq8fnPT8uKFeJf0pL-oi2EmDLxAAZNU6ImYkW_CTM84yFY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefucetufdoteggodetrfdotffvucfrrh
 hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkf
 fojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhes
 ugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeikedvueetff
 elieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihiivgeptden
 ucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:wrwZZXgN_3S8Pirpa6ickDLGE7Gn-2xFdeRSKL7GALAfZmSs1neEqA>
 <xmx:wrwZZXBQlq31c1e8nJdrG2KcyUDqLzMTnZyz6f9MUGiDKNujl6P-rw>
 <xmx:wrwZZQJ8a71h8NNobxaF_UfppUWSXkE287ACQsSj0yFdIn4HJfQEiw>
 <xmx:wrwZZeOf0jxFLurxaLwUQ_tlqSncUSwRtTLDdfZ1bwT5T4_o6vuNoQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Oct 2023 14:38:57 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: michael.roth@amd.com, kkostiuk@redhat.com, armbru@redhat.com,
 berrange@redhat.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 1/2] qga: Fix memory leak when output stream is unused
Date: Sun,  1 Oct 2023 12:38:25 -0600
Message-ID: <ab3696a99ea0ddf674c4f6b6463b9b9a11ad30e2.1696185261.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696185261.git.dxu@dxuuu.xyz>
References: <cover.1696185261.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.20; envelope-from=dxu@dxuuu.xyz;
 helo=wout4-smtp.messagingengine.com
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

If capture-output is requested but one of the channels goes unused (eg.
we attempt to capture stderr but the command never writes to stderr), we
can leak memory.

guest_exec_output_watch() is (from what I understand) unconditionally
called for both streams if output capture is requested. The first call
will always pass the `p->size == p->length` check b/c both values are
0. Then GUEST_EXEC_IO_SIZE bytes will be allocated for the stream.

But when we reap the exited process there's a `gei->err.length > 0`
check to actually free the buffer. Which does not get run if the command
doesn't write to the stream.

Fix by making free() unconditional.

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 qga/commands.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qga/commands.c b/qga/commands.c
index 09c683e263..ce172edd2d 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -206,15 +206,15 @@ GuestExecStatus *qmp_guest_exec_status(int64_t pid, Error **errp)
 #endif
         if (gei->out.length > 0) {
             ges->out_data = g_base64_encode(gei->out.data, gei->out.length);
-            g_free(gei->out.data);
             ges->has_out_truncated = gei->out.truncated;
         }
+        g_free(gei->out.data);
 
         if (gei->err.length > 0) {
             ges->err_data = g_base64_encode(gei->err.data, gei->err.length);
-            g_free(gei->err.data);
             ges->has_err_truncated = gei->err.truncated;
         }
+        g_free(gei->err.data);
 
         QTAILQ_REMOVE(&guest_exec_state.processes, gei, next);
         g_free(gei);
-- 
2.42.0


