Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0D8716D2B
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:06:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44a0-0000v1-JK; Tue, 30 May 2023 15:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44Zp-0000rc-EF
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:00:13 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44Zn-00018v-Fk
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:00:13 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-52cb78647ecso3096438a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685473209; x=1688065209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=THhkGZr6a/UiI45iUYjbN0L/k4ifkcv6BhtXqusiewE=;
 b=w2C7V0d3nAHhcXPvsJ560J8hhJbC/h9tKhqOQSGC66XeZA03LYJuja81vH7acrrL6O
 fjv01ELyiRYMojImH7vqKJ8ejSO05DC00Pe0l9Q+DpW7tEp8u5BhcX6AP88+N74U8VVk
 D4BCKk6N0HO7aLIelgncSycV28YK6e6mwYYG9kAAE5NOEqILYe+yfeCD0hP3Wjlz4B4j
 VRbl40g9fBHHOHUc85tx6kXIK1dnVOw6l0HEb0H2V58YIYH79H6CFPGjjsiz7zl5E7LR
 gGtcZLRaYb566lPzUJ5C+pmrG+uP+kdcQdpMBxsxzc4Cu0cR5JQygHnyaocG9aqcxxPk
 JmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685473209; x=1688065209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=THhkGZr6a/UiI45iUYjbN0L/k4ifkcv6BhtXqusiewE=;
 b=M44TARXEcs+L7IvAG6RgvQI38ehLkEDxnMJHl5HwYW7gcKZurShbDTXVKETOoDxCnI
 ZoRlaQ1iINdtZd/jo84O+gCO9SbE3Z5cnIL4CewXb0YBu8QCQjxDMtcM0sqwxBRXPvIe
 vkFiwa+fG5xazfXbkOmaGPFaKDMvRuIMhcByXkCe3kz5voov5fJo5qBmuuNV2RjNtp9J
 1ub7yrrDw4/Lpz3KEfK2u5yAzkbbhi5Dwf7TLhz01XjoVI6VjSx229teazPrMAk4UE8d
 lm3G4w08Ps49WZjNu4ahffgXfk1wiH7eEauiIdbXE6tVv9JsDc0zyTBRd/lcWmRO+sMc
 ND6g==
X-Gm-Message-State: AC+VfDxbaPtrn1PsGJ5LBgrNAcOdXege+4zcxh02Odw+xU6+G6QLQDK9
 ik51qqpQ2m3UjNsgezehtgiCCBtCbXHPDyi5rFE=
X-Google-Smtp-Source: ACHHUZ4w0wp8v8fd5Arh4xfZQq9Qr7jnrqErAfANREj7WzjZCzKA0cjrWUE5K01nJpohS9RzOj5Siw==
X-Received: by 2002:a05:6a20:1610:b0:10b:8698:2097 with SMTP id
 l16-20020a056a20161000b0010b86982097mr4169932pzj.0.1685473209289; 
 Tue, 30 May 2023 12:00:09 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a63fa52000000b0051f14839bf3sm9128496pgk.34.2023.05.30.12.00.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:00:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/27] decodetree: Do not remove output_file from /dev
Date: Tue, 30 May 2023 11:59:43 -0700
Message-Id: <20230530185949.410208-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530185949.410208-1-richard.henderson@linaro.org>
References: <20230530185949.410208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

Nor report any PermissionError on remove.
The primary purpose is testing with -o /dev/null.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/decodetree.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index e4ef0a03cc..a9a0cd0fa3 100644
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -71,7 +71,12 @@ def error_with_file(file, lineno, *args):
 
     if output_file and output_fd:
         output_fd.close()
-        os.remove(output_file)
+        # Do not try to remove e.g. -o /dev/null
+        if not output_file.startswith("/dev"):
+            try:
+                os.remove(output_file)
+            except PermissionError:
+                pass
     exit(0 if testforerror else 1)
 # end error_with_file
 
-- 
2.34.1


