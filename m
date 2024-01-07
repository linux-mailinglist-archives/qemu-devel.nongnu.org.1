Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6368263F6
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 12:56:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMRkX-0001Zz-2v; Sun, 07 Jan 2024 06:55:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rMRkT-0001Z9-9G
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 06:55:25 -0500
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rMRkR-0004oO-81
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 06:55:24 -0500
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3606e69ec67so11337175ab.2
 for <qemu-devel@nongnu.org>; Sun, 07 Jan 2024 03:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1704628398; x=1705233198;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BsJq+08/hy4tw8C3+mb2XKFWwfEKRHLLO2SaVLiSMJI=;
 b=NWVxJGp9vHBVzQ1PDo7hwGDw58gKfamY+vl8at0+4OE1gjTjaRMTqCoPaEoJyZEfU6
 7tixLIvbTOMOB6q693Y0zUSXTa0KMmX0Su662V120zkBEYK4zMvIUC0lSBCJ9J4ij2TX
 C+PFn2qOAQ0Hq8ZZlwcKznT3hFm1IKll+llkjDKQTw916Ee8QSvTiKXwxB1z00t3os2j
 AMk8tY3x7JVKCfP8vUp/R3xF4EK6pImCJGEFgtT3HwYtvgmiGLmhQykuvcqHmUoA7gRI
 UnKwEAnfmeEhaoWpI0bEKnydR3tUq9gyk5fY5F3pSGe/0yyWJLKdPn7ceUhlTkunUmpU
 gq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704628398; x=1705233198;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BsJq+08/hy4tw8C3+mb2XKFWwfEKRHLLO2SaVLiSMJI=;
 b=viy0f+SUcpncb4U/PjszCtIR4pC82u0puda1+PnL12sNgXQL52FSUE9iqVh9F6smex
 gtCiNqZOp/RDlDav36+kb3WYZSPmR0ScrKPpHp3tE1WqPy50PVa8RnuPgWtQ+oZY1fwi
 MYprIKCEqpvTituky2Mgw9sWNiba/s19vRwPE9O6Z932OIAIdY0vjMGUZ7WkBJfJov6H
 vgGwU+dFKBfkfMDVNufmtAyhN0iTgvhO7UaM+bbde/8GrzNKpyqIjR+OHnfLhzjyA0Jb
 JwqqHCi8cEjP7Pydn3MsFiwlVagD1xUps53TsFvp8/hKTycIT8TVb7OaSBGlc2Cp+oJo
 bs1w==
X-Gm-Message-State: AOJu0YymvbmyEeSjF6k6w2dhZSFRuxwVRc1hARKRY/f1MJyWbw0T56bB
 h/Q7N43KnWd+XK5IaxjGtJVBfwpxBWvhUyIC8H1vNHSyBQo1wQ==
X-Google-Smtp-Source: AGHT+IHjVDt6KilRn5ncOv9fR3d3mDDHS3KRTh2fUBrB8tLKPAlWGqI0+i9+hxJZy6IMQWdThiNKFw==
X-Received: by 2002:a92:ca08:0:b0:360:615d:5612 with SMTP id
 j8-20020a92ca08000000b00360615d5612mr5537603ils.57.1704628398138; 
 Sun, 07 Jan 2024 03:53:18 -0800 (PST)
Received: from localhost.localdomain ([171.216.79.156])
 by smtp.gmail.com with ESMTPSA id
 x5-20020a1709027c0500b001d4ea1b6a2csm4082694pll.32.2024.01.07.03.53.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jan 2024 03:53:17 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH v2 0/2] Nitpick at the error message's output
Date: Sun,  7 Jan 2024 19:53:09 +0800
Message-Id: <cover.1704626686.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::12a;
 envelope-from=yong.huang@smartx.com; helo=mail-il1-x12a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

v2:
- rebase on master
- add a commit to sort the error message so that an explanation
  error number can be returned on all failure paths

Hyman Huang (2):
  i386/sev: Sort the error message
  i386/sev: Nitpick at the error message's output

 target/i386/sev.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

-- 
2.39.1


