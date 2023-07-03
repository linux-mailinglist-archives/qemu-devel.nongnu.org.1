Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1532B745DBF
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:51:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJrj-0008Gs-KI; Mon, 03 Jul 2023 09:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJrA-0007Zy-M8
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:44:44 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJr3-0005jF-VE
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:44:42 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-307d20548adso4964207f8f.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 06:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688391876; x=1690983876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9GVtKOcv/SO0Bd9fPGHoO3oydZ4Ss+XbZE8K/rNAROI=;
 b=ulBqrqnIHNwslD8BYQYozsIYKhArQG13LS7wlZBbbKCmASC2bGAnTC6zs++DRrFcSh
 vi5lpxEK22WLrtqbo4SM2rB2y8faZ61ewqO8+HCgf6wIidzd6YL8fBMajy3nCE/yhf4x
 S1bxAXlsVXoDU0JNdYCxZo0lkDJrpQbzTBrBhWnofLEvinJlauKjRov2ks3SomwV0IyP
 wNRHVMFXOcp7iBlk02kJdlVxU35cS6qVZv4J8ABFs+Rgdn6RfTfMlH75WhMPYEKUUxvC
 Ty03ddKgo8Eal9Fha6KLggrCGFUGE31b+jUFlNTuPsVkYBFXdf8tPzST3DErBel0o7UJ
 ebXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688391876; x=1690983876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9GVtKOcv/SO0Bd9fPGHoO3oydZ4Ss+XbZE8K/rNAROI=;
 b=GJJgjGkSOW8itHG5niT+WkvSe0mmDqN9Xkl05B2Xi5cVpgJ2HJ1ixVeCyTMLzvKzxp
 +hjgzRZHhyDAgzOovnq7ruvpbr3XIeQ7SyAoQ5BCd//Z/W48LhaCzoGFcd6mhN2Gal6a
 Cjgds2RE3ALjYuyljatyDtLERKqvzltWyZOTu1Vx2UvgYBVAHjx6QLnwE0j5Mm4MqcG2
 SxxPK8J/XegR0eIUT6Yz2rp0HMK4RDtC82PzBS1a2y71pk1nfsbdsb0hGOpLNxPOqoYi
 5q6EImWnR7VFCvsYnI+jNlbnl8fyQyKgtrAKa1ME0NJlWp4F1ZQ03/dv770aJe6N9H+P
 4LZQ==
X-Gm-Message-State: ABy/qLbfpIIkhEVpfGmPp89sRJJvRc9MsprN66qajB9Wmj7LikBP8hb3
 daNF+aTk7wEzqST+dy2YdPQZ5Q==
X-Google-Smtp-Source: APBJJlHFbkggSkW8k+Ha1HWC8H87j7dK4RsZij8A/UvuF2TF3lcDgyQXKnmapw/kgYtOZ5I0e7y9+g==
X-Received: by 2002:adf:de0b:0:b0:314:32b6:af3 with SMTP id
 b11-20020adfde0b000000b0031432b60af3mr3993166wrm.5.1688391876660; 
 Mon, 03 Jul 2023 06:44:36 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 o10-20020a1c750a000000b003fbc0ea491dsm11258914wmc.40.2023.07.03.06.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 06:44:35 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0BA161FFE2;
 Mon,  3 Jul 2023 14:44:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 37/38] docs: Document security implications of debugging
Date: Mon,  3 Jul 2023 14:44:26 +0100
Message-Id: <20230703134427.1389440-38-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703134427.1389440-1-alex.bennee@linaro.org>
References: <20230703134427.1389440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Now that the GDB stub explicitly implements reading host files (note
that it was already possible by changing the emulated code to open and
read those files), concerns may arise that it undermines security.

Document the status quo, which is that the users are already
responsible for securing the GDB connection themselves.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230621203627.1808446-8-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230630180423.558337-38-alex.bennee@linaro.org>

diff --git a/docs/system/gdb.rst b/docs/system/gdb.rst
index 7d3718deef..9906991b84 100644
--- a/docs/system/gdb.rst
+++ b/docs/system/gdb.rst
@@ -214,3 +214,18 @@ The memory mode can be checked by sending the following command:
 
 ``maintenance packet Qqemu.PhyMemMode:0``
     This will change it back to normal memory mode.
+
+Security considerations
+=======================
+
+Connecting to the GDB socket allows running arbitrary code inside the guest;
+in case of the TCG emulation, which is not considered a security boundary, this
+also means running arbitrary code on the host. Additionally, when debugging
+qemu-user, it allows directly downloading any file readable by QEMU from the
+host.
+
+The GDB socket is not protected by authentication, authorization or encryption.
+It is therefore a responsibility of the user to make sure that only authorized
+clients can connect to it, e.g., by using a unix socket with proper
+permissions, or by opening a TCP socket only on interfaces that are not
+reachable by potential attackers.
-- 
2.39.2


