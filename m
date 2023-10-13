Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0DC7C7F66
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:05:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD5j-0008Ji-47; Fri, 13 Oct 2023 04:00:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5L-0007o1-Oy
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:52 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5I-0007MR-DZ
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:51 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2bffc55af02so21425321fa.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183986; x=1697788786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GK5QvAf46jj79m4OJkBEl5Y8X0BoRnQqYVbzHGs7YVg=;
 b=Ps/qXofN7DYwRBkSrFMrx5+vIm8sQBptScGBHA7eqUoZ7kA+sPA6wcjsqX+Y8q70RA
 RxHqUsZ5Yog5xS/WkMUxtHBBjqfmjYdtbGd8Tc5NuVMAvCA85DQeiVkLO9WV10wdtR28
 ypAWALc7/5HhnVvQnB+3VO7jpVYgMOHC8dFy43lo0QLlOeRNKHabdgvFON14N+f0P5ng
 Sz8JdtGNxjIn2+tkPfsUvS5iCDmAb3Yez0Ge4Kw/IcZCOUcHD10Xdza8CxwiV/n68IX3
 4NIs16+mP0jvIwPthU6SJCfUk57z74ncjPmAKeeTYo1ucyBamsPcqphX3+t3YV2fxZEm
 DARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183986; x=1697788786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GK5QvAf46jj79m4OJkBEl5Y8X0BoRnQqYVbzHGs7YVg=;
 b=E74pufj54pEvzrTl9gWK1fBnsr/rq66gxlgWoHo+vQhB50QWzbBgYIGnYyzgscvWif
 U88P1Q3oCrP58+s9OipfclnKCgyLcuojw0lIFDebbEbvqkych/0o69zOg57Fk5COHyrl
 UmBiiKJGSp1VOLfk4//yJNE74RAhTWfSS1BVNCIhw2EtIMawIDL20R8rMrYSK+ziB3bc
 gCOrvCBsTUdbokH3bJd4LTnyJggOPAVtsXjGoxSnvZvlQ/sDIhC5ReoYLCp/vES3fFN9
 fFtsAnGaMUAF21T5Bky4m/2LGcw93FYodjuJkR3rQ/tio9IyBicNBK+ezrPtNaycsdpk
 nRww==
X-Gm-Message-State: AOJu0Yz2FH8jOjg9OZxpDxjg+SS2w9TbbaIZaRJFjAkJVItdbXejW81X
 bxiyH/uMoQXenXwr8d2esXmxZOPko1u0DV0oWwY=
X-Google-Smtp-Source: AGHT+IHFoC4ze9VUX0dtlp3axU94nTbc3wi4cvOVIWFiX/NLI3/xN+mFfFtSZ7qO/pSCd7AuMirySg==
X-Received: by 2002:a05:6512:b25:b0:503:38bc:e68c with SMTP id
 w37-20020a0565120b2500b0050338bce68cmr21605036lfu.47.1697183986344; 
 Fri, 13 Oct 2023 00:59:46 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:59:45 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:OMAP)
Subject: [RFC PATCH v2 62/78] hw/gpio: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:57:29 +0300
Message-Id: <26ee3b7495f5d6f9715b0d00ad97bacf37ac3ed6.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x22b.google.com
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/gpio/omap_gpio.c  | 2 +-
 hw/i2c/bitbang_i2c.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/gpio/omap_gpio.c b/hw/gpio/omap_gpio.c
