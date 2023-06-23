Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F36073B8C2
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 15:27:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCgo7-0008NV-1E; Fri, 23 Jun 2023 09:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qCgo4-0008Lv-WA
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 09:26:33 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qCgo3-00030p-B8
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 09:26:32 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-39ed11d6a50so401050b6e.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 06:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687526790; x=1690118790;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=U6H+QT3J0J3/+WJFlKB+dVi1u8jnAJxpBz1MRRkxs8k=;
 b=I4Vdl73ck7Hf/dqPTVyECQXofwN/FbY7yvzu39ahZx07I2shWOq1cupCSOGM7/+D1K
 zQsYRY73XbVDUNfHdHYJIP5GIAAxlZXuKAOh53SJqqY+kRigt22wVB0+ZlRBXVylfHDw
 68ffOw+H0f7f85btz+cJbbKNF+oc0nKgdUEAN9LrhLayLT1Hwp+0o7A5MKuPpmmMgBxF
 jxI+k2OmbKUQYQZwsGFmlTCiI6j7/V7Z8+44ZXXZ+3n1XBFDGGAjnSpEOWeItej4VHAQ
 iOe5ltAngBc9b6M9SO7R0LlnK/cjbtdOzc3WmOcizF3gxdVnF+ebvh0frvrdQ4i+4t80
 TJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687526790; x=1690118790;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U6H+QT3J0J3/+WJFlKB+dVi1u8jnAJxpBz1MRRkxs8k=;
 b=BGCNxnK1Hhzn6z4LN9fJiE7DW5IrdIjDmoKXRxGskVKh4DSS9afeAZyYkOy51qI3n4
 rf8Qplw3EGUqf2gHwIqHWOqRHyMzjexuHF4E6PQ7uxembGFhTS+iq7SNXmFg1Rv9mIMg
 STNCW+4nctCGwZIMJgBekY/l3H6KViXsvBAcnFgpNGQh90VaCOTqhcS9JtMyhfOAMXll
 gW3FaWokCAGdu5EmrzGwOjebAyjA0gedalOJtjUvXNmFZj6BRbgoJYqp4hfSAlbZRNfB
 cZ2faXWfHCLCjMIueVJSQOw8W9I0aDLFezIA7Go4xsxa5RAmfWpHolA2zHSdQaRaREAr
 Hlfw==
X-Gm-Message-State: AC+VfDyazOKh9g+IH5RVpV80pSfdwCaWvO94we1frXyHDiY2SI6K/NnZ
 6lxpPftyKaTYRZS2GTYTCoM=
X-Google-Smtp-Source: ACHHUZ77jHkwvV9xIbcV9BOHmqfMqk6lS3QaiUmhWL+vCfnpxP9E/FPFEnW5YeiJGzr6LtjNChLW3g==
X-Received: by 2002:a05:6808:128d:b0:3a0:30c4:5d45 with SMTP id
 a13-20020a056808128d00b003a030c45d45mr16444588oiw.33.1687526789656; 
 Fri, 23 Jun 2023 06:26:29 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 e14-20020a17090ac20e00b0025bb1bdb989sm1476302pjt.29.2023.06.23.06.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 06:26:29 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH RFC 0/2] Vhost-vdpa Shadow Virtqueue _F_CTRL_RX_EXTRA commands
 support
Date: Fri, 23 Jun 2023 21:26:24 +0800
Message-Id: <cover.1687524532.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=yin31149@gmail.com; helo=mail-oi1-x229.google.com
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

This series enables shadowed CVQ to intercept rx commands related to
VIRTIO_NET_F_CTRL_RX_EXTRA feature through shadowed CVQ, update the virtio
NIC device model so qemu send it in a migration, and the restore of
that rx state in the destination.

To test this patch series, I modify the `n->parent_obj.guest_features`
value in vhost_vdpa_net_load_rx() using gdb, as the Linux virtio-net
driver does not currently support the VIRTIO_NET_F_CTRL_RX_EXTRA
feature.

Note that this patch should be based on [1], which has not
been merged yet. I will submit the v2 patch after they are merged.

[1]. https://lore.kernel.org/all/cover.1687402580.git.yin31149@gmail.com/

Hawkins Jiawei (2):
  vdpa: Restore packet receive filtering state relative with
    _F_CTRL_RX_EXTRA feature
  vdpa: Allow VIRTIO_NET_F_CTRL_RX_EXTRA in SVQ

 net/vhost-vdpa.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

-- 
2.25.1


