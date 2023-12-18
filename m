Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0098817A20
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 19:53:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFIiu-0006QU-GP; Mon, 18 Dec 2023 13:52:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rFIii-0006Jl-Bd; Mon, 18 Dec 2023 13:52:05 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rFIiR-0008QQ-2G; Mon, 18 Dec 2023 13:52:02 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40c41b43e1eso45000275e9.1; 
 Mon, 18 Dec 2023 10:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702925503; x=1703530303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hPwHpCKMVQft6dmkR72MEXRun0g3aRwzuJ4tXisLRCE=;
 b=OwTMUM135eWiFq0dckXiCvddrxIVeIwpdTb7SyUlCM5+EKLvdim1OPn2UmgtCiOT6S
 jLWT5jjFFoix+4+5520juKzVgIGN0/aJu1aMkhp2cq4IAyPi6wJUwJc8JyQ+hMy9x4B8
 qdPS2+VXQD9HI6S9GeASmUx4gUeCSgkocxRtQNeThbj6FG00TgAy8sCVl4a1gxzsAy+N
 4WAfI/Vy3qzlHFGOqZq15X6zGxMOCmp4U1s9Y0lFFo7cIgXz/ulAvLVuljf7EFfFmi3S
 9nZg/EbX0E1wVgghNbe5TNbNfujWrs95NUcfN3Iydx9pYGm2CQy/QeUwC1o9FZ7D3fzR
 I8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702925503; x=1703530303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hPwHpCKMVQft6dmkR72MEXRun0g3aRwzuJ4tXisLRCE=;
 b=vKYI6cskV7h8uKUYISmQEqO5394EWtZtwiCoGeBOOMB0feYSgInZe+aimt/2PRSx0N
 gEO6e2+ujqaMoKbq0ROro1kCBGUSrPXJjw9OvdtLIJ8H4dQ67+IM1+sbRjYuzEO5n5TD
 jjc7H3nwvvVn83Gdfej+CyLgoNpoitqJ0dO0Sg4SkE37k6A5tmA1C1yZuRW2SohWZ8vz
 9+669fEWCT7P9UNRdPBtgWO+WQ7mcPyJ1ixr3Beg32dA77fFFhygpNG16OOvEx+ElR+x
 SQ2BbR3jT5zkDVwgdOZvRMmGZGBE8CEN579ytgmAjAqBvFmBh8r1V0dvWPqP81iHVCKK
 HjaQ==
X-Gm-Message-State: AOJu0YzByCQLJkPKllJgTZkUQPffOXrjLa9DnJ7q9DDom1e2405rhLEZ
 8ZcwO7PwoO90KMSeyo8Uw7CCUMRcsKQ=
X-Google-Smtp-Source: AGHT+IGeJNTZzHuKLvGMnITTz3PB4FSAGA5kgYU8DwNQ9aZXAsonR5Mg3K0xJIqq8SqHf/kMC8zTPw==
X-Received: by 2002:a05:600c:4fd6:b0:401:bdd7:49ae with SMTP id
 o22-20020a05600c4fd600b00401bdd749aemr8020872wmq.18.1702925503118; 
 Mon, 18 Dec 2023 10:51:43 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-092-224-039-156.92.224.pool.telefonica.de. [92.224.39.156])
 by smtp.gmail.com with ESMTPSA id
 s7-20020a05600c45c700b0040c45071c18sm35134091wmo.39.2023.12.18.10.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 10:51:42 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 10/12] hw/char/parallel-isa: Implement relocation and
 toggling for TYPE_ISA_PARALLEL
Date: Mon, 18 Dec 2023 19:51:12 +0100
Message-ID: <20231218185114.119736-11-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218185114.119736-1-shentey@gmail.com>
References: <20231218185114.119736-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Implement isa_parallel_set_{enabled,iobase} in order to implement relocation and
toggling of SuperI/O functions in the VIA south bridges without breaking
encapsulation.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/char/parallel-isa.h |  3 +++
 hw/char/parallel-isa.c         | 14 ++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/hw/char/parallel-isa.h b/include/hw/char/parallel-isa.h
index 3b783bd08d..5284b2ffec 100644
--- a/include/hw/char/parallel-isa.h
+++ b/include/hw/char/parallel-isa.h
@@ -29,4 +29,7 @@ struct ISAParallelState {
     PortioList portio_list;
 };
 
+void isa_parallel_set_iobase(ISADevice *parallel, hwaddr iobase);
+void isa_parallel_set_enabled(ISADevice *parallel, bool enabled);
+
 #endif /* HW_PARALLEL_ISA_H */
diff --git a/hw/char/parallel-isa.c b/hw/char/parallel-isa.c
index ab0f879998..a5ce6ee13a 100644
--- a/hw/char/parallel-isa.c
+++ b/hw/char/parallel-isa.c
@@ -41,3 +41,17 @@ void parallel_hds_isa_init(ISABus *bus, int n)
         }
     }
 }
+
+void isa_parallel_set_iobase(ISADevice *parallel, hwaddr iobase)
+{
+    ISAParallelState *s = ISA_PARALLEL(parallel);
+
+    parallel->ioport_id = iobase;
+    s->iobase = iobase;
+    portio_list_set_address(&s->portio_list, s->iobase);
+}
+
+void isa_parallel_set_enabled(ISADevice *parallel, bool enabled)
+{
+    portio_list_set_enabled(&ISA_PARALLEL(parallel)->portio_list, enabled);
+}
-- 
2.43.0


