Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5F57A924F
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 09:55:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjEWK-0004UJ-0f; Thu, 21 Sep 2023 03:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjEWI-0004Tv-IK
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:54:42 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjEWG-0001LO-3S
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:54:42 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c5c91bec75so5058305ad.3
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 00:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1695282878; x=1695887678;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BOo7b3FJ14Y9XII2qqVrV2x7lRNTy3o3AMA2DumSWUY=;
 b=3LOAxqZ3WdslmfVya4kfZTES4d/iN5XpunNJBfQNkx1xe7Wruv6J7HTaaF+YoOamqB
 CZM/JrZP1Bnh0MtQXFx0xmpeg+5G2iNGRpRLIyEydd2yLxB7O7uLkJsJUwFtKCF1kWFP
 tJLSRk0f6bGpgCkOI4/MGV+KTwD7PTlfWQe79lkgQtsTJLLQ1NGRC24z/DPwGd6Fd8g5
 EvFiPmcN4Z0D5hGBlhXzxmYML0C31q/+dFEti9OPXb29A3+CYAmOzJUIlil2Y7kjILFc
 rs8ntt6BHI+X+OLFFfae/fQHyOb2XE6Wdf4gD+PyGErtYWU8eed0oxMhT5e/CsPZ3evE
 /vGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695282878; x=1695887678;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BOo7b3FJ14Y9XII2qqVrV2x7lRNTy3o3AMA2DumSWUY=;
 b=Xs3N3Xu30+WtVGWe1ErlcTuQptpHv8ZYSjvFjPS46GK6v40Tbhs/meNMyeGBe5hCSO
 XrREA/j6aHKoBvI67RgmZDL4Eduw2mmuUpTOoX3HNW/LG5Wk3B2DJ4JDvEBN4kOn676Q
 DQP76BFd7/1WI6R1x3UdxjCVEmckpkvCYu/E+94YnZd5x8Ht6esuoGoAiJlNZOcgXR7x
 CTm9f7FrfeAhO2qq82WeDyKt93jQxrSRkeAgw+ncyIXtiypd3jPJUofjXzZbG6vAWurq
 U0j0fkAA+TGAP3qYhFCj1XST4Og1beTMt1RobHTZk8oY285+yVFUGWzzXU88wrO287qO
 8+Bg==
X-Gm-Message-State: AOJu0YyT+Xxm6sd42h035YqhoDFPi9oQWAYmJM7j6v6j0akYLZ0vrn9u
 dh1SpC67ugWcHiTW2xmfsNjeejvBvOAMkmWJCew=
X-Google-Smtp-Source: AGHT+IFNd3uNlYrMPUWFVmvjhR9pLZWZKNMDaAqv63rUsSpuINKA+mDt58BlAOWZFTEe+2nvrqqL9Q==
X-Received: by 2002:a17:902:db0b:b0:1c3:749f:6a5d with SMTP id
 m11-20020a170902db0b00b001c3749f6a5dmr5767763plx.4.1695282878140; 
 Thu, 21 Sep 2023 00:54:38 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:a840:1e00:d54:e521:8bac:7bed])
 by smtp.gmail.com with ESMTPSA id
 p22-20020a170902a41600b001ae0152d280sm761928plq.193.2023.09.21.00.54.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 00:54:37 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, virtio-fs@redhat.com,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Yan Vugenfirer <yan@daynix.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 0/8] util: Introduce qemu_get_runtime_dir()
Date: Thu, 21 Sep 2023 16:54:14 +0900
Message-ID: <20230921075425.16738-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

qemu_get_runtime_dir() returns a dynamically allocated directory path
that is appropriate for storing runtime files. It corresponds to "run"
directory in Unix.

With a tree-wide search, it was found that there are several cases
where such a functionality is implemented so let's have one as a common
utlity function.

A notable feature of qemu_get_runtime_dir() is that it uses
$XDG_RUNTIME_DIR if available. While the function is often called by
executables which requires root privileges, it is still possible that
they are called from a user without privilege to write the system
runtime directory. In fact, I decided to write this patch when I ran
virtiofsd in a Linux namespace created by a normal user and realized
it tries to write the system runtime directory, not writable in this
case. $XDG_RUNTIME_DIR should provide a writable directory in such
cases.

This function does not use qemu_get_local_state_dir() or its logic
for Windows. Actually the implementation of qemu_get_local_state_dir()
for Windows seems not right as it calls g_get_system_data_dirs(),
which refers to $XDG_DATA_DIRS. In Unix terminology, it is basically
"/usr/share", not "/var", which qemu_get_local_state_dir() is intended
to provide. Instead, this function try to use the following in order:
- $XDG_RUNTIME_DIR
- LocalAppData folder
- get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR "/run")

This function does not use g_get_user_runtime_dir() either as it
falls back to g_get_user_cache_dir() when $XDG_DATA_DIRS is not
available. In the case, we rather use:
get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR "/run")

V2 -> V3:
  Rebase to the current master.
  Dropped patch "qga: Remove platform GUID definitions" since it is
  irrelevant.

V1 -> V2:
  Rebased to the current master since Patchew complains.

Akihiko Odaki (8):
  util: Introduce qemu_get_runtime_dir()
  ivshmem-server: Use qemu_get_runtime_dir()
  contrib/rdmacm-mux: Use qemu_get_runtime_dir()
  qga: Use qemu_get_runtime_dir()
  scsi: Use qemu_get_runtime_dir()
  module: Use qemu_get_runtime_dir()
  util: Remove qemu_get_local_state_dir()
  spice-app: Use qemu_get_runtime_dir()

 include/qemu/osdep.h           | 10 +++++++---
 contrib/ivshmem-server/main.c  | 20 ++++++++++++++++----
 contrib/rdmacm-mux/main.c      | 22 ++++++++++++++--------
 qga/main.c                     |  9 ++++-----
 scsi/qemu-pr-helper.c          |  6 +++---
 ui/spice-app.c                 |  4 ++--
 util/module.c                  |  3 ++-
 util/oslib-posix.c             |  9 +++++++--
 util/oslib-win32.c             | 24 ++++++++++++++++++++----
 contrib/rdmacm-mux/meson.build |  2 +-
 10 files changed, 76 insertions(+), 33 deletions(-)

-- 
2.41.0


