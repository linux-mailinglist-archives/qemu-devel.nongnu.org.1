Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30563777C5F
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 17:39:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU7ia-0005QP-Dj; Thu, 10 Aug 2023 11:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qU7iX-0005OZ-Ak
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:36:53 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qU7iR-0003FG-9a
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:36:53 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fe1d462762so9490745e9.0
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 08:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691681806; x=1692286606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iHM26J4ebdoiYZJz3zhEjNseIBWtdhkWcsKebtX2pWo=;
 b=eQO22FLdiPhn3e0movl88+RJll7ghzw5rpTk7QKrBL1XIehBZSmgDzbS0djyOdwFsU
 ieUbA47LEcCuW4d7tg5UUZgyMqWGPCGxGyuBEQ/mQjZtN+rxe25GzZuD3QwlZaKVo3gL
 C03AzwsWUesYegBVlJ8tGQUzN6E0WPCs5YzMYi6EFFH98QbVm/DL+puyrvnlk6d9vx4l
 7ZJQt7Kix5B4hLkraEapVKVRS37e0odFJHM2whwL6vHGGX1Czbfu6TqTeIilkDAYTmS/
 ZxlA1lndqSJeAS129mCyGMcYteTz//dHOGd0Dr1EqTsQMAL4baRZxFJJE8mRn4yJ6woe
 W4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691681806; x=1692286606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iHM26J4ebdoiYZJz3zhEjNseIBWtdhkWcsKebtX2pWo=;
 b=Hcl/rbT6Q59vJ+bCJwhJk2eo5fDvH1Kzryq44XV25uzdyo1AK53izFgR7MNIJYscwH
 gZOTBXRzyuIFSfbviWfFSwo2W7lP4oxFY5wQRNDwKkkUrstFMvm59uAwYLsFAZ1oiPp+
 LO/0yhIf1X9YLuLpwLWv357j7qCT6kGMIP3GG3IIwn8o/+BovzLTMtj6bY0HbpPkEyUq
 38njCXm7yTYZdUKiczmhmc0Bte6rWCd+ynbZ03CUqtpwCAncfRHTY93/u93M9K3yO29V
 8hMXE+6yV35oN9+A86mCb1RB0A6vMLm89Y0Zb2TomlNkRJsVsLnRsFb+Daj53LSwFOna
 ADfA==
X-Gm-Message-State: AOJu0YzRQ5wMFblPi13khuZFO9/g8k5lLEA+ECLIMrSH5ucifAXtEGZw
 fWzjv4v2eP+lG95dGoCOE3M36g==
X-Google-Smtp-Source: AGHT+IEWA75NxPGLC9g2qsbdXr3KkBpGt0Axzmi59pPqGpaeuqiw4Xc4KfNtxOdsJP0vTVRNcJyemg==
X-Received: by 2002:adf:e8d0:0:b0:314:2e95:1ec9 with SMTP id
 k16-20020adfe8d0000000b003142e951ec9mr2909419wrn.10.1691681805851; 
 Thu, 10 Aug 2023 08:36:45 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 k18-20020a056000005200b00317d2be2e59sm2513473wrx.73.2023.08.10.08.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 08:36:43 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A2D1E1FFC3;
 Thu, 10 Aug 2023 16:36:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 gdb-patches@sourceware.org
Subject: [PATCH 8/8] gdbstub: don't complain about preemptive ACK chars
Date: Thu, 10 Aug 2023 16:36:40 +0100
Message-Id: <20230810153640.1879717-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230810153640.1879717-1-alex.bennee@linaro.org>
References: <20230810153640.1879717-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

When starting a remote connection GDB sends an '+':

  /* Ack any packet which the remote side has already sent.  */
  remote_serial_write ("+", 1);

which gets flagged as a garbage character in the gdbstub state
machine. As gdb does send it out lets be permissive about the handling
so we can better see real issues.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: gdb-patches@sourceware.org
---
 gdbstub/gdbstub.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 20b6fe03fb..5f28d5cf57 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -2074,6 +2074,11 @@ void gdb_read_byte(uint8_t ch)
                 gdbserver_state.line_buf_index = 0;
                 gdbserver_state.line_sum = 0;
                 gdbserver_state.state = RS_GETLINE;
+            } else if (ch == '+') {
+                /*
+                 * do nothing, gdb may preemptively send out ACKs on
+                 * initial connection
+                 */
             } else {
                 trace_gdbstub_err_garbage(ch);
             }
-- 
2.39.2


