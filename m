Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CC080A1AA
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 12:00:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBYZE-00027d-I9; Fri, 08 Dec 2023 05:58:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBYZD-00027U-2j
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 05:58:47 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBYZB-00075d-A7
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 05:58:46 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40c09d62b70so22768165e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 02:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702033123; x=1702637923; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xu1HnZrXMUko7chG70ipHOZ+FcwWXqgidCwZ48iHVJg=;
 b=lKusxQVkF8HrqIBns6rn+QO5bTGP9YcJIQHapfELkoAzAsBmq0C+2e1TOlilFobtSf
 rxqNmEcj0DqeQyrzLTV4vFHbnzUQ7Z8KsJ+Zp6VA9nws4IsHSNdpZPMBrMpfJ68CnYbP
 ExJlUJk28fF7FvHCng31UkXou7rp/dxnEvtJlPSsXzuZNGtUUgr9wkrLfo7//cIblpj4
 RAUsP5SfpRzlB9BuJjT5IRSHOw1RI/AlbR97DlJJu4gPUxju5iE2H0+TUr224cYo/1TT
 bLW99PWXO9u8vkZKl4VUualXVaNEmO0fG6O0sFZu3EotdCFz/5DaN/IFBNYA8rfWEgO2
 uKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702033123; x=1702637923;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xu1HnZrXMUko7chG70ipHOZ+FcwWXqgidCwZ48iHVJg=;
 b=j8GtL7NCH4Ta2UGSTjAviPkj+Zqkm2HEnbz/rJkQV1LIMnPUD4C9XkqR8M+O64aoTZ
 M3RoLKi79FCRqqfp7EA2D1bzGt7S2rtUBPVGrKCXqqHXhE2UEfaR+3h3ENAxyqwCrNuv
 6uGgGLb15ifcEdccprSEk9SHjixuvPetockD762ed3f1KRu9OaqIn4GmqYDi0teTJieh
 GmGUFKbRKU8vFJ5bB/2hGSElTvfDegt5lSardnuw8YaC+LxhNEOUSClmJJWi0LeejFgy
 YTz7V8SXQ6TGKrME6/8sgCxjJjhZVHJv6iINQcL/e9xxBkJcXSqx0SiNMLn/RcjUg1V/
 tGaw==
X-Gm-Message-State: AOJu0Yw4gfnYxKtpnM8m95EiXrsYKe3/eMhJrwd3dK++JJJ4hCCdeELc
 HTQaqxH9ZgCHvrcpFdLHo2Mj0w==
X-Google-Smtp-Source: AGHT+IGewBEBx95tJ+FATXwtrVK1Nz3BVXEKjSgiiLtdhUe+DN9thOg5TiAKKP24s0Ll3QfDgbDkGg==
X-Received: by 2002:a05:600c:4f94:b0:40b:5e21:c5c7 with SMTP id
 n20-20020a05600c4f9400b0040b5e21c5c7mr1619447wmq.149.1702033123468; 
 Fri, 08 Dec 2023 02:58:43 -0800 (PST)
Received: from [192.168.69.100] ([176.176.146.181])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a05600c4f0600b0040b45282f88sm4768729wmq.36.2023.12.08.02.58.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Dec 2023 02:58:43 -0800 (PST)
Message-ID: <5b7f8743-977a-49a5-864a-15e920806c68@linaro.org>
Date: Fri, 8 Dec 2023 11:58:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] target: Make qemu_target_page_mask() available for
 *-user
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20231208003754.3688038-1-iii@linux.ibm.com>
 <20231208003754.3688038-2-iii@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231208003754.3688038-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 8/12/23 01:35, Ilya Leoshkevich wrote:
> Currently qemu_target_page_mask() is usable only from the softmmu
> code. Make it possible to use it from the *-user code as well.
> 
> Make use of it in perf.c.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   accel/tcg/perf.c       |  3 ++-
>   system/physmem.c       |  5 -----
>   target/meson.build     |  2 ++
>   target/target-common.c | 10 ++++++++++
>   4 files changed, 14 insertions(+), 6 deletions(-)
>   create mode 100644 target/target-common.c


