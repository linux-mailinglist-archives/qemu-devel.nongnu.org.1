Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B86E7C7E39
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 08:55:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrC3y-0008MK-1c; Fri, 13 Oct 2023 02:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qrC3v-0008Ln-UQ
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 02:54:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qrC3u-0002cu-6R
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 02:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697180057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5BmgSGH6Cm5ms0B5I1PoyFrC595oBSnY4IbOj60VQy4=;
 b=fobH1U7uS+5Z1nc8SsvPeaFK/UcrmJsFtNtaQAxeDE7XhFBhnqX/WlXI7IibH1xS8lEqaU
 /g6UvVam60cVHv9rEa46u0vYdw8Wj2GqYofMbVU+baSJmHZGsjBQ6iGYaVBcGfzHZN01Wd
 vGHkvovQ26qmnUZjgXnrojWvH8guhAU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64-0viA7wtpNWiohmpo738nbw-1; Fri, 13 Oct 2023 02:54:12 -0400
X-MC-Unique: 0viA7wtpNWiohmpo738nbw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0DAC83C0DF67;
 Fri, 13 Oct 2023 06:54:12 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 684BA1C060DF;
 Fri, 13 Oct 2023 06:54:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Chris Wulff <crwulff@gmail.com>,
 Marek Vasut <marex@denx.de>
Subject: [PATCH] MAINTAINERS: Add the nios2 interrupt controller to the nios2
 section
Date: Fri, 13 Oct 2023 08:54:08 +0200
Message-ID: <20231013065408.949486-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

These files obviously belong to the nios2 target, so they should
be listed in the nios2 section in the MAINTAINERS file.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6eecd617e0..45eb230465 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -296,7 +296,9 @@ R: Marek Vasut <marex@denx.de>
 S: Orphan
 F: target/nios2/
 F: hw/nios2/
+F: hw/intc/nios2_vic.c
 F: disas/nios2.c
+F: include/hw/intc/nios2_vic.h
 F: configs/devices/nios2-softmmu/default.mak
 F: tests/docker/dockerfiles/debian-nios2-cross.d/build-toolchain.sh
 F: tests/tcg/nios2/
-- 
2.41.0


