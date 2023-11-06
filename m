Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEBC7E2C87
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 19:59:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r04o4-0002uH-54; Mon, 06 Nov 2023 13:58:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r04o2-0002td-6c
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:58:38 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r04nv-0002PV-Tl
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:58:37 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40842752c6eso37059465e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 10:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699297110; x=1699901910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=00UxKawn1x7IIuLj2PQjPzOk5i/DAv1k///QzmwLrMg=;
 b=tiK4gFDwsXgQ9+aCaV0ogJMl8FhYqj0oZJ2mQZKSGl1C/YqnX4nr+/rhOaNVMhXS5r
 8A7ius2yeqKT9Dl+UpYMLK0/vgem/Qi54AjEeL55N3/Xu/WnoHW+8vG1n7fsoH5Ul4f3
 FQs7A9BLE8AXoDoBhAGHxxDbf+t/JJFXyHvBdeyyQlYJHq3UUmX4uFaJPxj2ij2h94fi
 WyxFlWOOhp3hoj4QfyFq8QaYAWtWYYMFF9oj0Q7E7zSIUcm7PwyVJNqy91WXjIFlLqZY
 E3QjP+saHyHwKGRMfT4ZprIzSZnxxF2KLFkeEy6d2UI1KorJ1ieXa/NtYLtSRlBky/kw
 MxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699297110; x=1699901910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=00UxKawn1x7IIuLj2PQjPzOk5i/DAv1k///QzmwLrMg=;
 b=lOLQm/0/C5Ip1F9W7HXy3RsjCyfMtpUI9kFCk3c/FlxFw20G2RyDJyjKxKsADZ/7qI
 vO3GCP+x09HqvKYmw9aJo/z66lFH4zoW+9biweRv/bFYH1BW0LkTIMWUjavpzF/sHeSr
 IF83iWKCgpAhg7nAqH1b2HZFH6Hk8BPoOZ+wXITxKdH/TXISg++9SssZ/bUG47epdp4o
 fV6dC7hnM8QEfSIPlcBXPz6dav1DZa4VlU8LbEk/mE2uX5PeI9kUlPmgNw6aORd96YVq
 KJ6CkPg6WrP6+5U60BsXg36ACp2h5/Q7fNpaYrH5KUY3t8DvbXCXdnuGPAiIx31Gbp2p
 0GFw==
X-Gm-Message-State: AOJu0YxuKsABtP+FXbLhZdhflhGp7qN0Da79769O344O89fKzkrVEk+R
 inQzGs6VIz8n5CdFGJf919jLzQ==
X-Google-Smtp-Source: AGHT+IEVxn/evBwBhq91x1q864UPUP6yIt7iLIyc+sDzaInOYWHv/fQRIwhB47gIF61HYqfdF1xJaQ==
X-Received: by 2002:a05:600c:3511:b0:408:4120:bab7 with SMTP id
 h17-20020a05600c351100b004084120bab7mr505936wmq.15.1699297110607; 
 Mon, 06 Nov 2023 10:58:30 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 e10-20020a05600c4e4a00b00406447b798bsm13481201wmq.37.2023.11.06.10.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 10:58:28 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 06EBA65761;
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
 Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 17/22] contrib/gitdm: Add Rivos Inc to the domain map
Date: Mon,  6 Nov 2023 18:51:07 +0000
Message-Id: <20231106185112.2755262-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231106185112.2755262-1-alex.bennee@linaro.org>
References: <20231106185112.2755262-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Whatever they are up to a number of people for the company are
contributing to QEMU so lets group them together.

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231013154424.1536392-2-alex.bennee@linaro.org>
---
 contrib/gitdm/domain-map | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index 3e31a06245..e676da8d47 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -38,6 +38,7 @@ proxmox.com     Proxmox
 quicinc.com     Qualcomm Innovation Center
 redhat.com      Red Hat
 rev.ng          rev.ng Labs
+rivosinc.com    Rivos Inc
 rt-rk.com       RT-RK
 samsung.com     Samsung
 siemens.com     Siemens
-- 
2.39.2


