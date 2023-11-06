Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D76087E2C83
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 19:59:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r04o2-0002tb-IL; Mon, 06 Nov 2023 13:58:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r04nz-0002rj-Pv
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:58:35 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r04nt-0002Ov-NW
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:58:35 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32d81864e3fso2777887f8f.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 10:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699297108; x=1699901908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J5D0D9ESjbdX0p907bmZ29I/+bI182M/W+pRshdrvtc=;
 b=h6c3Dgo7wzyL4L77lmQpc+q6WiQQUK/kzJeTkdd0imZK4VBdJh4QiwrgcoWBTQVlke
 ZsDJNFHG2sp94SeTlRRFwdRVV3D6D8UiIrBm8+yCOpWZStS29vg+99Xjui2LblemqgMN
 1xONLBiI/7mNfkMZQYQMJMSe3MYjh0oBDZVfzVatq1HEkKUbUFaYHf3PER48s5ijoQcO
 ZVMdvBdi7NeRT4WNX+br02vjkGs3bI39GjrBVGad//gFaPXbCKlNo6buO/p+mMK1cGl+
 vqCtaiNBNoWp4xLIdqu5J/jJg0wfje4zck5+YchgU5u8Hx6vC1Zeciku2wl+ECZvxV31
 ztuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699297108; x=1699901908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J5D0D9ESjbdX0p907bmZ29I/+bI182M/W+pRshdrvtc=;
 b=js69HTwR8MMvJiCpzrWj4qOgkKE50q3hKziN4sEVHYPMv0dN2QZSsDy4HJQqsTwEll
 mTyjVQi3hFV8HMHyccByXdUjJRG2goTFEH7b6ENWzYeuJ32ou4ParVl9nt+yIFQmt2W5
 hLKT6Ha0ipAXfmlwh4gjzR3/PiNAqnbWCXZRv2sd/RMNcudJALywHSN9JM21sUnXGo+0
 s/nOfrnL4oA7D6NH6xeHo9ljKktCLDGPHwy/shI0/CjV4GYDNr0AwWkpI1Rhtix2iPWn
 AXwUlbmlJw0u5UUGro5U9I/jF3jy/wAuVmdtXb4xvW6LfHp0Rki/wzl43o0XeuAxfofD
 ycfg==
X-Gm-Message-State: AOJu0YxUZE6V0wP9a6lFFRXC+OD0osGGa9bwH/6Nbm3y9hyvFJNG+qQr
 GfyFxDHsW00yk4cKqOF/oOtpBQ==
X-Google-Smtp-Source: AGHT+IEoVmTh5uyRSdi5gVZPiaA9I2GgPigU/Ng0uPYE8DfADm6AIkrrFQlMOBNN2GM7oW3SvsSTqw==
X-Received: by 2002:a5d:5848:0:b0:32f:83f4:e611 with SMTP id
 i8-20020a5d5848000000b0032f83f4e611mr22347655wrf.17.1699297108074; 
 Mon, 06 Nov 2023 10:58:28 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 g3-20020adffc83000000b00323293bd023sm336283wrr.6.2023.11.06.10.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 10:58:27 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5689D65765;
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
 =?UTF-8?q?Timoth=C3=A9e=20Cocault?= <timothee.cocault@gmail.com>,
 fanwenjie <fanwj@mail.ustc.edu.cn>
Subject: [PATCH 21/22] mailmap: fixup some more corrupted author fields
Date: Mon,  6 Nov 2023 18:51:11 +0000
Message-Id: <20231106185112.2755262-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231106185112.2755262-1-alex.bennee@linaro.org>
References: <20231106185112.2755262-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231013154424.1536392-9-alex.bennee@linaro.org>
Cc: Timothée Cocault <timothee.cocault@gmail.com>
Cc: fanwenjie <fanwj@mail.ustc.edu.cn>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index 94f19a0ac9..e12e19f691 100644
--- a/.mailmap
+++ b/.mailmap
@@ -30,10 +30,12 @@ malc <av1474@comtv.ru> malc <malc@c046a42c-6fe2-441c-8c8c-71466251a162>
 # Corrupted Author fields
 Aaron Larson <alarson@ddci.com> alarson@ddci.com
 Andreas Färber <andreas.faerber@web.de> Andreas Färber <andreas.faerber>
+fanwenjie <fanwj@mail.ustc.edu.cn> fanwj@mail.ustc.edu.cn <fanwj@mail.ustc.edu.cn>
 Jason Wang <jasowang@redhat.com> Jason Wang <jasowang>
 Marek Dolata <mkdolata@us.ibm.com> mkdolata@us.ibm.com <mkdolata@us.ibm.com>
 Michael Ellerman <mpe@ellerman.id.au> michael@ozlabs.org <michael@ozlabs.org>
 Nick Hudson <hnick@vmware.com> hnick@vmware.com <hnick@vmware.com>
+Timothée Cocault <timothee.cocault@gmail.com> timothee.cocault@gmail.com <timothee.cocault@gmail.com>
 
 # There is also a:
 #    (no author) <(no author)@c046a42c-6fe2-441c-8c8c-71466251a162>
-- 
2.39.2


