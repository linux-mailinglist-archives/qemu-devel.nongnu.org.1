Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D0AAC9EBB
	for <lists+qemu-devel@lfdr.de>; Sun,  1 Jun 2025 15:59:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLjDu-0007LV-2w; Sun, 01 Jun 2025 09:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1uLjDX-0006jp-DE
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 09:59:18 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1uLjDV-00049F-Jj
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 09:59:15 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1748786340; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=UDNubuZo5NJ82thF9GvQo6onozGT7on5ctTU14xVikVx5ciK57tz2aiN7D/xhj6FRgw0GKi0hLATkiUbTQIwBTygZOy4nWlsRuSI+4sBedoqo0cZAjI3KV81QLhZ1ZMyW4WOjyFH9MX6rFqGdrPOJTreNe08LB3TlID3LGUz3e8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1748786340;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=XZxvv2pvNhsuqoHYTqLWQiYNutflBG2RZpLm3Sb0iMo=; 
 b=evE48BKW/L1ST7RZbRAaOyiP7MiLbBfbMRR5JOmXJZYxe0UbK1PK5B/L3OE9gGYPz+as/xuUNLHdjOy6d4dl+IvZYNw7bRgd2V7Q7ky9+xCeHvc/AQJIMozkZvNOrno8d6EoDdIHQUEJD/5xIY4RqRRZm00PXPHR7ofqKdPw/lw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1748786340; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=XZxvv2pvNhsuqoHYTqLWQiYNutflBG2RZpLm3Sb0iMo=;
 b=N/ch61nkeaXH0v2VZ7mn3XXti7GHHGcMHRX8MwNreJw5uunJC2YbeZrTFFD4St31
 YTcTYvtM8ATpJFGUddiRdMTwriq+ZMfzWtjl0rMmUqkhdkkqfCJTxpb+KlahsC4LJXI
 aMlIrDGkObuF8/mUOuzxVZiBDnsrcIXavxvnShMA=
Received: by mx.zohomail.com with SMTPS id 1748786337813771.1470401622207;
 Sun, 1 Jun 2025 06:58:57 -0700 (PDT)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@gmail.com>, Sergio Lopez Pascual <slp@redhat.com>
Subject: [PATCH v13 09/10] docs/system: virtio-gpu: Update Venus link
Date: Sun,  1 Jun 2025 16:57:08 +0300
Message-ID: <20250601135709.847395-10-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250601135709.847395-1-dmitry.osipenko@collabora.com>
References: <20250601135709.847395-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Change virtio-gpu Venus link, pointing it at the Mesa Venus
documentation instead of the protocol. The Mesa doc provides more
information and also has a link to the protocol.

Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 docs/system/devices/virtio-gpu.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/system/devices/virtio-gpu.rst b/docs/system/devices/virtio-gpu.rst
index f8963c1f13cf..ea3eb052df3c 100644
--- a/docs/system/devices/virtio-gpu.rst
+++ b/docs/system/devices/virtio-gpu.rst
@@ -81,7 +81,7 @@ of virtio-gpu host memory window. This is typically between 256M and 8G.
 .. parsed-literal::
     -device virtio-gpu-gl,hostmem=8G,blob=true,venus=true
 
-.. _venus: https://gitlab.freedesktop.org/virgl/venus-protocol/
+.. _venus: https://docs.mesa3d.org/drivers/venus.html
 
 DRM native context is supported since release of `virglrenderer`_ v1.0.0
 using `drm`_ protocol.  ``DRM`` virtio-gpu capability set ("capset") requires
-- 
2.49.0


