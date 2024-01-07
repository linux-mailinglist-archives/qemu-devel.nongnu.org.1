Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E25826539
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 18:03:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMWX6-0000h4-Py; Sun, 07 Jan 2024 12:01:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rMWWy-0000Sg-0m; Sun, 07 Jan 2024 12:01:53 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rMWWw-00075L-IX; Sun, 07 Jan 2024 12:01:47 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-28be024282bso510507a91.3; 
 Sun, 07 Jan 2024 09:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704646904; x=1705251704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uhq4cqVst5wOeiM+A3ZvuIpPDrIGmY8oPrygh7VrYew=;
 b=WUYlfbE0w2rjJuOn0s0wBipoCfJiLuDPgSv+WqNBSa2JIu0A8SLevhNdW1mR7mbh/t
 MrfAFgPiJTCRJWdy9q3F34iGyQrQP6Etn9T70J8Hs61ywl8Dx0llTrgAE7wskRlWMysU
 qu4gxBvVueyFFI4MSyLVel39IsxJjH4BiDdIXkw73Gz62AGrFsQJ8wtuVSydOALFtubs
 5MlAyl5rtOcradnjHZdqHfHW0PicJzb8EGVw9pPHGpDmNsgmwWy+vrQb8sxAsPiQpEyC
 Fu85RaRqp14JSWVBcFWWMVueq3adR8JqMfly6Zv5HDti8T+B8Sb20pgYvcCmmCeQdasC
 ZGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704646904; x=1705251704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uhq4cqVst5wOeiM+A3ZvuIpPDrIGmY8oPrygh7VrYew=;
 b=lqAwxiwv+jtC6xgEsBhXa2a54eyXe63N7DigQim0TQIgqRboLtWAMxHjGo/OxgZR65
 mrpMBWjvsM0bS8FvEKLyhmDO2RDt/bLNe+pDlQVk1TtLSmgSrn8PBxjNzIEJQYx1ai2t
 25azRuDdLJloTccSu58g0HTMezaNY9mOp1f9l4zB7KOrZNIoMvTFqsY9GS7vnWKNp5ZT
 Q0zwDo/M5RK6QQPQUg4PpB1pxDNtWZk7iBy6YBKMzj/g0CPgRdeQ4kDwvrHyN2dAZT64
 tPDxLr4tzyBA/STxy4Bf255ihazVA1mZ8OWsbcXRljyjnIMp4ZB9fuCBvjeMQkaRxCw4
 3BFA==
X-Gm-Message-State: AOJu0YwVFMgwoG13kDbEfWfDwbDHon0hgXRGAoZV1uYrmBd6dYixQPM5
 bsRfVi04BjoB1VdfW/UakbIBpmYiXdA=
X-Google-Smtp-Source: AGHT+IFA6giLZ+u+pgGHuYba9TpYTl4/KY5RkpEgxPDbiY6WImq3POEK7o/Yt9effmQCRX78712zjw==
X-Received: by 2002:a17:903:495:b0:1d4:2266:64bf with SMTP id
 jj21-20020a170903049500b001d4226664bfmr764949plb.52.1704646904244; 
 Sun, 07 Jan 2024 09:01:44 -0800 (PST)
Received: from wheely.local0.net ([203.87.79.144])
 by smtp.gmail.com with ESMTPSA id
 c9-20020a170902c1c900b001d3ea8ad878sm4632883plc.290.2024.01.07.09.01.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jan 2024 09:01:41 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org (open list:S390 general arch...)
Subject: [PATCH 1/9] gitlab: fix s390x tag for avocado-system-centos
Date: Mon,  8 Jan 2024 03:01:11 +1000
Message-ID: <20240107170119.82222-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240107170119.82222-1-npiggin@gmail.com>
References: <20240107170119.82222-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1031.google.com
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

The 390x tag should be s390x.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 .gitlab-ci.d/buildtest.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 91663946de..cfe737aca2 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -184,7 +184,7 @@ avocado-system-centos:
   variables:
     IMAGE: centos8
     MAKE_CHECK_ARGS: check-avocado
-    AVOCADO_TAGS: arch:ppc64 arch:or1k arch:390x arch:x86_64 arch:rx
+    AVOCADO_TAGS: arch:ppc64 arch:or1k arch:s390x arch:x86_64 arch:rx
       arch:sh4 arch:nios2
 
 build-system-opensuse:
-- 
2.42.0


