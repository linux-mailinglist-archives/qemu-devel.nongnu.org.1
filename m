Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CDA70D1B3
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:48:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I2x-0004Cd-22; Mon, 22 May 2023 22:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I2k-0003ek-6b
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:46:35 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I2i-0004lF-Nk
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:46:33 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-25394160fd3so2446099a91.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809991; x=1687401991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KVTdacy49FyA+FuVA6oM99mQ+R5qExpSHtdv66+gor4=;
 b=BPmmCfq7Xuf8+WE/Rbl6H+s7qCEHHgKjf+wQI5rEddR/q2o30FHzZ6suomhGD6YScE
 8QeVAPKr/hJsvS6pl47NzescZxsexFer46Iu+VBwDkx/U4ABrvN5uj2qCskbxCGAZsVv
 yWFFkQ6WubZh/Y/DT+RWfS7WmOJZ1tlpfurXYM7dFf2sXrH87Dh91Phhw0nmpe7iQHB1
 rIRLvGEn2FUlEaEZaRKvf99qbp8ro833OrkwRov5k9up4oUOrFfP4HdqdObUZ1XB4jqX
 h0yfjVTvQtNtCWdGP4lSaW40l0wFDeQIgTVEzMiOejxokI9NRkZOAe5/SdmN7XYPNVw8
 783Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809991; x=1687401991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KVTdacy49FyA+FuVA6oM99mQ+R5qExpSHtdv66+gor4=;
 b=aTsP9vmWw8QWx3pkOc0uZn5vajlKkFI5TO/iA9AEq3Wibwg88Aab550126FVr4qc7L
 YIdmTjiRJAUB21Knt4Cv/Thv1PtvX+lp1IYcj3O7AEghd+toJC4nEBGlAVtK8KYSs8UF
 A7hZdXGZIfHedjOGJGvIqYTw+jCXF8l5Dsmbxs5p2fzzgB5kh1bsFAliIsPMjdadYmKe
 hwh+MuNIFCUbnexOd5RxEHkoSulaub/8z3ngpQLvpWTP3zWv+sjk01CpTBDsU33WUmDU
 ybbYIGHhY7OAEsRwz6RmyJ50IyawyIU25GLlPAYh9MoV5w8owVIsq+ALNa+TlxhIoO8z
 8PFQ==
X-Gm-Message-State: AC+VfDwWuXLPVG6eNxEvTAQzKlX15N6GkOGnC2gatHQpth0FR+ip/gjZ
 +ORwrokHFZUtI4wFA55xDOgVqA==
X-Google-Smtp-Source: ACHHUZ7qpMWMoGsG4MzU72EBQxa0dalFyDTa0J+cts5vgEzT58hzGLU1oz2eB0xukssbRGZK3PCJag==
X-Received: by 2002:a17:90a:420b:b0:24c:5e6:7035 with SMTP id
 o11-20020a17090a420b00b0024c05e67035mr11649478pjg.30.1684809991625; 
 Mon, 22 May 2023 19:46:31 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.46.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:46:31 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Tomasz Dzieciol <t.dzieciol@partner.samsung.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 47/48] MAINTAINERS: Add a reviewer for network packet
 abstractions
Date: Tue, 23 May 2023 11:43:38 +0900
Message-Id: <20230523024339.50875-48-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

I have made significant changes for network packet abstractions so add
me as a reviewer.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c31d2279ab..8b2ef5943c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2214,6 +2214,7 @@ F: tests/qtest/fuzz-megasas-test.c
 
 Network packet abstractions
 M: Dmitry Fleytman <dmitry.fleytman@gmail.com>
+R: Akihiko Odaki <akihiko.odaki@daynix.com>
 S: Maintained
 F: include/net/eth.h
 F: net/eth.c
-- 
2.40.1


