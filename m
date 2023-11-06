Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5417E2C82
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 19:59:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r04nz-0002rY-Hk; Mon, 06 Nov 2023 13:58:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r04nx-0002r0-7n
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:58:33 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r04nt-0002Ox-NF
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:58:32 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32f8441dfb5so3330632f8f.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 10:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699297108; x=1699901908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NwMK92q1ioO5BE1TM8zS+W2srcEmlEKZvS1c4LY3VNw=;
 b=lFFF61mXGCmplAz3OSvgW5UamvBEvwY4vgTty/vHjAS8xQ9NJT0uKPvmpoVrZz7ESi
 VYLQ686GkAcPXO+PQ8nR8rTDc6oE2YbCXfyKM1RgdBt1Bi0EMojAM2SE7sM0g0pu4vwe
 FfY3FS329mIPhEbgoSaNjHWEXPxwz4OZ8szEOrCLmgz2MS/095x01JMNdr1TrOHYymIL
 ICVoibhHuH+PGHby5fZ74RSq67/Rab5z2Gt83A62YdJV+xN7gk0/K7BaSjT8vUf44CX9
 cAhdrEg00xzGk7n2e1vwlsOt7AdvW63kLi/jH7H1MQ/UKs5Qs1nkZWr8xLZpPQ444c9i
 O72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699297108; x=1699901908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NwMK92q1ioO5BE1TM8zS+W2srcEmlEKZvS1c4LY3VNw=;
 b=dDFKw3mNSHli3a/owrKAlgfKP4kalM57PBk0tC8zRPtDdWghQg3aOaY024dLwuXrTs
 GgZRbu8+xW2tosknp4nBLCxv4V41GzdwfjnAOquDAusZt2KTwti6llsJcQLcIlWAtjoc
 igVjjrBmSkDKFdbgMgVNmszlRzko4EjiDsd9Fy/EmhSG1bQImEQk6ogVsqXFmAvFx/UU
 Mj0cEO07XHdYFNqCvfYmHLK8LvEe8wFbe+/RRxvBNsFUGiLREBBQCuyPvrsKLdYEbC3J
 B6f17kJGbDs5pquKzYgDVTGPyA/sP4RAfiMoGrj8HrpF0Fsgd29RtUcmjgv3AT4OYrQk
 DNyw==
X-Gm-Message-State: AOJu0YzHwUH66UlCDZEWS3zwF6sRUbOEiaUZYxfcrghEMwNKxsd+2MG9
 lA1kVzjXxH/buSSdsUHYrmYXOQ==
X-Google-Smtp-Source: AGHT+IEdxDNMarLH2UZJNjPU7dTlrjIZ28S/m+6TEoKH3vkVipG+bH6Din6RAoPTyiOIsypOHq3mpQ==
X-Received: by 2002:a5d:50cc:0:b0:32d:9a1b:5d79 with SMTP id
 f12-20020a5d50cc000000b0032d9a1b5d79mr21716520wrt.33.1699297108267; 
 Mon, 06 Nov 2023 10:58:28 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 e12-20020adffd0c000000b0032d893d8dc8sm338136wrr.2.2023.11.06.10.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 10:58:27 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 41E5A65764;
 Mon,  6 Nov 2023 18:51:14 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 20/22] contrib/gitdm: add Daynix to domain-map
Date: Mon,  6 Nov 2023 18:51:10 +0000
Message-Id: <20231106185112.2755262-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231106185112.2755262-1-alex.bennee@linaro.org>
References: <20231106185112.2755262-1-alex.bennee@linaro.org>
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

Daynix describes itself as a cloud technology company so I assume
employee contributions should count as such.

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231013154424.1536392-8-alex.bennee@linaro.org>
---
 contrib/gitdm/domain-map | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index 42571fc1c4..bf1dce03fd 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -17,6 +17,7 @@ cmss.chinamobile.com China Mobile
 citrix.com      Citrix
 crudebyte.com   Crudebyte
 chinatelecom.cn China Telecom
+daynix.com      Daynix
 eldorado.org.br Instituto de Pesquisas Eldorado
 fb.com          Facebook
 fujitsu.com     Fujitsu
-- 
2.39.2


