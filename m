Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B597ADAAF
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 16:55:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkmtm-0001T0-Go; Mon, 25 Sep 2023 10:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qkmtc-00014e-Rq
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:49:13 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qkmtQ-0008Gx-Jv
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:49:12 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40572aeb73cso31127225e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 07:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695653339; x=1696258139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kNHX4JyhoYexAQqB9a7CrjUa8yJRKrNW0ix3Ut30RxE=;
 b=o7okgtlzKM5CdQPEsjYaWC/JCovzE4x9nZPmryzKjLnYr+KwgIO92EBcllUVMpLwTP
 yKnPWH0bXZxePEqYhd9oIhyDONqAjFYEgSnEJNIJhHMylwUhDWNuq3wz1a2gA94Iosqf
 zK0NGvhXonwTmUQK0iqkt/yuQEJTiZIoQ9p9ztLGBJ1OVvJUafe7O3L7URsoNUgdVG+C
 MMOU4aLBkD+pAeVmDmTBsSyJBgcU4yec65/QoVZocVYpOuE5mqAyrd1u7z0Jv6SZ6p8V
 +P+0H5hUHuzDfNJsvFofxv7sqxvAnfW6lj5K4zpte5ZzbFr1SY7KpIkZZqIma2JZM23t
 Ch8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695653339; x=1696258139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kNHX4JyhoYexAQqB9a7CrjUa8yJRKrNW0ix3Ut30RxE=;
 b=i3Iq+lp9GJ8oE0MSbqlUSRqTDTp08n6A8mc59XesgBa1cLHziCElRYD6lL4toDPRHj
 kVlbPgamlLLR9nZOrb8mHf3cHcFbptn3zNR7UnVo0F61p2+w4oDX1ks9oLXezkMCVdkR
 MHTSWlJCM6gYTv+wSWBF1BA0ol1DLuGtJdopuSnLHZ/aoW1E1CA2vXgQLMTfflvDD7RV
 6tDh2z7EXn1WI29ZdXDJtAVV7JUM2rWhcdqc4vcZ/4MyuZV9Qu9pEbTfsb5wqnmGGGjP
 4ZN7yQIyGw+2WItDJQd1RsrIdToDIIGUxa2GYV60yfQoJR5PFhN75ZbkGTmFAFejlByM
 AzhA==
X-Gm-Message-State: AOJu0YzpDjv7y9aq65nYI/JhVLHQ/DkryDT59B7fD4d4ZEs75IfYuHSa
 q5V/Rm4pBMozd9lOyH8TDr+oSw==
X-Google-Smtp-Source: AGHT+IGMr7N7urKQ8V3Sq28hXqy9yAVrCdYa0uBVNGkQ33p+6KFVM9aPbd7eskGG9fS//8pY41zZPg==
X-Received: by 2002:a05:600c:5192:b0:405:75f0:fd31 with SMTP id
 fa18-20020a05600c519200b0040575f0fd31mr3794870wmb.31.1695653339092; 
 Mon, 25 Sep 2023 07:48:59 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 8-20020a05600c230800b003fe61c33df5sm15386125wmo.3.2023.09.25.07.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 07:48:57 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1A8A31FFBB;
 Mon, 25 Sep 2023 15:48:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 John Snow <jsnow@redhat.com>, libvir-list@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>, Nicholas Piggin <npiggin@gmail.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bin Meng <bin.meng@windriver.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, qemu-ppc@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Beraldo Leal <bleal@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 09/31] gdbstub: Fix target_xml initialization
Date: Mon, 25 Sep 2023 15:48:32 +0100
Message-Id: <20230925144854.1872513-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230925144854.1872513-1-alex.bennee@linaro.org>
References: <20230925144854.1872513-1-alex.bennee@linaro.org>
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

target_xml is no longer a fixed-length array but a pointer to a
variable-length memory.

Fixes: 56e534bd11 ("gdbstub: refactor get_feature_xml")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230912224107.29669-2-akihiko.odaki@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub/softmmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gdbstub/softmmu.c b/gdbstub/softmmu.c
index 9f0b8b5497..42645d2220 100644
--- a/gdbstub/softmmu.c
+++ b/gdbstub/softmmu.c
@@ -292,7 +292,7 @@ static int find_cpu_clusters(Object *child, void *opaque)
         assert(cluster->cluster_id != UINT32_MAX);
         process->pid = cluster->cluster_id + 1;
         process->attached = false;
-        process->target_xml[0] = '\0';
+        process->target_xml = NULL;
 
         return 0;
     }
-- 
2.39.2


