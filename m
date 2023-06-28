Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AFC7415EE
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 18:00:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEXWs-00030J-NO; Wed, 28 Jun 2023 11:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXVm-0002Vt-Kk
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:55:21 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXVk-0001hz-O4
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:55:18 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2b6a1fe5845so55379871fa.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 08:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687967715; x=1690559715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Z7hmSf7F5zCyqJWN1ZSSRjKzW8IULQcgC+39wDtspA=;
 b=HwCVEdLiBB20/nQnpNyCHsJT/cv4dG6G2fut64R1esGlbLRx8k3fHu6SRvYbMKyjZH
 J5kGI/EMPL2FdNTa3OnCxsYfU4S7XQsIdiNEhvvZRHOWuQ7qjL4ZqovI2VD4lsncwLcL
 DcgmDEdHVmc31k0W8FhTFkXoCJEZv6bB1FFSV8oUD5BkuuAkHoxSBPm45PKKefxAXPYM
 9W29FoY1n3qhKABimjDgijoL8P9l5Idi8fYdAqH9SzQ9MD49xQpsCsVRP4nnziJYEikc
 mH3vQDoqFJZwJxLYRZl9BJ4IE2Ks1kXQKdGHo/MxfY4NdOCJldfMoeMUYFHicH2cTEeI
 pQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687967715; x=1690559715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Z7hmSf7F5zCyqJWN1ZSSRjKzW8IULQcgC+39wDtspA=;
 b=TmxK5SFjVbckhT8JRflLPZqAdCS5Re+qF+yhPOtJ8onwOLRYc0kqfERpf1oVHgDQch
 5FWverYSzWfWhDXC7nRexL10CTGugWWsVkic5VVwIEvlObJy03nBflyr0PEwGLv4Nhvx
 7uNisqT+4Biiu/zY9KqRacakejHGgQg60b0xoMqN8wzWkX4kIM+nRj8w4X3/DNTvq/2I
 k7I3KPknxJGkzRCAwYFrDyzl9UkviqNpTCUl5jX1i4SOujxgk+RSz6VOKc5c1pQRR+Ml
 T/XBX3AdFOoLybJ5JCIj+SkoIXpZwb0w0NysGYDJLVESjdySqbNQa7RgkpF836zuzUmm
 TUYw==
X-Gm-Message-State: AC+VfDw9obtxM8iOExEBO14+j/kFND2GxQSj3qNGWZ2NcOu5+tafiq7k
 UcJH6XOezUC2eyv6pXD0NLij516idFionJhhrxE=
X-Google-Smtp-Source: ACHHUZ4FYQf9ndVmCp3iz42fwJm07amde2WgB4kbUGAuz15og0ntT/XrgBnSkndJBZkRXZBMGWBfGA==
X-Received: by 2002:a05:6512:4014:b0:4fb:8c52:611 with SMTP id
 br20-20020a056512401400b004fb8c520611mr2820414lfb.38.1687967714959; 
 Wed, 28 Jun 2023 08:55:14 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 j14-20020adfff8e000000b003112dbc3257sm13438198wrr.90.2023.06.28.08.55.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Jun 2023 08:55:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 20/30] accel/kvm: Declare kvm_direct_msi_allowed in stubs
Date: Wed, 28 Jun 2023 17:53:03 +0200
Message-Id: <20230628155313.71594-21-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230628155313.71594-1-philmd@linaro.org>
References: <20230628155313.71594-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22c.google.com
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

Avoid when calling kvm_direct_msi_enabled() from
arm_gicv3_its_common.c the next commit:

  Undefined symbols for architecture arm64:
    "_kvm_direct_msi_allowed", referenced from:
        _its_class_name in hw_intc_arm_gicv3_its_common.c.o
  ld: symbol(s) not found for architecture arm64

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230405160454.97436-3-philmd@linaro.org>
---
 accel/stubs/kvm-stub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 5d2dd8f351..235dc661bc 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -27,6 +27,7 @@ bool kvm_allowed;
 bool kvm_readonly_mem_allowed;
 bool kvm_ioeventfd_any_length_allowed;
 bool kvm_msi_use_devid;
+bool kvm_direct_msi_allowed;
 
 void kvm_flush_coalesced_mmio_buffer(void)
 {
-- 
2.38.1


