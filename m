Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8934579DD51
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 03:00:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgEDP-0001ok-6u; Tue, 12 Sep 2023 20:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qgED7-0001nf-4Z; Tue, 12 Sep 2023 20:58:30 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qgED3-0003Nw-Am; Tue, 12 Sep 2023 20:58:27 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-273d10d3df3so4166591a91.3; 
 Tue, 12 Sep 2023 17:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694566702; x=1695171502; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hq5QZs4F1DLQmA7jxSW/fHvxYyRNglWvE46aRach8Oo=;
 b=nccfCSY7zIuc+HAurhrIPzQvwKZuIKvte5GbxFPsBFXsjJY8soh6mrYzyhNqocFvhF
 wZn2hmC3xwj/sRLK4kpfT7jq5glUA2EPYPMkPN2tNVhisM5ckhh+iloLFCJG+bIjEvcF
 mGAPTWZj6Qj2ktihjp5E40B5d3ehkkoNqe3/oS8nUW1Y54CxmlIso+6BspSaJl6rIGlR
 pIom1aMPRWPaplQjNfh8ZXSUglRZcIB7CtMlPShKSwJx6oEBD/Vq0+uWi7398eMb2/am
 j3/5+PdupXwyQD6sfEbmezzBXeXi5DIO2FDrx+Jz/cLQNvv/qGl8ZncHmR3VczBdZAAH
 qv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694566702; x=1695171502;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hq5QZs4F1DLQmA7jxSW/fHvxYyRNglWvE46aRach8Oo=;
 b=K9Fq3DcnY0BlP0YRcNm/23qi/eBM8+9U76Wq4DkiEsNzAJETnn9U+qEJbDl1x9lLHu
 OINKki61gxVCd1UnET+1wnbpG+bniM0i6U0D55qeaYx7BeO2seudRt5MLEPWeQ55sRdI
 GikQF1LLIYEswPFlQdqVmpcdWf06OAhXWj4fXrZkj8fdmety9nqKATlKcXi8dreMdaKz
 E5iDZTu9dgVe9LIYd/fyJMui9FqnQgN6/J3CYXOztiDjhCBKPQXHr8nHOiFMx07S4AID
 D51xiqXrgwMIyv6Sr6qG0ID5SXCYqGGaS2Q9AfpgSYDDmHeHr02P9sHU+jjNV7/QXMHO
 gGdA==
X-Gm-Message-State: AOJu0YxDGkTbwkbCrV+WNg1YYk1p/jdDmPpbXHOIQcrpo/RpBqcAkWE1
 HMvdIHwvdOgOyDlBR+EzBPpH1OBqifw=
X-Google-Smtp-Source: AGHT+IH9GgDXrdALUeCbfHZYDZl6DkCuguVJPGHl65WHu5Ni5m+LzPlqT8ZCwyeMJyKjmBxjrRb4jA==
X-Received: by 2002:a17:90b:234f:b0:267:faba:705 with SMTP id
 ms15-20020a17090b234f00b00267faba0705mr980823pjb.10.1694566702602; 
 Tue, 12 Sep 2023 17:58:22 -0700 (PDT)
Received: from wheely.local0.net ([193.114.103.68])
 by smtp.gmail.com with ESMTPSA id
 j2-20020a17090a588200b0026f4bb8b2casm208868pji.6.2023.09.12.17.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 17:58:22 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 qemu-devel@nongnu.org
Subject: [RFC PATCH 0/3] target/ppc: Change CR registers from i32 to tl
Date: Wed, 13 Sep 2023 10:58:11 +1000
Message-Id: <20230913005814.413113-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is a bit of churn so I might leave it for later in the cycle (or
defer if we get a lot of other changes) since it's a relatively
mechanical change. So don't spend time reviewing details, I'm just
wondering about concept and general approach.

I'm not sure the history of why these are 32-bit, maybe better code gen
on 32-bit host emulating 64-bit? If so, that shouldn't be so important
now that most people use 64-bit systems to develop and test with.

Thanks,
Nick

Nicholas Piggin (3):
  target/ppc: Change CR registers from i32 to tl
  target/ppc: Use FP CR1 update helper more widely
  target/ppc: Optimise after CR register tl conversion

 target/ppc/cpu.h                             |   2 +-
 target/ppc/cpu_init.c                        |   2 +-
 target/ppc/dfp_helper.c                      |  12 +-
 target/ppc/fpu_helper.c                      |  38 +--
 target/ppc/helper.h                          | 124 +++++-----
 target/ppc/int_helper.c                      |  58 ++---
 target/ppc/machine.c                         |   2 +-
 target/ppc/translate.c                       | 239 +++++++++----------
 target/ppc/translate/fixedpoint-impl.c.inc   |   3 +-
 target/ppc/translate/fp-impl.c.inc           |  31 +--
 target/ppc/translate/spe-impl.c.inc          |  18 +-
 target/ppc/translate/storage-ctrl-impl.c.inc |   4 +-
 target/ppc/translate/vmx-impl.c.inc          |  24 +-
 target/ppc/translate/vsx-impl.c.inc          |   6 +-
 15 files changed, 267 insertions(+), 298 deletions(-)

-- 
2.40.1


