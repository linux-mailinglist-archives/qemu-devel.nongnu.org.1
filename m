Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DB17D7A3C
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 03:40:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvpLl-0001sR-LV; Wed, 25 Oct 2023 21:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvpLi-0001rH-54
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 21:39:50 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvpLg-00033z-2T
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 21:39:49 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c9b7c234a7so2757735ad.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 18:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698284386; x=1698889186; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3Ac4bKXSMeM5uVC6CTO1z9nXWFNWqWVCu3/+uN4eO3k=;
 b=DzFNjuPUMbz0C3nEzorNxI4kK9c3OTBnDDfzdz5Vqie2dF+6UVBncDL774MH5fwgEW
 5nmuq/OIgbc+Y9WLi3RIG7zFyH99T99YXT3V027SGQZEaSNIzOyIWJUkmSfeFBT+0RWZ
 RRvW+kdPt83eH0SIAqU8DVN7uFy4TSDO6ho4YFMw8s5rt0B4/yNfJa8iDsbRqs+7+AJs
 /pRvoEtv5csIU6QYng5LZsPAyYZnnogB2G78X7XU/GnEIdEPGMNyfQ6S7WryIHHhNR+4
 DYSYT6E4GV9NwKttd9BkCYz2p2DHLvPbaSivLzQC8qpeX1rspB4wNT77D2ihDcDmv5j5
 mpcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698284386; x=1698889186;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3Ac4bKXSMeM5uVC6CTO1z9nXWFNWqWVCu3/+uN4eO3k=;
 b=Bkh4srVEIhfVzly5jRfOwUVMJrUCtn1QYURbvCYfS8U5o63bFhFR43xLwDzHJtXzeD
 lZSCS+wJVipHIBNMGlFvxvgs1H4WZmncJ02JF3BSFhd6LEVkMqX2S6hyn0fmCMsyQNkN
 z/HkILos22MwrnZxVwGyo/7k+VuhqUY7hvas+Wmn2gWab1lJpe9ftshYNv373eW2ePCq
 HnSjakSSfQbtzGnib9shY0Yz7SxEidQK6L0uRBENOlPDV+aYeW4TPXSavba3/8bo+SzA
 tCgciumhh8FN/SBbLSR1dGWxBezdAJtz+B1lljC+j4svZg/qH+paY9yulOKBLyJUArqd
 6vuA==
X-Gm-Message-State: AOJu0Yw6RYWORmaitKCI1rINiFdFpWA89lUMyZr/AoHK0Ei8Y1bNsNe5
 I77pQsU9b/hjgznraSFaId6TUOFA9hY4Rl0+O8g=
X-Google-Smtp-Source: AGHT+IEjzHuYkF4BR4oE7CReVUFlmo9WI2f3eQqh+D7RtAawUFhv937iu/EWbRXNtTxtzA3nu6ZY7g==
X-Received: by 2002:a17:90a:d407:b0:27d:7ebe:2e8 with SMTP id
 r7-20020a17090ad40700b0027d7ebe02e8mr17986103pju.9.1698284386512; 
 Wed, 25 Oct 2023 18:39:46 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 y6-20020a170902864600b001c0c86a5415sm9817032plt.154.2023.10.25.18.39.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 18:39:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH 0/4] tcg: Canonicalize SUBI to ANDI
Date: Wed, 25 Oct 2023 18:39:41 -0700
Message-Id: <20231026013945.1152174-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Supercedes: 20231025185956.72677-1-pbonzini@redhat.com
("tcg: allow a target to request canonicalization of SUBI to ADDI")

Based-on: 20231025072707.833943-1-richard.henderson@linaro.org
("tcg: Introduce TCG_COND_TST{EQ,NE}")
There a couple of optimize.c routines introduced which I use here.

The final NOTFORMERGE patch suggests that I've caught all of the
cases, but I certainly wouldn't want to merge the assert without
a lot more testing.


r~


Richard Henderson (4):
  tcg: Canonicalize subi to addi during opcode generation
  tcg/optimize: Canonicalize subi to addi during optimization
  tcg/optimize: Canonicalize sub2 with constants to add2
  NOTFORMERGE tcg/i386: Assert sub of immediate has been folded

 tcg/optimize.c            | 35 +++++++++++++++++++++++++---
 tcg/tcg-op.c              | 25 +++++++-------------
 tcg/tcg.c                 | 49 ++++++++++++++++++++++++++-------------
 tcg/i386/tcg-target.c.inc | 13 ++++++++---
 4 files changed, 84 insertions(+), 38 deletions(-)

-- 
2.34.1


