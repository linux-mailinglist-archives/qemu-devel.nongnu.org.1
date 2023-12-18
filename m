Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 362D58167AE
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 08:48:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rF8LS-00080n-BP; Mon, 18 Dec 2023 02:47:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rF8LN-00080Z-Hs
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 02:47:17 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rF8LL-00052b-DH
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 02:47:17 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6d4bef65786so1238708b3a.2
 for <qemu-devel@nongnu.org>; Sun, 17 Dec 2023 23:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702885633; x=1703490433;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=F165y9zjSgYO4B2E2EgtJM6pMJysIINcipWYgRx2zNk=;
 b=AwhgTfpbxRMWu8hoKJOgrd++m50mtTIZuUiwrjIhxsQbw0kS5iEmZP8Tdo1RUJ72Vr
 h4hNR6n3qXI6/ZYstxa+nGdBJnVjEk80+PkjmTPApT5SC6O9NEwhFy4BizU3en4vvvuJ
 KMRay/bdyN8dXolI2EEuvYNPfQV0gdeouqDdpr9OjEfbjzCdR30PpRpVvE/Efo3VYgg2
 6GvQRmFC4JwU6U3IFtTTfADxwofP7PRouE1kwHzKsIubqcJNnFzOwVSwpPWyaO60Q0kv
 hhWkQzfYvw5NareLfHYNtFM+WhXJvFUXeo7IuJoLMK22ttBR3rrsI1UuWlwDL5N5dRJD
 U6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702885633; x=1703490433;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F165y9zjSgYO4B2E2EgtJM6pMJysIINcipWYgRx2zNk=;
 b=ZVDwr4lh1rtLle/w8gk3lc9ZGtucxPD+OdBHKQKyFc8fRt6zAZrxtkj8TZdP23lKrB
 YoiiPg1fmXxLmf6CYNDDjNrbrQOZ/lpNUElXohDw8P5uHKuU+DV/ED5Y5VfScwskGulC
 Oq+dXXm44w7kcwsp5edD2mcpoyJGf8aX9HXWhuTRT++pfdsqLn9AzwByraOkpzLRx1l4
 7KetsSE+AmgZsJL0JOQ1wA2C4Jq7w1+yBDNDvfrAkEDKscyToWzbDnh+TEzUYlNj+sO2
 aJAM5nOx2D6qimHxF7tDqMIgFUNnjVPZM0aWHDaslSVRw8r0mrOINF64z9qL2hfbB45H
 Mc3A==
X-Gm-Message-State: AOJu0Yzqop9H0jz3adj58Cor+h4pWpn/s15jnRosWCEciM+a+cH5MmBx
 gZDOy1XZf2za0hCX9UeMHX7jig==
X-Google-Smtp-Source: AGHT+IGL3G2ODlq29CHNG4kmeSOUV7/7pTp6RHpGGR7tp6egnMFURUSJvdd9vIGCcxmPFD+1CxPvqQ==
X-Received: by 2002:aa7:8483:0:b0:6d6:7c05:97fc with SMTP id
 u3-20020aa78483000000b006d67c0597fcmr2005990pfn.7.1702885633536; 
 Sun, 17 Dec 2023 23:47:13 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 s18-20020a62e712000000b006d70b0d4639sm1503725pfh.107.2023.12.17.23.47.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Dec 2023 23:47:13 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v8 0/3] ui/cocoa: Use NSWindow's ability to resize
Date: Mon, 18 Dec 2023 16:47:00 +0900
Message-Id: <20231218-cocoa-v8-0-d7fad80c7ef6@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPT4f2UC/12MwQ7CIBAFf6XZs5hCLRRP/ofxAHSxe7AYMKRN0
 3+XNjFRj/PyZhZIGAkTnKsFImZKFMYC3aECN5jxjoz6wiBq0XDBOXPBBcNaJW0nG43a9lC+z4i
 epr1zvRUeKL1CnPdsltv6X8iScXbSvrFYc829uPRmHmk6uvCALZHVt6Y+miqaNF5w9KqVXf2jr
 ev6BkLD9P/SAAAA
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Marek Glogowski <smarkusg@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Rene Engel <ReneEngel80@emailn.de>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::430;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

V5 -> V6:
  Rebased.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v8:
- Split into three patches. (BALATON Zoltan)
- Removed negative full-screen conditions. (BALATON Zoltan)
- Converted a C++-style comment to C style.
- Link to v7: https://lore.kernel.org/r/20231217-cocoa-v7-1-6af21ef75680@daynix.com

Changes in v7:
- Fixed zoom-to-fit option. (Marek Glogowski)
- Link to v6: https://lore.kernel.org/r/20231211-cocoa-v6-1-49f3be0191f2@daynix.com

---
Akihiko Odaki (3):
      ui/cocoa: Release specific mouse buttons
      ui/cocoa: Use NSWindow's ability to resize
      ui/cocoa: Remove stretch_video flag

 ui/cocoa.m | 537 +++++++++++++++++++++++++++++--------------------------------
 1 file changed, 254 insertions(+), 283 deletions(-)
---
base-commit: 9c74490bff6c8886a922008d0c9ce6cae70dd17e
change-id: 20231211-cocoa-576b8639e9bd

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


