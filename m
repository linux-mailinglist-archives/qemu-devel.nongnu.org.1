Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB177ADE9F
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:26:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqHa-0001Go-JU; Mon, 25 Sep 2023 14:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHU-0001DH-GP
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:04 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHS-0007Hq-Ue
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:04 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4053d53a1bfso58991595e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666360; x=1696271160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aNQ9mDc3plWciIdjeE5Tzw1D9iur6gZpe1I8Oy7Sjl4=;
 b=Gf2bO1uzD3KT+eUQ9B6HFxU2Mn8VHDdUHL1Uli9wGoFSZiivRGUgq3XORlLees9fUo
 y3sZvQwK0d7X7SFaddGCNAzAi2zO42T6wzKHxCWwVVuOIHI9qtGAmjNSAHiljR/doFAk
 N+xP86iavvQjyl3dD/i7atrW4E8wsdJptX/79ajXIlMdNwTw7vq2vRaOg+1326NvOlIH
 Zx+AHmiU/255fDW/trfpsWjo9ohpXV+7F0U6eI/hmDhqA36VWnB6fL37snbcNVRbTquH
 /iBQ3Gmx0nf6BDz6G3q2Paex9QiPBsPyREsS+rROp7KThEo5lpULLcbGL56YgMK6slO6
 1bVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666360; x=1696271160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aNQ9mDc3plWciIdjeE5Tzw1D9iur6gZpe1I8Oy7Sjl4=;
 b=VkPYwwMHrGsaAvhyizVj9W5sK2o669nLRXV0x5bKt+AI7h32blpuZBd2/ScAZG43a9
 NBqjLWWrMNNEm9qj+WJBeC0SdCBtvLArtmdlCYGEkcRGLxCSXK6javiSsq5NuO8k6g8C
 s9KZziDwneHw3bKSRUIdvEfjS3WYa0gubjP9Eo2dpmG4M3+OSgljFr9hLtxEVMTKo7e7
 BzhYD9AL3l2bMv/pAKgo8Vhdx3SJoc0/WaNW8xoZ519JySV+9xeGP8IzG3mGoSHHR8Vz
 3F6rsX/lViJr0qg3FbPI9q1U1S8H8/gpEoXluKY3YyqBtgKClXB5eCpk/E84MAdFyFV6
 3eDg==
X-Gm-Message-State: AOJu0Yz9spUC+cZIDo0gjIJR75IbXRKZUfaG5XiRlXD1tZ82jWBzMon0
 h5CjjSymmEh27GbsMNYJeP2quRIkAo4=
X-Google-Smtp-Source: AGHT+IFjuQIzcg4wUE3ICcYayg/kGTtTJQtg2R2hA/jRT/TlNH2omTfumX3VjXutcpsN8zw0t6dJ/g==
X-Received: by 2002:a05:600c:3b89:b0:405:9666:5242 with SMTP id
 n9-20020a05600c3b8900b0040596665242mr1264107wms.31.1695666360137; 
 Mon, 25 Sep 2023 11:26:00 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 19-20020a05600c229300b00405953973c3sm2232858wmf.6.2023.09.25.11.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:25:59 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 07/28] bsd-user: Implement target_to_host_rlim and
 host_to_target_rlim conversion.
Date: Mon, 25 Sep 2023 21:24:04 +0300
Message-ID: <20230925182425.3163-8-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
References: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32e.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-proc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/bsd-user/bsd-proc.c b/bsd-user/bsd-proc.c
index 68410a0aa9..19e39a2f76 100644
--- a/bsd-user/bsd-proc.c
+++ b/bsd-user/bsd-proc.c
@@ -38,3 +38,13 @@ int target_to_host_resource(int code)
     return code;
 }
 
+rlim_t target_to_host_rlim(abi_llong target_rlim)
+{
+    return tswap64(target_rlim);
+}
+
+abi_llong host_to_target_rlim(rlim_t rlim)
+{
+    return tswap64(rlim);
+}
+
-- 
2.42.0


