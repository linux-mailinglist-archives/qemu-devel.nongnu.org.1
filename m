Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C62752F5F
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 04:26:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK8Te-0005UZ-0D; Thu, 13 Jul 2023 22:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qK8Tc-0005TJ-0n
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 22:24:12 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qK8TW-0000CQ-Lr
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 22:24:11 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4fb7dc16ff0so2402355e87.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 19:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1689301444; x=1691893444;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YsJV0qHMO2EKmlmS2i2GogHW2f3k+PJgEe6IlX1gEak=;
 b=aZnUdCiIqLzo0wvgONHlvUJkMSG8SoDFG1fkC17jBR0WmmuHT6s02WoGW1e2hgYvZN
 fIztaFdPvg+lVwJdbx+UUtwLTceOo8bTY5qh216J84SkEnMQG1p5v23uOm5AmHXXWE4h
 u3oGVW1d5nvokz+VpKTECTOHKTboyIq8d133j+YFhkRcFKEMRqQ1T2KXlUsqtFZcC/oV
 gjPXGaymA+mQX7+DCbzcKypS8zl1CrAXSp6q6X5RROgAiRybS9TlmIFQE6dkSIg2JUBY
 KL5fQJzK0bOORL0TFK2Izu/wNJJBIg/LjEyVrzyf2X9cesYsgtlZJ/eGMgshQ9MreqzN
 JJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689301444; x=1691893444;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YsJV0qHMO2EKmlmS2i2GogHW2f3k+PJgEe6IlX1gEak=;
 b=UM/vjOAZ0VISAsx0zLadH/gtFE/Q+pSi2D0hofcLD0w4xC+m3d5EfJqF1sFC69nyaa
 rQU4KDF9B2qX85W3vw3MHfPHKrJkoJXMbljd9J/jeIZoxm4oIpnkB3UyokV5fFoGltdF
 vWH0OjKbNcdc0NEoeuvhR66MUx4Cp5yeOqsdf86n93shERHYO/wG4843UXRwo0tU5N2u
 HEKKyh+f6QuWBdsG8tlhvEFAFz3iom2yqkku87QpBx+JsrH22HGOx5yj8aUsNKGNnjrC
 AkuTMpUTPLCIONGxf74qLXvv2X9sLOS7HLhh7UGsjY9tSGfdeOj6nt4gT3Xls1w7H9Wa
 iijg==
X-Gm-Message-State: ABy/qLats2Wwh3xBjDDSZUFQLzGaDtewJZJX54vF0Ffs/aFHOdBuJxiJ
 PRX5eoVlN6aqifZpY7u06wcshQ==
X-Google-Smtp-Source: APBJJlHYiQddZtLEzuBlRHAzC/W9mM3x+bChX7uGbay5plHahLGb16lpbPzOxB7Fylc9rQrXsQR23Q==
X-Received: by 2002:ac2:447b:0:b0:4fb:8441:be06 with SMTP id
 y27-20020ac2447b000000b004fb8441be06mr2444845lfl.18.1689301444442; 
 Thu, 13 Jul 2023 19:24:04 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id
 r24-20020ac24d18000000b004fbe2172f7csm1294765lfi.49.2023.07.13.19.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jul 2023 19:24:04 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org, berrange@redhat.com
Cc: yuri.benditovich@daynix.com,
	yan@daynix.com
Subject: [PATCH v4 0/6] eBPF RSS through QMP support.
Date: Fri, 14 Jul 2023 05:23:52 +0300
Message-Id: <20230714022358.2438995-1-andrew@daynix.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::12e;
 envelope-from=andrew@daynix.com; helo=mail-lf1-x12e.google.com
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
 qapi/ebpf.json                 |   58 ++
 qapi/meson.build               |    1 +
 qapi/qapi-schema.json          |    1 +
 tools/ebpf/rss.bpf.c           |    2 +-
 13 files changed, 1096 insertions(+), 760 deletions(-)
 create mode 100644 ebpf/ebpf.c
 create mode 100644 ebpf/ebpf.h
 create mode 100644 qapi/ebpf.json

-- 
2.40.1


