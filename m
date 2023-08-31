Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B00D278E6D0
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 08:53:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbbXE-0004Op-81; Thu, 31 Aug 2023 02:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qbbXC-0004OT-L0
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 02:52:06 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qbbX9-0005W5-LD
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 02:52:06 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fee5ddc23eso4088915e9.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 23:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1693464722; x=1694069522;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aqfDa6aQdXGL2qWS8LE7jqMmS8rSVujIeOcDBwh8doU=;
 b=wpXnbdkj+RUdHS8fqPq6/Tx9sK85SZ9gjbtut1fza6sRty2ARAtZZ5Hbzu2Fo4bLGQ
 MeY7HdI3mbZO7LzGYisnxj7fPvlgAQh/kAZOVuYdcbSGjLcB08LZ1YVgIJ0MV1P72yEY
 7m8dw8ECeu125J5CmkgrbVWKwdkP8AyA/K8DerggPG7jNel8THvRGSZSXFSfVrmNGNI7
 FQu52rfUUSb7ztPaLlHQvU85ufD16Uzb4yHo8FCawlGm/PSPNf6y+JyKnAHOvWq7O3JV
 RopF6kOT8qvXSNzXvqAvsEGPJD8bxa429qCRq6v6xucqlqMKkCifBInWoCLaF+IAnNvT
 7Y2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693464722; x=1694069522;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aqfDa6aQdXGL2qWS8LE7jqMmS8rSVujIeOcDBwh8doU=;
 b=PuFDP5wVV+rjo2EkShKvD7iCvrsufg8Tf/f9i+luBakT6ll/9nrloKyePuO/NLO8pA
 0bVvPQakaBUjxyeNEOYx+2gJrwuBkOpa9RoMNEdNwjwBt0I9soVEMcUXjQFzfIcDfGRC
 exStN/jiODDnWVDvSclMRHByrHZGpcou+7ZCs32azJlKiZJ9HCf82/8UXaPXU0vLoLrH
 4YZI/V9m5Qk7wBMpIEa098fYR92AHglnqjiNhd5yQ6/XekxhWCXirQnBpCnTCs85z0jK
 ivpCjKXmeZftcZY3/p9H2WhbyLex/MIFQ1qPskDL/jk+hhllK3f71rSlonAlOmBvsrtA
 ae2g==
X-Gm-Message-State: AOJu0YyEkEdvcNnjls29h64aDXIoJfvi5sEabNKAT5OW0GGpP9g8vGSw
 S1xcfb+YQ9+HFS0mzpJLBFsLgA==
X-Google-Smtp-Source: AGHT+IGVzoScJVNunJWEnjfv2msd+mcY+Lxz68kZqZ25x/GudYVBMPrEG6mBf3S4bV4aZ+fMmq8o+w==
X-Received: by 2002:a7b:cd88:0:b0:3fe:34c2:654b with SMTP id
 y8-20020a7bcd88000000b003fe34c2654bmr3243531wmj.14.1693464721488; 
 Wed, 30 Aug 2023 23:52:01 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id
 hn8-20020a05600ca38800b003fee6e170f9sm969010wmb.45.2023.08.30.23.52.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 23:52:01 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org, berrange@redhat.com
Cc: yuri.benditovich@daynix.com,
	yan@daynix.com
Subject: [PATCH v7 0/5] eBPF RSS through QMP support.
Date: Thu, 31 Aug 2023 09:51:35 +0300
Message-Id: <20230831065140.496485-1-andrew@daynix.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::32a;
 envelope-from=andrew@daynix.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This series of patches provides the ability to retrieve eBPF program
through qmp, so management application may load bpf blob with proper capabilities.
Now, virtio-net devices can accept eBPF programs and maps through properties
as external file descriptors. Access to the eBPF map is direct through mmap()
call, so it should not require additional capabilities to bpf* calls.
eBPF file descriptors can be passed to QEMU from parent process or by unix
socket with sendfd() qmp command.

Possible solution for libvirt may look like this: https://github.com/daynix/libvirt/tree/RSS_eBPF (WIP)

Changes since v6:
 * added comments to ebpf.json
 * added libbpf version requirements to meson script with BPF_F_MMAPABLE check 

Changes since v5:
 * refactored ebpf.json

Changes since v4:
 * refactored commit hunks
 * added explicit BPF_F_MMAPABLE declaration

Changes since v3:
 * fixed issue with the build if bpf disabled
 * rebased to the last master
 * refactored according to review

Changes since v2:
 * moved/refactored QMP command
 * refactored virtio-net

Changes since v1:
 * refactored virtio-net
 * moved hunks for ebpf mmap()
 * added qmp enum for eBPF id.

Andrew Melnychenko (5):
  ebpf: Added eBPF map update through mmap.
  ebpf: Added eBPF initialization by fds.
  virtio-net: Added property to load eBPF RSS with fds.
  qmp: Added new command to retrieve eBPF blob.
  ebpf: Updated eBPF program and skeleton.

 ebpf/ebpf.c                    |   70 ++
 ebpf/ebpf.h                    |   31 +
 ebpf/ebpf_rss-stub.c           |    6 +
 ebpf/ebpf_rss.c                |  150 +++-
 ebpf/ebpf_rss.h                |   10 +
 ebpf/meson.build               |    2 +-
 ebpf/rss.bpf.skeleton.h        | 1460 ++++++++++++++++----------------
 hw/net/virtio-net.c            |   55 +-
 include/hw/virtio/virtio-net.h |    1 +
 meson.build                    |   10 +-
 qapi/ebpf.json                 |   66 ++
 qapi/meson.build               |    1 +
 qapi/qapi-schema.json          |    1 +
 tools/ebpf/rss.bpf.c           |    5 +-
 14 files changed, 1111 insertions(+), 757 deletions(-)
 create mode 100644 ebpf/ebpf.c
 create mode 100644 ebpf/ebpf.h
 create mode 100644 qapi/ebpf.json

-- 
2.40.1


