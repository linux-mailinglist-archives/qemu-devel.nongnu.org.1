Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E837AB348
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 16:11:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjgqv-0002vF-4R; Fri, 22 Sep 2023 10:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1qjgqm-0002u6-1X
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 10:09:44 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1qjgqk-0008P3-Js
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 10:09:43 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-31fe2c8db0dso1925941f8f.3
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 07:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1695391781; x=1695996581;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NwlBBf3rtKK44LxBF31RQ5uFpkLivnaBoZpAWCqLFCs=;
 b=yhjg11L28hHZw8onSiiyz0iJ8CTuC9ATQ7JVX+O+jlfSrNnNHbvUq0wB41HuUZbWum
 0PgNOPsR7JGcKnkSPty7wjsE04SudNyF6cDAdrinRtbYtR3ESg2xuDO+vAMtFgbOgGN4
 snf3pV7BODov6fV9MfSvwE5XGTpJm5O+77TUQYMckV+vVYzOB+cTPZ5SwjPJQi9MqA9n
 qziL7N4VqPWXohLJ5YDNHPPxp7o5zyVS73z40YmkaB/+k18JS46ELEliIP6RlVWz1riq
 Bct1ATj4vvlfmcEb9njIw4fKm8FShqTaShDBoLQR84oFwsB/F/JVJLXFgH2Q98AlaZrh
 bQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695391781; x=1695996581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NwlBBf3rtKK44LxBF31RQ5uFpkLivnaBoZpAWCqLFCs=;
 b=AfDbBmKmQCLvkPbfRkBU6FV/0lxify0JqrOCaK5fP3ZB0bF8W3W69Oy98pVY/tDLeD
 581CZHs9ForvhqTfT4LrSsGyohHtC2N9hLlhsQdvok6qEgrUTl+GfFAOedRuAnvPnxNW
 ze8f13yZ7CMij/Vah43o0IOBEld4zJ26DmJSldInjPGE853SUTJu54NLgVpQGdj5jUbl
 ftBnaTtQ6jP+ZvAPVhQZXxEghaTV1osF8YK+ig5zlJTpSvBO9SHhg/WuRbs7d/Gvx6W5
 WGfxYIGI87qck0eXNph6CAQI7SJwS+kXm/lARYo32qpHjh5Vv7PK+zK6YPftmC4N4hCU
 WxEQ==
X-Gm-Message-State: AOJu0Yw7k0cWRkFgLYnOOJObzazsfwvCMSX4BdialyOVHqZ1kZ4I0UuL
 pLEL+UzLX81G3Q0u/6CmTYQ39dYDl+x3/3QQyUM=
X-Google-Smtp-Source: AGHT+IHoBMN1jFEO04emIPxLz8c1aKi9bFLbR7D1HioY0UNIggIa6G/4kdSgIBW8PxmbAPfQoQAh9g==
X-Received: by 2002:adf:fc92:0:b0:31f:fa61:961d with SMTP id
 g18-20020adffc92000000b0031ffa61961dmr8334632wrr.63.1695391781119; 
 Fri, 22 Sep 2023 07:09:41 -0700 (PDT)
Received: from localhost.localdomain (89-104-8-249.customer.bnet.at.
 [89.104.8.249]) by smtp.gmail.com with ESMTPSA id
 g27-20020a170906395b00b009ae587ce128sm2725823eje.216.2023.09.22.07.09.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 07:09:40 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: dirty@apple.com, rbolshakov@ddn.com, lists@philjordan.eu,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 1/3] i386: hvf: Adds support for INVTSC cpuid bit
Date: Fri, 22 Sep 2023 16:09:12 +0200
Message-Id: <20230922140914.13906-2-phil@philjordan.eu>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230922140914.13906-1-phil@philjordan.eu>
References: <20230922140914.13906-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::429;
 envelope-from=phil@philjordan.eu; helo=mail-wr1-x429.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

This patch adds the INVTSC bit to the Hypervisor.framework accelerator's
CPUID bit passthrough allow-list. Previously, specifying +invtsc in the CPU
configuration would fail with the following warning despite the host CPU
advertising the feature:

qemu-system-x86_64: warning: host doesn't support requested feature:
CPUID.80000007H:EDX.invtsc [bit 8]

x86 macOS itself relies on a fixed rate TSC for its own Mach absolute time
timestamp mechanism, so there's no reason we can't enable this bit for guests.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 target/i386/hvf/x86_cpuid.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c
index 7323a7a94b..d2721bd2a7 100644
--- a/target/i386/hvf/x86_cpuid.c
+++ b/target/i386/hvf/x86_cpuid.c
@@ -145,6 +145,10 @@ uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
                 CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_OSVW | CPUID_EXT3_XOP |
                 CPUID_EXT3_FMA4 | CPUID_EXT3_TBM;
         break;
+    case 0x80000007:
+        edx &= CPUID_APM_INVTSC;
+        eax = ebx = ecx = 0;
+        break;
     default:
         return 0;
     }
-- 
2.36.1


