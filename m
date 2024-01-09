Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A5A828FF0
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 23:30:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNKbB-0006Ke-4r; Tue, 09 Jan 2024 17:29:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rNKb8-0006KU-Nd
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 17:29:26 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rNKb7-0004qO-4b
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 17:29:26 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40e5521db08so3784295e9.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 14:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704839363; x=1705444163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6eShGOOYzJgkxXcf3BN0KmzlHl9tWf4UCVl9RkW3Vs4=;
 b=Mb8NeV5fp9+oaY07C+fUElSg1IZ1BbhZcOcULQFlwzWBQYGlpbVgWP7XHapsOrbS8I
 yn8m6clJE8+1s6YFfJR4YFW4M71ostvW6zaMcYNrwCNifR3+KQfICkRnsaaNMKSgTXBR
 lN5jPGMSRdxlvbd4J9/OQS8SrKU/2TnCO8EOIyHlFkYx7aDTf6hqKHHFwlLq1T0D0ayr
 XmdkrItO6ZzDW71KtvB8f4dJfxXryAEyIrGIH4Qgol5vck+r9GuJinPFPyqh4Y7Maj3q
 xD1n3d5yJ7LC2DZLoJ6l3vRsYJ1fElLNZh10u/qu+M3sYxmWqEtbONkjKuy2dHvpl4OB
 Ztlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704839363; x=1705444163;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6eShGOOYzJgkxXcf3BN0KmzlHl9tWf4UCVl9RkW3Vs4=;
 b=QJhD6eKBVKtMaj1MaLAd//FzumgaeA0yp/6njJlZpwytck4GOrais3bSqoOSUBomMV
 qjnuZKp+czjwMPPsNo/rTfgxtJyPlKf4TayHoOFZbDuwwan0yBEDsLICK7MTInuvjyuF
 kJgRxEThYSrNY5ii9Ak7CzJwrPG2lYvmvCBfu0qxwqpzhRinMtSlRlVsW3tieg8bxynf
 YCoZ7zGliat8EvYHsCmewRq8zDE3ObNac7GGfnPbyd31oX8oZIvmBznRnlqOvyT1ar7c
 /mJ+XQe8KI7vF/i0puUww9ZU6NNu1Aqs9aFSq0Bfk9jqtFHFkhe9QfZWDZm0nal4EcVe
 W7+g==
X-Gm-Message-State: AOJu0YzZAGSHGr/IzIqd/Z66+cmoxa966EcyXfvGPEFrUQFOe7i8mtm0
 iP7ZRuycpoicUPu8uh9/dJ0=
X-Google-Smtp-Source: AGHT+IGsBx67M/CXG5ZKy9tf7B4FVsHy9jr6Taj33qNRJvhUESGymMQxI/zxyIILVvrQVh9ToM40Dw==
X-Received: by 2002:a05:600c:68d4:b0:40e:48e6:a6e3 with SMTP id
 jd20-20020a05600c68d400b0040e48e6a6e3mr8858wmb.149.1704839362816; 
 Tue, 09 Jan 2024 14:29:22 -0800 (PST)
Received: from [127.0.0.1] (dynamic-077-183-075-077.77.183.pool.telefonica.de.
 [77.183.75.77]) by smtp.gmail.com with ESMTPSA id
 gv2-20020a170906f10200b00a26a80a58fcsm1436941ejb.196.2024.01.09.14.29.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 14:29:22 -0800 (PST)
Date: Tue, 09 Jan 2024 22:29:14 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
CC: Chuck Zmudzinski <brchuckz@aol.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paul Durrant <paul@xen.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anthony PERARD <anthony.perard@citrix.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_hw/i386/pc=5Fpiix=3A_Make_piix=5Fintx=5Fr?=
 =?US-ASCII?Q?outing=5Fnotifier=5Fxen=28=29_more_device_independent?=
In-Reply-To: <7d24b5aa384a492b3bd33f50906e3f000b1ff6a0.camel@infradead.org>
References: <20240107231623.5282-1-shentey@gmail.com>
 <7d24b5aa384a492b3bd33f50906e3f000b1ff6a0.camel@infradead.org>
Message-ID: <9FEEB450-CA3D-4960-8C7D-BC837C93E58D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 9=2E Januar 2024 08:51:37 UTC schrieb David Woodhouse <dwmw2@infradead=
=2Eorg>:
>On Mon, 2024-01-08 at 00:16 +0100, Bernhard Beschow wrote:
>> This is a follow-up on commit 89965db43cce "hw/isa/piix3: Avoid Xen-spe=
cific
>> variant of piix3_write_config()" which introduced
>> piix_intx_routing_notifier_xen()=2E This function is implemented in boa=
rd code but
>> accesses the PCI configuration space of the PIIX ISA function to determ=
ine the
>> PCI interrupt routes=2E Avoid this by reusing pci_device_route_intx_to_=
irq() which
>> makes piix_intx_routing_notifier_xen() more device-agnostic=2E
>>=20
>> One remaining improvement would be making piix_intx_routing_notifier_xe=
n()
>> agnostic towards the number of PCI interrupt routes and move it to xen-=
hvm=2E
>> This might be useful for possible Q35 Xen efforts but remains a future =
exercise
>> for now=2E
>>=20
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>
>I'm still moderately unhappy that all this code is written with the
>apparent assumption that there is only *one* IRQ# which is the target
>for a given INTx, when in fact it gets routed to that pin# on the
>legacy PIC and a potentially *different* pin# on the I/O APIC=2E

Would TYPE_SPLIT_IRQ help in any way?

>
>But you aren't making that worse, so
>
>Reviewed-by: David Woodhouse <dwmw@amazon=2Eco=2Euk>

Thanks!

