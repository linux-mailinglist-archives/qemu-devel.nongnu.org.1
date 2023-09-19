Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0FE7A6899
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 18:09:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qidHq-0001s0-Pu; Tue, 19 Sep 2023 12:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qidHN-0001nW-B4
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 12:08:50 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qidHK-0004hF-Q2
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 12:08:49 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c434c33ec0so32457415ad.3
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 09:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695139724; x=1695744524;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ugWmU+RI6KuJRXphjeFR5kNJeU7Hhqdcf4zIt6LNeaY=;
 b=0XA0I1bRhoIX7gtgKYUjWyuntPcwloztTSEP54uJceyqy3GaixXcXtr/sMIPf2eiSY
 UpBUQc6x/1MnK2D6kp00o6vn5fh3p4xNi2Ls7HbErPp/RRJJCs82ovWj6jhpwr4XtMuQ
 RY0anzE0P/X4Z41m8WT2tMqX1mgNdZz0z1r5Xwgj+7VICXuvW0UcHMGW9NUBYPsmaOhz
 AZeDwTFHVaViXkyPUOpLEoqQEpgX2mXE4xbTpyCcnuGHJ7r9zgg48S1VPpuNq+qFfGN1
 xGnfksarrkVvh+h+zqWZwk2PjY92R1rpwp1P6l8BLL17foIDn9ubg+6Wq/i2rEKrmV9q
 lQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695139724; x=1695744524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ugWmU+RI6KuJRXphjeFR5kNJeU7Hhqdcf4zIt6LNeaY=;
 b=CY0Shji6bK20GZsn+ea4hlrykWgyE9EgFnG0We7sf/VRuCgEmOLO6Vw84PWbcKTlnJ
 t16Sf+SkuZeBB751poTvsq7x70iAMX48c7KM2pmh1HXuo6Px7hiffUHpXz/1FWvBrVXr
 uN6yY4s6Q4SqPNtgdQzTffWu4jfDnk2Vn1obF2lmF8ljOFVi8FQBsWix7aTG9uBTBhuu
 6j7tbTJf0g2wPHa/oQnKdLbVlKqKgJbtOicWnkGVUBl6yT5jlt4WlSF3Js6SdcXeYmKO
 EPydUoL5mcJusMeBYTw57g2qOplRcFzXZno0voXXsKRfegsLxO20ageqPpEw0gUbmFaB
 Fk0A==
X-Gm-Message-State: AOJu0Yz3OvVvAGaOXJaPKVkSvfLMpTlpD5jmP+k8nk5Kb4zmXvC2YUfo
 WWLPrSIQs569ZfoJnQrsa/vlBsyUe2mzYsRFgK/cYA==
X-Google-Smtp-Source: AGHT+IEMnigZRFyOpmGSUfIgP01c6q3pmUoxtl4Ll2aCY6jkL04hQoTUBuAOm7i5eIU7o48nq2u+rw==
X-Received: by 2002:a17:902:9303:b0:1c3:a1a8:969a with SMTP id
 bc3-20020a170902930300b001c3a1a8969amr10622991plb.8.1695139724088; 
 Tue, 19 Sep 2023 09:08:44 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([66.220.2.162])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a170902d34900b001b8a1a25e6asm8086308plk.128.2023.09.19.09.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 09:08:43 -0700 (PDT)
From: Mattias Nissler <mnissler@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: john.levon@nutanix.com, stefanha@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v4 3/5] Update subprojects/libvfio-user
Date: Tue, 19 Sep 2023 09:08:11 -0700
Message-Id: <20230919160814.3343727-4-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919160814.3343727-1-mnissler@rivosinc.com>
References: <20230919160814.3343727-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=mnissler@rivosinc.com; helo=mail-pl1-x62e.google.com
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


