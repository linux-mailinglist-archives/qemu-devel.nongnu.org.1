Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE8973FD27
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:48:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE92E-0005RV-A5; Tue, 27 Jun 2023 09:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qE928-0005Ps-Jt; Tue, 27 Jun 2023 09:47:05 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qE927-0001Im-0A; Tue, 27 Jun 2023 09:47:04 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3a3373211a1so285234b6e.0; 
 Tue, 27 Jun 2023 06:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687873620; x=1690465620;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Kyep1n3Keean0L8NM8PiGLccMF8dyHy+RpfGW9V1U4s=;
 b=Tkc6DP7Yt/D+rTtCqnkfKf8yD0HgXymWysAEKx31qSXJLy4h0mRCBAPsTvK0WX+iAP
 jW3HJFG7KNZuBAUNPS398jT92gqCwRSlHZWh1DZYp+SJKmXFlkuRdoGFuUeqxndqrywR
 2kfmc4if01Zq9I7Qtmp7s5pgBZ/KYoe3EmN+4UxsIGsLj5bW+IrhJEydnqZ8/XxykSJ8
 qd5OwKOBWLPRjWYBsQaHgcryURyCoTNGfjcw4KHhlkJ3LNPWD03VRu4QCf6M1rdvgQps
 0rCvnoYDlPH51NO2c6udPCjKmT4HHznzpN0EEAHChPKd2qtZQPDCcV2XEmziDRrNxSEd
 WhkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687873620; x=1690465620;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kyep1n3Keean0L8NM8PiGLccMF8dyHy+RpfGW9V1U4s=;
 b=YJJo4tWmLKxtPuFCPVg4KMINtbDcT9jEmk6sYbe4e0c4Zonh9AM5qhsKUOFfq6/7lw
 Z3de3/lYbytij/Y6UTysn2xIKkBtA7K8HH64z8VeadW1j3wo/uY8mohzojX1/uBD57nw
 YxuXjopmdqgj7XN65dSeDYZ43Wy2JXYsDnmIVHG8wwZeLkDw82bJt6fxUPdMjJF2wDJv
 AADkfFrpITxRhWpSUf9Kczoh+/2H0XSIXlPxDbrv/dNOVH/f4ocPWhF8WKqG9PPuOz87
 sGcThhVxzlSYCPzVFADnuF8Ww02iu5p+Ccyb3w2qP30RoioMEnos30qkqYzvnybW30FR
 P5YA==
X-Gm-Message-State: AC+VfDygpOfTJRSm+D1FZVDEbCkiXvoWvWNBIUKJz6zx3w7EdhKFXGmG
 Lpev6+5ptB0bM2o6y8ab+NuFst7iV1I=
X-Google-Smtp-Source: ACHHUZ4zwn1CVILBRHTub4QDNc2wf6U5vB28tOHkxXezLecKAh8Pq/GDoRc2vAbgiNZZfyrX3HVMQw==
X-Received: by 2002:a05:6808:2392:b0:39c:475e:d78a with SMTP id
 bp18-20020a056808239200b0039c475ed78amr39612490oib.17.1687873620238; 
 Tue, 27 Jun 2023 06:47:00 -0700 (PDT)
Received: from wheely.local0.net (193-116-109-121.tpgi.com.au.
 [193.116.109.121]) by smtp.gmail.com with ESMTPSA id
 d9-20020a63f249000000b0051eff0a70d7sm5741384pgk.94.2023.06.27.06.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 06:46:59 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v2 0/4] target/ppc: Catch invalid real address accesses
Date: Tue, 27 Jun 2023 23:46:40 +1000
Message-Id: <20230627134644.260663-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Since v1 I squashed a patch (and wrapper function) out, removed 970
to POWER8 invalid real address checkstop, added attn implementation to
demonstrate sharing of checkstop, and made some fixes to checkstop
mechanism so it stops on the instruction causing it.

Thanks,
Nick


BALATON Zoltan (1):
  target/ppc: Move common check in machine check handlers to a function

Nicholas Piggin (3):
  target/ppc: Machine check on invalid real address access on POWER9/10
  target/ppc: Make checkstop actually stop the system
  target/ppc: Implement attn instruction on BookS 64-bit processors

 target/ppc/cpu.h         |   2 +
 target/ppc/cpu_init.c    |   1 +
 target/ppc/excp_helper.c | 181 ++++++++++++++++++++++-----------------
 target/ppc/helper.h      |   2 +
 target/ppc/internal.h    |   5 ++
 target/ppc/translate.c   |   7 ++
 6 files changed, 121 insertions(+), 77 deletions(-)

-- 
2.40.1