index a3341d70f1..82a9ea4810 100644
--- a/hw/gpio/omap_gpio.c
+++ b/hw/gpio/omap_gpio.c
@@ -532,54 +532,54 @@ static uint64_t omap2_gpio_module_readp(void *opaque, hwaddr addr,
 static void omap2_gpio_module_writep(void *opaque, hwaddr addr,
                                      uint64_t value, unsigned size)
 {
     uint32_t cur = 0;
     uint32_t mask = 0xffff;
 
     if (size == 4) {
         omap2_gpio_module_write(opaque, addr, value);
         return;
     }
 
     switch (addr & ~3) {
     case 0x00:	/* GPIO_REVISION */
     case 0x14:	/* GPIO_SYSSTATUS */
     case 0x38:	/* GPIO_DATAIN */
         OMAP_RO_REG(addr);
         break;
 
     case 0x10:	/* GPIO_SYSCONFIG */
     case 0x1c:	/* GPIO_IRQENABLE1 */
     case 0x20:	/* GPIO_WAKEUPENABLE */
     case 0x2c:	/* GPIO_IRQENABLE2 */
     case 0x30:	/* GPIO_CTRL */
     case 0x34:	/* GPIO_OE */
     case 0x3c:	/* GPIO_DATAOUT */
     case 0x40:	/* GPIO_LEVELDETECT0 */
     case 0x44:	/* GPIO_LEVELDETECT1 */
     case 0x48:	/* GPIO_RISINGDETECT */
     case 0x4c:	/* GPIO_FALLINGDETECT */
     case 0x50:	/* GPIO_DEBOUNCENABLE */
     case 0x54:	/* GPIO_DEBOUNCINGTIME */
         cur = omap2_gpio_module_read(opaque, addr & ~3) &
                 ~(mask << ((addr & 3) << 3));
 
-        /* Fall through.  */
+        fallthrough;
     case 0x18:	/* GPIO_IRQSTATUS1 */
     case 0x28:	/* GPIO_IRQSTATUS2 */
     case 0x60:	/* GPIO_CLEARIRQENABLE1 */
     case 0x64:	/* GPIO_SETIRQENABLE1 */
     case 0x70:	/* GPIO_CLEARIRQENABLE2 */
     case 0x74:	/* GPIO_SETIREQNEABLE2 */
     case 0x80:	/* GPIO_CLEARWKUENA */
     case 0x84:	/* GPIO_SETWKUENA */
     case 0x90:	/* GPIO_CLEARDATAOUT */
     case 0x94:	/* GPIO_SETDATAOUT */
         value <<= (addr & 3) << 3;
         omap2_gpio_module_write(opaque, addr, cur | value);
         break;
 
     default:
         OMAP_BAD_REG(addr);
         return;
     }
 }
diff --git a/hw/i2c/bitbang_i2c.c b/hw/i2c/bitbang_i2c.c
index de5f5aacf5..3d768ae564 100644
--- a/hw/i2c/bitbang_i2c.c
+++ b/hw/i2c/bitbang_i2c.c
@@ -79,99 +79,99 @@ static int bitbang_i2c_nop(bitbang_i2c_interface *i2c)
 /* Returns data line level.  */
 int bitbang_i2c_set(bitbang_i2c_interface *i2c, int line, int level)
 {
     int data;
 
     if (level != 0 && level != 1) {
         abort();
     }
 
     if (line == BITBANG_I2C_SDA) {
         if (level == i2c->last_data) {
             return bitbang_i2c_nop(i2c);
         }
         i2c->last_data = level;
         if (i2c->last_clock == 0) {
             return bitbang_i2c_nop(i2c);
         }
         if (level == 0) {
             /* START condition.  */
             bitbang_i2c_set_state(i2c, SENDING_BIT7);
             i2c->current_addr = -1;
         } else {
             /* STOP condition.  */
             bitbang_i2c_enter_stop(i2c);
         }
         return bitbang_i2c_ret(i2c, 1);
     }
 
     data = i2c->last_data;
     if (i2c->last_clock == level) {
         return bitbang_i2c_nop(i2c);
     }
     i2c->last_clock = level;
     if (level == 0) {
         /* State is set/read at the start of the clock pulse.
            release the data line at the end.  */
         return bitbang_i2c_ret(i2c, 1);
     }
     switch (i2c->state) {
     case STOPPED:
     case SENT_NACK:
         return bitbang_i2c_ret(i2c, 1);
 
     case SENDING_BIT7 ... SENDING_BIT0:
         i2c->buffer = (i2c->buffer << 1) | data;
         /* will end up in WAITING_FOR_ACK */
         bitbang_i2c_set_state(i2c, i2c->state + 1);
         return bitbang_i2c_ret(i2c, 1);
 
     case WAITING_FOR_ACK:
     {
         int ret;
 
         if (i2c->current_addr < 0) {
             i2c->current_addr = i2c->buffer;
             trace_bitbang_i2c_addr(i2c->current_addr);
             ret = i2c_start_transfer(i2c->bus, i2c->current_addr >> 1,
                                      i2c->current_addr & 1);
         } else {
             trace_bitbang_i2c_send(i2c->buffer);
             ret = i2c_send(i2c->bus, i2c->buffer);
         }
         if (ret) {
             /* NACK (either addressing a nonexistent device, or the
              * device we were sending to decided to NACK us).
              */
             bitbang_i2c_set_state(i2c, SENT_NACK);
             bitbang_i2c_enter_stop(i2c);
             return bitbang_i2c_ret(i2c, 1);
         }
         if (i2c->current_addr & 1) {
             bitbang_i2c_set_state(i2c, RECEIVING_BIT7);
         } else {
             bitbang_i2c_set_state(i2c, SENDING_BIT7);
         }
         return bitbang_i2c_ret(i2c, 0);
     }
     case RECEIVING_BIT7:
         i2c->buffer = i2c_recv(i2c->bus);
         trace_bitbang_i2c_recv(i2c->buffer);
-        /* Fall through... */
+        fallthrough;
     case RECEIVING_BIT6 ... RECEIVING_BIT0:
         data = i2c->buffer >> 7;
         /* will end up in SENDING_ACK */
         bitbang_i2c_set_state(i2c, i2c->state + 1);
         i2c->buffer <<= 1;
         return bitbang_i2c_ret(i2c, data);
 
     case SENDING_ACK:
         if (data != 0) {
             bitbang_i2c_set_state(i2c, SENT_NACK);
             i2c_nack(i2c->bus);
         } else {
             bitbang_i2c_set_state(i2c, RECEIVING_BIT7);
         }
         return bitbang_i2c_ret(i2c, 1);
     }
     abort();
 }
-- 
2.39.2


