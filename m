Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5052730AA8
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 00:31:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9Z00-00041y-3H; Wed, 14 Jun 2023 18:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1q9Yzy-00041N-CO
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 18:29:54 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1q9Yzw-0001AA-Dr
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 18:29:54 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4f642a24568so9549707e87.2
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 15:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1686781790; x=1689373790;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z3LBFV89fkHOWtkmFW8agC9oKU7Qk1kjrwFde1B0JqM=;
 b=aq32ZtGIDrAHGz5S2dIwtIr2jiOVGc6eDdEXQWgK87XP+Q6qtFlDce0lO/qAqN8m6v
 cG6zzhLGkPKAUz4l8JFDo9DuQr0VWkjJgJEcLnV/S5qs8BO0541bY7gJCEaPAEtnekJa
 JSEoKeJ8J6UiiZtAj57dqr57S0iE2vy7nV0HbvsczE8CtNmiEa4J9Hc1Brmdn+AD0UXO
 IdFnmkDZ9bF5X1yWhFJr2PwoPY618rdj+DmbV6RLfKmmARzW5gxJS43XxyAdxBJUNdjX
 9gaa7OkQRMtkDUFQzkEUasod5VlropyntxU4ZS/viYXp3xTQ04BN/e3xn0nPCHuip/gG
 Wl7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686781790; x=1689373790;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z3LBFV89fkHOWtkmFW8agC9oKU7Qk1kjrwFde1B0JqM=;
 b=NQVjFhQS5HGAug+hJa8TWyiZ9EbnXQq23q3CNMYwlxsSPC45SH6F/4cWeISqBJ7D29
 9XDyAJwTvTvmi0HSYsYXKPwGJL04UJA49N8FUubREZJ7N0M9UDk5ed9+l9hnofLO3s85
 U9ajTYgkkop0P/PrfOjsTW2baKcsfTW5u6D6QcfumGofR8jiS3f4EVD6nu0Q3MHSVp3s
 2FZS7jD0HnpeM2i2VYEXq+NcerQ59pmsBC9YI08TB9G3kbHDwgctgCXoka3f5/ztQSEb
 +8p2q1QHlNulfr8hkBl9X3aEQjuXcsKE/6DiciPAeL+/n3Dn9Wvv9r0M9prFbGDFIuRR
 eDRA==
X-Gm-Message-State: AC+VfDz2rngV/5oNNjzSGnvg+220vjqnSPmMRQRe4uoZfnH2kylB4Hxp
 kELe+YuCx4feW0uyAnFJwv49ug==
X-Google-Smtp-Source: ACHHUZ5LF/ICYTfR/mD80nEm3kO3AusTCLceYEoRKnjyd4HTLpjI667ods8Y3jg1AE7ouRyQbggjQA==
X-Received: by 2002:ac2:5b4e:0:b0:4ec:8524:65a4 with SMTP id
 i14-20020ac25b4e000000b004ec852465a4mr7231422lfp.55.1686781789859; 
 Wed, 14 Jun 2023 15:29:49 -0700 (PDT)
Received: from localhost.localdomain ([46.98.110.34])
 by smtp.gmail.com with ESMTPSA id
 x8-20020ac24888000000b004f39837204fsm2279483lfc.85.2023.06.14.15.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jun 2023 15:29:49 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org, berrange@redhat.com
Cc: yuri.benditovich@daynix.com,
	yan@daynix.com
Subject: [PATCH v3 0/6] eBPF RSS through QMP support.
Date: Thu, 15 Jun 2023 01:10:20 +0300
Message-Id: <20230614221026.56950-1-andrew@daynix.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::12d;
 envelope-from=andrew@daynix.com; helo=mail-lf1-x12d.google.com
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

Changes since v2:
 * moved/refactored QMP command
 * refactored virtio-net

Changes since v1:
 * refactored virtio-net
 * moved hunks for ebpf mmap()
 * added qmp enum for eBPF id.

Andrew Melnychenko (6):
  ebpf: Added eBPF map update through mmap.
  ebpf: Added eBPF initialization by fds.
  virtio-net: Added property to load eBPF RSS with fds.
  ebpf: Added declaration/initialization routines.
  qmp: Added new command to retrieve eBPF blob.
  ebpf: Updated eBPF program and skeleton.

 ebpf/ebpf.c                    |   70 ++
 ebpf/ebpf.h                    |   31 +
 ebpf/ebpf_rss-stub.c           |    6 +
 ebpf/ebpf_rss.c                |  150 +++-
 ebpf/ebpf_rss.h                |   10 +
 ebpf/meson.build               |    2 +-
 ebpf/rss.bpf.skeleton.h        | 1469 ++++++++++++++++----------------
 hw/net/virtio-net.c            |   55 +-
 include/hw/virtio/virtio-net.h |    1 +
 qapi/ebpf.json                 |   55 ++
 qapi/meson.build               |    1 +
 qapi/qapi-schema.json          |    1 +
 tools/ebpf/rss.bpf.c           |    2 +-
 13 files changed, 1093 insertions(+), 760 deletions(-)
 create mode 100644 ebpf/ebpf.c
 create mode 100644 ebpf/ebpf.h
 create mode 100644 qapi/ebpf.json

-- 
2.39.1


