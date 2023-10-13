Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C84357C7EFA
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 09:52:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCw9-0004Sx-Cl; Fri, 13 Oct 2023 03:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCw6-0004Om-SS
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:50:18 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCvy-0004AO-27
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:50:18 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-32c9f2ce71aso1490395f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183406; x=1697788206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YoOAm/+YqzAoYUm0iWl4CDp2UH+g6Xdk4CGXRsLOFtI=;
 b=FsBQITbqVhAIboxLcvifzZNePBXJ2YLbv23mfAnqzMsXGu62w4/eTuXT+h3yvIo92c
 siATcjMsSFDqjqTpxvvaZ7pKhI3eAEwonpxfZTHNSdA10RgW5Bo61LfE1XYTkI3mRRox
 r8GROACuL69aGfYc8WAayOB4GTwu5Apuw33/yXCEzyp4Iueea0qugwb2v+ZLfMhJafcr
 70KdlCqXPhS5+szkTpP7HEFeg1dtHOPnjyQHDFaWvLubwb8zGKYUtpR6ST3AiSXbZuPG
 h43/8ujbwEr+k+z2LosZPIcFLHUqK2yDjdwmS2a2SJtohaYarY3i7mmxwmQIIGjTPTc+
 4+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183406; x=1697788206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YoOAm/+YqzAoYUm0iWl4CDp2UH+g6Xdk4CGXRsLOFtI=;
 b=UtrqsD7BE/gfz9h4SJxaf2Ard30JnKk/wYiziZ7m4FCBDI0xS8Q4z1UbcWvi7zTnl5
 RtoNpVsCbEEVqJLS5X+H/7pLlZbvyKtNtOXuzLw5Y6XYOLnjrzFXrHPL3iGxa/LJiXG5
 Gg8ZA87uA5lS+unPyTQbhbTAzue4PYyaENYW00rJ4Rzt+hIfYpfB4Zpkk7RDPVcav05T
 LbdN2y71VnIQGLdLvPh0v7W0JlZIbILIWpKogrLT3zsbYkEu99z5kQOOXGRBB78hHZtU
 ZDfubb2SFYUMhgzu07QPEXuIZU0XI7kFuchE++iqsH+1jpAvJS3IfGXspfM2dpnwWVtc
 nBOQ==
X-Gm-Message-State: AOJu0YzpqwV4yBQd5irnxK6Ve5DIkWswyYArL0WhIBiO/suFLK2nZsbg
 FvyQpUxsK4rxiHNG9fe5zs3gPlXEZwU+6bZttQ4=
X-Google-Smtp-Source: AGHT+IFCq01vgzZaM03Sf3dHpn/JPf4sG/O9tkvKMQqKlZKJjPts+xCKiGqf+bBJHq4dDbh2MALKgA==
X-Received: by 2002:adf:f3c6:0:b0:32d:9fdc:a136 with SMTP id
 g6-20020adff3c6000000b0032d9fdca136mr283466wrp.11.1697183406072; 
 Fri, 13 Oct 2023 00:50:06 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 m8-20020adfa3c8000000b0032d7fde2d3csm7990663wrb.79.2023.10.13.00.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:50:05 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [RFC PATCH 10/78] hw/ide/atapi.c: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:47:14 +0300
Message-Id: <cef77c3b4f13c967f371d203d1aba515b05f3555.1697183082.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42d.google.com
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
 hw/ide/atapi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
index dcc39df9a4..85c74a5ffe 100644
--- a/hw/ide/atapi.c
+++ b/hw/ide/atapi.c
@@ -1189,53 +1189,54 @@ static void cmd_read_disc_information(IDEState *s, uint8_t* buf)
 static void cmd_read_dvd_structure(IDEState *s, uint8_t* buf)
 {
     int max_len;
     int media = buf[1];
     int format = buf[7];
     int ret;
 
     max_len = lduw_be_p(buf + 8);
 
     if (format < 0xff) {
         if (media_is_cd(s)) {
             ide_atapi_cmd_error(s, ILLEGAL_REQUEST,
                                 ASC_INCOMPATIBLE_FORMAT);
             return;
         } else if (!media_present(s)) {
             ide_atapi_cmd_error(s, ILLEGAL_REQUEST,
                                 ASC_INV_FIELD_IN_CMD_PACKET);
             return;
         }
     }
 
     memset(buf, 0, max_len > IDE_DMA_BUF_SECTORS * BDRV_SECTOR_SIZE + 4 ?
            IDE_DMA_BUF_SECTORS * BDRV_SECTOR_SIZE + 4 : max_len);
 
     switch (format) {
         case 0x00 ... 0x7f:
         case 0xff:
             if (media == 0) {
                 ret = ide_dvd_read_structure(s, format, buf, buf);
 
                 if (ret < 0) {
                     ide_atapi_cmd_error(s, ILLEGAL_REQUEST, -ret);
                 } else {
                     ide_atapi_cmd_reply(s, ret, max_len);
                 }
 
                 break;
             }
             /* TODO: BD support, fall through for now */
+            fallthrough;
 
         /* Generic disk structures */
         case 0x80: /* TODO: AACS volume identifier */
         case 0x81: /* TODO: AACS media serial number */
         case 0x82: /* TODO: AACS media identifier */
         case 0x83: /* TODO: AACS media key block */
         case 0x90: /* TODO: List of recognized format layers */
         case 0xc0: /* TODO: Write protection status */
         default:
             ide_atapi_cmd_error(s, ILLEGAL_REQUEST,
                                 ASC_INV_FIELD_IN_CMD_PACKET);
             break;
     }
 }
-- 
2.39.2


