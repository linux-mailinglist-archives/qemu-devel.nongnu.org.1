Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FDF7EB7A6
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 21:19:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2zr3-0000N8-V9; Tue, 14 Nov 2023 15:17:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2zr1-0000MC-Jp
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 15:17:47 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2zqz-0008HI-LG
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 15:17:47 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6b5af4662b7so5315343b3a.3
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 12:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699993064; x=1700597864; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0BGlZQSWNYq+UX1DZnJCxaL6IF30deqH3Jt+zw05A24=;
 b=OHlvke2UJO1P3afygKX70VHps12q/ArV0lVX13E7ZbOmdncPvWdPh1wW3waLZIwXmT
 cqDy+5vuOYCfzhJqdMkFGIQixAET8/1m23WeT4m6ZsWJ+SjHaYnVa+pOwiZxUqZx6ivL
 rzVu/VuWJMVZQqZR2CcbJNZOdf/VY0HEweRpv4QKzKOrNlkfADqKQUYROu8N0FPC2UkR
 4YFpFK8/IZRmmP6l6ew6ThHe7DxwObxqO4vlDmfhnhTqbWYE6XcNa1NxkehllknlYmJX
 ePkj9u7Z9HkOu/eZAKu7XAt829QwaKxnruQXugujAc2sy5WE2Xd8/pmPjUkm5+o+hRMm
 1L2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699993064; x=1700597864;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0BGlZQSWNYq+UX1DZnJCxaL6IF30deqH3Jt+zw05A24=;
 b=TarR6t5mG7SkJPi0a5OUM3h2QoaI0CtiHVjIp162yytRZp9y55VXChSEA0R+iSlC+2
 agmM49VDzxO++P/Ebmmh3oq79tfMUoBWCFqkG3A3E2ZHP//YFDza2yG+2zNczuVUlIVr
 RcjqkXcKisCpKKCGnxtJ0x1NOTZQ3I5V61+K4BpQfWd1riQS/ic5WB5dF7g0jg90GeE3
 JumS8sS1USN3ijjNF1zeEQ4wY5pgqU0pWgEfhRcRFon5y3brALmHB38ZgNwBkuRBu2yP
 s8BJ18Y4t8+lUvZvsbHh5eNaFdMXpiVRD1RLTRVqKB7tyhulZ4Khh6z4SPzMPafdjF6q
 M/ew==
X-Gm-Message-State: AOJu0Yx+Ih1bU9A67kouvnTSxv05Gi+BfTTqpgDJNoRTD8dogsfTTA/d
 Y958045FzBX9BeUAJyPzadLy4fR0J5HuwnHw3/c=
X-Google-Smtp-Source: AGHT+IHptBm6MBOLNToAdOH/BdElx9QY6S/vRxWC4isM5SNu2EpZcb/a8qsQmLhxYJGvlOs0LnO99g==
X-Received: by 2002:a05:6a00:4390:b0:690:ce30:47ba with SMTP id
 bt16-20020a056a00439000b00690ce3047bamr10193090pfb.10.1699993063771; 
 Tue, 14 Nov 2023 12:17:43 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k6-20020a056a00134600b006c69851c7c9sm1559077pfu.181.2023.11.14.12.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 12:17:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	mjt@tls.msk.ru,
	qemu-stable@nongnu.org
Subject: [PATCH for-8.2] linux-user: Fix loaddr computation for some elf files
Date: Tue, 14 Nov 2023 12:17:42 -0800
Message-Id: <20231114201742.183271-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

The file offset of the load segment is not relevant to the
low address, only the beginning of the virtual address page.

Cc: qemu-stable@nongnu.org
Fixes: a93934fecd4 ("elf: take phdr offset into account when calculating the program load address")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1952
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 4cd6891d7b..cf9e74468b 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3308,7 +3308,7 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
     for (i = 0; i < ehdr->e_phnum; ++i) {
         struct elf_phdr *eppnt = phdr + i;
         if (eppnt->p_type == PT_LOAD) {
-            abi_ulong a = eppnt->p_vaddr - eppnt->p_offset;
+            abi_ulong a = eppnt->p_vaddr & TARGET_PAGE_MASK;
             if (a < loaddr) {
                 loaddr = a;
             }
-- 
2.34.1


