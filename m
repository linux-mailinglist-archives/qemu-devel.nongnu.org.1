Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1961939B49
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jul 2024 09:03:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW9YG-0004rV-MF; Tue, 23 Jul 2024 03:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sW9YB-0004lu-Kb
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:03:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sW9Y6-0000j8-UM
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721718181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K/GzOZxFCbN6eJ01B+nSFP77J4zP5nfCvO0hf3Fvfsw=;
 b=QdSfYshJyDzZFmO8IdM6UDKtie5VVr3IIKZlEbW6INWyiJthRt4AYMZuLLDl9+dIvIKqda
 vJ4n3tPrHq0KTvAGrM/Tr5/5U6VT1LxhW7G7c1UhrjApp4EuKo4pvMmibgCcreFiZBAtVV
 UA3Ai9x2wUWK7EdPKZfdWZ9nYlQ3hLs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-kpxIn2ijOX-FsSy2xcefcw-1; Tue,
 23 Jul 2024 03:02:59 -0400
X-MC-Unique: kpxIn2ijOX-FsSy2xcefcw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C3D051955D4A; Tue, 23 Jul 2024 07:02:58 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.211])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B0513000192; Tue, 23 Jul 2024 07:02:56 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL v2 01/25] qga: drop blocking of guest-get-memory-block-size
 command
Date: Tue, 23 Jul 2024 10:02:27 +0300
Message-ID: <20240723070251.25575-2-kkostiuk@redhat.com>
In-Reply-To: <20240723070251.25575-1-kkostiuk@redhat.com>
References: <20240723070251.25575-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

This command has never existed in tree, since it was renamed to
guest-get-memory-block-info before being merged.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240712132459.3974109-2-berrange@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-posix.c | 2 +-
 qga/commands-win32.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 7f05996495..76af98ba32 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -3099,7 +3099,7 @@ GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
             "guest-suspend-disk", "guest-suspend-ram",
             "guest-suspend-hybrid", "guest-get-vcpus", "guest-set-vcpus",
             "guest-get-memory-blocks", "guest-set-memory-blocks",
-            "guest-get-memory-block-size", "guest-get-memory-block-info",
+            "guest-get-memory-block-info",
             NULL};
         char **p = (char **)list;
 
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 0d1b836e87..9fe670d5b4 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1995,7 +1995,7 @@ GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
         "guest-suspend-hybrid",
         "guest-set-vcpus",
         "guest-get-memory-blocks", "guest-set-memory-blocks",
-        "guest-get-memory-block-size", "guest-get-memory-block-info",
+        "guest-get-memory-block-info",
         NULL};
     char **p = (char **)list_unsupported;
 
-- 
2.45.2


