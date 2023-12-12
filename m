Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5495C80EA82
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 12:38:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD14S-0000HX-Ai; Tue, 12 Dec 2023 06:37:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD14L-0000Bt-7w
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 06:36:57 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD14F-0006uj-Lf
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 06:36:56 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50d176eb382so5143572e87.2
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 03:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702381009; x=1702985809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r9l5OJKRIKjrnTI1L+t9VvIOzVTPo5liJg25JIXeLpU=;
 b=IJFaMmzWNcwUI0Y0TTqK21azM844yfwDIn03mhnA1CnOnkpFJuutpg5mYVXCIppu3a
 bLea1nB5u+Fu/nW9UldFKAAyQilR2Oznak/KZw5wnPlwOn/07x2wZR5IhSEJkBEPrb4d
 V5aohQCcmlCboS29WZoSjd1nS1cpj9yljhuQsslSNYVaq1xS9phiDmWvAGp+mV/VYaNU
 36RJSXkQWZS0GgLf7HskVGoMammFvhRpndEY99AAEfQBTeXs1y7NmN9GZiunEN3DvWZ9
 aJl/IMmyShbJBmek1UPFt+H//xeOa+Ry1FXIlvCnEXQcqVyFAu+ZUE/WXR0IErDD4jHw
 Tt1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702381009; x=1702985809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r9l5OJKRIKjrnTI1L+t9VvIOzVTPo5liJg25JIXeLpU=;
 b=MnUk3ND2ZDB/05K7dvtG+cx6lg7miK4IiaFhaxHLYCm0kmYzfkbypHiYHHc+i8DzVT
 +K4aztwi3fUb/EPHZNivpsB/Sp/PLdC/YJKbWxOBWRoY/KPLRAjOt9SraVVOHm7w2FuJ
 4t6vQTRdFwLhYJcBYwBtsWab2O9i48oWSS0hrCG7ZGv4pkwC5iQZd4TkH/eCivgSdzWY
 8Zm13HuJID1ZsXKMwL86dNkF0CwDsb5vSBocw40jMNYuE8IC32NkqbKRrJmELArVwx8a
 CG2vG7bN1ykt93EXzyTJv/6FXtHqZycRwWj0s5pkPIT1/13uxKpQJnOOUy195yaPfokq
 E/Mw==
X-Gm-Message-State: AOJu0Yx1Hov0lnxcoMPSo+N5PmsoUCog8SPtOS0YXf9gMsiw1YtoWGiP
 fe/x5N9JpRDUKUHLhjgyt+4n1R98Gqf23zLj/Xh/Vg==
X-Google-Smtp-Source: AGHT+IFt5V/5vP7JOsG9RVMgBV+If7R7ADPOJCUBat5qsDuN3906AOL7aBzBECTb2TX4Y6d5rZ2dlg==
X-Received: by 2002:a05:6512:3ba1:b0:50b:fac4:3ffc with SMTP id
 g33-20020a0565123ba100b0050bfac43ffcmr4022085lfv.74.1702381009595; 
 Tue, 12 Dec 2023 03:36:49 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 mm19-20020a1709077a9300b00a18c2737203sm6172438ejc.109.2023.12.12.03.36.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 03:36:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH 1/4] hw/ppc/spapr_hcall: Remove unused 'exec/exec-all.h'
 included header
Date: Tue, 12 Dec 2023 12:36:37 +0100
Message-ID: <20231212113640.30287-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212113640.30287-1-philmd@linaro.org>
References: <20231212113640.30287-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/spapr_hcall.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 522a2396c7..fcefd1d1c7 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -8,7 +8,6 @@
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/error-report.h"
-#include "exec/exec-all.h"
 #include "exec/tb-flush.h"
 #include "helper_regs.h"
 #include "hw/ppc/ppc.h"
-- 
2.41.0


