Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 877439AA0C7
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Oct 2024 13:04:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Cgs-00073i-Q0; Tue, 22 Oct 2024 07:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3Cge-0006zi-0J
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 07:04:32 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3CgW-00035b-7w
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 07:04:26 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c9552d02e6so6994240a12.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 04:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729595035; x=1730199835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xhZwhDsyP9u5fu/gLDiAkir8lHLMK7A4MI+ExEvLX/4=;
 b=XRSBRYAD4Qd7pnBwiz5a5vIHHE27BmtWB2IOMOgUsSEWejCyvuQ2qxVuuvJ1z4Y5gn
 kuQ3d+pGx0NQdjtFWNrSc8mT1YqKmT8t7Zhb27vevRXS7CVlO2IpXlDkBi0QR1Vmxh9x
 RnVBeCjG78UsHTfjFNZTe8WaG9d5XB9vyDpSFSqQjCqaKEy1cz/ve/hDYssDYndwsHuI
 Eh6RWotLfzq+4fPfHmDhPzb89jiD2CqYEkb7T3cgy0p+kcIrqRK5dWGAn5xtkykBr95x
 vvePsTdNKvzUM6jQxvJnE8keYtm7PKq6nsB7h00g7suq1xTxIhzxf+Z6QjVo0TBY6I2v
 ZNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729595035; x=1730199835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xhZwhDsyP9u5fu/gLDiAkir8lHLMK7A4MI+ExEvLX/4=;
 b=Co2Psi70diMXZc7rjX6FKw1TUhpv9BNDj7g12WLkfmOTqx/sIvo2zhnJGT50w0Fnel
 zPuszsF2JQOOBudYBygr4NyQsy+I6axiXl7LKJLA2wDiD7rNSaL+aa1hVyNFAjMnxuit
 bte4p6oa7wW61feo64v8fa9S7pqe42PIIioJgj8TZ0ya9AWHRI8SbWwbWNMuHmTry57K
 V6orBqO/7BK3+Q/LL67EyG9/iIBtTe3FlWk7efNnv4uD74ur8omyApO0s03m33+DykvO
 VXBZ17y0Nv0btJU8rLhdhfJ78a60wv9oq05xjuXka6pS8xtqzpLXyeBQQx/OsXX2uatE
 MJJQ==
X-Gm-Message-State: AOJu0YxERu3/ielKqN5Cxhnr5VfuGo7uX36CHTAqpJ/K1K5uwFrYBisN
 hcgrDbFCj7DkJ6HgGp2WHCELuFgaikEpkYEvC8PJv57xStSxz4H8hwEO5PqFclw=
X-Google-Smtp-Source: AGHT+IGrsXwXm6QQRI2EJsc5NTDWH/8THorwiRLqjS3xUSuBrUIQM0t1N7fBGivyxVye6YEvh9zvEA==
X-Received: by 2002:a05:6402:13cf:b0:5cb:7295:49b with SMTP id
 4fb4d7f45d1cf-5cb72950e50mr4337266a12.34.1729595035184; 
 Tue, 22 Oct 2024 04:03:55 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb66a6a6efsm3001448a12.53.2024.10.22.04.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 04:03:54 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0BE3F5FC19;
 Tue, 22 Oct 2024 11:56:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, devel@lists.libvirt.org,
 Cleber Rosa <crosa@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 16/20] MAINTAINERS: mention my plugins/next tree
Date: Tue, 22 Oct 2024 11:56:10 +0100
Message-Id: <20241022105614.839199-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241022105614.839199-1-alex.bennee@linaro.org>
References: <20241022105614.839199-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

Make it easier to find where plugin patches are being staged.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 81396c9f15..02b8b2dfd6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3702,6 +3702,7 @@ F: include/tcg/
 
 TCG Plugins
 M: Alex Bennée <alex.bennee@linaro.org>
+T: git https://gitlab.com/stsquad/qemu plugins/next
 R: Alexandre Iooss <erdnaxe@crans.org>
 R: Mahmoud Mandour <ma.mandourr@gmail.com>
 R: Pierrick Bouvier <pierrick.bouvier@linaro.org>
-- 
2.39.5


