Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E79B5831B1F
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 15:11:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQT6D-00058h-QO; Thu, 18 Jan 2024 09:10:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQT6B-00057j-DA; Thu, 18 Jan 2024 09:10:27 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQT69-0000u8-54; Thu, 18 Jan 2024 09:10:27 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6da4a923b1bso6770747b3a.2; 
 Thu, 18 Jan 2024 06:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705587023; x=1706191823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vzpd9gv/kIdWlDpyR0UgDjKHHsa/fTE6O8y5VckY0X4=;
 b=H0gWoTYwhMaSnn1C/kUEO2nScUsMuaCeEpBAUiuf+3zzaqdbnedLq80bBBWSgV3PS8
 0IpFyzseLgxXDNArfEZuKRlmHxR8IZWLENOoVHRt+RfYBC5gXKng4hPCaJ0GeqyoqvD3
 plQ2R88xvqK654g37MHjNp8w4EEEFK4cyE2SefsDZEXC+JlW3Mp4lEQSt4TMJ2AAeytd
 8Td1CT+eIZ/txHHEQjBFXyqX/2mYXDEevH2qBnIMznyntsrxzP6fX8a6lpf1fs23tpqZ
 OGIlVw6ith3U5CbAe5CmUGkTpMPptChAu/+UPlrqKAvaf1rLhbBlUCvVyZ99HCbag7ha
 fgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705587023; x=1706191823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vzpd9gv/kIdWlDpyR0UgDjKHHsa/fTE6O8y5VckY0X4=;
 b=GpQJhxOuBIP9ARRYBenRjWhl4SWZKd2Wv9cb8Oj/+eDo6nrlnGOaFhjIx57cHReCe1
 Du3jj5jSZe1jSf5B+MrgViKf9juD1to+1/3sATJsXDqchjrP4b5FPOJkdY48XyMCSX4S
 moSKMhKspDb7MeNl/aX+RziKqbHehDQFLX2SnTH/EzlYJmkmj91vQX+pWP4KFzYJjx8L
 3RX+oIbwt+6IaF0U+5hO+UqM/+HBIntwunEF13NbUqW5l2dls5MAzRhvCaEUOpN8elNl
 Mx566Xi2sRs9FyDdNgeLMJEisM6zZDv52dNF/ojHQNbPV89AJLgH1FX+aL3IWcSzMD0x
 KRNg==
X-Gm-Message-State: AOJu0YxuJCi5dm1t+WwQ+EhyfUPfAMTYbq785OthCXuJ165aj6kEv9Mp
 Hi2GKTnPUQ0b+nGlpCpL43owtpgIocxIXnDpH9SfbXfHrSsM772IUA7YZsCv
X-Google-Smtp-Source: AGHT+IHV00uMGJoAmoYa50eJouruBXTCymZDG15r2WAImchsC1uGTM2CJA/0D3A/NqEtXn1G24iO0g==
X-Received: by 2002:a05:6a00:194a:b0:6d9:b293:115c with SMTP id
 s10-20020a056a00194a00b006d9b293115cmr968738pfk.11.1705587021849; 
 Thu, 18 Jan 2024 06:10:21 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a62be12000000b006db3149eacasm3323336pff.104.2024.01.18.06.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 06:10:21 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 4/8] ppc/spapr: Adjust ibm,pa-features for POWER9
Date: Fri, 19 Jan 2024 00:09:38 +1000
Message-ID: <20240118140942.164319-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118140942.164319-1-npiggin@gmail.com>
References: <20240118140942.164319-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

"MMR" and "SPR SO" are not implemented in POWER9, so clear those bits.
HTM is not set by default, and only later if the cap is set, so remove
the comment that suggests otherwise.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ce969be770..1e1946de59 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -248,14 +248,14 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
         0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /* 6 - 11 */
         /* 16: Vector */
         0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 12 - 17 */
-        /* 18: Vec. Scalar, 20: Vec. XOR, 22: HTM */
+        /* 18: Vec. Scalar, 20: Vec. XOR */
         0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 18 - 23 */
         /* 24: Ext. Dec, 26: 64 bit ftrs, 28: PM ftrs */
         0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 24 - 29 */
-        /* 30: MMR, 32: LE atomic, 34: EBB + ext EBB */
-        0x80, 0x00, 0x80, 0x00, 0xC0, 0x00, /* 30 - 35 */
-        /* 36: SPR SO, 38: Copy/Paste, 40: Radix MMU */
-        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 36 - 41 */
+        /* 32: LE atomic, 34: EBB + ext EBB */
+        0x00, 0x00, 0x80, 0x00, 0xC0, 0x00, /* 30 - 35 */
+        /* 38: Copy/Paste, 40: Radix MMU */
+        0x00, 0x00, 0x80, 0x00, 0x80, 0x00, /* 36 - 41 */
         /* 42: PM, 44: PC RA, 46: SC vec'd */
         0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 42 - 47 */
         /* 48: SIMD, 50: QP BFP, 52: String */
-- 
2.42.0


