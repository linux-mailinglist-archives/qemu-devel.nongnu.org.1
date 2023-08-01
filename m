Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD7076BCAF
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 20:43:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQuKM-0002an-Ba; Tue, 01 Aug 2023 14:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQuKB-0002Vk-DW
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 14:42:28 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQuK8-0008BL-VF
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 14:42:26 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1b8ad907ba4so38010365ad.0
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 11:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690915342; x=1691520142;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=pf3sXURMKne8t5u+4zvnyd9loI7aVsrtmic9rFFh0IY=;
 b=aZgzHze0tu/eiCM+urVF18Zj22Qw64k2WFA3A0k8hlRNVStczLQdWh/EdH4peNswTn
 ArQpwHary3Pw7PSXEoE9vWeCQPjeFW3QAQf+NjEQQQ0BEvsHUotefMDYxj+qiifDh8sS
 zwZFmoJ5li0kKL+JPIhefcdV+SS+NVLdFwoBbXSpqurJFXpBC8EBSd/Dw1rLRteD9qHV
 mH0O9edCoPID8ASN3fSAmdP2U/4b3FJxyiLOJHmUxP9Eu37DMaV7jNeziRb3hoYUetL/
 Itk8RqeJhLTtoagsVZKaciV/O4srsFLZHVsb08wU3dmbzS3hopQM+6o/8CfbhsoKKG8N
 XC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690915342; x=1691520142;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pf3sXURMKne8t5u+4zvnyd9loI7aVsrtmic9rFFh0IY=;
 b=TtVY3fTkDkuKr1Ma5tNGjobX6LH3Cl3j0o1UqGjujI8nOPPm1nH/6yMi9wrvbcFy3B
 d2MR6PPw7Av4Ki+vj52eteP199coTdqt2TH1TDg1pdUCFX7m05r2VzgCp8Nqfo6bNh5O
 MHazXGjG9wq1kpZ3SSFT2cCnDAdjX9uHgh8vFfjnYjl6dx8OFlrim6o/kEdsOXT/fCsG
 gVY8hyuukigZqHqKIwHvun+2xoqC+yUROEraSKf86XXUxOlrwxYrhrNUgdAzIkCk3mh8
 7xqXmzBKhOW2jhOqLHmsGRXyyVhNgSIS1neexoKpCDDJoB6GnflQCUR1n+0NQLW+cOqZ
 sX4w==
X-Gm-Message-State: ABy/qLY1OXq5CwiTBQ8I/iZoCGr8y3f209Mo1ucfNApHgLcCwoftqToX
 T7Nb3ln+3uwEudjqn1HbH/EPtqC3VgsfvEoRd6g=
X-Google-Smtp-Source: APBJJlG0Ceo6zzvcVCqrPp8bcRE7cCMbLJUwpS6xqSWGADPH4Qzqy2z96W79D3Zygc4V8V33z3l9IA==
X-Received: by 2002:a17:902:7242:b0:1bb:bb70:c23e with SMTP id
 c2-20020a170902724200b001bbbb70c23emr9981381pll.18.1690915342071; 
 Tue, 01 Aug 2023 11:42:22 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:67b4:35b2:87e2:dccc])
 by smtp.gmail.com with ESMTPSA id
 jn13-20020a170903050d00b001b80ed7b66fsm10797037plb.94.2023.08.01.11.42.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Aug 2023 11:42:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-8.1 0/3] accel/tcg: Do not issue misaligned i/o
Date: Tue,  1 Aug 2023 11:42:17 -0700
Message-Id: <20230801184220.75224-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Fixing #1800, and possibly more.

r~

Richard Henderson (3):
  accel/tcg: Adjust parameters and locking with do_{ld,st}_mmio_*
  accel/tcg: Issue wider aligned i/o in do_{ld,st}_mmio_*
  accel/tcg: Do not issue misaligned i/o

 accel/tcg/cputlb.c | 251 ++++++++++++++++++++++++++++++---------------
 1 file changed, 169 insertions(+), 82 deletions(-)

-- 
2.34.1


