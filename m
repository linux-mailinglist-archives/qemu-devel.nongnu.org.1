Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 244DD714A24
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 15:19:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3clb-0001jb-LD; Mon, 29 May 2023 09:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q3cla-0001jF-DM
 for qemu-devel@nongnu.org; Mon, 29 May 2023 09:18:30 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q3clY-0006Pr-Sv
 for qemu-devel@nongnu.org; Mon, 29 May 2023 09:18:30 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-64d577071a6so3909199b3a.1
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 06:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685366307; x=1687958307;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y8plhs8Dd3R9/0mvDG8M8lxTdkwUM8fya1c3ZcQOwgg=;
 b=iDdFvryqUg/caiAZSDTcCHNi6KbemzgEN/uAN2uVeBv1yz4YF97DvN1jdKIjKaHOk3
 PB5rQ9wsHRTt/KupqAlDr7k1OlBOCJWPPmZZJ8Tr48//orWUfLoURShANZArc2hic+C3
 xDg4S40QxONJlGMm1tpsEtcu/wpr4ImFxb091dkU2ksQ9bONR3H0uvhWuzbPH3dSWYoa
 LCyMknbN7JuMTpOZuOkGxXPXUw7ct0yWM4UM/CbILnPGPXY21TSiaYhHzIQtaarlNnca
 PyNekI++djOC/OqPiVh3qOwdtK/v7iUqlLlW56dyoFxc3Nf0QH5ktr92MuUaVc8LqeIi
 U3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685366307; x=1687958307;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y8plhs8Dd3R9/0mvDG8M8lxTdkwUM8fya1c3ZcQOwgg=;
 b=X77CX2tu+jVG1zCG7e/JKm6yUm/9najMNl5O1IOc8kiIzVwRO4UYauX9isDH9ec3RO
 T6LGZ3TVV2lNszPJXyODIkiTxypEf2Aqueh2/CZ9f4Her+RK0EL8xlVBX3NubmHd8SGB
 Q9xxnWgGPoMOsRH0hEKK1K37/QvdwZyVBTh+Mrf6nPyT4PGIpGopaTWsR4oiNgFIG9Zq
 YibExW8KLf/RXqqYYipK3XPPjJdX1Hkdpv6Y8GyFpVkdT+LnfrXnE99XaUT3E4TDsZ0P
 fCnhob1X232zBqKyUY7Sb5/Kl7kVFdE800XEKLdCWzZPkTl1pozCy/JPzpObvWBc4odG
 lAEw==
X-Gm-Message-State: AC+VfDx8EO5TaI5p8aosMiSUuAkcbHoMUoAL9s9GMiUqvkCKkUK34cKw
 4m0coxZULGv4ONOxoSvvvkY=
X-Google-Smtp-Source: ACHHUZ6etXkK+4mG6ib35LVSW7in1WlxE13T4liREG5dH45Lp+Jav0zHwIRoYv+6EWLDDoNezEKeiA==
X-Received: by 2002:a05:6a00:21d4:b0:64c:c5c0:6e01 with SMTP id
 t20-20020a056a0021d400b0064cc5c06e01mr14793580pfj.31.1685366306487; 
 Mon, 29 May 2023 06:18:26 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 c6-20020aa78806000000b0064d2d0ff8d5sm6729103pfo.163.2023.05.29.06.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 May 2023 06:18:26 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: eperezma@redhat.com
Cc: yin31149@gmail.com,
	18801353760@163.com,
	qemu-devel@nongnu.org
Subject: [PATCH 0/2] Vhost-vdpa Shadow Virtqueue Offloads support
Date: Mon, 29 May 2023 21:18:20 +0800
Message-Id: <cover.1685359572.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=yin31149@gmail.com; helo=mail-pf1-x432.google.com
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

This series enables shadowed CVQ to intercept Offloads commands
through shadowed CVQ, update the virtio NIC device model so qemu
send it in a migration, and the restore of that Offloads state
in the destination.

Hawkins Jiawei (2):
  vdpa: Add vhost_vdpa_net_load_offloads
  vdpa: Allow VIRTIO_NET_F_CTRL_GUEST_OFFLOADS in SVQ

 net/vhost-vdpa.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

-- 
2.25.1


