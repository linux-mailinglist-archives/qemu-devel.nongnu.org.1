Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6439BD93F
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Nov 2024 23:59:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SWJ-0002qz-RW; Tue, 05 Nov 2024 17:59:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1t8SWH-0002qm-Up; Tue, 05 Nov 2024 17:59:29 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1t8SWF-0006ld-B6; Tue, 05 Nov 2024 17:59:29 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4314f38d274so70917435e9.1; 
 Tue, 05 Nov 2024 14:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730847566; x=1731452366; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MFZyr2VRlQ1VNjSzl69Okeyb/RsPEOM4GrEdhgZ2hEQ=;
 b=eZB/lVLMdW1ZUhPGafe1jUowzfMH2c/CDVZ4muRwA9MueOWb7bzHKkB3td1YsR1/oS
 wDkC1gAewL8GxRUyU1FIXYEb/K28bf+udKPaAPSs/Xc+hs70nhqD9pVywLxAHUQfPdaj
 TZujof0S55onIC7d4EU6xQo+76vIHngcLxROzmFn2G/UQnzhxU8OzhiaTfSoIjtrf+0w
 06+8LWil9bdPCccx6292oslHvePEOP3p7oXHpi3TdpYPDRICZ5PAXeW4aa5oqzdvi/B1
 m9JpW9uQZsWO3xh1mNYpUTuvVqVgjVXqKv+2d8/d5i1rJAvDTTZzQwMNYx/z/u/29VC6
 FPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730847566; x=1731452366;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MFZyr2VRlQ1VNjSzl69Okeyb/RsPEOM4GrEdhgZ2hEQ=;
 b=D6AO7s4y+ToQR5VCw+9OPwbYhtsmrog1+Arrt1xT68ztfS9ZDWm5NAbbqER93R8lQG
 W4VNcyWo1ufDi8RInUHBBGHinWr7GJzK61gYBEZbf/2d7cUEAAeogWv9ymHMLvzw5GCQ
 lOTjVxDtwniNb8hOfHhh52NabWhOnjsfcCQWrt+rTZINhQrVzg5XvHB3H8sCEbCv9wkR
 /xsau5g5FJfW9GVzBZQEOaC0t7LYwRMnBvy8JLXP0PLECkEDY6noVcJ7frCJZY6CvAS6
 QBbhoAkK74mQZ6Y65jUkQG8BQiaAYJ8l+vFj4WrwVV6t61tc23pawuf3cm2R3iD5DUCj
 Fsng==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3RtCwIskMKeQArwjK2M09TW4dMDYd0crwA0Z6so4JSH5Z4vrA74zZ6yZJCuX7sl9sutthDloRhQ==@nongnu.org
X-Gm-Message-State: AOJu0Yz6RtNdEEHAZGObSRKAJGQDCKyb9ncllhdQeH7BaQlgo5icfSQ8
 R6pEj1nEX8wljiaTMVNcW4WhlX9bZSvomtcajY0JuAav0jmVBZEf
X-Google-Smtp-Source: AGHT+IH6AGqfu0xPZ0QMCm99pQ4kbrQxcFKA44c/HfiL7dRNBrRFAfzeobSuSvDJByCXFzIClUsoFg==
X-Received: by 2002:a05:600c:4455:b0:42c:b508:750e with SMTP id
 5b1f17b1804b1-4328324ae6cmr184100085e9.11.1730847565553; 
 Tue, 05 Nov 2024 14:59:25 -0800 (PST)
Received: from gmail.com ([89.101.60.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6b35c0sm1314005e9.16.2024.11.05.14.59.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 14:59:24 -0800 (PST)
Date: Tue, 5 Nov 2024 23:59:24 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 devel@lists.libvirt.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 04/19] hw/microblaze/s3adsp1800: Rename unimplemented
 MMIO region as xps_gpio
Message-ID: <ZyqjTDvocg7fHdLb@zapote>
References: <20241105130431.22564-1-philmd@linaro.org>
 <20241105130431.22564-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241105130431.22564-5-philmd@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, Nov 05, 2024 at 02:04:16PM +0100, Philippe Mathieu-Daud� wrote:
> The machine datasheet mentions the GPIO device as 'xps_gpio'.
> Rename it accordingly to easily find its documentation.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


> 
> Signed-off-by: Philippe Mathieu-Daud� <philmd@linaro.org>
> ---
>  hw/microblaze/petalogix_s3adsp1800_mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
> index 37e9a05a62a..581b0411e29 100644
> --- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
> +++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
> @@ -124,7 +124,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
>      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, ETHLITE_BASEADDR);
>      sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[ETHLITE_IRQ]);
>  
> -    create_unimplemented_device("gpio", GPIO_BASEADDR, 0x10000);
> +    create_unimplemented_device("xps_gpio", GPIO_BASEADDR, 0x10000);
>  
>      microblaze_load_kernel(cpu, ddr_base, ram_size,
>                             machine->initrd_filename,
> -- 
> 2.45.2
> 

