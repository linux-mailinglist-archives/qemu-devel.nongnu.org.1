Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 929B775E0E9
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 11:28:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNVNf-0001hQ-L9; Sun, 23 Jul 2023 05:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qNVNe-0001hH-5J
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 05:27:58 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qNVNa-0001X4-Co
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 05:27:57 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-1bb5f78b30dso91625fac.1
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 02:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690104473; x=1690709273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lqDYe0wtYfLpN2tqp42QO/VtGC9R8rwe6ys1M/nbgpg=;
 b=fULkiA3qFelc4c5X8wZOSnw7GrJzc8129ArM2M5dYiBcWdBXRodnnr0YvQZFeVUYPj
 ib/fykJJuJZo/m//jYbLC+MCq3XsuRjAti8czPrefmbMULmXRMijeBh2BHvCxZOkUGYh
 MoOCynN7hyFwqulQ4O7bVu0C1tt2lqnM/T+xqWJKWyy6uB8bFUWl4loICv6GadAlYA7t
 BJvgojOspq/SpxQ8loxNBSEtAKUjy9TNEmPEditmPszs/PjnuExn4wO3kIWcSinYJcIz
 JO5gYf4yMRyiwEo0WEFWpby5GACL8c6qu22C1knQHoAOnv+MHeu+It8z89QKkJMICw8g
 dD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690104473; x=1690709273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lqDYe0wtYfLpN2tqp42QO/VtGC9R8rwe6ys1M/nbgpg=;
 b=GPg4yzwVSxFSYEBWOi3eSa/CCQvkl7tbyC9Mb5ZWkx4Hx7OB4W6R4ovKl8Ouuitydb
 xrLg2MSC1+/39WOUCi+mrn3VPt4Idk4fdd4mvehTsyDLCoxRCaP5dgOnjRcOkTTUgDv4
 8Pt3DTmfxFJ04lJNDtqdpaR2BE7BV44ztqg2RqM7Ya8mCKcL9l3oAWIvNV0bVd0k6TYN
 4qX+T+P6bvGbD8ltbOa+tPkTs0dMSWfmkVova0fCQaJF/Gb30gAzFxf8ckiQ66CYN/Hf
 vJynsvcNX5ExJC1wjP0kvQx2XSiGSWLVZnWWnBguxjiytrWpyNOuL+bpLVgNrWEppDNA
 kpSA==
X-Gm-Message-State: ABy/qLaMAfOBLDM1Vq69e8w/aTBSQ7CE/g/smGTwAmEcBOqqxtzMif1k
 ubxvTV0etuRByNX5GG+5AKQ=
X-Google-Smtp-Source: APBJJlFgR7zSjLZJnFfT85js8lc2AkclerUTOd4L0vSRp9agwotZKJCFlDXArfR/jRV0WzKiP8nj9g==
X-Received: by 2002:a05:6871:112:b0:1a0:85d3:3d70 with SMTP id
 y18-20020a056871011200b001a085d33d70mr7788428oab.28.1690104472723; 
 Sun, 23 Jul 2023 02:27:52 -0700 (PDT)
Received: from localhost ([123.117.183.65]) by smtp.gmail.com with ESMTPSA id
 z129-20020a633387000000b005633c9493d0sm6179518pgz.21.2023.07.23.02.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jul 2023 02:27:52 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v2 4/4] vdpa: Allow VIRTIO_NET_F_CTRL_VLAN in SVQ
Date: Sun, 23 Jul 2023 17:26:37 +0800
Message-Id: <38dc63102a42c31c72fd293d0e6e2828fd54c86e.1690100802.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690100802.git.yin31149@gmail.com>
References: <cover.1690100802.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=yin31149@gmail.com; helo=mail-oa1-x34.google.com
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

Enable SVQ with VIRTIO_NET_F_CTRL_VLAN feature.

Co-developed-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 347241796d..73e9063fa0 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -111,6 +111,7 @@ static const uint64_t vdpa_svq_device_features =
     BIT_ULL(VIRTIO_NET_F_STATUS) |
     BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |
     BIT_ULL(VIRTIO_NET_F_CTRL_RX) |
+    BIT_ULL(VIRTIO_NET_F_CTRL_VLAN) |
     BIT_ULL(VIRTIO_NET_F_CTRL_RX_EXTRA) |
     BIT_ULL(VIRTIO_NET_F_MQ) |
     BIT_ULL(VIRTIO_F_ANY_LAYOUT) |
-- 
2.25.1


