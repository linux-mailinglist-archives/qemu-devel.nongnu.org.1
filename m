Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A89517F2C7E
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 13:04:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5PTZ-00057e-B1; Tue, 21 Nov 2023 07:03:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r5PSj-0004ta-T6
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 07:02:45 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r5PSh-0006gp-0f
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 07:02:41 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40839807e82so17302715e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 04:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700568157; x=1701172957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=bGW2vxLm7g1qtpfBccUqInrEwdq3kJsYsbttZX1AwHY=;
 b=bvMTV18jQxq4OCAr0hwOXbRjIef7V8RtlHaLTLkyuDXI3VYn6bKxcjtEr7IkYekwmM
 m2+PcDISIPrhK+q4t4oOYAcaqcy0fhv6eTu6Is82RTzyPSof7pxN26Ki5+o1agiU8MX1
 RrbF0rx5B2dT1hLIiLCLcB3trlJ4CLVWNvWxpGks8/Dr7ZAorG4q26UqVsvYi6mBkXDp
 r5Wiy+LDsh3onS+XpAAu3j8ZiCOi1b3kXf8VhlPOVNcrqWefMggULXkLPZW1khYJidRs
 73I3NMoYdUoOaHTYMW+iDgR/RzbV9mOjt+frJnswyRJB11AeCGGmO/SKl34D9+8Xm6qV
 6rpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700568157; x=1701172957;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bGW2vxLm7g1qtpfBccUqInrEwdq3kJsYsbttZX1AwHY=;
 b=SDI7TD+03NferQlL7yFRM9GfUEoQz+0zmV1psleJVgmG+wMpP9zLO6jEXRPjX/lbEu
 rXmsBGl/tsvcuUL38e3Mw/lzRLo6+xYQsiQmoNC2xdEt5QvMg1XIYpIbvthrTE9Vs/s6
 ncpZjnCnEqWSpxn6O0/OLnD0P6Pmqqc9QQNF4YLFqSa8576qKd3rIDnw4ExuWzraX8EL
 prlO+o/VKdfVFrQI8BF8uZtkDQswcNF1PM4ks8FaQT7xdGZgpTsWbd5ve0oIPbABYYxQ
 Z+8rDdsw6tkOAtp5cDzS4h0QH67SJH8NsPqc6Src1O8hc2sToqV+2Z1eeJdRB+iU2YWx
 cQgg==
X-Gm-Message-State: AOJu0YzddBVtoPJKYWin2uqTH5i6ySpEqOczuDAPNfyTvQLk6lx7DcNz
 SR89ARcJfU29r27OJDeea8lMYg==
X-Google-Smtp-Source: AGHT+IGZDVyWe8h6Qqw33LcL2b1o0Fvr7HGIPuuuVi1PvQaw1sBWvrTfGB516h/RysUAn9IRfJbtdQ==
X-Received: by 2002:a1c:7518:0:b0:40b:2afd:1a9 with SMTP id
 o24-20020a1c7518000000b0040b2afd01a9mr1127222wmc.15.1700568156228; 
 Tue, 21 Nov 2023 04:02:36 -0800 (PST)
Received: from meli.delivery (adsl-75.109.242.226.tellas.gr. [109.242.226.75])
 by smtp.gmail.com with ESMTPSA id
 v12-20020a05600c214c00b004065daba6casm20994041wml.46.2023.11.21.04.02.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 04:02:35 -0800 (PST)
Date: Tue, 21 Nov 2023 13:54:27 +0200
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
Subject: Re: [PATCH-for-9.0 02/25] memory: Have
 memory_region_init_ram_nomigrate() handler return a boolean
User-Agent: meli 0.8.2
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-3-philmd@linaro.org>
In-Reply-To: <20231120213301.24349-3-philmd@linaro.org>
Message-ID: <4h2s9.5sthh644d88o@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x331.google.com
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
> system/memory.c       | 5 +++--
> 2 files changed, 6 insertions(+), 3 deletions(-)
>
>diff --git a/include/exec/memory.h b/include/exec/memory.h
>index f038a7e5cf..4140eb0c95 100644
>--- a/include/exec/memory.h
>+++ b/include/exec/memory.h
>@@ -1288,8 +1288,10 @@ void memory_region_init_io(MemoryRegion *mr,
>  *
>  * Note that this function does not do anything to cause the data in the
>  * RAM memory region to be migrated; that is the responsibility of the caller.
>+ *
>+ * Return: true on success, else false setting @errp with error.
>  */
>-void memory_region_init_ram_nomigrate(MemoryRegion *mr,
>+bool memory_region_init_ram_nomigrate(MemoryRegion *mr,
>                                       Object *owner,
>                                       const char *name,
>                                       uint64_t size,
>diff --git a/system/memory.c b/system/memory.c
>index 313dbb2544..337b12a674 100644
>--- a/system/memory.c
>+++ b/system/memory.c
>@@ -1574,13 +1574,14 @@ void memory_region_init_io(MemoryRegion *mr,
>     mr->terminates = true;
> }
> 
>-void memory_region_init_ram_nomigrate(MemoryRegion *mr,
>+bool memory_region_init_ram_nomigrate(MemoryRegion *mr,
>                                       Object *owner,
>                                       const char *name,
>                                       uint64_t size,
>                                       Error **errp)
> {
>-    memory_region_init_ram_flags_nomigrate(mr, owner, name, size, 0, errp);
>+    return memory_region_init_ram_flags_nomigrate(mr, owner, name,
>+                                                  size, 0, errp);
> }
> 
> bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
>-- 
>2.41.0
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>




