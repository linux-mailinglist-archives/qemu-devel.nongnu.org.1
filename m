Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22535A055B5
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Jan 2025 09:47:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVRhS-00068r-IC; Wed, 08 Jan 2025 03:46:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tVRhD-00065r-Vo
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 03:45:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tVRhC-0001no-Hj
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 03:45:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736325945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tW/wPuJVrr8OL/8q9TH0GvpC38OJs+qigH7g3x85HTo=;
 b=hsFoiep/Na5orWIgvlQaFMR+5gxqf7JssnGYW6XIcE7tQSJ9CdZ3yaMD6fjfjzhPctFWQj
 ApepfPreyviTGgxVucXb3vYR/8GNE7Zoivpsyx+sDhKkNKFGxGNcQ3JCNkR0yNh2xQBgmT
 PJ5HC+Xh35s9xJF2lLoMaOY5TFYNAiM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-teCmVej8MrG0fYERuIpxVQ-1; Wed,
 08 Jan 2025 03:45:43 -0500
X-MC-Unique: teCmVej8MrG0fYERuIpxVQ-1
X-Mimecast-MFC-AGG-ID: teCmVej8MrG0fYERuIpxVQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2D491955DC0
 for <qemu-devel@nongnu.org>; Wed,  8 Jan 2025 08:45:42 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-228.str.redhat.com
 [10.33.192.228])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6E4F019560AA; Wed,  8 Jan 2025 08:45:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 13/14] docs/about/deprecated: Remove paragraph about initial
 deprecation in 2.10
Date: Wed,  8 Jan 2025 09:45:10 +0100
Message-ID: <20250108084511.238458-14-thuth@redhat.com>
In-Reply-To: <20250108084511.238458-1-thuth@redhat.com>
References: <20250108084511.238458-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

When we introduced the deprecation rule of keeping deprecated features
for two more releases, we had to state that we would not remove features
by surprise that had already been marked as deprecated before. Nowadays,
this paragraph is not needed anymore, so we can remove it now.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250103145702.597139-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/about/deprecated.rst | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 63b46fd520..4a3c302962 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -24,12 +24,6 @@ should exclusively use a non-deprecated machine type, with use of the most
 recent version highly recommended. Non-versioned machine types follow the
 general feature deprecation policy.
 
-Prior to the 2.10.0 release there was no official policy on how
-long features would be deprecated prior to their removal, nor
-any documented list of which features were deprecated. Thus
-any features deprecated prior to 2.10.0 will be treated as if
-they were first deprecated in the 2.10.0 release.
-
 What follows is a list of all features currently marked as
 deprecated.
 
-- 
2.47.1


