Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC00998DE5
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Oct 2024 18:58:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sywTW-0000f3-Rc; Thu, 10 Oct 2024 12:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sywTU-0000eP-DQ
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 12:57:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sywTS-0000f5-W8
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 12:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728579434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=4bjmF6CYmZjE9cPmoyqAUls739GZG2d/1BmyjWCH8Tg=;
 b=Etw0Oaycj+qfEQKZNK65TL8YXdP2CbbspmOf4maUEsxND6upiQAGWb0PC58KzTQD2UCUb2
 MTT1VzH3iBodRCgAs+X/HlF6s1HHebB7d9YyCia50Mj6uNj1+S4a/3PHQkB+9j/CVkYe/Z
 NHzQKgik2id8V4dowQGj29S1SOqC1iA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-5M4ONwWwMCGBW-YvWyASpg-1; Thu,
 10 Oct 2024 12:57:09 -0400
X-MC-Unique: 5M4ONwWwMCGBW-YvWyASpg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8AF41956088; Thu, 10 Oct 2024 16:57:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.47])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2FBEC195607C; Thu, 10 Oct 2024 16:57:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F1E1A21E6A28; Thu, 10 Oct 2024 18:57:01 +0200 (CEST)
Resent-To: michael.roth@amd.com, xieyongji@bytedance.com,
 Coiby.Xu@gmail.com, eduardo@habkost.net, mark.cave-ayland@ilande.co.uk,
 philmd@linaro.org, qemu-block@nongnu.org, qemu-devel@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Thu, 10 Oct 2024 18:57:01 +0200
Resent-Message-ID: <87ldyvhp5u.fsf@pond.sub.org>
X-From-Line: armbru@redhat.com  Thu Oct 10 17:01:44 2024
X-Original-To: armbru
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2D1EF21E68B2; Thu, 10 Oct 2024 17:01:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: xieyongji@bytedance.com, kwolf@redhat.com, hreitz@redhat.com,
 Coiby.Xu@gmail.com, pbonzini@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, mark.cave-ayland@ilande.co.uk, michael.roth@amd.com,
 kkostiuk@redhat.com, qemu-block@nongnu.org, philmd@linaro.org
Subject: [PATCH v2 7/7] qerror: QERR_PROPERTY_VALUE_OUT_OF_RANGE is no
 longer used, drop
Date: Thu, 10 Oct 2024 17:01:44 +0200
Message-ID: <20241010150144.986655-8-armbru@redhat.com>
In-Reply-To: <20241010150144.986655-1-armbru@redhat.com>
References: <20241010150144.986655-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Lines: 21
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/qerror.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
index 101c1141b9..d1db6f18cd 100644
--- a/include/qapi/qmp/qerror.h
+++ b/include/qapi/qmp/qerror.h
@@ -23,7 +23,4 @@
 #define QERR_MISSING_PARAMETER \
     "Parameter '%s' is missing"
 
-#define QERR_PROPERTY_VALUE_OUT_OF_RANGE \
-    "Property %s.%s doesn't take value %" PRId64 " (minimum: %" PRId64 ", maximum: %" PRId64 ")"
-
 #endif /* QERROR_H */
-- 
2.46.0



