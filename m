Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDAF8201BF
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:29:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKQL-0000yA-6D; Fri, 29 Dec 2023 16:29:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKQF-0000IB-6L
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:29:39 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKQD-0000RQ-DD
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:29:38 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6da47688fd9so327941b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885376; x=1704490176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M7Lza5D+iII9yK1P5GdP5roYCy14hxv1Hja38xdJAFg=;
 b=M920ShM67Zm25lSY72bvOWMEHjqT9eWE1TcN651XZINtQe+OPYCaRKNZwWdWgJaPi/
 Ht9g/LnLFz86LMLXx68v5MTCkmrnQbM4qZfg2K4Eb7/vux/Wg4ExnSb5fq/RNSTUTf/v
 WZRYxAxv/kG25S3EykNOY2OFj+oL9Ekqe5h7d+n4wWySOrn79Bqr/aWT/mBP9rPI4dmR
 JgnW9gOTYz4w+Mt81qnKMORNp1mz5OeI9ZHvTZaCL+eb/kRP2/c2eljXnv9VgtENJ3k8
 VRtUHG3sX6Df1gs5D51Z+pF9XX56rM/D5xs/UBene3UDfuFZPwzNVLTVa8hfbYg8davf
 kAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885376; x=1704490176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M7Lza5D+iII9yK1P5GdP5roYCy14hxv1Hja38xdJAFg=;
 b=blbdICtu7sCGwyT9lz/7HBoQqFnLg6fC5Nymvg/g+rEJSA0ZFRn211/e3cIYDL+HdV
 qHmz9lFKyCu8djD2PUmZeQJsqSs1rNnMHk363i3IMEopPm26f2C1R4jGZ6VXBiEePYHD
 eEilLpS904QJ/Kg1fimU0fOUNkGD4yO3IbpdWuua4lHN5vgWIXr9ove1xI50z28aBYLQ
 9vfpXZ4L86BZ/Qhita+iYTLug7fQfFsyFKFf+CRuiWVn10r8lm87kmCVusjo0HLMhqR8
 pm/2zBZFmQeMurs/hFjFxauPFgxeQHJDryc3nnuCPxLHnzsFpjcmRpBLrqq0DRbfkbSF
 4V8g==
X-Gm-Message-State: AOJu0YzjN14bQrCgOtRJqxOgA9QF9lxYuow5xxenYJ2Uj/E/GMew8uNm
 q3TBHfnFhRC2mFFjbhAHEhDHbQL09tFNaAbnXaftUIvt0tKlwg==
X-Google-Smtp-Source: AGHT+IEHexNUJqTy53Vs7e77msEX3OVMaeskWxo/5+YNQOGkxS6kDBfmOe1ylETBd2mhqeMOY1Ej0g==
X-Received: by 2002:a05:6a00:2355:b0:6d9:b95c:6608 with SMTP id
 j21-20020a056a00235500b006d9b95c6608mr4468410pfj.41.1703885375950; 
 Fri, 29 Dec 2023 13:29:35 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 bd33-20020a056a0027a100b006d9a96b7d0dsm11285396pfb.208.2023.12.29.13.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:29:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 69/71] util/fifo8: Constify VMState
Date: Sat, 30 Dec 2023 08:23:44 +1100
Message-Id: <20231229212346.147149-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231221031652.119827-70-richard.henderson@linaro.org>
---
 util/fifo8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/fifo8.c b/util/fifo8.c
index d4d1c135e0..de8fd0f1c5 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -109,7 +109,7 @@ const VMStateDescription vmstate_fifo8 = {
     .name = "Fifo8",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VBUFFER_UINT32(data, Fifo8, 1, NULL, capacity),
         VMSTATE_UINT32(head, Fifo8),
         VMSTATE_UINT32(num, Fifo8),
-- 
2.34.1


