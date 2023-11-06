Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB797E2C66
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 19:53:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r04gx-0005pT-2j; Mon, 06 Nov 2023 13:51:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r04gv-0005og-4V
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:51:17 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r04gt-0000wx-Lt
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:51:16 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-32d895584f1so2892957f8f.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 10:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699296674; x=1699901474; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QOPhrZl7WNF8otYFyZDv53mbMT0F92opu0HK5hUSxKk=;
 b=GSBkUg0mPBcZcRt24FiBAU+g9UWN/b69mnhEFOjlWIGCCRFPkvbgP+oJd7odTVQh9R
 4wWFI5m3u3d1ILkOceFvGcar0SgoipQfOqbEaMqyZg8uqGTqqbN8U+2tMsY7EAqUp3CP
 ZuUGzXMuyJCbeo2ZAIEI0V3Ac/ie2yWwuiwVNoqdx9Mk9VT2QMiEwPWIgu7UtSw5Vukc
 DOslx4qtyUqZ1/Nljlh0Q4mZ0mhhm7nkRI99K5QB8qSv10G9dEkfUtuBrU+oxz6p7otH
 ZajvrlIcyAoxK68ghO/nT5CZVoly7Hxw02BzD2IxjaGjjfVJ65Kj3guYT8z5cJUeuzad
 4VUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699296674; x=1699901474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QOPhrZl7WNF8otYFyZDv53mbMT0F92opu0HK5hUSxKk=;
 b=vbBTgk1Cpwin9AYROxtTGN5q35kp5cdE+S2ZyNi2GrFlU95sskhfhOeRiSqjMf2qgL
 70qjqMspr3eBwoHgcw0NUSKohWYuzy51A2MNY67RbzsQVVeTliFCRdsnR0g7aFmkM2zG
 JUcIzlvLeyNT/p1//RbldAY9JfCeLRxfnHhnjmtj/eQzRKXM6x6gnH0u/LuXlb8YcEw+
 U3PJ1fJtM+2JHyBhEHINvn0nMIUxTprJlIlqG6AFCZzOorpSeQam9OHo6vRBQcHwT++Q
 J9Ki382MuXTjfGVfiLOft3I6W3348FTzWPPgEiV/s9N1VoXVnAsvQnahjCr4zkByE6kc
 R8PA==
X-Gm-Message-State: AOJu0Yyd5CH+NJSpV6a3BytN2GTA4IFB6xAiRD/ihLT1bcm0x0oODEPA
 QCBuYGq2f50f55Ty0GJkjZpWRg==
X-Google-Smtp-Source: AGHT+IH0QY5Z2L7n6isopsBwJEEH53rwU+X7Q84YPntSymlToJOVP+H0waLbsvKKv4+Y/9NrWI1l8w==
X-Received: by 2002:a5d:4242:0:b0:32d:9fc9:d145 with SMTP id
 s2-20020a5d4242000000b0032d9fc9d145mr19775989wrr.41.1699296673683; 
 Mon, 06 Nov 2023 10:51:13 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 g1-20020adfe401000000b0032d9523de65sm311361wrm.48.2023.11.06.10.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 10:51:13 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A7E46656D9;
 Mon,  6 Nov 2023 18:51:12 +0000 (GMT)
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
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 02/22] gdb-xml: fix duplicate register in arm-neon.xml
Date: Mon,  6 Nov 2023 18:50:52 +0000
Message-Id: <20231106185112.2755262-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231106185112.2755262-1-alex.bennee@linaro.org>
References: <20231106185112.2755262-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231103195956.1998255-3-alex.bennee@linaro.org>
---
 gdb-xml/arm-neon.xml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gdb-xml/arm-neon.xml b/gdb-xml/arm-neon.xml
index 9dce0a996f..d61f6b8549 100644
--- a/gdb-xml/arm-neon.xml
+++ b/gdb-xml/arm-neon.xml
@@ -76,7 +76,7 @@
   <reg name="q8" bitsize="128" type="neon_q"/>
   <reg name="q9" bitsize="128" type="neon_q"/>
   <reg name="q10" bitsize="128" type="neon_q"/>
-  <reg name="q10" bitsize="128" type="neon_q"/>
+  <reg name="q11" bitsize="128" type="neon_q"/>
   <reg name="q12" bitsize="128" type="neon_q"/>
   <reg name="q13" bitsize="128" type="neon_q"/>
   <reg name="q14" bitsize="128" type="neon_q"/>
-- 
2.39.2


