Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8605DA9760A
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Apr 2025 21:51:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JR6-0001I3-6d; Tue, 22 Apr 2025 15:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLh-0000fs-E1
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:07 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLb-0006ch-To
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:04 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-227d6b530d8so58374775ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350317; x=1745955117; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BoCYXpmxTadp3XapZ6TJFD3hsb+jhxzWsNPz+aVP0mI=;
 b=Tzhw8rV1VZT81rseU4N0/CkDeCUE3iZtvSQpLmZZAFb6r2h2aishWrQFW9I4gYz0Yx
 PR1LSjylz13hyQzMTfBW/8YVFWSCLw6ezMPbZIBnHojzjkBWvGcbUa3nWXEbNuLBNHGz
 Hvocy3gNgg6N5kzBK7aJgiD/xiIet2I/1PcWwL64T6BFRgrv+755MJPJK1a5vmw4a/AS
 LbNcKwPl71JZ6hwJ0dBgVghxv0Iq+bIQIw3oO7Ct5OHAAOql6RZUzXIP9cDxAI/Q3cio
 dRkEsdpHXEst3IuUs+BnN/l6VWATo4wg1PFusP9/R93PjOs0eScM+Ot85zhErZnCh4N2
 RFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350317; x=1745955117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BoCYXpmxTadp3XapZ6TJFD3hsb+jhxzWsNPz+aVP0mI=;
 b=IQAEDvmuWGo2G45YvtLaj/aWVFlnVDXVj1TeoTUHWIevJKgpBCujjDCmRaY8ET8lbN
 zE16uU5axeM2SKuAWR0AhYM5+ucvQ9/CsSZKCB0z1J5538QlGvUZZ9HATRI6cuMC6CwV
 9Rl3zEl7phyyHPUsisxjpE3JRV+02GBzMoEjC8yD8eGribzpO1TP7xT0QXqiGAV5w9uU
 88uax9jmRcntJwaPmldP3XUVVSlWJN0nQhL8g99s8LD3r5UFEnvHVrq1Jx9Zwfc0cqQA
 gMLtOz5hWqaItqBYwEH07CFFewT3ocJ/zjgjXxBarWCDQ/ux5ldIy6EiefJP7e8f8Rzy
 yFLA==
X-Gm-Message-State: AOJu0Yx/Sn4fHSehpzoKAqTT/lh+D3dwPwCYN7udk7BrX++WhN+MltgX
 uSiqbhzTgrsP0yXaXgyz/oRLeG2q2cLW49CGmbPUEB4GHoOMRj0WShtLVWVO4428C/h4XbeTlX9
 g
X-Gm-Gg: ASbGncscakFSEbuNIPATDoouiRP0J3FLu3fIDTsa2C6KSm3VCUneh8DcoxsFSR9lzwa
 LorW20TTEuIQ4hfjSOJsVcJVPHAKNG0m/ubmCSas3WIldIXu3r3h/VrlbWFTZuVBW1RHtMvPUsK
 7j1Kmk3A1vUT/Ihn/4QYkAhdalt1Cc0B/AsZBUbU3XCzD9CmN9SjeSjdbN54IW0d7B5gLQAf+dd
 h65XhfYyxUtRfh430C7PkuxkEbeIS1VlsfBZGPn1sG5ls2Mn7eRNk1jW9nlfhqDpxHv0lnIB9cx
 HSFziuXzjiWvDhFydGFYcFKJcKs34bdyaeqHLNY9X3gAScoWvz/gDGMaGDArG+Ls+Ls1g+SOKCW
 vSJQZe2lL1w==
X-Google-Smtp-Source: AGHT+IGytOSzE39M6wuHRJfpbJwRfmWFee/iQzjpKNry0zQgeAi4DtPzAIWLzjW6mdTTmtvcn3Bo0A==
X-Received: by 2002:a17:902:ced0:b0:224:26fd:82e5 with SMTP id
 d9443c01a7336-22c536272b1mr249454495ad.48.1745350317117; 
 Tue, 22 Apr 2025 12:31:57 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdda3bsm89312635ad.27.2025.04.22.12.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:31:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 055/147] include/hw/s390x: Remove ifndef CONFIG_USER_ONLY in
 css.h
Date: Tue, 22 Apr 2025 12:26:44 -0700
Message-ID: <20250422192819.302784-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

We were hiding a number of declarations from user-only,
although it hurts nothing to allow them.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/s390x/css.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index cd97e2b707..965545ce73 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -238,7 +238,6 @@ uint32_t css_get_adapter_id(CssIoAdapterType type, uint8_t isc);
 void css_register_io_adapters(CssIoAdapterType type, bool swap, bool maskable,
                               uint8_t flags, Error **errp);
 
-#ifndef CONFIG_USER_ONLY
 SubchDev *css_find_subch(uint8_t m, uint8_t cssid, uint8_t ssid,
                          uint16_t schid);
 bool css_subch_visible(SubchDev *sch);
@@ -262,7 +261,6 @@ int css_enable_mss(void);
 IOInstEnding css_do_rsch(SubchDev *sch);
 int css_do_rchp(uint8_t cssid, uint8_t chpid);
 bool css_present(uint8_t cssid);
-#endif
 
 extern const PropertyInfo css_devid_ro_propinfo;
 
-- 
2.43.0


