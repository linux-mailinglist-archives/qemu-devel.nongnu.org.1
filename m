Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF6E7737DE
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 06:22:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTECh-0006CT-G1; Tue, 08 Aug 2023 00:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTECf-0006C5-6y; Tue, 08 Aug 2023 00:20:17 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTECd-0007Mw-Od; Tue, 08 Aug 2023 00:20:16 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3a37909a64eso3643776b6e.1; 
 Mon, 07 Aug 2023 21:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691468414; x=1692073214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hT9GJ/9VV0KpWK9H30KM7vb3aR/pgNelxHTyGEtKvI0=;
 b=AqG+PFqH1HL0zDCM4A2pfG52bzVZB5M+acXC3R108ErFGS11MJj3PK/UT81g33OaQO
 qglWQ70ZChzArkY6pOe/rIl6ttfTNrmVACEG04ozQh2yTLShqmtkTkL2G7s4E2S7A8JN
 hTf+FuOE1g1IV12HTc/4uzZ2QuTqNPw6GRL/M1bEstE3GQPTD/sWfbr7+8/VTS7zNEoB
 PXg+55MBFXYDoYjFVJ4u2P8ylpEQrLfkO6DfS5dE3Nk5UhLZpFbSv93V4LVM60TDEjkB
 IObKo3BABBQStq1V7FSsqZ7Qqga/Omie3epoqlTUPXKjJ+9/Flwy6vIl/B33CpeZaFdP
 QpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691468414; x=1692073214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hT9GJ/9VV0KpWK9H30KM7vb3aR/pgNelxHTyGEtKvI0=;
 b=HPe9wWl+PuDkst3cRCKbb8y4UJb5k7kZXaM9vtoiE8hbrQS3g9Gl2O1DUHERnz+lVo
 8fLeCVVwalcE8pBd//RT0Ei5ewZMFTfS6CXuMUoynz9ilIoRobBNYWDknT5LmY2NLHTr
 IIRLA7TIQbPt+0Duhhki2uw4eG88TI+f842eW2BQ4+UQP1qre1TSOpwenLcFcMIhzV23
 QYLjc/hi7J0Pd6bddCktUHhaNeKAf1sBAxxF5qfUq6hBzQ0WZPKW6kBuiE8SoYv6RBPX
 ZoG1ZbU1pc/A5f7D0XXFA8QrnNRRNYTlARCaWWBXzRddwtVWrEO2NojEeBYJbaEn+n6z
 WgZQ==
X-Gm-Message-State: AOJu0YwsAWFesrWDwBi5a98CFHUQd+g9frWi/joGAiILA23P+iem3Eab
 LY45lbIi0jFSyhOVzIXj4Bc=
X-Google-Smtp-Source: AGHT+IHLokgpulhYYVTWISKthhPb91H750vIfMp/6+BSRYp5YnmEbwOgx2OH0wHaoDQ5yLxLaRQc4w==
X-Received: by 2002:a05:6808:213:b0:3a7:56a1:9bbe with SMTP id
 l19-20020a056808021300b003a756a19bbemr11013329oie.45.1691468414320; 
 Mon, 07 Aug 2023 21:20:14 -0700 (PDT)
Received: from wheely.local0.net (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 fk10-20020a056a003a8a00b0068718f6a035sm6979207pfb.33.2023.08.07.21.20.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 21:20:14 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 01/19] ppc/vhyp: reset exception state when handling vhyp
 hcall
Date: Tue,  8 Aug 2023 14:19:43 +1000
Message-Id: <20230808042001.411094-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808042001.411094-1-npiggin@gmail.com>
References: <20230808042001.411094-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Convention is to reset the exception_index and error_code after handling
an interrupt. The vhyp hcall handler fails to do this. This does not
appear to have ill effects because cpu_handle_exception() clears
exception_index later, but it is fragile and inconsistent. Reset the
exception state after handling vhyp hcall like other handlers.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 32e46e56b3..72ec2be92e 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -843,6 +843,7 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
             PPCVirtualHypervisorClass *vhc =
                 PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
             vhc->hypercall(cpu->vhyp, cpu);
+            powerpc_reset_excp_state(cpu);
             return;
         }
 
@@ -1014,6 +1015,7 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
             PPCVirtualHypervisorClass *vhc =
                 PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
             vhc->hypercall(cpu->vhyp, cpu);
+            powerpc_reset_excp_state(cpu);
             return;
         }
 
@@ -1526,6 +1528,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
             PPCVirtualHypervisorClass *vhc =
                 PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
             vhc->hypercall(cpu->vhyp, cpu);
+            powerpc_reset_excp_state(cpu);
             return;
         }
         if (env->insns_flags2 & PPC2_ISA310) {
-- 
2.40.1


