Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1207B4939
	for <lists+qemu-devel@lfdr.de>; Sun,  1 Oct 2023 20:40:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qn1LP-0002mU-0x; Sun, 01 Oct 2023 14:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dxu@dxuuu.xyz>) id 1qn1LL-0002mL-Ld
 for qemu-devel@nongnu.org; Sun, 01 Oct 2023 14:39:03 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dxu@dxuuu.xyz>) id 1qn1LK-0006Qp-7p
 for qemu-devel@nongnu.org; Sun, 01 Oct 2023 14:39:03 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.west.internal (Postfix) with ESMTP id AB3463200EBB;
 Sun,  1 Oct 2023 14:39:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Sun, 01 Oct 2023 14:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
 :cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm1; t=1696185540; x=
 1696271940; bh=BiH8F8J+Usfp2OTAGkqTcECSCj+UFE/E2rKabqN4Lfo=; b=e
 9RuYRKod8F2UnyGi20k2xqJN8YvlPzOw3rtStFOxfbMTl/D0WUUXssrQPDSTYYvf
 yt7PGuanfT/jvwP+XHVa1PC+x9bU8Q1vo8PgTbUD1suTbJP0pw2w7ejobWHk+dt7
 tg2xAgJ2tiEhlcFoGQWWjqpldb2b+5rz/i+aM5q/jXIg91IFVV+ClNj4w6tXCvKV
 CufdtMvBUQ9r33uuOXaydmvIreDMCoz7oScFuLaMsniXiWBvSqLZZg7Gu7Q40oeD
 qA4/TEjmQTmgwR+ZAm2/sn1h1FmCwq6UkRolfuaBUxfSEdQ9sWIHD17zOo4zJkqr
 Z9SBEa4tGJhPSFL0TxQ/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1696185540; x=
 1696271940; bh=BiH8F8J+Usfp2OTAGkqTcECSCj+UFE/E2rKabqN4Lfo=; b=D
 Aj7oMSGBHOwGJM0Tr3crEhs4tpXqu84lcVMKlfsnxv9DjdxXYNHjVQeAVYNzgD1t
 ztxzTfrOBSZePO5jDAdFv1n05ilY4TWcT23N54tito2ElyupKPGRfDIrh6iuGFUN
 /8gYweHLGc+4p5BTxVc3xQtsK7Tmz8FD3oWcRcQoGDvgC9gtDZS1VgmxV3IgRq3h
 t9KbRtuCuk4pmu0XDQenTbzI6rdd6j+TeR5rF0AdG+Rqs4o9dC6PIuYkRPl3saBH
 cB0JhBg7orG3moXB8Fly4zpai4K6kCaNGMQj2ikfwHeqkzGUxyvBHzJ4jhiHDxr7
 22HOxDG5f0lLRUaYaDnIw==
X-ME-Sender: <xms:xLwZZQCDLnI0BBMUl0reYaMeHXn3XfYYADXmv2YSztLhUOEf78cmHw>
 <xme:xLwZZSjjdXOOg6CYhpxs00y1vBTOF-EHfI7yng1gj7DKRd3g7BFfAzGOPu4iisrS1
 yYbD07w7G_rg_tl4A>
X-ME-Received: <xmr:xLwZZTkAiCMLL2mJ8ecDdR4EfFACFIj_H97_-d6Z3QFYEBG8FGQJ9oK_hyj773Bco9CODcglizTW4blfJwGzRMkwxhQDzGshh2GdsvE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefucetufdoteggodetrfdotffvucfrrh
 hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevufffkf
 fojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhes
 ugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeikedvueetff
 elieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihiivgeptden
 ucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:xLwZZWy6ijgOoEjdcZcstZ9Hrj7azjAfwAIBSQzN13J5zilAQcxofQ>
 <xmx:xLwZZVQsYna9CUL_VmBh3AB1YZugyPUrWGMGrJ6GprtV6nY6hyg-og>
 <xmx:xLwZZRb09tHa7VWdH8PmjPu_3uDWtREsRFowJrzsqu9cAfcKugn2ZQ>
 <xmx:xLwZZXeGRUlbYhmQxuwy6052ZibG69smrZCmULQb5_1JSrYrD1K-kA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Oct 2023 14:38:59 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: michael.roth@amd.com, kkostiuk@redhat.com, armbru@redhat.com,
 berrange@redhat.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 2/2] qapi: qga: Clarify when out-data and err-data are
 populated
Date: Sun,  1 Oct 2023 12:38:26 -0600
Message-ID: <935735389830bbe8407d95ebf89632792bf11a30.1696185261.git.dxu@dxuuu.xyz>
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

If output is being captured for a guest-exec invocation, the out-data
and err-data fields of guest-exec-status are only populated after the
process is reaped. This is somewhat counter intuitive and too late to
change. Thus, it would be good to document the behavior.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 qga/qapi-schema.json | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index b720dd4379..876e2a8ea8 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1220,11 +1220,13 @@
 # @signal: signal number (linux) or unhandled exception code (windows)
 #     if the process was abnormally terminated.
 #
-# @out-data: base64-encoded stdout of the process
+# @out-data: base64-encoded stdout of the process. This field will only
+#     be populated after the process exits.
 #
-# @err-data: base64-encoded stderr of the process Note: @out-data and
+# @err-data: base64-encoded stderr of the process. Note: @out-data and
 #     @err-data are present only if 'capture-output' was specified for
-#     'guest-exec'
+#     'guest-exec'. This field will only be populated after the process
+#     exits.
 #
 # @out-truncated: true if stdout was not fully captured due to size
 #     limitation.
-- 
2.42.0


