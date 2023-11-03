Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A01657E09D4
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 21:05:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qz0LZ-0008Rk-7P; Fri, 03 Nov 2023 16:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qz0Kv-00088o-Pc
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 16:00:09 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qz0Kp-0005Ld-DJ
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 16:00:09 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-32fb95dfe99so533096f8f.2
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 13:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699041601; x=1699646401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KYZuWVa43D0DKc9oObff9+vpWR6o8oc5r5+fymGHhRI=;
 b=cumF0FkWaivF51fD/Urub2D1CpzAw2Dz6T1PT7trM7nguvlDlry20iSM0w+uGp9TYv
 NKJeE2aLI5aGWmXu9BWZDL2lD8nKbx+6NNCOnKU7vIP6X7a8Z/FdS8VVF4fmNtbq4wh6
 VcifJETRim+/sVOHRSn60cmH0Ao/VOv+8AFNrXSRTQmhQCMSPPSIbeaZhzs4Y5lclwpf
 A3NSuEMbHghKZT1SWZnL/yPX+Js2p4n9EiZq2iOhM+lamFakVw+ymIL8X68zvkodAH2J
 zaRyCSOL+lr/B6n5YWVxXZbNonoT5ZNZvLjrEOJ/EEyPqHehzPcEJLfQ8HKstjtUTbdZ
 KGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699041601; x=1699646401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KYZuWVa43D0DKc9oObff9+vpWR6o8oc5r5+fymGHhRI=;
 b=GylYoE9CjBVynD9scw4lGQRUzXbpgP1jobuZuUTUb+NKvbFDhp4XZdbVTbb4bN8+Ow
 lbiM7r1oOX8zx5vEtWVh5pAI1nKEbso1CyAZmrlksvJapfUhQ92u1t3vpxfegqfiHqMA
 IjLrph1sSawBX9qJJw/ZRCQzPqcQ2kh0H0iBfGuNeccH54BDAwvjCU9wb+yy0GyXvQNf
 TCsX0inzfmz3s3p98BO09WdvkPpLDm9h14ZgyNyLIeDaHUZAQuI6zmW11WAzJNrzZNri
 uU1ep+TEUhdFuHp6Y2qwFyOHsK139T7C/l4Fd8zFp813nAz9Xt4OmBBI18+xIG2TpWAO
 K3wQ==
X-Gm-Message-State: AOJu0YzSg2Ra2+DS824x9+wE902KX19XdEbK7OFSAyAoY+PkbQeLfOAw
 7QDpC5Q806atlQsGZmRuud/N8g==
X-Google-Smtp-Source: AGHT+IEdnBZvUgthsuh3K32pKKFffjqq1mxVr1uHHbuiRs5EHvS6bjJ7eTxWZnuxCf+DZvN8o7qpqw==
X-Received: by 2002:adf:f18f:0:b0:32f:bdb5:98b0 with SMTP id
 h15-20020adff18f000000b0032fbdb598b0mr1409673wro.66.1699041600885; 
 Fri, 03 Nov 2023 13:00:00 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 r7-20020adff107000000b0032db8f7f378sm2625170wro.71.2023.11.03.12.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 12:59:57 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EBCA865742;
 Fri,  3 Nov 2023 19:59:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Song Gao <gaosong@loongson.cn>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Brian Cain <bcain@quicinc.com>, qemu-ppc@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-s390x@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Nicholas Piggin <npiggin@gmail.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Bin Meng <bin.meng@windriver.com>, Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH 03/29] target/arm: hide the 32bit version of PAR from gdbstub
Date: Fri,  3 Nov 2023 19:59:30 +0000
Message-Id: <20231103195956.1998255-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231103195956.1998255-1-alex.bennee@linaro.org>
References: <20231103195956.1998255-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This is a slightly hacky way to avoid duplicate PAR's in the system
register XML we send to gdb which causes an alias. However the other
alternative would be to post process ARMCPRegInfo once all registers
have been defined looking for textual duplicates. And that seems like
overkill.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5dc0d20a84..104f9378b4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3727,7 +3727,7 @@ static const ARMCPRegInfo vapa_cp_reginfo[] = {
       .access = PL1_RW, .resetvalue = 0,
       .bank_fieldoffsets = { offsetoflow32(CPUARMState, cp15.par_s),
                              offsetoflow32(CPUARMState, cp15.par_ns) },
-      .writefn = par_write },
+      .writefn = par_write, .type = ARM_CP_NO_GDB },
 #ifndef CONFIG_USER_ONLY
     /* This underdecoding is safe because the reginfo is NO_RAW. */
     { .name = "ATS", .cp = 15, .crn = 7, .crm = 8, .opc1 = 0, .opc2 = CP_ANY,
-- 
2.39.2


