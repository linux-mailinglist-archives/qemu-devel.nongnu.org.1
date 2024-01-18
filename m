Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 962FA831AA2
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 14:32:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQSVN-0004pS-55; Thu, 18 Jan 2024 08:32:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQSVH-0004hH-5q; Thu, 18 Jan 2024 08:32:19 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQSVF-00020o-Dv; Thu, 18 Jan 2024 08:32:18 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6dbb003be79so202827b3a.0; 
 Thu, 18 Jan 2024 05:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705584735; x=1706189535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QsXC1D4iGPyXlNewdG9Nb+NsIXjSArGgXTM6duN2fMI=;
 b=iU4hHEbH7cEYyewyGSnjWv12dhwihhaEmFDXV0HtwOKBGfoxbglM8G/LX1tLW0iHXd
 KyW9VMf7sEcAJb40mf4jjyJxUe/siVaRdlLhZweJLK5MQN7vcccelpR7eIApKo0zAIG+
 WHk/CRZOCFmtJ91FD7M3btihdwZL0TSadwma76JRxQSzoCnfmMRf8bYbpiLEaDIr9J01
 LyDiZmGRB4wnNrrt9sgbJb+G2u9jO1NXBhL2E/zj4NVShCLm9BTCE2y0+XfZoeJYnrKL
 Et8whtw7QHnE7yIpFmbKFc3//dFlFSXJV0OogLY21QfNa4YP2QghwnvP88RaHLIEtSk6
 zeNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705584735; x=1706189535;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QsXC1D4iGPyXlNewdG9Nb+NsIXjSArGgXTM6duN2fMI=;
 b=HQHAMbTbx7z9rFmgm7JIh7dZAwYKaHP0CRRMftMrZR7kupbx/7fAp300VDPemlaRtO
 F4ujTRpgxyT1JNxvoZphKS49vMp4etVVDcZ1fj70PBkJ6ykinBa5oGYvcOFAY+CkRRgy
 uEAQB1Dv/ilif27cdqCKfFbHX1ZAsIwrKeuhPt5+IE5ecP8CtScPLQGtfAAyhQXgpVav
 yxFeM51sXF6/pyBPenrQVTZURNA56Rrl1dDtW6c6avOEefENhvx9HnFdeTDv4eJWmsgB
 kQVthGhqoU+9wOU6iVpv8YKIZY4LtZbJPGDU28jDUi0Vel2jw4u8xHXXNbciLpkfkIfC
 LGcw==
X-Gm-Message-State: AOJu0YwMx/XEs9hTuapl4jEbGvVPeUTvDGlKMXdpod/noW6ivrT9Kiub
 yK0JRr5gegHO0MxRbHwGdYOX3hifFBlqlRO07JXp6/meKbGoKPYGCbWyxPon
X-Google-Smtp-Source: AGHT+IEjF+fYVc/m/q67tHtdNWOJHAqiuyXX1I4ZKj6rizHXEG4r1HBbrYfsN0KOt7i+6HgdkB+PaQ==
X-Received: by 2002:a05:6a20:3d93:b0:199:d02a:9565 with SMTP id
 s19-20020a056a203d9300b00199d02a9565mr1234226pzi.19.1705584735240; 
 Thu, 18 Jan 2024 05:32:15 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 a19-20020aa780d3000000b006daf1ded817sm3282551pfn.209.2024.01.18.05.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 05:32:15 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] hw/ppc/spapr: Rename 'softmmu'
Date: Thu, 18 Jan 2024 23:32:02 +1000
Message-ID: <20240118133206.158453-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
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

I grabbed Philippe's series series and tried to use a more
agreeable name. Further disagreement is okay, but must come
with a better alternative :) would be good to get this out of
the way. I actually don't think softmmu is a great term for it
either even in isolation, so would be good to move away from it.

Previous discussion:
https://lists.gnu.org/archive/html/qemu-ppc/2023-10/msg00016.html

Thanks,
Nick

Philippe Mathieu-Daudé (4):
  hw/ppc/spapr: Add missing license
  hw/ppc/spapr_hcall: Allow elision of softmmu_resize_hpt_prep
  hw/ppc/spapr_hcall: Rename {softmmu -> vhyp_mmu}_resize_hpt_pr
  hw/ppc/spapr: Rename 'softmmu' -> 'vhyp_mmu'

 include/hw/ppc/spapr.h                       |  9 ++++++---
 hw/ppc/spapr_hcall.c                         | 12 ++++++++----
 hw/ppc/{spapr_softmmu.c => spapr_vhyp_mmu.c} | 13 +++++++++++--
 target/ppc/tcg-stub.c                        | 15 ---------------
 hw/ppc/meson.build                           |  2 +-
 5 files changed, 26 insertions(+), 25 deletions(-)
 rename hw/ppc/{spapr_softmmu.c => spapr_vhyp_mmu.c} (97%)

-- 
2.42.0


