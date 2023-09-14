Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D68537A0512
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 15:10:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgm6G-0003o1-6Y; Thu, 14 Sep 2023 09:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgm6D-0003nd-2m
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 09:09:37 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgm69-0006xp-HX
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 09:09:36 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-52a23227567so1153565a12.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 06:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694696971; x=1695301771; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lk589Yo0o47fVYW+/y70Qbq6qyRx2NgMPe3k2lJornE=;
 b=cwYyr3ORElXoCi3nw2z4WKO/vXBB7HANrIAJMY56JH5pBVzkIFep/9hbCGm0cD4rEA
 Aispgi9WaXhjV4MZUIsJ0YFwfgHkMPAeLw3JOP2f4C67NGLXnJCnKXnR/e7noUULCB8j
 mLPzgytntiiGxaawqLPMd5ygp9nEKwMvfnjghUfD4rnwSdn1CQ9zB4cOKAbggRL/sPx8
 felQZGtneGkHOh3gJT3ji+wGkD8X1+UCkoDDGz78Lwa+cWW3khEhj9tyPigEYanhPvKM
 hoPLrzhhjZChqDhcCWS0vtPqkXaZ+QsYfRbtIH014HjX4Noh1sxmdVcUCnbVC4nIh+V7
 J3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694696971; x=1695301771;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lk589Yo0o47fVYW+/y70Qbq6qyRx2NgMPe3k2lJornE=;
 b=DZPn/HSUEfpXrcNLUtU40Y3IK9yqKZ5KrFR3NBNgCzeLYSzKYEwXcsklcxhPIj4dhv
 0KDBa7bPJGebcaSkIjrpNahOo0brPUc6sib+GMP/19C7Cf488hPpXmYuUTiPTtnYU35A
 bK/Ex8J7AuQLgpXITOFdVsBU2/jNl+w3o9juLJFnyb/zqnmoKu63ONu3R5T4CjqWnYYN
 O1o/ZSE8dZR72xCiZRd0WPyukdc6yMQbjzmby6ImaRIr2cOtZuAl4VFCLNEDOswoEpqg
 aHFpOZAcHshE6470jmkzSFk6MG9pihaksxqVdOhgxN4+isoPR4Kh2WbER8yC/toiHb45
 yAcw==
X-Gm-Message-State: AOJu0YxKH0nV90XlRmJIcoLrmIUIyZS31wTeOHgcXllH10S/ZZAzh6EM
 qg2HmosvGfk/7r4To63AM3AMHQ==
X-Google-Smtp-Source: AGHT+IFW963oZqWxBtn9a1Fcu4v7KZBOgKZV18rZhrx/3LIzWBNHSKhMfc1m0XuYpaaea78JhpnoDg==
X-Received: by 2002:aa7:cd52:0:b0:523:bfec:4915 with SMTP id
 v18-20020aa7cd52000000b00523bfec4915mr5083268edw.0.1694696970807; 
 Thu, 14 Sep 2023 06:09:30 -0700 (PDT)
Received: from [192.168.69.115] (176-131-223-129.abo.bbox.fr.
 [176.131.223.129]) by smtp.gmail.com with ESMTPSA id
 o18-20020aa7c512000000b0052540e85390sm926286edq.43.2023.09.14.06.09.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 06:09:30 -0700 (PDT)
Message-ID: <b8b1631a-9295-6e80-5df9-90631c2080c3@linaro.org>
Date: Thu, 14 Sep 2023 15:09:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] hw/qxl: move check of slot_id before accessing guest_slots
Content-Language: en-US
To: Anastasia Belova <abelova@astralinux.ru>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org,
 Michael Tokarev <mjt@tls.msk.ru>
References: <20230914092717.7158-1-abelova@astralinux.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230914092717.7158-1-abelova@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

Hi Anastasia,

On 14/9/23 11:27, Anastasia Belova wrote:
> If slot_id >= NUM_MEMSLOTS, buffer overflow is possible.

overflow: unlikely. Do you mean over-read?

Did you found that by code audit? I can't see where this
function get slot_id >= NUM_MEMSLOTS.

This isn't guest triggerable and seems an API invalid use,
so developer error, which we can catch with assertions:

-- >8 --
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 7bb00d68f5..443f034168 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -1309,16 +1309,13 @@ static int qxl_add_memslot(PCIQXLDevice *d, 
uint32_t slot_id, uint64_t delta,
      QXLDevMemSlot memslot;
      int i;

+    assert(slot_id < NUM_MEMSLOTS);
+
      guest_start = le64_to_cpu(d->guest_slots[slot_id].slot.mem_start);
      guest_end   = le64_to_cpu(d->guest_slots[slot_id].slot.mem_end);

      trace_qxl_memslot_add_guest(d->id, slot_id, guest_start, guest_end);

-    if (slot_id >= NUM_MEMSLOTS) {
-        qxl_set_guest_bug(d, "%s: slot_id >= NUM_MEMSLOTS %d >= %d", 
__func__,
-                      slot_id, NUM_MEMSLOTS);
-        return 1;
-    }
      if (guest_start > guest_end) {
          qxl_set_guest_bug(d, "%s: guest_start > guest_end 0x%" PRIx64
                           " > 0x%" PRIx64, __func__, guest_start, 
guest_end);
---

Note, qxl_add_memslot() return value is ignored...

> So the check should be upper than d->guest_slots[slot_id]
> where size of d->guest_slots is NUM_MEMSLOTS.
> 
> Fixes: e954ea2873 ("qxl: qxl_add_memslot: remove guest trigerrable panics")
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> ---
>   hw/display/qxl.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> index 7bb00d68f5..dc618727c0 100644
> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -1309,16 +1309,17 @@ static int qxl_add_memslot(PCIQXLDevice *d, uint32_t slot_id, uint64_t delta,
>       QXLDevMemSlot memslot;
>       int i;
>   
> -    guest_start = le64_to_cpu(d->guest_slots[slot_id].slot.mem_start);
> -    guest_end   = le64_to_cpu(d->guest_slots[slot_id].slot.mem_end);
> -
> -    trace_qxl_memslot_add_guest(d->id, slot_id, guest_start, guest_end);
> -
>       if (slot_id >= NUM_MEMSLOTS) {
>           qxl_set_guest_bug(d, "%s: slot_id >= NUM_MEMSLOTS %d >= %d", __func__,
>                         slot_id, NUM_MEMSLOTS);
>           return 1;
>       }
> +
> +    guest_start = le64_to_cpu(d->guest_slots[slot_id].slot.mem_start);
> +    guest_end   = le64_to_cpu(d->guest_slots[slot_id].slot.mem_end);
> +
> +    trace_qxl_memslot_add_guest(d->id, slot_id, guest_start, guest_end);
> +
>       if (guest_start > guest_end) {
>           qxl_set_guest_bug(d, "%s: guest_start > guest_end 0x%" PRIx64
>                            " > 0x%" PRIx64, __func__, guest_start, guest_end);


