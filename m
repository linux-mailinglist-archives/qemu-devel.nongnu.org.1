Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A31980ACBF
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 20:12:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBgFr-0000jy-4Y; Fri, 08 Dec 2023 14:11:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1rBgFm-0000h4-Bp
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 14:11:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1rBgFb-0003el-Kw
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 14:11:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702062661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dQfV6LviLmnLOWvIHHdxc9m6pS5dYwlHHOW0whSlNbs=;
 b=WkE6VUCuTnRhjXBKOVll+WgLM5GLI+oe311YgqtdgZO4LWl4NaEYk06jUE60L0HoF4zSuT
 wzVLtQlRy/u6ohSc7GxqtZ+R1P4lv/XpDYUj9KRx0rX7/9c2Qbzp39yqYNCRvczFkQP5MI
 ioBZOfugcmY1pHKVMNDCY+XpwlK3mtk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-k844ebb0OB23C_5-AhuuGw-1; Fri,
 08 Dec 2023 14:09:38 -0500
X-MC-Unique: k844ebb0OB23C_5-AhuuGw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF95E2823F61;
 Fri,  8 Dec 2023 19:09:37 +0000 (UTC)
Received: from p1.localdomain.com (ovpn-114-104.gru2.redhat.com
 [10.97.114.104])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C9176112131D;
 Fri,  8 Dec 2023 19:09:34 +0000 (UTC)
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
Subject: [PATCH 05/10] tests/avocado: use more distinct names for assets
Date: Fri,  8 Dec 2023 14:09:06 -0500
Message-ID: <20231208190911.102879-6-crosa@redhat.com>
In-Reply-To: <20231208190911.102879-1-crosa@redhat.com>
References: <20231208190911.102879-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Avocado's asset system will deposit files in a cache organized either
by their original location (the URI) or by their names.  Because the
cache (and the "by_name" sub directory) is common across tests, it's a
good idea to make these names as distinct as possible.

This avoid name clashes, which makes future Avocado runs to attempt to
redownload the assets with the same name, but from the different
locations they actually are from.  This causes cache misses, extra
downloads, and possibly canceled tests.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/avocado/kvm_xen_guest.py  | 3 ++-
 tests/avocado/netdev-ethtool.py | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/avocado/kvm_xen_guest.py b/tests/avocado/kvm_xen_guest.py
index 5391283113..ec4052a1fe 100644
--- a/tests/avocado/kvm_xen_guest.py
+++ b/tests/avocado/kvm_xen_guest.py
@@ -40,7 +40,8 @@ def get_asset(self, name, sha1):
         url = base_url + name
         # use explicit name rather than failing to neatly parse the
         # URL into a unique one
-        return self.fetch_asset(name=name, locations=(url), asset_hash=sha1)
+        return self.fetch_asset(name=f"qemu-kvm-xen-guest-{name}",
+                                locations=(url), asset_hash=sha1)
 
     def common_vm_setup(self):
         # We also catch lack of KVM_XEN support if we fail to launch
diff --git a/tests/avocado/netdev-ethtool.py b/tests/avocado/netdev-ethtool.py
index 5f33288f81..462cf8de7d 100644
--- a/tests/avocado/netdev-ethtool.py
+++ b/tests/avocado/netdev-ethtool.py
@@ -27,7 +27,8 @@ def get_asset(self, name, sha1):
         url = base_url + name
         # use explicit name rather than failing to neatly parse the
         # URL into a unique one
-        return self.fetch_asset(name=name, locations=(url), asset_hash=sha1)
+        return self.fetch_asset(name=f"qemu-netdev-ethtool-{name}",
+                                locations=(url), asset_hash=sha1)
 
     def common_test_code(self, netdev, extra_args=None):
 
-- 
2.43.0


