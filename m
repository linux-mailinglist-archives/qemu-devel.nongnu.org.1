Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFB181AD5A
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:24:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9Z6-0007Ip-Av; Wed, 20 Dec 2023 22:17:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9Yx-0007Ia-R5
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:17:31 -0500
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9Yw-0003ht-Eo
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:17:31 -0500
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-78109a21144so22008785a.0
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703128649; x=1703733449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N0r38Np42udsEJQmZQn5+cDvuZVIj+90Kpy1j8QxGC4=;
 b=pFDHGns7fbJfvBYvp14RB5aC4i28KU9TeUhLeU/5rfk2+JFYddIEh+gaAh5kfygCBW
 iWzaTOIHSVeV8G5Gd94Zd8P0pz22RfWq2lOCIWruqhQP8H/SZTyWNiYMi04c8xOiDsIa
 Np/yY1NZvQC8uQt3iEBNXeqHu9p/QyZ6zD77467SwsD85hWNgOt70CChpRt9IxFhz3nz
 VvH+mIe7M3TJj3A0QfAVHXOlFeJJh2WxbODsLpbQgWv8Se/aRXRUq1/XEFgK0yW51OlL
 uV/PxV7Z0XkaXmTV876OiF3HXwGHvfPnURnzNDoK/+BdaQB8fmzj1dJW5HWSXh0QwALJ
 /EyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703128649; x=1703733449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N0r38Np42udsEJQmZQn5+cDvuZVIj+90Kpy1j8QxGC4=;
 b=aGAXd4Qd+3xtWkzvSILKGhp7Kc2gfiHKTGbf6IKuSi80gOTRuHfIm3otmw1PN8a16R
 9IF1yO/yOlZYD2nEAaU0zoNLBw7w6Udzql3fJmbUMRpwmF3tHh08+debzH7dRzyN7gB1
 vlJblgI+nmsdnny8oKJfYT8K4HOu451QlwsIa443BvFOFBHAFCGLzjyy/+4MnWM3Mr/c
 QSggOiw4ZeQHQgHdPZf/MtTuEt64b7wOecIACA//+eOLinM79wtg5HUJAxiAo5zLhTbh
 1qPh1KbBEMGRPsvIRjDcGGLQVGMsGYnb0p09/zH4Vxr6g2kiFz3p6frrXe96owcpoY1L
 Q1mg==
X-Gm-Message-State: AOJu0YwTZ7m0hFDJvpLlxarSNwemy3PChIj/rwpmsbZLCJxvvs3prsYD
 QyRNC6qmWkvfawl9apXL9un8DA6r+XIJFLX7FdoCiftl
X-Google-Smtp-Source: AGHT+IHSgDWNrq7ZD/VTNiuXCLfu7uXqFMOY64a2kD3gvf+x6n/6IoTEZqdAU+6RrxtvprbP3xw/5g==
X-Received: by 2002:a05:620a:d94:b0:77f:b70c:8299 with SMTP id
 q20-20020a05620a0d9400b0077fb70c8299mr11829353qkl.18.1703128649691; 
 Wed, 20 Dec 2023 19:17:29 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 n8-20020a05620a294800b0078116d55191sm360808qkp.130.2023.12.20.19.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:17:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 05/71] target/avr: Constify VMState in machine.c
Date: Thu, 21 Dec 2023 14:15:46 +1100
Message-Id: <20231221031652.119827-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::730;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x730.google.com
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

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/avr/machine.c b/target/avr/machine.c
index 16f7a3e031..4402862fb9 100644
--- a/target/avr/machine.c
+++ b/target/avr/machine.c
@@ -100,7 +100,7 @@ const VMStateDescription vms_avr_cpu = {
     .name = "cpu",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(env.pc_w, AVRCPU),
         VMSTATE_UINT32(env.sp, AVRCPU),
         VMSTATE_UINT32(env.skip, AVRCPU),
-- 
2.34.1


