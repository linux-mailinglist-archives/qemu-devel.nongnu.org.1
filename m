Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
Delivered-To: lists+qemu-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJdtIB7Mb2mgMQAAu9opvQ
	(envelope-from <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>)
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jan 2026 19:40:30 +0100
X-Original-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 333F2499E6
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jan 2026 19:40:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viGeP-0000RO-Mc; Tue, 20 Jan 2026 13:40:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGdm-0008I0-8J
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:39:51 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGdj-00063e-0p
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:39:44 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47ee974e230so45715215e9.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 10:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768934381; x=1769539181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RpgFu71iSgMMr/zkbX8X7POnwFWrfw1mWAO/J2FKty4=;
 b=PCfdDspYs9ArUXw2mpUrGApZPUbO56JQLpwD/dMmsVG1vTOfR+7gETs0P1JpTrmC/A
 XNHHo87qsUc78Pw+Woy9EaSJWxeQ8zV3ARtlmyOowbYXEeME8/+2wnWZIO8klcq2bFQk
 ktUw6MJ5TBmCvbsilGeQJdnjD/Rn2HZs9mlzE+srQ6CiAkk55kf9GD81Fci89T6nBXm6
 MGmuG34cAoFhxJZS8Af9JO2SKp5lT7/RC5a00+/PHFhOnifkQzxGBdDhegQNIxMYvVNG
 m/G7XgBuZP/7EzYwUBpCD4qyJMda4cf2DDHNrjndp5dcZb2BtWU6/y5D/AOdq1FL1AFO
 koRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768934381; x=1769539181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RpgFu71iSgMMr/zkbX8X7POnwFWrfw1mWAO/J2FKty4=;
 b=tx8pRip8arwl+1wTrVIRm3MaUr8Iv2v0bkBe0LmF7MrLRTtWf2QUlhth5m1HQlzBOi
 ro7tlqwBW27nBo8/gG1FyC/UQCtYgulnyoy+C9bNnzge5h0qZhZ2wwSOFTWiru9iGDx5
 F8movteBvqIL6Cc4H1OzsNn3yShifOYPLGwOkmS/UmBbNxKPFVc/nG0HATSS40B+THkH
 lxXjlKX6yqil6LR2kTeAh/kjkbOnTvvGkbQoyBUeHkVgi1Rf4nuodEWRClaNyBNaNmvp
 tcyxmklMsCEe5s9F0p9agTl0MmTsrkThyzyLiJW1RFoPJT5AajBnab2ulkLK62/zbhrq
 RNkg==
X-Gm-Message-State: AOJu0Yz8szGJ0PNRhxTgiKlRYhh35OHARSifMGRokCqriUCBsNihoIMQ
 Rtho2H3ikxoF8xPpK5UT48TEGdtYLoab0NBANcQWd0/zYSTp1O9VBXdwAyVHYUhBzuJU03+J7Wu
 0suVBgmk=
X-Gm-Gg: AY/fxX4vqeqRvPs1wf0vJtYTnG4NX8V3oAfJofz6GftfkjUmeDB7dRqOmnUMigwU5no
 W/FgleB/xViFNC0FxNKE/AggvobnNSSDTvNtXUtdgFOOenXo7HAdn4c3q86lMd1+O7ciRIDTyiY
 dd/axHivHsDFa1Qwt3NFon60iS+Ngz0S0TgIDIq7Dvn/I+qisblF8SbNTfLP0sECGwYkZ0qJEol
 3SGrE7okkCsrHwWbGReS6M1ooH83QLwOsT00Yy2jVJY9UP4DXKoTrU0fvpw7qajkIE+4B1jDMa1
 8ijUnDq4NVe/q9BavHtB92kFqU2PKpuN2eYLV6xcNUkB+h+XyYKExoViN/V7E5E0ndxZjbdbJoc
 ag5j1vlgWpBOlgzm33gF069LDrGnHilPxIXrw8ExooDuqDx1zdePIDonlQ5CZMsFPu/5sS52XeL
 wkIMueBOvtRFzbuwHXqIQuPrqv/extDHICMi+2RUFapCnDRYprR2SgzzA+f6jy
X-Received: by 2002:a05:600c:5299:b0:477:a9e:859a with SMTP id
 5b1f17b1804b1-4803e7e859dmr41492995e9.22.1768934381153; 
 Tue, 20 Jan 2026 10:39:41 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe6e703sm110306665e9.18.2026.01.20.10.39.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Jan 2026 10:39:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/29] hw/arm/smmuv3-common: Add STE/CD set helpers for
 repeated field setup
