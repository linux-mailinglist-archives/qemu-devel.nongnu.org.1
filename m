Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBBD7F3F41
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 08:52:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5i25-0003j5-OX; Wed, 22 Nov 2023 02:52:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r5i1x-0003i9-DZ
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 02:52:20 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r5i1s-0005Ve-P7
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 02:52:15 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3316bd84749so3264537f8f.2
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 23:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700639530; x=1701244330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=fAUTxtWFf3B4YwcwwB50ijwvVY8c/JE3rBaEGwFmi5s=;
 b=Xnb8YE86RkpsW3L4evyZJ0315pr160+in0ktKpTOdIqUk/MYPIlAKbpZ63U23pwtSj
 5Z481FAJ93Ih9aLxgcDg6agB6ZOZEIf1JJzeF9aWlAravw386YXihEtHkqAicNacF7Jg
 cQprXgbkn6JPtMggnOascJxqiVMGwR7EIa85DkkApOSA1DNFzGhZVwmuZCSuIJxiNPYn
 BHqfEZ5rhsy3l8AhD+UpYzLrQhL6EiKVwyyRwq8PPFG6XcfNhPKr8IGYsAcY38VpgxNI
 uraOg4TfJnElalYKtFsE20GbcOTj5z6tD0uBrZyBKUtKpQpmuQZhsXZnWtlRACvgXyWc
 gNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700639530; x=1701244330;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fAUTxtWFf3B4YwcwwB50ijwvVY8c/JE3rBaEGwFmi5s=;
 b=YCYReXYYvkWNUtIEM/D1qUF+bZxaqRolHlTmhFTvIBQuSGnI6WWU9A2Dr1R4hamYge
 2FKMRVmLMz0+w84G4A4BkW2DQwwqYHna+Af0osT8xCnBK1rzPgpr2kgq8y/B30q0qmo6
 JynFsd+wITBYOB3N6s9RApHSJnxSMFuwdta1MIHsEIV2cW6JFCuMltNWZ7b/mnTR77op
 83w1iHBnw6WZ2ZH09BYWDF7K15z+15yQh+iZ7uc1fxzqr1Mb5v3AWcwHWE4GLRCTlMTI
 oDB3YFrk1dHmUT+7LzjTkZt4Z416D1+9iX8ps3UdrjpoZSWJvpAkxa6K2SPwkISqHcfP
 N0Ug==
X-Gm-Message-State: AOJu0Yxa3qxb4a1l/fU1MXLRCj2aQj6Un0RtwpDvTF5khuWG/h3kjHpT
 yo9lWXghJW0wHkOapM+DV+1QBg==
X-Google-Smtp-Source: AGHT+IGVyKBluBQ0h+68tCHOoVOdn7J9CmIaUTGOG+iol3gmVQL0l4NQjYrTujcD/BjI0r7LjD08Yg==
X-Received: by 2002:a5d:444f:0:b0:331:6dfc:939c with SMTP id
 x15-20020a5d444f000000b003316dfc939cmr889004wrr.29.1700639530019; 
 Tue, 21 Nov 2023 23:52:10 -0800 (PST)
Received: from meli.delivery (adsl-195.37.6.2.tellas.gr. [37.6.2.195])
 by smtp.gmail.com with ESMTPSA id
 o5-20020a5d4745000000b0031ad5fb5a0fsm16439368wrs.58.2023.11.21.23.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 23:52:09 -0800 (PST)
Date: Wed, 22 Nov 2023 09:46:28 +0200
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
 Peter Xu <peterx@redhat.com>,
 Herv=?UTF-8?B?w6kg?=Poussineau <hpoussin@reactos.org>
Subject: Re: [PATCH-for-9.0 25/25] hw/pci-host/raven: Propagate error in
 raven_realize()
User-Agent: meli 0.8.2
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-26-philmd@linaro.org>
In-Reply-To: <20231120213301.24349-26-philmd@linaro.org>
Message-ID: <4iluv.uh21dliq5uv@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42f.google.com
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
>When an Error** reference is available, it is better to
>propagate local errors, rather then using generic ones,
>which might terminate the whole QEMU process.
>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>---
> hw/pci-host/raven.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
>diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
>index 86c3a49087..e34ce47874 100644
>--- a/hw/pci-host/raven.c
>+++ b/hw/pci-host/raven.c
>@@ -345,8 +345,10 @@ static void raven_realize(PCIDevice *d, Error **errp)
>     d->config[PCI_LATENCY_TIMER] = 0x10;
>     d->config[PCI_CAPABILITY_LIST] = 0x00;
> 
>-    memory_region_init_rom_nomigrate(&s->bios, OBJECT(s), "bios", BIOS_SIZE,
>-                                     &error_fatal);
>+    if (!memory_region_init_rom_nomigrate(&s->bios, OBJECT(s), "bios",
>+                                          BIOS_SIZE, errp)) {
>+        return;
>+    }
>     memory_region_add_subregion(get_system_memory(), (uint32_t)(-BIOS_SIZE),
>                                 &s->bios);
>     if (s->bios_name) {
>-- 
>2.41.0

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>



