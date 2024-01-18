Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 635A5831AA4
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 14:33:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQSVd-00056X-G0; Thu, 18 Jan 2024 08:32:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQSVZ-00051I-CD; Thu, 18 Jan 2024 08:32:37 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQSVX-000232-It; Thu, 18 Jan 2024 08:32:37 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6da4a923b1bso6726548b3a.2; 
 Thu, 18 Jan 2024 05:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705584752; x=1706189552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vHaAra0yiJpjPl5M+0aVbS5rb6YYjPPEl4Zi1Bp8Ct4=;
 b=YQ2qhE+rNeuaS44IPtWZ4nsHGb7EAa7w5JCodlMByHiJEPCh7X+as9n4k8N5v1GXQS
 hmBJWkvux5Big9W8CGiGCgg4ozIqRcMNqom0m4uTA9d1cRzVeAEdHuC4E0AL0BVEmX0d
 +a1Ag9Gobj7+hjK9lSGXysgmA9JtFXU34pc7FTyZUgvDbuOa5y6+CJbP2GNTjOJaInB4
 UjgTVnBfHf/rwXLQBzIJIWJ2Fe3FiW2LZs6nvPACwVPpxcbRf0g/eZoGwxQogK9NlFp4
 tQZbmG2uif5Fvlzobz+yj2MSJZ7XgZGkrWW03qg8dFOpMCAfqMPWeFEMUcnt88UYtCX+
 kKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705584752; x=1706189552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vHaAra0yiJpjPl5M+0aVbS5rb6YYjPPEl4Zi1Bp8Ct4=;
 b=BaHCuek3IHXMnsYa5pkJD62cKeRTOGx8tYdGa3YmyBTHYe2GnzBT7Yys0VKMxCrVEX
 X7t9SvqIvbMkQaGjgbQbTHM92omjuOwIY+a39aqqbQxrJ1R63JSUaGelYoXxtX0XvAgi
 T6oiNA1oXhsIv1HjNVA6eADEmjK3lJ18qMzFlCvzyccRRessT/m74sGggECyf2UlGbms
 0zGGoCeO7v9EJMBffmGO4KRRVx9FNv1NVnaeKuC6mpi0XkNkbH1SHJv2JrJwXw85DQji
 IyLPZXcsvK/UtFVRQHyqDTTqCn1/B9DSclbwwpVqy3FoPuk4/JGC733SD62k7pTU+i+z
 BeoQ==
X-Gm-Message-State: AOJu0Yy7krv0H70MyH2LPnPPlnbBBw3DDREKrTFAlOrT/StUS9N6aECK
 diZXDnD1p8m59Brm18vQTZNcv8L70QGXZTd6Gj388pIf5IBfnKEGKiPYU/SQ
X-Google-Smtp-Source: AGHT+IGCfwqJoMylsM58zp6V2LyDerTyHxadmKah8oLnUsxSausg/mtbNS+6F0PpxSL2hoD69gJJrQ==
X-Received: by 2002:a05:6a00:3995:b0:6db:ade0:4bc9 with SMTP id
 fi21-20020a056a00399500b006dbade04bc9mr523623pfb.31.1705584752432; 
 Thu, 18 Jan 2024 05:32:32 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 a19-20020aa780d3000000b006daf1ded817sm3282551pfn.209.2024.01.18.05.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 05:32:32 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 4/4] hw/ppc/spapr: Rename 'softmmu' -> 'vhyp_mmu'
Date: Thu, 18 Jan 2024 23:32:06 +1000
Message-ID: <20240118133206.158453-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118133206.158453-1-npiggin@gmail.com>
References: <20240118133206.158453-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

In the spirit of reducing use of the term 'softmmu', rename
spapr_softmmu.c to spapr_vhyp_mmu.c.

Logically, the TLB loading code that walks the hash table is the
implementation of the ppc hash MMU, and the code that manipulates
the hash table is the implementation of the PAPR hypervisor
interface (called vhyp).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[npiggin: Pick a different name, explain it in changelog.]
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/{spapr_softmmu.c => spapr_vhyp_mmu.c} | 0
 hw/ppc/meson.build                           | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename hw/ppc/{spapr_softmmu.c => spapr_vhyp_mmu.c} (100%)

diff --git a/hw/ppc/spapr_softmmu.c b/hw/ppc/spapr_vhyp_mmu.c
similarity index 100%
rename from hw/ppc/spapr_softmmu.c
rename to hw/ppc/spapr_vhyp_mmu.c
diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index eba3406e7f..30bd2aaccf 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -31,7 +31,7 @@ ppc_ss.add(when: 'CONFIG_PSERIES', if_true: files(
   'pef.c',
 ))
 ppc_ss.add(when: ['CONFIG_PSERIES', 'CONFIG_TCG'], if_true: files(
-  'spapr_softmmu.c',
+  'spapr_vhyp_mmu.c',
 ))
 ppc_ss.add(when: 'CONFIG_SPAPR_RNG', if_true: files('spapr_rng.c'))
 if host_os == 'linux'
-- 
2.42.0


