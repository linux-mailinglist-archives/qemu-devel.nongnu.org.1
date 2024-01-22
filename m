Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D04837250
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 20:19:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRzoJ-0007tX-4S; Mon, 22 Jan 2024 14:18:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rRzoH-0007sm-Mo
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 14:18:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rRzoG-0004cU-Bo
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 14:18:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705951095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z3u6Yy9CfrVqwRHpuhwl3ZEXeFccWfWXdnHXfJdqu0U=;
 b=VOXUEV4DC1WITDMzF8+bmdOIrABCj4+N+fvTGQ04eDfjTuosRG/eTxsgJSjkAnBw4g66Pf
 FgAfgjXvLMhjqVHttAuDksEBMpONdcn2bxhEQcxulveM0YPIyvGO2vs3Yh3ZMH45Q/lZEC
 aE+Hio/TNjaycPTz0mOCodgoHE0Ns5E=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-yVRBcxsbNu2UAsUKFqchqw-1; Mon,
 22 Jan 2024 14:18:11 -0500
X-MC-Unique: yVRBcxsbNu2UAsUKFqchqw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 59F9F28EA6E5;
 Mon, 22 Jan 2024 19:18:05 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.179])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B332492BC6;
 Mon, 22 Jan 2024 19:18:03 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>,
	qemu-trivial@nongnu.org
Subject: [PATCH 5/5] util/uri: Remove unused macros ISA_RESERVED() and
 ISA_GEN_DELIM()
Date: Mon, 22 Jan 2024 20:17:53 +0100
Message-ID: <20240122191753.103118-6-thuth@redhat.com>
In-Reply-To: <20240122191753.103118-1-thuth@redhat.com>
References: <20240122191753.103118-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

They are not used anywhere, so there's no need to keep them around.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 util/uri.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/util/uri.c b/util/uri.c
index 5f5ca79792..2deab91da3 100644
--- a/util/uri.c
+++ b/util/uri.c
@@ -163,19 +163,6 @@ static void uri_clean(URI *uri);
      ((*(p) == '+')) || ((*(p) == ',')) || ((*(p) == ';')) ||                  \
      ((*(p) == '=')) || ((*(p) == '\'')))
 
-/*
- *    gen-delims    = ":" / "/" / "?" / "#" / "[" / "]" / "@"
- */
-#define ISA_GEN_DELIM(p)                                                       \
-    (((*(p) == ':')) || ((*(p) == '/')) || ((*(p) == '?')) ||                  \
-     ((*(p) == '#')) || ((*(p) == '[')) || ((*(p) == ']')) ||                  \
-     ((*(p) == '@')))
-
-/*
- *    reserved      = gen-delims / sub-delims
- */
-#define ISA_RESERVED(p) (ISA_GEN_DELIM(p) || (ISA_SUB_DELIM(p)))
-
 /*
  *    unreserved    = ALPHA / DIGIT / "-" / "." / "_" / "~"
  */
-- 
2.43.0


