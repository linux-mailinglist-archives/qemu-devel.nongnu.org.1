Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F05790801
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Sep 2023 15:01:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcQE9-0000w4-VH; Sat, 02 Sep 2023 08:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qcQE7-0000vP-N6
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 08:59:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qcQE5-0001fh-GJ
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 08:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693659582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6XZptx8cJZ8kcxWm2Gl48lmu/YCctk9KQrWCHxIcahU=;
 b=ZV5BhY92+ljWiXytD0rK7/Y4mcEqjO3xW0v97+fRWxDZEqfS55IbMyktkOApDwa6D7OSZq
 W7HEcMlJavFQJqQxKnu0hZdqxmgiVSBL6yXW4m7uh5g01/rRLuuSJ/yTPO/QgBPR7Ri3Gy
 uevZVZt7Mds88G6oz0M2zgW9WZV7GjY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-1WZzKfY8M3KSEnRH3JjmFg-1; Sat, 02 Sep 2023 08:59:39 -0400
X-MC-Unique: 1WZzKfY8M3KSEnRH3JjmFg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31aecb86dacso1532343f8f.1
 for <qemu-devel@nongnu.org>; Sat, 02 Sep 2023 05:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693659576; x=1694264376;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6XZptx8cJZ8kcxWm2Gl48lmu/YCctk9KQrWCHxIcahU=;
 b=Xf20yDF5CjHDAP07wBJIqb3ASDPsn1anZ88JZttRRoxg/KwerFHDn2gPv/9nHcb33Z
 7zaVigHsmqduy0SdSyEENVq8seJytzqKdIPJ/FgEFcX4zQ+bsfCYOqPpO6FQxNzUJvtP
 hxYLXyRhqZTYkzqGMcYTIIb7dWR/p/utFEsC5bSUTx382LdPGTC6cMZ/YRN9Tq7B3z2j
 250+tiSXcxNXjvn73Dy6bZNBRpf1h11m3kjl9OJtgJAiQCyHecUTxP7thEdmldMEKNw3
 7TH97n8Q0mGdeAJoNnVJ3eqe2s1NzX8C4MIMScHFGmiJRh+AvBqOTzbBIs6sVGZdxn0h
 Z9Jg==
X-Gm-Message-State: AOJu0Ywv9bHUiDAkFeQe7jUtD3aHCYLObG4WYPg42wsF+T9t0JANlBUr
 +nUlPrRBDUTwbZE2S3yzEmP3HPjo973Ixo9CWoF3lAGiV/9qIdqookn6ZksLOmTXVK0b0JZy6AO
 r48xkM7cUKWhjpev+xesyvi/WheSakq+TQOXZ6cya5j3KbKkNDWNF+F/iwquwvew+qmmbSeFugF
 0=
X-Received: by 2002:a5d:4b46:0:b0:317:67bf:337f with SMTP id
 w6-20020a5d4b46000000b0031767bf337fmr3691394wrs.2.1693659576749; 
 Sat, 02 Sep 2023 05:59:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEK0b3gFfmyRS5zdRhey2ZUL0CBhO0NSnzPYNDle1JaAF9xKvPDkp0szrOD3VmT2iRKPfQRgg==
X-Received: by 2002:a5d:4b46:0:b0:317:67bf:337f with SMTP id
 w6-20020a5d4b46000000b0031767bf337fmr3691385wrs.2.1693659576261; 
 Sat, 02 Sep 2023 05:59:36 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 a28-20020a5d457c000000b00317f70240afsm8493735wrc.27.2023.09.02.05.59.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 05:59:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/15] configure cleanups for QEMU 8.2
Date: Sat,  2 Sep 2023 14:59:19 +0200
Message-ID: <20230902125934.113017-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This includes a few more patches cleaning up the configure/meson
separation.  The highlights are fixing --host-cc, removing the last
traces of compiler detection from config-host.mak, and dropping the
useless pc-bios/Makefile.

Compared to v1, I have also removed the loop that takes random CONFIG_*
lines of config-host.mak and shoves them into config-host.h.  These were
the last remains of the old scripts/create_config logic, but they are not
needed anymore because all config-host.h tests are done in meson.build or
come from meson-level options.  We're definitely getting into diminishing
returns land (which is a good thing), but I believe it's worth having a
few extra patches to further reduce the coupling between config-host.mak
and meson.build.

To be honest, the plugin code would probably be a lot simpler if
contrib/plugins/Makefile was turned into a meson.build file.  As things
stand, the "are plugins enabled?" logic has to stay in configure, in order
to decide whether to build contrib/plugins.  However, contrib/plugins
was left as a separate build process for demonstration purposes, so I
am not going to change that.  If desired, this can be changed in the
future (together with moving all the $plugins logic from configure
to meson.build).  Perhaps the "external project" module from Meson
could be used too, but right now it is limited to projects with
a "configure" phase.

Paolo

Paolo Bonzini (15):
  meson: do not unnecessarily use cmake for dependencies
  meson: update unsupported host/CPU messages
  configure: remove HOST_CC
  configure: create native file with contents of $host_cc
  meson: compile bundled device trees
  configure: remove boolean variables for targets
  configure: move --enable-debug-tcg to meson
  meson: test for CONFIG_TCG in config_all
  contrib/plugins: use an independent makefile
  configure: unify recursion into sub-Makefiles
  configure, meson: move --enable-plugins to meson
  configure, meson: remove CONFIG_SOLARIS from config-host.mak
  configure, meson: remove target OS symbols from config-host.mak
  meson: list leftover CONFIG_* symbols
  configure: remove dead code

 Makefile                                  |  29 +++--
 accel/tcg/meson.build                     |   4 +-
 chardev/meson.build                       |   2 +-
 configure                                 | 125 ++++++----------------
 contrib/plugins/Makefile                  |  18 ++--
 docs/devel/build-system.rst               |   8 +-
 docs/devel/kconfig.rst                    |   2 +-
 gdbstub/meson.build                       |   4 +-
 meson.build                               | 106 ++++++++++--------
 meson_options.txt                         |   4 +
 net/meson.build                           |  18 ++--
 pc-bios/Makefile                          |  19 ----
 pc-bios/meson.build                       |  25 ++++-
 plugins/meson.build                       |  12 ++-
 qga/meson.build                           |   4 +-
 scripts/meson-buildoptions.sh             |   6 ++
 storage-daemon/meson.build                |   2 +-
 tcg/meson.build                           |   2 +-
 tests/Makefile.include                    |   2 +-
 tests/meson.build                         |   8 +-
 tests/migration/meson.build               |   2 +-
 tests/qtest/meson.build                   |  18 ++--
 tests/tcg/tricore/Makefile.softmmu-target |   2 +-
 tests/unit/meson.build                    |   6 +-
 24 files changed, 198 insertions(+), 230 deletions(-)
 delete mode 100644 pc-bios/Makefile

-- 
2.41.0


