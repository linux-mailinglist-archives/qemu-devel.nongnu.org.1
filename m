Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE42825753
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 16:59:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLmR3-0002Ab-2a; Fri, 05 Jan 2024 10:48:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmPl-0005MS-La
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:47:19 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmPj-00045A-UF
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:47:17 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33748c4f33dso1402314f8f.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 07:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704469634; x=1705074434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=foPbRN9kgz3ubIukCDMoVcakJKSu99lNJLUQRej2Dsg=;
 b=pAJGDXvCXqCWtmEX24PENeF/S6BWfWmbADoC/oGYDGPwQKutZ5aONcv7Q3kSxSaRsj
 Vu1dKH40+YAhYVZ7ElIXYKG0OUx6y6xhkG8jaidL7xoZVDljyNVB9qb/gcn66glAF2Ej
 VADCTDYsNLlH/NBBSWO8K0crq+FVsvtxd1WsgGMiKvJDumxUi3bpkr0+gz1s5XSO55CQ
 2H1E3rcmYnn9EzUtcSsrdkwF3eoYzC0hlkyc7a0GnoOvAgaf278CFXcxQKO9qj8ggKRE
 dolEz3LzOa9vJ4XLQMRq/OC+E2g2ngAL1ZDrJWgWWG3DDk2OpuAsv+t9H7skvwZJxfuG
 htyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704469634; x=1705074434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=foPbRN9kgz3ubIukCDMoVcakJKSu99lNJLUQRej2Dsg=;
 b=AYBWjTv2WOVeTbjsp0IL+3uy3VlAwnoXFSsKl8tr7yj29aWJGjEcwwui1IDaLEUc8F
 TFuMja47zyNBShc0s93HDyXLsLn83f2rNnwfchaGvcLbWadX9b+8e0Jgy1wc8+MW6G94
 M7wUlpciROWugSKi4LKwAFFyZFC7LIWB88cBgjTLFJ+gE70yLquKncjP4q71BMpe9Vl0
 b03SW56QZB/6aHfrG3BxglxS8Jw/ancUFyc4iYaGciwIz30rfnE6NkWR7LAN7wh+oDEr
 bOlCsZNpOgbnrN7zma6z9KKuCmJCDcHrxfRlKEsIXj1X3yd1f/FGsXesxvKHYzmMxqel
 D4jw==
X-Gm-Message-State: AOJu0YydBaZuhR5jcHE43LVwZ2pKJchD7QP6GSteBwPBF4V/FribfeA/
 DTwtw+yU7Lvk43zJjwk/QBbUiE8TcBcrhPp0RPepPjlZ9ss=
X-Google-Smtp-Source: AGHT+IHg1HQZbW3JaXorahcPs3JXuhS2e6/ZjANSl9hTUp1wBVq9xc+bE8w9O8VzKqOqqQuwrYzHSA==
X-Received: by 2002:a5d:550d:0:b0:332:e667:4277 with SMTP id
 b13-20020a5d550d000000b00332e6674277mr1265526wrv.40.1704469634427; 
 Fri, 05 Jan 2024 07:47:14 -0800 (PST)
Received: from m1x-phil.lan (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 g18-20020adfa492000000b003365f5e87f4sm1623391wrb.95.2024.01.05.07.47.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jan 2024 07:47:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 37/71] hw/audio/sb16: Do not migrate qdev properties
Date: Fri,  5 Jan 2024 16:42:30 +0100
Message-ID: <20240105154307.21385-38-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240105154307.21385-1-philmd@linaro.org>
References: <20240105154307.21385-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Since commit f7b4f61f63 ("qdev/isa: convert soundblaster") these
fields have been converted to qdev properties, so don't need to
be migrated:

  static Property sb16_properties[] = {
      DEFINE_AUDIO_PROPERTIES(SB16State, card),
      DEFINE_PROP_UINT32 ("version", SB16State, ver,  0x0405), /* 4.5 */
      DEFINE_PROP_UINT32 ("iobase",  SB16State, port, 0x220),
      DEFINE_PROP_UINT32 ("irq",     SB16State, irq,  5),
      DEFINE_PROP_UINT32 ("dma",     SB16State, dma,  1),
      DEFINE_PROP_UINT32 ("dma16",   SB16State, hdma, 5),
      DEFINE_PROP_END_OF_LIST (),
  };

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-Id: <20231124182615.94943-1-philmd@linaro.org>
---
 hw/audio/sb16.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index bf7f35a42b..fd76e78d18 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -1325,11 +1325,11 @@ static const VMStateDescription vmstate_sb16 = {
     .minimum_version_id = 1,
     .post_load = sb16_post_load,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT32 (irq, SB16State),
-        VMSTATE_UINT32 (dma, SB16State),
-        VMSTATE_UINT32 (hdma, SB16State),
-        VMSTATE_UINT32 (port, SB16State),
-        VMSTATE_UINT32 (ver, SB16State),
+        VMSTATE_UNUSED(  4 /* irq */
+                       + 4 /* dma */
+                       + 4 /* hdma */
+                       + 4 /* port */
+                       + 4 /* ver */),
         VMSTATE_INT32 (in_index, SB16State),
         VMSTATE_INT32 (out_data_len, SB16State),
         VMSTATE_INT32 (fmt_stereo, SB16State),
-- 
2.41.0


