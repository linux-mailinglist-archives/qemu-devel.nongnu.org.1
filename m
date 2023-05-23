Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB8B70D43E
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 08:45:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Lku-0001qZ-O9; Tue, 23 May 2023 02:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1Lko-0001kI-Lp
 for qemu-devel@nongnu.org; Tue, 23 May 2023 02:44:20 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1Lkm-0002dc-7g
 for qemu-devel@nongnu.org; Tue, 23 May 2023 02:44:17 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3f41d087a84so31182875e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 23:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684824251; x=1687416251;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0XNp5hrp6CbHsMtrvz7ehXxz7V7OaM9fJO5/hKVwTco=;
 b=uA7VltoIsTkrLbOFXNmZXI/2+0rQBRCLwmmYYdwFaKMcm0wlWg+3Iid/OFdfG+9dMi
 Oz66zQ0OZ0BEeoqkH98bU5BhHGjyfFTQoGi+8uJf86IIQTn9YhJSopeP0ULZ0+sJ//fI
 qkVEdeQfPvZoAqGaOuw5SCAY/e5er11PQAZvxZgIr7jbvh87MSyLmk86MBQPga+vA/T1
 R5u+2wD8piSDQh5H9jrotb73ieOOwWZmH9gTvxjGxI58OtTueFtiKKGMyKSsKWhiByfZ
 tg7hQR8Xw48xPHW3qtxO11L3Ueicj1Pl4yxJPmQABygAxnmeWb2fWHuBimu57z28famP
 xDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684824251; x=1687416251;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0XNp5hrp6CbHsMtrvz7ehXxz7V7OaM9fJO5/hKVwTco=;
 b=P4nrDYXsG8DSnfHvCynOKB08DdJbudZjHmnGkjb9T5tSg+OYrcj5YtWYFroyKwvGLP
 LTFuABCYwFaWrDzzd3NCzQvIaLQYEmwckZSIG0Ok8jMiGnNHUYDyrPG61Tg2ecl8iurm
 nWez7HfMvG14+QX5ki41eFhF22tuQfo5th0kS9ibTelEx7KVX3fGTqeuKGzLHAJeZM/g
 lj/o5AbO3ouIRsXAyPictH44Q21ljo6Y0QynVLIAymd4g1E5KDkj+Z5AVzB7Suzrcbvo
 xfkUysut6TetdO1p1MZQNRV3LGVBdg6P3XUAPm5HjWrExAqZumbPljvEBHDhe/MuSG73
 SRtw==
X-Gm-Message-State: AC+VfDwDSq+LSymUXYqwTU1Cups8E+DTp7/6j3qa1icTFj6vKKbL6Lp2
 M4uL6sAM8gr155NaeMjIECj3Ok34FlquJoZo5js=
X-Google-Smtp-Source: ACHHUZ7/6aCgBlwuvKzZkOgRPT9MStnc/irb8CMoIK6xsdn7e+rn0Gf7jvB5HNzVBwnfbuyakNqzdQ==
X-Received: by 2002:a7b:ca44:0:b0:3f4:e432:7589 with SMTP id
 m4-20020a7bca44000000b003f4e4327589mr9474496wml.10.1684824251599; 
 Mon, 22 May 2023 23:44:11 -0700 (PDT)
Received: from localhost.localdomain
 (vil69-h02-176-184-48-94.dsl.sta.abo.bbox.fr. [176.184.48.94])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a7bc7ce000000b003f4b6bcbd8bsm10578913wmk.31.2023.05.22.23.44.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 May 2023 23:44:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-ppc@nongnu.org,
 Titus Rwantare <titusr@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] hw: Fix abuse of QOM class internals modified by their
 instances
Date: Tue, 23 May 2023 08:44:05 +0200
Message-Id: <20230523064408.57941-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Bernhard warned for QOM class abuse here [*]:

> A realize method is supposed to modify a single instance only
> while we're modifying the behavior of whole classes here, i.e.
> will affect every instance of these classes. This goes against
> QOM design principles and will therefore be confusing for people
> who are familiar with QOM in particular and OOP in general.

This series fixes the cases I found while auditing.

[*] https://lore.kernel.org/qemu-devel/0DAAC63B-0C0F-44C4-B7EB-ACD6C9A36BF1@gmail.com/

Philippe Mathieu-Daudé (3):
  hw/mips/jazz: Fix modifying QOM class internal state from instance
  hw/ppc/e500plat: Fix modifying QOM class internal state from instance
  hw/i2c/pmbus_device: Fix modifying QOM class internals from instance

 hw/i2c/pmbus_device.c | 17 ++++++++++-------
 hw/mips/jazz.c        | 41 +++++++++++++++++++++++------------------
 hw/ppc/e500plat.c     | 25 +++++++++++--------------
 3 files changed, 44 insertions(+), 39 deletions(-)

-- 
2.38.1


