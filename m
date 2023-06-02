Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 516767200ED
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 13:54:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q53Kf-0008JV-7e; Fri, 02 Jun 2023 07:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q53Kd-0008IJ-4j
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 07:52:35 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q53Kb-0007G9-L9
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 07:52:34 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-64f47448aeaso1307804b3a.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 04:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685706752; x=1688298752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PR8gVp6AayIwlrOZ5rFXSJfbCB9/dT2f8XhiwNsNRww=;
 b=ixUqMJq7lMbyHcVcQtZZhKMPlD67/eSpqX+oz7WNXEl1ci5foffYb7ukeDa3ot2TLI
 mjiS9hujPhekZTmwQp2YC4RsKiubvGvqAzoGkNOAwp/sq/0ayr9WiSKak/LsEvFvQYsi
 2Xh6kiFWni2gqkFt7QfkRoU1NyZuFJVwbHw3b7zI3qLXAaIFyoMOujoZaqMLFoIh2TBv
 kBMLUjLtJFhtecyJv/WRTLsC9rHiLSqMDELSwdq9tmrZf9GgW2hIS0XWdC7khgpnHk54
 UF7QC5E7KiN/LxVUFSAsIDUEzE3YpQEEwIL9HvLlpIcEOUjkOZUSWIw9IzXjZQ0U7W+r
 B5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685706752; x=1688298752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PR8gVp6AayIwlrOZ5rFXSJfbCB9/dT2f8XhiwNsNRww=;
 b=Ca4TtTeyamN4Icqp67Zf3atEAjzxrdaPiVWOWiKg89Rb06OBrpma42oJ0lQcHfMB3Q
 nkxvpSqTk0nK6ooZFX0Ceo9K6TUQdGmu9ICX76eHIiw/YM0B/3RdXp66DUHnU11Axj5F
 taPKD0y7hF0yFM+WUkIYue2GVGos1uY4onBdl044MJBda9fmHDjdhMYBD0U4BYwGJYaf
 fpbIQ2nWUJgBSrAkJroLznN5hZp6VtRapHUyCnUGl3Off5j7yTrAMu7MUUiZrfFu8mOU
 Wpt5k4Td0yqk+kGVXsjylJMpHsqWqXvf8PMcdYYrY5t59GaqFu05eBCsiN8y66TuThK2
 hoOg==
X-Gm-Message-State: AC+VfDxd8Ve6POFIglElzvm3ZQr3EvaphhZpPRg0Wi5UreF8eRZ4AgOF
 6FJgDcqs7n5HRPsoLck6/cY=
X-Google-Smtp-Source: ACHHUZ5OaLaJXDakvssJWFlAYaAPFK7vdEzWRQGMD/p+4D0n8oSzyJmupi0GDZWZEYqGLkGNRxd70A==
X-Received: by 2002:a05:6a20:a5a9:b0:10c:67c9:e5ea with SMTP id
 bc41-20020a056a20a5a900b0010c67c9e5eamr8467201pzb.31.1685706751932; 
 Fri, 02 Jun 2023 04:52:31 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 e21-20020a170902d39500b001aaf2172418sm1190659pld.95.2023.06.02.04.52.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 04:52:31 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v4 3/6] hw/net/virtio-net: make some VirtIONet const
Date: Fri,  2 Jun 2023 19:52:15 +0800
Message-Id: <489b09c3998ac09b9135e57a7dd8c56a4be8cdf9.1685704856.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685704856.git.yin31149@gmail.com>
References: <cover.1685704856.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=yin31149@gmail.com; helo=mail-pf1-x42d.google.com
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

The VirtIONet structure is not modified in
virtio_net_supported_guest_offloads().
Therefore, make it const to allow this function to
accept const variables.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
---
 hw/net/virtio-net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 6df6b7329d..7b27dad6c4 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -874,7 +874,7 @@ static uint64_t virtio_net_guest_offloads_by_features(uint32_t features)
     return guest_offloads_mask & features;
 }
 
-static inline uint64_t virtio_net_supported_guest_offloads(VirtIONet *n)
+static inline uint64_t virtio_net_supported_guest_offloads(const VirtIONet *n)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
     return virtio_net_guest_offloads_by_features(vdev->guest_features);
-- 
2.25.1


