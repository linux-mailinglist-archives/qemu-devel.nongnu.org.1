Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F52E7704B3
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 17:30:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRwl1-0006D2-3y; Fri, 04 Aug 2023 11:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qRwkv-0006Au-9y; Fri, 04 Aug 2023 11:30:21 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qRwkt-0004LY-OZ; Fri, 04 Aug 2023 11:30:21 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6bcd4b5ebbaso769078a34.1; 
 Fri, 04 Aug 2023 08:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691163015; x=1691767815;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cjiyicEk3Y9Yrss7LlYTwAlVsgSRcEm72ZZwgwcPRyE=;
 b=K1Cdaus6mPlwFMGjqvjuWEiYXrr/Ds4+quEvd0e/9kmfaJf9TIbV+kIY8wn1HTljYy
 HSgnSwdYv/WjKLbIHKvbSeBam/yYhKHp18l6v+Iaq0r8gOua0emyeK8yD07jxFi1ryil
 Z5iZftqexB1DgYbPanZ93sKJvFfJfH8PTKhgkskDTfA5LaLejUN+R/loYX2j9fWi3Vmh
 +KhdBzYImoMPm14oOYY7pSlYLtH8fanK0XdCjr9D/JLYAecth/kknTDt2oPzgy5zDW5e
 qQDQPw7RCKQRyBnndLnfvNz0CESB7c7gwYaQmtf8sYL89ftcR3VBmw9F6jh3DQoQULpl
 CWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691163015; x=1691767815;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cjiyicEk3Y9Yrss7LlYTwAlVsgSRcEm72ZZwgwcPRyE=;
 b=e+VKJQ3k+3haKYL+sNZBYOWwL/Za7d6bm4xaJhAJRUFkZRsehxXi8KPaZoqp3nq3ML
 +BrzbCqDC4EdTnLT3bFwCtImYPZ7L3Q7PPoBReXIzZZnMR7qEALjBMiPKiox8oW7Vnil
 6udeuB2XZ3D4AeMiEsoJG4f4mnqsXuamfTDhr4lqmfWjUl/Z+6MpoYlteIK4HaeWe9uC
 YagArqVqCTDG3FvCD2kY4WUlhgKpLTZQR9BnCgUr81VQw723ZtxU6W/KoLiRhM7lT7lx
 V9c+tt+PawUpJQj9R+C/JL9rLhbq0/0gbxfI5Z3dAEKRtilaffHLv9deBb5t+MrfC3J0
 C1Sg==
X-Gm-Message-State: AOJu0YwuOw/2yvqQyzkmXhlHV1gJmLv0X0rppOAUSdGJhsF+5/gP2CwJ
 yUx2fIXwC99pvHGXy3a2MmHImrt+t6Y=
X-Google-Smtp-Source: AGHT+IFoIUnMN5ounnN29KTuuJc5+KCFRiULMvggSFOM4saq0KKCAyEoQkMuUSlCjEB654coPi801A==
X-Received: by 2002:a05:6870:8089:b0:1be:fdae:601b with SMTP id
 q9-20020a056870808900b001befdae601bmr2981089oab.52.1691163015717; 
 Fri, 04 Aug 2023 08:30:15 -0700 (PDT)
Received: from grind.. ([177.197.108.190]) by smtp.gmail.com with ESMTPSA id
 q4-20020a4a4b04000000b00560b1febfdfsm1115761ooa.10.2023.08.04.08.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 08:30:15 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org
Subject: [PULL 0/7] ppc queue
Date: Fri,  4 Aug 2023 12:29:48 -0300
Message-ID: <20230804152955.22316-1-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x332.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The following changes since commit c26d005e62f4fd177dae0cd70c24cb96761edebc:

  Merge tag 'hppa-linux-user-speedup-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2023-08-03 18:49:45 -0700)

are available in the Git repository at:

  https://gitlab.com/danielhb/qemu.git tags/pull-ppc-20230804

for you to fetch changes up to 0e2a3ec36885f6d79a96230f582d4455878c6373:

  target/ppc: Fix VRMA page size for ISA v3.0 (2023-08-04 12:22:03 -0300)

----------------------------------------------------------------
ppc patch queue for 2023-08-04:

This queue contains target/ppc register and VRMA fixes for 8.1. pegasos2
fixes are also included.

----------------------------------------------------------------
BALATON Zoltan (4):
      ppc/pegasos2: Fix reset state of USB functions
      ppc/pegasos2: Fix reg property of ROM BARs
      ppc/pegasos2: Fix naming of device tree nodes
      ppc/pegasos2: Fix reg property of 64 bit BARs in device tree

Nicholas Piggin (3):
      target/ppc: Implement ASDR register for ISA v3.0 for HPT
      target/ppc: Fix pending HDEC when entering PM state
      target/ppc: Fix VRMA page size for ISA v3.0

 hw/ppc/pegasos2.c        | 24 ++++++++++++++--
 target/ppc/excp_helper.c |  6 ++++
 target/ppc/mmu-hash64.c  | 72 ++++++++++++++++++++++++++++++++++++------------
 target/ppc/mmu-hash64.h  |  5 ++++
 4 files changed, 88 insertions(+), 19 deletions(-)

