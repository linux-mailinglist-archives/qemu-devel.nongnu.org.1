Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E735873B29C
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 10:22:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCc1v-0000eq-KM; Fri, 23 Jun 2023 04:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCc1r-0000cY-Cb; Fri, 23 Jun 2023 04:20:27 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCc1n-0002fp-AZ; Fri, 23 Jun 2023 04:20:26 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-666683eb028so146394b3a.0; 
 Fri, 23 Jun 2023 01:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687508412; x=1690100412;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6fNYDh2Ud2dKk0g90beaK7fcfysXZQSIjZcsfsuBSVs=;
 b=ieCXMJUQeWbAkzJvft9ob4B7ulwCBtmcICAzIUjuER7YxuqOfBfz7MONDoBjwvuz6a
 EvWl6kxShs4cDgx51T8mOuBjugs1orsY5G/yCAGfHjQTK0JjsIwZmeaGHq+Skt3J+E7Q
 CYftENiR3JAQXgnTYEq0fP4EALDt5Vy/Wy4dn5neTtzhVCCnXr4HraJoaQK0TGVCcNCj
 pgYupQrDF5ULT9DmeEWBZvEceX8JAQpl1GBzC0dk1vheXCn7jzR5aVQTMAEYZYXKfmPk
 f0K9L6hQxx5QP89jmjME+g9tvyTFZ7i4Ykh7YbmxCkToWj9XWYq7CucYtN89YzfpE8yT
 qLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687508412; x=1690100412;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6fNYDh2Ud2dKk0g90beaK7fcfysXZQSIjZcsfsuBSVs=;
 b=kugaJ8pc4H1XO4TDfm+co5YCxnV/DYOciLRSl+mbntFV7zfK73ia5t0pWs4LcYvpaH
 6GruoJLl/TUbZtYRDhg5zIhnDn1nBk+apNGFrH8gDG4aCPapblNkZusf88w46ZoPnPwa
 zyok+XavyCkGyQBR1RI1jF+k4A8GRdqZTtn5Oen23OZChCCgqb6xhXlNfOeUWu6fDARB
 sILwgW5euywQk6/RMDm4yDC6lAO/ziLIc9xRePoBBKmXgnv9dYy01e6G9Y4uYMefWogF
 m2OQKR1akaZfvq0ln+1fO/9LI1rj4G/xlZZxdEIHbzyXxAK+qrZ5fTmja5tPQEYvMjsJ
 UERw==
X-Gm-Message-State: AC+VfDzLKtBUzdGLAyADkj9ZHf8KRhBGKdq5ZkK0E95rJ5SoaMVpS4h7
 o7yr7TSITcFbo9EVvBl5a52aGJTTDo0=
X-Google-Smtp-Source: ACHHUZ6d21T917qRJ3wy7G92t4pmzoryr3mdYHUFA3W5eGnP1drbF41ecBmwyun4JxNFYy5zxzLuKg==
X-Received: by 2002:a05:6a00:2d9a:b0:66a:386c:e6a3 with SMTP id
 fb26-20020a056a002d9a00b0066a386ce6a3mr7941199pfb.34.1687508412319; 
 Fri, 23 Jun 2023 01:20:12 -0700 (PDT)
Received: from wheely.local0.net ([1.146.27.231])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a62e70f000000b0066884d4efdbsm5780604pfh.12.2023.06.23.01.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 01:20:11 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
Subject: [PATCH 0/4] target/ppc: Catch invalid real address accesses
Date: Fri, 23 Jun 2023 18:19:49 +1000
Message-Id: <20230623081953.290875-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
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

ppc has always silently ignored access to real (physical) addresses
with nothing behind it, which can make debugging difficult at times.

It looks like the way to handle this is implement the transaction
failed call, which most target architectures do. Notably not x86
though, I wonder why?

Other question is, sometimes I guess it's nice to avoid crashing in
order to try to quickly get past some unimplemented MMIO. Maybe a
command line option or something could turn it off? It should
probably be a QEMU-wide option if so, so that shouldn't hold this
series up, I can propose a option for that if anybody is worried
about it.

In any case this seems to work. I have only implemented it for books
64-bit for now because I'm not sure what all the others do. I could
try to investigate it if there is interest.

I took Zoltan's patch and tweaked it slightly (hopefully that's okay).

Also made a better checkstop while we're here because the old one
really doesn't work.

Thanks,
Nick

BALATON Zoltan (1):
  target/ppc: Move common check in machne check handlers to a function

Nicholas Piggin (3):
  target/ppc: Machine check on invalid real address access
  target/ppc: Add POWER9/10 invalid-real machine check codes
  target/ppc: Make checkstop stop the system

 target/ppc/cpu_init.c    |   1 +
 target/ppc/excp_helper.c | 178 +++++++++++++++++++--------------------
 target/ppc/internal.h    |   5 ++
 3 files changed, 95 insertions(+), 89 deletions(-)

-- 
2.40.1


