Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E1EB19136
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Aug 2025 02:03:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLiw-0002Ag-Pd; Sat, 02 Aug 2025 19:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLgf-0006se-UY
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:30:50 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLge-0004uy-2S
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:30:49 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-741a254d4a0so892941a34.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177447; x=1754782247; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kEj8duxAu1Pam82WhtcHKlYlFMg89KDGm3ClOoILo48=;
 b=u7PBaoiLD00XkhOppNWpjHjYFoa2x8Q3sjGjVTN+W3tPfwIB6Dzpaqpu0CnDuK57QK
 a1j6IfTkwBu4HYBTVzz7Pym0ZNeBbN7pLx1EbA7S6uyBDoidgXdm+NFrqp667jo+PQub
 8CYUKPP6vvz2GbHusZrk994/MFoQGlSeE259+GTTQHELBFiNBQXIAsDQdByA/QNcTKLA
 EJgNw/RTEgT30+Rf+QGHwqnkMrR1cFSA2m8Erv67yauxqfiRB3wGm8Fx5A7F6KvA03QH
 NFxraefxvutlar6pVzISmiEwog6vOQ8qyJIxiG42FZHVgDlehGrfyRf6p6kOjWxkWpIM
 QA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177447; x=1754782247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kEj8duxAu1Pam82WhtcHKlYlFMg89KDGm3ClOoILo48=;
 b=qTMvzsvQLYYRGwBXKYXTu7cqTScq7XK2oZF+Bs78eSyteGtTYIgbxmZ8qH/F5ZzgtH
 hmeiFo8DB/+s2Amd27VdrgJ90UzPXx0ak7fUsKFRoCzlVAHk78bb1b1VUyhoC0CbikOI
 HSZLHxmF/7riS4vz1ODmR73rCoI6mPGXHWMsVh8TkipXQt9wFlBZ0plk1AekfaEJtLdU
 Sk+UCS4383un/J6MBAnMXvXH4WUHgTt6ebU6NHXHIMM7ePJK8jhuqOjSGAp40R5i+mjB
 uhRxISmKq4mL7hkVVKxN4sLvFcs3NzCrkMk+ddjp66WNujR/v/5guHB/+7GPhNASp5ok
 DtJA==
X-Gm-Message-State: AOJu0YySYq3cDebHG8GiURKjG5YGKcZARMLSLYeL5VwiUhOhvrYz3N7u
 YRoj+p+E+vIo0reGzS8giQzQsVj6PXDZyK63/qz8zA8VV0AGJ/r7kkbEdWlSPSTjLq9sfGGoP86
 /MaFiQPw=
X-Gm-Gg: ASbGncuWIyx5KOjyT44YFGPrZ7cm5ke86ZQm77KursOdrVo+HnlUrs3aJgziWZNRpZi
 xoiAH1NjN1ZPGLP4CNDfsn10s4fdzghfu3Q6CUkf3mLg3W0+MvorslUQg10Zo2nY4gDJEJT1oKm
 d2iMczNbpwpESWp49aJGw/tJtqagIQM9CazwMJIJJSiIG9CReFNMN5P8w9W0km+emcl6lOxorw9
 tlHgDZeDS/ReIf+G1+eZrjuoohWgjCC5ml2YhGyozzewG728AUHV2o5hCGS/lqWPyLJ3mPYcTUI
 opCPOiNx7yiuO9fVV4gu2mDDnLc9hy1OJ+tg+EgXXfy7UFyB507mh772Us4hXhmAFY/6TL9Gyot
 fDwzVuGmcK7nCWInQxJ3jZWOFfKK+Ms2BXalFjf/ckug/k44OCeyN
X-Google-Smtp-Source: AGHT+IHiqSeqoSJmoQQLzg0b/R7VSK1wiFSdieYogDifbx+Txeh56HuZ5yxKRJR46OjPVimEzix7SQ==
X-Received: by 2002:a05:6830:600f:b0:73e:5540:730e with SMTP id
 46e09a7af769-741879d7295mr7675745a34.4.1754177446714; 
 Sat, 02 Aug 2025 16:30:46 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30b8e3c9b32sm71031fac.24.2025.08.02.16.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:30:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 10/85] target/arm: Fill in HFG[RWI]TR_EL2 bits for Arm v9.5
