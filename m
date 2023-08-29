Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D5778C978
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 18:17:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb1Nk-0004uk-0X; Tue, 29 Aug 2023 12:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qb1NU-0004nH-G9
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:15:40 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qb1NM-0004OH-DD
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:15:40 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fefe898f76so45071975e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 09:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693325730; x=1693930530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iiC7cvPGqtDwu4nVf8eS+Cmc1lWchz2oWST+0j9UI/U=;
 b=AxZnMkqnTdFfPhoc8pKiUmrB9AxxnzwWR+eetooDI0+GxpNyCaM0orLmp+0u2QMzmg
 7liHZyijK/5Gwrcie/qY3QrSTCgKGNuIkyvSpEI2BBGH/KEvzl+deEKTig4wxWa5UF6h
 jD6YMbSm8qx1QlPx09Wp7YQqVUrD0BYvAjaOT1JTeTuEs3HwdYR6g2ramsSJawt0kTYL
 7XX7D0pvHBSW5pzVjgnciMe0RxJBiwaObjC8AkeTivWD+tYZlgE2KI5RK155hxbmppzq
 A/h76wJ0GbrhPDlfR8eiTy3rmHmMhfIQupIgyCAFbjb3jzRznaCRUaOYf8LOwQRGR/qM
 jLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693325730; x=1693930530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iiC7cvPGqtDwu4nVf8eS+Cmc1lWchz2oWST+0j9UI/U=;
 b=L4uyRdW4wIcHpkF1I/NlVv1qFo5Aj4z17kzazdAl1FT8tllffH4PymmWKQr9i6OL0q
 xxDnDz3eRDQM/jreX2ZWB/u84TbCe+k3tTRgJX2YvckuPuZYlItfLZM4IEZJRf2AxRCD
 htcMNYdB1ZJJNrEXoM1ZLg6QQovlJ/mhvq+uwFdlyNX/L7rqFYq5ReLzCJPKGeZRWokJ
 eYu9SHycd0jdUblrMbmGve7gsy4MKTmZWLkKBskCrR8gCAthh6iABGfykq9aan2t7q2c
 daGQs4wteuQq/BbZlwgNZSGrNAQGp+IOkbNZ+9V32Y8l2U+RZdYZrSNDl/mS2qO68SYx
 9KBg==
X-Gm-Message-State: AOJu0YxLRICE26yNjjTQzj2uDwCbxcRmiy/BN5/qABzXbUBpjsl7C7gp
 SraXGVRSi3dInBRna3K3Yat7rA==
X-Google-Smtp-Source: AGHT+IF7UUc6/x2VJ3X2eskj0/McdSfyEB4xEBcpeDnHceEXs0kpCeLAzcslpKxllXd80+x+lFCvtA==
X-Received: by 2002:a5d:6282:0:b0:31a:c6ef:5edc with SMTP id
 k2-20020a5d6282000000b0031ac6ef5edcmr19002628wru.12.1693325730643; 
 Tue, 29 Aug 2023 09:15:30 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 l4-20020adff484000000b003197a4b0f68sm14357588wro.7.2023.08.29.09.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 09:15:29 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A70E91FFBF;
 Tue, 29 Aug 2023 17:15:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-arm@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Juan Quintela <quintela@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 04/12] docs/style: permit inline loop variables
Date: Tue, 29 Aug 2023 17:15:20 +0100
Message-Id: <20230829161528.2707696-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230829161528.2707696-1-alex.bennee@linaro.org>
References: <20230829161528.2707696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

I've already wasted enough of my time debugging aliased variables in
deeply nested loops. While not scattering variable declarations around
is a good aim I think we can make an exception for stuff used inside a
loop.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230822155004.1158931-1-alex.bennee@linaro.org>
---
 docs/devel/style.rst | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/docs/devel/style.rst b/docs/devel/style.rst
index 3cfcdeb9cd..2f68b50079 100644
--- a/docs/devel/style.rst
+++ b/docs/devel/style.rst
@@ -204,7 +204,14 @@ Declarations
 
 Mixed declarations (interleaving statements and declarations within
 blocks) are generally not allowed; declarations should be at the beginning
-of blocks.
+of blocks. To avoid accidental re-use it is permissible to declare
+loop variables inside for loops:
+
+.. code-block:: c
+
+    for (int i = 0; i < ARRAY_SIZE(thing); i++) {
+        /* do something loopy */
+    }
 
 Every now and then, an exception is made for declarations inside a
 #ifdef or #ifndef block: if the code looks nicer, such declarations can
-- 
2.39.2