Date: Tue, 20 Jan 2026 19:38:38 +0100
Message-ID: <20260120183902.73845-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120183902.73845-1-philmd@linaro.org>
References: <20260120183902.73845-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
X-Spamd-Result: default: False [-0.21 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	MAILLIST(-0.20)[mailman];
	R_SPF_ALLOW(-0.20)[+ip4:209.51.188.0/24:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[lists,qemu-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:22989, ipnet:209.51.188.0/24, country:US];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[philmd@linaro.org,qemu-devel-bounces@nongnu.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[qemu-devel];
	PREVIOUSLY_DELIVERED(0.00)[qemu-devel@nongnu.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linaro.org:dkim,linaro.org:mid,lists.gnu.org:rdns,lists.gnu.org:helo,phytium.com.cn:email]
X-Rspamd-Queue-Id: 333F2499E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tao Tang <tangtao1634@phytium.com.cn>

This change introduces STE_SET_* and CD_SET_* helpers to centralize and
simplify repeated field setting logic.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-ID: <20260119161112.3841386-6-tangtao1634@phytium.com.cn>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/smmuv3-common.h | 79 ++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
index e8e7746d1fa..f644618f38b 100644
--- a/include/hw/arm/smmuv3-common.h
+++ b/include/hw/arm/smmuv3-common.h
@@ -100,6 +100,37 @@ REG32(STE_7, 28)
 #define STE_CFG_ABORT(config)      (!(config & 0x4))
 #define STE_CFG_BYPASS(config)     (config == 0x4)
 
+/* Update STE fields */
+#define STE_SET_VALID(ste, v)                                                 \
+    ((ste)->word[0] = FIELD_DP32((ste)->word[0], STE_0, VALID, (v)))
+#define STE_SET_CONFIG(ste, v)                                                \
+    ((ste)->word[0] = FIELD_DP32((ste)->word[0], STE_0, CONFIG, (v)))
+
+#define STE_SET_CTXPTR(ste, v) do {                                           \
+    (ste)->word[0] = FIELD_DP32((ste)->word[0], STE_0, CTXPTR_LO, (v) >> 6);  \
+    (ste)->word[1] = FIELD_DP32((ste)->word[1], STE_1, CTXPTR_HI, (v) >> 32); \
+} while (0)
+#define STE_SET_S2T0SZ(ste, v)                                                \
+    ((ste)->word[5] = FIELD_DP32((ste)->word[5], STE_5, S2T0SZ, (v)))
+#define STE_SET_S2SL0(ste, v)                                                 \
+    ((ste)->word[5] = FIELD_DP32((ste)->word[5], STE_5, S2SL0, (v)))
+#define STE_SET_S2TG(ste, v)                                                  \
+    ((ste)->word[5] = FIELD_DP32((ste)->word[5], STE_5, S2TG, (v)))
+#define STE_SET_S2PS(ste, v)                                                  \
+    ((ste)->word[5] = FIELD_DP32((ste)->word[5], STE_5, S2PS, (v)))
+#define STE_SET_S2AA64(ste, v)                                                \
+    ((ste)->word[5] = FIELD_DP32((ste)->word[5], STE_5, S2AA64, (v)))
+#define STE_SET_S2ENDI(ste, v)                                                \
+    ((ste)->word[5] = FIELD_DP32((ste)->word[5], STE_5, S2ENDI, (v)))
+#define STE_SET_S2AFFD(ste, v)                                                \
+    ((ste)->word[5] = FIELD_DP32((ste)->word[5], STE_5, S2AFFD, (v)))
+#define STE_SET_S2S(ste, v)                                                   \
+    ((ste)->word[5] = FIELD_DP32((ste)->word[5], STE_5, S2S, (v)))
+#define STE_SET_S2TTB(ste, v) do {                                            \
+    (ste)->word[6] = FIELD_DP32((ste)->word[6], STE_6, S2TTB_LO, (v) >> 4);   \
+    (ste)->word[7] = FIELD_DP32((ste)->word[7], STE_7, S2TTB_HI, (v) >> 32);  \
+} while (0)
+
 /* CD fields */
 
 REG32(CD_0, 0)
@@ -169,6 +200,54 @@ REG32(CD_5, 20)
              (((uint64_t)FIELD_EX32((x)->word[3], CD_3, TTB0_HI) << 32) | \
               ((uint64_t)FIELD_EX32((x)->word[2], CD_2, TTB0_LO) << 4)))
 
