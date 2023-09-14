Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D412C7A0E92
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 21:53:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgsOT-00066y-Hx; Thu, 14 Sep 2023 15:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgsOQ-00066i-Ut
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 15:52:50 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgsOP-0006mz-DN
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 15:52:50 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-502f302b68dso78609e87.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 12:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694721167; x=1695325967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=apJ9rfBp2rCZyyq835aOveYeTS1oCQzV0m60yDVlahc=;
 b=GZZCPpTTYI2SNlPvEXgyhQxb2lDljhAhgdZZzf14Kw1dfoiq9cuEacXRwdZQ4TZKW2
 8GEYWIpUKARMV0cWLPdZdE85m3tcf1FOmUhTFZLtkBpiqWwY+LFlu2ViTKmhSKIHSqVR
 LIDKzDJ9yRziQE3T8dEM2RS44ifh5nDvSMNemBcaHrkwn4Ws5XTVt9zfCvxSfZoAbGq8
 d4hV+lTeKMYbru3qRSQQpK3zHbw3GsHCdisgQj8r3Fvn35myuc0FV6bGg/jj8RwLn09L
 2HPY5x3FRW1sIrbGvpto0LwYOoS2fax7J0qP1oole6Gmdt8l+KWKbXK/fraOK+BCuWTj
 Uoag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694721167; x=1695325967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=apJ9rfBp2rCZyyq835aOveYeTS1oCQzV0m60yDVlahc=;
 b=MkpR9kBL0KQvnVvmHnNEkI+KlIFS1nCyJysR+UkDHM7TEYdIT3V05aFoSbD6UwZXFU
 Y+pdgr/bgRayQMlpSnuta2tlFAtLbuXHGo84zobTdbuaibI+aDUGXiny+Nhyax66aOsx
 wZGWWz+k31SL8zgzmh+fWybPVApA4M1aFpgJh2+whEMDuqyDtAqWvXBDGzzY52n3LcSg
 LbebF2RcPHjHDgTTeJY4vn1mzf2edhCTkqmyO0puClSth+7C4E638JGaJObU63npN2ey
 fGFRovfRGYPyeNjXGm/R1I0WSmqnQYVxmDH2MflbmmUycLHaJZnVqxLCT//jXA0tLFKo
 fm6Q==
X-Gm-Message-State: AOJu0Yx80Tsb/GcPZyaWZI/Y55D7wAnS1F4W9QUFw9/fH/oWZGM3y2Xd
 gSFAYwkwBNkvcBeUmECP4LRdECbmtFZmNbez1GE=
X-Google-Smtp-Source: AGHT+IEzwjo2Yjc1mK1cZMoJLogDgQ1au7Z4NgSs0HdZaeRi5JgJu0mrAZOQ0eESns0v7NAaSMYQYA==
X-Received: by 2002:a05:6512:2354:b0:4fb:ca59:42d7 with SMTP id
 p20-20020a056512235400b004fbca5942d7mr6586346lfu.33.1694721167222; 
 Thu, 14 Sep 2023 12:52:47 -0700 (PDT)
Received: from m1x-phil.lan (176-131-223-129.abo.bbox.fr. [176.131.223.129])
 by smtp.gmail.com with ESMTPSA id
 z21-20020a170906241500b0099b76c3041csm1439481eja.7.2023.09.14.12.52.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Sep 2023 12:52:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Anton Johansson <anjo@rev.ng>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Subject: [PATCH 2/4] accel/tcg: Remove unused tcg_flush_jmp_cache() stub
Date: Thu, 14 Sep 2023 21:52:27 +0200
Message-ID: <20230914195229.78244-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230914195229.78244-1-philmd@linaro.org>
References: <20230914195229.78244-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
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

Since commit ba7d3d1858 ("cpu_common_reset: wrap TCG
specific code in tcg_enabled()") we protect the single call
to tcg_flush_jmp_cache() with a check on tcg_enabled(). The
stub isn't needed anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/stubs/tcg-stub.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index f088054f34..dd890d6cf6 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -18,10 +18,6 @@ void tb_flush(CPUState *cpu)
 {
 }
 
-void tcg_flush_jmp_cache(CPUState *cpu)
-{
-}
-
 int probe_access_flags(CPUArchState *env, vaddr addr, int size,
                        MMUAccessType access_type, int mmu_idx,
                        bool nonfault, void **phost, uintptr_t retaddr)
-- 
2.41.0


