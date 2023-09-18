Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 327747A47AB
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 12:55:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiBtr-00051z-R1; Mon, 18 Sep 2023 06:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dxu@dxuuu.xyz>) id 1qiBtp-00051C-Oq
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:54:41 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dxu@dxuuu.xyz>) id 1qiBtn-0000Cf-IM
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:54:41 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.west.internal (Postfix) with ESMTP id 0782F3200392;
 Mon, 18 Sep 2023 06:54:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Mon, 18 Sep 2023 06:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
 :cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm1; t=1695034477; x=
 1695120877; bh=lrwfeWhM9YciqVz2gysFObhZcZA9e3eJTJ8tXVBkz2A=; b=k
 uAXFcSuV47Y3owCSgE7afevoaGt8MXYRUpm+RgMqW9k0NOflP+759vcGSw5hyUZ7
 6wqFm8duKiiKp9I4w+4EQQXUi2UGkHdsd8BncT9bXpfzt5MWpeh59NXhAyyAX3L3
 F2OGvJkH4E93A4Ly/ttJQ+xvYENHZB7F6u1LXtbShN+wwY0yKoDaby7i+qURNCe0
 J5z6MvxvkycmRNnATIebaywPPbILN2xhfdli6wYApGIceZytlVWGCtrpbLOi3j+N
 oUxP+LmsMPPfrud6FjKNSjkLO0wxmWFGmO4n9U33yymtd6PZS6V5uduEoBaSR/5m
 Mp+0QvaDOnR+RTzm+hmMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1695034477; x=
 1695120877; bh=lrwfeWhM9YciqVz2gysFObhZcZA9e3eJTJ8tXVBkz2A=; b=d
 1NdIEv0NL5HxJbpCSGOfBMpcLQuJvrhftA6G/c8z5rr5vN8sTW0V2/FGI2tbdOyO
 NR8y//ILIHiFLFVD5hjQA9dwEGemkGLwqqBFC1A2GinVhPU49wYEioqwt1gGOKlA
 iryn8RRj6UdDtf+h9/FeLbEq+FghzaCLxNPe7ptPEJsnlTq6kpYnqLaxG6/MXGwF
 i1yEnya9cNYjNqogjM6DNA7wY1d7IdJZTUhls3HP7NwH9//V6I6ZSPK8uhXzUZFz
 yMSIoI+Cvs7rxY0MHkYQRBPXNkUxYG8JaIbAEkpdQswqajoX4xH5eHoWwKnbHJjN
 FgLAnVJULMHoP1KaytivA==
X-ME-Sender: <xms:bSwIZcYZU5OHe0idLXejupnzbH7NzrJsw4dIZcWbsDm4WcxfmDILPg>
 <xme:bSwIZXb5ByLifrPcOLtXbP90ojjE16McYqsD5zSdKSii3IfrEQyLdSuhCVVlxtSUF
 7JNXLaVrFG_HkN9uA>
X-ME-Received: <xmr:bSwIZW-Trev8BNU9rCH73jPV5WS1OXaaat0rxz26XgNp1jyvedlsoPRLUdGwbL47SOBiJGY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejkedgfeefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
 evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
 ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
 dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
 vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:bSwIZWrslLzml-B4kDS0l_IEwzA-szvq_IAyIyVEp0pRXCZC9d6t-g>
 <xmx:bSwIZXqpyzF0vluEx-89kGT_SLvQ9B6b6KJtHTG4yNVzpwde9sXYcQ>
 <xmx:bSwIZURhWbeJzfgGIW7CBMK7XE-Yf_feTMvy5qjPUA11mK6izzPBMA>
 <xmx:bSwIZWUra1b8mkrtOOyF0S3FXwMwmRLIFhjuTzrDbZ122ExzZBYMJg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Sep 2023 06:54:35 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: kkostiuk@redhat.com,
	michael.roth@amd.com,
	berrange@redhat.com
Cc: qemu-devel@nongnu.org,
	hmodi@aviatrix.com
Subject: [PATCH 1/3] qga: Fix memory leak when output stream is unused
Date: Mon, 18 Sep 2023 04:54:21 -0600
Message-ID: <ae16e9ec85a25e6ed679ca1360c57b3f2cafd138.1695034158.git.dxu@dxuuu.xyz>
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
2.41.0


