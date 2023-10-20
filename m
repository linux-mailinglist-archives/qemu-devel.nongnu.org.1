Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B11727D14A7
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 19:16:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtt5i-0000lX-8i; Fri, 20 Oct 2023 13:15:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtt5f-0000l3-UF
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 13:15:15 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtt5e-0004RD-9O
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 13:15:15 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2c515527310so15330291fa.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 10:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697822112; x=1698426912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FOnrF4PFjqlwbRpkGw7aaEfcztV2JQ5uSHjglSueDhU=;
 b=m4Ex2Kl3IxnAQIp+ZaR/2MeolTaTOynofEb+sgzPLDnZjXzlxYRSNNxsW7zowSEYTL
 4+9312KS0//aoeB0imBlVqru1dzjQjilfCw7SmkEpwK4usk5yyNOsBVI5hHXWSl21Rjd
 uCoDtN7WGFMn2IC/2TaD6VlmX8R9O0yQ3yrXqK1hURJK3od0eDvOBLoqO23Wlx8zhv43
 1LbTeggSL4hmL1rT3a9ZS3s23OtH3Lfc5r5p8vX6PxXFqL0MEWPqi2QtrPmmnzMQfCaV
 FD+TQTQJBWjgV4Qi0N67pLuwooCZpOgS25u4AcxKYwtN6HyM63u62tlZagGJKBTp3fjR
 wgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697822112; x=1698426912;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FOnrF4PFjqlwbRpkGw7aaEfcztV2JQ5uSHjglSueDhU=;
 b=UEih910VY5Gy4KNrCZhcuXc0zEvSMeR0qWDL9W6ssLJpNySB5WQ+T4s2AjWYvNoJaP
 EdverIFEeLPik5CxD1wt9NoDz+LSmVSpMkLsjrNSKSuuczGvMr2qtqOHXJfKUwjinYZX
 UN4EljT7kAtqwdI3oBhmUDUGnBee+dEiw4/ogcekESSHc/TGtAYuAICHB32pTNIL9FP8
 4kVvM2bPrZZkW66mloO98AOuPQWTaqK7IgFYD/wnToNl+yDV3ZY7juhBJnPLls1293fv
 fHZgoOLvmyZofRbidHAdS2XdtzOxgmL6U/QbT7oCuSDcHqyJGHdxepP3qanNsCmbneXw
 4ihA==
X-Gm-Message-State: AOJu0Yz7JvJGwftyuHoPxOL4CkbGjG7k2GUM2QQQqJPySj3EJTHUo5fQ
 hdKLPDbH6vzgcG1xamCRg7fBbM04gYSwd3Y3lGg=
X-Google-Smtp-Source: AGHT+IHeo0i+li/bobBBASUGSKmGyF7UCLaC5r5qK4qmALat+3Mfn1qa/yuKmxBsn/sN7pOzf+hWkQ==
X-Received: by 2002:a2e:9c8c:0:b0:2c5:70f:614a with SMTP id
 x12-20020a2e9c8c000000b002c5070f614amr1712003lji.17.1697822111903; 
 Fri, 20 Oct 2023 10:15:11 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 p15-20020a05600c1d8f00b00402d34ea099sm7454062wms.29.2023.10.20.10.15.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 10:15:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 0/4] hw/audio/pcspk: Inline pcspk_init()
Date: Fri, 20 Oct 2023 19:15:04 +0200
Message-ID: <20231020171509.87839-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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

Unfortunately v2 was merged as commit 40f8214fcd,
so adapt v3 to clean the mess.

Philippe Mathieu-Daudé (4):
  hw/i386/pc: Pass Error** argument to pc_basic_device_init()
  hw/i386/pc: Propagate error if HPET device creation failed
  hw/i386/pc: Propagate error if PC_SPEAKER device creation failed
  hw/isa/i82378: Propagate error if PC_SPEAKER device creation failed

 include/hw/i386/pc.h |  5 +++--
 hw/i386/pc.c         | 15 +++++++++++----
 hw/i386/pc_piix.c    |  2 +-
 hw/i386/pc_q35.c     |  2 +-
 hw/isa/i82378.c      |  4 +++-
 5 files changed, 19 insertions(+), 9 deletions(-)

-- 
2.41.0


