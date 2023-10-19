Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF257D039A
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:18:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaPa-0004kB-PO; Thu, 19 Oct 2023 17:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaPW-0004h8-3Z
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:18:30 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaPT-0004BP-A2
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:18:29 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32d9b507b00so109770f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697750304; x=1698355104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hia+i/K2YtabkAu41NP8XCQvgUNbgGky8+wqX7wYf4o=;
 b=Dn/xnAo0m+dMi0Fuxx/hk2Y3zz1X9zHDk5XgUTTwUFe8uZ98GqwKjrXPuzAAzaMDjk
 kixxp6jdGuOnsH4R26sg75aBZ5cXGhcE1m4iIcm19IN8s1biMaVWcy+4zuoBqXt03LZY
 Fgri9K4AcfftAleLATtayUPr72cUiR6eyYZrI0lV8IA/HbOt2ielWUENuRK8C+0uTaEF
 7pGDYlDHH/sQ+lmGOrOwFAZOIQIE+hB9jX9gKeAIjz9fcSoquO3z/S9sNXB+repl7q8b
 sknCp2t+/PQ/3mGElzdx2TzGLnGByaXVeZ5A6oUZ0IbCQKRQmLYH3gJ2IhZxiQzDud+7
 jQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697750304; x=1698355104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hia+i/K2YtabkAu41NP8XCQvgUNbgGky8+wqX7wYf4o=;
 b=LrBdfg4z3osvhlEfLnl1Vg51e5MySc/tkv7Up2LWY8TiZ8Xifz9K9vbJHC9BVHbIwr
 kEWIpGsv83OqyqMKhJA+kx7roonuhNiMPMYBX6TXRYXVTk7k14zcR2BlDX/kusVXQP5W
 8VhFF5X1CcnyX/fej9lNmZ31A/QSMr7FlljNG/Kuo9po4knRye2er340UQRX5ASnpfPP
 XF32cKz/pEJTOjpp2kqOg2LoQSZUrB/naZyAfowPG+uxv6RfxmU5vg78o77qeSJOrNTG
 Z0JtZGbECtBPCgE5EmL4tCjoT9Y7Moag4NBISr5GNRIehpV1+Rgz89cm1Eet9yW8lv8S
 UqWg==
X-Gm-Message-State: AOJu0YzW9gbSPuLdddFvvqrOz3Eq8VhV52v7UmbkQXW1cA+axnercRnX
 aXXOEujzRSJ2Jk6PUY3yh4NCulUJG26gxej8hHRuKg==
X-Google-Smtp-Source: AGHT+IG4PSBnaFjsnzhxMpiO8FM96hWxZreKEqqyM5FuNUUcjyI+6+1KWYVdOPU4FCjKiayJ+6DZAw==
X-Received: by 2002:a5d:6b8a:0:b0:32d:ad05:906c with SMTP id
 n10-20020a5d6b8a000000b0032dad05906cmr2065409wrx.3.1697750303889; 
 Thu, 19 Oct 2023 14:18:23 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adfe390000000b0032dab20e773sm212889wrm.69.2023.10.19.14.18.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 14:18:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/46] mailmap: update email addresses for Luc Michel
Date: Thu, 19 Oct 2023 23:17:26 +0200
Message-ID: <20231019211814.30576-2-philmd@linaro.org>
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

From: Luc Michel <luc@lmichel.fr>

Map my old and now invalid work email addresses to my personal one.

Signed-off-by: Luc Michel <luc@lmichel.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230929140326.2056658-2-luc@lmichel.fr>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 .mailmap | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.mailmap b/.mailmap
index d214959288..94f19a0ac9 100644
--- a/.mailmap
+++ b/.mailmap
@@ -81,6 +81,9 @@ Huacai Chen <chenhuacai@kernel.org> <chenhuacai@loongson.cn>
 James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
 Leif Lindholm <quic_llindhol@quicinc.com> <leif.lindholm@linaro.org>
 Leif Lindholm <quic_llindhol@quicinc.com> <leif@nuviainc.com>
+Luc Michel <luc@lmichel.fr> <luc.michel@git.antfield.fr>
+Luc Michel <luc@lmichel.fr> <luc.michel@greensocs.com>
+Luc Michel <luc@lmichel.fr> <lmichel@kalray.eu>
 Radoslaw Biernacki <rad@semihalf.com> <radoslaw.biernacki@linaro.org>
 Paul Brook <paul@nowt.org> <paul@codesourcery.com>
 Paul Burton <paulburton@kernel.org> <paul.burton@mips.com>
-- 
2.41.0


