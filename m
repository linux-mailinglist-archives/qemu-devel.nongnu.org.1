Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D9F7F2CE5
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 13:16:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Pf0-0003YK-F0; Tue, 21 Nov 2023 07:15:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r5Pek-0003Y2-5L
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 07:15:06 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r5Peh-0002UB-Bp
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 07:15:05 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40859dee28cso27209155e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 04:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700568901; x=1701173701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=NpLx8dxJzqRjqYZvQ1tqeqGFEDximu0aVnXwrBcJhpM=;
 b=FrcSqaPdns9Aw2+bp7LUs7YDL71u3b2mJqNdNNxcKQA/mnO2eXlJ6qENWP4M40m0nt
 dUa3q6J/K0pSEPwO/Yw6WupOCh7JPD1Ux4VQrLPu2ENDLOMAdcx1sJBMa3YjSW9yqeO0
 xjbfERrRMqO2C0w/puMjlnKqCJF4EUYdivWlzE0wAWgTXqtXMOjDXKqaLXIhlVx0wuhT
 JMfFd6s/4p6PH3niiy6yhm6Md453UyKAVwPxVW8Vq+i4BsuPDKmztwCbIM1TEJEL4Pjg
 SgXkURxfGihN5jPmLF6qVl99YJ8uQuetI30JnDtxY+ProlrGq8LmY4UzYLBWPTfn3zlq
 qJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700568901; x=1701173701;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NpLx8dxJzqRjqYZvQ1tqeqGFEDximu0aVnXwrBcJhpM=;
 b=COvmtOKtuNGiDmv02ZcH1JpGItvw+ihw0mkxJcM4fH1kxd21aOAHreIkV0K73b4cLB
 9hMEh18EZ/Ac1DjyIPeq2YRoFjEgH6GN5DFaSlPvmPzNnAJtXLN2AZdHbguAKc81gzfv
 Gz8Ut8QvnrRAj5Lmc4h5D5X4Cq2XxtBq86U10LfJrq9n//z9MScpAxY6payT+7lp+g8g
 J4lLLfbAmNsnPot5qDMBlRb1BtA7uvllLxTRG2qju/oLfgDzfLEyF4LwDUncHolHWcSg
 8cRUslWr3XYgCbBYy+hq8oO4XKc+iWFlttCuSG3CTc7wBhAE6Q6U5R/lvwpT73kpn1Mo
 S20g==
X-Gm-Message-State: AOJu0Yx0TBVt42TCfwsA30xGFkJoMfXuJBmPM4ABNBTwFM1RjnLuJHgI
 magdisKGiJeKrfWmvlSZrVNTMQ==
X-Google-Smtp-Source: AGHT+IHet9zWJGbdLFUDq6yPUhJaLRI/zeOA232YpusGxz/l/LctPZMHSk/CYYu8jlAj30h/NWDDqw==
X-Received: by 2002:a05:600c:1f96:b0:40a:57b3:d006 with SMTP id
 je22-20020a05600c1f9600b0040a57b3d006mr7962535wmb.22.1700568901498; 
 Tue, 21 Nov 2023 04:15:01 -0800 (PST)
Received: from meli.delivery (adsl-75.109.242.226.tellas.gr. [109.242.226.75])
 by smtp.gmail.com with ESMTPSA id
 21-20020a05600c229500b004090798d29csm16525550wmf.15.2023.11.21.04.15.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 04:15:01 -0800 (PST)
Date: Tue, 21 Nov 2023 14:13:33 +0200
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
Subject: Re: [PATCH-for-9.0 05/25] memory: Simplify
 memory_region_init_ram_from_fd() calls
User-Agent: meli 0.8.2
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-6-philmd@linaro.org>
In-Reply-To: <20231120213301.24349-6-philmd@linaro.org>
Message-ID: <4h3cz.uqlmydms81xu@linaro.org>
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
>Mechanical change using the following coccinelle script:
>
>@@
>expression mr, owner, arg3, arg4, arg5, arg6, arg7, errp;
>@@
>-   memory_region_init_ram_from_fd(mr, owner, arg3, arg4, arg5, arg6, arg7, &errp);
>    if (
>-       errp
>+       !memory_region_init_ram_from_fd(mr, owner, arg3, arg4, arg5, arg6, arg7, &errp)
>    ) {
>        ...
>        return;
>    }
>
>and removing the local Error variable.
>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>---
> system/memory.c | 5 +----
> 1 file changed, 1 insertion(+), 4 deletions(-)
>
>diff --git a/system/memory.c b/system/memory.c
>index 2fe4c3861b..ca05c4defa 100644
>--- a/system/memory.c
>+++ b/system/memory.c
>@@ -3604,11 +3604,8 @@ void memory_region_init_ram(MemoryRegion *mr,
>                             Error **errp)
> {
>     DeviceState *owner_dev;
>-    Error *err = NULL;
> 
>-    memory_region_init_ram_nomigrate(mr, owner, name, size, &err);
>-    if (err) {
>-        error_propagate(errp, err);
>+    if (!memory_region_init_ram_nomigrate(mr, owner, name, size, errp)) {
>         return;
>     }
>     /* This will assert if owner is neither NULL nor a DeviceState.
>-- 
>2.41.0
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>




