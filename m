Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 150D07DE165
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 14:17:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyB5a-0000KH-I6; Wed, 01 Nov 2023 09:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qyB5K-0000Ht-A5
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 09:16:40 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qyB5D-0003dP-1U
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 09:16:36 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6d31f3e8ca8so172711a34.0
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 06:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698844590; x=1699449390;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ugWmU+RI6KuJRXphjeFR5kNJeU7Hhqdcf4zIt6LNeaY=;
 b=08zeba/S+dn2LGCOL0okQIUIBVn/eRmkpIiW2oC6m2v941oQ4DQurbYuuk9PC58gbX
 ohodhw1XhrYYpljrvacp+wwJLCzVjJnOI7og6mLltjxttUXEmVmoVRxj7ORvAPkxehET
 F+LSITTC83GcOCCiQ2gI2XPYwynFH8U2kSvx8meVwcM+UW66pYu4H45E7N4Ew9eJ7Rps
 DH2KugxVA9DawsdYJsKhdtsVkbz6GW9KQ4vWkjvUzeYf6lezs9stDUrYChXFH+swc2bw
 brGqvljnp08IbLfBTiPABWUUzKGUF5zuuIIekPynziTph52mRpeOziwdeAr4okqmOwED
 NuOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698844590; x=1699449390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ugWmU+RI6KuJRXphjeFR5kNJeU7Hhqdcf4zIt6LNeaY=;
 b=Y/Ww+HQcczx28XKgK+KpvnkfamK66lP2/CXEbRE4XylnjkfonG/38tI5LtnnMv2wRo
 RqHbPuMC09xOpUqx38yq4iOPbsSKWsmVtOU093imwvxvtTkboG1Fwo5U/ZOC3E5jBqK3
 wQsSQSo78DqVKDzIjcZq/AWXtIatmyNGrUrUAdr628eo7BQUYqMMTFDoRKVCeKrCIIDl
 iTRIklyh5w237CrL5OpwTvCt3yS7CMXc8+LY8Z3QjQS+6fVXJv5HQfZhTLOtJzmMsvx1
 tRmR5H3VzMw9eWpYMprh2zNAqZ8udVjRhlEIP9y9hbTAVDjzMaBmdUIJyp2rfkBF57hk
 k81g==
X-Gm-Message-State: AOJu0YxqOwgF5dwVPLaI4P6COHfucOOp0A1oh0aJu5KLt4ci5f18Dq84
 JLPqDz1wB+4KBFp1FqBuoVL/5Q==
X-Google-Smtp-Source: AGHT+IEP5Q8DivA0tzeg44pVx0YgKFNh0PvTvuOG6RxbCjwy7n0x95B5TNTcAflKx0ZjEr8i8phxyQ==
X-Received: by 2002:a05:6870:32cc:b0:1ea:cdcb:5a2b with SMTP id
 r12-20020a05687032cc00b001eacdcb5a2bmr18687360oac.54.1698844589990; 
 Wed, 01 Nov 2023 06:16:29 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 y6-20020a056870e3c600b001d4d8efa7f9sm238148oad.4.2023.11.01.06.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 06:16:29 -0700 (PDT)
From: Mattias Nissler <mnissler@rivosinc.com>
To: stefanha@redhat.com, jag.raman@oracle.com, qemu-devel@nongnu.org,
 peterx@redhat.com
Cc: john.levon@nutanix.com, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v6 3/5] Update subprojects/libvfio-user
Date: Wed,  1 Nov 2023 06:16:09 -0700
Message-Id: <20231101131611.775299-4-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101131611.775299-1-mnissler@rivosinc.com>
References: <20231101131611.775299-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=mnissler@rivosinc.com; helo=mail-ot1-x330.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Brings in assorted bug fixes. The following are of particular interest
with respect to message-based DMA support:

* bb308a2 "Fix address calculation for message-based DMA"
  Corrects a bug in DMA address calculation.

* 1569a37 "Pass server->client command over a separate socket pair"
  Adds support for separate sockets for either command direction,
  addressing a bug where libvfio-user gets confused if both client and
  server send commands concurrently.

Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
---
 subprojects/libvfio-user.wrap | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/subprojects/libvfio-user.wrap b/subprojects/libvfio-user.wrap
index 416955ca45..cdf0a7a375 100644
--- a/subprojects/libvfio-user.wrap
+++ b/subprojects/libvfio-user.wrap
@@ -1,4 +1,4 @@
 [wrap-git]
 url = https://gitlab.com/qemu-project/libvfio-user.git
-revision = 0b28d205572c80b568a1003db2c8f37ca333e4d7
+revision = 1569a37a54ecb63bd4008708c76339ccf7d06115
 depth = 1
-- 
2.34.1