> diff --git a/target/meson.build b/target/meson.build
> index a53a60486fc..dee2ac47e02 100644
> --- a/target/meson.build
> +++ b/target/meson.build
> @@ -19,3 +19,5 @@ subdir('sh4')
>   subdir('sparc')
>   subdir('tricore')
>   subdir('xtensa')
> +
> +specific_ss.add(files('target-common.c'))
> diff --git a/target/target-common.c b/target/target-common.c
> new file mode 100644
> index 00000000000..903b10cfe4b
> --- /dev/null
> +++ b/target/target-common.c
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#include "qemu/osdep.h"
> +
> +#include "cpu.h"
> +#include "exec/target_page.h"
> +
> +int qemu_target_page_mask(void)
> +{
> +    return TARGET_PAGE_MASK;
> +}

FYI I carry this patch and am going to post it soon:

-- >8 --
diff --git a/meson.build b/meson.build
index d2c4c2adb3..5fdc4ef8db 100644
--- a/meson.build
+++ b/meson.build
@@ -3488,7 +3488,7 @@ if get_option('b_lto')
    pagevary = declare_dependency(link_with: pagevary)
  endif
  common_ss.add(pagevary)
-specific_ss.add(files('page-vary-target.c'))
+specific_ss.add(files('page-target.c', 'page-vary-target.c'))

  subdir('backends')
  subdir('disas')
diff --git a/page-target.c b/page-target.c
new file mode 100644
index 0000000000..d286e2d58b
--- /dev/null
+++ b/page-target.c
@@ -0,0 +1,43 @@
+/*
+ * QEMU page values getters (target independent)
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "exec/target_page.h"
+#include "exec/cpu-defs.h"
+#include "exec/cpu-all.h"
+
+size_t qemu_target_page_size(void)
+{
+    return TARGET_PAGE_SIZE;
+}
+
+int qemu_target_page_mask(void)
+{
+    return TARGET_PAGE_MASK;
+}
+
+int qemu_target_page_bits(void)
+{
+    return TARGET_PAGE_BITS;
+}
+
+int qemu_target_page_bits_min(void)
+{
+    return TARGET_PAGE_BITS_MIN;
+}
+
+/* Convert target pages to MiB (2**20). */
+size_t qemu_target_pages_to_MiB(size_t pages)
+{
+    int page_bits = TARGET_PAGE_BITS;
+
+    /* So far, the largest (non-huge) page size is 64k, i.e. 16 bits. */
+    g_assert(page_bits < 20);
+
+    return pages >> (20 - page_bits);
+}
diff --git a/system/physmem.c b/system/physmem.c
index a63853a7bc..4bdb3d0592 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3422,41 +3422,6 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
      return 0;
  }

-/*
- * Allows code that needs to deal with migration bitmaps etc to still 
be built
- * target independent.
- */
-size_t qemu_target_page_size(void)
-{
-    return TARGET_PAGE_SIZE;
-}
-
-int qemu_target_page_mask(void)
-{
-    return TARGET_PAGE_MASK;
-}
-
-int qemu_target_page_bits(void)
-{
-    return TARGET_PAGE_BITS;
-}
-
-int qemu_target_page_bits_min(void)
-{
-    return TARGET_PAGE_BITS_MIN;
-}
-
-/* Convert target pages to MiB (2**20). */
-size_t qemu_target_pages_to_MiB(size_t pages)
-{
-    int page_bits = TARGET_PAGE_BITS;
-
-    /* So far, the largest (non-huge) page size is 64k, i.e. 16 bits. */
-    g_assert(page_bits < 20);
-
-    return pages >> (20 - page_bits);
-}
-
  bool cpu_physical_memory_is_io(hwaddr phys_addr)
  {
      MemoryRegion*mr;
---

