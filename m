Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64486790AC9
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Sep 2023 06:32:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcem6-0002GB-34; Sun, 03 Sep 2023 00:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qcem1-0002Et-JV
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 00:31:45 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qcelv-0006zr-UR
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 00:31:45 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6bcb5df95c5so383727a34.1
 for <qemu-devel@nongnu.org>; Sat, 02 Sep 2023 21:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1693715499; x=1694320299;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JGIx5VmKC+qEqkrX7A0VzIiIuVMOabzMZ9XhVHygWtw=;
 b=nh0ZP+w7OjM1poJUNbqrJZ0QpD6tk/yYiQX4QHgzsMSUMRXw4+NONJH81DMqEaxYdU
 +ELScZmISITmQ+S+ebT5a6esJyInG+XSZfWb9ZNkTLetuAg90KDEe5l8KAKWU5Nss973
 e4ysDPBFLIEEcGN0udrssKOjyQc59WDWIuZYkh1tmwP7g7o5C1yISda5lUdpTLPf1C58
 L7XWs5Sj1g4RaJSAwsN6E4cnaKW9u7zffMDICUi301vmpnno0AjTYduEA8IM0EXqcx2r
 UwmcNfmWMOne93TB6+5H1CR6ZYF/hNYhk7zkvGgNiokvHII6OLaja2r+krpgwVPGYxIn
 XMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693715499; x=1694320299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JGIx5VmKC+qEqkrX7A0VzIiIuVMOabzMZ9XhVHygWtw=;
 b=EL/afcrGHgPq9+hcEYSyFmUFKiY9TSiMJ0tUuaJHl7UImMDLXNjO4tlB3Rba6H4GeK
 jtcQ8DL+aPQZ5iF64AKKPRPuCe7GAEORAuYo8t5m8kkNuIizWhHFY67J1hG6wF6g9877
 92bhCU70nqhz2EQvYtpjZD6vdI6gLlH9byc7tltaaePBSsuKZ6pClLGrZbh2wHJHJiKL
 Y/BGnVJ2uRJ9540XEOiieHy7+mEW4N7gqaAWoBNjJDDpU8JabkOv6nmOL9nUsmaXctnr
 yc1wsWxdDM4SFJCEsmJG01Bes5M/0HlNOdma22a+lubFqUTBslifCXgA/OIrAZa0leFN
 RHTg==
X-Gm-Message-State: AOJu0YzAkxL4DwpQpboIcVgek7HITTo7XhH8lW26rNDwhCaviUHtn1pf
 hY2qlDT3Lgyb6+rCvLonqsgHbg==
X-Google-Smtp-Source: AGHT+IFQkakJ8PSvZSCptRrZmoLdXYWhZchavzY3Bbjb9riKNDi8Uw0rJR7gGrV4tpZInEngFR6ecg==
X-Received: by 2002:a54:4e81:0:b0:3a7:2570:dcfc with SMTP id
 c1-20020a544e81000000b003a72570dcfcmr7919345oiy.43.1693715498840; 
 Sat, 02 Sep 2023 21:31:38 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 iz2-20020a170902ef8200b001bb9f104328sm5295792plb.146.2023.09.02.21.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 21:31:38 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs)
Subject: [PATCH 7/8] target/ppc: Remove references to gdb_has_xml
Date: Sun,  3 Sep 2023 13:30:17 +0900
Message-ID: <20230903043030.20708-8-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230903043030.20708-1-akihiko.odaki@daynix.com>
References: <20230903043030.20708-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::330;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x330.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

GDB has XML support since 6.7 which was released in 2007.
It's time to remove support for old GDB versions without XML support.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 target/ppc/gdbstub.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index 72df36ca06..ec5731e5d6 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -54,12 +54,6 @@ static int ppc_gdb_register_len(int n)
     case 0 ... 31:
         /* gprs */
         return sizeof(target_ulong);
-    case 32 ... 63:
-        /* fprs */
-        if (gdb_has_xml) {
-            return 0;
-        }
-        return 8;
     case 66:
         /* cr */
     case 69:
@@ -74,12 +68,6 @@ static int ppc_gdb_register_len(int n)
     case 68:
         /* ctr */
         return sizeof(target_ulong);
-    case 70:
-        /* fpscr */
-        if (gdb_has_xml) {
-            return 0;
-        }
-        return sizeof(target_ulong);
     default:
         return 0;
     }
@@ -132,9 +120,6 @@ int ppc_cpu_gdb_read_register(CPUState *cs, GByteArray *buf, int n)
     if (n < 32) {
         /* gprs */
         gdb_get_regl(buf, env->gpr[n]);
-    } else if (n < 64) {
-        /* fprs */
-        gdb_get_reg64(buf, *cpu_fpr_ptr(env, n - 32));
     } else {
         switch (n) {
         case 64:
@@ -158,9 +143,6 @@ int ppc_cpu_gdb_read_register(CPUState *cs, GByteArray *buf, int n)
         case 69:
             gdb_get_reg32(buf, cpu_read_xer(env));
             break;
-        case 70:
-            gdb_get_reg32(buf, env->fpscr);
-            break;
         }
     }
     mem_buf = buf->data + buf->len - r;
-- 
2.42.0


