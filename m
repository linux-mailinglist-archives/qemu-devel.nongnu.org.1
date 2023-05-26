Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2FF711D8A
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 04:13:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Mwd-00027B-Vw; Thu, 25 May 2023 22:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2Mwa-00026w-Rw
 for qemu-devel@nongnu.org; Thu, 25 May 2023 22:12:40 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2MwU-0004ss-HS
 for qemu-devel@nongnu.org; Thu, 25 May 2023 22:12:39 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-51452556acdso131154a12.2
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 19:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685067152; x=1687659152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MGForFNpx0ZhyGhYah3l6/MGE1/x6CdLWPbICDlT/bs=;
 b=kDDeVxR/Z/lQDoMSHQSRDCLRz4HRJ9XZhbdKHi8+Wsi8ObZ4OVSEIJhZmyAzPBcOmq
 HNAqWrVFkz8LjTdeSV+eB4ZAfw4cDz53GKGD3a6JLtgMhGhFVU19e3PGq5gEpZeCTjdo
 6ICALBAtkBj6Rquf0nckiTo8gyrUJwKKmgceOSfct88YqPqkCpI3tDJvwBqrQG0SEY2L
 zonXtOjUwiip0Ho6HyhULQA4AhTNAZ/tA5lOlbugI/cEzp9p3r8fTYK7GVNcaOXyPfEB
 0OQHu16Mm87eVSt8sZHpiqKx4ufV4ghBWqfaee7ekXHJ5sf2NQCtO5fsJRfsyTVm5dlo
 NJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685067152; x=1687659152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MGForFNpx0ZhyGhYah3l6/MGE1/x6CdLWPbICDlT/bs=;
 b=jxlmxRlFyBXY8ToUUBAHpQv9uE+5or6Tz/IyunusQlQ3iUWjfYdacnhfgGH0IQKGaF
 WdojhCujyEuhbYR+XbQLgAi96iTrCAfedbm5PaHXIwCDCufyt+8kzmeqJMqfIsit/ZIV
 36OfzZViQHTlujp9ZaDJl0t8tj6w0VEzDluSlaTHOL//ve82UUV6ykq/ClGoEbZHI4ar
 1CXJIv11tFDFMuaO01MFogD0MU9J6wJbmdwoOsePJYBu8VUuAL56KOMwl/OTDSIrKfVO
 b4njSCZwt/HkRkH2vZWQwpIumzHipebdj+UeDccaeFWYL1+luIOkROsplWPA+rch/c+K
 Xj/A==
X-Gm-Message-State: AC+VfDylHb6IkzO9AGqxzcZ935KNFRiZ1fUZoDqzklNL89+Ujo5frZ3E
 KduvbWBbNN+lcG8gsxT6yT9xPIrhvEMDA58LaCw=
X-Google-Smtp-Source: ACHHUZ4oS6kFdqj8GNqGkGElTA36hlnJ1W98Muy7mSFW3/YB/+AgGWs1zXaZJwzmObmfCNPgkMjNTQ==
X-Received: by 2002:a05:6a20:4322:b0:10c:a627:7ede with SMTP id
 h34-20020a056a20432200b0010ca6277edemr207135pzk.58.1685067152650; 
 Thu, 25 May 2023 19:12:32 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 oe17-20020a17090b395100b0023a9564763bsm3594086pjb.29.2023.05.25.19.12.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 19:12:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v2 3/4] decodetree: Diagnose empty pattern group
Date: Thu, 25 May 2023 19:12:27 -0700
Message-Id: <20230526021228.1777917-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526021228.1777917-1-richard.henderson@linaro.org>
References: <20230526021228.1777917-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Test err_pattern_group_empty.decode failed with exception:

Traceback (most recent call last):
  File "./scripts/decodetree.py", line 1424, in <module> main()
  File "./scripts/decodetree.py", line 1342, in main toppat.build_tree()
  File "./scripts/decodetree.py", line 627, in build_tree
    self.tree = self.__build_tree(self.pats, self.fixedbits,
  File "./scripts/decodetree.py", line 607, in __build_tree
    fb = i.fixedbits & innermask
TypeError: unsupported operand type(s) for &: 'NoneType' and 'int'

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/decodetree.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index e2640cc79b..e4ef0a03cc 100644
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -506,6 +506,12 @@ def output_code(self, i, extracted, outerbits, outermask):
                 output(ind, '}\n')
             else:
                 p.output_code(i, extracted, p.fixedbits, p.fixedmask)
+
+    def build_tree(self):
+        if not self.pats:
+            error_with_file(self.file, self.lineno, 'empty pattern group')
+        super().build_tree()
+
 #end IncMultiPattern
 
 
-- 
2.34.1


