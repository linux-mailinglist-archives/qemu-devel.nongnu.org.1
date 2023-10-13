Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F597C7F56
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:04:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD6T-0003cW-Rw; Fri, 13 Oct 2023 04:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5n-0000gG-Su
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:00:19 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5l-0007mj-8j
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:00:19 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5041bb9ce51so2315689e87.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697184015; x=1697788815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VUr7ma9/URcW12PwoU86CMS0D0tvRcZTYVEP0u5I3rQ=;
 b=txSF8WUN2c6eW6y3Eh4741PAnkEMuy4X6SDZdZ4Ot1dHyFxxKmbCLT1zOF/NrGiNrC
 43ncDUIv6OyYogCSdPNA9hPEHkifXxaE0S4tbHM7pukXdGHhml7M0EaFnPKAXV0oFB12
 3CwTUHiB0ZCogOoX7PB+tblVt/Cp83AOib7To4cx7pmBr8zTnsPS31WQ4E2FcK+cm8Pp
 IBfpfqtibf958476ps82r/wnlI+no6O8sWXipB2KBfU/AQHWUP/T2azCnvj66WCjDVV6
 muElj3PpIrB8p6G0jHY85NXfTn9j6WMLftMhR/qYHyGRSeeg0feyai3k65+Jy94/5i+w
 dplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697184015; x=1697788815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VUr7ma9/URcW12PwoU86CMS0D0tvRcZTYVEP0u5I3rQ=;
 b=IgTrmSzpzLqA6iBm8y6zJWEv8iFzVFGx7GW/GcS3utGt6dXvJxa3T9/txWLuvEGeUA
 6DkEiY2n2g9dh7q/IiPUPpTAo2d7AnpBZ578Zug2WVzUgKDHMc9ocLkbpl2jVvB9CkIJ
 gW6eZ0cOVcPbXesLZKAAlcmS3BgV4mh49A2gm3k9Ic/PiRU/8w8isi3A5V6B1tHRye8K
 IAhEHGH3z9dWrcxBrmJ4mxWxJGNn/U/8/9+OCYnzXBaU5OBK+eTnAVLNPloJDP0yCex0
 WPmEHT/ydx1NekLEHeWDwzu28QcR3RztjdmvQbEpMCnVmBjl+XMyju1wcsuTKMYupdQ/
 BfkQ==
X-Gm-Message-State: AOJu0YxDoXZpGKvv/tlR43mCpdR1PYE0K2XHfbFxsLVOBjUxqyojR4O2
 HMTqA/z3lAsdMUL5u1T4mhUSiIZ9/zWkKUb6s2k=
X-Google-Smtp-Source: AGHT+IGAwAPjt5MDy7jTxRx86MHoZdUrsSWRRN/PsQ2xaq5LUlP4jZ2W0iZUSLu/PWp+cTg7q3l3KA==
X-Received: by 2002:a05:6512:3051:b0:500:7696:200 with SMTP id
 b17-20020a056512305100b0050076960200mr27330958lfb.59.1697184015131; 
 Fri, 13 Oct 2023 01:00:15 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.01.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:00:14 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [RFC PATCH v2 77/78] tests/unit/test-char.c: add fallthrough
 pseudo-keyword
Date: Fri, 13 Oct 2023 10:57:44 +0300
Message-Id: <92c0d221dab341363cf85f8e7526e32cfc048ff0.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x12f.google.com
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
 tests/unit/test-char.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/unit/test-char.c b/tests/unit/test-char.c
index 649fdf64e1..6f5a2c4108 100644
--- a/tests/unit/test-char.c
+++ b/tests/unit/test-char.c
@@ -56,25 +56,25 @@ static void fe_read(void *opaque, const uint8_t *buf, int size)
 static void fe_event(void *opaque, QEMUChrEvent event)
 {
     FeHandler *h = opaque;
     bool new_open_state;
 
     h->last_event = event;
     switch (event) {
     case CHR_EVENT_BREAK:
         break;
     case CHR_EVENT_OPENED:
     case CHR_EVENT_CLOSED:
         h->openclose_count++;
         new_open_state = (event == CHR_EVENT_OPENED);
         if (h->is_open == new_open_state) {
             h->openclose_mismatch = true;
         }
         h->is_open = new_open_state;
-        /* fallthrough */
+        fallthrough;
     default:
         quit = true;
         break;
     }
 }
 
 #ifdef _WIN32
-- 
2.39.2


