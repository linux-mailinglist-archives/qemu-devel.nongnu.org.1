Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E70B57C890A
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 17:46:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrKL3-0001o9-4c; Fri, 13 Oct 2023 11:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrKL1-0001nW-Jq
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:44:31 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrKL0-00055a-1h
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:44:31 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40776b200e5so2336445e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 08:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697211868; x=1697816668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JF3gom/LuvopelDxpX2buDCD4c3QpVtGIBWgdmUxuOo=;
 b=Q1MaJRsPYvX57YEZ4HhLIV2YE3IQoR/NcrvWdtCmfRPY1LGSh1C3MPPok4U8nwWCpF
 eVoEVHChg4r8M8y1a/a1bNRBcJcdphOe6pu82ojwPyKUqvWIWY0tGgXmU2MyVbyiCViM
 w4SxygKD3dKEP+/VHL4W6Vwk0bTvg1/Da1AN3VaA2YwMVNINeKaOtOSt//CFXwI9Rd9x
 RwnCQrGi8OkBX7jpkbVFaWbGSjqsJWjUliHstmGvMsBpuuz66V5a5ZadfHLp8gWbLr2y
 t0bk6DGwyWv2Wzh6PkN/hY1Z6ghxBFhNwYXKUxqXn2yTGSQjlwOAg5zkh2Iy8iCRzQN5
 +zOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697211868; x=1697816668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JF3gom/LuvopelDxpX2buDCD4c3QpVtGIBWgdmUxuOo=;
 b=D5gl9D5Aexyb5IYgbJOfumlVlMfvJgi8g1hZ5p6TtYcs+On4NDTHgYFYcjdhlmq3c4
 IIiD2V7JNXj3QxbNpJVlO0Okc+WGGd0E2iTCtYiQtYUA6/09EaOpy9uJF0kglorDo4rD
 53uhLWuOD5MhFtMzGYx3+VwXU0hkGnjuNBiR8GV2fyfRO661hT8uVorMdyKChH6tF2yT
 AqSsUuGeNlabEnHX51LbjM/vsOnoHvIcfIQZEr9zjSi1MqoaenngwkEDbRK3zNio/P6m
 sD+AHITmlIlTjzhk32Wrsn+tzVUwcWm4vIhPjmm8yFFGpu66UUgd1oyODqW+M3qRngcH
 1Uog==
X-Gm-Message-State: AOJu0YwFZDo7jMZPQKEabIWkUHY4rJ4A/Zr2DyR7RKFIjpptcNxCZWsQ
 jwDi6HJ4SqmSiiBLJLKgU9eGOd96lco3e3oaixg=
X-Google-Smtp-Source: AGHT+IHSJ6SmMTPMWXMyLbO0txEAG3B/6jS6oFpfhneLCwwBf3a9iANMVnQa2fz2xO6DIyLTaJONAw==
X-Received: by 2002:a7b:ce09:0:b0:405:3dbb:ec5a with SMTP id
 m9-20020a7bce09000000b004053dbbec5amr25527249wmc.1.1697211868303; 
 Fri, 13 Oct 2023 08:44:28 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 ay9-20020a05600c1e0900b003fc0505be19sm464581wmb.37.2023.10.13.08.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 08:44:26 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 14BFA1FFC3;
 Fri, 13 Oct 2023 16:44:25 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Timoth=C3=A9e=20Cocault?= <timothee.cocault@gmail.com>,
 fanwenjie <fanwj@mail.ustc.edu.cn>
Subject: [PATCH 8/8] mailmap: fixup some more corrupted author fields
Date: Fri, 13 Oct 2023 16:44:24 +0100
Message-Id: <20231013154424.1536392-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231013154424.1536392-1-alex.bennee@linaro.org>
References: <20231013154424.1536392-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Timothée Cocault <timothee.cocault@gmail.com>
Cc: fanwenjie <fanwj@mail.ustc.edu.cn>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index d214959288..477c1fae2a 100644
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


