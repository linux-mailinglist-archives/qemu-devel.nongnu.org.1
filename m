Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E127B44BA
	for <lists+qemu-devel@lfdr.de>; Sun,  1 Oct 2023 01:54:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmjm8-0004M2-F8; Sat, 30 Sep 2023 19:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qmjm6-0004Lu-BF
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 19:53:30 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qmjm4-0007vc-O8
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 19:53:30 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c186ea81c7so73587751fa.1
 for <qemu-devel@nongnu.org>; Sat, 30 Sep 2023 16:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696118007; x=1696722807;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Qyyf4f7KekpLgnFV4mRW/n+rtuPM++OlNWbEs/wnPZY=;
 b=TDACL6oyqzY/XZGojwh7T+19G8duhQULgQclSOpCoALZP+MSMIEI1Ko4pYEJ/HluZM
 7tsXtLw25wzFPjaE1zI9ATLjAAox/NPoR3wusaF0pYSWW33QL2ZdTePQONS6Elyz3EqL
 09vMlG8FAOEEbFZQfMH/Ax9s/c8IWshTMDT2tUdidRjoKfk6mtFjOBLAwKNCV7Jd5UsX
 AyFC2qHDtZng4SzonErj4zexEbvTS8VT7ondA9PddAepS5J+qEKkYDXlCrIBi1aPVLRv
 cxqxQQR+V1yW0sBytKTmDnuytNLjGhHvx7J+ajIs8I0iNPDq6PDnZn2e+y+Hl3zwvEWT
 oncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696118007; x=1696722807;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qyyf4f7KekpLgnFV4mRW/n+rtuPM++OlNWbEs/wnPZY=;
 b=JcnV9bas+atvwUSP8fx9BDVsXCu1Im73LDr0jwfQTtOKanm5WsZmDbQ9gHo2KSNuSH
 Hg1ztvuKo+b3UG6DPtB8MbOkXpCLCtmOfX2XhgwtNuYmE/rWshzV3bnM9zicRl0duhvI
 LPHxgTj1ixPqxITNFk6vaJf/4FCAh/JmVLqv2blQzdIri2jSvvMyT6RXDdO/+C8YVsMh
 wE97A0H9UJzbH/JAyYdw8Z4MtaIyIHllndfVL0AHX6Ze/TUHL5dHObA28tiqV/UWCSyP
 iT+TOeBgTFkByi+Dt8YOwcDFmFAB95lg+N7zIty1dgcziMLBFYn5q00ZJAZoKG4GRAF1
 gtiQ==
X-Gm-Message-State: AOJu0YxZIvI9kIQAeEzTuKcs8nNR9o4e5By6W4niMLBzLgjXXECiokB1
 ByqVntFu4zHTAwWfun5Vmvp00A==
X-Google-Smtp-Source: AGHT+IEStiu+gYUmtvCG3Qoflh4x3SW7m41+dhV1gvmsR2qfJ6b2wbfSJTYkBktGGf4S0aGZpQlXtA==
X-Received: by 2002:ac2:5487:0:b0:4fb:91c5:fd38 with SMTP id
 t7-20020ac25487000000b004fb91c5fd38mr5485212lfk.0.1696118007186; 
 Sat, 30 Sep 2023 16:53:27 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-8.nat.spd-mgts.ru.
 [109.252.90.8]) by smtp.gmail.com with ESMTPSA id
 h18-20020a197012000000b0050309ea3a62sm4012391lfc.277.2023.09.30.16.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Sep 2023 16:53:26 -0700 (PDT)
From: Viktor Prutyanov <viktor@daynix.com>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, akihiko.odaki@daynix.com, yan@daynix.com,
 viktor@daynix.com, viktor.prutyanov@phystech.edu
Subject: [PATCH v2 0/2] elf2dmp: fixes of code analysis warnings
Date: Sun,  1 Oct 2023 02:53:15 +0300
Message-Id: <20230930235317.11469-1-viktor@daynix.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::22d;
 envelope-from=viktor@daynix.com; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This series tries to fix Coverity warnings.

v2: fix commit authorship, add CIDs

Viktor Prutyanov (2):
  elf2dmp: limit print length for sign_rsds
  elf2dmp: check array bounds in pdb_get_file_size

 contrib/elf2dmp/main.c |  2 +-
 contrib/elf2dmp/pdb.c  | 13 +++++++++----
 2 files changed, 10 insertions(+), 5 deletions(-)

-- 
2.21.0


