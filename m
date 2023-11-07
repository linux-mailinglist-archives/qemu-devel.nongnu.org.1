Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B95957E41D1
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 15:29:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0N0K-0004Tb-2n; Tue, 07 Nov 2023 09:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0N03-0004GV-W5
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:24:16 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0N01-0007cO-Fk
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:24:15 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40839807e82so35472075e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 06:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699367049; x=1699971849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kvs5yYoc9I7mQ0TZEsVB3Q/WNehbciT+s2kf/2EJ0zk=;
 b=Bg2SLAOYU5CAvx6j9makRMoCEKzXK0ptM6bbeOgyIkLAnGHcP4uezU5RJxvPrYG96i
 so24eprvNvBNvBC1WQmbrUz3uf6MRI6ILHLVq6AroBo1rLwokpx18wxddCElL1rUrzdX
 4hf9//fD6m0quM0jpJy73ow13vptQyaAyL/pfscpHVB6Zh8zak1IjmHc414K7gsDuCpw
 02fB4VfwI9YEQWZFZLG12co2T7knCHjyxjWfXfN4AQcIubwLjRO++l5NdjFBxl4pVkzL
 EGb2XryvneCJByVt0WtEWkn9cXK+zAWTpsdAPEiLfl6dKTiahWtT9s1S08JGJahqLQhV
 mn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699367049; x=1699971849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kvs5yYoc9I7mQ0TZEsVB3Q/WNehbciT+s2kf/2EJ0zk=;
 b=OiHlrCMPIf94twk22jGlEOZbZSqSc90uBzLs2SkJ9LUDwa/GFptIik3/V4zJjdEugJ
 mtadZWxgYF2BLUkvJf9m13aj0Z5tgkd08AO/Kyl1fiFsAiUu6lnVbep9mRtEFufVPV1x
 qV7iY9jK2l2JklPurWa/FEFhVxtgj5jZRQoSyzj/oKPcdV0dEGjW1PwlpMGhDon8ByCJ
 2F6D5IPSfxQfXWi/ttxfQeqMSJcmMaCVvqrK6udNRBVjgcj+cCpjZ2nITrpG6X5S+qA8
 fp4OOCRKxBevC1sNVTqurjfe9vy0Nk3ayvlfZyIN+WwPhHS02j9fNYDvIaxqgWTzDIzX
 YyvQ==
X-Gm-Message-State: AOJu0YwsktGcsL44O7NJUF8Xbr4I3Y3t6JXwFI4yFmrvLO7QFASlSEbd
 1zyJ8A37lGb/BA58+PbxiezMTg==
X-Google-Smtp-Source: AGHT+IGn8TQvG8QI5i/tLuyA+cohUZ1H9ET25c+eowVo7JbdmThT/O83pq+fLg1FPP+OpgYKkQSyGg==
X-Received: by 2002:a05:600c:2213:b0:408:36bb:5b0c with SMTP id
 z19-20020a05600c221300b0040836bb5b0cmr3421774wml.7.1699367049321; 
 Tue, 07 Nov 2023 06:24:09 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 i12-20020a05600c354c00b004042dbb8925sm15922596wmq.38.2023.11.07.06.23.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 06:24:05 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0E72A65764;
 Tue,  7 Nov 2023 14:23:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 16/23] gitlab: add dlltool to Windows CI
Date: Tue,  7 Nov 2023 14:23:47 +0000
Message-Id: <20231107142354.3151266-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107142354.3151266-1-alex.bennee@linaro.org>
References: <20231107142354.3151266-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
index 12a987cd71..f7645f72b7 100644
--- a/.gitlab-ci.d/windows.yml
+++ b/.gitlab-ci.d/windows.yml
@@ -72,6 +72,7 @@
   - .\msys64\usr\bin\bash -lc "pacman -Sy --noconfirm --needed
       bison diffutils flex
       git grep make sed
+      $MINGW_TARGET-binutils
       $MINGW_TARGET-capstone
       $MINGW_TARGET-ccache
       $MINGW_TARGET-curl
-- 
2.39.2


