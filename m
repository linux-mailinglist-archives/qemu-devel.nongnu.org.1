Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 462DC7A755D
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 10:07:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qisEV-0005dQ-37; Wed, 20 Sep 2023 04:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qisER-0005bh-QK
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 04:06:47 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qisEQ-0002oU-1r
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 04:06:47 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-690b8859c46so2086045b3a.3
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 01:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695197204; x=1695802004;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ugWmU+RI6KuJRXphjeFR5kNJeU7Hhqdcf4zIt6LNeaY=;
 b=fUOUlR6orK48hnRZiFwplkldz9gGGrP5izHFdM8xKD4Zy0BEZFUF+AToMrt4T/FjRO
 VZw1JoeiuU4IADPRxZVqy5RhUwG2bF2DXIbnoswpkcc3FFqUYnUiPXxYaJQRqoEbfR45
 7zl4ISzGH6FDffQRNiXrlW7XOZjCx9GgrkhuNSyuqIowSj7diDcgsTrgpVYKPjC4Tx+w
 A1oBzyodlTTCB5dVdmauynOLcCOcQVBBysCFsZwfwH1g7aAl2fECCSNPFxrgO6I4wlYf
 QWayE++Dw2m0yrx5+GufcQxucfMHYasvTk2kf8CQ0T9ETV5T1q+BVqshRn0B1B/GPEUX
 uSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695197204; x=1695802004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ugWmU+RI6KuJRXphjeFR5kNJeU7Hhqdcf4zIt6LNeaY=;
 b=UfMER7B3+Z8M+lnfd9gCEe5b9uDp/p/Df3H+AITgXFYclK/6B7WCpIhL/RbUS1vw4K
 YF6YVUrm22UbWtcTuexpjzoFoSmQgTniUkjpxH1t6+X1ius7a+MLHOU/us0PN32eohP9
 41rKRDt90Iqsbw3888v6asY8qAnuVVpHczyOxKXm2mWMqsMUx63to5lVqEeVombH4tAx
 +6UeHP3EeCbPYnfVEuA4jtelDjrz4noZwjtZ9M5Uu5Uegaz6Pe+7BiZzG3k+RtrXwt0U
 ZLYDFq6pz9I15lUC3ZnTJ/3PUGLwwkOJfI8F/j+WEOPcB7yltcEXkUJ9c9VUswBd/H19
 kghw==
X-Gm-Message-State: AOJu0Yzree7EIAKk3vwqE1pJdEaZazPIubaivesUmsRXZnSdzttZcoFV
 C+bWPYFY93UvjtZfrwk21+TAG9roiMUGvCCvoolqMw==
X-Google-Smtp-Source: AGHT+IE1a4jjlgDR3OPPD6bzNogKvNspUhKNAKL1181DN1A7pklyeaN2bKw+xzS8IzADNkaFRibNtg==
X-Received: by 2002:a05:6a00:c8a:b0:690:25fb:bac1 with SMTP id
 a10-20020a056a000c8a00b0069025fbbac1mr2005125pfv.18.1695197204261; 
 Wed, 20 Sep 2023 01:06:44 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([66.220.2.162])
 by smtp.gmail.com with ESMTPSA id
 a16-20020aa78650000000b006862b2a6b0dsm2378596pfo.15.2023.09.20.01.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 01:06:43 -0700 (PDT)
From: Mattias Nissler <mnissler@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 john.levon@nutanix.com, peterx@redhat.com,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, stefanha@redhat.com,
 Jagannathan Raman <jag.raman@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v5 3/5] Update subprojects/libvfio-user
Date: Wed, 20 Sep 2023 01:06:20 -0700
Message-Id: <20230920080622.3600226-4-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920080622.3600226-1-mnissler@rivosinc.com>
References: <20230920080622.3600226-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=mnissler@rivosinc.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