+/* Update CD fields */
+#define CD_SET_VALID(cd, v)                                                   \
+    ((cd)->word[0] = FIELD_DP32((cd)->word[0], CD_0, VALID, (v)))
+#define CD_SET_ASID(cd, v)                                                    \
+    ((cd)->word[1] = FIELD_DP32((cd)->word[1], CD_1, ASID, (v)))
+#define CD_SET_TTB(cd, sel, v) do {                                           \
+    if (sel) {                                                                \
+        (cd)->word[4] = FIELD_DP32((cd)->word[4], CD_4, TTB1_LO, (v) >> 4);   \
+        (cd)->word[5] = FIELD_DP32((cd)->word[5], CD_5, TTB1_HI, (v) >> 32);  \
+    } else {                                                                  \
+        (cd)->word[2] = FIELD_DP32((cd)->word[2], CD_2, TTB0_LO, (v) >> 4);   \
+        (cd)->word[3] = FIELD_DP32((cd)->word[3], CD_3, TTB0_HI, (v) >> 32);  \
+    }                                                                         \
+} while (0)
+
+#define CD_SET_TSZ(cd, sel, v)                                                \
+    ((cd)->word[0] = (sel) ? FIELD_DP32((cd)->word[0], CD_0, TSZ1, (v)) :     \
+                             FIELD_DP32((cd)->word[0], CD_0, TSZ0, (v)))
+#define CD_SET_TG(cd, sel, v)                                                 \
+    ((cd)->word[0] = (sel) ? FIELD_DP32((cd)->word[0], CD_0, TG1, (v)) :      \
+                             FIELD_DP32((cd)->word[0], CD_0, TG0, (v)))
+#define CD_SET_EPD(cd, sel, v)                                                \
+    ((cd)->word[0] = (sel) ? FIELD_DP32((cd)->word[0], CD_0, EPD1, (v)) :     \
+                             FIELD_DP32((cd)->word[0], CD_0, EPD0, (v)))
+#define CD_SET_ENDI(cd, v)                                                    \
+    ((cd)->word[0] = FIELD_DP32((cd)->word[0], CD_0, ENDI, (v)))
+#define CD_SET_IPS(cd, v)                                                     \
+    ((cd)->word[1] = FIELD_DP32((cd)->word[1], CD_1, IPS, (v)))
+#define CD_SET_AFFD(cd, v)                                                    \
+    ((cd)->word[1] = FIELD_DP32((cd)->word[1], CD_1, AFFD, (v)))
+#define CD_SET_TBI(cd, v)                                                     \
+    ((cd)->word[1] = FIELD_DP32((cd)->word[1], CD_1, TBI, (v)))
+#define CD_SET_HD(cd, v)                                                      \
+    ((cd)->word[1] = FIELD_DP32((cd)->word[1], CD_1, HD, (v)))
+#define CD_SET_HA(cd, v)                                                      \
+    ((cd)->word[1] = FIELD_DP32((cd)->word[1], CD_1, HA, (v)))
+#define CD_SET_S(cd, v)                                                       \
+    ((cd)->word[1] = FIELD_DP32((cd)->word[1], CD_1, S, (v)))
+#define CD_SET_R(cd, v)                                                       \
+    ((cd)->word[1] = FIELD_DP32((cd)->word[1], CD_1, R, (v)))
+#define CD_SET_A(cd, v)                                                       \
+    ((cd)->word[1] = FIELD_DP32((cd)->word[1], CD_1, A, (v)))
+#define CD_SET_AARCH64(cd, v)                                                 \
+    ((cd)->word[1] = FIELD_DP32((cd)->word[1], CD_1, AARCH64, (v)))
+#define CD_SET_NSCFG(cd, sel, v)                                              \
+    ((sel) ? ((cd)->word[4] = FIELD_DP32((cd)->word[4], CD_4, NSCFG1, (v))) : \
+             ((cd)->word[2] = FIELD_DP32((cd)->word[2], CD_2, NSCFG0, (v))))
+
 /* MMIO Registers */
 
 REG32(IDR0,                0x0)
-- 
2.52.0


