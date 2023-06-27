Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F327400A7
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:17:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBMK-00014g-8K; Tue, 27 Jun 2023 12:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBMG-00011F-Tb
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:16:00 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBMA-000887-Gx
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:16:00 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-307d20548adso4306759f8f.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687882551; x=1690474551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E+S/2xF0HXkyXAmhdbBZi2PQMRaPK50oTftei6f5iso=;
 b=BV7BhM8Ovfh2OFs128IggTGFRSjkSCL0R1igGCXlxO4X0Lownl8Pm+ZzUOI0/FOXp/
 vwNsLsoxEZmQM3zgf7K821zL0E+I96IRnwMsXDXk8zWD+WsfRFoIu+5w4+j+4oiBjZOc
 KhjbS6tbtdOVJETWApXJqWyrsiJJowKvO9h0jsDsgA0izHIdoVuU2fh4WNUDm7XDo2Dw
 jsk8zHPM/tmFgFcZ7mvWejaFQFgLg6HobxOOeOU4WSVte3lQBhqn1VoIJ4ltsTGEGeMs
 OsXDJBsFbInS+liPfgdAFejUcssEUci7o5vQbQqg8V4Q832WnsweFHJX+KBfv+Ew3nDL
 9UFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687882551; x=1690474551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E+S/2xF0HXkyXAmhdbBZi2PQMRaPK50oTftei6f5iso=;
 b=isvjdch04FX5vTK+fs/CgJEnqTOM2Ol3/8MlVGzaY792LDUQivj1gmmqRXQrAGu80n
 cXql7Jg5R2PUzKIe+nBPcF6OGESFHnTLCb8fnWfsVPvvZot4qMFS1jClsiz3o1K0p/Qb
 eBkrEzsNrJR9ub4SbyzwvCqhc5iW1cNxNtJFK+ddNiVARdKA6e1GadA/A0STy2vcjtoa
 Q2w58tCxNpGaNQjtRSy0VVJJBPiDoXgVlzhe0dIw5rIEivqkG0up9/Wnr/78iubU49EI
 wVZFygrXH6C2znQsRVQEQ7DvL5t28v/ywWWLxXuvrI0BFPVkTv4TnLca6GHoeKu72bMw
 sfJw==
X-Gm-Message-State: AC+VfDx8YEhfi2FvgvqNXvnPF0FUCwM3uBOOvRKId5dbsi/gv+TSVhKT
 26hce58Q+gq/9OLIN/WXkAxQyQ==
X-Google-Smtp-Source: ACHHUZ6oQWKKBEW2NibzmI8qH+9pDLTNT5KTWrQHwLnpgaOrra1yl2Y5OVPGrM0U05bfZO8HeI620g==
X-Received: by 2002:adf:f24c:0:b0:313:f152:d7f2 with SMTP id
 b12-20020adff24c000000b00313f152d7f2mr4395926wrp.36.1687882550883; 
 Tue, 27 Jun 2023 09:15:50 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f13-20020a5d50cd000000b0030647d1f34bsm10970498wrt.1.2023.06.27.09.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:15:50 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1058E1FFE1;
 Tue, 27 Jun 2023 17:09:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bandan Das <bsd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Laurent Vivier <lvivier@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 35/36] docs: Document security implications of debugging
Date: Tue, 27 Jun 2023 17:09:42 +0100
Message-Id: <20230627160943.2956928-36-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230627160943.2956928-1-alex.bennee@linaro.org>
References: <20230627160943.2956928-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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
Message-Id: <20230621203627.1808446-8-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/system/gdb.rst | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

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


