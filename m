Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB9680DD09
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 22:28:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCnil-0002Mc-3W; Mon, 11 Dec 2023 16:21:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCnii-0002IL-Ry
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:21:45 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCnif-0005cY-Sd
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:21:44 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a1e2f34467aso469890766b.2
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 13:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702329700; x=1702934500; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gRG2U+UvZdWTGYdcA/MTX3iesT+e4Kqtp08ALJBiHJ0=;
 b=ssb+pP/0t677mdQx2Yxxfknmk7znc8iJ0s27TcSFW8cJpHSsU0fQbZc6F+fCnlgRo3
 wa5ObS1EAqeH9qIFzu1XhdqIbcciS5BAUHsnqA432ScUYuFHjdHIy93b4HxU6i63EPdA
 f5ErJxN6Z0qfLujHn84mLIfWaXkeezwRd6rmooa9TMmTWffohcz2AWXohjEIyaiquOm2
 42g6xxG+m20c5UIrG9fRkvKWxjtyeurYyhHVEAvMci/LWYkibwslhTD0PBrCmY2Hg2N2
 EEeyHhG5jCTvwGWJupbAA7RkGdw9KkpaTAYBJeZnGz7IHdlTyDLyjyBZp1phIjqQUMKq
 szrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702329700; x=1702934500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gRG2U+UvZdWTGYdcA/MTX3iesT+e4Kqtp08ALJBiHJ0=;
 b=UTMoh1OazljoQNEUfxOZ/WYILA8QGqJqx60HxEy19zDo5jQJLVlWBMx6yrNzPXKmiz
 zsPAovLN5IwblPOoaaP39cQwWD1bBAyPGvJjoojxtVBTY7LK7asxTNc7zK48cs2RHu6U
 aYGuVnv9fffAn5sbxjYoclTFYAkSYrhy9JZbH8eQ9T2v64gqkfT4linozQJtAxR/1npx
 F6bfMf/6P+7RdLi1q0XlxCvmmzbSbNRign1ddh3slXc7OxS/kd+S/oLFckB+ADhU11/6
 fR9tHCTKskbjk6rx74rl0ijF5LxqZKumYSvr7enAI1BaCl/xoG64Cki0VXpstwEh7duw
 1d0w==
X-Gm-Message-State: AOJu0Ywt8qRzFmenN3BZEVKzZxcpIpIXBO7YbwFl6tw+FXE07JTLen8d
 CQbhkJn+qppf4NW+qAJo3If6NCzWWreE0sEhJp6cUA==
X-Google-Smtp-Source: AGHT+IEa3URetu7g5tfPDUGMgSUYvKg8IduDwrwb0TA8kvL1/wJJ22FrnJm8tGba/n12vArKa+29YQ==
X-Received: by 2002:a17:906:ecf1:b0:a19:4628:1606 with SMTP id
 qt17-20020a170906ecf100b00a1946281606mr2921924ejb.45.1702329700238; 
 Mon, 11 Dec 2023 13:21:40 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 jg2-20020a170907970200b00a1db9c0f55esm5287908ejc.198.2023.12.11.13.21.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Dec 2023 13:21:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-riscv@nongnu.org, David Hildenbrand <david@redhat.com>,
 Warner Losh <imp@bsdimp.com>, Claudio Fontana <cfontana@suse.de>,
 Brian Cain <bcain@quicinc.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH 11/24] hw/s390x/ipl: Remove unused 'exec/exec-all.h' included
 header
Date: Mon, 11 Dec 2023 22:19:48 +0100
Message-ID: <20231211212003.21686-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231211212003.21686-1-philmd@linaro.org>
References: <20231211212003.21686-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/s390x/ipl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 515dcf51b5..62182d81a0 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -35,7 +35,6 @@
 #include "qemu/cutils.h"
 #include "qemu/option.h"
 #include "standard-headers/linux/virtio_ids.h"
-#include "exec/exec-all.h"
 
 #define KERN_IMAGE_START                0x010000UL
 #define LINUX_MAGIC_ADDR                0x010008UL
-- 
2.41.0


