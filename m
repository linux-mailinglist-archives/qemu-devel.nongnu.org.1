Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DDCAC669C
	for <lists+qemu-devel@lfdr.de>; Wed, 28 May 2025 12:06:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKDfS-0003j6-Ta; Wed, 28 May 2025 06:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKDfN-0003hP-UJ
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:05:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKDfM-0007Df-9j
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:05:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748426743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1RB+zViEFHGrU/67PhbRLcWmgiYOEsMhUSk4cTJVDvQ=;
 b=GGNtdDHgifSxke0g1K8cicyhCeaF2XMAT9HgTASxHgyjUuJgNBXjFgmhapEgU1koSoXDWv
 jXkKgyNvwNCVVDHUXG8T2+U+QQMwhz0u6vlEmH9vApzoCR1pqpBwlXzlL+nCdJpMsH4pwY
 9U/uxGuj7WAxLi68ob3upOS+TtJi7g0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-e6QBhjJiO2W8e2npM3c4Qw-1; Wed,
 28 May 2025 06:05:40 -0400
X-MC-Unique: e6QBhjJiO2W8e2npM3c4Qw-1
X-Mimecast-MFC-AGG-ID: e6QBhjJiO2W8e2npM3c4Qw_1748426739
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9169218004AD; Wed, 28 May 2025 10:05:39 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.110])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5A9AC180049D; Wed, 28 May 2025 10:05:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/27] docs: Deprecate the qemu-system-microblazeel binary
Date: Wed, 28 May 2025 12:04:49 +0200
Message-ID: <20250528100507.313906-10-thuth@redhat.com>
In-Reply-To: <20250528100507.313906-1-thuth@redhat.com>
References: <20250528100507.313906-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) DKIMWL_WL_HIGH=-2.907, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

The (former big-endian only) binary qemu-system-microblaze can
handle both endiannesses nowadays, so we don't need the separate
qemu-system-microblazeel binary for little endian anymore. Let's
deprecate it to avoid unnecessary compilation and test time in
the future.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250515132019.569365-5-thuth@redhat.com>
---
 docs/about/deprecated.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index f3bf02d8b88..891f8dedc90 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -354,6 +354,19 @@ machine must ensure that they're setting the ``spike`` machine in the
 command line (``-M spike``).
 
 
+System emulator binaries
+------------------------
+
+``qemu-system-microblazeel`` (since 10.1)
+'''''''''''''''''''''''''''''''''''''''''
+
+The ``qemu-system-microblaze`` binary can emulate little-endian machines
+now, too, so the separate binary ``qemu-system-microblazeel`` (with the
+``el`` suffix) for little-endian targets is not required anymore. The
+``petalogix-s3adsp1800`` machine can now be switched to little endian by
+setting its ``endianness`` property to ``little``.
+
+
 Backend options
 ---------------
 
-- 
2.49.0


