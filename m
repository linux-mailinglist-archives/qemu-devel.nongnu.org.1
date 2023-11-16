Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ABF7EE031
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 12:55:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3awt-0006i1-D8; Thu, 16 Nov 2023 06:54:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r3awq-0006hj-Lb; Thu, 16 Nov 2023 06:54:17 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r3awp-0007hC-80; Thu, 16 Nov 2023 06:54:16 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6c431ca7826so635708b3a.0; 
 Thu, 16 Nov 2023 03:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700135652; x=1700740452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=khu5P4E16LAd1R2e6yUGq0YwfAOQmxoguNRACDoGfCg=;
 b=Ggihks2ADxgnmYv6LYoRpvf4YZC3xtuHDtqckIgwJJRaX2uyoj5g41/nIKdCLa0kvC
 oWOr4WxfmA0771drr4nxt3q33NzJqEnOQXISA+d/b4Xnz657djXADDIfn1iHROkJgAtQ
 UBnsqWaaZRF2dbUDFl4vGs52sDLjUHQ3Ae5jbUOgrONjrIsAn4KXxZLBdgPYiskPuHTu
 aZMb4hWfu2VLd+sMx1seISDkfy3X6z6c+rcXsiBiDPhisDA1iM96gNgXCyLHvnXRl8yX
 dWTK2ludjYU2JTj1xn7j0B5FTni+p//1ZfGBAO37K39/W6pBrJ0VZcOa5zAHyuGMOWAg
 VhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700135652; x=1700740452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=khu5P4E16LAd1R2e6yUGq0YwfAOQmxoguNRACDoGfCg=;
 b=rRvodotZke8T1nvB0gNJF6BBae1DxoVBSCNON/69hQtc4Jqsn4GrC+OibPyWelP81n
 MBX5uuQn/vd1M32F70ecu1wfPZppeQg6VFOzGuSm4zez2P7EXA3blkFZkiQh7riDusuV
 E0D9CMYRU4OwmjnKD4FcOKGNS2N/NkOYITyxaUkdeu7bm6fExRlDHc8+dnPESL2cGl04
 KGMCT4XQvM6JrKzYruRMZ09fHPeRKw1rtd38ZDfYgf843EEQFSrAj95wG1T59b3pOdwI
 1YStyG1ICbJuTpBUJa8ZvOQ7mfKBXnv1s5CjT2UghYpmFR4qB8p/qsHnpCZMjQelNZmw
 0N3w==
X-Gm-Message-State: AOJu0YxesbEplqopFuBIGwLLxe+3QU+K5om+8oMUJza+6ra0urMBGKR8
 9XbGa/iyUHxW6NDNBwl47dbEP7KUW/c=
X-Google-Smtp-Source: AGHT+IFymt2qv910Oa/LderXVtoyd1pY2xzwWMs/AkszvU1nAyn732QPn/4KMAQr6wYZ+Pu7Ddu6/g==
X-Received: by 2002:a05:6a00:1e18:b0:68f:f650:3035 with SMTP id
 gx24-20020a056a001e1800b0068ff6503035mr13497466pfb.12.1700135652048; 
 Thu, 16 Nov 2023 03:54:12 -0800 (PST)
Received: from wheely.local0.net ([210.84.53.86])
 by smtp.gmail.com with ESMTPSA id
 n19-20020a62e513000000b006c60b150383sm4507960pff.12.2023.11.16.03.54.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 03:54:11 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Thomas Huth" <thuth@redhat.com>, "John Snow" <jsnow@redhat.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 2/3] chardev: report blocked write to chardev backend
Date: Thu, 16 Nov 2023 21:53:53 +1000
Message-ID: <20231116115354.228678-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231116115354.228678-1-npiggin@gmail.com>
References: <20231116115354.228678-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
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

If a chardev socket is not read, it will eventually fill and QEMU
can block attempting to write to it. A difficult bug in avocado
tests where the console socket was not being read from caused this
hang.

warn if a chardev write is blocked for 100ms.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
This is not necessary for the fix but it does trigger in the
failing avocado test without the previous patch applied. Maybe
it would be helpful?

Thanks,
Nick

 chardev/char.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/chardev/char.c b/chardev/char.c
index 996a024c7a..7c375e3cc4 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -114,6 +114,8 @@ static int qemu_chr_write_buffer(Chardev *s,
 {
     ChardevClass *cc = CHARDEV_GET_CLASS(s);
     int res = 0;
+    int nr_retries = 0;
+
     *offset = 0;
 
     qemu_mutex_lock(&s->chr_write_lock);
@@ -126,6 +128,10 @@ static int qemu_chr_write_buffer(Chardev *s,
             } else {
                 g_usleep(100);
             }
+            if (++nr_retries == 1000) { /* 100ms */
+                warn_report("Chardev '%s' write blocked for > 100ms, "
+                            "socket buffer full?", s->label);
+            }
             goto retry;
         }
 
-- 
2.42.0


