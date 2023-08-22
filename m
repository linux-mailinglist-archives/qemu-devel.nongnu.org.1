Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B157783D03
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 11:38:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYNpk-0000WV-L7; Tue, 22 Aug 2023 05:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYNpj-0000WN-0B
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 05:37:55 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYNpg-0001jJ-UF
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 05:37:54 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fed6c2a5cfso36534225e9.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 02:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692697071; x=1693301871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ssIMRuL1OyQOsdEBR17Mz29ZALSmu3/U8oxoKYB7pZ4=;
 b=C9korm5UeFj8UelkeyvZunH0m1QhImOMZ4Qn/sk7b0xSPTKBqwxXAFSKRKYomMotAV
 B6hSbaIdUOXKpn20QJi1ne3Cz7xxpUxwVU8GE9YDt3nzNM9VobSoS50vnONu1sFXvCBE
 7c5h0Xdch38aKi/bgaXvaf/oaB5ODclBoIY+ZVGgsCNUA3/MX3QhoGfZU6c34dRgaV1o
 eKVEdf5oNP749wQjTtPSkc4v+aY4A6qu7WViUbQtluF0XQWcx+YKrKmhDob2+UO/LF63
 4sHFGFiJzbuswdRhKvFeZexS2wB5VtF22Of7ckHPha87S4VOO+wGaBUaLBwlUGayOMQE
 5K1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692697071; x=1693301871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ssIMRuL1OyQOsdEBR17Mz29ZALSmu3/U8oxoKYB7pZ4=;
 b=cFX8cWq4xXdSOGehMJlF5LmQpyJpQOhdC98pFrEv3DaAriuI1IdymBNgnZ4IwGImnO
 23TYKaquGD2c+DsKF5hPJKGWcfaNTlDBap7sYgwNdPCfiw8jxTT3yRnYMyizJMu2mGtD
 hWgSnVe8xheIUorfnzXWMSFdFQAtxwtIARSoEMw7G0GYrHKeh0xDe1EjGTmbBAJor2Cy
 o6VM3R2u7noQcTgNvQ8ATXQ+trlUBRC7hy5X3BwId7PF0kkJZDd1jRJr8rNIpg4vOAHb
 LyLx01o/AnMVReUm9wbI2jbplo9xLdWtDSAntrwdlTv58XO8VcD15o+a4QSs/YTjU1Y6
 Ji9Q==
X-Gm-Message-State: AOJu0Yz3M4Tb7FWxsDQI0zAGTF+BI/+7HljbTK2GX3w6aGhw25Gl9VmE
 MZnJFnD+abrafYKq8hGAVhqguDvrjQx1Avhu5D1Qsw==
X-Google-Smtp-Source: AGHT+IHkr0u1Cs3dD1hyrpt6Lb6J31SxujbI/Fk4ofr0h3CuQEoDB+fDSQF9FPgCnCX4Sl7vm9jU2Q==
X-Received: by 2002:a05:600c:255:b0:3fe:90f:8496 with SMTP id
 21-20020a05600c025500b003fe090f8496mr6645538wmj.1.1692697071423; 
 Tue, 22 Aug 2023 02:37:51 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 eo4-20020a05600c82c400b003fe1a092925sm15260039wmb.19.2023.08.22.02.37.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 02:37:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/7] tcg/tcg-op: Document deposit_z()
Date: Tue, 22 Aug 2023 11:37:11 +0200
Message-ID: <20230822093712.38922-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822093712.38922-1-philmd@linaro.org>
References: <20230822093712.38922-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Document deposit_z_i32() and deposit_z_i64(), added in
commit 07cc68d528 ("tcg: Add deposit_z expander").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/devel/tcg-ops.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 306025ece7..7ea6aba502 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -449,6 +449,10 @@ Misc
        |
        |     *dest* = (*t1* & ~0x0f00) | ((*t2* << 8) & 0x0f00)
 
+   * - deposit_z_i32/i64 *dest*, *t1*, *pos*, *len*
+
+     - | Similar to deposit, except that a zero value is deposited.
+
    * - extract_i32/i64 *dest*, *t1*, *pos*, *len*
 
        sextract_i32/i64 *dest*, *t1*, *pos*, *len*
-- 
2.41.0


