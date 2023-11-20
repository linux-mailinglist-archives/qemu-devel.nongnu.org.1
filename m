Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 034307F16D9
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 16:11:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r55tg-0006LZ-76; Mon, 20 Nov 2023 10:09:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r55tR-0005tj-Ho
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:09:00 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r55tG-0001Hr-8n
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:08:54 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50943ccbbaeso6230384e87.2
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 07:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700492922; x=1701097722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MdYIuvPCwbs1/SkyidzDPaAAsnYLQJ1SQQvqDWTDjY4=;
 b=m6JTyB23Uz+26G2fTIGU0iRylMm+0RbjDkZiSu4MHuUs4PEPVq6/AF1fo/17ljRStr
 /+feY3oSx9RMbbT1U7eYjWKZp15GSilihxT+tSdlTo4UmiCQRdnGYpPR7fZGSW38z17n
 ldEoR3IAZ+rsTjFUkSikOJKGDvNyaAA2ZkeY9otPRMjbWk/xBtxbDKCmZ0LdXLk67UlL
 5sf+5wVJfrqkkL+15p/2CLA9pfgBYtoLmmva/mkkjigI+EgyAYTkIFpZPSfTsS2Cw4Hh
 dImMv+qDYL+lSKVBlMN5EITeqnVzHp7tCVqZdqGcT70LF9fqw/W1BM/j2flIbMmD7YSo
 aUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700492922; x=1701097722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MdYIuvPCwbs1/SkyidzDPaAAsnYLQJ1SQQvqDWTDjY4=;
 b=M2XZTvNk2pfO0AllhUfNEG47fGfb0Z2qyE9FXPDQGq/L2UvYu3rHLnTkH+YH4isQlt
 9G4uDpKKN3I/Rm/5HCRe7tCJi3dEu10NMikAT4puYxboUdBXcMJ/EpYE03434wd+Nuvu
 cRWfcb7Bzu8DANjqY/WgPozaTtrmZc/K7wLnq2tDXUYMGcdehQ6PszB3/b5ztQIKQwGy
 1VRoQTNfWKBoOXHHFJEtmmzTSG0UxuVrx2MRU1xtAisZM0s4b+4trnS3Pdc03Mt+UdG0
 mj8JO8mLHAAT8AxgRZVdonWtcBkpt03DstU6ycRoxVlfhW7tlGuL2MDX7UntCwK5Mh1a
 jB0g==
X-Gm-Message-State: AOJu0YzTnXwUeBijo6Bi3AA/ePOsn72uuzRg4KKwE/U82x4KYRO9HzSt
 sZqmjPpy+l6/bMjruan7yEkqig==
X-Google-Smtp-Source: AGHT+IHGOkrx0KapVhaxqiUy8V1IlL2HM4IzeBDQH/UBvJi7eaZoPYIvqDtpZNvM6TAVX1cDEkEiYQ==
X-Received: by 2002:ac2:4469:0:b0:509:e5a4:2b03 with SMTP id
 y9-20020ac24469000000b00509e5a42b03mr5760174lfl.13.1700492922721; 
 Mon, 20 Nov 2023 07:08:42 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 e29-20020adfa45d000000b0033169451a84sm11501414wra.29.2023.11.20.07.08.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 07:08:38 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CD30865777;
 Mon, 20 Nov 2023 15:08:34 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-s390x@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Marek Vasut <marex@denx.de>,
 Thomas Huth <thuth@redhat.com>, Chris Wulff <crwulff@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 09/14] hw/core: skip loading debug on all failures
Date: Mon, 20 Nov 2023 15:08:28 +0000
Message-Id: <20231120150833.2552739-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120150833.2552739-1-alex.bennee@linaro.org>
References: <20231120150833.2552739-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x136.google.com
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

ELF_LOAD_FAILED is one of many negative return codes we can have. Lets
treat any positive size_t as a success for loading.

Message-Id: <20231115205542.3092038-8-alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/core/loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 3c79283777..e7a9b3775b 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -505,7 +505,7 @@ ssize_t load_elf_ram_sym(const char *filename,
                          clear_lsb, data_swab, as, load_rom, sym_cb);
     }
 
-    if (ret != ELF_LOAD_FAILED) {
+    if (ret > 0) {
         debuginfo_report_elf(filename, fd, 0);
     }
 
-- 
2.39.2


