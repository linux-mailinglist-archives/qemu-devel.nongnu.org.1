Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7CE71731C
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 03:23:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4AYk-0004Gv-Nq; Tue, 30 May 2023 21:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q4AYh-0004Bj-EX; Tue, 30 May 2023 21:23:27 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q4AYf-0005FC-HJ; Tue, 30 May 2023 21:23:27 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1b04706c85fso23305185ad.0; 
 Tue, 30 May 2023 18:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685496203; x=1688088203;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QBsgDic338ev1UsBM9NktZHW+krHEqrybfAB+SU5sG4=;
 b=ebVe7yCqtbmE13xbBc4hdDPJeGYbIM1706euuMf8Njl2d/IuTRQxX9n56XBghGuISK
 cPpJuTiDXI3V8kQjVVyjIEABvTQRsAbetqTRvfVV++IfYogZ+JMTq3skuSeCmVGN2ZBu
 XVLc82UvRiswzHyRCqtSCKcFsLGuMaSYFovbrCvTIq2qQoYUbVZViAbKDHK2w44PNzBw
 LFpnWtJme87LvhKwfJCkNm2NOig1IPafgc4bDTgCi4alFE61VkAsy7PXx0rhlCYdDuBd
 bemZk1xemJ8kiYYjpr/7GzJ5f0JMNL804IJ5TU3TwA7h+M8VD/iE6+KheUe0Z0ltnWmT
 DJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685496203; x=1688088203;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QBsgDic338ev1UsBM9NktZHW+krHEqrybfAB+SU5sG4=;
 b=DQnHQwhJzt/u3az//uTks6tNFgYw6Sm6Vph6kNZ34ux83ZYanCLvj+bhviOCkNOodN
 Xjd9ZI1u58NWF/AqAG/9bpXaPXqHqBVUOQmLyXgOKgeGBLWQMPvxXkmfhavkMeF2yiJ0
 7Dxw+IBjeG63e1adKJuq6AgxXEJgFoBeoqPl+4WCpzFpp8nYqojGclC/tXqoxPSyxogq
 0F6339biq641cydoB3bwr+TaoGzR0grL5KWRZMQbNftVnoTbg+ZlzbaBFl9TI4EoZR9s
 f3IeIwfDLvaMwNvJLMME69s0cSHa7q4CB7rMnhbq/jSYeT5eulzjB1ahKBZ2AfsVV/TH
 B93w==
X-Gm-Message-State: AC+VfDxqMfM7vqxKl3Ee1d98DasDtI3HnFl8NwA0toAOBvUL1EX/2Vmr
 p+jS1hXJ0PuWf9iSvbiUlFRLDrmREWI=
X-Google-Smtp-Source: ACHHUZ4rTG5grvuPI+sTYKvgkbRHLccYM9cRUGe7G04FosUi4DgcybXQSvqWXdtWczvTdE4UONkqlQ==
X-Received: by 2002:a17:902:e744:b0:1af:de3d:bbe3 with SMTP id
 p4-20020a170902e74400b001afde3dbbe3mr4307722plf.26.1685496202883; 
 Tue, 30 May 2023 18:23:22 -0700 (PDT)
Received: from wheely.local0.net ([203.221.142.9])
 by smtp.gmail.com with ESMTPSA id
 9-20020a170902c10900b00186a2274382sm10928840pli.76.2023.05.30.18.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 18:23:22 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [RFC PATCH 0/5] target/ppc: initial SMT support in TCG
Date: Wed, 31 May 2023 11:23:08 +1000
Message-Id: <20230531012313.19891-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi,

I'm posting this now just to get some first thoughts. I wouldn't say
it's ready but it does actually work with some basic tests including
pseries booting a Linux distro. I have powernv booting too, it just
requires some more SPRs converted, nothing fundamentally different so
for the purpose of this RFC I leave it out.

A couple of things, I don't know the object model well enough to do
something nice with topology. Iterating siblings I would have thought
should be going to parent core then iterating its children CPUs. Should
that be done with the object model, or is it better to add direct
pointers in CPUs to core and core to CPUs? It is (semi) important for
performance so maybe that is better than object iterators. If we go that
way, the PnvCore and SpaprCore have pointers to the SMT threads already,
should those be abstracted go in the CPUCore?

The other thing is the serialisation of access. It's using the atomic
single stepping for this which... I guess should be sufficient? Is it
the best way to do it though? Can a lock be used somehow instead?

Thanks,
Nick

Nicholas Piggin (5):
  target/ppc: gdbstub init spr gdb_id for all CPUs
  target/ppc: Add initial flags and helpers for SMT support
  target/ppc: Add support for SMT CTRL register
  target/ppc: Add msgsnd/p and DPDES SMT support
  spapr: Allow up to 8 threads SMT configuration

 hw/ppc/ppc.c                                  |  6 ++
 hw/ppc/spapr.c                                |  4 +-
 hw/ppc/spapr_cpu_core.c                       |  7 +-
 include/hw/ppc/ppc.h                          |  1 +
 target/ppc/cpu.h                              | 16 +++-
 target/ppc/cpu_init.c                         |  5 +
 target/ppc/excp_helper.c                      | 86 ++++++++++++-----
 target/ppc/gdbstub.c                          | 32 ++++---
 target/ppc/helper.h                           |  4 +-
 target/ppc/misc_helper.c                      | 93 +++++++++++++++++--
 target/ppc/translate.c                        | 46 ++++++++-
 .../ppc/translate/processor-ctrl-impl.c.inc   |  2 +-
 12 files changed, 252 insertions(+), 50 deletions(-)

-- 
2.40.1


