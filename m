Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D90407187DB
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 18:57:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4P6z-000100-4c; Wed, 31 May 2023 12:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3DHx3ZAQKCg0sy97t11tyr.p1z3rz7-qr8ry010t07.14t@flex--flwu.bounces.google.com>)
 id 1q4P6x-0000zV-J5
 for qemu-devel@nongnu.org; Wed, 31 May 2023 12:55:47 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3DHx3ZAQKCg0sy97t11tyr.p1z3rz7-qr8ry010t07.14t@flex--flwu.bounces.google.com>)
 id 1q4P6s-0002f5-F6
 for qemu-devel@nongnu.org; Wed, 31 May 2023 12:55:47 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-568a85f180dso48854357b3.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 09:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1685552140; x=1688144140;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=nk2APEzF/f+KlYCoahOjgtbapi9OrU7D3SgXtUw4m5Y=;
 b=FEndrvXXbeWLek8rePu5pp/IILCzklHygAkODqlwqG89/+A6wJTf8Kxvry33GWSDPa
 /HdSC73/+gYj5LWQviKqUAqfG6UA0cQ1TZbz0UO+F6ASEBAWvs0RxYkHQTiDb1OHfzoE
 VBw603hVw5OGk1usXOZRTgtXhsjJr4LsXKuFdRSMJaJSntSfW4QkilzHK6M1AIRZ8OYW
 iUp4QcUOYzPNv5/0cNW2uGY1HJrX192wsfda7zAnjOevzRy3zngTiiKR3LU9joGkC+Gy
 6sqMsJnrcsWecmAHtnqkrMcn5N4pBZmH5rKT4wuwRJuwJiLH7TOn5O/0RzkmjTt59CXB
 jCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685552140; x=1688144140;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nk2APEzF/f+KlYCoahOjgtbapi9OrU7D3SgXtUw4m5Y=;
 b=cy4dSTiwtsXGcrvFsccnZGw+j2c+rvf7JKzSSzCMT+agPAOcjdrY0EpQ5Pnur2lvcX
 BssFDkbOEhrYKUKNl41SDggjHbvs31ssvhIM1inJ03QnluO5RKfkEue3yq7QZF9B0yu7
 jO2GHlJzhmYIC6yI6UtSe4RnJ+OEexk2vtb04PPrzsIb67EigyEsa4tIk6broehGw3ZF
 6alvfIQ/tVJHzMBti8Ezo9sVnEZY/S/rVlRnJCFfYB+0NkDB+iWynflE6aBgbZdVFCk9
 EXhLGTBr1yJ1knd0ZhvVW0IQCIYaYV3IZ6arzOuyEV7Cm15N5abGY76fWeU0sf1GZZll
 V0SA==
X-Gm-Message-State: AC+VfDzO4udbw99HIRicaLpg2l6ZVZ8X2PDAicbGc6gt7hyY/WYcZUHT
 Ke3PRehccgXVRv2iWo6r62c8KU21
X-Google-Smtp-Source: ACHHUZ5/gNlhVDqucdH2NUtkGlWuvPwfF/jeSlTt5oiG8nOmZvGE5Bnr6y7MZf7b0Mm0rplrNqONmE6q
X-Received: from flwu.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2200])
 (user=flwu job=sendgmr) by 2002:a81:b70c:0:b0:561:8e86:9818 with
 SMTP id
 v12-20020a81b70c000000b005618e869818mr3557834ywh.7.1685552140074; Wed, 31 May
 2023 09:55:40 -0700 (PDT)
Date: Wed, 31 May 2023 16:55:35 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230531165537.3721999-1-flwu@google.com>
Subject: [PATCH 0/2] Added 32 bits property for ASPEED GPIO with updated
 qtests. This change gives ASPEED GPIO similar behavior as Nuvoton.
From: Jingbo Wu <flwu@google.com>
To: clg@kaod.org, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Felix Wu <flwu@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3DHx3ZAQKCg0sy97t11tyr.p1z3rz7-qr8ry010t07.14t@flex--flwu.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Felix Wu <flwu@google.com>


Felix Wu (2):
  hw/gpio: Add property for ASPEED GPIO in 32 bits basis
  tests/qtest: Add qtest for for ASPEED GPIO gpio-set property

 hw/gpio/aspeed_gpio.c          |  56 ++++++++++++++++++
 include/qapi/qmp/qdict.h       |   1 +
 qobject/qdict.c                |  13 ++++
 tests/qtest/aspeed_gpio-test.c | 105 ++++++++++++++++++++++++++++++---
 4 files changed, 166 insertions(+), 9 deletions(-)

-- 
2.41.0.rc0.172.g3f132b7071-goog


