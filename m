Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F2973DD10
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 13:15:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDkBk-00034J-BI; Mon, 26 Jun 2023 07:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDkBY-0002xB-Ga
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:15:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDkBU-0000ZR-AN
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687778103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0W8NdMue2w0PHMCwCzmpD+VGR+2VHcU3d8NE23hGmkY=;
 b=N+8NoOkeOFIzvIBt84N7U0nBaxBjjLu5KRa/XC1t0t/ACmGEFhRx0vfiHJwiQTywdh+PWV
 kEbA//TRMK6rNhZAToSBm2tAj0hts2Zq9BZe1tpJxk0ASreT0mEfw75bOWkEAqb2FCGLTV
 pgu80PvDtsBNZGkhG+Zp3arD1f7iDJo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-Vg0qnGHoOluZUTd1Ho93sw-1; Mon, 26 Jun 2023 07:15:02 -0400
X-MC-Unique: Vg0qnGHoOluZUTd1Ho93sw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fb40d0623bso1078545e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 04:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687778101; x=1690370101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0W8NdMue2w0PHMCwCzmpD+VGR+2VHcU3d8NE23hGmkY=;
 b=RHFzuPUzCgaAKTCrYg7bfuIoOaV0rB16TpYgxgOp1Mu+DUQ3XGxk3mO9Pac9awgPlH
 BKyE7XtG3y3+uNUMltATiAKbIWflylZDc4G9vLGdAUwHgMLmQWbbK3Bo/a79qxn9elXf
 +tUNf3pmYapV4UD920hrB7fImOyfrqDtotOzT6ghjqXiWkEW2XVpKhVb4K1elvQROEIY
 i6jQqdZ8lP02vPPGrx/Y6EPZ2rr7vcmaPgaPwi8bFd3k/xyzx+gnfTbrXq13D2BPr+jL
 X2WYmBJhvLyvSst6gH05whFmg0DaU8h3TW7t6Nvs8fATj2lO2QOaT25QVX2MyBUGREca
 8E8w==
X-Gm-Message-State: AC+VfDy6ehR6VVbrB2dsyPXmce6OJcAgdjBE59Ju2OsW6Nhfx5ReZ9P1
 QMwGdEHnBb7NEiyUs2QvGMH605tSVePmY+M03Bb1TzbwPQT1prT0+gFDOV7l1XdjjfPpFjgwmDs
 B74cIq+AMoEiSajSiUESUNmMeizBjltmJ91zpgQ7d00gszP9TAeK5YWKABmEWloQym1ln/qffrM
 Q=
X-Received: by 2002:a1c:ed10:0:b0:3f7:e660:cdc5 with SMTP id
 l16-20020a1ced10000000b003f7e660cdc5mr25211542wmh.9.1687778100895; 
 Mon, 26 Jun 2023 04:15:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7qMb//GePSK234b6jmqJny3RPXng8f8aKGZiJquZ2QmGrwljhE9T6OcFsO3rN/1EjNqnc+nQ==
X-Received: by 2002:a1c:ed10:0:b0:3f7:e660:cdc5 with SMTP id
 l16-20020a1ced10000000b003f7e660cdc5mr25211529wmh.9.1687778100632; 
 Mon, 26 Jun 2023 04:15:00 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 y17-20020a1c4b11000000b003f90a604885sm7373639wma.34.2023.06.26.04.14.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 04:15:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 09/18] target/i386: TCG supports RDSEED
Date: Mon, 26 Jun 2023 13:14:36 +0200
Message-ID: <20230626111445.163573-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626111445.163573-1-pbonzini@redhat.com>
References: <20230626111445.163573-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

TCG implements RDSEED, and in fact uses qcrypto_random_bytes which is
secure enough to match hardware behavior.  Expose it to guests.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ff3dcd02dcb..fc4246223d4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -657,11 +657,10 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
           CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ADX | \
           CPUID_7_0_EBX_PCOMMIT | CPUID_7_0_EBX_CLFLUSHOPT |            \
           CPUID_7_0_EBX_CLWB | CPUID_7_0_EBX_MPX | CPUID_7_0_EBX_FSGSBASE | \
-          CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_AVX2)
+          CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_RDSEED)
           /* missing:
           CPUID_7_0_EBX_HLE
-          CPUID_7_0_EBX_INVPCID, CPUID_7_0_EBX_RTM,
-          CPUID_7_0_EBX_RDSEED */
+          CPUID_7_0_EBX_INVPCID, CPUID_7_0_EBX_RTM */
 #define TCG_7_0_ECX_FEATURES (CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU | \
           /* CPUID_7_0_ECX_OSPKE is dynamic */ \
           CPUID_7_0_ECX_LA57 | CPUID_7_0_ECX_PKS | CPUID_7_0_ECX_VAES)
-- 
2.41.0


