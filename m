Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3E1745DC0
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:51:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJrL-0007qt-7X; Mon, 03 Jul 2023 09:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJr5-0007Te-Sc
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:44:40 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJr2-0005gs-Q3
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:44:39 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4fba74870abso4370983e87.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 06:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688391871; x=1690983871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FeBR8GZv3DfL2Dr3RQS42VRWnzI9QYt8QP9XGBKiFno=;
 b=vBhGM3LDh0qLDyoo3KAZQBLhM8IIL12ObF4VI/Mh4kkw50DVCgumZlC12xvyw86No+
 IQAHG7FsH+XuwFUgyMCRZ8hom3oVemicGeUIfRZMKOLgj4c4noPlRxfz2BlMQe5udcNs
 cSZ/YKUVUqWMI6N4LYDmmO1XikwVUnPEQGklHHH+whJg2ES+JA8SulPumJaRu39RY2sc
 n8hsaJuU7xdU6mtQJFXo8JZw8sAFzNjRvtSUMqWaEG+KTzBYVGUXq763mi5itNHg+jnR
 tWmS5A2hV659APMMauYm6MYqnK/c3hUHayCxfRDdywJAxyEse4dY5SQZarMs4KQSwLbJ
 Dtgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688391871; x=1690983871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FeBR8GZv3DfL2Dr3RQS42VRWnzI9QYt8QP9XGBKiFno=;
 b=YJqpYr4bLQRbnKLsIb2h1EIOgR07q5HTnk15duxLYW6N70wHEUsc+4EcvwBL9qHmq3
 QhDFGxODOuS0e6vHv5M8NReZ/X9+iTlKAKdWnBDR0OJHKb/IQkLk963ukBGjomh2HEeN
 P+a3viDtZBx07iwah03zBBDjP1/eFkRCaHx/0Bdvq6M1YRUQRrDrMNDKDZdwVKPQ+hlX
 VcyY0kadsKy3N9S92XNDb1G7GmWSY9JoCBQAb8bDqXR3F1bmhmiJKAMjjcg12HPRtCrb
 5CrCd2K/YZbxYdsmrbAB6qSUDxMZ4PnPKRD/o1W2ruwIywQMjhtBnqwOj9SXOhFOLxOj
 fABA==
X-Gm-Message-State: ABy/qLZIthBe/WmIANn0WCuYLd5PE4CxBfIOlL9iIH39kmlQgBqTbVj2
 C0nClGDRSNX8XgGUvOSzDHSNww==
X-Google-Smtp-Source: APBJJlEmPlZUBMbbZobnayJLhxoLMovPHCicGNFCXwUkIYxzGF9Q46n3jE5jl3l+CI3QFLciWl0Ipw==
X-Received: by 2002:ac2:5f9a:0:b0:4f8:5717:e41b with SMTP id
 r26-20020ac25f9a000000b004f85717e41bmr6062949lfe.41.1688391871359; 
 Mon, 03 Jul 2023 06:44:31 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 b17-20020a056000055100b0031434cebcd8sm3760582wrf.33.2023.07.03.06.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 06:44:30 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8D4CA1FFC2;
 Mon,  3 Jul 2023 14:44:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Bulekov <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Darren Kenny <darren.kenny@oracle.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>
Subject: [PULL 07/38] scripts/oss-fuzz: add a suppression for keymap
Date: Mon,  3 Jul 2023 14:43:56 +0100
Message-Id: <20230703134427.1389440-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703134427.1389440-1-alex.bennee@linaro.org>
References: <20230703134427.1389440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12e.google.com
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

When updating to the latest fedora the santizer found more leaks
inside xkbmap:

  FAILED: pc-bios/keymaps/ar
  /builds/stsquad/qemu/build-oss-fuzz/qemu-keymap -f pc-bios/keymaps/ar -l ara
  =================================================================
  ==3604==ERROR: LeakSanitizer: detected memory leaks
  Direct leak of 1424 byte(s) in 1 object(s) allocated from:
      #0 0x56316418ebec in __interceptor_calloc (/builds/stsquad/qemu/build-oss-fuzz/qemu-keymap+0x127bec) (BuildId: a2ad9da3190962acaa010fa8f44a9269f9081e1c)
      #1 0x7f60d4dc067e  (/lib64/libxkbcommon.so.0+0x1c67e) (BuildId: b243a34e4e58e6a30b93771c256268b114d34b80)
      #2 0x7f60d4dc2137 in xkb_keymap_new_from_names (/lib64/libxkbcommon.so.0+0x1e137) (BuildId: b243a34e4e58e6a30b93771c256268b114d34b80)
      #3 0x5631641ca50f in main /builds/stsquad/qemu/build-oss-fuzz/../qemu-keymap.c:215:11

and many more. As we can't do anything about the library add a
suppression to keep the CI going with what its meant to be doing.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230630180423.558337-8-alex.bennee@linaro.org>

diff --git a/scripts/oss-fuzz/lsan_suppressions.txt b/scripts/oss-fuzz/lsan_suppressions.txt
index 02ec0a6ed5..7d90c280d0 100644
--- a/scripts/oss-fuzz/lsan_suppressions.txt
+++ b/scripts/oss-fuzz/lsan_suppressions.txt
@@ -1,2 +1,5 @@
 # The tcmalloc on Fedora37 confuses things
 leak:/lib64/libtcmalloc_minimal.so.4
+
+# libxkbcommon also leaks in qemu-keymap
+leak:/lib64/libxkbcommon.so.0
-- 
2.39.2


