Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F757C8900
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 17:45:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrKL2-0001ni-Em; Fri, 13 Oct 2023 11:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrKL0-0001mH-D1
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:44:30 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrKKw-00054r-Uh
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:44:30 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-32d849cc152so2127052f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 08:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697211865; x=1697816665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hWNFCYkSUHyvxvoI8oXqjN3ZQ93uyYjNddqMnmk3BMM=;
 b=d77FCgITAWshbEGjfwfQA330g3juHufBaaAhv3DZTnEESKhU6ryEitG0LxFWNQ5IJn
 TexFviGPXfkucUCZ/auhETDPCxOTXPaEO0+BhKaC5OxxsMJ4o6XpL0zZQXTOBlUX4nro
 6mGjZWgnuu2yWpZc2GbrnFOCAjdSGm5cou7mEg8tFA7nueyCQrD0vRLldLJwoFNQmFmM
 tHIz0sy5c/XeFJWO/wvwxumdRZb1bUGXY1JnXuDzW4lGbDRay3adYhxJyNNK/wDAmX72
 0AoYCDx5ryCSaSHBfRTiKbKKoRRcUWVyYYDd2ASdjuEFKmyJyAZvOZ/gQOWogmVS7kAQ
 rbqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697211865; x=1697816665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hWNFCYkSUHyvxvoI8oXqjN3ZQ93uyYjNddqMnmk3BMM=;
 b=LfCmYYWdnTS1o3kg0y4kztWAVkWOUzEdfkzWKvMLnNoRZkFxSFaWu3qrw7r0BPqWNo
 xN7Obw987LWThsPadgeTM8nHHoWZEBE2xrUboUFIVZI4JTnKsVubh7k6R4rQ0Ei0zRlx
 CsfC8VgvKTDvN8atMRqyX2XazT/85JyJrtiIFvZvI7pug8n0/rDr6Yb0bkXJvV5IUoFF
 Po2SsFJEr1iJKSrmgCpTKA0fzipvl4fvmVTZHlhtexoFqD6HwUl8ALeiN/CqlSFndMgt
 WF0oUPcJjy0CWOPfjoiW9NIE6WmJGsVbCW/9Nl6rUCo26L5ig2H0SxjAJgWQRKvrnxmL
 MRqg==
X-Gm-Message-State: AOJu0YzISjxAs0Tow/xEqNon1G19eeJdZIGQVIBtDd8eQ9ku/SBAHoRa
 n2bqoBM8TbmLMqfy8BXWf8FFz0vmoKfb6qgL7xk=
X-Google-Smtp-Source: AGHT+IFhLwsy6ekxGv3xZwrnLJ4G6fshMU7MTc75gF0fD/P2+Jc0UYOJaq5wUfHEbR8SEmL1AJvP6g==
X-Received: by 2002:adf:ed8b:0:b0:32d:9579:94e3 with SMTP id
 c11-20020adfed8b000000b0032d957994e3mr3298147wro.6.1697211865258; 
 Fri, 13 Oct 2023 08:44:25 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 e6-20020a5d65c6000000b0032326908972sm4984636wrw.17.2023.10.13.08.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 08:44:24 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 68BE81FFBC;
 Fri, 13 Oct 2023 16:44:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 Dao Lu <daolu@rivosinc.com>, Andrew Bresticker <abrestic@rivosinc.com>,
 Vineet Gupta <vineetg@rivosinc.com>
Subject: [PATCH 1/8] contrib/gitdm: Add Rivos Inc to the domain map
Date: Fri, 13 Oct 2023 16:44:17 +0100
Message-Id: <20231013154424.1536392-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231013154424.1536392-1-alex.bennee@linaro.org>
References: <20231013154424.1536392-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

Whatever they are up to a number of people for the company are
contributing to QEMU so lets group them together.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Atish Patra <atishp@rivosinc.com>
Cc: Dao Lu <daolu@rivosinc.com>
Cc: Andrew Bresticker <abrestic@rivosinc.com>
Cc: Vineet Gupta <vineetg@rivosinc.com>
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


