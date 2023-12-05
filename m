Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABA880495E
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 06:33:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAO2q-0006mt-Sk; Tue, 05 Dec 2023 00:32:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1rAO2T-0006lA-79; Tue, 05 Dec 2023 00:32:10 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1rAO2Q-0008JW-Tr; Tue, 05 Dec 2023 00:32:08 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5bdb0be3591so3075686a12.2; 
 Mon, 04 Dec 2023 21:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701754323; x=1702359123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6hdTjP845CTa+K1hWq+V/UuFUpEo+Dbi5845nkpb6eE=;
 b=guTS1xRrslzvrT0FprkPGwx29NT4umNDOfZGxR3bHtj8ZFaULq3MBULtXugxU7ppgf
 tsLxFVUcXrpECpNr30INR/oRahC/hn0X60N3fqydPi7cpXxZMC4nV6xeDTcxM3j0Xwoc
 4eqebexxRzvqKx3mD6kijbsIvx4GD0WdE4bRA3Y6urRWqKV4JnXIkO2YhJFBsFdjjUtE
 +b3owumdasPr86hdgKyqlWQGuweRwBlCzd76LhNaZK13gQHTobE02OIsR2NNdEIelV44
 1WYrVpdrnc6a44vFRwaVWhN7UZ+jgbOvIhX6Xx/WjJsbnmCgNU5ty4ujMzKjiduWiOTK
 MiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701754323; x=1702359123;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6hdTjP845CTa+K1hWq+V/UuFUpEo+Dbi5845nkpb6eE=;
 b=EGNZzjfbJ59uWnfjm4Q/NiPEg88x4yPK+io9OJMpp8rie/hd3A8n+nwLVnyLPUrShm
 xANOCBFWBznjqpgfbbeW2LV1m2obkZ8zUSumEAGCOtrpAdITsUGB7W0rWnnRcstV2Psd
 AiZr6/Al6P3L3z1HKKu1gbycQvwtbjzIE0goUYBl+FPlcVNRfcpmNatTQwRJMjkfJ3Ct
 s5qcgjgOecJvHbxTmddCjHMdS+/CZTjRf4GA7jzY0F68fhF5zD1FyCme4lo2UaDVdYDs
 obvIfA4mUzbMK7pduVxdU/cyvMPO8nMSqkNMjnmzKdTaLVygRO9lDUL9LOqBdUJljrjp
 wMBg==
X-Gm-Message-State: AOJu0Yzk5NBpsGzzomYfyvd67XhWFT50pjHF2sawQE+zz6xoLwMziqc0
 wEfP4ZqbAsdUDv4U0gZ6K+4=
X-Google-Smtp-Source: AGHT+IHY4dSnAdLEiIo0HUvBuFxbEc7wq2+HAafbHzjeBn9J1f5elke87dOGe7JRwc+eX35JkJ4FYg==
X-Received: by 2002:a17:902:ab8f:b0:1d0:6ffd:e2b6 with SMTP id
 f15-20020a170902ab8f00b001d06ffde2b6mr4821228plr.80.1701754322719; 
 Mon, 04 Dec 2023 21:32:02 -0800 (PST)
Received: from jeuk-MS-7D42.. ([218.147.112.168])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a170902ee8500b001cfc42ccfcasm7581806pld.152.2023.12.04.21.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 21:32:02 -0800 (PST)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: stefanha@redhat.com
Cc: jeuk20.kim@gmail.com, jeuk20.kim@samsung.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PULL 0/1] ufs fix for 2023-12-05
Date: Tue,  5 Dec 2023 14:30:51 +0900
Message-Id: <cover.1701752391.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pg1-x530.google.com
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

From: Jeuk Kim <jeuk20.kim@samsung.com>

The following changes since commit 1664d74c50739401c8b40e8b514d12b5fc250067:

  tests/avocado: Update yamon-bin-02.22.zip URL (2023-12-04 08:17:35 -0500)

are available in the Git repository at:

  https://gitlab.com/jeuk20.kim/qemu.git tags/pull-ufs-20231205

for you to fetch changes up to 80a37b039ea9473d038bcef8bb64f4213affeae8:

  hw/ufs: avoid generating the same ID string for different LU devices (2023-12-05 13:57:18 +0900)

----------------------------------------------------------------
ufs fixes for 8.2

- Fix QEMU not starting when creating two UFS host controllers

----------------------------------------------------------------
Akinobu Mita (1):
      hw/ufs: avoid generating the same ID string for different LU devices

 hw/ufs/ufs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

