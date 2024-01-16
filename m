Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8346F82EF5A
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 14:03:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPj5k-0007Jf-Iq; Tue, 16 Jan 2024 08:02:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rPj5f-0007IW-UE
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 08:02:54 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rPj5e-0006gs-BM
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 08:02:51 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40e60e137aaso50477175e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 05:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1705410168; x=1706014968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l4bYg0bXuaXxvx4i4Ropz7CkhLERrz2bkP+NdBxyTx4=;
 b=LYdjH13Y+Vcof4VKOfXtFiHJ1kl+di5ei8wGJHmZJuC8FHaJ8WEfVm/rMBkQuDlqYI
 JGkvexmEd7QX9oWlTN1XLBzrQAmIy9F97+a9Z5cOl49iTOsbGCH4KDhbTPdhMA6Nbvrg
 thRmbR/Is+F85iDest76LA29SwhNQejQYO2piuvgXnAezSJlEHFWSv8zEdB367o2fC+z
 d6Qxi2ywrdEiouARiQsrOgA0h3cq2Y4c/ZtFRL1hZqjYg2juZaFB6fwHSlWfg4EeeiUE
 u8sIhKbKYTcWcizzHlDvbhNc86uGErpwyCGpUA5NkFMq3FqVTyVJqz2K0AnK6NX3pg3h
 1xkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705410168; x=1706014968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l4bYg0bXuaXxvx4i4Ropz7CkhLERrz2bkP+NdBxyTx4=;
 b=FYqBY1l8DSTOCw8RgY0ECRmkdtjZAdsHwi1L/N2ahnw7pDi3A0cwQPK1UteV65LBn5
 Kft9HW1Ko4SWTnWIEQittcdq5DVMKJEp18hrGZ9ziucpN81UPa+k5Qtx8i9OJYipRfjC
 Hxms5tVMKZq4Ql3LtzfpF5ccp8l1YrmSLSUoGX9b1jjr/hJecfDqEDeXf60ddHSb/PYq
 nVOVc4tA/DZta1Ud8GiVG9w7MhpplQPDJuSrN9U8xaKtDtMIThY72Yg8kAbEDCUlM165
 ijwjqjr7mzfUNlkTTdVMgTuU250XsUwrEj0KG+afEP8puifv7DSsL9rleyJU7rAy5Qih
 cnTg==
X-Gm-Message-State: AOJu0YyXuLcivEOX0rsmPAEiaTe9500WXKJM9vd9urrveWaH5enUthW1
 bTbMYgbzwsJirhk9QEJz1VBNsjIMTRKLFO8ci6OUhI4cBg==
X-Google-Smtp-Source: AGHT+IEOsLXla9/rlTV1zoaRBTP38OMd0nOsoTfnQn/eYGZBwfZlyJIvXTsrkU4Tb2Hw4seQ3aq76g==
X-Received: by 2002:a05:600c:45ca:b0:40e:44af:8b1e with SMTP id
 s10-20020a05600c45ca00b0040e44af8b1emr3968855wmo.160.1705410168515; 
 Tue, 16 Jan 2024 05:02:48 -0800 (PST)
Received: from chigot-Dell.telnowedge.local
 (lmontsouris-659-1-24-67.w81-250.abo.wanadoo.fr. [81.250.175.67])
 by smtp.gmail.com with ESMTPSA id
 d16-20020a05600c34d000b0040e83867d62sm2495316wmq.34.2024.01.16.05.02.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 05:02:47 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Fabien Chouteau <chouteau@adacore.com>
Subject: [PATCH v2 8/8] MAINTAINERS: replace Fabien by myself as Leon3
 maintainer
Date: Tue, 16 Jan 2024 14:02:13 +0100
Message-Id: <20240116130213.172358-9-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240116130213.172358-1-chigot@adacore.com>
References: <20240116130213.172358-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x32d.google.com
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

CC: Fabien Chouteau <chouteau@adacore.com>
Signed-off-by: Clément Chigot <chigot@adacore.com>
Reviewed-by: Fabien Chouteau <chouteau@adacore.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b406fb20c0..b4e78e7748 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1708,7 +1708,7 @@ F: hw/rtc/sun4v-rtc.c
 F: include/hw/rtc/sun4v-rtc.h
 
 Leon3
-M: Fabien Chouteau <chouteau@adacore.com>
+M: Clément Chigot <chigot@adacore.com>
 M: Frederic Konrad <konrad.frederic@yahoo.fr>
 S: Maintained
 F: hw/sparc/leon3.c
-- 
2.25.1


