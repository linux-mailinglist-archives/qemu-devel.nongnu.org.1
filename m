Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B035831B28
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 15:12:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQT62-0004vT-MI; Thu, 18 Jan 2024 09:10:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQT5w-0004ua-TI; Thu, 18 Jan 2024 09:10:13 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQT5s-0000rn-TZ; Thu, 18 Jan 2024 09:10:12 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6da4a923b1bso6770439b3a.2; 
 Thu, 18 Jan 2024 06:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705587006; x=1706191806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4OxPR6eUkgmQgdlDv1NNhfgzx+8cKuCgUfiVAwJqprg=;
 b=iPAifPUiMISwWa0g0UAvdVwyovAHHc0Y9v46TD8JqE2fxtI7P1iQLLgJ8VwbdmY1br
 95NMaN4/6DTI8VLyePH7bViddYQMahrML7MjUbsdtfMrPXC6DgGP4d/S2RAX1Zo8+CT8
 WsE6kIIRqQyRP8oLJlJHmU6QCSTuju/yEZEm+vK+eNFlATxiQMA9oB/HqOSlFBFuDspC
 k9rYt0zZ/+ThWDZKgcojdOuyr18YEIV5Si6TIOqFlndSiRi0a2wWmzcW1oMXlh8ivtrf
 2KZfAV5CVmeZS5p2p4b6gonLZh8v7qFaTeMf05radYmZy2IbxpM5kHI93bKzTxVRPL7z
 JowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705587006; x=1706191806;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4OxPR6eUkgmQgdlDv1NNhfgzx+8cKuCgUfiVAwJqprg=;
 b=V+sibFBSZy6x/1XF6G/gYhegEyvJbkCcAsey3tDjPw5y53Uh9BlLWwVXwhwwhOSBfy
 n4SiQTyS/1iI0L0ACTIVADnIHCoioO9n0V+coze7tC0NJGZLCQTDJrDtHco5MHSA8xSW
 ogaq4u/nOMlftYedGigS64nicb0ClMHVxKmVAT23qI26QzeJqnzFjiHYv+PdZpzHOiM9
 R0XpLwVjMGwB1P5ow01MTq3o6hCi7FfI7Xr1iX0Utu6LejhAVzUDzrQ6vpasl3uNSsNE
 ToT0Uy8rxn0MUUSHCaNkAOqzVqk96sFhE6FOEvx+OG+0SvDkAic9pVqCyhhkCJmVXeeW
 O3WQ==
X-Gm-Message-State: AOJu0YwyBoBWOcGCYKei1zROxh5J2EVeP72gvCexjy/EgkkC2KJnGXav
 D+zwtd2BZpf58RLZoXo9ArOf4zgVITkWo5sYOvxynDFwfg0hF201ZJW4VNPr
X-Google-Smtp-Source: AGHT+IFxBROIJ9znoclP/u7WQR+3vrz1pzpDbGV+tMiT+i8O2RvwW+cJ/1drVEzvTpVBWULi2xBZ6Q==
X-Received: by 2002:a05:6a00:4094:b0:6d9:bb7c:a56d with SMTP id
 bw20-20020a056a00409400b006d9bb7ca56dmr825117pfb.35.1705587005584; 
 Thu, 18 Jan 2024 06:10:05 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a62be12000000b006db3149eacasm3323336pff.104.2024.01.18.06.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 06:10:05 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 0/8] ppc: Update targets for Power machines (spapr and pnv)
Date: Fri, 19 Jan 2024 00:09:34 +1000
Message-ID: <20240118140942.164319-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
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

These are some patches to move defaults to Power10 CPU, update
some feature bits, and also update skiboot to 7.1. I would like
to do this for 9.0 if possible.

Thanks,
Nick

Nicholas Piggin (8):
  target/ppc: POWER10 does not have transactional memory
  ppc/spapr|pnv: Remove SAO from pa-features when running MTTCG
  ppc/spapr: Remove copy-paste from pa-features under TCG
  ppc/spapr: Adjust ibm,pa-features for POWER9
  ppc/spapr: Add pa-features for POWER10 machines
  ppc/pnv: Permit ibm,pa-features set per machine variant
  ppc/pnv: Set POWER9, POWER10 ibm,pa-features bits
  ppc/pnv: Update skiboot to v7.1

 hw/ppc/pnv.c          | 110 +++++++++++++++++++++++++++++++++++++-----
 hw/ppc/spapr.c        |  72 +++++++++++++++++++++++++--
 target/ppc/cpu_init.c |   4 +-
 pc-bios/skiboot.lid   | Bin 2527240 -> 2527328 bytes
 roms/skiboot          |   2 +-
 5 files changed, 168 insertions(+), 20 deletions(-)

-- 
2.42.0


