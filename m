Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB4A7D039D
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:20:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaPj-0004rc-3Q; Thu, 19 Oct 2023 17:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaPh-0004qw-M1
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:18:41 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaPf-0004Mt-4N
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:18:41 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40651a72807so989295e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697750317; x=1698355117; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P143GsrIkkWZV6XUtWMe/VI7qSgf5Ym9rpk/8SpsGrY=;
 b=gN8aIfFlCniSPQR6HBy6imi5+JxWeXaZFvIIo7yGYXPcRJbjvanoNhROKSXzo/9RdG
 Z3860kB8nEDd1mj1VzP9ihIYqLf4DIbrgBy2LhAEK0WuRe3CwHYv4o75+oyPoWHUZvq5
 gj+TZQtc2/gqonbHTSPY678zxrUafmAXmKLgFP/paew0zkUQOgXuwEB4tArw/z9UfXGJ
 q7HQ99hPdvQbTFO1avXxYy7qYckm2OddNkOqOh26mPzBDefr66PQiclU0Am+ust49pNF
 vi9YkHTngsDmH8B+LVIUmYjTL/6zB/qfkJq6LdfJCUKcC3XGUN6gvm9Rn9ZMh1h4XVvL
 i7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697750317; x=1698355117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P143GsrIkkWZV6XUtWMe/VI7qSgf5Ym9rpk/8SpsGrY=;
 b=jujHN8S8cmHhj/UqHYxr5hfSoGI0qFC0yGFTinsRY16fIOJgmIqK6NqlxUSqjoQODN
 ghIrl2yIVVUQxu/V1ihQnt49XNkccTsGlTkacYmQ/6sHvIeFfZzCyxClBQEZf58CVsZW
 po08CFV/VEO5Nsn5CspWcgvtZ6begRErHTElWMOu7i20DaeEEgLaUKszc7d/T0pjhLnJ
 M2XpqEdr3kiRNdT4GFvdLef8Y3fmyxxD13bQHXljvMLnxRrbShCrST7aOzcHJfSpz4h9
 0kQ+BSZ2pSkCnV2v66gWvs1FxLfm0b8Ratyh8QzNuRtLMw+DZ7d5WxvNlAuoF7sXU0Q0
 6vag==
X-Gm-Message-State: AOJu0Yzc+wjL30ta4bErJqt+NQeqE9A5zn68Z/5VAqvRi4m4c/Lup+qs
 yRN6VZ+gAudIOL3ubwHsu5UKF2lFjQg9NGtLWu1Ewg==
X-Google-Smtp-Source: AGHT+IEzfAiO/GrKd6JTGCJbZN8bfM2Aik1xRx3vi6e2P0BIQgN1lcvjJM6h0DLWlakN+FMTIK/Efw==
X-Received: by 2002:a05:600c:3b20:b0:405:4f78:e128 with SMTP id
 m32-20020a05600c3b2000b004054f78e128mr62634wms.4.1697750317473; 
 Thu, 19 Oct 2023 14:18:37 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 p21-20020a05600c431500b004076f522058sm5278343wme.0.2023.10.19.14.18.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 14:18:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 03/46] MAINTAINERS: Add hw/input/lasips2.c to the HPPA machine
 section
Date: Thu, 19 Oct 2023 23:17:28 +0200
Message-ID: <20231019211814.30576-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019211814.30576-1-philmd@linaro.org>
References: <20231019211814.30576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Thomas Huth <thuth@redhat.com>

hw/input/lasips2.c and the corresponding header include/hw/input/lasips2.h
are only used by the HPPA machine, so add them to the corresponding section
in the MAINTAINERS file.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20231017151933.213780-1-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5f7d8ed866..29b350f819 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1179,9 +1179,11 @@ R: Helge Deller <deller@gmx.de>
 S: Odd Fixes
 F: configs/devices/hppa-softmmu/default.mak
 F: hw/hppa/
+F: hw/input/lasips2.c
 F: hw/net/*i82596*
 F: hw/misc/lasi.c
 F: hw/pci-host/dino.c
+F: include/hw/input/lasips2.h
 F: include/hw/misc/lasi.h
 F: include/hw/net/lasi_82596.h
 F: include/hw/pci-host/dino.h
-- 
2.41.0


