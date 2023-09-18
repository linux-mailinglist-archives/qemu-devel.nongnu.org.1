Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 566547A4A95
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 15:30:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiEJc-0003zv-Op; Mon, 18 Sep 2023 09:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qiEJa-0003ze-Pl; Mon, 18 Sep 2023 09:29:26 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qiEJZ-0003W2-5L; Mon, 18 Sep 2023 09:29:26 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3a88ef953adso3177471b6e.0; 
 Mon, 18 Sep 2023 06:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695043763; x=1695648563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fK0kuypElg49sloaLIdM1Ov8y3roW9lqXQXQ5vx4VSs=;
 b=C/9ZiOVtnZEBJKElCN4g5YUhPe7jZ2fMlvEm5ek9idkfE2nRBzdez9pRjTcKFaa/Uh
 xgdO9HZYUkE7xeSe8TTmZ4TYAEgtN1SPQKycpTDiK9pGgUK/K2T+V8O98STOBVBvin6d
 gqaOJ0m/fUmAVr4OoJrYw/iTpW1pqpjO197Upox/Z+5/P8eEMmDMrvYFTVUPW5hJoVIx
 puVlOB/vZCywu0AB9PMjYixTFFuDc91Yy4a1IEZkBDXqyxZIuNPXoaOQi96ByAG+jYEs
 +KxevSpEbd6PNvJDscosUwYDd19MyeInybMCOurlKyzu3ygrNVwLm9bkG2cAw/Hagd0K
 aV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695043763; x=1695648563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fK0kuypElg49sloaLIdM1Ov8y3roW9lqXQXQ5vx4VSs=;
 b=RL4oqSRimLGsy4eRar5cAquqYivGEY9fJzRNvOF+Opc3nOgWyASqwUBwh7wnbt6jip
 m5j+mlhL6PykdFzWCdpJZBkLFjgLt/DtUR74H3V3pcJMBepa+y9lxxEKIU6tpZmNTAxi
 zhLI6/kQ4gFtbjCBhoRUr9+DslL6tPZH51/R/fnYKl7F9uY10XEgK4dxMyn4bYLqhfN+
 DHt/gPOCm+VVDIv+MbTJ64EbPeXB0kR0M6WZj9euHnt3xTUinyUZXVI+LStpSsSVOhs/
 sA3kXiSV6qvqTTkBOf7oYp9A0X2cs4xZ7NO0nGcLwEUoOjGiKH85efaFIENzdvDbIBLv
 4wyA==
X-Gm-Message-State: AOJu0Yx/cLVpyRkbZ9q4zFiTxUVe5TNOHMne1bbHirmnrUNovhrkPYnU
 oycrCT3YpZeE2pGof3SEvyBFlL0QXXg=
X-Google-Smtp-Source: AGHT+IF9e30ejuU6tjoiPYt/TDuDod4U1NeED6hCN9uuU8+hU89v3gam1Kq5ZN1p8r3Ik159FUaEWg==
X-Received: by 2002:a05:6870:a70e:b0:1c8:b715:6c81 with SMTP id
 g14-20020a056870a70e00b001c8b7156c81mr10209797oam.55.1695043763322; 
 Mon, 18 Sep 2023 06:29:23 -0700 (PDT)
Received: from grind.. ([152.234.127.211]) by smtp.gmail.com with ESMTPSA id
 y1-20020a056870a34100b001c8f250820esm4927161oak.48.2023.09.18.06.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Sep 2023 06:29:23 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 clg@kaod.org, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PULL 1/3] MAINTAINERS: Nick Piggin PPC maintainer, other PPC changes
Date: Mon, 18 Sep 2023 10:29:10 -0300
Message-ID: <20230918132912.291204-2-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918132912.291204-1-danielhb413@gmail.com>
References: <20230918132912.291204-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x22d.google.com
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

Update all relevant PowerPC entries as follows:

- Nick Piggin is promoted to Maintainer in all qemu-ppc subsystems.
  Nick has  been a solid contributor for the last couple of years and
  has the required knowledge and motivation to drive the boat.

