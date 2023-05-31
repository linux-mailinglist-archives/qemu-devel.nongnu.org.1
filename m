Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C25717D03
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 12:17:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4IsF-0001md-VO; Wed, 31 May 2023 06:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eskultet@redhat.com>)
 id 1q4IsD-0001mK-Bz
 for qemu-devel@nongnu.org; Wed, 31 May 2023 06:16:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eskultet@redhat.com>)
 id 1q4IsB-0000Vj-FF
 for qemu-devel@nongnu.org; Wed, 31 May 2023 06:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685528166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R0BNZ1jQIjLJBGZHjnr/9umGTlFGV1JYDN7JOgx25qQ=;
 b=TzSbK2mjalq+UuTEXCy3JmCMKUmoc4IjlHAZSVEh3BYMfrDj/a4XOd4zK5Z8+cRSNiZhu6
 gNtug8r2MuqQr+qtGPwEMp1zgdaQpoqwVcD+UMh2aZfAPkYskEMQgot0iUEnMmMcS7IOdS
 ZkuMOhQWaVtpCfhCi8L3pjHVa+27ycU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-VM5Cq9JCNUOiQWtM7ctpEg-1; Wed, 31 May 2023 06:14:52 -0400
X-MC-Unique: VM5Cq9JCNUOiQWtM7ctpEg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9ADC9185A791;
 Wed, 31 May 2023 10:14:51 +0000 (UTC)
Received: from ridgehead.redhat.com (unknown [10.45.224.152])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 77AD640CFD08;
 Wed, 31 May 2023 10:14:50 +0000 (UTC)
From: Erik Skultety <eskultet@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Erik Skultety <eskultet@redhat.com>
Subject: [PATCH 1/2] tests: lcitool: Refresh to latest master
Date: Wed, 31 May 2023 12:14:47 +0200
Message-Id: <91978633d9ff3d3b4e413c71a2c51932b1708335.1685528076.git.eskultet@redhat.com>
In-Reply-To: <cover.1685528076.git.eskultet@redhat.com>
References: <cover.1685528076.git.eskultet@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eskultet@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

- adds Alpine 3.17 & 3.18 targets, drops 3.15 & 3.16
- adds pipewire-dev mapping

Signed-off-by: Erik Skultety <eskultet@redhat.com>
---
 tests/lcitool/libvirt-ci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index c8971e90a..6d8b63be7 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit c8971e90ac169ee2b539c747f74d96c876debdf9
+Subproject commit 6d8b63be74e1dd317808657ccf59321d125403fa
-- 
2.40.1


