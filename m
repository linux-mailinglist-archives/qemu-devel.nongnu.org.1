Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 414517A4E4B
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 18:10:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiGjc-0008Oj-TN; Mon, 18 Sep 2023 12:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiGj6-0006li-7t
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:03:57 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiGj4-00047P-0P
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:03:55 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50305abe5f0so3128444e87.2
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 09:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695053031; x=1695657831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dCQpcHiGYl2b5PMw9sHU7Xzs4il9aZ3go8echWC+OUY=;
 b=FQYTnb2iEsJtLlSXmuBujvnttvgfO0zf1nBecTbg6e06R/UPi6rfb5RPyAmpEzj7o6
 vfmMniuY+qJGEUf6ihj3bTI4yRlgNxM3Z2fmkhOJlnx2WLNnoxePcFgy4upgbeJ11Zve
 OAcxC+RhPjRRflhUrIWFg1iydcrxJEHxDt3x4PxrDOceOuS3X0Y8fjThLq/y2LFuG5to
 pM1z7MTtS6FKWqpqeCocdZkLC6wQie+DUVt7vcXChlwt6XNZEaItb/kAXGYnyY+DDmWI
 2DORwyvoad9lugoVC/suAfsnOW0nOXhVGTyvt+bFj/bapJkx5kgxm/3OaSUrEM8y6isU
 5LXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695053031; x=1695657831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dCQpcHiGYl2b5PMw9sHU7Xzs4il9aZ3go8echWC+OUY=;
 b=Vd6LteFobx2Sk11UXn+iUhPvwtrgz3umQMlqu4fw4W5QmIi8NOIYe4UTkN8/oXDs66
 E5mNa/EgX1KyKcIjJpemzE0MLEe4pzoOCBvfn2OfJZAWYx3PsEVAJv0fJEfjdZAlnOAM
 Cx391UupXh0+/ik+Nb6qfAfV8Fopq0AwmmxYM3RP9I7TW29khtGDAuKMWCgKP71CjFLj
 h8zWqEoSoyQnvfj0GcxmWz10vNXwT358RRSfF7xNKLMwZS4PuQSkowANp+ukoGEo6yTr
 HMc0Y4rRtJlDWaBMmXCWXtaxaPRTuqwH/NVNmUYWPvxOsNdXNL0skiZ8ISiPE7bOcUCm
 Zy1w==
X-Gm-Message-State: AOJu0YwejeRWixYcM2Sv7aFD7+iIOHzRgtbC5WWB223XyNhgGKInMVHl
 QQPEsDakH6hXKMHfF0NxbzLndURvyBezoTGz9Fwx6NEy
X-Google-Smtp-Source: AGHT+IGy+sW3/rMWVgA+iQsVUNjPLRtt/VMoay0ZFOuWvfTpfSlLeQiHWwG9NxI8+yiSPP5hV5k4jw==
X-Received: by 2002:a05:6512:3a9:b0:4fe:5860:7abf with SMTP id
 v9-20020a05651203a900b004fe58607abfmr6929316lfp.13.1695053031505; 
 Mon, 18 Sep 2023 09:03:51 -0700 (PDT)
Received: from localhost.localdomain
 (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
 by smtp.gmail.com with ESMTPSA id
 n3-20020a50cc43000000b0053132e5ea61sm913803edi.30.2023.09.18.09.03.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Sep 2023 09:03:51 -0700 (PDT)
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
Subject: [PATCH 10/22] target/hppa: Create timer *after* accelerator vCPU is
 realized
Date: Mon, 18 Sep 2023 18:02:43 +0200
Message-ID: <20230918160257.30127-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918160257.30127-1-philmd@linaro.org>
References: <20230918160257.30127-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
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

Architecture specific hardware doesn't have a particular dependency
on the accelerator vCPU (created with cpu_exec_realizefn), and can
be initialized *after* the vCPU is realized. Doing so allows further
generic API simplification (in few commits).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 49082bd2ba..b0d106b6c7 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -131,8 +131,6 @@ static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    acc->parent_realize(dev, errp);
-
 #ifndef CONFIG_USER_ONLY
     {
         HPPACPU *cpu = HPPA_CPU(cs);
@@ -140,6 +138,8 @@ static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
                                         hppa_cpu_alarm_timer, cpu);
     }
 #endif
+
+    acc->parent_realize(dev, errp);
 }
 
 static void hppa_cpu_initfn(Object *obj)
-- 
2.41.0


