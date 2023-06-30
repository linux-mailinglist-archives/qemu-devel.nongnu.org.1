Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7757441FA
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 20:16:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFIci-0005Om-2T; Fri, 30 Jun 2023 14:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFIcf-0005Mz-EX
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:13:33 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFIcc-0003Vm-Gj
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:13:33 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fbc656873eso12230555e9.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 11:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688148809; x=1690740809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7t6FYLyWy431w3wryjlf0ss7bOMa2KXvVFdEtFrGEiI=;
 b=s3JFjpZw+RNiazG9hTe3HKM9400YXzQw9NPtXnhtUmCb1jBU7AXQrUOVrvefsI+6/g
 SmpF5cwZZQ+Y/lbOIo6/mfDbRhiVw/tkn9mWedjuES95xENVvLpIs8qufu0OjjEyWNvY
 irguLNjBtt35MFgRw3n/TvSgcdFgf9Y9wt1u9sz5iWhIo/2ekxZBAszUrBQeoehE7Cdm
 AmB3t4U4mqYZvoieChrFih25YNKuaT2jLitwlRyr+Bpr7X9jodjMfslYC0N9PJc/GMAy
 gqZjyB0rSeznq93bbZTJkFKEubNDlS31IgE6yWGEKKijT/6ur8zwlkDr9YetUtrufZWJ
 eZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688148809; x=1690740809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7t6FYLyWy431w3wryjlf0ss7bOMa2KXvVFdEtFrGEiI=;
 b=IskMdat2snc0bN6fC8z6w9AaZCLGjd4jHTnYZ6IXjKO5okLweWgVc8YHcMest5PDUS
 67Z3KR3X6tXOMB1o8Qe0qGHR2YNSbzXQZc0689CALlZrn0noI6pHwhjo96Y9TpJB77Y1
 HS/4ryavFtao++gr0V8YURBcs4An4Wg+DLPIfom+4jWiiMTFS3/ON3AimBuw6Y9RKWiT
 dwMfQMM8OggoPs7JXgnKLgLJhL599Vzsf94QNq2+zmMw8MTJ1G6cj9mhOnXKHijHLFf0
 /OGaYy6ukdJWlkSNpAY+X+L765CQbnP2KT6PaubT+gfZPAr5qbla7hHpyqyteRZbTKKM
 u1Pg==
X-Gm-Message-State: ABy/qLaptT/L+T2lv3e2aAmw/943bSGINi6fOhyWK7wD1DItUx8wI3wI
 DVQPyOW6fII8Nk/lx6MAQi4SAw==
X-Google-Smtp-Source: APBJJlGmpfk4R4KUMQGYa7joUoKZa5JJ3/luXyPnZwTXSSyvd5myghG/45kFuSOHwyVSRrJOQFnQfA==
X-Received: by 2002:adf:ee51:0:b0:313:e520:936f with SMTP id
 w17-20020adfee51000000b00313e520936fmr3790842wro.17.1688148809192; 
 Fri, 30 Jun 2023 11:13:29 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n5-20020adfe345000000b0030e5bd253aasm18865146wrj.39.2023.06.30.11.13.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 11:13:28 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 355CA1FFE4;
 Fri, 30 Jun 2023 19:04:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Riku Voipio <riku.voipio@iki.fi>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Bandan Das <bsd@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-arm@nongnu.org,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v4 37/38] docs: Document security implications of debugging
Date: Fri, 30 Jun 2023 19:04:22 +0100
Message-Id: <20230630180423.558337-38-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230630180423.558337-1-alex.bennee@linaro.org>
References: <20230630180423.558337-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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
Message-Id: <20230627160943.2956928-36-alex.bennee@linaro.org>
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


