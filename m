Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9BA7EE65F
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 19:06:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3gkK-0002LW-7f; Thu, 16 Nov 2023 13:05:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r3gkH-0002Kv-Na
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 13:05:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r3gkG-00040V-0l
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 13:05:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700157938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+ruPnXfnYkgnqPOHxNYE+5bMTUEHSxvFb07H/goCRIQ=;
 b=gRT8J0VBfrJaHdvIrlcyp86/k9vW9cbp88Lie+enidhspWzGge/O2txpf8gGdgM8Q4FW5w
 QUKxGzX+qq7CIlWDaOItVRSjZ8P+yL3ysMceoxOAP9j26XmBQDoZxLeYkxwujagRsDcRGS
 HO02lXhHlQQHgRv8sCY0R6cM0ycMh8M=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-54z8h9dDMKeTBokwNWskzQ-1; Thu,
 16 Nov 2023 13:05:36 -0500
X-MC-Unique: 54z8h9dDMKeTBokwNWskzQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 82E111C0BA4A
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 18:05:36 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DCAE31121306;
 Thu, 16 Nov 2023 18:05:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 00/10] Avocado test fixes
Date: Thu, 16 Nov 2023 19:05:24 +0100
Message-ID: <20231116180534.566469-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The following changes since commit 34a5cb6d8434303c170230644b2a7c1d5781d197:

  Merge tag 'pull-tcg-20231114' of https://gitlab.com/rth7680/qemu into staging (2023-11-15 08:05:25 -0500)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2023-11-16

for you to fetch changes up to c4d74ab24a02c90b7a3240510b3dd4e1bec536dd:

  tests/avocado: Enable reverse_debugging.py tests in gitlab CI (2023-11-16 14:22:56 +0100)

----------------------------------------------------------------
* Fix the avocado tests for running with Python 3.12
* Add some asset hashes to silence warnings
* Fix the broken reverse_debugging test

----------------------------------------------------------------
Nicholas Piggin (2):
      tests/avocado: reverse_debugging drain console to prevent hang
      tests/avocado: Enable reverse_debugging.py tests in gitlab CI

Philippe Mathieu-Daudé (2):
      tests/avocado: Replace assertRegexpMatches() for Python 3.12 compatibility
      tests/avocado: Make fetch_asset() unconditionally require a crypto hash

Thomas Huth (6):
      tests/avocado: Replace assertEquals() for Python 3.12 compatibility
      tests/avocado/virtio-gpu: Fix test_vhost_user_vga_virgl for edid support
      tests/avocado/intel_iommu: Add asset hashes to avoid warnings
      tests/avocado/multiprocess: Add asset hashes to silence warnings
      tests/avocado/replay_kernel: Mark the test_x86_64_pc as flaky
      tests/avocado/mem-addr-space-check: Replace assertEquals() for Python 3.12

 docs/devel/testing.rst                  |  4 +-
 tests/avocado/avocado_qemu/__init__.py  |  2 +-
 tests/avocado/cpu_queries.py            |  2 +-
 tests/avocado/empty_cpu_model.py        |  2 +-
 tests/avocado/intel_iommu.py            |  6 +-
 tests/avocado/mem-addr-space-check.py   | 14 ++---
 tests/avocado/multiprocess.py           | 18 ++++--
 tests/avocado/pc_cpu_hotplug_props.py   |  2 +-
 tests/avocado/replay_kernel.py          |  3 +-
 tests/avocado/reverse_debugging.py      | 12 ++--
 tests/avocado/version.py                |  2 +-
 tests/avocado/virtio-gpu.py             |  6 +-
 tests/avocado/x86_cpu_model_versions.py | 97 +++++++++++++++++----------------
 13 files changed, 88 insertions(+), 82 deletions(-)


