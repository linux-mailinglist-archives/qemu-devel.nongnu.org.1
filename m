Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 856857B1EE7
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:47:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlrJl-0000zF-AZ; Thu, 28 Sep 2023 09:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qlrJe-0000vM-NK
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:44:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qlrJP-0005FU-Eo
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695908653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5a+Sfl4+XDRgp7FT+3zfvklhFMtJBxRGcdWHy6W9jaI=;
 b=JNCXmJgH+cu+gAtw1UvaHHOGhb2AdKh8GXYDm09nQxYqNlNLr7XxrpLPlyQzc3+LrbPL1G
 HFSFdiVbuTvezKK2OkNMWcQZb1hvyTyqQGpkI4IZ64GWxoB4KOaMIH9QG+EqCKosKw0IUY
 97lyH5yq8/dkHKwOn2TUfrsyn0Ci38k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-0KtYT3rOMqq7fvU9PsHbmQ-1; Thu, 28 Sep 2023 09:44:11 -0400
X-MC-Unique: 0KtYT3rOMqq7fvU9PsHbmQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4066C3C40C0D;
 Thu, 28 Sep 2023 13:44:11 +0000 (UTC)
Received: from localhost (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8CA592156A27;
 Thu, 28 Sep 2023 13:44:10 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Mads Ynddal <m.ynddal@samsung.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 01/14] simpletrace: add __all__ to define public interface
Date: Thu, 28 Sep 2023 09:43:54 -0400
Message-ID: <20230928134407.568453-2-stefanha@redhat.com>
In-Reply-To: <20230928134407.568453-1-stefanha@redhat.com>
References: <20230928134407.568453-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Mads Ynddal <m.ynddal@samsung.com>

It was unclear what was the supported public interface. I.e. when
refactoring the code, what functions/classes are important to retain.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
Message-id: 20230926103436.25700-2-mads@ynddal.dk
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/simpletrace.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/simpletrace.py b/scripts/simpletrace.py
index 1f6d1ae1f3..b221d9a241 100755
--- a/scripts/simpletrace.py
+++ b/scripts/simpletrace.py
@@ -14,6 +14,8 @@
 from tracetool import read_events, Event
 from tracetool.backend.simple import is_string
 
+__all__ = ['Analyzer', 'process', 'run']
+
 header_event_id = 0xffffffffffffffff
 header_magic    = 0xf2b177cb0aa429b4
 dropped_event_id = 0xfffffffffffffffe
-- 
2.41.0


