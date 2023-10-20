Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0FB7D0FEF
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 14:53:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtozN-0002GP-TL; Fri, 20 Oct 2023 08:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtozL-00027J-DA
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 08:52:27 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtozB-0001HA-CE
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 08:52:27 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40651a726acso6437215e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 05:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697806335; x=1698411135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ah3WKGt0I4J6MGqXZ6iDMJbohTp8VA+zrxGknDCvKfI=;
 b=NR+bPCCMYWTwF9Vok8laxpRi+UdJ0vcRZt4iHkPvlP+d8ywlKJ9M6zXXT1IBQ7h3km
 g/3vXU1jstxs2nWHYAOU9JBDZhgIdEGnQ9IJzrXBo4zkop/kd8PTJ7/oUsz+Hslo057r
 QzrIkfrFwHsf8JuopEgu0pP2W825kqhb3rm6SFQFr6Q0LWgnSDpxEFhvJiZEmJ0VnDgS
 oKJ4DWeG+Xb5sgnH39wxJ+AJhGDKj/RYISdoNTXIvkoY3NgBsObFniroJHHv/SDN4zUP
 DXnjLnyRcrl5fVrlW3Er4Evg1wDIREZgR5LPuOikyZbAryO5XPI2MNKj5dPhoX3pAkUR
 Kn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697806335; x=1698411135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ah3WKGt0I4J6MGqXZ6iDMJbohTp8VA+zrxGknDCvKfI=;
 b=gAfwSVxadFAxS/QX4+Qt4e00TPmwT77zsmKOUo0gi5YhIE5DJSxw5/H9bMgmp/tPUK
 8dOIPoVFVBMJWQC/XjmIrPhA4rT8Sb9QWBuZz+VCdk2VfPm0Nkay9r/htwdtbNy+CwD3
 i4xyOWZzD0RAai28EauXK3gQpmVxLFVI355sjtd8iaoBZYv/dVj4DlAREFmGRO7qjXUm
 wPbipFPsw4kzMnAUlX9bMsZ8tzfL31mHYHKjRIyLo7d1Hm8CCFzv0m61fO1jIsCIj6Zp
 SOJPrVF5vUP/KBDvqZEqPS89imtW8TeEASHn2BZaI742+lbOHTmAzOAJhIiuBxNysMSk
 ccBg==
X-Gm-Message-State: AOJu0YzusXHWPDKVO9WGGw8zH0cVAe5uPuRs7T3SxfGA/scLCm2EIOfA
 fJiyoE7yNZqi6LqfQ30drTrmLw==
X-Google-Smtp-Source: AGHT+IEHl71cH1GU9IOkQc7yNPBS7Yyp8siOOlpWrUqdWayjEHo78cEF+nKYng3wp1O8lnxVo5NPPA==
X-Received: by 2002:a05:600c:1c1c:b0:408:3c8a:65ec with SMTP id
 j28-20020a05600c1c1c00b004083c8a65ecmr1408636wms.8.1697806335266; 
 Fri, 20 Oct 2023 05:52:15 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 r6-20020a05600c458600b00406443c8b4fsm6989056wmo.19.2023.10.20.05.52.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 05:52:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: 
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PULL v2 06/46] MAINTAINERS: Extend entry to cover
 util/qemu-timer-common.c, too
Date: Fri, 20 Oct 2023 14:51:48 +0200
Message-ID: <20231020125201.49361-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020125201.49361-1-philmd@linaro.org>
References: <20231020125201.49361-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

We already cover util/qemu-timer.c in MAINTAINERS - change this entry
to util/qemu-timer*.c so that it covers util/qemu-timer-common.c, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231020062142.525405-1-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe11c98669..1b2c5b9e76 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2937,7 +2937,7 @@ F: include/qemu/main-loop.h
 F: include/sysemu/runstate.h
 F: include/sysemu/runstate-action.h
 F: util/main-loop.c
-F: util/qemu-timer.c
+F: util/qemu-timer*.c
 F: system/vl.c
 F: system/main.c
 F: system/cpus.c
-- 
2.41.0


