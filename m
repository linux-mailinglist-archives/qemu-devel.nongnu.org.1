Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B07A743923
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 12:14:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFB41-0005iS-V9; Fri, 30 Jun 2023 06:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qFB3y-0005Z6-BT
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 06:09:14 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qFB3v-0000rH-44
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 06:09:14 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-1b01b43577fso1461076fac.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 03:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1688119750; x=1690711750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QSNMKSaNrKe/mydianYvoIyVObUlklQTJwLyvz70obg=;
 b=bSajgJ+fC7k/FH5QuQtWUpv6X6nVVUCKeOjTi+P9mQiQScL65NanjdSQMW9fTr457T
 CDXD+er6pBnxeOla361cUlrBY1maFj/qAbW21TNbn3ePC1iOPramBXI1OAe73MsbgKGt
 VUEM06FLAAcR3rWvB0r81mecSgrX+qb7FxJRXJpKoPTqNEcwGw+2aT7l9dGQzSf1fIZC
 tb3CtfBfwspdUMkVEXppZwR5Tg5SIo4tZOl0A/UM8QoxPwm4TQonKXvujQS0EWuLfeuk
 1XlyU8uB/NLJvj/69xi5Bqjht1jOpzENQP5lQJz3UtmTUrXvop2bq3Q1MVnnm1zyjdZ2
 EXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688119750; x=1690711750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QSNMKSaNrKe/mydianYvoIyVObUlklQTJwLyvz70obg=;
 b=lYYmkCqIwS7HdJweL/vKa59ct9henlB+ZJJG0uyApNcyUgDJGqcWOxUe8bf/lfid2K
 Ti440FrLo+PGHPZP85awHV+YEndl9Edzj8JKgyRHnQqr1iahsubCwlIo7s/FlRu+WEVw
 aKfy3ptuI1DAnsoOJYzGMC3X8jnqShVAygUoHV8ujMDzDuJqtGU/WZkRB/Zc3xlzpJac
 fqwQ6XYMS1hnZIc1AJ9On9FMPhXqmFI8PagWHtocDwkbTZoahfM59nznbRm41bguOsNm
 RHFhpVOJ3+4d8QnnDVdewEkurFd69lqcmsHRH+vlF28zsEilvhFUIps2hOO9iGWhcXM5
 2IlQ==
X-Gm-Message-State: AC+VfDx53zucSw5ScyPO3GXGJnYJ09vyGXpSzwUgyzxwtsHZiQuHDzO+
 8TmAfU8eBIjhmIFqs+MCYtCH1ujk3cw2J1mqiJw=
X-Google-Smtp-Source: APBJJlGiAotiVbaORV0IXzTvm1TC/sCA2wGiDzd/vGWNSuoNcq86PbSH4UOaEwIcQiDbXETisxnkQA==
X-Received: by 2002:a05:6870:b14c:b0:1b0:1c08:857f with SMTP id
 a12-20020a056870b14c00b001b01c08857fmr2888921oal.49.1688119749793; 
 Fri, 30 Jun 2023 03:09:09 -0700 (PDT)
Received: from grind.. (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 eh18-20020a056870f59200b001a663e49523sm8707467oab.36.2023.06.30.03.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 03:09:09 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v7 15/20] target/riscv/cpu.c: add satp_mode properties earlier
Date: Fri, 30 Jun 2023 07:08:06 -0300
Message-ID: <20230630100811.287315-16-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630100811.287315-1-dbarboza@ventanamicro.com>
References: <20230630100811.287315-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x2b.google.com
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

riscv_cpu_add_user_properties() ended up with an excess of "#ifndef
CONFIG_USER_ONLY" blocks after changes that added KVM properties
handling.

KVM specific properties are required to be created earlier than their
TCG counterparts, but the remaining props can be created at any order.
Move riscv_add_satp_mode_properties() to the start of the function,
inside the !CONFIG_USER_ONLY block already present there, to remove the
last ifndef block.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/cpu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f348424170..db718eff65 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1770,6 +1770,8 @@ static void riscv_cpu_add_user_properties(Object *obj)
     DeviceState *dev = DEVICE(obj);
 
 #ifndef CONFIG_USER_ONLY
+    riscv_add_satp_mode_properties(obj);
+
     if (kvm_enabled()) {
         kvm_riscv_init_user_properties(obj);
     }
@@ -1788,10 +1790,6 @@ static void riscv_cpu_add_user_properties(Object *obj)
 #endif
         qdev_property_add_static(dev, prop);
     }
-
-#ifndef CONFIG_USER_ONLY
-    riscv_add_satp_mode_properties(obj);
-#endif
 }
 
 static Property riscv_cpu_properties[] = {
-- 
2.41.0


