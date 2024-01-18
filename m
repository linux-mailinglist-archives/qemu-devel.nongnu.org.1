Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8157C831B76
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 15:36:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQTUB-0000bK-AF; Thu, 18 Jan 2024 09:35:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQTU8-0000aP-RC; Thu, 18 Jan 2024 09:35:12 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQTU5-0002fQ-Ds; Thu, 18 Jan 2024 09:35:12 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1d5e004f592so16757215ad.3; 
 Thu, 18 Jan 2024 06:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705588507; x=1706193307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=D7hWGbds9yl2973IH2tZEpIAf6CF2SzkCWtoWy7dTAA=;
 b=DjfQAFooRtCiCjtCVJ/zRJhT4WeDTMJC3XWIJCjmID7l8bTcc8oGkJiMRp+HEMzxAb
 zDtCZUlqh3+8T9eK72FjaD7Ex/bSSHH0zIp+5JeDpJkF4MSkDcZKImSg8ZZ4JNZJvEe0
 RY8O7c83txyKe5JELb8m+RiRBeeFeUwdz9fYPWh4mlwRpZhNBlhcu3qs9CYBUIVC4M6P
 2nRIdciqGw5lQtY3p+YZNhCfrdggcEbEv0gKBSNdc72w32ElT6ZPYP7fvD51QzRV5YMp
 VsqznfN3T1XZNs+REWeIVp5gYX0pXuMT5UyopuKV7np+jT2GKPLNMXBQFe8hkfwgGcqk
 JM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705588507; x=1706193307;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D7hWGbds9yl2973IH2tZEpIAf6CF2SzkCWtoWy7dTAA=;
 b=tQeaLahjkacIUJAiCHSyxwucm1AzHOefuJXdW2HBizs6sCWhL+eL+vALGatYXfp/QB
 OiiwKVHuFusuKWvPsFUCDiKiwZ5fKeb/LsW8G1g33qy69Pw7FYdof23ZA5Jpi1GJ5MCo
 mgG86mbUihJoTU2HrY5CPfQYe341m972cc0V1mfFZcRKQuaZJEEZO/XqzG0ofDO6psvA
 8eXRBxagZDHK8eDsYpN8tD3z7V0OZAQPpZn7q9+Dq0M3ZcVI9oJZfYgnAP3L8AEYnMZ0
 RoVBg7XqdnFQ2uus7DUGpbD6e4e+G11CLRAdDHo8sZT/F58y/FawtCNUBbn3Q2eX51CH
 tNJw==
X-Gm-Message-State: AOJu0Yz1jXjXAtUvAm8mun1ORl4qQdP51EME3+IWvoDlP13erdY+Ogpp
 NSPCVn2ePH+XQwWixAO9dAt3BTzhhomypD7Fr3dkYY3ubVA7T1BLFTSAtQjk
X-Google-Smtp-Source: AGHT+IGN10y1SvEfws9reFzNwsJjpKOcSTu6XuF/6S8xvGLHLecOTE65wz+SLKAvwuptj0NdNJOc/Q==
X-Received: by 2002:a17:902:708c:b0:1d5:e213:64fc with SMTP id
 z12-20020a170902708c00b001d5e21364fcmr756364plk.132.1705588507442; 
 Thu, 18 Jan 2024 06:35:07 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 la11-20020a170902fa0b00b001d4ac461a6fsm1484371plb.86.2024.01.18.06.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 06:35:07 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 0/4] ppc: add machine check injection HMP command
Date: Fri, 19 Jan 2024 00:34:55 +1000
Message-ID: <20240118143459.166994-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
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

I'd like to resurrect this and get it merged, because it's quite
useful for testing (has caught several Linux bugs in the past).

IIRC the main concern David had last time it came up was that it
should have QMP commands too. Which is valid. But I ended up
deciding it wouldn't be nice to expose this low level interface too
much, it would be better to use maybe a higher level error injection
interface that would be emulated in more detail (e.g., not just a
MCE, but would set relevant FIR registers and go through error
handling logic).

Since x86 has a low level 'mce' hmp command without qmp equivalent,
and since better error injection might take some time, I'd like to
just hold nose and take this for now.

Thanks,
Nick

Nicholas Piggin (4):
  nmi: add MCE class for implementing machine check injection commands
  ppc/spapr: Implement mce injection
  target/ppc: Add machine check interrupt injection helper
  ppc/pnv: Implement mce injection

 include/hw/nmi.h             | 20 ++++++++++++
 include/hw/ppc/spapr.h       |  3 ++
 include/monitor/hmp-target.h |  1 -
 include/monitor/hmp.h        |  1 +
 target/ppc/cpu.h             |  1 +
 hw/core/nmi.c                | 61 ++++++++++++++++++++++++++++++++++++
 hw/ppc/pnv.c                 | 55 ++++++++++++++++++++++++++++++++
 hw/ppc/spapr.c               | 54 +++++++++++++++++++++++++++++++
 hw/ppc/spapr_events.c        |  3 +-
 monitor/hmp-cmds.c           |  1 +
 target/ppc/excp_helper.c     |  7 +++++
 target/ppc/ppc-qmp-cmds.c    | 10 ++++++
 hmp-commands.hx              | 20 +++++++++++-
 13 files changed, 233 insertions(+), 4 deletions(-)

-- 
2.42.0


