Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7C176D920
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 23:03:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRIyg-0003N4-Ix; Wed, 02 Aug 2023 17:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qRIyf-0003Mn-3q
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 17:01:53 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qRIyd-00066N-8L
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 17:01:52 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2b9bf52cd08so3325831fa.2
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 14:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691010109; x=1691614909;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X8bS9eFtoOlLiwGmIMJNF+YzWLM/8WA3Emhd7Nb2yhQ=;
 b=HpYrdeFhza7vkEVpO41O3S/5VVvJ5mgIkJXg4TYG10SeSAAH7SUu7M+gpixdV30Ipj
 rncwtHRfXgDemY4/WhVcBD18iFC5VPBkOvoIDY3L+2AEAizqjB6nvz3WgmtjJ9gMz1+r
 6CZwAGwFYPcDQBxbFgvOjK8QixiSfChgkzOoSGkDfqXWdtPn4OCECdw7v53vxA0/ojLW
 VQwhGOs9XBX/3VLH4cNULgZHF6bQSgODVKs/b6IAfnMJcwOwW5FvNhReRYz4fnvwWO6P
 6S9+eOqB4sfjZ/E+eGaM15HCuF1Olfy8e+5YfGWozkKPY2kSii2SUIb+Wo0QNTbBTOEv
 IE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691010109; x=1691614909;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X8bS9eFtoOlLiwGmIMJNF+YzWLM/8WA3Emhd7Nb2yhQ=;
 b=izTdNdGkLxEnrq974r1H4aMXFyd8uw5LsPfZpOaPVmPbvP9h06N+5ruwpjXHIZyihS
 iKZkic/PTF58l/ppttu8IMlUA90Tn8oe0Jg8j9m6OOfHUUaMI4QGTLPszfp+fSGCLKba
 +5oieP13yDayL+AklfHkfKEPFQA09T50FtVrWrPk9k9uzcQYgQ1grBr/qQgypiIXGKx/
 2/3C3jOdwTg9+/c/DMQtVwFtQBOU8mWDr/fjTzTCyN7Zmdpq/Lw6XitDoI1/BR9GKfce
 MqG0P+K0N9g7MMU6aW1TrEIvQJ+AY7HcPCxfDlc2cggNPCmoNCIe5z7dags0yY23hMXE
 jUZw==
X-Gm-Message-State: ABy/qLY0G8eKiBSOV9eWV3fjHGNYEEAnnB03eAhBB/3H3Eeo7YOcvovZ
 21J4SceP3z5ROLNMfG1Zi8PSyg==
X-Google-Smtp-Source: APBJJlHll3lXpcR0gFzBVzo48PHSgFbGet4n3hEwvL1A0ByAlw3lGe4MRKO7n4T4sVIg0bMmAP5eyw==
X-Received: by 2002:a2e:b617:0:b0:2b6:e2c2:d234 with SMTP id
 r23-20020a2eb617000000b002b6e2c2d234mr6421028ljn.33.1691010108989; 
 Wed, 02 Aug 2023 14:01:48 -0700 (PDT)
Received: from localhost.localdomain ([194.126.180.172])
 by smtp.gmail.com with ESMTPSA id
 8-20020a05651c00c800b002ba045496d0sm391880ljr.125.2023.08.02.14.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 14:01:48 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, eblake@redhat.com,
 berrange@redhat.com, qemu-devel@nongnu.org
Cc: yuri.benditovich@daynix.com,
	yan@daynix.com
Subject: [PATCH v5 0/5] eBPF RSS through QMP support.
Date: Wed,  2 Aug 2023 23:41:18 +0300
Message-ID: <20230802204125.33688-1-andrew@daynix.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::230;
 envelope-from=andrew@daynix.com; helo=mail-lj1-x230.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 qapi/ebpf.json                 |   57 ++
 qapi/meson.build               |    1 +
 qapi/qapi-schema.json          |    1 +
 tools/ebpf/rss.bpf.c           |    5 +-
 13 files changed, 1095 insertions(+), 754 deletions(-)
 create mode 100644 ebpf/ebpf.c
 create mode 100644 ebpf/ebpf.h
 create mode 100644 qapi/ebpf.json

-- 
2.41.0


