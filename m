Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A56527D3EC1
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:14:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzRJ-00061o-FU; Mon, 23 Oct 2023 14:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzRD-0005ja-W5
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:14:04 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzRC-0008Ic-GD
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:14:03 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-58441865ffaso1326698eaf.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698084841; x=1698689641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MhCC9XTd6nS9RO+tM5LcavZGdQ2zIqBqYuneDU4EEqo=;
 b=EbQFiyYu1JIWNdonw6t1qltXCI1VT/lz2m34STwT3n7F5RrcLOLguQ9Eq8kGd92aeW
 pRZ5JAhxcgToafDdK6rQAY8q8MOiYnyaABG1YxpOH+HYbSvh/7ETXNYUIY3GpWEdNMUe
 QPiz3Bqb8wfVQcNzkJrcM8cvTJ0oC9f/+nPkAxRjIsahB6QejGVKPnnE+e1QjCdYW7z/
 5tEXlK3vi0bG/NWUy3jbJ3F/NbkTmXnoHHVLyhl2hgN2VxZnzKLiPBMQbUON2PtFzERy
 FAAy1O1Is/aQdfntwfA+8vYo+sH6RQa1vKA11qbv2IJ+PeRqxn+MXLxeAJCs5GOorsUT
 Du1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084841; x=1698689641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MhCC9XTd6nS9RO+tM5LcavZGdQ2zIqBqYuneDU4EEqo=;
 b=qOUEgKYJNNCcqwPz49/a1InaXX9Yjq3LlilWF97ruQ7F5k65pNUqsnCnVuT0kThldt
 vZO429Ob5hUQe+l9zyuQABkH48yEZP3Z4yMgGVv2TFfkzoSYSeTYsNE2F4WItLTScPwQ
 PvxrcvlFEFohTKlJpMHOXzDC1XR4aBAbnyYY3XLhA177hs5zMJiDGhv6FXt7ezfHR/pr
 kSndAIE8/a95BzE1/O76bDYNtNfk1bLBAhE/jDo5TgZH8QBSSYb8eDZhoHvb/3Q7muLK
 z99WHFrCPHHpKaOt4yNyZEwW1bwXh0wCaN5GGGdbUQc12071ccGb1KBfPiX5OA+rWUx/
 fqPg==
X-Gm-Message-State: AOJu0Yy/9ZQDGGC//ahreRJS/7rk1IwA2bEXNS0VxmJ3uegOIGGKiQ7d
 IioRq8Z2B54aiGGTiudXuvOVakQ7/GjzA/9c35U=
X-Google-Smtp-Source: AGHT+IFv98O8x2AxAfMlYhiOXcYUnuA1ISQMrD+hyXvSd3lXCHvpaA4BxG9DOWyjjxXPZ7nZrHKGJg==
X-Received: by 2002:a05:6359:593:b0:168:e9d2:6568 with SMTP id
 ee19-20020a056359059300b00168e9d26568mr1568841rwb.25.1698084841422; 
 Mon, 23 Oct 2023 11:14:01 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v10-20020a65568a000000b005b83bc255fbsm5205137pgs.71.2023.10.23.11.14.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 11:14:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v3 34/38] target/i386: Use tcg_gen_ext_tl
Date: Mon, 23 Oct 2023 11:13:25 -0700
Message-Id: <20231023181329.171490-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023181329.171490-1-richard.henderson@linaro.org>
References: <20231023181329.171490-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc36.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/translate.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 18d06ab247..587d88692a 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -701,33 +701,11 @@ static inline void gen_op_movl_T0_Dshift(DisasContext *s, MemOp ot)
 
 static TCGv gen_ext_tl(TCGv dst, TCGv src, MemOp size, bool sign)
 {
-    switch (size) {
-    case MO_8:
-        if (sign) {
-            tcg_gen_ext8s_tl(dst, src);
-        } else {
-            tcg_gen_ext8u_tl(dst, src);
-        }
-        return dst;
-    case MO_16:
-        if (sign) {
-            tcg_gen_ext16s_tl(dst, src);
-        } else {
-            tcg_gen_ext16u_tl(dst, src);
-        }
-        return dst;
-#ifdef TARGET_X86_64
-    case MO_32:
-        if (sign) {
-            tcg_gen_ext32s_tl(dst, src);
-        } else {
-            tcg_gen_ext32u_tl(dst, src);
-        }
-        return dst;
-#endif
-    default:
+    if (size == MO_TL) {
         return src;
     }
+    tcg_gen_ext_tl(dst, src, size | (sign ? MO_SIGN : 0));
+    return dst;
 }
 
 static void gen_extu(MemOp ot, TCGv reg)
-- 
2.34.1


