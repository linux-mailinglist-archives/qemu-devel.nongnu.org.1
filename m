Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5C77CFB4B
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:38:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTCt-0004BW-Sz; Thu, 19 Oct 2023 09:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBx-00024v-P6
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:36:03 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBt-0001E6-N8
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:36:01 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40651a726acso69287425e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697722546; x=1698327346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KQjZ8bTDzCLrmeviYWdiySCbGKf4nGRL3SCgsoJSs2w=;
 b=XSwNhND0GaYDcZR6q2r2Wfj+qUEM++Bq269oSdxumsaoyyqk5v0JItfIS2Z12C9GJY
 hIJvW6mgGwV8Sfk5RiLNdmhErEjaHxCHY1/vBZzzjEhu3Bd4kx/cWmnCXdxDGnQ2Iezu
 ZsUogDNHP0pf8+y//2l74ayAvYU500j1vbyh+bH3OpTaRzj9gj111EQMuEkKVSRRw9gk
 ffY18KD7T7xORLEzs/D7tAUz57BBfP05x128MUVwRZdKzBEBEpPZlKSWx+Pw0Y+q0CuR
 qS9XvG6yecuLVL5b44UWSLUIhhstm6yu+pGiqATjirK2XtQFFq/eIJrVDw+QdxMFBu+c
 +YEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697722546; x=1698327346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KQjZ8bTDzCLrmeviYWdiySCbGKf4nGRL3SCgsoJSs2w=;
 b=ls3RBG76ASeYZHlNegofRb3bmYe2YSwSERJPoEgHuUkciJv7hnzcYKom8dalXXLSwK
 MCPgWrUD+Tam+shGl6frmSUvSPUyoU3lVwvIMqQcoB4KxKY8V6eovtk7beXcOYgFSOJ8
 tCeARlSdT5ayrpCG2w/CjKLgkDWBrOWH0BBSR5LSLGgXxoybLOVx+sjFh383SwSfvppU
 Mn9DOmEbeczzoD0LtgJj4md6r298AL9Xm9TlsHLg9Aw/Y9MRIBcLn+snmLauf0FiPuDD
 AunxjiYKwG0NGySnYFkjdSUW0xNteZxiLGEn50dCqRoHHjHUuFugcM2wCr3JirU1oFdA
 JP2A==
X-Gm-Message-State: AOJu0YxmPA3wQZigbeDroO3kXFLpKTaAX8v9W8dUmmGvitlypGqNX9b5
 s0CxyhJoVyuH1phE+uo+rWlnC7m9+LoN22q2JpA=
X-Google-Smtp-Source: AGHT+IGftjQYcJ9+wdmWIH8qExqPy59EVNJF+WUt/+zUcdc2GrFTAB3usLZARLAVXNolNW81bk4uxA==
X-Received: by 2002:adf:cd90:0:b0:31f:fdd8:7d56 with SMTP id
 q16-20020adfcd90000000b0031ffdd87d56mr1458275wrj.12.1697722546210; 
 Thu, 19 Oct 2023 06:35:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d28-20020adf9b9c000000b0031f3ad17b2csm4512690wrc.52.2023.10.19.06.35.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 06:35:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/24] hw/arm/smmuv3: Update ID register bit field definitions
Date: Thu, 19 Oct 2023 14:35:29 +0100
Message-Id: <20231019133537.2114929-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133537.2114929-1-peter.maydell@linaro.org>
References: <20231019133537.2114929-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Update the SMMUv3 ID register bit field definitions to the
set in the most recent specification (IHI0700 F.a).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20230914145705.1648377-2-peter.maydell@linaro.org
---
 hw/arm/smmuv3-internal.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 648c2e37a27..6076025ad6a 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -38,33 +38,71 @@ REG32(IDR0,                0x0)
     FIELD(IDR0, S1P,         1 , 1)
     FIELD(IDR0, TTF,         2 , 2)
     FIELD(IDR0, COHACC,      4 , 1)
+    FIELD(IDR0, BTM,         5 , 1)
+    FIELD(IDR0, HTTU,        6 , 2)
+    FIELD(IDR0, DORMHINT,    8 , 1)
+    FIELD(IDR0, HYP,         9 , 1)
+    FIELD(IDR0, ATS,         10, 1)
+    FIELD(IDR0, NS1ATS,      11, 1)
     FIELD(IDR0, ASID16,      12, 1)
+    FIELD(IDR0, MSI,         13, 1)
+    FIELD(IDR0, SEV,         14, 1)
+    FIELD(IDR0, ATOS,        15, 1)
+    FIELD(IDR0, PRI,         16, 1)
+    FIELD(IDR0, VMW,         17, 1)
     FIELD(IDR0, VMID16,      18, 1)
+    FIELD(IDR0, CD2L,        19, 1)
+    FIELD(IDR0, VATOS,       20, 1)
     FIELD(IDR0, TTENDIAN,    21, 2)
+    FIELD(IDR0, ATSRECERR,   23, 1)
     FIELD(IDR0, STALL_MODEL, 24, 2)
     FIELD(IDR0, TERM_MODEL,  26, 1)
     FIELD(IDR0, STLEVEL,     27, 2)
+    FIELD(IDR0, RME_IMPL,    30, 1)
 
 REG32(IDR1,                0x4)
     FIELD(IDR1, SIDSIZE,      0 , 6)
+    FIELD(IDR1, SSIDSIZE,     6 , 5)
+    FIELD(IDR1, PRIQS,        11, 5)
     FIELD(IDR1, EVENTQS,      16, 5)
     FIELD(IDR1, CMDQS,        21, 5)
+    FIELD(IDR1, ATTR_PERMS_OVR, 26, 1)
+    FIELD(IDR1, ATTR_TYPES_OVR, 27, 1)
+    FIELD(IDR1, REL,          28, 1)
+    FIELD(IDR1, QUEUES_PRESET, 29, 1)
+    FIELD(IDR1, TABLES_PRESET, 30, 1)
+    FIELD(IDR1, ECMDQ,        31, 1)
 
 #define SMMU_IDR1_SIDSIZE 16
 #define SMMU_CMDQS   19
 #define SMMU_EVENTQS 19
 
 REG32(IDR2,                0x8)
+     FIELD(IDR2, BA_VATOS, 0, 10)
+
 REG32(IDR3,                0xc)
      FIELD(IDR3, HAD,         2, 1);
+     FIELD(IDR3, PBHA,        3, 1);
+     FIELD(IDR3, XNX,         4, 1);
+     FIELD(IDR3, PPS,         5, 1);
+     FIELD(IDR3, MPAM,        7, 1);
+     FIELD(IDR3, FWB,         8, 1);
+     FIELD(IDR3, STT,         9, 1);
      FIELD(IDR3, RIL,        10, 1);
      FIELD(IDR3, BBML,       11, 2);
+     FIELD(IDR3, E0PD,       13, 1);
+     FIELD(IDR3, PTWNNC,     14, 1);
+     FIELD(IDR3, DPT,        15, 1);
+
 REG32(IDR4,                0x10)
+
 REG32(IDR5,                0x14)
      FIELD(IDR5, OAS,         0, 3);
      FIELD(IDR5, GRAN4K,      4, 1);
      FIELD(IDR5, GRAN16K,     5, 1);
      FIELD(IDR5, GRAN64K,     6, 1);
+     FIELD(IDR5, VAX,        10, 2);
+     FIELD(IDR5, STALL_MAX,  16, 16);
 
 #define SMMU_IDR5_OAS 4
 
-- 
2.34.1


