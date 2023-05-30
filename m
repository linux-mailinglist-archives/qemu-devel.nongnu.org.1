Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FEB7161FE
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:33:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zNb-0007l5-GA; Tue, 30 May 2023 09:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zMy-0005hl-CD
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:26:38 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zMu-0001Rk-7Z
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:26:35 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-4f50a8f6dd7so1364668e87.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685453190; x=1688045190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Osd+ug5T0eLwuQV28tEjnEAHVhvHjnqg8nDEVtg3G/g=;
 b=P5PthRVjGhtaqFWw+47Fshdo3pUnk8uH1iKjq4GdVMUqZhNY4k16XRVcWmJ15tdMOn
 RibHM5eq+TAiFzOF2LajKY1+Pc54dEoM3vF4vqFFRzFss3IAqw2gMSmf70hltZ9xSfZ/
 q1xLRsZGlXcopSk6kIzMUdeNjeyYGuevAp4xvuCSFZAuFf90bovYH96F279B3ayVRBg4
 +UVHapqI+08Y0HYItaGen+dqXSdVmJ5J8JHaYP7Xm2Iy+8CUnYsiZqGehCg+oaUdbdLF
 Ej1MjuZdKXp5qtEP3mczO9U7nq0i2p+pj8W/mNlI/Fs8LYAHxy9dlsTW5Ek7/UD+SXeH
 8YQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685453190; x=1688045190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Osd+ug5T0eLwuQV28tEjnEAHVhvHjnqg8nDEVtg3G/g=;
 b=QcVrKfskL28s2OagTDJpbxaq3RRxM7zdsqrnvxggbubLpnrfJzYxO9gfrQjRLF5nKW
 K/cydBbHySOfTsicqx//hyeBLtv7o3IOEALsBWrZ/BlJICD0z762byuMVzS4s7pkKIb9
 ZYnsbXG6kuI3KdmCgZ1fsiASQ8z5TCl24ahYFvwI1LHXtCJhKL/REr42c1CaFAeFCsTt
 XwNOQsMThHQImz49CJWWDlG+mPwJDjz9HybyJDjm5ZMCMkX+qcXxozFqSR0A/UCaoYqT
 IgOapVBE9GVU/bkuKEABlYyExCQeQqcD4vFHOfg+88de4Bi5RvK65bTk8j9bcVGlqg5e
 8hTg==
X-Gm-Message-State: AC+VfDx4CDbjIVarWNXGvuq+iXm6UINY3Ts3yUc+A3drul9l3aapUob3
 IqTprhfi5LkTvOGK6Nf4KYZe02tSs+BXFmGHD0Y=
X-Google-Smtp-Source: ACHHUZ7VGqABzNBOFfz1z7Y7Rw2Qla4oQkaun0LiTvRk8+LCX2jI2bFKJNrpQ8YSd3KG/i7CZlpdPA==
X-Received: by 2002:ac2:4435:0:b0:4ef:d5cb:18e0 with SMTP id
 w21-20020ac24435000000b004efd5cb18e0mr686597lfl.43.1685453190367; 
 Tue, 30 May 2023 06:26:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 p19-20020a1c7413000000b003f60e143d38sm17463615wmc.11.2023.05.30.06.26.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 06:26:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/21] Update copyright dates to 2023
Date: Tue, 30 May 2023 14:26:18 +0100
Message-Id: <20230530132620.1583658-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530132620.1583658-1-peter.maydell@linaro.org>
References: <20230530132620.1583658-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Enze Li <lienze@kylinos.cn>

I noticed that in the latest version, the copyright string is still
2022, even though 2023 is halfway through.  This patch fixes that and
fixes the documentation along with it.

Signed-off-by: Enze Li <lienze@kylinos.cn>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20230525064345.1152801-1-lienze@kylinos.cn
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/conf.py              | 2 +-
 include/qemu/help-texts.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/conf.py b/docs/conf.py
index c687ff26630..e84a95e71ce 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -89,7 +89,7 @@
 
 # General information about the project.
 project = u'QEMU'
-copyright = u'2022, The QEMU Project Developers'
+copyright = u'2023, The QEMU Project Developers'
 author = u'The QEMU Project Developers'
 
 # The version info for the project you're documenting, acts as replacement for
diff --git a/include/qemu/help-texts.h b/include/qemu/help-texts.h
index 4f265fed8df..d0359f82e08 100644
--- a/include/qemu/help-texts.h
+++ b/include/qemu/help-texts.h
@@ -2,7 +2,7 @@
 #define QEMU_HELP_TEXTS_H
 
 /* Copyright string for -version arguments, About dialogs, etc */
-#define QEMU_COPYRIGHT "Copyright (c) 2003-2022 " \
+#define QEMU_COPYRIGHT "Copyright (c) 2003-2023 " \
     "Fabrice Bellard and the QEMU Project developers"
 
 /* Bug reporting information for --help arguments, About dialogs, etc */
-- 
2.34.1


