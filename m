Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1967A1D19
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 13:06:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh6df-00074O-2F; Fri, 15 Sep 2023 07:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qh6dV-00072L-KT; Fri, 15 Sep 2023 07:05:23 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qh6dT-0003Du-OM; Fri, 15 Sep 2023 07:05:21 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3a7ca8720a0so1241776b6e.2; 
 Fri, 15 Sep 2023 04:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694775918; x=1695380718; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s2qJqpHwIiH62Z1Y+zBBpb+4FQJFpoLY7LPSH6IwqB0=;
 b=evJsl+x3Lyt67AoIOQUtH32F2LGHj2c7tFNyQWMuDcmtX4jPpnClNZj7YJ0UYv0/qR
 1qAkp02VAzkqS31URLwyscQzfZGNe8qYa4kXi8alYMi2buJXuiio2+DuG0SGKCKxb+EU
 HgyQ6dLmea948mfOpNTypvyJWzvX42Q10FFgL4sD3MjZbSE9B5B0qkqhqLmf17Hnu2lO
 RPnKwcaZzfvgfs2DKuOvfY1PUwArwRJ3UxVRH+hrRewxOA9rAUlToIXOtBbPfUHgjzz8
 TAPDStZzhRxVUvn+y9qNTSkk0xTlFBbeOTfMkjyr6woI5v4RKHjyiP3vYAzhLWLdwktq
 vHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694775918; x=1695380718;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s2qJqpHwIiH62Z1Y+zBBpb+4FQJFpoLY7LPSH6IwqB0=;
 b=GdY26wvAv4i/2+mY9rlna+CErXTIVzWlZzL2XT7MbCmkVwN8e3ND+c4OcvjuHR+1IS
 a33UBAsH//HEnM9z5tdhJ3KaQMIpNZ6IMWqS17V3xdgS93DRcUAVN1G7N1yADfk9PJe0
 DDLxsNWtXbXK5Upom/50IMP9cNHlVXiOB9EXwAFlU6SiS8Iq/ZnFodfTKBDxy8fDeeEi
 RavavY0qBW1QplA3rjsvbntXO049oEF3kw7VhorEMqfpO3NhaEu8J3kP09TIN9H1blhO
 OpScS7CPSiAuwqkzYubZqRe8Pg0zGhniJ0VMc0y60odKfHG+S9jbRTK2AKUe1O0wT7ix
 e27Q==
X-Gm-Message-State: AOJu0YyRZbxDgDGg3kx5VbmLcUjp51rTM2w4Z9693EaY8EBRt7v0GrOs
 fD+ed6kyjRvrG/Ua5W64s37n26Gj8KU=
X-Google-Smtp-Source: AGHT+IF38Yn6192xZ5mypT1eIXBWhrRRI+RRQpXvIkRc+lymR9RiWvbGEu84s7eSxtbK3fTUPKTjiQ==
X-Received: by 2002:a05:6870:468e:b0:1b3:715c:463e with SMTP id
 a14-20020a056870468e00b001b3715c463emr1612628oap.0.1694775917809; 
 Fri, 15 Sep 2023 04:05:17 -0700 (PDT)
Received: from grind.. ([177.9.182.82]) by smtp.gmail.com with ESMTPSA id
 h22-20020a056870a3d600b001ccab369c09sm1730291oak.42.2023.09.15.04.05.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 04:05:17 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, groug@kaod.org,
 npiggin@gmail.com, aik@ozlabs.ru,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH] MAINTAINERS: Nick Piggin PPC maintainer, other PPC changes
Date: Fri, 15 Sep 2023 08:05:07 -0300
Message-ID: <20230915110507.194762-1-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x22b.google.com
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


