Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4136B82C67A
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 21:57:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOOaq-0007sJ-4z; Fri, 12 Jan 2024 15:57:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rehn@rivosinc.com>) id 1rOOan-0007rr-EX
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 15:57:29 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rehn@rivosinc.com>) id 1rOOal-0000wS-FT
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 15:57:29 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-50ea9e189ebso7759255e87.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 12:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705093043; x=1705697843;
 darn=nongnu.org; 
 h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
 :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=1rD8zDBVL2EmMJPj3uOPkRH+NGDIF55c6E5WtLm5LU8=;
 b=uYsDpNkcGAs7O5Iv/CnXAE+3xb4tcpl0sjt8/MfrxXQtWYJtJLTD+Q/lfa4sv/1g3p
 m4+Yxdk2SbeTvlolmKTthieJl/0zHuA2frBYjGJOnmiYmJu1AC4QHo4VFRN2IQhDclOE
 b0g96WMkZXFUV4QjVaWSf7CSq/3wspwmw7L5XjJkt2RYaVkqT47rSWPh5BM2K7DFwthm
 gb7l3emWw1pfT9uUfGch4lcfJNnB/tFyzxXeoYYkWwN0EgvVkhssY0fwnzkoz09Rb9Js
 XSqho9Ic5IMWFFZuiEBYf5dy+hVhdkVfNTE+z/JwOQqJwaQk3cvltA7zrNUnEaNa3ifZ
 qZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705093043; x=1705697843;
 h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
 :subject:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1rD8zDBVL2EmMJPj3uOPkRH+NGDIF55c6E5WtLm5LU8=;
 b=D9+tn5oZwsThRmajMP9SEDjSsLN9sdWy1hTR4WeyDLh+xZV0NoH/ShCuBLqZvCF4r1
 OcPgkrQfLqiEam3X3E5nltcxd6Yj9cnkmOAaz6EVR+bF5DHT09H3EVPG2TuRBjgqY6ud
 /XZA5+OaLV+ZLM0slJftEpVuAck9JM45Eqx/3jBN4S+pyVRuKMdQqTYPlzw0SQZOjAe5
 nXgszy/9emlak4njWH3Za/QMTftpb2HfIxStD1JPTC/cRLX+jkxCJEEOXZHTaBy9lnq9
 u4HhkorbtbKnt+lUwcnIDdVn6UnrX079jYGQCQ8ZwfCAstmGB3Ca0mWyZImvece9bhRH
 H0sQ==
X-Gm-Message-State: AOJu0Yz4kSj2d6Gbk+2m7D4TTVO7EwK9ZtKLLSasLXrb5/Qit8+xsPAi
 hh/wLBbzBi8O/K3achKGtBFh/mn5Q0dxRLMoKHOsmvIyevo=
X-Google-Smtp-Source: AGHT+IEidV8i6qbDT7494aEAH5v9L4dIgOCqKRv+O29k1iLD9NGdRI8SnVmZy863TbOXyLVAE12gKA==
X-Received: by 2002:ac2:4643:0:b0:50e:6b69:6ab9 with SMTP id
 s3-20020ac24643000000b0050e6b696ab9mr855058lfo.21.1705093043398; 
 Fri, 12 Jan 2024 12:57:23 -0800 (PST)
Received: from h-2001-9b1-c3c7-e600-85ca-d347-89f8-bacf.na.bahnhof.se
 ([2001:9b1:c3c7:e600:85ca:d347:89f8:bacf])
 by smtp.gmail.com with ESMTPSA id
 c7-20020a196547000000b0050eabefd528sm610305lfj.88.2024.01.12.12.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 12:57:22 -0800 (PST)
Message-ID: <33f27425878fb529b9e39ef22c303f6e0d90525f.camel@rivosinc.com>
Subject: [PATCH] linux-user: Fixed cpu restore with pc 0 on SIGBUS
From: Robbin Ehn <rehn@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, palmer@rivosinc.com
Date: Fri, 12 Jan 2024 21:57:22 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=rehn@rivosinc.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Commit f4e1168198 (linux-user: Split out host_sig{segv,bus}_handler)
introduced a bug, when returning from host_sigbus_handler the PC is
never set. Thus cpu_loop_exit_restore is called with a zero PC and
we immediate get a SIGSEGV.

Signed-off-by: Robbin Ehn <rehn@rivosinc.com>
---
 linux-user/signal.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index b35d1e512f..c9527adfa3 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -925,7 +925,7 @@ static void host_sigsegv_handler(CPUState *cpu, siginfo=
_t *info,
     cpu_loop_exit_sigsegv(cpu, guest_addr, access_type, maperr, pc);
 }
=20
-static void host_sigbus_handler(CPUState *cpu, siginfo_t *info,
+static uintptr_t host_sigbus_handler(CPUState *cpu, siginfo_t *info,
                                 host_sigcontext *uc)
 {
     uintptr_t pc =3D host_signal_pc(uc);
@@ -947,6 +947,7 @@ static void host_sigbus_handler(CPUState *cpu, siginfo_=
t *info,
         sigprocmask(SIG_SETMASK, host_signal_mask(uc), NULL);
         cpu_loop_exit_sigbus(cpu, guest_addr, access_type, pc);
     }
+    return pc;
 }
=20
 static void host_signal_handler(int host_sig, siginfo_t *info, void *puc)
@@ -974,7 +975,7 @@ static void host_signal_handler(int host_sig, siginfo_t=
 *info, void *puc)
             host_sigsegv_handler(cpu, info, uc);
             return;
         case SIGBUS:
-            host_sigbus_handler(cpu, info, uc);
+            pc =3D host_sigbus_handler(cpu, info, uc);
             sync_sig =3D true;
             break;
         case SIGILL:
--=20
2.40.1


