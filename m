Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A797174E1
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:11:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D7H-0003U3-Qa; Wed, 31 May 2023 00:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D7B-0003DB-Cl
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:07:14 -0400
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D76-0006vI-06
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:07:13 -0400
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-33b1e83e1daso5402115ab.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685506025; x=1688098025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Br8zXaVAOKNlB9xv5g9cPNHLqbtW8oBpWMoxXID7zwE=;
 b=JkjY80sN/xIzZs3jW1dXf1x9YB1B3+ml++vbzcmpCNqkuHMUGHYQMGMtp9W25QyB8X
 mMrST86zk1QZE7U/yupamBEiaqQR2At1sOPewGnHTK5FmpSTIl+pbqrHEeETLzV+5EEs
 s+QEkGzJ56StWc98IYNxnhTVMLqvarj1pWOKQhaQKNM2qFPHKt8GsUT6KvOkpWiqSsl5
 THYwzpalefNJ0IwN+VmJEND4+2T0aWDp2QQeik/B9MMxP6wM2FrGoSr+s93DsT0pvQEu
 0im4ydKkif0gg2HJ8LSc45jXCMzfc4LaSiOwP6kO62WznOViRNpJOzCQ5tSIfvjxEAEh
 /WNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685506025; x=1688098025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Br8zXaVAOKNlB9xv5g9cPNHLqbtW8oBpWMoxXID7zwE=;
 b=ftqR+vG6RMOdpP4zQ1TD8T1kx6mYJsOrTujrQXV/OMZwgtAINAvR1Oqc1YXhcnVue3
 5+sTX2C3O3E6mpolO0gApSBRWdMIhMjqMomffRP18H9W6IxOoXNxS/Xx+Vgmyuva06iw
 BrJqDuelo4DQ1iMogdz5FV7Ncc4MxvemNO+LOydiw7UJye6gjS7GgtrR6eNet1wlYk8i
 2iILBsb4Q7wfsX+YLfFd8K0VDoRoLixvWzamsj1ni7n7iSBiEAWCTlfUfHojCXBZrqHz
 M788glgblPMyX0+eHmL7VKi+XjYYq3Wl9rZYMPiVupBlt8rEXh43eAVEwbJxyJ/Wz6lK
 z6uA==
X-Gm-Message-State: AC+VfDy3rubPy70IiJz9zp2doaffj1xNjpYk3bHn5r80s3itXDtuwuoF
 bsgBtyjVq5Gwjsgg5gHrGLETPhJ9KVMHv6wCbFs=
X-Google-Smtp-Source: ACHHUZ4hYIWYhXnXwaQ3Mu5DkwDuh7jPtMiKxqyMmkx4XjKn1aWkkF9TEV1WojfBMDppGBXfQjBphA==
X-Received: by 2002:a05:6e02:5cf:b0:335:9028:d6d1 with SMTP id
 l15-20020a056e0205cf00b003359028d6d1mr999753ils.32.1685506025671; 
 Tue, 30 May 2023 21:07:05 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a170902f7cd00b001aadd0d7364sm151797plw.83.2023.05.30.21.07.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:07:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 43/48] tcg: Move env defines out of NEED_CPU_H in
 helper-head.h
Date: Tue, 30 May 2023 21:03:25 -0700
Message-Id: <20230531040330.8950-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12b;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12b.google.com
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

Since the change to CPUArchState, we have a common typedef
that can always be used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/helper-head.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/exec/helper-head.h b/include/exec/helper-head.h
index a355ef8ebe..28ceab0a46 100644
--- a/include/exec/helper-head.h
+++ b/include/exec/helper-head.h
@@ -22,6 +22,7 @@
 #define dh_alias_f64 i64
 #define dh_alias_ptr ptr
 #define dh_alias_cptr ptr
+#define dh_alias_env ptr
 #define dh_alias_void void
 #define dh_alias_noreturn noreturn
 #define dh_alias(t) glue(dh_alias_, t)
@@ -37,6 +38,7 @@
 #define dh_ctype_f64 float64
 #define dh_ctype_ptr void *
 #define dh_ctype_cptr const void *
+#define dh_ctype_env CPUArchState *
 #define dh_ctype_void void
 #define dh_ctype_noreturn G_NORETURN void
 #define dh_ctype(t) dh_ctype_##t
@@ -52,9 +54,6 @@
 #  endif
 # endif
 # define dh_ctype_tl target_ulong
-# define dh_alias_env ptr
-# define dh_ctype_env CPUArchState *
-# define dh_typecode_env dh_typecode_ptr
 #endif
 
 /* We can't use glue() here because it falls foul of C preprocessor
@@ -96,6 +95,7 @@
 #define dh_typecode_f32 dh_typecode_i32
 #define dh_typecode_f64 dh_typecode_i64
 #define dh_typecode_cptr dh_typecode_ptr
+#define dh_typecode_env dh_typecode_ptr
 #define dh_typecode(t) dh_typecode_##t
 
 #define dh_callflag_i32  0
-- 
2.34.1


