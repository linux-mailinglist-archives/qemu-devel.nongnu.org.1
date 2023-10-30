Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A151B7DBBF9
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 15:41:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxTRO-0001Ql-IH; Mon, 30 Oct 2023 10:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxTRM-0001Q3-2J
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:40:28 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxTRI-0001rj-0o
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:40:27 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-32dd70c5401so2899795f8f.0
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 07:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698676822; x=1699281622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WuUDSxKsXjW5GqbYcOSHq6FGSIjG2WuDJO98unbaNSY=;
 b=ECN+3hdzxG0XZXghgcaW6l+ubgl6vF4/juo3MD1UEoMrlrSoqe1arnPilvG6CCabV9
 JCR92tIEr5TWXjlH9aYioNF1CuhP+DYOhAZRrAkxN2JXd7rxFtSP1UJObqYXeSO3TjI0
 s8/Etkl+CvsWIw7R6gIF3fE3ex6q+FxB/xy/pU0H1H9m7iYNS0kbp8CyfTv9kKG13JqX
 K5RCMprtDe60XZ3S1Go1I4dHZEUkC4BX9hlEEL/o30q4UU1So/qZhN3ekOirHlLCJZiy
 Pg0R6BBNRpdzCUiu5f1q/HxIRZLf50NszuN09botlR4ZFB4w2nS5RllIMGWqjBBl9VUd
 6x5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698676822; x=1699281622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WuUDSxKsXjW5GqbYcOSHq6FGSIjG2WuDJO98unbaNSY=;
 b=wewVve0pOa/PD8qmi71CJqN1oy4PninIOdx388Hoxbv0yhVyOksRBVlYEk3d6iHSaX
 xgMUSTaVz7I5UUKyBRpExFeIdaxvn9OZodDblFriY5Pme6pgos9QtaO3QGZxS6VVvxpQ
 QQA2aP87dLH1Klgb3iY5SPqRGA/J7Bilrg5m/kMM5Xyn9fYDwaqcOmThIubfrfxeQFdp
 Omi7PmJ5udQSa9Mbb0zM9Zvz/yA9gDYq+BVeYcOlS+MDjbgM/jVdfqyjJh8ZEtnci13o
 K+JVAAqtR88qsZjOwf9GZ2Q149Iyz9PGOwgLX5G8AsPCLFEZT8OdWQ2UmY3TIjyTgxEJ
 W7uA==
X-Gm-Message-State: AOJu0Yyi5D/HxPur37vZd5S4+v1OZtkVK49XBmUvp+6j6b89x5zOSUDa
 hyEH/3mRfrIRlrYKOMxmKm2dG2zo9VcJtiL8DUY=
X-Google-Smtp-Source: AGHT+IH8uNdiGnD6SclQ4UDCtGupHzAS3OCWKZ9YgQ6aDLexQHapei0d+FkCiYahJ1M/KNQybJMltg==
X-Received: by 2002:adf:f948:0:b0:32d:a243:a30e with SMTP id
 q8-20020adff948000000b0032da243a30emr6832983wrr.1.1698676822383; 
 Mon, 30 Oct 2023 07:40:22 -0700 (PDT)
Received: from m1x-phil.lan ([176.170.212.50])
 by smtp.gmail.com with ESMTPSA id
 j8-20020a5d4528000000b0032f7c563ffasm5790158wra.36.2023.10.30.07.40.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Oct 2023 07:40:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: Luc Michel <luc.michel@amd.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Bernhard Beschow <shentey@gmail.com>, qemu-ppc@nongnu.org,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/5] hw/ppc/e500: QOM-attach CPUs to the machine container
Date: Mon, 30 Oct 2023 15:39:54 +0100
Message-ID: <20231030143957.82988-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231030143957.82988-1-philmd@linaro.org>
References: <20231030143957.82988-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Instead of having CPUs dangling in the /unattached/device
bucket, attach them to the machine container.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/e500.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index e04114fb3c..f8177c0280 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -946,6 +946,7 @@ void ppce500_init(MachineState *machine)
             exit(1);
         }
 
+        object_property_add_child(OBJECT(machine), "cpu[*]", OBJECT(cs));
         /*
          * Secondary CPU starts in halted state for now. Needs to change
          * when implementing non-kernel boot.
-- 
2.41.0


