Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E5A759770
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 15:54:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM7cZ-00089x-0y; Wed, 19 Jul 2023 09:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yui.washidu@gmail.com>)
 id 1qLwTj-0005Bo-7a
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 21:59:47 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yui.washidu@gmail.com>)
 id 1qLwTg-00032b-R7
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 21:59:46 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1b9cdef8619so40604325ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 18:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689731982; x=1692323982;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L8bb2HK8/m+y4PhBVy2ANyG3Ll3bf50xATCh/qwD7x0=;
 b=qrdT1a/k9Gg/lom/gUvAcPvpbEgVe5AiMqH0OrEAwlsB6cQIpjme+llmlWXUBi6uIQ
 uhzFrrjlBZxEhZHLHa2aGTrYz1dWBeXpJk+wDL0w8x8UtZH47W2vrVpYEyA4YFrYCNnP
 fs9YcyV+5AZrWAxAhG64DRnIYV6tFcnSAogF7gItCLHD9V/UtHt3upAjmxfy98tcWach
 vqD1VQRvFae19j2FZPhv4VdbqZvhDYkQBEM0CMcilAEFdLtqd/7SLL0uDeDmJhzTAMPG
 D1x+fJ72x1D4tXoGVaHbDrsBbVcLf84MLA9gjpgSm/+FogCjEhC3Q3zjSkkYYJgmbTEp
 sUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689731982; x=1692323982;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L8bb2HK8/m+y4PhBVy2ANyG3Ll3bf50xATCh/qwD7x0=;
 b=XEyIV3MsAZOn+1EF3jcKU7ciSAJp+5sHqBhVgQb9QpqfLHAixzbpBMCG6pYwIA15Y2
 YS2VzgBmGypUC0F9I1y8ZTbaq6Els4+SysrfwmETWlWw4lCSHgS4OChp3o6F7E24sm+/
 YShJBpgF2fL1QKxoUBJCNYIxm2Ju/EcWMzWA3HUs4mPofz8CNiX1H9untS0jn9LQJjAh
 YT4yML6LDnQFo2ZjfleXUAIphSWG+CPpu26uTco/V9F1C0BhG6Cxh0EjpH6k3Uie3ROE
 Fi1ARx4z11MF4v3xuzuhrGcwHy/zwO0eCrWBHf0UI+PvOkDltDeveXKhy5Dq4u+TZgvc
 qMZA==
X-Gm-Message-State: ABy/qLa4azOeTFla110kXVF9ZEp087uoXQOfwGLi7qIHpXG7ougp7CkD
 LtgSVgzzf6KqtxTkcg2ngnxq+gPZl+w=
X-Google-Smtp-Source: APBJJlEA+UOFEOoQ8i0TYY7hBqJag13w5hstDm5ZigPpCzhOvarAyubffLWDPORRFynS8Efs0o1gRg==
X-Received: by 2002:a17:902:74c4:b0:1b8:4ec2:5200 with SMTP id
 f4-20020a17090274c400b001b84ec25200mr3642604plt.2.1689731982568; 
 Tue, 18 Jul 2023 18:59:42 -0700 (PDT)
Received: from redsen-desktop625.kern.oss.ntt.co.jp ([222.151.198.97])
 by smtp.gmail.com with ESMTPSA id
 i12-20020a1709026acc00b001bb54abfc07sm19722plt.252.2023.07.18.18.59.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Jul 2023 18:59:42 -0700 (PDT)
From: Yui Washizu <yui.washidu@gmail.com>
To: qemu-devel@nongnu.org
Cc: Yui Washizu <yui.washidu@gmail.com>, jasowang@redhat.com, mst@redhat.com,
 akihiko.odaki@daynix.com, yvugenfi@redhat.com, ybendito@redhat.com,
 mapfelba@redhat.com, marcel@redhat.com, ghammer@redhat.com,
 mdean@redhat.com
Subject: [RFC 0/1] virtio-net: add support for SR-IOV emulation
Date: Wed, 19 Jul 2023 10:56:47 +0900
Message-Id: <1689731808-3009-1-git-send-email-yui.washidu@gmail.com>
X-Mailer: git-send-email 2.2.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=yui.washidu@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 19 Jul 2023 09:53:28 -0400
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

This patch series is the first step towards enabling
hardware offloading of the L2 packet switching feature on virtio-net device to host machine.
We are considering that this hardware offloading enables
the use of high-performance networks in virtual infrastructures,
such as container infrastructures on VMs.

To enable L2 packet switching by SR-IOV VFs, we are considering the following:
- making the guest recognize virtio-net devices as SR-IOV PF devices
  (archived with this patch series)
- allowing virtio-net devices to connect SR-IOV VFs to the backend networks,
  leaving the L2 packet switching feature to the management layer like libvirt
  - This makes hardware offloading of L2 packet switching possible.
    For example, when using vDPA devices, it allows the guest
    to utilize SR-IOV NIC embedded switch of hosts.

This patch series aims to enable SR-IOV emulation on virtio-net devices.
With this series, the guest can identify the virtio-net device as an SR-IOV PF device.
The newly added property 'sriov_max_vfs' allows us to enable the SR-IOV feature
on the virtio-net device.
Currently, we are unable to specify the properties of a VF created from the guest.
The properties are set to their default values.
In the future, we plan to allow users to set the properties.

qemu-system-x86_64 --device virtio-net,sriov_max_vfs=<num>
# when 'sriov_max_vfs' is present, the SR-IOV feature will be automatically enabled
# <num> means the max number of VF on guest

Example commands to create VFs in virtio-net device from the guest:

guest% readlink -f /sys/class/net/eth1/device
 /sys/devices/pci0000:00/0000:00:02.0/0000:01:00.0/virtio1
guest% echo "2" > /sys/devices/pci0000:00/0000:00:02.0/0000:01:00.0/sriov_numvfs
guest% ip link show
 eth0: ....
 eth1: ....
 eth2: .... #virtual VF created
 eth3: .... #virtual VF created
 
Please note that communication between VF and PF/VF is not possible by this patch series itself.

Yui Washizu (1):
  virtio-pci: add SR-IOV capability

 hw/pci/msix.c                  |  8 +++--
 hw/pci/pci.c                   |  4 +++
 hw/virtio/virtio-pci.c         | 62 ++++++++++++++++++++++++++++++----
 include/hw/virtio/virtio-pci.h |  1 +
 4 files changed, 66 insertions(+), 9 deletions(-)

-- 
2.39.3


