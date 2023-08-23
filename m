Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C12786180
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:27:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuRi-00068N-2i; Wed, 23 Aug 2023 16:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuRe-0005XK-Dk
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:27:14 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuRc-0006DY-Mr
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:27:14 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-53482b44007so3484120a12.2
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822431; x=1693427231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WwQYaeS2yjo0iydPx+8m5saMzA4puxq3QLJOAgwD58U=;
 b=RqQvFVNNLJHsJ0Oodc17xEgfcO9fwaeYoQO3ND2oq9JsHO0LGGOthh400tofDo7bOZ
 UBMfBeigeUr4j6G5hy6BvPnvsai61qcrN2AaAMCFS39mE1QrK3XJb8MWUsQ4dSKvUrTO
 VJou+EgN0lfXeIDEK3zElGYJGz+e6sQtlqOyjALZtIoGF00muvY8hwv/lyOIFpfcPGez
 4APhIM3QaWqp+8DIZUUbVO1q7OWbda045XNK3AVmCtY1LRIP08j6KFVlW87CDP0cnJja
 JGcEqpAGqVwK1mGPKwB7QCczI20ewIt1lwJq1v0jJbeUfSFy6vWQXRVn+BjoUtSn2nJi
 miaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822431; x=1693427231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WwQYaeS2yjo0iydPx+8m5saMzA4puxq3QLJOAgwD58U=;
 b=bW/DGjfJZT4pTx/8uuUql420mn6OxszUbfPbKSiB9g7BFA3xiB8Hm9n4GmTB7RFebF
 9Vyoqw7QTYyivD0rHW4CiVHN/+tt5XMPZtQDMGq7/YUEE100qFWD2pX1vhpjqDgntSIH
 sGuQ2tpzn5t4vcd/L5ZZXnYUn8+OnJ7TGLNfqB1sYEB0uxzl1lLr6PP9cTKXj/9Ic4rP
 08y3O/Xq7mJFWqQ9TtJGBAXbVO224a93nAhV9Xyz1ahhVVYytuDmytOG3xRBK/vRIGTL
 waW+fmLJWXfNZSrI/lX1wZfgpanzYYpoGTEbfDQb75DTNzMlcRF4LysP7VNNq0mHxQ3d
 ScCg==
X-Gm-Message-State: AOJu0YxnUvGmX4aMwvn8x5fafqRAwDOZ04UUyhYBQUFj8LlJqEH02CBy
 KToFnK2i7DpyxQLa7EUrrciXWmUQjo1Hu5MhIDI=
X-Google-Smtp-Source: AGHT+IG81nzfv3p17+MTs+50oV6JKZvq55torcVYJ+L1K5LEFOzjcYCDPIrATiPnyHwuMPlCulfjZw==
X-Received: by 2002:a05:6a21:3d94:b0:13c:8e50:34b8 with SMTP id
 bj20-20020a056a213d9400b0013c8e5034b8mr11304616pzc.35.1692822431138; 
 Wed, 23 Aug 2023 13:27:11 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 j25-20020aa783d9000000b006873aa079aasm10117871pfn.171.2023.08.23.13.27.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:27:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 47/48] docs/devel/tcg-ops: fix missing newlines in "Host vector
 operations"
Date: Wed, 23 Aug 2023 13:23:25 -0700
Message-Id: <20230823202326.1353645-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This unintentionally causes the mov_vec, ld_vec and st_vec operations
to appear on the same line.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230823141740.35974-1-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/devel/tcg-ops.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 9e2a931d85..8ae59ea02b 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -718,7 +718,9 @@ E.g. VECL = 1 -> 64 << 1 -> v128, and VECE = 2 -> 1 << 2 -> i32.
 .. list-table::
 
    * - mov_vec *v0*, *v1*
+
        ld_vec *v0*, *t1*
+
        st_vec *v0*, *t1*
 
      - | Move, load and store.
-- 
2.34.1


