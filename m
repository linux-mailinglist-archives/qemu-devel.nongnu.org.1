Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E38227F3EF4
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 08:37:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5hmr-0004i2-8R; Wed, 22 Nov 2023 02:36:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r5hmn-0004he-5P
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 02:36:37 -0500
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r5hmj-0002sQ-8f
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 02:36:36 -0500
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2c6b30aca06so79613181fa.3
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 23:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700638591; x=1701243391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=heh+k4/ZBsoYVeDKOiMmdTEQKR9cVd8tuPwq4kKh4gg=;
 b=U+BFUGASSaotWMch+ue/90IPM0JLpis7a0Shs1HBQ/+mfEGPA5gR7EO5/ZzeyGRP9B
 +xhNa/5nNoQlSNTjhzXuFDIasNFJjpwdhO1z/VIgcRt/mrWaRZ7MoHuelnOBYG1O/YM0
 io2aW+cD4t8IvKEE+x0XByzhECdgNI3A6SVI6y8pdn5BToPzHkuxMsHBOV6GqNe6uUvQ
 5JSno99mWStSPPBi8FQxuMZccBKcw8HoZ/gPd2IrrIdVdxXbsVM1LlGWjstoCreD70sZ
 Xc7O+n5lbHh0y0hpEEBOmzysqPmGSJaAsv31CdE2W5CODeXJmoqVRE6Ksuf/Y76+/4t7
 igzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700638591; x=1701243391;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=heh+k4/ZBsoYVeDKOiMmdTEQKR9cVd8tuPwq4kKh4gg=;
 b=oW1rLqQeBZIr8+TbukJlj7/ZvI+EKqs0kGw1NNgN6KcXjvNxQEgBVuANXXcgXafizx
 /GIIsXBbcvYBdVELr8C7QykEA4gV6oHiEnOLrMu4WEz/uU9yMKrxg5aEQO4aHxcrrbe0
 /wY/eb3e2ZLtqxcJVUhBc89zRLho2G9qndUv6UXsN9cYeolNV31UzxkHzNLLOxF4V19F
 xLaHOlgseagZ+amZBwEfWIF6lcRE0egk29NOBggue1vV+ao2TzV8yJUpf7IQ1c5AGgx2
 iPrzJIlHzE/E5VRV0TxhEmBJrudwlvl0Jtp+RSvdYif6Enk+HEf38sRPDu3np4tM6l1T
 IOGQ==
X-Gm-Message-State: AOJu0YwoBYJK8FaOrsINW3h1LUCJjdQBFvcGY/h2O4JGxOWUKIrDJWNd
 kGcRTurbqJRq2UbJPXlp16FQWQ==
X-Google-Smtp-Source: AGHT+IFvy9Ui2xYpyFBgpZPk+6IF5JVwMopCeVRmsH7LIKhaudKmH7oSXJkPCDa475JZd+9DL9gr9w==
X-Received: by 2002:a2e:991a:0:b0:2bb:b01a:9226 with SMTP id
 v26-20020a2e991a000000b002bbb01a9226mr881290lji.7.1700638590760; 
 Tue, 21 Nov 2023 23:36:30 -0800 (PST)
Received: from meli.delivery (adsl-27.37.6.163.tellas.gr. [37.6.163.27])
 by smtp.gmail.com with ESMTPSA id
 3-20020a05600c234300b00405c33a9a12sm2063384wmq.0.2023.11.21.23.36.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 23:36:30 -0800 (PST)
Date: Wed, 22 Nov 2023 09:32:26 +0200
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
Subject: Re: [PATCH-for-9.0 17/25] backends: Reduce variable scope in
 host_memory_backend_memory_complete
User-Agent: meli 0.8.2
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-18-philmd@linaro.org>
In-Reply-To: <20231120213301.24349-18-philmd@linaro.org>
Message-ID: <4il4s.ev85gnoc1wow@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x229.google.com
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

On Mon, 20 Nov 2023 23:32, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>Reduce the &local_err variable use and remove the 'out:' label.
>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>---
> backends/hostmem.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/backends/hostmem.c b/backends/hostmem.c
>index 3f8eb936d7..1b0043a0d9 100644
>--- a/backends/hostmem.c
>+++ b/backends/hostmem.c
>@@ -324,7 +324,6 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
> {
>     HostMemoryBackend *backend = MEMORY_BACKEND(uc);
>     HostMemoryBackendClass *bc = MEMORY_BACKEND_GET_CLASS(uc);
>-    Error *local_err = NULL;
>     void *ptr;
>     uint64_t sz;
> 
>@@ -400,15 +399,16 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
>      * specified NUMA policy in place.
>      */
>     if (backend->prealloc) {
>+        Error *local_err = NULL;
>+
>         qemu_prealloc_mem(memory_region_get_fd(&backend->mr), ptr, sz,
>                           backend->prealloc_threads,
>                           backend->prealloc_context, &local_err);
>         if (local_err) {
>-            goto out;
>+            error_propagate(errp, local_err);
>+            return;
>         }
>     }
>-out:
>-    error_propagate(errp, local_err);
> }
> 
> static bool
>-- 

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>



