Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E35C873B75E
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:33:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfwb-0001Cp-Ts; Fri, 23 Jun 2023 08:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfwE-00018v-5s
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:30:55 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfwB-0000Sw-3u
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:30:53 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-31129591288so571631f8f.1
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687523449; x=1690115449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/lZ58MHVs7VVcDhLDA+codKww1SNsRkU8Vn2ofdw4A8=;
 b=XSqIJteZOMQV1Jwrm7ChEhfzxCaxgq+bxtHm2yPKMUz3H34yqD887cwrFG1szKNQsl
 CANqxVPCUDqHZGfIX8xGZKnm5IjCLHpj9ykq5aNqyPU945dlm15J0Cp5+Bxnv/5/UVTE
 l8TRtY2viRzxV7qyZ5lVKirMTRWSR4gD0Eb9Rymuiazv1k6VKtDI0ngzPB+vzwdGHOin
 3G+j1IOG4tXHAnTY3iQfqo6I50pOf+DegwVWlfC9YZ99dhSHttNTybsjgqGN4BNWAJYQ
 BFu5577xL1hSN2kDfeHlSgnwkhfe/6Pc59hnLbHWNwulQMFteNjSRJAkDJzu/pJF9OSn
 Rxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687523449; x=1690115449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/lZ58MHVs7VVcDhLDA+codKww1SNsRkU8Vn2ofdw4A8=;
 b=f0ciuWperg1bWAK57M6/1EusLbkXeBDb04Yf/utUBIvye+hlV5dYVZqNSSUmcpROAD
 YHLzBdkM6nWE/YEyIzoIr+hHvVB2fCBV15SXvzUFNLsBlDD5b3wHlj/0V5FjlvecQFmK
 2aDVN1qrba5+UQPGGneb52GYHSxSN7ObGEQXhhQp4n6u7z/geEI9k4DDgNJdziCxk4kW
 wUtJDWMgX0hfQZa+HR+OSJO/f3W2PBh6j+UoM93M6dopbd9zOda9xOTS6fGUmt0rIakS
 /Nko44UTdyu3ZpsyNxvPyFgD6NTxQf0qbrGfacJ5FtcRQnu+daiCZzA3GkO2PvVYj/KI
 MNqw==
X-Gm-Message-State: AC+VfDxO6/qVkzQMYn+TFCGxztWqV787lOrKi+Z/rvNveZb3esPv/uDD
 241fPehKDxWHp7sTPx3I2TJf0g==
X-Google-Smtp-Source: ACHHUZ5gCpC1PqJSY5KAH6Ru/3VkO8yq1rSc/C0G+OyMnExlnP0Y6WRC4N9v4XA1nXGFGNrtvSW8Kg==
X-Received: by 2002:adf:ee4e:0:b0:309:49e3:efb4 with SMTP id
 w14-20020adfee4e000000b0030949e3efb4mr14037477wro.63.1687523449292; 
 Fri, 23 Jun 2023 05:30:49 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 j18-20020adff012000000b0030e56a9ff25sm9484366wro.31.2023.06.23.05.30.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:30:49 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 34A091FFCC;
 Fri, 23 Jun 2023 13:21:03 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Xu <peterx@redhat.com>,
 qemu-arm@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Riku Voipio <riku.voipio@iki.fi>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Bulekov <alxndr@bu.edu>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 22/26] include/migration: mark vmstate_register() as a legacy
 function
Date: Fri, 23 Jun 2023 13:20:56 +0100
Message-Id: <20230623122100.1640995-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623122100.1640995-1-alex.bennee@linaro.org>
References: <20230623122100.1640995-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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

Mention that QOM-ified devices already have support for registering
the description.

Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230619171437.357374-3-alex.bennee@linaro.org>
---
 include/migration/vmstate.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 084f5e784a..35579b2c1f 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1209,7 +1209,14 @@ int vmstate_register_with_alias_id(VMStateIf *obj, uint32_t instance_id,
                                    int required_for_version,
                                    Error **errp);
 
-/* Returns: 0 on success, -1 on failure */
+/**
+ * vmstate_register() - legacy function to register state serialisation description
+ *
+ * New code shouldn't be using this function as QOM-ified devices have
+ * dc->vmsd to store the serialisation description.
+ *
+ * Returns: 0 on success, -1 on failure
+ */
 static inline int vmstate_register(VMStateIf *obj, int instance_id,
                                    const VMStateDescription *vmsd,
                                    void *opaque)
-- 
2.39.2


