Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FAD9053AC
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jun 2024 15:23:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNvZ-00011D-1M; Wed, 12 Jun 2024 09:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sHNuv-0000O7-Qs
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:21:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sHNuq-0003wj-7b
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718198484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fL0oeRA4y1D39ogIDciJCzoJ6e3r/gjv0CsBd13xcrY=;
 b=Kd6DWsihCBEZUW8VI0lXQkQegwtWWp+q1OZfBEQMEC5HLumnfSIbX7GJb6dJ5n5pgE5goC
 nKBa5a8FFB89taQPVB8lDKLUKhkPq9+RrHixYd4uzS9k/yrhwn2Lx5bdbXrYYOy9GKfhvJ
 AL4fd8cnV7LgnXWNU3HrqmmeqmGlxB8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-g7DcJbRPPtOjZJNWJ6SOIQ-1; Wed,
 12 Jun 2024 09:21:20 -0400
X-MC-Unique: g7DcJbRPPtOjZJNWJ6SOIQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AFCB819560B3; Wed, 12 Jun 2024 13:21:19 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.236])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B579B1955E87; Wed, 12 Jun 2024 13:21:17 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Zhao Liu <zhao1.liu@intel.com>,
	Yongwei Ma <yongwei.ma@intel.com>
Subject: [PULL 07/15] tests/unit/test-smp-parse: Fix comments of drawers and
 books case
Date: Wed, 12 Jun 2024 15:20:47 +0200
Message-ID: <20240612132055.326889-8-thuth@redhat.com>
In-Reply-To: <20240612132055.326889-1-thuth@redhat.com>
References: <20240612132055.326889-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Fix the comments to match the actual configurations.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Message-ID: <20240529061925.350323-2-zhao1.liu@intel.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/unit/test-smp-parse.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index 9fdba24fce..fa8e7d83a7 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -474,8 +474,8 @@ static const struct SMPTestData data_with_drawers_invalid[] = {
 static const struct SMPTestData data_with_drawers_books_invalid[] = {
     {
         /*
-         * config: -smp 200,drawers=2,books=2,sockets=2,cores=4,\
-         * threads=2,maxcpus=200
+         * config: -smp 200,drawers=3,books=5,sockets=2,cores=4,\
+         *              threads=2,maxcpus=200
          */
         .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 200, T, 3, T, 5, T,
                                                 2, T, 4, T, 2, T, 200),
@@ -485,8 +485,8 @@ static const struct SMPTestData data_with_drawers_books_invalid[] = {
                         "cores (4) * threads (2) != maxcpus (200)",
     }, {
         /*
-         * config: -smp 242,drawers=2,books=2,sockets=2,cores=4,\
-         * threads=2,maxcpus=240
+         * config: -smp 242,drawers=3,books=5,sockets=2,cores=4,\
+         *              threads=2,maxcpus=240
          */
         .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 242, T, 3, T, 5, T,
                                                 2, T, 4, T, 2, T, 240),
-- 
2.45.2


