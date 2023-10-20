Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 964537D0DFE
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 12:56:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtn9d-0006Dr-GG; Fri, 20 Oct 2023 06:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtn9b-0006DY-Mg
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 06:54:56 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtn9Y-00054X-4k
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 06:54:54 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-317c3ac7339so537755f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 03:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697799290; x=1698404090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DRXl7FYJRbnu5FN1+Vxlh8KExoG7zuMkkdyPGrTEQY0=;
 b=D40iUX+MFIsGf+xcGaZcXISbdtW8HaZwHCZDNVkrJrSsXfsnpyBycRHgCamuwZ7HJp
 HBmvwZ1eM9QbZ2Iq9lSTzXXD6bCT32jDO1C6AjkX/mvMK53cJEKuNZE235kPBx0/x64Q
 54t1AbO7tBjjTffiomlGMKV3lt3YumKNBT5gQoFIafjOn5npXjwe9JblltcEswaa8uAm
 9H0f8V9ZlUj8h4he97RHw3IEIv8pxbZkdmCAY6ApLu5OQOeJX8Jdk6cXB6dW/azE7BR1
 ehypR0GP7eBjyoVKBtqtkGnOyXQAi0/vTC4BKRtW08XX8VP2L/64hMdCijS4ch1Caavk
 hK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697799290; x=1698404090;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DRXl7FYJRbnu5FN1+Vxlh8KExoG7zuMkkdyPGrTEQY0=;
 b=UqZAwHrXnF5dDVRhPcErKF91aY8fI2FtMHtUtSpSK1QI2yoJPDty/LF7skQVs/iv45
 NAvlxiMt2vJ3DXo6rbaW2n2w60Ot81CpZJGVxGhluDOitFLmSzRxTisNu/iHNejqexyE
 6wCANumzuAP10MQ218M17jGQGwYabZUIGWrRdPDej22K/xWTtqG1q45So9MKkZ18PXS+
 B0Opij+y3YSDFMzx55TH5gftEqbvyeXAAgsvJ5ho8uzRO5PX6BMZnfgJFbA31KEM5zIS
 I65SsPKY9jOESDmGNc3rt57L36FGCH97E2g6ceBV14WM+I0NV9F5djY3FHY/cX0TbYaj
 4PFg==
X-Gm-Message-State: AOJu0YyHVmRiX1Try6K/TJML+P32ZcqKWHV84Em8elwbec1UPTXHxPZC
 af9sxaeFvAdmXPUngD1IjDNe/z/0bGf1VyqRhn0=
X-Google-Smtp-Source: AGHT+IFx+BSfNBUgBPeNuyINyMS14cZ6fqiGC4+F1ske3VmgAll5iKw2bMVT6CZmcPttsbpjNLcvDw==
X-Received: by 2002:adf:f64a:0:b0:32d:a49c:dfd0 with SMTP id
 x10-20020adff64a000000b0032da49cdfd0mr984081wrp.64.1697799290150; 
 Fri, 20 Oct 2023 03:54:50 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 r17-20020a5d4e51000000b0032d09f7a713sm1440395wrt.18.2023.10.20.03.54.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 03:54:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 0/5] hw/audio/pcspk: Inline pcspk_init()
Date: Fri, 20 Oct 2023 12:54:41 +0200
Message-ID: <20231020105447.43482-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Since v2:
- Propagate error in hw/i386/

Philippe Mathieu-Daudé (5):
  hw/i386/pc: Pass Error** argument to pc_basic_device_init()
  hw/i386/pc: Propagate error if HPET device creation failed
  hw/i386/pc: Inline legacy pcspk_init() in pc_basic_device_init()
  hw/isa/i82378: Inline legacy pcspk_init()
  hw/mips/jazz: Inline and remove legacy pcspk_init()

 include/hw/audio/pcspk.h | 10 ----------
 include/hw/i386/pc.h     |  5 +++--
 hw/i386/pc.c             | 17 +++++++++++++----
 hw/i386/pc_piix.c        |  2 +-
 hw/i386/pc_q35.c         |  2 +-
 hw/isa/i82378.c          |  7 ++++++-
 hw/mips/jazz.c           |  5 ++++-
 7 files changed, 28 insertions(+), 20 deletions(-)

-- 
2.41.0


