Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EFE7E878B
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Nov 2023 02:33:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1cql-0001z4-DL; Fri, 10 Nov 2023 20:31:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r1cqi-0001yY-On
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 20:31:48 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r1cqg-0001W3-7X
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 20:31:48 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6c3363a2b93so2671216b3a.3
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 17:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699666303; x=1700271103; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fb5l/7MPtXVWmzjrSLllnNYFSmujLY1Dpe/f8MAB7EY=;
 b=IwQYZRzK+wxM0/3fmGQmMRZ/J/LmawCwv7hJJ737RYZIW0FWTsLlu5i4+FkDyr2j2W
 mQBTU2nGg494bIvTNYzvvT/anq+UArMjsCotM29DIFPWqIqtmbxV8AtRTZu3CQdXU4DD
 e4MDNkAsBEIRTzN4PG20MZIb+5FIrSUcgodFfwhexeW6efCOY9NIWoEB4fxNlaI9Ba96
 tBEGcJ0lZrUvfsPT/2k8YGr3xX2AIXNle6uUQGPwIMzZAY9HH9nx5H6MLls7qibWPFac
 mHz/ELF7tirJPTO5UP0r46aLh2ooY5MkLp/AyTXqE1fOYaGEbApL6erpxvFvK2Q4KhfM
 U3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699666303; x=1700271103;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fb5l/7MPtXVWmzjrSLllnNYFSmujLY1Dpe/f8MAB7EY=;
 b=ZP4PFYbnRSVyOmEz/9C5OQdMQN12yT9Knf0Udxffyp5sIWExfp4CE9tKNOOcyorilT
 3AwJ2OAsEejZQgIRyCDLI+xVRJSxlasoAjvRRzvSZ1LK3cX+yKdOcMYdPBwkCMYY2EKx
 jxUTqGRS7U7BG9f/qzzvHAA3nYxNRMzjszP40MS4U6z7ISOGP13m5Kzpt105nS6zzbYO
 3G0j7u7y2+APidqcyu1fBXLGPz6n5mqimNogFA+tFnspUhllkJTqVJY/lXG2s8V/tHRl
 vSLai3PsIChh1t2udi97HkokKwtrVlX4PojjdZE8IR/Zs2M7Z6UJKUCTQZ+yIT622UeL
 74zQ==
X-Gm-Message-State: AOJu0YxUS6CeWTKAOAQ7Wkasl9WVfgWt8xd9b1DHsoiYUFaEtLOPgr/y
 00gLR22aU+sZ9df+aJyKydy6nBGAbsCCob3EpBU=
X-Google-Smtp-Source: AGHT+IFL9i587M1jUt+0pkJjOolNB4YUf4O5PM432V6HnJj9258/sr9HV4gZog9VTRNooE8r7LphZw==
X-Received: by 2002:a05:6a20:8429:b0:181:7d6d:c0f1 with SMTP id
 c41-20020a056a20842900b001817d6dc0f1mr1040541pzd.37.1699666303110; 
 Fri, 10 Nov 2023 17:31:43 -0800 (PST)
Received: from stoup.hsd1.or.comcast.net
 ([2601:1c0:5e02:2a20:a99c:45a6:14e9:ea6])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a170902a9c900b001c60c3f9508sm276465plr.230.2023.11.10.17.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 17:31:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH for-8.2 00/11] target/hppa: PA2.0 fixes
Date: Fri, 10 Nov 2023 17:31:29 -0800
Message-Id: <20231111013141.229605-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Fixes to the recent hppa64 cpu support to enable booting
the 64-bit linux kernel to user-space.


r~


Helge Deller (6):
  target/hppa: Update to SeaBIOS-hppa version 11
  hw/hppa: Require at least SeaBIOS-hppa version 11
  target/hppa: Mask reserved PSW bits in expand_sm_imm
  target/hppa: Fix calculation of CR_IIASQ back register
  target/hppa: Fix possible overflow in TLB size calculation
  hw/pci-host/astro: Fix boot for C3700 machine

Richard Henderson (5):
  target/hppa: Use only low 2 immediate bits for PROBEI
  target/hppa: Use PRIV_P_TO_MMU_IDX in helper_probe
  target/hppa: Introduce MMU_IDX_MMU_DISABLED
  target/hppa: Replace MMU_PHYS_IDX with MMU_ABS_IDX, MMU_ABS_W_IDX
  target/hppa: Reduce TARGET_PHYS_ADDR_SPACE_BITS to 44

 target/hppa/cpu-param.h   |   2 +-
 target/hppa/cpu.h         |  25 +++++-----
 hw/hppa/machine.c         |   2 +-
 hw/pci-host/astro.c       |  73 +++++++++++++---------------
 target/hppa/int_helper.c  |   2 +-
 target/hppa/mem_helper.c  |  97 ++++++++++++++++++++++----------------
 target/hppa/op_helper.c   |   5 +-
 target/hppa/translate.c   |  41 +++++++++-------
 hw/pci-host/meson.build   |   2 +-
 pc-bios/hppa-firmware.img | Bin 755480 -> 681132 bytes
 roms/seabios-hppa         |   2 +-
 11 files changed, 134 insertions(+), 117 deletions(-)

-- 
2.34.1


