Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBB980ACC2
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 20:12:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBgFu-0000mu-ES; Fri, 08 Dec 2023 14:11:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1rBgFm-0000h6-Bt
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 14:11:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1rBgFb-0003eP-Kk
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 14:11:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702062660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=adJH7rWy3zq1h4h/lqGpwZ7Vbw0iyk9j/MLUkacF4c0=;
 b=RCqoJGJUHZH9G2IDxgBIT04yUgyR4VUAAopgAG2hqUCf57/mdl2XgII7v8gh/VUIErL2ii
 ESfd58YioIN2FJFr2zNrtc7HFhZCzn93JRKHn1wkrlRSX+fJ+K8YbiTouZRBo7xBQG6tZj
 r2VXEcWtcu1S5OTVTAghVq8By4iE5gM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-heyNTEq2N5q3V0XwSXHsjw-1; Fri, 08 Dec 2023 14:09:24 -0500
X-MC-Unique: heyNTEq2N5q3V0XwSXHsjw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3DB81101A52A;
 Fri,  8 Dec 2023 19:09:21 +0000 (UTC)
Received: from p1.localdomain.com (ovpn-114-104.gru2.redhat.com
 [10.97.114.104])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E7D25112131D;
 Fri,  8 Dec 2023 19:09:17 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Paul Durrant <paul@xen.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvm@vger.kernel.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 00/10] for-8.3 tests/avocado: prep for Avocado 103.0 LTS
Date: Fri,  8 Dec 2023 14:09:01 -0500
Message-ID: <20231208190911.102879-1-crosa@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is a collection of improvements to a number of Avocado based
tests, but also fixes that will allow them to behave properly under
Avocado's upcoming new Long Term Stability release (LTS) version
103.0.

A pipeline with (pretty much) these changes can be seen at:
  - https://gitlab.com/cleber.gnu/qemu/-/pipelines/1096168899

While a pipeline with the Avocado version bump (using a preview of the
103.0 release) can be seen at:
  - https://gitlab.com/cleber.gnu/qemu/-/pipelines/1099488480

Once Avocado officially releases 103.0 LTS, which is expected to take
no longer than 2 weeks (after a huge development window), the actual
version bump will be posted, along with more profound changes to the
tests to leverage the new features.

Cleber Rosa (10):
  tests/avocado: mips: fallback to HTTP given certificate expiration
  tests/avocado: mips: add hint for fetchasset plugin
  tests/avocado/intel_iommu.py: increase timeout
  tests/avocado: machine aarch64: standardize location and RO/RW access
  tests/avocado: use more distinct names for assets
  tests/avocado/kvm_xen_guest.py: cope with asset RW requirements
  testa/avocado: test_arm_emcraft_sf2: handle RW requirements for asset
  tests/avocado/boot_xen.py: merge base classes
  tests/avocado/boot_xen.py: unify tags
  tests/avocado/boot_xen.py: use class attribute

 tests/avocado/boot_linux_console.py      | 27 +++++++++++++++----
 tests/avocado/boot_xen.py                | 34 +++++-------------------
 tests/avocado/intel_iommu.py             |  2 ++
 tests/avocado/kvm_xen_guest.py           | 30 ++++++++++++++-------
 tests/avocado/machine_aarch64_sbsaref.py |  9 +++++--
 tests/avocado/machine_aarch64_virt.py    | 14 +++++-----
 tests/avocado/netdev-ethtool.py          |  3 ++-
 7 files changed, 67 insertions(+), 52 deletions(-)

-- 
2.43.0


