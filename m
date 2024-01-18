Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 206E08316BE
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 11:39:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQPmn-0003dW-JH; Thu, 18 Jan 2024 05:38:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQPmk-0003cV-R2
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 05:38:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQPmi-0006v4-4G
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 05:38:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705574286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=j5hV5GmGycQNkJWF0EYTgUMVq9H9BhvmE8XkS6rWopw=;
 b=O6cMAUbzARM1yM1/ss5Xf45H1t5qUh5hfDEgCQSUd7csCoAlGOmi/EV9vlVQzYDdXUDiRa
 W7Csm8CC99bbMLS7/0UTgfGOGkcBXL7Zg4rwyeZcA54jnFPcP+wlmFzLXRiX0uSSUMtk1T
 zDlT43g3MrM9uzNWmhuEeM27qCe5i0U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-zmgEsOs0PpKxUSex-rvDBQ-1; Thu,
 18 Jan 2024 05:38:02 -0500
X-MC-Unique: zmgEsOs0PpKxUSex-rvDBQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41245285F998;
 Thu, 18 Jan 2024 10:38:02 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C1CAB492BC6;
 Thu, 18 Jan 2024 10:38:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/4] Remove deprecated command line options
Date: Thu, 18 Jan 2024 11:37:55 +0100
Message-ID: <20240118103759.130748-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The -no-hpet, -no-acpi, -async-teardown and -chroot options have been
deprecated for at least two releases, so it should be fine if we remove
them now.

v2:
 - Rework some more occurances of -no-acpi in the second patch (Markus)
 - Collected Reviewed-bys from v1
 - Drop the -singlestep patch since this is handled by Philippe's series:
   https://lore.kernel.org/qemu-devel/20240117151430.29235-1-philmd@linaro.org/

Thomas Huth (4):
  qemu-options: Remove the deprecated -no-hpet option
  qemu-options: Remove the deprecated -no-acpi option
  qemu-options: Remove the deprecated -async-teardown option
  qemu-options: Remove the deprecated -chroot option

 docs/about/deprecated.rst       | 22 -------------------
 docs/about/removed-features.rst | 23 ++++++++++++++++++++
 docs/specs/tpm.rst              |  4 ++--
 hw/i386/pc.c                    |  4 ++--
 system/vl.c                     | 19 -----------------
 qemu-options.hx                 | 38 ---------------------------------
 6 files changed, 27 insertions(+), 83 deletions(-)

-- 
2.43.0


