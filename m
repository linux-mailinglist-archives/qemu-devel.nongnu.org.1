Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B055B786BE2
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:30:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6er-00083a-Bl; Thu, 24 Aug 2023 05:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6e9-00047R-4F
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:28:59 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6e1-0004yW-Ne
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:28:53 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-4ff8f2630e3so10386526e87.1
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 02:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692869323; x=1693474123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rDBvn+8aP4FuM7R/tw2wMoRa69yeF0kW2DF1HQRjT0U=;
 b=Uk3yZPrneVeCZefuFulG6pI7sV78J9QS6OYQ59as/SIS4zvALIJwW7TCwx6VgZmzfW
 TaRQsOBeUOwvDanRQQFo6Hcn0rIxQadsqpRdOtrkPWYYwh3GrjtTdKgkUaHRE7KH3/UT
 lZdqka5jqUrGVo2ZOK2uSTTGT+WfmgZxHulLIR8SqF9zDd2QEBrmSWvbNaKyTsSlkzY6
 Zh+br9qpnAJae57Vtp6C2e4BTPjJdueGdMjXfkT0lfUkACkqN6IZdb/WR72r5tApgfWU
 2bihS0Wg/ontiAayNDxBrhQ9BI9KGzTM9laCzRYBKoovonlIo9bRtdB/2I6MAKFZ3QKg
 TS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692869323; x=1693474123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rDBvn+8aP4FuM7R/tw2wMoRa69yeF0kW2DF1HQRjT0U=;
 b=aat0P1TA2kRfmb93pcHmkw/fLfZChSoTr22lY4zSbQ+rY/VEPkoXax0wTr7CiQfNJ3
 XCDv125skv+Zmsb9cH6SQTnr86sLIqMkkwUx0KfUUFfOZMT3QaV1xoj/HOpU46yI0gW/
 E2ubzHtbwKL108GGw6oe8VEiqbtyb4Xpq6mSmuo6/fDaHi9qUaJSg3GPj2K/y8hyw2NN
 n6nnzVGRsTMa8OPcEGDrrvbjT0Yta8ZmIfBIYvwXZLC9PRuMFVM82q+fegXo8ztEeBeP
 J6OpcI7nK90rQlAO3zL53qkDtM9ZmagAUMci/WuIPL/byoFE+FZJmZBLHO2F9ZYGGBr3
 gAgw==
X-Gm-Message-State: AOJu0YxRlSCmM9G9vXKGx4KU1HDAwWNa4jjwU1KBWE79uPwu07kXl8oi
 CuLuYCtviThcgnh8XUa85Ay2mKoSg2xJsv2aeV4=
X-Google-Smtp-Source: AGHT+IEXsE1HWFOThAP0vCO6Eyk9HhxVOS0evO5AX/JUOJwi9AUSu0EFdNUE52MaFrMyv8zv+oYdng==
X-Received: by 2002:a05:6512:459:b0:500:9704:3c9 with SMTP id
 y25-20020a056512045900b00500970403c9mr2512839lfk.26.1692869323008; 
 Thu, 24 Aug 2023 02:28:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s12-20020adfeccc000000b00317b5c8a4f1sm21844004wro.60.2023.08.24.02.28.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 02:28:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/35] accel/kvm: Free as when an error occurred
Date: Thu, 24 Aug 2023 10:28:12 +0100
Message-Id: <20230824092836.2239644-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824092836.2239644-1-peter.maydell@linaro.org>
References: <20230824092836.2239644-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12f.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

An error may occur after s->as is allocated, for example if the
KVM_CREATE_VM ioctl call fails.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-id: 20230727073134.134102-6-akihiko.odaki@daynix.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: tweaked commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 accel/kvm/kvm-all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 3bac5aa678b..ed30f4135b5 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2765,6 +2765,7 @@ err:
     if (s->fd != -1) {
         close(s->fd);
     }
+    g_free(s->as);
     g_free(s->memory_listener.slots);
 
     return ret;
-- 
2.34.1


