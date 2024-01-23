Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A1D839797
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 19:24:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSLQQ-0001sg-KB; Tue, 23 Jan 2024 13:23:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rSLQN-0001qi-Qk
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 13:23:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rSLQM-00075C-D4
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 13:23:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706034181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hXzjaPrm8EeY1wCl4uaoHpH5ctPZ6quOFNd2OAdMg6c=;
 b=NrAd73NdhAcVTUOw6Z6VRpvlAjr3qdgtV2nZr/Ry5+AU55MtuGvymm9kpbcYl9DT7uEwR9
 agSRqkQZ58MLMcFZMMKscDBGl+ZJF7Sqlwjculz7ESHnBq2mjfrmfhsKf3OqWYZQg7BoMA
 Xfx9iChdBNwKoWkTRXeslZty1Y7I3tk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-gUZbvGGvP4aOaS50DUPdnQ-1; Tue, 23 Jan 2024 13:22:58 -0500
X-MC-Unique: gUZbvGGvP4aOaS50DUPdnQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D16C1013667;
 Tue, 23 Jan 2024 18:22:57 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3132D2166B32;
 Tue, 23 Jan 2024 18:22:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, qemu-trivial@nongnu.org,
 qemu-block@nongnu.org
Subject: [PATCH v2 4/4] util/uri: Remove unused macros ISA_RESERVED() and
 ISA_GEN_DELIM()
Date: Tue, 23 Jan 2024 19:22:47 +0100
Message-ID: <20240123182247.432642-5-thuth@redhat.com>
In-Reply-To: <20240123182247.432642-1-thuth@redhat.com>
References: <20240123182247.432642-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.327,
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

Message-ID: <20240122191753.103118-6-thuth@redhat.com>
Reviewed-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: "Daniel P. Berrangé" <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 util/uri.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/util/uri.c b/util/uri.c
index 350835b03f..573174bf47 100644
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


