Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1934380DD07
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 22:27:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCniN-000181-A7; Mon, 11 Dec 2023 16:21:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCni4-00016v-3D
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:21:04 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCni2-0005Mj-IL
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:21:03 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-54d048550dfso7094817a12.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 13:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702329660; x=1702934460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y/4S5uEaEhG14FzKfAgbneY+HkdmgvAL2IyWQ5CT/QM=;
 b=wWmbQxsTpCdJ60UZ4xHnUB324CE9Ukdrqv54znYeb3dIs7aRkmeDsodmHnSINtNZhA
 kbhHbVNDXgUpFmrpjPQ8VT1PMhr2yp4dDxvEzHVv5sd2/xDBjyhKLgMYRLTKYWzBCaU9
 trRM1IqAlhkSUiCIPEaFObY+nosuwCcuohLqTNweexxxcg0BAql37GLuqnmQFH8BSRL/
 08iQUkYiLb6rC1yTDamii43FzU8tvrTw85I2kM6DH+MTcH/Gu6O+761ZrZvsBNJYzb89
 BZ/iKQbmJji3SA1R967TZwZDrLSensLvZDC0+UTW0oDOY03JZmRStFgicsFCR/DjBX12
 WOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702329660; x=1702934460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y/4S5uEaEhG14FzKfAgbneY+HkdmgvAL2IyWQ5CT/QM=;
 b=jYZ5oNDhtGbVQynW/R/T9b3oCuPXF6E49epPwMXdMePgKEbdqcDYiLp2JR+0Izg1Ar
 jX62wnACKOPmFUC6pzC2KHJgcye4P9ppb8gZVkiIovQ+eO69N3LrAXMChSVLWhwPWg+l
 bIG7DMHK95SdikEBYCNxUxkcMMUbQknQNyNfEz4jfLeY3brDo7CrP+yLEr9qrkN05noJ
 1UJ8tq4gabDy3zA/V7xgRYpCFI6BXAD/pNf3tIvXvqBfcGuymHJrFJfliCbaBTtH1lhY
 AXxaUzzDCPlglthyBQfbENiKSyaiOTAPTOKOlVWVxKZGFgimnxJwekT0ly/ljDDegKfh
 oQgw==
X-Gm-Message-State: AOJu0Ywi+WIR+/iSsz2XApyk7d1krzRMZljrZu8oLW12DOJteLyRL94I
 n6cwIQE8uQjqY2BwFX0RUwNiQSr5fwtOt3KZ/AW20Q==
X-Google-Smtp-Source: AGHT+IG2Vm9+9nZozqmpyx0to/UIe7Qixe2bQihK4D/rfYN6NuV3VFVlogSlogUpRJvEdJfYdlLdmQ==
X-Received: by 2002:a17:907:7f94:b0:9e5:ee70:5da1 with SMTP id
 qk20-20020a1709077f9400b009e5ee705da1mr1827163ejc.53.1702329660720; 
 Mon, 11 Dec 2023 13:21:00 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 rf20-20020a1709076a1400b00a1d1b8a088esm5331871ejc.92.2023.12.11.13.20.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Dec 2023 13:21:00 -0800 (PST)
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 06/24] semihosting/guestfd: Remove unused
 'semihosting/uaccess.h' header
Date: Mon, 11 Dec 2023 22:19:43 +0100
Message-ID: <20231211212003.21686-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231211212003.21686-1-philmd@linaro.org>
References: <20231211212003.21686-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

Nothing in guestfd.c requires "semihosting/uaccess.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 semihosting/guestfd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/semihosting/guestfd.c b/semihosting/guestfd.c
index 955c2efbd0..fd7e609790 100644
--- a/semihosting/guestfd.c
+++ b/semihosting/guestfd.c
@@ -15,7 +15,6 @@
 #ifdef CONFIG_USER_ONLY
 #include "qemu.h"
 #else
-#include "semihosting/uaccess.h"
 #include CONFIG_DEVICES
 #endif
 
-- 
2.41.0


