Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 643FD7F59AA
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 08:58:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r64Zr-0006NW-Le; Thu, 23 Nov 2023 02:56:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r64Zp-0006NJ-QT
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 02:56:45 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r64Zn-0008Qt-NT
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 02:56:45 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1cf6a67e290so4512725ad.1
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 23:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700726201; x=1701331001;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R42t0zurSU/voQ0hzGOFli39dvO6lzPv12UhMDveciM=;
 b=wFKlF+rMxYnODDd22gLsxCqWc3D0eZAEDqBF6ettY6+VA5VgvKE7n2qbdD6gxpC0TE
 jcPAT7NIzlzzhn3ra9qYWo6QC18he0pOdLjQObNrrWdjH7vy1vJkgcop4oRculyCDIU7
 1hYMvtkkamXSTFKsRoOa5dZyXQ16FdiH3tvA/6MeHZEaxq1xp2HSmjdmQUM1OJ1B/lmE
 BBRdAOQ978hASKqhxsRs4KZqE+OJGygUH1js2XCfY+UnViU0+kV+qeh/Z7Vd62mtLJ71
 vyzx9Flt1iaJC7f8CfAxzjGQ1aAVYvkupMgZKqOrF8zKYL8cCnTtO9ut4DBAzHMZj7WM
 MNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700726201; x=1701331001;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R42t0zurSU/voQ0hzGOFli39dvO6lzPv12UhMDveciM=;
 b=oXVmUMtKT5v9WipCOl2h9Onnb2w9QH1NZ5PGkOoeqG355R9N2zIWYlZsFkTC5EKh0E
 03cI3zqY/O6rQOLLcKgWlP9uVRpoAJWL8+GaZFnyjfv+VrbSMLDGl2FiGT3tIydWonpl
 bVu3o0C6yapeTLrUCn/qyucHlNDwaHy1twJFIxn9UejBuY67bq3rkTezSLnrbUR4YjK6
 w49tbK2tFS8RfLjGcjjvmDB2e6fnpFqltxseQZYDAud+12hsCOcgDxvLZ16f4X86cz1l
 EqhFyFrI7FD+w0OTvbMh6dUCq9dHfLDNMgFUVrw+ndaaLXdp6sHh8k85/gIxiujg/lfF
 sz9Q==
X-Gm-Message-State: AOJu0Yx4TX/gGMMJhXNADYddsRFg4MAiQj+3+gAsC7wL4ilRe2ZNhXya
 UpICgqW1U0Y9iVr/7DORW1WylA==
X-Google-Smtp-Source: AGHT+IGS1S1/L0jRCSVNJ7P1eaNQI8AdMMRWfbNl+NxZt2fveenC81oK1TRq/Dy4HFK5/jWd/vqvUA==
X-Received: by 2002:a17:902:e84e:b0:1cc:33f1:3f03 with SMTP id
 t14-20020a170902e84e00b001cc33f13f03mr5354692plg.2.1700726201194; 
 Wed, 22 Nov 2023 23:56:41 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 n8-20020a170902e54800b001cf6aae59cbsm701383plf.85.2023.11.22.23.56.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Nov 2023 23:56:40 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Subject: [PATCH] pcie_sriov: Remove g_new assertion
Date: Thu, 23 Nov 2023 16:56:29 +0900
Message-ID: <20231123075630.12057-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

g_new() aborts if the allocation fails so it returns NULL only if the
requested allocation size is zero. register_vfs() makes such an
allocation if NumVFs is zero so it should not assert that g_new()
returns a non-NULL value.

Fixes: 7c0fa8dff8 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")
Buglink: https://issues.redhat.com/browse/RHEL-17209
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 5ef8950940..a1fe65f5d8 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -178,7 +178,6 @@ static void register_vfs(PCIDevice *dev)
     num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
 
     dev->exp.sriov_pf.vf = g_new(PCIDevice *, num_vfs);
-    assert(dev->exp.sriov_pf.vf);
 
     trace_sriov_register_vfs(dev->name, PCI_SLOT(dev->devfn),
                              PCI_FUNC(dev->devfn), num_vfs);
-- 
2.42.1


