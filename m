Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A889716D29
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:06:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44aa-0001kc-FX; Tue, 30 May 2023 15:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44Zo-0000qV-Bx
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:00:13 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44Zl-0000ua-4s
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:00:10 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-64d30ab1f89so3289615b3a.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685473208; x=1688065208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MGForFNpx0ZhyGhYah3l6/MGE1/x6CdLWPbICDlT/bs=;
 b=th+B/rFnGveoa+pV8gpDtKfoeMnSRwZniBoJrD1O69j4rPdO2DXADyPqcamp/vt5Rj
 3GkLfc/zn7TITxVNRBqt4+IXjnZKLyb0O3VApHITislb4rnCcYDZLQfoC1blw9jUnP+V
 ClH2lUte5fhfSWcR8i2gaDh6R147edvpyuGVTq61YiF7LyBOGH3NnlQnIDkGQgZQRTV2
 bDG+j608bjHRdTNuwIzUJJ6mreJINeLNOk0yoi17XEIPHzf9yutru7x8EAUk/4mAiUp3
 pmaWsi1BU+9x7PUKLetdVHBTczm9AV5QS+zH/Ac1K5dDZJRz1I2dO6g0/Y81pmzal2Fx
 H+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685473208; x=1688065208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MGForFNpx0ZhyGhYah3l6/MGE1/x6CdLWPbICDlT/bs=;
 b=ZQ9kDzeamq2JbNgI4b7FMq9t1ktEz1JQQeJKILRnl4KBvYJ5I/Im2vfcP0bMg3Nh0M
 w4WkGcIoBjcC6O6nokFGudHDF/3BA/7JUizQjLGwJiHdLiZBuds5gxxuTWeyH/7r+xam
 7BrVJGptA2VbGdvFqQSbFEE3fPSeI6kjwlDhlJRZVUqEBoZjOtj3SoCI/QEdgZC6cO4D
 +2VgcTy3bgZOAIyl5vMVUoGs63TEym2y01P52KrIhXKQArBSZioF4K0ST1TIv+jfa0WX
 nhLBOUSsHuCBs6YzPzQTRnMgSb4NvBnrwutuIzunAwxa7u3bPzxq6RwbO8kOq6tOQ8JU
 Pjaw==
X-Gm-Message-State: AC+VfDyjS1IzvsxynVCwLoL84UXoMto+a5ofVIVcvKb9iPOHvsJ4Ydrd
 E47zMfp9uiczyc8/slAPMKUG41ZtZtiYF+ymuL8=
X-Google-Smtp-Source: ACHHUZ7+KFrKq0dBoCYQlBsVchKpV+q8hgX3ZMVQUMlav+VCx2yFAL20wEPTba2pbWmMUKsFyO07CQ==
X-Received: by 2002:a05:6a20:918a:b0:111:92ef:314e with SMTP id
 v10-20020a056a20918a00b0011192ef314emr3953072pzd.35.1685473208379; 
 Tue, 30 May 2023 12:00:08 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a63fa52000000b0051f14839bf3sm9128496pgk.34.2023.05.30.12.00.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:00:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/27] decodetree: Diagnose empty pattern group
Date: Tue, 30 May 2023 11:59:42 -0700
Message-Id: <20230530185949.410208-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530185949.410208-1-richard.henderson@linaro.org>
References: <20230530185949.410208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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


