Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B755B832FF8
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 21:47:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQvl8-0006Tw-H3; Fri, 19 Jan 2024 15:46:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1rQvkz-0006TI-VN
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 15:46:31 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1rQvkw-0001kf-SS
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 15:46:28 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6d99980b2e0so1258786b3a.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 12:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705697184; x=1706301984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=v8qksGej6ArUnbGgIby4i03JQyp+KjxGP4eMg9vLSmg=;
 b=H4Szig8y67sBldo3FH4Smjt4IXFjdNL4PqC6U9rESCHmENYqS6PVcGQMUOlotuzW6P
 PSHABfZ/jt2oCR3I/4Y7ZXsHot7XjxkpH4Ce/M8CSLp6+1c6xPjLsNQNE/l3QXpGXglQ
 MSAnZ710XtLuPTH9VfBtMdxA/ncIay12H7te5QmnVpDNx60WUFSjMInit0Z3e6AVQLHp
 PmfpPqpv6H8RabsJuR5xe8MNP1VNRHOp3/xtY8JuzTLmqZJjMV/cpuorKlbipiCUHIOL
 +RRRC3GoYrUKHTqo7mB6Xfb6/4H3wXMdX/ey5HD3dArEY6xGrlSbkRcPuOZfO4ZBHd7j
 3hbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705697184; x=1706301984;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v8qksGej6ArUnbGgIby4i03JQyp+KjxGP4eMg9vLSmg=;
 b=rMUZDlRFGIYOH/xnntTJslE8tLlthgDmr0lvvQcCDTa9EsSmlILNswGNcn+LbZ+Oou
 8MJS7YV7eOWqj5qyb5qQ51fbD+Diq8DYGzb/tzw5xDyAvAHhiIsIrtQoSziTLoC4WuV0
 h2FyvBSYKKsK5g1kwvYFvpIeGUWMlDKcwc05z5yXhwS+EUqdBZ6CjG7vk/805v+KW7Mp
 fmoGyIkieBdxZjWn7Y9c12Vd6c7UUhn2bUI4794NJV1mkJ+MdxqlCupKtqH1F4yRy8h1
 nwgmzBhq1H44Q4tk4BgrgK62kyMraYRm0ot+OMXO4FO1ofqHVree46BBycEd4hZH6ufG
 XmPw==
X-Gm-Message-State: AOJu0YwurkODc48Je6ec4nRCyEmtrE6gGtbUDJFHCnnse3ab1DlYg3Nv
 xdCvJqwavJn7p/DcXoQuasoaffG1R9RrbE3i+eMWyqwIE6Brw+h2yeMJqgCi
X-Google-Smtp-Source: AGHT+IEYjqgw5E82kaefbTJd6JfZeoRn3Gf9srWh0TVERWtfySTG9R5VjBroBhjVPR2Vu09qInSMtA==
X-Received: by 2002:a05:6a21:3183:b0:199:e9cf:5fc0 with SMTP id
 za3-20020a056a21318300b00199e9cf5fc0mr528295pzb.63.1705697184536; 
 Fri, 19 Jan 2024 12:46:24 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net
 (c-73-63-239-93.hsd1.ca.comcast.net. [73.63.239.93])
 by smtp.gmail.com with ESMTPSA id
 kq9-20020a056a004b0900b006db85b12036sm5535228pfb.137.2024.01.19.12.46.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 12:46:24 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 0/2] target/xtensa: tidy xtensa memory management
Date: Fri, 19 Jan 2024 12:46:06 -0800
Message-Id: <20240119204608.779541-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.998, HK_RANDOM_FROM=0.998,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hello,

this series separates xtensa MMU and MPU states and improves variable
TLB way logic.

Max Filippov (2):
  target/xtensa: wrap MMU and MPU state into structures
  target/xtensa: tidy TLB way variability logic

 target/xtensa/cpu.h          | 21 +++++++---
 target/xtensa/mmu_helper.c   | 74 ++++++++++++++----------------------
 target/xtensa/overlay_tool.h | 15 +++++++-
 3 files changed, 56 insertions(+), 54 deletions(-)

-- 
2.39.2


