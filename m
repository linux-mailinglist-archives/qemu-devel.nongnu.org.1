Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8216808563
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 11:28:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBBaq-0004fp-0x; Thu, 07 Dec 2023 05:26:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBBag-0004dq-7u
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 05:26:47 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBBaX-0001XS-CI
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 05:26:38 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40c236624edso8303435e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 02:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701944794; x=1702549594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2xefmX366fbhfJxsIeFGi91XZmITR9sN6ULSxx36cJM=;
 b=f0i/Ku2loLm3GQSqMEOgFPpaihki9649Qg77gV0rs6i4Uv7mpJhN/IeQFTlx+XoetO
 NzZ76shA0CYdfA64ElSj4Ob/oIM0s3Jmo8MMEfjaq6EqiapEz7c3baqAPI0xKMQyjwkO
 o0jb81S09defIA778jR5vRcWNsd6Qsav75+HMZgYzKfl24JyQrSUghaeKscRI0wjV9vb
 VAe14/LkbxJuv3ICA/iaRwmLeFqmh4Y+FHg+8f4htMrvQZq+lcVrb9YjXboZxe/R4DEL
 FTpSPqX1SLowoVzJ8O+SCMraG9lLokHqsg3RJdh+IScS6qruu4ZNFt6HP69UE/nl9rjO
 9OWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701944794; x=1702549594;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2xefmX366fbhfJxsIeFGi91XZmITR9sN6ULSxx36cJM=;
 b=qfq1j40muLYXQG2nb/xEhIV4wHCsLFUDHE2SUUX9YAQdVWzZB43M844qYmty4SamQ9
 XXNbZsJK+cePDwaRzo9npW3l9HYMO5Fq5gYdOAXTmhWFd0LrlVD+LPf4YZXBCKlmWkCH
 8HIh0o4/3T3dJpZd8A9ixemgoSXYJHeA9G+CEfNBrXChO3kvRGWW0ofvsPn/ZLML+1Ei
 VAa+8QiLEYwSEWUUsZr6Y653QcrHfQUSUSu2VfTe59v6aEByeJSxjbn4Cry6F4sgOTC/
 Jq6lGWyyLwAo+Iy2KNq95Z2bT6f52Qi+G6JnhjhvFERLZrvOu6L8X9aANFsLYb/9Iymr
 wqmg==
X-Gm-Message-State: AOJu0Ywq7jxWszhi846rUAMOMVa1xkLGfw+clx28YpAebpKLKoJxO1G7
 /tAyP0jqbJ4oJYyACFeEd+VzE1EsWtNTrxzaLlY=
X-Google-Smtp-Source: AGHT+IH8Rq6Tb0mlVLhKeozUEcWLchIwWQG3Va34wcbBEPgyrZXm/kwtAXv5ndUn3wedm/1Qz60Bmg==
X-Received: by 2002:a05:600c:5199:b0:40c:2395:1fa7 with SMTP id
 fa25-20020a05600c519900b0040c23951fa7mr1093806wmb.141.1701944794513; 
 Thu, 07 Dec 2023 02:26:34 -0800 (PST)
Received: from m1x-phil.lan ([176.187.202.111])
 by smtp.gmail.com with ESMTPSA id
 h11-20020a05600c350b00b0040b4cb14d40sm1489520wmq.19.2023.12.07.02.26.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 07 Dec 2023 02:26:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] sysemu/replay: Restrict icount to TCG system emulation
Date: Thu,  7 Dec 2023 11:26:28 +0100
Message-ID: <20231207102632.33634-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Slightly simplify non-TCG and user emulation code.

Philippe Mathieu-Daudé (3):
  util/async: Only call icount_notify_exit() if icount is enabled
  sysemu/replay: Restrict icount to TCG emulation
  sysemu/replay: Restrict icount to system emulation

 include/sysemu/cpu-timers.h |  2 +-
 include/sysemu/replay.h     | 11 ++++++++---
 stubs/icount.c              | 27 +--------------------------
 system/vl.c                 |  6 +++++-
 util/async.c                | 16 +++++++++-------
 5 files changed, 24 insertions(+), 38 deletions(-)

-- 
2.41.0


