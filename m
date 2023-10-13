Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 040B77C80CD
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:53:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqo-0001bH-Hj; Fri, 13 Oct 2023 04:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqc-0000zQ-2R
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:42 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqU-00016U-1P
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:41 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-32d9cb5e0fcso342170f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186912; x=1697791712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V3qFECiL29XF5h8iKL/j7sOru8slcdx32x/ROXDZUac=;
 b=bYqtIK/Ta2vWMFfBa4Q1yipfEkEXfQTc8UOWQB6Uamp+A+yKNWReB7CJ7g/mwM/xzd
 j1Nak4+hfsFxb15My1kpFZrZ66GQgA08k/PxVSmuj8y4V7kIcblzJT++55rnrl+j3kGP
 z97Mk9JQ/Z2Z7gWCAQ3VI1Cnzdh51qgYsJFabCTUnfUCrAddEwhGnC+a1kS/spz2WqsN
 Nxq4LIo/EISKosSRBwf79Q3pnRI0yTGZ44e1tM3kb+k3JpJxvxcJOX02vxdrYgP7XVpn
 JzCLnBYW6OOZyL/HyJVsIBsw/XeCcB/qNjoPkH9mUNr+xb5qPhF+EyyhIIbHm+VH/Ura
 1j+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186912; x=1697791712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V3qFECiL29XF5h8iKL/j7sOru8slcdx32x/ROXDZUac=;
 b=pbvpGbTmEAVa2iIWOvC9oDISo9DBIqUP2mfg8lgRYw5Vqgdkfjv4/kIBDQe0iJuxhy
 kOQzGs3lRqKwjhDMEK0TfeUiRtHrwNa78ILEgdg4nee+k03zRWcMz+Ecr1ER8LHX2W1U
 mOyopzYuxRpT/ET+QGfXbo+OAd01BudbPsg0S+n7HQ7IBd3SXaUzjp6ll+X428PfFBGl
 uQwXTmS0YR9gqKw6SPmLivIzmsRw/G/jQZU1/3UML5rvhE78XZYlW0coFp90+ICQttM1
 3Q+wLTjiI1QpS9jqvmQ76sY2Osx0VD1AoogLl+m0fj+mihRFZMVjis2KBCynkqhJOGYb
 IEVA==
X-Gm-Message-State: AOJu0YxbVf6xDc0fwtjPPYCUZHHwxslZkvtpZpMFCTd/xcwjR0QQBsar
 YjL8pZBEYHk/M7ZMORURH/D0S+nJQ/wALWexM9I=
X-Google-Smtp-Source: AGHT+IHm8H+xCHlf1yPi/Zuj3MXspqCb16kwTv/o0+IYj0/qMTsq1G/3aiAz2blW1E6bdC73xpkkOg==
X-Received: by 2002:a5d:4b48:0:b0:317:d048:8d87 with SMTP id
 w8-20020a5d4b48000000b00317d0488d87mr20892735wrs.61.1697186912468; 
 Fri, 13 Oct 2023 01:48:32 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:48:31 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [RFC PATCH v3 47/78] contrib/rdmacm-mux: add fallthrough
 pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:15 +0300
Message-Id: <56f673960f1e05963f5dbfae95743c54ee5383f1.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42a.google.com
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
 contrib/rdmacm-mux/main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/rdmacm-mux/main.c b/contrib/rdmacm-mux/main.c
index 771ca01e03..dda6917d58 100644
--- a/contrib/rdmacm-mux/main.c
+++ b/contrib/rdmacm-mux/main.c
@@ -342,16 +342,16 @@ static int get_fd(const char *mad, int umad_len, int *fd, __be64 *gid_ifid)
         break;
 
     case UMAD_CM_ATTR_REP:
-        /* Fall through */
+        fallthrough;
     case UMAD_CM_ATTR_REJ:
-        /* Fall through */
+        fallthrough;
     case UMAD_CM_ATTR_DREQ:
-        /* Fall through */
+        fallthrough;
     case UMAD_CM_ATTR_DREP:
-        /* Fall through */
+        fallthrough;
     case UMAD_CM_ATTR_RTU:
         data += sizeof(comm_id);
-        /* Fall through */
+        fallthrough;
     case UMAD_CM_ATTR_SIDR_REP:
         if (unlikely(umad_len < sizeof(*hdr) + sizeof(comm_id))) {
             rc = -EINVAL;
-- 
2.39.2


