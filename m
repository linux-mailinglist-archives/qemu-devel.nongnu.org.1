Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B048B7714B2
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:04:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qScQn-0001md-NI; Sun, 06 Aug 2023 08:00:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQd-0001ak-SB
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:11 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQY-0005d6-C2
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691323203; x=1691928003; i=deller@gmx.de;
 bh=KOwVOGLkUNJS93FOFZ3KD/tcWS4SN2K96HANSWFCUjM=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=TduY2SUSGGxchPKoX2FvclUF0a+NtStTJDsveyOFr9LgGm31R0UeMEZLCTqCgymhlubYpHa
 EMMmDJgDfYt391lCNI0v6mqKPZLe7TQO5mDCdWzaaX2jNajdi6ot+KRcZYlrR7LAqJYs+epsj
 L783EQk4nnou4z6mWHpqDoNJOp62Cr7qfoZLLsIvQFT5rTyLUzTPzJfasTWUxIQXY5QX9S/FM
 RTpIk96VJrqz2sBPG/aYp5OB0FXmWDr1o7xcB4wyujPgZZpLczrdu6cKa7fX8PaSATKmWr6cI
 hK5wJsQykVzrfyVzwN+6goP1wUbCliI9Tc2EYf0ZrqeMjhFom6Kw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfpSb-1pvDUQ1UTZ-00gD22; Sun, 06
 Aug 2023 14:00:03 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH 09/23] target/openrisc: Use MMU_INDEX() helper
Date: Sun,  6 Aug 2023 13:59:47 +0200
Message-ID: <20230806120001.89130-10-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806120001.89130-1-deller@gmx.de>
References: <20230806120001.89130-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eIo0E6aHCD+BvwKhiwgS9fhiJRcOsu/aLqWcVrfYtoMmquUCNJy
 YezmbPfgwy/F0WQrfPbqIWDV2vC8RjQy5unuJXAfUDfs/ZoZygqqepNeADN2Bb3ealPmxIx
 mdX0bZ7SE9bE9s2O8mdcclf3DSmvhIjLx5VJoswaUd+6e9Vp4V022mMNuV1sdhQ+r8oytKE
 SanKYT3YNQ1N/dSbWxmng==
UI-OutboundReport: notjunk:1;M01:P0:WWUrUlkuTQM=;xGxBXe64PY3qkUHqOg04IWH9DoK
 CHkXaCPHPE87TIDjP6qSjpOzKd5LefAJ4dCL3R1RJ0T128DzEiD1atFfZ6G1kofXguZYu+4Bh
 PUPfRrx9eDByq1G8c+2pJdf3oi1gQL/WyHOH586fIooz9uJK/6dungLu+VOIETa0dk0s706aS
 GrTJLQXal0v4KYQ5NXcqxjUxw6bUaWZayOc7pZwcwmO95TNnuqJ5JyNknkiTK7KEvBQrx3n8m
 Kuno+doh2ThNkdkI1XO4857S3nqaxxGNP6GbPUvsQEc9lcLyFBI4N9X4wkT2JxIb3IyHhwU8o
 cD6Msg6diUi4tidGPyVzjNkYGzcXSb5OEdOcmf1TTsecJuqfAfJXDTSxWvdzmhXRa3mfrSno0
 hqSwq24BBHKQSyWM/Mdb9PhD4JtCERaW8YjXXRml4hYfM81dRC3MH5r33ALTSoqV8FIeGWR1N
 po8VbebdYHQci7r7ZY7YiLiF8q8uGUBqxeqUHegtZBTU6HrpXI+Whv4p3DjZyvEc/h+aDieOl
 GFZVdyfgvnO5GESE6z5zB417ka6rnAjP+EGtiCfA3TJwnE5aSzgpRpOxF5ezTkYgwR1tQi/ag
 fS+iOAVUL0pCaj9lT4I1tVYgc3kj3hf1pUfFaEuy6OuFmk52yfaMWvOdO+q6VF/bh/5BklAwD
 52plyfvkd59rcIkQDRVEzTF9+dTDKtPYkK7yirgmGtPqzpBGHMAr45Mu5A4iCGReTrNjf4SzN
 iEL7uNeTNYN23+Sly1TvV7Im90XeHZ9fUXj+gymQJKc4Gh+YbM9ZrEX/ARkM6u5JkphL5gI54
 fSYlr2HoGEEVAOrifXpU5zYw8JhinENwJOQBmUonzcbo8xWJv+Icxy01F0dtPzFgECDWu1duK
 4N6HFs3XUybsb8RS1+Br8fiqJ4gLo2Tqt/kdQGV290oED77DpH5Nq0lqSLIeSfckAg+Hf/6xY
 lfIPxs3IzXM3Bn2TAp9ZYLNmUeY=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Use the new MMU_INDEX() helper to specify the index of the CPUTLB which
should be used.  Additionally, in a follow-up patch this helper allows
then to optimize the tcg code generation.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 target/openrisc/cpu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index ce4d605eb7..c216f2fb77 100644
=2D-- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -50,9 +50,9 @@ struct OpenRISCCPUClass {
 #define TARGET_INSN_START_EXTRA_WORDS 1

 enum {
-    MMU_NOMMU_IDX =3D 0,
-    MMU_SUPERVISOR_IDX =3D 1,
-    MMU_USER_IDX =3D 2,
+    MMU_NOMMU_IDX =3D MMU_INDEX(0),
+    MMU_SUPERVISOR_IDX =3D MMU_INDEX(1),
+    MMU_USER_IDX =3D MMU_INDEX(2),
 };

 #define SET_FP_CAUSE(reg, v)    do {\
=2D-
2.41.0


