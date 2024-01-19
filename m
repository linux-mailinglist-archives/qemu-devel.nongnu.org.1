Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 535E3833172
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jan 2024 00:24:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQyCo-0000Y1-Rt; Fri, 19 Jan 2024 18:23:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQyCm-0000XC-CX
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 18:23:20 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQyCk-0008HO-Rq
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 18:23:20 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40e87d07c07so15031695e9.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 15:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705706597; x=1706311397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KhSRWStR20AE9AnE5PIKZZLXq3xopPZV2ThAYniELgo=;
 b=YJFnquOAnQZpEvVx/+WkNozuCYzzZLTzcCLdB694gxzRpTdqCMVC91mkV4DYJskNOd
 F1hXpTSVrHjVW8m2WOjwxTfv1s9DhYOylZsEoxKqUaguIMT6pQbkpbszzijCbV7qeWXk
 G2mclL8sMhgtHLzQ0GojJLufv8EBGKl5QscrhLUQOYMHhnWPCy2SuppaDjFyY+qQXAHe
 DXUYfmMlnFj4cICHi3av6Sq/RRgZ31C8rFWhjTQ6miEvXM8J7+okBJGEUm+mHqjcrlQq
 AL7kZsAwj/Cte9ftIMDIsRTkAkhHhkCJ0x94sBrUvMpIOGbPMk3sSSc98flhqqAd+A6R
 xgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705706597; x=1706311397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KhSRWStR20AE9AnE5PIKZZLXq3xopPZV2ThAYniELgo=;
 b=UxSLtvyiEiF00iepIelrcjDLBul7wbs7JO5abDCxFVlSC15FUNfd/vBbNluMIPMJrB
 1Eww8RQVjr3F9tYh9vrRbREP0iBgeNZUT5pTVm6+9R1mksOc5qHd8DImt3t5ECDKXSTU
 DhdX+EzG5fBR5Z3Qen5riQVC5lExv+3bJNAvXNLAZZpjn9RLAqBVYAnTVdnc5HqouJ7Z
 +p3tILtBeSbQNpErlwSB/7Jpi6nzbMJjvjqLyKPCP7FZwPnfX4gpc2lIOJPkSDNsT92t
 2v5AzWhkrFh3jM7mkynj5NEu2V6hwg6cM0/unW05Q04GTLE3Km8w9goA63o3e8eq5XnL
 +5qA==
X-Gm-Message-State: AOJu0YzP/cwmZgoPLxAQSob0Mn9dMvEbazUjySRH/n27r3Tq3PyFjzNG
 HxBMHFAtxFdpbUcRNB1G4TDV+G2oiUGUIiNS8FdrLnm/e87ICOXHLvKchjRTwhQzpgD4mdZYu4M
 J
X-Google-Smtp-Source: AGHT+IFz3l6fBNd1GdBqXt39X8W628P+12A4cmhdGcipJ732CyRzc5I44Oup+8HiIkLqlr7V87rLgA==
X-Received: by 2002:a05:600c:3d89:b0:40e:9d77:d9c2 with SMTP id
 bi9-20020a05600c3d8900b0040e9d77d9c2mr276934wmb.32.1705706597125; 
 Fri, 19 Jan 2024 15:23:17 -0800 (PST)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 z4-20020a5d6544000000b00337bfa4e638sm7526710wrv.59.2024.01.19.15.23.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jan 2024 15:23:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 15/38 4/6] target/s390x: Reorder CC_OP_STATIC switch case
 in disas_jcc (4/5)
Date: Sat, 20 Jan 2024 00:23:00 +0100
Message-ID: <20240119232302.50393-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240110224408.10444-16-richard.henderson@linaro.org>
References: <20240110224408.10444-16-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Code movement to ease review, no logical change.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/tcg/translate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index fd1138c684..9224df867b 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -914,10 +914,6 @@ static void disas_jcc(DisasContext *s, DisasCompare *c, uint32_t mask)
             cond = TCG_COND_LTU;
             c->u.s32.b = tcg_constant_i32(2);
             break;
-        case 0x8: /* cc == 0 */
-            cond = TCG_COND_EQ;
-            c->u.s32.b = tcg_constant_i32(0);
-            break;
         case 0x4 | 0x1: /* cc == 1 || cc == 3 => (cc & 1) != 0 */
             cond = TCG_COND_NE;
             c->u.s32.a = tcg_temp_new_i32();
@@ -938,6 +934,10 @@ static void disas_jcc(DisasContext *s, DisasCompare *c, uint32_t mask)
             cond = TCG_COND_GTU;
             c->u.s32.b = tcg_constant_i32(1);
             break;
+        case 0x8: /* cc == 0 */
+            cond = TCG_COND_EQ;
+            c->u.s32.b = tcg_constant_i32(0);
+            break;
         default:
             /* CC is masked by something else: (8 >> cc) & mask.  */
             cond = TCG_COND_NE;
-- 
2.41.0


