Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0BA9AF5DC
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Oct 2024 01:36:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t47MN-0008IA-9C; Thu, 24 Oct 2024 19:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t47ML-0008HE-8G
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 19:35:17 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t47MJ-0002rZ-O2
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 19:35:17 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1729812904; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=X2frgcOnXSjBZZyiUJ4n+uzGqFa0WpD0d/TJ/LOHZCqpVA/m7nPGsGlLj5aEHde+uvFrDNiQ5DBigkr0aMxL3y3FtkShDoS9QMHHgeATUN+z0zFsNYvbGrmFXXp4/wjjZkwQlCFIZ6Jxzr5VahE5DNw+ATBLhTPDmzbMwnv0cYY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1729812904;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=YX8Cx3IAbZCZCZ5QLBTfQHwoqaPoB7M3PM5VoA7yqzk=; 
 b=GN4KZWUbH6o0frr5CKPxC16tUgVPUqjwmm/9C7bei8NJcqgY5lzC0E4QzlxKTVAe7HltbssVd3wtOxyDVIKOEe21ZsaXnSZOyL6IkqgpxtpmBTcf360JD+Vf9lGgCTzapQZf9+QAxPQTaNj5j03catyivjuD4ale6jS8MxdIej8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729812904; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=YX8Cx3IAbZCZCZ5QLBTfQHwoqaPoB7M3PM5VoA7yqzk=;
 b=iIeOnHGmQD9BYyqHLpdEgjRy1prWB8bZc/L8l2+lSVPbiuVltmQZmq/4JpTkpiG5
 69zH3t5FDGaDDRSV8j5O09RhV1gHB6SacylZ1ZrxuuMhuPbxEl7zzf8vu3jmlk9z72r
 UcVMht9tIaBHCQ5M5GfFS1jxazW0TgfivHQVEgys=
Received: by mx.zohomail.com with SMTPS id 17298129026091011.7865610905661;
 Thu, 24 Oct 2024 16:35:02 -0700 (PDT)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
Subject: [PATCH v3 1/6] ui/sdl2: Restore original context after new context
 creation
Date: Fri, 25 Oct 2024 02:33:49 +0300
Message-ID: <20241024233355.136867-2-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024233355.136867-1-dmitry.osipenko@collabora.com>
References: <20241024233355.136867-1-dmitry.osipenko@collabora.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

SDL API changes GL context to a newly created GL context, which differs
from other GL providers that don't switch context. Change SDL backend to
restore the original GL context. This allows Qemu's virtio-gpu to support
new virglrenderer async-fencing feature for Virgl contexts, otherwise
virglrenderer's vrend creates a fence-sync context on the Qemu's
main-loop thread that erroneously stays in-use by the main-loop after
creation, not allowing vrend's fence-sync thread switch to this new
context that belongs to it.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 ui/sdl2-gl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index e01d9ab0c7bf..b1fe96d6af22 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -168,6 +168,9 @@ QEMUGLContext sdl2_gl_create_context(DisplayGLCtx *dgc,
                             SDL_GL_CONTEXT_PROFILE_ES);
         ctx = SDL_GL_CreateContext(scon->real_window);
     }
+
+    SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
+
     return (QEMUGLContext)ctx;
 }
 
-- 
2.47.0


