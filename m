Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41171AAC83A
	for <lists+qemu-devel@lfdr.de>; Tue,  6 May 2025 16:38:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJPk-0008ME-VR; Tue, 06 May 2025 10:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJPA-00083O-Ok
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:36:20 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJP9-00017C-24
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:36:20 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-441ab63a415so57928655e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542177; x=1747146977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jXGXJXekOQ7eMfA+d/T2yDZNBjaeBW38SPlSuK10hsU=;
 b=rReBAEaUWo7o1NGh4zRz7zISsgmRdfJ6yjX3iKKVe5JcDypss99AeDSjfg+opSfVZU
 duDSB4rDiLAazwIGSF/NxkkN+h+1dLSazezzaoCdOwFsNeCLT5vmVB/M1maUR25r/HS8
 hD4Y9xAKifVAa50oozikxt3ppyBGvzTM/kK7JtWuK8cuZRLdTZC6LZR99nc2QWLL/6hR
 RT0ayL+ZmEQ1hbMqjLwHw8KKLheS0jE3ZQ5jCVyf+VEF/K8VJTKBNIURBxlaRSmYajxs
 sdqaezS0PXfKtzjMG/HEdlaExQ+seaZheShKd+v4OCvp7A006DyliWgVt0zr8LCzKUAz
 +J6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542177; x=1747146977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jXGXJXekOQ7eMfA+d/T2yDZNBjaeBW38SPlSuK10hsU=;
 b=NeTbpiJn64hRE55Q2XnAmQclPSXh2PjouKVuAMpC9FjriL8Wc7EYurXyvOxjXEa4S+
 FUD7s0gLsYjdxeMUv+HN/Zcc8A8k8bzN0354kyQADEx+7RnzOi0FKXbepqiR1Vilfk+Y
 HNYpB73YnbCxePw0Q8vF/8YlPk1eYwHNgMRiHpfxd6eXVgWuxcWwvMQvviSSCVC6IJLE
 eJmwjsu4LNJM4iKc/04L5FaRyXtP7jEgzV2wQaqyo1yek/TQQuA+/PG0iNwE7hFI4Cv6
 kOtLzs29V0aN9DxjNcJnondYj/fU4vEyl0OX/ax3O2UsyKu5kHzHrZ7SPgLjWbniWTl6
 6dxQ==
X-Gm-Message-State: AOJu0Yw/WEejjpPLr2QvADjbDIxGPIfUgN78OFw2m25zxGgMvq98637a
 GHSSbcMMMR2gR58ULUzY6oIRFn9an3apW1ok9EDmkt/V8sWxGQHKr9Cs9Af+P1YADl1NXKwRvTt
 4
X-Gm-Gg: ASbGncsbG12ePJMCenCoRSW1qxK+Sf0+xfJ+owYF6TK097mvJj4a8bS/nK4HpF7XQYN
 fgqHAb8ryk79eFqu/uOLNK2b/yprg1NBU0a1oaH3KhaellheF6GDecrguG+1iaICd5AdpqxaHdQ
 foZ5IiRD+6SIvoJCioR/2gYSgSNCE7KjRhuTXNwGPloJO2rY2kFA2lEG4D6MKezNCcNeQKvEO6e
 lFYxzLR4CZevTuYBHfXiXx51JDB61A1NL4Kpi5w/qYD8+DXbQuS5vROnV9ebab4Yw4UZUzf9Lr+
 o2ztFL0uKOGbkuWG4krwbfxQ2idDcXAX7Cjbn61AH98dcBt7x+jrg0iKpmWyWp9uANH+sDw3RZe
 okMIBAUVycrWOcc2m97KE
X-Google-Smtp-Source: AGHT+IESlvhdqID5Mx5Y7k/5gBsabYjyxh3vj5uZS81EmJ5hfRvEicTaBSVyl+wrhI1JDSZQS30BcQ==
X-Received: by 2002:a05:600c:3e05:b0:43d:1824:aadc with SMTP id
 5b1f17b1804b1-441d1012f22mr27703015e9.29.1746542176845; 
 Tue, 06 May 2025 07:36:16 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441d15dd9c6sm17639015e9.1.2025.05.06.07.36.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:36:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/22] hw/hyperv/hyperv_testdev: common compilation unit
Date: Tue,  6 May 2025 16:35:02 +0200
Message-ID: <20250506143512.4315-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143512.4315-1-philmd@linaro.org>
References: <20250506143512.4315-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250424232829.141163-7-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/hyperv/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/hyperv/meson.build b/hw/hyperv/meson.build
index 5acd709bdd5..ef5a596c8ab 100644
--- a/hw/hyperv/meson.build
+++ b/hw/hyperv/meson.build
@@ -1,5 +1,5 @@
 specific_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'))
-specific_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
+system_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
 system_ss.add(when: 'CONFIG_VMBUS', if_true: files('vmbus.c'))
 system_ss.add(when: 'CONFIG_SYNDBG', if_true: files('syndbg.c'))
 system_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c', 'hv-balloon-page_range_tree.c', 'hv-balloon-our_range_memslots.c'))
-- 
2.47.1


