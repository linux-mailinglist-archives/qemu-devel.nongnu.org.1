Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 020DE782001
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 22:44:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXpHT-0004wg-7i; Sun, 20 Aug 2023 16:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXpHR-0004wJ-TI
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 16:44:13 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXpHP-0007k8-Ql
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 16:44:13 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3a76d882080so2111594b6e.2
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 13:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692564250; x=1693169050;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ur4meHCyWQ1AQMyFoKi52Sob4ZjmAkssVn+7JlJ9cF4=;
 b=Mb+0yD5Wf/m1WeMn1e0kpFyetgA4ngzCfwVi25eIjAfyg8slFOHd2v7cpf9adm/BxI
 tycMkXl9Si+FMXFHtAjcn569CVBnyhCoHGVgTnTUDcIAIKo3+HammUMRc1psrel9NkfU
 cBe7fPFXjzTKEvcUA6uZ+s4YUb0jDfdUoNUiEhLXq0/w527JWb9ZzfqDCcHcXtQwMh4v
 IqozNwEqNdcwSTWa5hWRZSjzlvboteiyrHAwTOYpEbP8QtuSuTImqrlaVw1lPxiU92a+
 fhkf7OjlQZBw6T23FBNwY+ojOWzgldNSV6E4Z7gqc93D4Rk+NZjxq8JTw5UpEyQo7bJ/
 76Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692564250; x=1693169050;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ur4meHCyWQ1AQMyFoKi52Sob4ZjmAkssVn+7JlJ9cF4=;
 b=WocB1EBj1FdBNFoFqSV7KDBhEZmTsWKtCJ2oy765xy4aqjWuQ6jwE5BYZWsNu8y+NJ
 EW4k0/fUfn4RE7RjPF40nwemugr3N2edkkxwRMjazvQQuJM6rPwUqzVfgAbbxsI6bC2Z
 lj3IhZIW9ILsYYDWv14kq+k8oTqbZJp+E3k7ASeGle/aoRU1UsI1s8Xg8nILQu8lRE6s
 HXjC5pDCucCBqmxvx4RlKCW4PMs04osq83DBClJgQbgx4RFMlWWFJvY2Y9HSnsgqZ0TJ
 yEc/E26UL5Fach2+ltcPFhUoJnCV7Ps/2JAtL1mNtPg4SQZZ90NDYYbVl7A58xWJK+7A
 p8vg==
X-Gm-Message-State: AOJu0YyqDKi1nfrTwMWGtU50GmjVz2rhTSkWxNBdwcrWL5jucgDoACqz
 e/JPU1V/okkw2Acwu5c1rylFj330iM7eFQkpgds=
X-Google-Smtp-Source: AGHT+IGnjFEnKQ+gTW1wJVadi+AwMzN1hhCxi79ttv5ZXm2+cUBc/MKiUuNclG2mcfl+8ccMq9Q4ig==
X-Received: by 2002:a05:6808:41:b0:3a7:b3e7:54d1 with SMTP id
 v1-20020a056808004100b003a7b3e754d1mr6978833oic.45.1692564249895; 
 Sun, 20 Aug 2023 13:44:09 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:347d:4d37:bdd7:f5e5])
 by smtp.gmail.com with ESMTPSA id
 c7-20020aa78c07000000b0064fde7ae1ffsm1430149pfd.38.2023.08.20.13.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Aug 2023 13:44:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	imp@bsdimp.com,
	kariem.taha2.7@gmail.com
Subject: [PATCH 0/4] linux-user: shmat/shmdt improvements
Date: Sun, 20 Aug 2023 13:44:04 -0700
Message-Id: <20230820204408.327348-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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

A couple of points I noticed with bsd-user copying linux-user:

(1) Make sure to remap memory for reserved_va
(2) Use something better than an array for tracking shmat.


r~


Richard Henderson (4):
  linux-user: Move shmat and shmdt implementations to mmap.c
  linux-user: Use WITH_MMAP_LOCK_GUARD in target_{shmat,shmdt}
  linux-user: Fix shmdt
  linux-user: Track shm regions with an interval tree

 linux-user/user-mmap.h |   4 +
 linux-user/mmap.c      | 168 +++++++++++++++++++++++++++++++++++++++++
 linux-user/syscall.c   | 143 +----------------------------------
 3 files changed, 176 insertions(+), 139 deletions(-)

-- 
2.34.1


