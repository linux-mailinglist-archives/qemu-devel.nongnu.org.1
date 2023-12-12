Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6246E80EA68
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 12:30:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD0yD-000662-At; Tue, 12 Dec 2023 06:30:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD0xz-00064S-S9
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 06:30:24 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD0xx-00045I-28
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 06:30:22 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-54c7744a93fso7785725a12.2
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 03:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702380619; x=1702985419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ueBqNhx6BK67IUq8z+0/fpvGM9Ts68nyh+e99PjXJLk=;
 b=lPIfvd1OjPdmrD3b8H3rTaR+xR/+OLERjeifhkd2nxV9EiGNYyosLWlSITgip8ZLtn
 uuj55M2EPexfFBmstmcUd5UP+X60VMMP3h0wCCcppd6+eCAg86uIqtUCir+WTtBhV+7A
 IPoHSniYXknqZyb9U/Cv+GaTZyL8YVA2SOtl3fOtuBoA8iyHAWLiZLpjJLSPDXZV9eKF
 7TCiEGduHUdCdqH6JPGA0OdRfiopPlv4u/i9VnUpaK4xlEJAI1eaMPrUe6AyGRUL7mMj
 csc36sJmiA3mqqq+Q9feHqC/dPkbb6IVyV2s28BFUkmIkesT6tEL/qMajgs2EmxpRcrO
 06Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702380619; x=1702985419;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ueBqNhx6BK67IUq8z+0/fpvGM9Ts68nyh+e99PjXJLk=;
 b=sl1nGuGkGj1VW4Tov+xzCxzyGBPI25afM8mp+CtYhEKL1ejjoBHl5fDvQ0tVIkDCGi
 y86EM8JGLi5nAMT/lAnpWk5ufp19/KpPwo/JfJ/fnMzkrU5BHHBRLlHT8Ant7jHp7m7Y
 iocx/HCw1Wt8x3xwwyTGgPzfJjV5UWjwnIZfz5Av7mrdLCgaIBpjNXn8alCI+p7HwZQ1
 o2PEFGjra2/aC10Deycey8iAXUmjFRSmjA3gweGLgqG39c7XBRGnJ4GujrCsyFSumwx7
 zvIM6sU3/2qhoZiAQmrfWGuz/kA6jRWeK/Ut6iXaQckq3tickAPCDMXb99OHNG8moABu
 Z0Ew==
X-Gm-Message-State: AOJu0YwlNMl1lWSTAN+21IyZz5fDfjJlkLn3Ole9eBIR71pCyLi1lkJN
 BK/a74cxmbutAcKzJvRMXqiEWN1Cz7LhDLNzxWSzcg==
X-Google-Smtp-Source: AGHT+IFpVa+jY5dHAWYQkZqbZQNGk2c0AM8pBfS5cYpjbTd03xzK6EvKo12dv0zn0g6X7a/pfiW2YQ==
X-Received: by 2002:a05:6402:222b:b0:54a:fe99:105c with SMTP id
 cr11-20020a056402222b00b0054afe99105cmr2783639edb.6.1702380619082; 
 Tue, 12 Dec 2023 03:30:19 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a50c2d2000000b0055147185e2fsm1488610edf.61.2023.12.12.03.30.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 03:30:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] system/qtest: Minor include cleanups
Date: Tue, 12 Dec 2023 12:30:14 +0100
Message-ID: <20231212113016.29808-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

Add missing header and restrict to sysemu.

Philippe Mathieu-Daudé (2):
  system/qtest: Include missing 'hw/core/cpu.h' header
  system/qtest: Restrict QTest API to system emulation

 include/sysemu/qtest.h | 2 ++
 system/qtest.c         | 1 +
 2 files changed, 3 insertions(+)

-- 
2.41.0


