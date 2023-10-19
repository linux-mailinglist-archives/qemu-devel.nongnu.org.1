Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF9B7CFB6E
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:41:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTCc-0002oZ-Ih; Thu, 19 Oct 2023 09:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBw-0001z9-8e
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:36:02 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBn-0001Ef-9I
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:35:57 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32db8924201so3260558f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697722548; x=1698327348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pWFnlBnEBWziPmtTDaxLrH+se8eDbl8V/1Yai8/lSj8=;
 b=HWxsWR+YwnjR6yfr/BeKqovILeL8MQLQFhRvZ89REu8eN4rfUdgtvOp8Ylbp+SARzt
 3P9liYHMbfGMyaexXKkSDOq8t+6Y7+bAWP0RASfUYBVmRyjlyf5Kxn7OQOP91C41OEjK
 9rwh+0Xk3dQviRxx5UFwie3e7sB0OZarHdmFtVpT8wrKM3/KVWNCU9/CWVXKIQZTVgwu
 0kKUp+C9flP6m3/B6kOWPVV9pn+UDDrRtEBT8+muaYsLhtoz34ZnWkMIZxqRuLPRElMJ
 t/kvWPtzrrc0+TMON5qqNyRlbfLGWAwh7KGiMP/n/SQJR80miFJl/iTkXuwWdFqKu9fY
 w0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697722548; x=1698327348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pWFnlBnEBWziPmtTDaxLrH+se8eDbl8V/1Yai8/lSj8=;
 b=vMyqi28iMPt76hxIrCYTz1MJn2ZUGwtYt6cUEgHhNmvozvlEt8Fs/SZz79yogWQNxx
 J/P6QgWp8DPTVk19rbSTRZ0AdwZzW2UHpLQJJLgzw6ptvz9qrWiaJlqtRC51crETO7qb
 SpqchPaaSpzzp9rCvsR1K7OiFjX3Y6w01n3RMU/7WZ1w7BVxzcSi+iOBqWjd+uRHqmso
 lc4V+WNwiufuKHXS/LXmTp7akNYxAHTp7x/JPdCRPc3ELjvycrIoQiybPw02amcvroDW
 YV9C6DR6n4uEhAJYL82x8171orZdJjFclC1aOaa36BdwMlUiZq/j9oaWtrWsYLiFiJRr
 hlIg==
X-Gm-Message-State: AOJu0YxayffnD+QUbXFinse/e+0JrRjIZpcgRasGAgkLWbm7U3IlalIV
 77VMJ1j7aCEsL+dBld5kMSliK69Qh7vf40kqi+U=
X-Google-Smtp-Source: AGHT+IGmhr1Lf60auRbZjFH0Gk0uTJOQw4EKiyqxqJ8VS3JorsmLuxiaEdnsEao44RCDRtuQdD/xZw==
X-Received: by 2002:a5d:5442:0:b0:32d:9d91:6273 with SMTP id
 w2-20020a5d5442000000b0032d9d916273mr1162791wrv.71.1697722547982; 
 Thu, 19 Oct 2023 06:35:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d28-20020adf9b9c000000b0031f3ad17b2csm4512690wrc.52.2023.10.19.06.35.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 06:35:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/24] target/arm/kvm64.c: Remove unused include
Date: Thu, 19 Oct 2023 14:35:33 +0100
Message-Id: <20231019133537.2114929-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133537.2114929-1-peter.maydell@linaro.org>
References: <20231019133537.2114929-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The include of hw/arm/virt.h in kvm64.c is unnecessary and also a
layering violation since the generic KVM code shouldn't need to know
anything about board-specifics.  The include line is an accidental
leftover from commit 15613357ba53a4763, where we cleaned up the code
to not depend on virt board internals but forgot to also remove the
now-redundant include line.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20230925110429.3917202-1-peter.maydell@linaro.org
---
 target/arm/kvm64.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 558c0b88dd6..4bb68646e43 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -30,7 +30,6 @@
 #include "internals.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/ghes.h"
-#include "hw/arm/virt.h"
 
 static bool have_guest_debug;
 
-- 
2.34.1


