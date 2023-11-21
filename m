Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD4D7F2CD0
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 13:13:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5PcA-0001a1-3K; Tue, 21 Nov 2023 07:12:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r5Pc1-0001YW-Ou
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 07:12:17 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r5Pbz-0001xG-6q
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 07:12:17 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40b2b3da41eso2907755e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 04:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700568733; x=1701173533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=TF0gAB9WSwpKOqjmrXXi1XjhOCnDRrZ4WlPzaCamL7w=;
 b=EASYvuVFqPB1gSvxk91q3YwiYM8jxparsbv2vmCRFdFWBM1R3tGIJzcfMxEobj9uKt
 ZEikJHc8IE2GEOWKOWYusYln8GEytEQ1MyQFkVJ0mXJK1rSJooMQEKVCqm7+o2xWrGHJ
 lBtj+MWbHrUSkJG/YpDKBgSi0tqOCiy2rRDKGkDGkvIq3skM/gReqNNalN0V2U7AdyAU
 HJrXkClHKTsEqIKmkLIXAbpvQlvVIr6uVwdyhKVhBp3I035/HyfwzJ8KWyrUh/dfbhDA
 FNzpy0shutt7T/sLGi3SDCyp1ESGnMlQB32yw6VQvcjsQoxWi5AUAtM3wD/qQUXVXk4A
 XWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700568733; x=1701173533;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TF0gAB9WSwpKOqjmrXXi1XjhOCnDRrZ4WlPzaCamL7w=;
 b=PI3M/98vPF0jdGifLe0HGPo75b5guk9HyBXppngLu7s0JAFEw9pfi+xHjDGvpJP/4d
 S1lUoF7O9XI8Sy8bY+BCIE5Lb9jeRWTM2soDsM58aecUTgcWwwE0IybC9Wvp9lErbuvh
 Zl7ybetZSoODSNsW3ytGg6Pp9JIlR3DBodeRde09xvp0FKTWcvCeRouXa12rWf05MNjR
 ZtBvZL1IUU6oZP/8/qqgmEFloa2S+X6Mz77918J7z/RqXrIdhQAJIhHCEIC7GVKEA5kC
 wJwYvusAOpTaFsyc+E4lf8QzBOjVxPGQDhQ7RiE9E/+RTs2E5gBVUlQ+VoilPb8Wn1Tt
 apXw==
X-Gm-Message-State: AOJu0Yy2NNTbkP8UGhYiDwVooqHLwr4m2bppWSm35zk5YOF0n/3vk0fI
 GQWvYXWcVA3xE3u8EtTQuj3onQ==
X-Google-Smtp-Source: AGHT+IEu59CWEMrjhsmqnOkATlVAgUxJuZyMYWYSERymUoR9PUoQA3EH8cxbG/pf/TthypM0xkznug==
X-Received: by 2002:a5d:5cc5:0:b0:327:e073:d5fe with SMTP id
 cg5-20020a5d5cc5000000b00327e073d5femr6095959wrb.38.1700568732868; 
 Tue, 21 Nov 2023 04:12:12 -0800 (PST)
Received: from meli.delivery (adsl-27.37.6.163.tellas.gr. [37.6.163.27])
 by smtp.gmail.com with ESMTPSA id
 i11-20020a5d55cb000000b003143867d2ebsm14192554wrw.63.2023.11.21.04.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 04:12:12 -0800 (PST)
Date: Tue, 21 Nov 2023 14:10:28 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-arm@nongnu.org,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 C=?UTF-8?B?w6k=?= dric Le Goater <clg@kaod.org>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH-for-9.0 03/25] memory: Have
 memory_region_init_rom_nomigrate() handler return a boolean
User-Agent: meli 0.8.2
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-4-philmd@linaro.org>
In-Reply-To: <20231120213301.24349-4-philmd@linaro.org>
Message-ID: <4h38a.h95poe276hnn@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 20 Nov 2023 23:32, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>Following the example documented since commit e3fe3988d7 ("error:
>Document Error API usage rules"), have cpu_exec_realizefn()
>return a boolean indicating whether an error is set or not.
>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>---
> include/exec/memory.h | 4 +++-
> system/memory.c       | 8 ++++++--
> 2 files changed, 9 insertions(+), 3 deletions(-)
>
>diff --git a/include/exec/memory.h b/include/exec/memory.h
>index 4140eb0c95..8e6fb55f59 100644
>--- a/include/exec/memory.h
>+++ b/include/exec/memory.h
>@@ -1498,8 +1498,10 @@ void memory_region_init_alias(MemoryRegion *mr,
>  *        must be unique within any device
>  * @size: size of the region.
>  * @errp: pointer to Error*, to store an error if it happens.
>+ *
>+ * Return: true on success, else false setting @errp with error.
>  */
>-void memory_region_init_rom_nomigrate(MemoryRegion *mr,
>+bool memory_region_init_rom_nomigrate(MemoryRegion *mr,
>                                       Object *owner,
>                                       const char *name,
>                                       uint64_t size,
>diff --git a/system/memory.c b/system/memory.c
>index 337b12a674..bfe0b62d59 100644
>--- a/system/memory.c
>+++ b/system/memory.c
>@@ -1729,14 +1729,18 @@ void memory_region_init_alias(MemoryRegion *mr,
>     mr->alias_offset = offset;
> }
> 
>-void memory_region_init_rom_nomigrate(MemoryRegion *mr,
>+bool memory_region_init_rom_nomigrate(MemoryRegion *mr,
>                                       Object *owner,
>                                       const char *name,
>                                       uint64_t size,
>                                       Error **errp)
> {
>-    memory_region_init_ram_flags_nomigrate(mr, owner, name, size, 0, errp);
>+    bool rv;
>+
>+    rv = memory_region_init_ram_flags_nomigrate(mr, owner, name, size, 0, errp);
>     mr->readonly = true;
>+

By the way, do we want to set mr->readonly on failure? Should there be 
modifications if an error is propagated upwards?




