Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 663F5774F4F
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 01:31:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTW9p-0002iz-Gj; Tue, 08 Aug 2023 19:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qTW9l-0002iP-J5
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 19:30:29 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qTW9j-0005PE-HT
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 19:30:29 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fe32016bc8so52221735e9.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 16:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691537426; x=1692142226;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DrqCNeZcoV7eyL2RFgvAiM6hta2Wd2hPOqtIm0dIxZg=;
 b=j/cY13hsHjad8PfszhaVqPv9X4ml/vTDYj3mpqzRHTcjfLzNSjgmcrYTvtZvhK28RC
 9wvm6pyS5/qrhjWOf+UW+x2M61WRKGxpDrdQzqsi2z1HSb+RPydwRZIg+dDg3pE7T39j
 yLzM7ALMfTbfc/DfsYJ+NKl36fwXpTrvl+0gFUU+dZpzja9U7VUzsHt3B/oztKzaYn9u
 bhWPWh9j2HDiaw0uQrmDAYek69suFTZUEiH3aESFlFyEa7XQO7rMFs6ii+R+/vG6WtEd
 gEESgw2YaApLk5bzwuEmxNdN5M8AsZkmKLhOWYUqckf4CrXWgO5jYSUYM78OixpnZIEG
 eQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691537426; x=1692142226;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DrqCNeZcoV7eyL2RFgvAiM6hta2Wd2hPOqtIm0dIxZg=;
 b=OagZhpJ62SjeegPebZNm98fmnwPcF+l1D40/sH6esDWwJttN/fhLzNIpMyFTwgUGGi
 /p7VmSFKmuHVbNRs1I8t10TOoN8VoMN76CD/1It672N3xMXoZS3xK0J7XaIk0zFlDPey
 pIaf2LiVDZcLG/mjiSN0UNHothRGO2l9tAoYpIa4Heu3ttovi13Mz1MCKpggRWPI1Jxk
 /vUoGdYqoLWwm+gnfK3iys0zA4f5gIYrBiyPwLOuDQuuiBwSmrCp4WpM3pmUjuJdZ/gL
 TC3jK09FwUQXEg6Dhzb+6SbD9IelscYnvH6GoqHLkfzoOb06NssR+k70Kmthodx19u6g
 Pr1A==
X-Gm-Message-State: AOJu0YzDMatidXd1SlORjesdyLogyoFD2rfbXo3xBmXfiIg9BSIyfRRT
 WQCDyHWhcNjEL1tzy/+dasxr7g==
X-Google-Smtp-Source: AGHT+IHI+zHTY/cG6rW9G7R7SqottBRfW/Qio5XUCsqWcnN4cFrxQYbntnxHNpOY5EeUqFpGVDW7Rw==
X-Received: by 2002:a05:600c:2484:b0:3f9:c8b2:dfbd with SMTP id
 4-20020a05600c248400b003f9c8b2dfbdmr860680wms.19.1691537425805; 
 Tue, 08 Aug 2023 16:30:25 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id
 g6-20020a056000118600b00314398e4dd4sm14776795wrx.54.2023.08.08.16.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 16:30:25 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org, berrange@redhat.com
Cc: yuri.benditovich@daynix.com,
	yan@daynix.com
Subject: [PATCH v6 0/5] eBPF RSS through QMP support.
Date: Wed,  9 Aug 2023 02:30:10 +0300
Message-Id: <20230808233015.2295947-1-andrew@daynix.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::330;
 envelope-from=andrew@daynix.com; helo=mail-wm1-x330.google.com
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

Changes since v5:
 * Refactored ebpf.json

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
 qapi/ebpf.json                 |   56 ++
 qapi/meson.build               |    1 +
 qapi/qapi-schema.json          |    1 +
 tools/ebpf/rss.bpf.c           |    5 +-
 13 files changed, 1094 insertions(+), 754 deletions(-)
 create mode 100644 ebpf/ebpf.c
 create mode 100644 ebpf/ebpf.h
 create mode 100644 qapi/ebpf.json

-- 
2.40.1


