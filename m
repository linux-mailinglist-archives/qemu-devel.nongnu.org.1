Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 419BF7A4DEF
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 18:04:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiGie-0006D0-TN; Mon, 18 Sep 2023 12:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiGiU-0006Bk-Kl
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:03:18 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiGiS-0003xJ-SQ
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:03:18 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2bb9a063f26so74532601fa.2
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 09:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695052995; x=1695657795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MazgQXWzZA8uxNgPyG3XxGvrbp91MALAwpKlSsIULzk=;
 b=AWcgkPnxQFXDv9XqrQamwTrogPRQfzeKQmSrrrydfp/8D4XnOfw+GuBW2gjofq9dcW
 S2P4bTXltsjEIvjSWhAMMLj2eECFmAKuaOa3di8HIOowFOuXFC2fWwQko6v7fSpui6Tb
 AZw7A19XwmQrvT8aEbBEpG3F3i0Xol2F8gGXZjPcENvvs6fJT2iQsoTzrieg33DUPqiM
 1wBMXn9QBN+afVRpMCJpxFiwkFHUJPV8n2AhWGyFm/FYLTw03wRTA3qf5YLqpnZxZkhZ
 y9gOO4DlwOgOAPgsIrMvzy/FQh4MdMwvk/jkitj2ZM/cqf1W7RNyfr/brF/NBYMRHZDz
 cENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695052995; x=1695657795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MazgQXWzZA8uxNgPyG3XxGvrbp91MALAwpKlSsIULzk=;
 b=b2aZnNC+WmRlXT8d0AeGvUR4XjeqrBlUwq2CIOUCSefluwzINSGaNH+Obf4ZoF7IMj
 mcd8qFdKpsw3J5cgUnRXq++t3vYHFUOMEM8rwl2lq+RLHoNfQmIZHsnNiQQpDezmI0fL
 2hY6l6kdGXduBopNtYlGvoLT37zcKT7AyMDzIV4feCuULO8fNQ0fs9WBjUeOii+h5gQU
 uD6025NQ1nNXCir2JZllFaZvkT3VOqZ7pfcqYk/jhp+vMlT5jn0pmEIXmj7Wln+8PC+M
 sQEDKMpZtM16bNjS6i1iRBqYssscboyCx1lkWbGgiBtROTp2ppEGTuUYr82dKYLrch5i
 6ViA==
X-Gm-Message-State: AOJu0YwkxSkqndIoo/Yh1GVe3i1fxZO71lF/jo6qOcRFzrPXjk9JLGfE
 XZ42xWeEnnksZHvpjh2gspwfTdfeDWjsc48G4aWxJ1q7
X-Google-Smtp-Source: AGHT+IG8278V/bx3bmgpaUhHZZUcMrkwCw5Xh6lMORAxCV90jlud9/Vt30zNUM+Rqe+3rVD6prsUKA==
X-Received: by 2002:a2e:8ed0:0:b0:2c0:d06:9e65 with SMTP id
 e16-20020a2e8ed0000000b002c00d069e65mr2857839ljl.8.1695052995061; 
 Mon, 18 Sep 2023 09:03:15 -0700 (PDT)
Received: from localhost.localdomain
 (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
 by smtp.gmail.com with ESMTPSA id
 r11-20020a170906350b00b009934b1eb577sm6608438eja.77.2023.09.18.09.03.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Sep 2023 09:03:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, David Hildenbrand <david@redhat.com>,
 Peter Xu <peterx@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Marek Vasut <marex@denx.de>, David Gibson <david@gibson.dropbear.id.au>,
 Brian Cain <bcain@quicinc.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Claudio Fontana <cfontana@suse.de>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-ppc@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alessandro Di Federico <ale@rev.ng>, Song Gao <gaosong@loongson.cn>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Chris Wulff <crwulff@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Fabiano Rosas <farosas@suse.de>,
 qemu-s390x@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Luc Michel <luc@lmichel.fr>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Bin Meng <bin.meng@windriver.com>, Stafford Horne <shorne@gmail.com>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Greg Kurz <groug@kaod.org>,
 Michael Rolnik <mrolnik@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 03/22] target/i386/kvm: Correct comment in kvm_cpu_realize()
Date: Mon, 18 Sep 2023 18:02:36 +0200
Message-ID: <20230918160257.30127-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918160257.30127-1-philmd@linaro.org>
References: <20230918160257.30127-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/kvm/kvm-cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 7237378a7d..1fe62ce176 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -37,6 +37,7 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
      *  -> cpu_exec_realizefn():
      *            -> accel_cpu_realizefn()
      *               kvm_cpu_realizefn() -> host_cpu_realizefn()
+     *  -> cpu_common_realizefn()
      *  -> check/update ucode_rev, phys_bits, mwait
      */
     if (cpu->max_features) {
-- 
2.41.0


