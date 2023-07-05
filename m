Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE397484D2
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 15:19:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH2Pb-0007YR-Ty; Wed, 05 Jul 2023 09:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qH2PY-0007Xs-FV
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 09:19:12 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qH2PW-00073k-UN
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 09:19:12 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-51d946d2634so8052168a12.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 06:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688563149; x=1691155149;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ioBwe0OLq/VGRiubaGlaJ87m8J6eLas7reANWo7Qc3Y=;
 b=oSmQLQ/JLdAjVcAGuD7FLSscv8gJwH3F1Fo7ASkO0qeQ6d6dLeHjl+3gkqfI56tWGH
 w9VXdWhqS3hrVih0uW8a3UH9p+AV/HwtwPheo+SEEqHVIuqy9u57ieWqVmKiSfH17S7f
 82WaRCeR1mGuTgKOPKwYvavAiUV0Lg6Yi+fop12ZbfjADu7QT7x6RRxjJiP4iwGtXp88
 vTF9xKDRvFp/TPOZuPv2L26QfVlA9cHk9IR3AxuyjdsX1jYPYmEiDZq4lSWhS9p4Jqz7
 JRdewEA1cG0nU3G65ai2kBsSC2PwL+tS4hwwbk03EcAItu8zPvL/xHmPB89fHtkSTnsF
 q2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688563149; x=1691155149;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ioBwe0OLq/VGRiubaGlaJ87m8J6eLas7reANWo7Qc3Y=;
 b=cBrBxlPanVuqu5CkYenycAsY3fna/Qln0MEzRJSYD0nW030rFoI6xTrN6aOm1Fb7rs
 W756Ebptns77aQXdZZe+K4ZwYSWNZDZcQ5u0c09d7F3tGgzBNUDEk3+OX1z6Aoxu4OO7
 AM6ZdC66/P0bUY6Fqx0KUa+b4O0ZbRLRp8q83y0cNnJ2ab6jUj3MyLoFomgm7K17KiiU
 4qnXFu8tAmbnfQIPM8EhJJ9zxZXGBl0aYqTVt4SK6oKQ0cnaL2xIsMyomqFtfRZOEmF2
 8ZgP8CvEkjbrRgQuZjCbHZ7ayOtNOQ3+JpOFPtQZ33CsmcjTSjwor0T36iexSYKyNgvA
 gkPA==
X-Gm-Message-State: ABy/qLY7w57/e/Ha9aiPIZk+DdHPAyHoCX5C2ZCaPZEbs3o30ZGmLmwR
 WRwjrAeye2K1fLsUpNjjpODLj9Ye2Fhk1RTKKbU=
X-Google-Smtp-Source: APBJJlF3EiaWFVL8oBcz6entS98WxhLUA4Om4rjSz5MACppkn6JR+vDppCT4dC9BCvQwGnw6aXuFow==
X-Received: by 2002:a17:906:3913:b0:977:e87c:e633 with SMTP id
 f19-20020a170906391300b00977e87ce633mr13692662eje.23.1688563148976; 
 Wed, 05 Jul 2023 06:19:08 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.96])
 by smtp.gmail.com with ESMTPSA id
 gy18-20020a170906f25200b0099297782aa9sm8999462ejb.49.2023.07.05.06.19.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 05 Jul 2023 06:19:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/3] util/fifo8: Introduce fifo8_peek_buf()
Date: Wed,  5 Jul 2023 15:18:56 +0200
Message-Id: <20230705131859.53970-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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

Extracted from "hw/char/pl011: Implement TX (async) FIFO":
https://lore.kernel.org/qemu-devel/20230522153144.30610-1-philmd@linaro.org/

All series reviewed.

Philippe Mathieu-Daudé (3):
  util/fifo8: Fix typo in fifo8_push_all() description
  util/fifo8: Allow fifo8_pop_buf() to not populate popped length
  util/fifo8: Introduce fifo8_peek_buf()

 include/qemu/fifo8.h | 39 +++++++++++++++++++++++++++++++++------
 util/fifo8.c         | 28 +++++++++++++++++++++++-----
 2 files changed, 56 insertions(+), 11 deletions(-)

-- 
2.38.1


