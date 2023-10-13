Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 017BF7C890C
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 17:46:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrKL1-0001nV-Sd; Fri, 13 Oct 2023 11:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrKL0-0001mJ-Cz
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:44:30 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrKKy-000558-Vb
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:44:30 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-406619b53caso23619915e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 08:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697211867; x=1697816667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m2T0u4gmN1cHtihV/ZmIU3HqihMQ44U7WMzEZKNkSUk=;
 b=uuRqHZTYyP/5diXxHTVZqwAriesVdNAOHn5/2e+UnQJ86ItnMdrX+JoBIAnTpcC9dW
 ZX005mCyWvyt6enfnQMKLL8P1EFj3vaIe/x9yUWWUEqw8QCAipuTXKFqRFM0ApZ/k7Q1
 KxlVfEUpaJpvo+t+9BIKESVq13Guh4qeE20tFemUdeQO+PRNpqph4sVWHr54dadNczDr
 I/a2RKL1HW7iHRuh4/4EmSFrnLGoB1IzzZYThba5rKo0vQ6wfUHOcaYmBekjKWpTZZwi
 1lAKypntypx90muIXmXaQEEaj5ZaDwfKNwuKF+t6r3WXFQhxXRqp8kEkeorWp8kbJYSz
 Zr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697211867; x=1697816667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m2T0u4gmN1cHtihV/ZmIU3HqihMQ44U7WMzEZKNkSUk=;
 b=wny1YfzEbDwjEU9bivZ8YwztBIFuQ3PrqNUEcdA7cOZgaEzXtPupQy2j88UCpDoy1U
 /ms5vIgbdI5q5M3DRodV8fNvzzgEbzJISYaI44wv1+LS5CyJIIo+CzWlM7nMaW42XSe6
 AeI1weV/73Lmo4tAhaM1sph+iHoH42hlNkRHIodNL4+IKsXLAdDswO3rHyI1ab/Z95Ks
 S3ez0gf0GLO+lhmvxewkTwG4SrLC6hrHL+DN2krSCQgp7XTCyF76mSdGby0vJL9LOesk
 bw9eBAe7B7JPcHXglcKuT9TcaAjvO/LLiV+tyD5boIhKprj43x6bzkZDISjTTV4MJUIF
 4OfA==
X-Gm-Message-State: AOJu0YxgXY1cAK4ntxHi0M4+CLZA54LIxykROixuGal4P73eP7GHFMmQ
 ninFTDb8eO+pH/Zd3jeU8QCWYY039rl4F1Gwgwo=
X-Google-Smtp-Source: AGHT+IFoFjlteKJVnnX8ynr+MxQhSG/29gPhVkxKARKEZzkAeI1P9IuqfUb5l0bIoZKD6g79qK8n6g==
X-Received: by 2002:a05:600c:332a:b0:407:59d2:7925 with SMTP id
 q42-20020a05600c332a00b0040759d27925mr8649215wmp.21.1697211866936; 
 Fri, 13 Oct 2023 08:44:26 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 t16-20020a05600c199000b00403b63e87f2sm462701wmq.32.2023.10.13.08.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 08:44:25 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B0D1A1FFBF;
 Fri, 13 Oct 2023 16:44:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Amarjargal Gundjalam <amarjargal16@gmail.com>
Subject: [PATCH 4/8] contrib/gitdm: add more individual contributors
Date: Fri, 13 Oct 2023 16:44:20 +0100
Message-Id: <20231013154424.1536392-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231013154424.1536392-1-alex.bennee@linaro.org>
References: <20231013154424.1536392-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

I'll only add names explicitly acked here. Let me know if you want
contributions mapped to a company instead.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Amarjargal Gundjalam <amarjargal16@gmail.com>
---
 contrib/gitdm/group-map-individuals | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/group-map-individuals b/contrib/gitdm/group-map-individuals
index d7116f5444..4bdc2731b7 100644
--- a/contrib/gitdm/group-map-individuals
+++ b/contrib/gitdm/group-map-individuals
@@ -42,3 +42,4 @@ shentey@gmail.com
 bmeng@tinylab.org
 strahinja.p.jankovic@gmail.com
 Jason@zx2c4.com
+amarjargal16@gmail.com
-- 
2.39.2


