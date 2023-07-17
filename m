Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41904756311
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 14:47:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLNcB-0005af-RM; Mon, 17 Jul 2023 08:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qLNbx-0005Uv-KW
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:46:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qLNbu-0008DS-Kz
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689597953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LU6ZbyBfVXm9DqvO2MdKg/dnr9icpjpYHCcN5yv3smE=;
 b=Kgpxc5Blp3cZzasNSeOsW3Pp1+tLujRz7BM1jZU9uWSyBsPPzKnM209s0aM1HSKGli8UuQ
 e8RLagoAcxjDaOnsbbw8cKN/jI8ZON62H7vT6sIidHRAio7VQK0yxqsEDjDON2NJ2MyfVE
 CL3bZQsJ/4BH5uT4WM/xy0N3dYNHFWg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-322-qu9wyEjpPMiBNKim705RVw-1; Mon, 17 Jul 2023 08:45:49 -0400
X-MC-Unique: qu9wyEjpPMiBNKim705RVw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D3948966C2;
 Mon, 17 Jul 2023 12:45:49 +0000 (UTC)
Received: from localhost (unknown [10.39.208.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD6661121318;
 Mon, 17 Jul 2023 12:45:47 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, richard.henderson@linaro.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: [PULL 00/19] UI & audio patches
Date: Mon, 17 Jul 2023 16:45:25 +0400
Message-ID: <20230717124545.177236-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The following changes since commit ed8ad9728a9c0eec34db9dff61dfa2f1dd625637:

  Merge tag 'pull-tpm-2023-07-14-1' of https://github.com/stefanberger/qemu-tpm into staging (2023-07-15 14:54:04 +0100)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request

for you to fetch changes up to 92f69a2c9bca26ee756c7cb932142664aca9c9c6:

  audio/pw: improve channel position code (2023-07-17 15:23:31 +0400)

----------------------------------------------------------------
ui & audio fixes for 8.1

----------------------------------------------------------------

Dongwon Kim (5):
  ui/gtk: Make sure the right EGL context is currently bound
  virtio-gpu: replace the surface with null surface when resetting
  virtio-gpu-udmabuf: correct naming of QemuDmaBuf size properties
  ui/gtk: set scanout-mode right before scheduling draw
  ui/gtk: skip refresh if new dmabuf has been submitted

Marc-André Lureau (13):
  virtio-gpu: fix potential divide-by-zero regression
  libvirt-ci: update submodule to cover pipewire
  tests/lcitool: add pipewire
  audio/pw: Pipewire->PipeWire case fix for user-visible text
  audio/pw: drop needless case statement
  audio/pw: needless check for NULL
  audio/pw: trace during init before calling pipewire API
  audio/pw: add more details on error
  audio/pw: factorize some common code
  audio/pw: add more error reporting
  audio/pw: simplify error reporting in stream creation
  audio/pw: remove wrong comment
  audio/pw: improve channel position code

Mauro Matteo Cascella (1):
  ui/vnc-clipboard: fix infinite loop in inflate_buffer (CVE-2023-3255)

 meson.build                                   |   2 +-
 qapi/audio.json                               |  12 +-
 include/ui/console.h                          |   4 +-
 audio/pwaudio.c                               | 212 +++++++-----------
 hw/display/virtio-gpu-udmabuf.c               |  12 +-
 hw/display/virtio-gpu.c                       |  21 +-
 ui/console.c                                  |  11 +-
 ui/dbus-listener.c                            |   8 +-
 ui/egl-helpers.c                              |   8 +-
 ui/gtk-egl.c                                  |  20 +-
 ui/gtk-gl-area.c                              |  15 +-
 ui/vnc-clipboard.c                            |  10 +-
 audio/trace-events                            |   2 +-
 meson_options.txt                             |   2 +-
 qemu-options.hx                               |   4 +-
 scripts/meson-buildoptions.sh                 |   2 +-
 tests/docker/dockerfiles/alpine.docker        |   1 +
 tests/docker/dockerfiles/centos8.docker       |   1 +
 .../dockerfiles/debian-amd64-cross.docker     |   1 +
 tests/docker/dockerfiles/debian-amd64.docker  |   1 +
 .../dockerfiles/debian-arm64-cross.docker     |   1 +
 .../dockerfiles/debian-armel-cross.docker     |   1 +
 .../dockerfiles/debian-armhf-cross.docker     |   1 +
 .../dockerfiles/debian-mips64el-cross.docker  |   1 +
 .../dockerfiles/debian-mipsel-cross.docker    |   1 +
 .../dockerfiles/debian-ppc64el-cross.docker   |   1 +
 .../dockerfiles/debian-s390x-cross.docker     |   1 +
 tests/docker/dockerfiles/fedora.docker        |   1 +
 tests/docker/dockerfiles/opensuse-leap.docker |   1 +
 tests/docker/dockerfiles/ubuntu2204.docker    |   1 +
 tests/lcitool/libvirt-ci                      |   2 +-
 tests/lcitool/projects/qemu.yml               |   1 +
 32 files changed, 171 insertions(+), 191 deletions(-)

-- 
2.41.0


