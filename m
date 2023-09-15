Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 399627A2376
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:21:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhBYq-0005Vq-L3; Fri, 15 Sep 2023 12:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhBYo-0005Us-2K
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:20:50 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhBYm-0000Vd-Iz
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:20:49 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-52fe27898e9so2688236a12.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 09:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694794845; x=1695399645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6temGotEx2ub12Rc+wYsnVX/4TWqLZ5ZPmR47kI0Rw0=;
 b=iO5KypNtljoemqGRj2xNtyhVDj8pCs+xHGfwp9fFrLxCAvPv6rJv9R56rqylonxgSO
 Ixg78GsMDgaX+zco6GHNamW5tYZNFa6d+waJXDqzzbv+j+E044gYdc1vlGKWmBcJW/65
 hYlZ1iUCx9Kl1NXya7cqve6yU+yKBWaGfjzHn0kk77+rxP6I7nZoOUxEYXvofi00ikma
 LBmVAZSBBUOTUeGDUyDPZmcdpt/PwpjkLBMJUimV9KoYdH9u2K6b/DCgI9Pwbc8n7IDg
 OU5/aYbjS5ctGKIlr8fDs+KI3NBygrxavYzpGP11XgJAy0zLbenv6WLyqFM4mst/rYHA
 ZVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694794845; x=1695399645;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6temGotEx2ub12Rc+wYsnVX/4TWqLZ5ZPmR47kI0Rw0=;
 b=AJfJg9s0XEM3FJ4SnyDi3U5ACBwEJRfy0j97pEpjdPZIRJXy218GiVibh9TVKlS6Gl
 MayHVaRcgK70jVsiQfYJY5S6UdvKDbIGEALYcSgVNVwmXe+nb/9kfvB8ciBiOGRJK890
 tjr4PEA6upsKp5x5dqHHs77uN7iJpaA6Bbj2idmd4JyncHlVDAOCaF0fi5Qo2Gpe2xbf
 yqwwp9t47ipp6mJdKhAc+c6mIrzO/RDNB7sDyj3Bd0lrAHnDgLedAB9eHPwhAUlfeoC0
 TUbnZuqg+6v50Zu8osqHxNhNiUos/5bLciQU/wifyv9wEbyoKwfPC5xas6ZVCsXQxhsm
 Xmdw==
X-Gm-Message-State: AOJu0YyTlZqGtjFgw6X0XvynNtIe60SAA3RfJHzj4whSxoPfkZLjhfBn
 8ES9ysojhtipEUtQ55D59cc3C4haasDCPrwF7VM=
X-Google-Smtp-Source: AGHT+IF05d89cdTJD42+6eoS6UvcJBbAEid7O3cvngyFUNSlHU6884B9pfbpbOfOkvHCXUbR4QICWw==
X-Received: by 2002:a50:fa85:0:b0:529:fa63:ef7d with SMTP id
 w5-20020a50fa85000000b00529fa63ef7dmr2118320edr.7.1694794845703; 
 Fri, 15 Sep 2023 09:20:45 -0700 (PDT)
Received: from m1x-phil.lan (6lp61-h01-176-171-209-234.dsl.sta.abo.bbox.fr.
 [176.171.209.234]) by smtp.gmail.com with ESMTPSA id
 bm10-20020a0564020b0a00b005236410a16bsm2478385edb.35.2023.09.15.09.20.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 Sep 2023 09:20:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] hw/intc/apic: QOM cleanup
Date: Fri, 15 Sep 2023 18:20:40 +0200
Message-ID: <20230915162042.55890-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

Minor cleanup extracted from a bigger series
touching x86_cpu_realizefn().

Philippe Mathieu-Daudé (2):
  target/i386: Only realize existing APIC device
  hw/intc/apic: Pass CPU using QOM link property

 hw/intc/apic_common.c    |  2 ++
 target/i386/cpu-sysemu.c | 20 +++++++++-----------
 target/i386/cpu.c        |  8 +++++---
 3 files changed, 16 insertions(+), 14 deletions(-)

-- 
2.41.0