- Greg Kurz is being removed from all qemu-ppc entries. Greg has moved
  to other areas of interest and will retire from qemu-ppc.  Thanks Mr
  Kurz for all the years of service.

- David Gibson was removed as 'Reviewer' from PowerPC TCG CPUs and PPC
  KVM CPUs. Change done per his request.

- Daniel Barboza downgraded from 'Maintainer' to 'Reviewer' in sPAPR and
  PPC KVM CPUs. It has been a long since I last touched those areas and
  it's not justified to be kept as maintainer in them.

- Cedric Le Goater and Daniel Barboza removed as 'Reviewer' in VOF. We
  don't have the required knowledge to justify it.

- VOF support downgraded from 'Maintained' to 'Odd Fixes' since it
  better reflects the current state of the subsystem.

Acked-by: Cédric Le Goater <clg@kaod.org>
Acked-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20230915110507.194762-1-danielhb413@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 MAINTAINERS | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 00562f924f..c4aa1c1c9f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -298,11 +298,9 @@ F: hw/openrisc/
 F: tests/tcg/openrisc/
 
 PowerPC TCG CPUs
+M: Nicholas Piggin <npiggin@gmail.com>
 M: Daniel Henrique Barboza <danielhb413@gmail.com>
 R: Cédric Le Goater <clg@kaod.org>
-R: David Gibson <david@gibson.dropbear.id.au>
-R: Greg Kurz <groug@kaod.org>
-R: Nicholas Piggin <npiggin@gmail.com>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: target/ppc/
@@ -438,10 +436,9 @@ F: target/mips/kvm*
 F: target/mips/sysemu/
 
 PPC KVM CPUs
-M: Daniel Henrique Barboza <danielhb413@gmail.com>
+M: Nicholas Piggin <npiggin@gmail.com>
+R: Daniel Henrique Barboza <danielhb413@gmail.com>
 R: Cédric Le Goater <clg@kaod.org>
-R: David Gibson <david@gibson.dropbear.id.au>
-R: Greg Kurz <groug@kaod.org>
 S: Odd Fixes
 F: target/ppc/kvm.c
 
@@ -1430,10 +1427,10 @@ F: include/hw/rtc/m48t59.h
 F: tests/avocado/ppc_prep_40p.py
 
 sPAPR (pseries)
-M: Daniel Henrique Barboza <danielhb413@gmail.com>
+M: Nicholas Piggin <npiggin@gmail.com>
+R: Daniel Henrique Barboza <danielhb413@gmail.com>
 R: Cédric Le Goater <clg@kaod.org>
 R: David Gibson <david@gibson.dropbear.id.au>
-R: Greg Kurz <groug@kaod.org>
 R: Harsh Prateek Bora <harshpb@linux.ibm.com>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
@@ -1452,8 +1449,8 @@ F: tests/avocado/ppc_pseries.py
 
 PowerNV (Non-Virtualized)
 M: Cédric Le Goater <clg@kaod.org>
+M: Nicholas Piggin <npiggin@gmail.com>
 R: Frédéric Barrat <fbarrat@linux.ibm.com>
-R: Nicholas Piggin <npiggin@gmail.com>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: docs/system/ppc/powernv.rst
@@ -1497,12 +1494,9 @@ F: include/hw/pci-host/mv64361.h
 
 Virtual Open Firmware (VOF)
 M: Alexey Kardashevskiy <aik@ozlabs.ru>
-R: Cédric Le Goater <clg@kaod.org>
-R: Daniel Henrique Barboza <danielhb413@gmail.com>
 R: David Gibson <david@gibson.dropbear.id.au>
-R: Greg Kurz <groug@kaod.org>
 L: qemu-ppc@nongnu.org
-S: Maintained
+S: Odd Fixes
 F: hw/ppc/spapr_vof*
 F: hw/ppc/vof*
 F: include/hw/ppc/vof*
-- 
2.41.0


