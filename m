Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D97D70E1E6
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:37:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1V0C-0001Go-Va; Tue, 23 May 2023 12:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1V0B-0001FP-FB
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:36:47 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1V08-0001hY-Uo
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:36:47 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3093a7b71fbso7347429f8f.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684859803; x=1687451803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LoKzYtGI7sysobWsyNZRR7hMSKUoHQ2fOYULMUN/GtU=;
 b=Zkyz29agILkhhtATpLyavCWN++d8QSZ0S8hpJ+v6wRNoFZkJii6sgLOmOT6P0XLxq/
 PV+6XEyfA/zye3EMNCINhojrAEfM6lrhO26Njk0kk5/u8U7Z5YcWRgiI5AfpgTYfGww7
 5PrcUf2a93B7yDEJv7ImBBtpFbWV8lTI0vyC89UCl0XeulYJUo3TCTYAT++VFRCFvr4z
 lk5fv3ujXLad3EFnrz8KH2usqfhVFjDOos7UfyaGdREVwkl/NPX+7GaEv5sH8gE6lv3l
 a9hRyfCEY49xJl/0VZVKw53l3eMKib6w4CESGI6tCTH0LREb0luC66iaY0lx5CpeHkDw
 lsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684859803; x=1687451803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LoKzYtGI7sysobWsyNZRR7hMSKUoHQ2fOYULMUN/GtU=;
 b=N7rF93R8XMWgVGQpXqqJeuD105sE4XRHH1pCIzM7UAZBwp7g6di6beOEJu/1Gv3Pj1
 hXRlpaYbDXnHaC2Iaudi6WpgfPN1AWJejdDdWriqVaQ4iG8u3F7IIG0lOe+0uq4YJuHK
 O3hzvERTzfCZymtbNkzZu/psLwRz65TM4DOoBSHvY1fNjqkklY9BMwqYcwftLT5TRp1s
 tCoUoQ+Z7oS+KdDiqpfj1BHfcOHrFnmMHXQlkXNDH1NDCzg0ChLzsgaq/bBD2D7TVRnV
 gFL49umCCK2FhUHE95LbyyJHgOvyDJmoFgMfL4FxeNlTp7bNb0N+5gGaF++d6kLLsEG9
 kiOg==
X-Gm-Message-State: AC+VfDzZqcHd/sw86Ow9cbu9CHtVfwBo9u1DD/nGfSM02KlF1dYvqpCV
 cWvDNCAF23n4wFuSwU7+TLgPLE/FJ18zTMviDyY=
X-Google-Smtp-Source: ACHHUZ4LyIR/hoVtxCmsZve4h5nIgXZ6oI4E0/m+5TnUg3AoJcvcJslo/YuZWRBfvk3H1ZpJBJlfow==
X-Received: by 2002:adf:e945:0:b0:309:3a83:cf43 with SMTP id
 m5-20020adfe945000000b003093a83cf43mr10284626wrn.27.1684859803286; 
 Tue, 23 May 2023 09:36:43 -0700 (PDT)
Received: from localhost.localdomain
 (vil69-h02-176-184-48-94.dsl.sta.abo.bbox.fr. [176.184.48.94])
 by smtp.gmail.com with ESMTPSA id
 g9-20020adffc89000000b002e5ff05765esm11616459wrr.73.2023.05.23.09.36.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 May 2023 09:36:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Peter Xu <peterx@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Eric Farman <farman@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org
Subject: [PATCH 06/11] hw/virtio/virtio-mem: Use qemu_ram_get_fd() helper
Date: Tue, 23 May 2023 18:35:55 +0200
Message-Id: <20230523163600.83391-7-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230523163600.83391-1-philmd@linaro.org>
References: <20230523163600.83391-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Avoid accessing RAMBlock internals, use the provided
qemu_ram_get_fd() getter to get the file descriptor.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/virtio-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 538b695c29..74e63bd47a 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -135,7 +135,7 @@ static bool virtio_mem_has_shared_zeropage(RAMBlock *rb)
      * anonymous RAM. In any other case, reading unplugged *can* populate a
      * fresh page, consuming actual memory.
      */
-    return !qemu_ram_is_shared(rb) && rb->fd < 0 &&
+    return !qemu_ram_is_shared(rb) && qemu_ram_get_fd(rb) < 0 &&
            qemu_ram_pagesize(rb) == qemu_real_host_page_size();
 }
 #endif /* VIRTIO_MEM_HAS_LEGACY_GUESTS */
-- 
2.38.1


