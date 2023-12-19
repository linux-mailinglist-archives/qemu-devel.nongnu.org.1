Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC80819080
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:17:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfWo-0001n1-Jf; Tue, 19 Dec 2023 14:13:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWk-0001jw-OW
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:14 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWh-0001lI-G0
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:14 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33678aeda3fso62735f8f.3
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013190; x=1703617990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9bxYcAuKeHOY0Scr+m8bY+3d+8njdh2moV1wFNg9V4M=;
 b=G9+cmKJnTPTvWWU1BGKxNO/iDlPans1ZKI5YTEd827CdvOQcxcWB8Sqabg8BDkxLiH
 McPfiAtgW3Xbtsxx33XWz+lelsuRms4OYbvuAdphyBc2eLEPg4Y0FCfZKe+Gz7D5gSOV
 Ol1e+eTn+mhEvJQIN15EhhUI4ntKxkb/P9eGdwczx/uoU/3DMg1B1t8GQ4bGFyYJmJMC
 NmU69iZemqHoe59OVCEd/Wv3V5fJdi6cZNpWwgOksvo3D8wf7GvsrV4BLpvNdOOv+k79
 CCQJgdzt4VWypjdw461TTKCbCYkp/q/Xt3aARJVTwYojiHLc+WOHHtVtOJ34dSwhFzw2
 NxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013190; x=1703617990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9bxYcAuKeHOY0Scr+m8bY+3d+8njdh2moV1wFNg9V4M=;
 b=gEkYHgYd1GBywAWu5gOsEzknlh7IoEBUB8l8gTrJK85UWj91RsTcolsZqlE767TFus
 T4khHS/KW0v0hjKQwwc3Nn9YPN9gfY0vHU4wYfjs8bnrdPWPBovmuP1z+F1dEcjOniQV
 V9REjBRH374Fr4FONV87xt4FavbvzrVOUfeB7/sSguHXnZEBo8EgJBF0YW6LMElrfaCo
 hFugrVWppg73BZity951CuS7rXAnPro2O8i0jX6V2sIj3xEjk/L9CUobLW1Bi9gw0xto
 XpLnuHms0eirrEVwUsjo7f7Dofs+5rmaPqu+d0IkTJJ+ZgcDwcwCG2oSZ5JC+w2m0X1o
 MuZw==
X-Gm-Message-State: AOJu0YzqkD/jrnaLbrvn5U/TaNjYG/jUDjfqDm9wGd2cf0Z29g89sZ47
 wiyAzwGRLaL3MVFlVheD5F8TwwKgu004UbEWrrY=
X-Google-Smtp-Source: AGHT+IFTC7juGA2NZsy89Uc2lAI7RtTBODUQa+XrR4JZF28gGKayhMbmarOiodDEmR7NglV9nVR4OQ==
X-Received: by 2002:a5d:5411:0:b0:336:686c:c60d with SMTP id
 g17-20020a5d5411000000b00336686cc60dmr2177066wrv.115.1703013189980; 
 Tue, 19 Dec 2023 11:13:09 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:08 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/43] accel/kvm: Make kvm_has_guest_debug static
Date: Tue, 19 Dec 2023 19:12:25 +0000
Message-Id: <20231219191307.2895919-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

This variable is not used or declared outside kvm-all.c.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 accel/kvm/kvm-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index e39a810a4e9..f138e7fefe7 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -98,7 +98,7 @@ bool kvm_allowed;
 bool kvm_readonly_mem_allowed;
 bool kvm_vm_attributes_allowed;
 bool kvm_msi_use_devid;
-bool kvm_has_guest_debug;
+static bool kvm_has_guest_debug;
 static int kvm_sstep_flags;
 static bool kvm_immediate_exit;
 static hwaddr kvm_max_slot_size = ~0;
-- 
2.34.1


