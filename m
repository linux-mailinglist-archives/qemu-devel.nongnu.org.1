Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B76947C7F7E
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:07:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD5l-000080-8g; Fri, 13 Oct 2023 04:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5O-0007tn-Fz
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:55 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5K-0007Mx-0C
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:52 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5042bfb4fe9so2332617e87.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183988; x=1697788788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X5VpKHEqnL+Wsz989a6c98ciJXzLW3/QD62qq4ISbic=;
 b=wDENUJEJT6ttV/jHa30+0Xzex6xda43m7dHxxmLRl0q9fFk5y1tIsIOJvXLeFxVkcO
 I01Z0whQCtPHlT7YkSnrVETUpplwhO2O5VuE20WN6J75AJ/r22juYPdI7Bk8JLcMgvn7
 4S+Tali5NbnEMHLYT5iBmLEV+Hx6c9eB//OmqsdpfyzNrqigIgQlyXFeXAU3fttstUeY
 qHDxc593l9vFVZfDns9mTp3pDHevph4bfJJZLrKGpz4iKJHfDgmO5qj4+i1AjB1bLiZD
 pRa0d/FZwtahUTaGAo5axGXTHH8WMux8XA/AZJAa4aZwOOE8Zx0IwFje2Q/7mo5JJYRj
 PBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183988; x=1697788788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X5VpKHEqnL+Wsz989a6c98ciJXzLW3/QD62qq4ISbic=;
 b=J40YUHPc4hZUuTvkhkZUqfqE7UHpi0ygIifJ3O37i5deOYXH1sHJxnQ3wFu6NdrdPU
 4dJc5v8hjcLhUa8mF9Jf3KGPe3xqp2IgfP5EaM1xFUVGBKlQ7zLnyaUgsf02cSCHER02
 Ss83b44AH315tuDYTN8zN/6Ef3miBGTRxJtc2Efge4cYr3uuostRiQUwLB7Qz747pw3l
 ZW2FayXOs+HaOBwT7u7KcmLCNFxd2mqsgfJnSTmyTH5Sx3DqQCw+P0nTH9/lmHc1VsUG
 A/Fp+mWsiHr03cvisw0X3dkvQxkR+f5hq3XKndzmSJsfj/9yV0AMOcHqrpPX+OvuEWmW
 Y17A==
X-Gm-Message-State: AOJu0Yyq9rWsKkyL85/7k+Pjw25WVAnrF+KmoJqfV9anqEzhYI8oJovc
 RfOQDbXzjOFOgTmt1BbA32T1PZKXAdwHwPKD6KU=
X-Google-Smtp-Source: AGHT+IHGagpBaHPMbrGTxfOLH7i+5vY6BHOb6DsCpX9wwl5iTkyJm5kRpNVg2uKWjjKkIZUirV75LA==
X-Received: by 2002:ac2:5f66:0:b0:506:87a3:c27c with SMTP id
 c6-20020ac25f66000000b0050687a3c27cmr14362256lfc.53.1697183987760; 
 Fri, 13 Oct 2023 00:59:47 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:59:47 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Corey Minyard <minyard@acm.org>
Subject: [RFC PATCH v2 63/78] hw/ipmi: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:57:30 +0300
Message-Id: <bb840f22f424db1d386475d5c0e2d50ee5b50a26.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x131.google.com
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
 hw/ipmi/ipmi_bmc_extern.c | 2 +-
 hw/ipmi/smbus_ipmi.c      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index e232d35ba2..b2ca02b21f 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -168,15 +168,15 @@ static void extern_timeout(void *opaque)
 static void addchar(IPMIBmcExtern *ibe, unsigned char ch)
 {
     switch (ch) {
     case VM_MSG_CHAR:
     case VM_CMD_CHAR:
     case VM_ESCAPE_CHAR:
         ibe->outbuf[ibe->outlen] = VM_ESCAPE_CHAR;
         ibe->outlen++;
         ch |= 0x10;
-        /* fall through */
+        fallthrough;
     default:
         ibe->outbuf[ibe->outlen] = ch;
         ibe->outlen++;
     }
 }
diff --git a/hw/ipmi/smbus_ipmi.c b/hw/ipmi/smbus_ipmi.c
index d0991ab7f9..58f5328a19 100644
--- a/hw/ipmi/smbus_ipmi.c
+++ b/hw/ipmi/smbus_ipmi.c
@@ -207,90 +207,90 @@ static int ipmi_load_readbuf(SMBusIPMIDevice *sid)
 static int ipmi_write_data(SMBusDevice *dev, uint8_t *buf, uint8_t len)
 {
     SMBusIPMIDevice *sid = SMBUS_IPMI(dev);
     bool send = false;
     uint8_t cmd;
     int ret = 0;
 
     /* length is guaranteed to be >= 1. */
     cmd = *buf++;
     len--;
 
     /* Handle read request, which don't have any data in the write part. */
     switch (cmd) {
     case SSIF_IPMI_RESPONSE:
         sid->currblk = 0;
         ret = ipmi_load_readbuf(sid);
         break;
 
     case SSIF_IPMI_MULTI_PART_RESPONSE_MIDDLE:
         sid->currblk++;
         ret = ipmi_load_readbuf(sid);
         break;
 
     case SSIF_IPMI_MULTI_PART_RETRY:
         if (len >= 1) {
             sid->currblk = buf[0];
             ret = ipmi_load_readbuf(sid);
         } else {
             ret = -1;
         }
         break;
 
     default:
         break;
     }
 
     /* This should be a message write, make the length is there and correct. */
     if (len >= 1) {
         if (*buf != len - 1 || *buf > MAX_SSIF_IPMI_MSG_CHUNK) {
             return -1; /* Bogus message */
         }
         buf++;
         len--;
     }
 
     switch (cmd) {
     case SSIF_IPMI_REQUEST:
         send = true;
-        /* FALLTHRU */
+        fallthrough;
     case SSIF_IPMI_MULTI_PART_REQUEST_START:
         if (len < 2) {
             return -1; /* Bogus. */
         }
         memcpy(sid->inmsg, buf, len);
         sid->inlen = len;
         break;
 
     case SSIF_IPMI_MULTI_PART_REQUEST_END:
         send = true;
-        /* FALLTHRU */
+        fallthrough;
     case SSIF_IPMI_MULTI_PART_REQUEST_MIDDLE:
         if (!sid->inlen) {
             return -1; /* Bogus. */
         }
         if (sid->inlen + len > MAX_SSIF_IPMI_MSG_SIZE) {
             sid->inlen = 0; /* Discard the message. */
             return -1; /* Bogus. */
         }
         if (len < 32) {
             /*
              * Special hack, a multi-part middle that is less than 32 bytes
              * marks the end of a message.  The specification is fairly
              * confusing, so some systems to this, even sending a zero
              * length end message to mark the end.
              */
             send = true;
         }
         if (len > 0) {
             memcpy(sid->inmsg + sid->inlen, buf, len);
         }
         sid->inlen += len;
         break;
     }
 
     if (send && sid->inlen) {
         smbus_ipmi_send_msg(sid);
     }
 
     return ret;
 }
-- 
2.39.2


