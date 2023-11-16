Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF53A7EE142
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 14:15:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3cD7-0000Lq-I9; Thu, 16 Nov 2023 08:15:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r3cD5-0000L0-QE
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 08:15:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r3cD2-0002MK-TW
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 08:15:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700140503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=snw9xEK0v7SZldty7P6Pm+UZKNzNQ4TzJt6o9iZnLqQ=;
 b=RSvPOSL/9vCMeeNRhPzHF0PAyNMBZnrIx6VOWDklPp36OC28acd7NmfVtt9F+xNh9QtOd0
 wgMGPTimNmKWlpIN7ylcIPlNH28nvOZfvjOBORInu2NgccMn82J0tU7qoUhHF+3aWEy+Ct
 QmdvPtM3sreeA/mVLKjcWgi6FX5YU7I=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-ZzT34rk3MZyQzgosbFQGdQ-1; Thu,
 16 Nov 2023 08:14:59 -0500
X-MC-Unique: ZzT34rk3MZyQzgosbFQGdQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E3963C2364F;
 Thu, 16 Nov 2023 13:14:59 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 31B701C060B0;
 Thu, 16 Nov 2023 13:14:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 0/5] Limit type names to alphanumerical and some few
 special characters
Date: Thu, 16 Nov 2023 14:14:49 +0100
Message-ID: <20231116131454.541434-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_FILL_THIS_FORM_SHORT=0.01,
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

QOM names currently don't have any enforced naming rules. This
can be problematic, e.g. when they are used on the command line
for the "-device" option (where the comma is used to separate
properties). To avoid that such problematic type names come in
again, let's restrict the set of acceptable characters during the
type registration.

First four patches are clean-ups related to comma and colons
in type names, and the final patch introduces the check for
valid names.

v2:
- Include Markus' patches in the series
- Add patches to clean up colons in type names
- Add the check to type_register_internal() instead of type_new()
  so that we can disallow colons, too
- Only allow '+' in legacy names

Markus Armbruster (2):
  docs/system/arm: Fix for rename of type "xlnx.bbram-ctrl"
  hw: Replace anti-social QOM type names (again)

Thomas Huth (3):
  memory: Remove "qemu:" prefix from the "qemu:ram-discard-manager" type
    name
  tests/unit/test-io-task: Rename "qemu:dummy" to avoid colon in the
    name
  qom/object: Limit type names to alphanumerical and some few special
    characters

 docs/system/arm/xlnx-versal-virt.rst     |  4 +--
 include/exec/memory.h                    |  2 +-
 include/hw/misc/xlnx-versal-cframe-reg.h |  2 +-
 include/hw/misc/xlnx-versal-cfu.h        |  6 ++--
 include/hw/misc/xlnx-versal-crl.h        |  2 +-
 include/hw/nvram/xlnx-efuse.h            |  2 +-
 include/hw/nvram/xlnx-versal-efuse.h     |  4 +--
 include/hw/nvram/xlnx-zynqmp-efuse.h     |  2 +-
 qom/object.c                             | 41 ++++++++++++++++++++++++
 tests/unit/test-io-task.c                |  2 +-
 10 files changed, 54 insertions(+), 13 deletions(-)

-- 
2.41.0


