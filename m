Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 817AA725E58
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 14:15:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6s2t-0006xr-FW; Wed, 07 Jun 2023 08:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q6s2r-0006wH-Cu
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 08:13:45 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q6s2p-000360-OV
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 08:13:45 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-653fcd58880so2745464b3a.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 05:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686140022; x=1688732022;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EMiW25v1yGrSSjCGLoRa326ruQCygeOytRF9hBNtrkE=;
 b=TILPBt+pUqlCzsn3JwcJw7/N3+5U92D0pQRouy4qx2ypV3VXM+ERozjkd7YjDV0aHY
 ExLxYJg4CPWMwNXdaRyrx/DgSgO5P8jz3ehSFcbErhOQdRWZnDyklsPJ5avT2o+diiKf
 YelMDQ+tHThQF5TC/bdpdxaW5smTdJN0ujHbXXdBqjCBSrFKGzXrroXzh9qjlpVnoTvs
 JmeW9R1bHYBiEJ6yFHv2qi9ClOK/YHlB3cMBMwe6mzuPuLgeUIY/ZQgqPuBuEO+FoGIW
 FG9bhzkNRPKQ8MKvH1+nyaiu5vJBS2cMvImP5xn9J5JjFbLqflu136tGA2A2PUA9UtPo
 hfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686140022; x=1688732022;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EMiW25v1yGrSSjCGLoRa326ruQCygeOytRF9hBNtrkE=;
 b=U/npOkaGDe/Z8WsX983YymICqzc6ktWAVpCDiEg7csQBM7wmt42ZUgPbGuHFa+qfY+
 rltQfu0y5U8LQXwyCI7cXDH3bgn00k/AGZd+vcvjfRqGD9S2KxhXnbK73pB6JmdSxzNx
 0CB9Fkihc/B3EwKB7uXGzmw+dfKA1LyCMNuwgHGqxavlR23ovalP7HJ7Z3mrZWuh8tFq
 XHWnq0O1Ynq/qVLTD9y/tAMwOzTScfpOPbQNNt8ybFEmaOWbmpq64N2CfGOTjDH2oFhi
 fMM/ZXmch4XhH3fnXUQnrQWpt38c3H3pLlF2C1LrnTPc5vFRADn1kRACq7Ax+2bxpHtZ
 0S7g==
X-Gm-Message-State: AC+VfDzUdmTxP2IWYlltaCqRGAa+4q+3+vg64qsU9rI7D3ZIPHEZeyoJ
 FltUfxO8M1NGm3Sg3b/+WwQ=
X-Google-Smtp-Source: ACHHUZ56phjB9DJzM1I1OsvkTxpNdARz0rGMyX2jCzbtBdsLES/hkVleYd2xJVtskXY2ceO8DQpeUg==
X-Received: by 2002:a05:6a20:2d20:b0:10b:56bd:b00e with SMTP id
 g32-20020a056a202d2000b0010b56bdb00emr1069535pzl.40.1686140021374; 
 Wed, 07 Jun 2023 05:13:41 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 m26-20020a056a00165a00b006610b89d53bsm2208972pfc.73.2023.06.07.05.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 05:13:40 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH RFC 0/2] vdpa: refactor vdpa_feature_bits array
Date: Wed,  7 Jun 2023 20:12:16 +0800
Message-Id: <cover.1686137925.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

This patchset removes the duplicated VIRTIO_NET_F_RSS entry
in vdpa_feature_bits array and reorganizes the vdpa_feature_bits array
in ascending order based on its value to avoid future duplicates.

Note that this patchset conflicts with the [1], but conflict can be
easily resolved by inserting the VIRTIO_NET_F_CTRL_GUEST_OFFLOADS entry
into vdpa_feature_bits array in order.

[1]. https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg00601.html

Hawkins Jiawei (2):
  vdpa: delete duplicated VIRTIO_NET_F_RSS in vdpa_feature_bits
  vdpa: order vdpa_feature_bits array

 net/vhost-vdpa.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

-- 
2.25.1


