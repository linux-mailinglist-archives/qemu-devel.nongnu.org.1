Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A57BA857DBC
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Feb 2024 14:33:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rayKg-0008Bz-08; Fri, 16 Feb 2024 08:32:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rayJl-00080u-5p
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:31:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rayJh-00069N-JX
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:31:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708090307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QV3xLt3tq3Hji6mN2kzVKFMZcajAGamk5W0ilCetoNQ=;
 b=CuxIM6WI6Oq9zIoj/xYfyTgzjKQhf2DvVRv/Tm2Kx7sJ9ANNoxBMKvehLzJHQHRBg/KuR+
 bEYzF6LoPsEoEQWUl2J1i6blWNin4GFGNSIy8qrhZsLAArtGDRot0HA8HnSFWcTrCQZTOd
 40aPZij/THxpsv0NsK451gnwdMIdFgo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-0f8FlRPNPdKLUrpEEojmSA-1; Fri,
 16 Feb 2024 08:31:46 -0500
X-MC-Unique: 0f8FlRPNPdKLUrpEEojmSA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF38A3C100AD;
 Fri, 16 Feb 2024 13:31:45 +0000 (UTC)
Received: from localhost (unknown [10.39.208.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B9C512166B4F;
 Fri, 16 Feb 2024 13:31:43 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 0/7] Ui patches
Date: Fri, 16 Feb 2024 17:31:33 +0400
Message-ID: <20240216133140.3611100-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.364,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 3ff11e4dcabe2b5b4c26e49d741018ec326f127f:

  Merge tag 'pull-target-arm-20240215' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-02-15 17:36:30 +0000)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request

for you to fetch changes up to 186acfbaf7f325833702f50f75ef5116dc29e233:

  tests/qtest: Depend on dbus_display1_dep (2024-02-16 17:27:22 +0400)

----------------------------------------------------------------
UI-related fixes

----------------------------------------------------------------

Akihiko Odaki (3):
  audio: Depend on dbus_display1_dep
  meson: Explicitly specify dbus-display1.h dependency
  tests/qtest: Depend on dbus_display1_dep

Daniel P. Berrangé (1):
  ui: reject extended clipboard message if not activated

Fiona Ebner (2):
  ui/clipboard: mark type as not available when there is no data
  ui/clipboard: add asserts for update and request

Tianlan Zhou (1):
  ui/console: Fix console resize with placeholder surface

 ui/clipboard.c          | 26 +++++++++++++++++++++++---
 ui/console.c            |  2 +-
 ui/vnc.c                |  5 +++++
 audio/meson.build       |  3 ++-
 tests/qtest/meson.build |  2 +-
 ui/meson.build          |  2 +-
 6 files changed, 33 insertions(+), 7 deletions(-)

-- 
2.43.1


