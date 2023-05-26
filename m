Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1547712A31
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 18:09:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Zzf-0004EO-S4; Fri, 26 May 2023 12:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2ZzY-0004BH-60
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:08:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2ZzV-0002cp-9I
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685117311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=heH7PN+Wll92+Kt+nYX5oJMV6/TOFRg0eKlE9VU+xTk=;
 b=TJyWrQKt8W0O55DnWGhjtWHrTcsizdiOkdqug/1fMGpxV6FaQK1ruuTkow3BJziUL9mELT
 4dpOcpPYKkhJ7WZGD1vkV2IoiE6HI7JTyNljKInvtHPyybnaycXe45TMQT38XZY0cbddUZ
 bu5NDjIgIr//4mgtwCxvs0nOTdlciSo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-BkStxQExOrq78QxZEY-zBg-1; Fri, 26 May 2023 12:08:29 -0400
X-MC-Unique: BkStxQExOrq78QxZEY-zBg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-94f7a2b21fdso114416966b.2
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 09:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685117307; x=1687709307;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=heH7PN+Wll92+Kt+nYX5oJMV6/TOFRg0eKlE9VU+xTk=;
 b=Z2ywYDc52GOTinjycQY87yIxSjMRMazcCjBCLzwzw/+0G8oBFFjFWxrLmtPzkxj2wp
 OCxzWRG40nAysW3seHqsDWmgZLG9gO8m/f4K3+mFFG6o73NZ7c0Y+J1p6ghtg5VlOSMC
 /uBrKUbPyV4EjZeJhe84JVLGeqhZMi2w46rqTpKH5WaXdWT9xnfBVdam9oBYF24gfcYI
 2zo2coo4EJ3enxIywB1lWe7Kaimz4xdiIGea7W1vSrFOHKBLh5JIO16dI/GvWmQqW7i1
 L/dEqqHMUlIXEYp/Sk6Ruo5YuSCsF7UlQN+TQUAahBnjxZqUKZj8pHEkh4Cjd1MR+Xzj
 GkCg==
X-Gm-Message-State: AC+VfDyJjL4FkFti72nvu157DFujnU53x7zvyr2pOyn9KC+M4NLGy0rk
 q3V+b2Nk7wIM6pTQoccxwMR4+SimtkRj+cX3KSAiVSPBoKwcILqS82vu/25VVNzdQp5Mk789Y5+
 Qkg4COImYbhtU4ggRiUIJmz6YHNvuftZ6RX59alYIafAYxy8ipHOPzq2EXQCb15ebLrvhlG9h07
 Y=
X-Received: by 2002:a17:907:368a:b0:96f:f046:9a92 with SMTP id
 bi10-20020a170907368a00b0096ff0469a92mr2560331ejc.37.1685117306913; 
 Fri, 26 May 2023 09:08:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5lFxF7U3mKGZ3IXpbIRmRE5yJXqgUOwgnXmQ88PBpbovNOPKf4dSbDMqK4uKqVortvLplZ2Q==
X-Received: by 2002:a17:907:368a:b0:96f:f046:9a92 with SMTP id
 bi10-20020a170907368a00b0096ff0469a92mr2560307ejc.37.1685117306469; 
 Fri, 26 May 2023 09:08:26 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 s20-20020a1709066c9400b0094ee3e4c934sm2331408ejr.221.2023.05.26.09.08.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 09:08:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/12] (Mostly) build system patches for 2023-05-26
Date: Fri, 26 May 2023 18:08:12 +0200
Message-Id: <20230526160824.655279-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The following changes since commit a3cb6d5004ff638aefe686ecd540718a793bd1b1:

  Merge tag 'pull-tcg-20230525' of https://gitlab.com/rth7680/qemu into staging (2023-05-25 11:11:52 -0700)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to b17bbf835c8998e93fd99b06164f1d63843fe8c9:

  configure: ignore --make (2023-05-26 12:36:20 +0200)

----------------------------------------------------------------
* build system fixes and cleanups
* use subproject() for the dtc and keycodemapdb submodules
* fix virtio memory leak
* update slirp.wrap to latest commit in the master branch

----------------------------------------------------------------
Fabiano Rosas (2):
      meson: Remove leftover comment
      meson: Add static glib dependency for initrd-stress.img

Paolo Bonzini (10):
      tests/docker: simplify HOST_ARCH definition
      tests/vm: fix and simplify HOST_ARCH definition
      Makefile: remove $(TESTS_PYTHON)
      configure: unset harmful environment variables
      slirp: update wrap to latest master
      virtio: qmp: fix memory leak
      meson: simplify logic for -Dfdt
      meson: use subproject for internal libfdt
      meson: use subproject for keycodemapdb
      configure: ignore --make

 .gitmodules                      |  8 +++---
 configure                        | 29 +++++----------------
 hw/virtio/virtio-qmp.c           | 11 ++++----
 meson.build                      | 54 ++++++++++++++--------------------------
 scripts/archive-source.sh        |  2 +-
 dtc => subprojects/dtc           |  0
 {ui => subprojects}/keycodemapdb |  0
 subprojects/slirp.wrap           |  2 +-
 tests/Makefile.include           |  8 +++---
 tests/docker/Makefile.include    |  2 +-
 tests/migration/meson.build      |  4 ++-
 tests/vm/Makefile.include        |  7 +++---
 ui/meson.build                   |  8 +++---
 13 files changed, 50 insertions(+), 85 deletions(-)
 rename dtc => subprojects/dtc (100%)
 rename {ui => subprojects}/keycodemapdb (100%)
-- 
2.40.1


