Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B32370DED4
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:12:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SVq-0003bM-Fs; Tue, 23 May 2023 09:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SVm-0003WQ-Jd
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:57:14 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SVe-0004BV-Pz
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:57:14 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-64d1e96c082so4215138b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850226; x=1687442226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PRmXJMFN3rYya2LUNfLtjvM1yMLdoZFGjXY4lJtw1jE=;
 b=fhbY9Gl2HgEsCvEI3gzEY+YcjLrGDqywmivCg2PzNxrTjXFmUd7jQX3TTY6eCZ5Ezx
 aKR+nrXzyRVfTFRGopPCq03uEVXbtPoxXEwF/dGxR7LUwrCYyQTFyLRJd8qlvm4uA1dr
 9rSkpG1iDMzgi4DtLNFUJ6GUR4E92kzjyeNb2DwAeFXb4Du8RE4PLrdvGkcUXar79Oyj
 AWf0FeOJLSO/slUhVagKOMD+y/PEr0qyLiKOWKxyIBucGe6XQtSyPrdf0hhNxpNJbCLl
 HDH+cK3KV0zKXKnta6LoNGDl1DnTLqJo2vGaE3tclzwWwutZps7MKRvlO1aSxSCxYcdx
 9wMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850226; x=1687442226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PRmXJMFN3rYya2LUNfLtjvM1yMLdoZFGjXY4lJtw1jE=;
 b=kpCS18qM/pQ6r7rcJ8XYjIhtybqDJ1QDTjTVrFjOOaws2SvUpnhGge2aLLeOkZAG07
 X8dlU3HjE5wTpXr0QeW9xQeRBYHfJhoCkXA16lA/isOAl1l29VooOQIH5z3F6TJr1/pQ
 zzhVKuChxeLYW3S1tX31mp/PGXxy45e9sdRxJQgjFYoGWt4F/6wDlseERvPac+K8nDC7
 UoWdamLEzEmbwD8pKSmDvLqtMCDaGQLDkJq4Ty1G000sCD9/58DezSTX/unHV0NStYSj
 fKPD9YykBpCaIgl41Szw0erhxzw3lPZyaVrpzyaylh+3+ltjOcMSERfkqLyCZ+FP3RVe
 LVKg==
X-Gm-Message-State: AC+VfDy90S4RJMgwf8j1CE4UP89ESn5nQBvyNu9Ngf1qFZXBCGb7zjSw
 nRcv1FSJYPlRtGkCoJeITV+5X9yrXV+/h3z5LUY=
X-Google-Smtp-Source: ACHHUZ7lz1XDLUCrO0UT2wOyhzOzxizVXVuMrUjZteMwh8eIqomT6WDzEYRsZlLhbSrPU52ReH3Syw==
X-Received: by 2002:a05:6a00:188e:b0:64d:3227:b800 with SMTP id
 x14-20020a056a00188e00b0064d3227b800mr19126746pfh.16.1684850225438; 
 Tue, 23 May 2023 06:57:05 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a62a50b000000b0063799398eaesm5805790pfm.51.2023.05.23.06.57.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:57:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 51/52] exec/poison: Do not poison CONFIG_SOFTMMU
Date: Tue, 23 May 2023 06:53:21 -0700
Message-Id: <20230523135322.678948-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

If CONFIG_USER_ONLY is ok generically, so is CONFIG_SOFTMMU,
because they are exactly opposite.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/poison.h         | 1 -
 scripts/make-config-poison.sh | 5 +++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/exec/poison.h b/include/exec/poison.h
index 256736e11a..e94ee8dfef 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -85,7 +85,6 @@
 #pragma GCC poison CONFIG_HVF
 #pragma GCC poison CONFIG_LINUX_USER
 #pragma GCC poison CONFIG_KVM
-#pragma GCC poison CONFIG_SOFTMMU
 #pragma GCC poison CONFIG_WHPX
 #pragma GCC poison CONFIG_XEN
 
diff --git a/scripts/make-config-poison.sh b/scripts/make-config-poison.sh
index 1892854261..2b36907e23 100755
--- a/scripts/make-config-poison.sh
+++ b/scripts/make-config-poison.sh
@@ -4,11 +4,12 @@ if test $# = 0; then
   exit 0
 fi
 
-# Create list of config switches that should be poisoned in common code...
-# but filter out CONFIG_TCG and CONFIG_USER_ONLY which are special.
+# Create list of config switches that should be poisoned in common code,
+# but filter out several which are handled manually.
 exec sed -n \
   -e' /CONFIG_TCG/d' \
   -e '/CONFIG_USER_ONLY/d' \
+  -e '/CONFIG_SOFTMMU/d' \
   -e '/^#define / {' \
   -e    's///' \
   -e    's/ .*//' \
-- 
2.34.1


