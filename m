Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B58DBA383E2
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Feb 2025 14:07:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk0pY-00025W-Jp; Mon, 17 Feb 2025 08:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tk0pR-00025B-L2
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:06:31 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tk0pP-0004hQ-EI
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:06:28 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2fa7465baceso8801562a91.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 05:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739797582; x=1740402382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LAiD6jNMlnvOxC6RFwTNse4mAN9kNlx9AjExQlpN6Gw=;
 b=vSfK3XXhI+VcOvF/mCqxDbPpB05uQ5Pe0jz2H3nYh24lus9MJLof0rWazn3Mk9WvzB
 9i8+4urzmPIHMfIxTszVzYMfx4cUfp8+gfS4nx7JH8GVb8zUykqdnrVJJR9nTl51VMA/
 ThOZgBuXx4KP+400RyyW2ZIEoLIhQIKX5qbcY/FwZdZ/GXDRKkWeJvL6y3rMFVU7MltZ
 zCe5PE2tgvp4Vi9RHDGhoXGqGxj879mEK+60T3QCg00jcrNWbc3oMTCxzgZ1kbGVWEGL
 2//jU/u6E8nUZizyQWhJnggW7Zbn2BcbkduJMYxds+yAW/QP+DSBOs3kmJ5kzukkgJHb
 ifRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739797582; x=1740402382;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LAiD6jNMlnvOxC6RFwTNse4mAN9kNlx9AjExQlpN6Gw=;
 b=n5+4vMf8hepKLoLWq11gB/Mi4A7xKmMq+DPX5zH6HCiITW7L2+zqOOL7qaj7QYyzB6
 A1F1PVHbg/QqWtPoBItVNrKcjec7VahfGvoM65QKM3TldCGfvfOrYm81uWNJ7ObZQZ3K
 DJrwIqtfHgJrmr4S+OcigpgbU20vK6UbkvbOmcqhLayPrbCUMqAThBtWD2gO6c5a4j7f
 zAEpy9lvL9RCdw6tu7BddzDpIrP+aUI9QBh84zgcDtqLSq2LBti4xmcLYdYqclapP+J0
 WIYHbABPBanqynU9qWdLr2SxQ/U5DJRmecfqDhPS2oqiUgFdEE3L7w9SbtmpMRr8+p3F
 TK3A==
X-Gm-Message-State: AOJu0Yxi0u5FPdQ3hmRiPy+2j2a4CZP6Y2d0u/aVQObuCj7SjgSfeAtR
 iCULDoRjUSj58GVq5N8odKyECBI7ep+qUCk/GFFHmzDFyDsUDRjbNQcy0NqIGVMh3vHLsfcLO1u
 4ljc=
X-Gm-Gg: ASbGncuXDKk9tJKkOcvD2INqYP5pcZnR94anYM6gltpKwBGW90fwvfQmwgtpYtnJ3uB
 zWAlTEkatucPqVknZa0R2UjkjHmOeKlCcYIppThQhCQy8D3JRDXgkLInHcU2lYBR3ne8jeYL11h
 C6DdHpxiNxy4PEyOXPdnJHT3A7pGJ9rf20ZLVV3zJpgQ7ze54O8pV0BmTgM/O1OxTr1RJe+DWED
 JVOW7Nm3mA9rwyP234dYAElc01sErMV3BKX5ewrQ1Y4CILfi01hzy5CGehgm+LhmRUnSdcT0Srm
 2sOTkkWojIXntB6GzppohqSEVEZzJVzXqh/dOM3ISAA=
X-Google-Smtp-Source: AGHT+IFqFZ2pYXJhjCyZv4x9ytBw5t4mNjH5Dhr40oA051q86mnKRcNsMpCZZEYTWfe9T/TqzmUL7g==
X-Received: by 2002:a17:90b:3812:b0:2f4:434d:c7ed with SMTP id
 98e67ed59e1d1-2fc40f1f83cmr17033499a91.16.1739797582624; 
 Mon, 17 Feb 2025 05:06:22 -0800 (PST)
Received: from localhost.localdomain ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf98cff80sm10031309a91.16.2025.02.17.05.06.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Feb 2025 05:06:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/5] accel/tcg: Clean cpu_memory_rw_debug() up
Date: Mon, 17 Feb 2025 14:06:05 +0100
Message-ID: <20250217130610.18313-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x1029.google.com
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

Address Richard' suggestions from [*], cleaning
cpu_memory_rw_debug() user implementation.

branch: https://gitlab.com/philmd/qemu/-/commits/user_cpu_memory_rw_debug

Based-on: <20250123234415.59850-14-philmd@linaro.org>
[*] https://lore.kernel.org/qemu-devel/20250123234415.59850-1-philmd@linaro.org/

Philippe Mathieu-Daudé (5):
  accel/accel-cpu-target.h: Include missing 'cpu.h' header
  accel/tcg: Include missing bswap headers in user-exec.c
  accel/tcg: Take mmap lock in the whole cpu_memory_rw_debug() function
  accel/tcg: Avoid using lock_user() in cpu_memory_rw_debug()
  accel/tcg: Move cpu_memory_rw_debug() user implementation to
    user-exec.c

 include/accel/accel-cpu-target.h |   3 +
 accel/tcg/user-exec.c            |  82 +++++++++++++++++++++++++
 cpu-target.c                     | 101 +------------------------------
 3 files changed, 87 insertions(+), 99 deletions(-)

-- 
2.47.1