Date: Sun,  3 Aug 2025 09:28:38 +1000
Message-ID: <20250802232953.413294-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index c9506aa6d5..1d103b577f 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -408,10 +408,19 @@ FIELD(HFGRTR_EL2, ERXPFGCTL_EL1, 47, 1)
 FIELD(HFGRTR_EL2, ERXPFGCDN_EL1, 48, 1)
 FIELD(HFGRTR_EL2, ERXADDR_EL1, 49, 1)
 FIELD(HFGRTR_EL2, NACCDATA_EL1, 50, 1)
-/* 51-53: RES0 */
+/* 51: RES0 */
+FIELD(HFGRTR_EL2, NGCS_EL0, 52, 1)
+FIELD(HFGRTR_EL2, NGCS_EL1, 53, 1)
 FIELD(HFGRTR_EL2, NSMPRI_EL1, 54, 1)
 FIELD(HFGRTR_EL2, NTPIDR2_EL0, 55, 1)
-/* 56-63: RES0 */
+FIELD(HFGRTR_EL2, NRCWMASK_EL1, 56, 1)
+FIELD(HFGRTR_EL2, NPIRE0_EL1, 57, 1)
+FIELD(HFGRTR_EL2, NPIR_EL1, 58, 1)
+FIELD(HFGRTR_EL2, NPOR_EL0, 59, 1)
+FIELD(HFGRTR_EL2, NPOR_EL1, 60, 1)
+FIELD(HFGRTR_EL2, NS2POR_EL1, 61, 1)
+FIELD(HFGRTR_EL2, NMAIR2_EL1, 62, 1)
+FIELD(HFGRTR_EL2, NAMAIR2_EL1, 63, 1)
 
 /* These match HFGRTR but bits for RO registers are RES0 */
 FIELD(HFGWTR_EL2, AFSR0_EL1, 0, 1)
@@ -452,8 +461,18 @@ FIELD(HFGWTR_EL2, ERXPFGCTL_EL1, 47, 1)
 FIELD(HFGWTR_EL2, ERXPFGCDN_EL1, 48, 1)
 FIELD(HFGWTR_EL2, ERXADDR_EL1, 49, 1)
 FIELD(HFGWTR_EL2, NACCDATA_EL1, 50, 1)
+FIELD(HFGWTR_EL2, NGCS_EL0, 52, 1)
+FIELD(HFGWTR_EL2, NGCS_EL1, 53, 1)
 FIELD(HFGWTR_EL2, NSMPRI_EL1, 54, 1)
 FIELD(HFGWTR_EL2, NTPIDR2_EL0, 55, 1)
+FIELD(HFGWTR_EL2, NRCWMASK_EL1, 56, 1)
+FIELD(HFGWTR_EL2, NPIRE0_EL1, 57, 1)
+FIELD(HFGWTR_EL2, NPIR_EL1, 58, 1)
+FIELD(HFGWTR_EL2, NPOR_EL0, 59, 1)
+FIELD(HFGWTR_EL2, NPOR_EL1, 60, 1)
+FIELD(HFGWTR_EL2, NS2POR_EL1, 61, 1)
+FIELD(HFGWTR_EL2, NMAIR2_EL1, 62, 1)
+FIELD(HFGWTR_EL2, NAMAIR2_EL1, 63, 1)
 
 FIELD(HFGITR_EL2, ICIALLUIS, 0, 1)
 FIELD(HFGITR_EL2, ICIALLU, 1, 1)
@@ -512,6 +531,11 @@ FIELD(HFGITR_EL2, SVC_EL1, 53, 1)
 FIELD(HFGITR_EL2, DCCVAC, 54, 1)
 FIELD(HFGITR_EL2, NBRBINJ, 55, 1)
 FIELD(HFGITR_EL2, NBRBIALL, 56, 1)
+FIELD(HFGITR_EL2, NGCSPUSHM_EL1, 57, 1)
+FIELD(HFGITR_EL2, NGCSSTR_EL1, 58, 1)
+FIELD(HFGITR_EL2, NGCSEPP, 59, 1)
+FIELD(HFGITR_EL2, COSPRCTX, 60, 1)
+FIELD(HFGITR_EL2, ATS1E1A, 62, 1)
 
 FIELD(HDFGRTR_EL2, DBGBCRN_EL1, 0, 1)
 FIELD(HDFGRTR_EL2, DBGBVRN_EL1, 1, 1)
-- 
2.43.0


