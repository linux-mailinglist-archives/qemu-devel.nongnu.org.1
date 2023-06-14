Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFD072FF57
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 15:02:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9Q8U-0003LV-N6; Wed, 14 Jun 2023 09:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q9Q8O-0003I9-IY; Wed, 14 Jun 2023 09:02:03 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q9Q8M-0007MG-5C; Wed, 14 Jun 2023 09:01:59 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1b3db8f3d07so17298125ad.2; 
 Wed, 14 Jun 2023 06:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686747716; x=1689339716;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KNcXy+x2wiznMWAxVc7wQoOhufahhv0gn9hHs57Ut5Y=;
 b=a0JHoiBIOD1ZgWgEGcE9YGEFPvLzLMNH7fc2y5zp8JJF/eHVEBZNFgLz7UsQ0mIIhK
 jT/UXU17eZ2A0hASKXhf0vCgKAgWsifQQSjdaNasdXqcZnm1hhZQcBL0hbowjmpld+kM
 8e7cZd90SZ1uvj1i1ECzfde2zVF+XFloSr1QJBF+p+abKgVjs6iehxoBvBgAK6TI96MA
 6sO4C6oOwzI9hZkrH/X6CrP3oc1odsrkeZrHpF8V8oDprcPf5spSTRdNFHhRWkYm8s3K
 ebXd8x/bRrb4oOvtcNZjrI6It+AL/vUse2IDP6dmFV64hmuexuBAhV/nunSHdeP+1ko6
 lGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686747716; x=1689339716;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KNcXy+x2wiznMWAxVc7wQoOhufahhv0gn9hHs57Ut5Y=;
 b=NFhkGbEjTwXB/IFl8Wn/e8FwotY3oPxXCbXXyLPJnMy+mEp4wKBocFO7u8+cL8xKq4
 sOy8IyPqFqGUt1GWiMgA8flwaEU4WuuJE1JiVEVr9HWgbuP26i/b83nI5TTd5/zz7ykz
 acUCnExqV+2/2NUdFgZl0GenKcx8WpFSvmOl+08TJeqaeAXwCDAJzURlkz8iSrVpXa1q
 /0tyKoWhLvaSQ/jGNVwA+aZNXk2PPtTgAZN6rhbP1NZcRrfKxaVVqo90rrptI4f2FX8D
 Y0cvu1Nzak/jrcB/Xr8yCFCqEpQcDRyYuwxvpQlHw4Qn8k7Hjvicb3HA8qk20UbG7b2Z
 zCBw==
X-Gm-Message-State: AC+VfDz8p5uBnGVcPqxOQMzG6EsE/kEsku/ZnfDASZ5SeL3tZ6rWQbf1
 InlPrjSMpyGt/tpWbdH0lGQ=
X-Google-Smtp-Source: ACHHUZ7JuDTMzTWxdywaDP/BwMr1+kJ0yTlJZMJV/LFgNM8hD/Rm5F2Jp7I04BPLQf9/aONKZnTtiw==
X-Received: by 2002:a17:902:b703:b0:1b3:e802:5de6 with SMTP id
 d3-20020a170902b70300b001b3e8025de6mr4342885pls.29.1686747715183; 
 Wed, 14 Jun 2023 06:01:55 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 j11-20020a170902690b00b001b03842ab78sm12167370plk.89.2023.06.14.06.01.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jun 2023 06:01:54 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, yin31149@gmail.com,
 18801353760@163.com
Subject: [PATCH RFC 0/1] Return -EINVAL if device's ack is VIRTIO_NET_ERR
Date: Wed, 14 Jun 2023 21:01:46 +0800
Message-Id: <cover.1686746406.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This patch fixes the problem that vhost_net_start_one() doesn't cancel
the device startup and returns 0 even if the device's ack is VIRTIO_NET_ERR
in net->nc->info->load().

Note that this problem also exists in
patch "vdpa: Add vhost_vdpa_net_load_offloads()" at [1].
Because this patch has not been merged yet, so I will submit the v2 patch
to fix the problem in that patch once the pending patch
has been successfully merged.

[1]. https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg00504.html

Hawkins Jiawei (1):
  vdpa: Return -EINVAL if device's ack is VIRTIO_NET_ERR

 net/vhost-vdpa.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

-- 
2.25.1


