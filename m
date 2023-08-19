Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE327818A8
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 11:51:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXIZx-0008DG-88; Sat, 19 Aug 2023 05:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIZf-000819-1l
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:48:52 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIZc-0004JV-Px
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:48:50 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-31ad779e6b3so1485431f8f.2
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 02:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692438526; x=1693043326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zlGMaK6j2mWq7JaFuFrlpLtB5W9kFdVwVcjMIv6tsic=;
 b=AR3GMnN5ke/Rb4pCDPgdwemz+cap9Or3qGsGN6HiqNJywOzZAbimzJD5GFjbd9+/B+
 I5L6UqiloZbvhxWobi51zaXE4uD1RkZiNzr3e4Bny9d9B4Dis7BwYAn0EwWGoXGuZEwi
 wBNlDLA71qoYC4+0nmdedNRIRDfpHSxr2/R76kxRkJKi7Rqexb9S65YrCVptRuPOdGjU
 5aTjplFDrjrGNeM0qTaJvo8iUv8VOPsbcsYNx6otOobit7EVbz9BCSFruL9WCP7E8Ein
 GIyaohjMKF6NkEAeGMn1B5KdQGon0VOS0zgEPsHyFmw7Y8n4+7RpO1vW4LDpwLsCaQPL
 F8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692438526; x=1693043326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zlGMaK6j2mWq7JaFuFrlpLtB5W9kFdVwVcjMIv6tsic=;
 b=hxARwO1IzBYU6R3/xzMeNEwDwU0XdX8EVD+dXwZurt/bl/AQ7nXzHCqU339GBtMHPg
 qxZKrNpX9tfkTvV362S+YgxSSe1Th0Hewk4PSnwUaHgqAD/4SCCmZYFhB1ZVdIOqkAib
 ZLNPlTcqs8TbEU2aD+k0IgLfVUQlSOZe678BQI9+yF7cwpbqNlvNPVvTkuylrMfENXsO
 9N8UR4boLK9X5apCEcq8Aa43qAjuxbVIQJCRcEnZyIoaPBPDsk9OXzXTRFI55yqIMw37
 0FgYwaEZ/WJ4GKLaH3gBZYj1qr5TTzkhe/NXB6VubLxYAi4Um6VADwfGfydiOj1CANsB
 a2vw==
X-Gm-Message-State: AOJu0YzpQ8ixlExT49W7wKE5+87gagRk1F8ZIUBLbeJVe+QnclIr9Odm
 NZPTzADa4IouSms16OJUKcX2H622gFw=
X-Google-Smtp-Source: AGHT+IFOfOtgLl4rZx8MTegMBYd7Z1LJEWnFGdOSDOWumf7My5GrMWcXhP77tN2ZraNXwZZpFoL4yg==
X-Received: by 2002:a5d:684b:0:b0:317:597b:9f92 with SMTP id
 o11-20020a5d684b000000b00317597b9f92mr1140926wrw.57.1692438526300; 
 Sat, 19 Aug 2023 02:48:46 -0700 (PDT)
Received: from karim.my.domain ([197.39.34.171])
 by smtp.gmail.com with ESMTPSA id
 o18-20020adfead2000000b003143b14848dsm5617216wrn.102.2023.08.19.02.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 02:48:45 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com,
	Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 07/22] Add bsd-mem.c to meson.build
Date: Sat, 19 Aug 2023 11:47:51 +0200
Message-Id: <20230819094806.14965-8-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

---
 bsd-user/bsd-mem.c   | 0
 bsd-user/meson.build | 1 +
 2 files changed, 1 insertion(+)
 create mode 100644 bsd-user/bsd-mem.c

diff --git a/bsd-user/bsd-mem.c b/bsd-user/bsd-mem.c
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/bsd-user/meson.build b/bsd-user/meson.build
index 5243122fc5..6ee68fdfe7 100644
--- a/bsd-user/meson.build
+++ b/bsd-user/meson.build
@@ -7,6 +7,7 @@ bsd_user_ss = ss.source_set()
 common_user_inc += include_directories('include')
 
 bsd_user_ss.add(files(
+  'bsd-mem.c',
   'bsdload.c',
   'elfload.c',
   'main.c',
-- 
2.40.0


