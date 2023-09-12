Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A93BF79CFEF
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 13:31:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg1be-0004G5-0l; Tue, 12 Sep 2023 07:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qg1bU-00042i-HP
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 07:30:49 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qg1bQ-0000rN-Tx
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 07:30:47 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-99bcc0adab4so696978666b.2
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 04:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694518243; x=1695123043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EJDcYGi9xkj6QKbqo3iNcw77O78wB7Hq6Jj/+q8EmC0=;
 b=yW5lewStDd//iABYoGkiNWmTAUWKTsI5QBpRc9tDw3blWT8hGKn3vDR7sWCGDeExJl
 0tNv2sHtdHYnwsL1lt6LAmbw2MUNut2pdNLodtBCwc/W3zRPn5aXKQpPkviM4vCuNq/8
 CAt1nZk/eLTxl7H6NsAjL5M/7zeRnVWD04VIILlnBHxAimDNwBXeS3PlxvhLNluiX8Sf
 bzDd0EfQ/qPGUyvtWtI59Kl+ZwUCvp+5u3vn+2Voii4nrHHKTHgfTCBYFjkGsTJpRSu8
 2NfUp9CL3Wbpno6t/Vf76bueX2z1j0mzapE44T7DPrgNK7lfJdn/1rZKq5E+7/y9vomL
 2Bxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694518243; x=1695123043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EJDcYGi9xkj6QKbqo3iNcw77O78wB7Hq6Jj/+q8EmC0=;
 b=r/Zpif/37qcpf5l+V2BBr/S/gXes9CjyrajagRa7CXJ45LvZaQ/f8aHML5ZWO9jW76
 Hd33uSNGiS1iOln2INxEeM/y3dQC1zrGS9lB78LVNLh0b2FM8n220chhHhhzi655odYN
 o7ti4x3gIoKrHNYOgaAB3PPAnGg+OjdueKfehe2ZfwZ3frx6uruoltpV/Y0PLAW/d6ub
 IAQ80PoYFmUGZlBiv/mLI57vKklsrvvJQ/QJM7JW3VIpx4rCfjAgzGW6+bWwp9TkyPHM
 tb8x9F2W8Oi3rJY2bTecNXJw1YxuUaDb3XJbwCD+IRpvtygG5X3pJc9Kb3Q0Oy1KrPOx
 sOPw==
X-Gm-Message-State: AOJu0YyTX+TKLmEgZMXX5DmuNTPdCv+JZb+RcwBNdApOzMRbvZGpwuGg
 KC0ub6LPxzmsicjvZ2lmO/8HVIkjFCYNGfmJwpk=
X-Google-Smtp-Source: AGHT+IFGR/hGUK+MotInaJDLHL5KTJ51jW0Vv1cuFdKWsf08M8zQ6ICYJzMY0WFbfe/ZeqQConVujA==
X-Received: by 2002:a17:906:1da9:b0:9a1:d79a:418e with SMTP id
 u9-20020a1709061da900b009a1d79a418emr10080318ejh.40.1694518243093; 
 Tue, 12 Sep 2023 04:30:43 -0700 (PDT)
Received: from m1x-phil.lan (cou50-h01-176-172-50-150.dsl.sta.abo.bbox.fr.
 [176.172.50.150]) by smtp.gmail.com with ESMTPSA id
 ld10-20020a1709079c0a00b009ad829ed144sm953504ejc.130.2023.09.12.04.30.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Sep 2023 04:30:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/4] target/ppc: Restrict KVM objects to system emulation
Date: Tue, 12 Sep 2023 13:30:24 +0200
Message-ID: <20230912113027.63941-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912113027.63941-1-philmd@linaro.org>
References: <20230912113027.63941-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

kvm-stub.c only defines kvm_openpic_connect_vcpu(),
which is clearly not used by user emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/meson.build b/target/ppc/meson.build
index 4c2635039e..bf1c9319fa 100644
--- a/target/ppc/meson.build
+++ b/target/ppc/meson.build
@@ -30,7 +30,6 @@ gen = [
 ]
 ppc_ss.add(when: 'CONFIG_TCG', if_true: gen)
 
-ppc_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'), if_false: files('kvm-stub.c'))
 ppc_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user_only_helper.c'))
 
 ppc_system_ss = ss.source_set()
@@ -46,6 +45,7 @@ ppc_system_ss.add(when: 'CONFIG_TCG', if_true: files(
 ), if_false: files(
   'tcg-stub.c',
 ))
+ppc_system_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'), if_false: files('kvm-stub.c'))
 
 ppc_system_ss.add(when: 'TARGET_PPC64', if_true: files(
   'compat.c',
-- 
2.41.0


