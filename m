Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 546717D0408
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:29:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaPs-0004yq-Cm; Thu, 19 Oct 2023 17:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaPo-0004v5-2n
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:18:48 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaPl-0004W6-HK
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:18:47 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3296b49c546so97957f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697750324; x=1698355124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kiEw9YpCoXl5uwZnYD6Z6QL4RjcbavrFkOGyAF3Ak2A=;
 b=TSSkRj/b5FdRwYnmfAj+2T+70VEgqQ48MGSrRDOdcXeZ0fSVzb6EeGQJ43whoNXJIH
 vPvVg8+bXHnr0mkAWQVZM00Qk3F5yYtrNtQOhUKsI12bqISDEiWZDVt2xBnYj5JCcklJ
 rx+lJH7gxhZqekM5xh0kXeBsR1ceIXJMmFXZTrvnGbNpUu4vkEUOR03Zoxo9qbYOEI/F
 ct7Dz0ren0XiekVxRIGjtMsGP6LAsmI8ryRL5FYCjfZMxYqHwileQ+FgACf2Vxm7a8rF
 9qRvuPG26Rv0uZlVHXSDno+lOSjhqMh4vejx9bweX0k8vxQfVkMOB+13OpNRocWIQILN
 Sl6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697750324; x=1698355124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kiEw9YpCoXl5uwZnYD6Z6QL4RjcbavrFkOGyAF3Ak2A=;
 b=tpCN24lvwkZEDe4GDho5BUsoArC6rwYeQAkJ9hys6w1x5g9QP4e92g6OMVzlQrGrIo
 P1Bs64aN4ZCLgPtn2ZD/ix+UuQo3tUoLSvrEda/E5nPRQhsqZXtB0LdBFHwNDRQkPOhO
 KPAdnIzCVjnA0UNnBSYXZwGvmwdL9PWosKCGG3hRaJBqK94DdBXsFpWylrs5ov0DuyK4
 tiNVWWuhDSb/wmh8IJN6X1AHcAKqTr5qLC5OL7C11OhU6b/jqyqKA3cfzi2myTCeS1yu
 iIgzZC4/RcbDDRaVBvitJEYMMuw0K5UUIhn9A92m/DopGgsMCM5r5RrjNtvyAbiKA76X
 9O0A==
X-Gm-Message-State: AOJu0YzTJUUVbjHDt+xheNbt380Jhmf7XjmkIZeQHhyjnuUGpSzPvXy4
 aCOcx3U5yVDYWzd26n+tQhWtCynEgqThCwOOrvaL/g==
X-Google-Smtp-Source: AGHT+IEgFUHRyV9z8ITqbBgPBCaLiMxjMDcpKV0JS1zIs+kqsSW/Y8BtxwpEsR1JFhzjoJUyb+GUaA==
X-Received: by 2002:adf:ee49:0:b0:32d:bc7d:c431 with SMTP id
 w9-20020adfee49000000b0032dbc7dc431mr2176023wro.1.1697750324033; 
 Thu, 19 Oct 2023 14:18:44 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 f1-20020adff8c1000000b0032da75af3easm212753wrq.80.2023.10.19.14.18.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 14:18:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Subject: [PULL 04/46] MAINTAINERS: Add include/hw/intc/loongson_liointc.h to
 the Loongson-3 virt section
Date: Thu, 19 Oct 2023 23:17:29 +0200
Message-ID: <20231019211814.30576-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019211814.30576-1-philmd@linaro.org>
References: <20231019211814.30576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

The corresponding .c file is already listed here, so we should
mention the header here, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20231017153345.233807-1-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 29b350f819..91ca93328a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1336,6 +1336,7 @@ F: hw/intc/loongson_liointc.c
 F: hw/mips/loongson3_bootp.c
 F: hw/mips/loongson3_bootp.h
 F: hw/mips/loongson3_virt.c
+F: include/hw/intc/loongson_liointc.h
 F: tests/avocado/machine_mips_loongson3v.py
 
 Boston
-- 
2.41.0


