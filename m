Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 302209D5A08
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Nov 2024 08:34:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEOAe-0006sl-Rj; Fri, 22 Nov 2024 02:33:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tEOAY-0006rp-UI
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 02:33:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tEOAX-0000d8-3d
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 02:33:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732260810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MG1T2c7HErPqJnnYKB+lRnlI3FXUhtC+uZQyIF5JB2o=;
 b=ExfhtkoiRo8UHCWlPz8ZWR0cmfU43UXLl2v1vTyP+FdoURgCpRXR/fip4Gby2zqeXDLFFp
 SiOuWq8wg1Z1QxbGxkaNHXvtFf5LUZxhyPiN/p5OlW3CKFbxhQeaEG31PCzRBORuv8Fo65
 euDh0pvKgWJlBm07JYvAuqH7hTfND8c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-NTcG502cNoS5G87GCGiJ6A-1; Fri,
 22 Nov 2024 02:33:25 -0500
X-MC-Unique: NTcG502cNoS5G87GCGiJ6A-1
X-Mimecast-MFC-AGG-ID: NTcG502cNoS5G87GCGiJ6A
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C3FD19560B2; Fri, 22 Nov 2024 07:33:22 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.194.14])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E78B71955F40; Fri, 22 Nov 2024 07:33:10 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 0/3] tests/functional: Finish conversion of Aspeed tests
Date: Fri, 22 Nov 2024 08:33:06 +0100
Message-ID: <20241122073309.1897944-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
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

Hello,

This series completes the conversion of the Aspeed tests to the new
functional framework and removes the workarounds for capturing the
console output.
  
Thanks,

C.

Changes in v3:

 - Rebased on :
   https://lore.kernel.org/all/20241121165806.476008-1-alex.bennee@linaro.org/
 - Added documentation on EXTRA_BOOTARGS removal
 - Used a "login:" string or the command prompt to wait for in all
   executed commands

Changes in v2:

 - Redirected all console output in console.log file
 - Added a "found" prefix when an expected string is captured
 - Used a user mode network backend in SDK tests
 - Changed the expected string to "login:" in buildroot tests
 
Cédric Le Goater (3):
  tests/functional: Convert Aspeed aarch64 SDK tests
  tests/functional: Convert Aspeed arm SDK tests
  tests/functional: Remove sleep workarounds from Aspeed tests

 tests/avocado/machine_aspeed.py         | 202 ------------------------
 tests/functional/meson.build            |   2 +
 tests/functional/test_aarch64_aspeed.py |  97 ++++++++++++
 tests/functional/test_arm_aspeed.py     |  83 ++++++++--
 4 files changed, 173 insertions(+), 211 deletions(-)
 delete mode 100644 tests/avocado/machine_aspeed.py
 create mode 100644 tests/functional/test_aarch64_aspeed.py

-- 
2.47.0


