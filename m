Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B508821646
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 03:02:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKU3v-0004Aq-3y; Mon, 01 Jan 2024 20:59:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3s-00044I-IZ
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:59:20 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3r-00076z-0X
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:59:20 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5bdbe2de25fso7047200a12.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jan 2024 17:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704160757; x=1704765557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cKA7tvrOkGtPLWpEPatX1MbkSLxefO/Qsp6i6MEPEuU=;
 b=Xbv57JQwqEVC7t8eeKcadGzP8eoMWfKouwFxmMHCgmBpH2m8mqSqWubw3n3xV+wAmr
 XIDABjfTqDz7dm6HXiJPxmuiaM5UOEDgp8e6j/x0dZ+oQYPqAIdcUDbXUjIsthJ2qJl/
 oZDGOSTOrJuPQTkwlMZHDQlH4Tc54FrXHQN8UDnn/gOL5AH/F32ccLOjnrztg5VPUktS
 NbeXrwPfZxa0wRSMwTHnzmWDKeNXXxEWJ7iTU6iox2nLxXYBWJKQ1BBdEDp0TSDyE93L
 OJvsXWJkbwIN0evh0LWy+Zy/Io1CveslhPwMSgHD2bdLALDJl2hyJVNh7Sm3xJnJqfEC
 zdhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704160757; x=1704765557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cKA7tvrOkGtPLWpEPatX1MbkSLxefO/Qsp6i6MEPEuU=;
 b=aKfbOYW0FiW/KK3rRopA79Ck1zq3vWO77wF+W2Ix0r0CWaXNSOqpvQeV/6/YhLczqw
 6Rz5bTghYFYLiehAluHFnNeGgVYNbIiFniKMwjpK0iFpWIRfxG1n5TCdr2s+2Ckpc4ss
 jftcbm0mWC9UwLDYKNFt4uZCE2MnDaSRfWpGqA+kIDcQRgh7TaaDWRDT+t+Tw3202Aet
 u7w13oYXohlwJ4GvuL3e4Hrb5a14gAf8/CQm5SLE6/ONK429RTF5VCKiUMksRk6rjduR
 H9NocqlU8ay1auIR2yaugB0ePxjolF0PXcs3quWzAG4SfuC+9yAQsEtEeHSEEVDKcLoA
 0Qkg==
X-Gm-Message-State: AOJu0YxgfrsEkbtu/K2FUKomz7L2qKjAXg5/u8YwHd7UHjhc4XNlZ2BE
 pESURMkW5UnjtnYo9G/aSUG2qyikPpWbd8k7C13QO6VfY+4=
X-Google-Smtp-Source: AGHT+IF0VPFNCiKp6I6Eq/Eruaa8wVMAxzlNRHyjfPYWdOyZa/83k0so/SQZYzKzRLH3ksC6OgqwHQ==
X-Received: by 2002:a05:6a20:321b:b0:194:228d:c24d with SMTP id
 hl27-20020a056a20321b00b00194228dc24dmr20490371pzc.42.1704160757558; 
 Mon, 01 Jan 2024 17:59:17 -0800 (PST)
Received: from stoup.. (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a635221000000b0058ee60f8e4dsm19561891pgb.34.2024.01.01.17.59.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jan 2024 17:59:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 31/33] linux-user: Bound mmap_min_addr by host page size
Date: Tue,  2 Jan 2024 12:58:06 +1100
Message-Id: <20240102015808.132373-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102015808.132373-1-richard.henderson@linaro.org>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

Bizzarely, it is possible to set /proc/sys/vm/mmap_min_addr
to a value below the host page size.  Fix that.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index d00a0d7d1f..d5f3fa26c0 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -904,7 +904,7 @@ int main(int argc, char **argv, char **envp)
         if ((fp = fopen("/proc/sys/vm/mmap_min_addr", "r")) != NULL) {
             unsigned long tmp;
             if (fscanf(fp, "%lu", &tmp) == 1 && tmp != 0) {
-                mmap_min_addr = tmp;
+                mmap_min_addr = MAX(tmp, host_page_size);
                 qemu_log_mask(CPU_LOG_PAGE, "host mmap_min_addr=0x%lx\n",
                               mmap_min_addr);
             }
-- 
2.34.1


