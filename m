Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C75957E2799
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:49:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00oT-0008Qp-4x; Mon, 06 Nov 2023 09:42:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <udo@hypervisor.org>)
 id 1r00oQ-0008HX-HA; Mon, 06 Nov 2023 09:42:46 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <udo@hypervisor.org>)
 id 1r00oO-0002IM-5f; Mon, 06 Nov 2023 09:42:46 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1699281759; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=g1L3Bl4lLQZEfGAeuEaDQO/krMtwPfMLc8p6f6LI44Ch8c76FgDW2kRYnnhUupzqZF
 ZsRaQcmXVHPHXbpK+WV0QsRjkhbIhrNKTDB7Jm6BLeQ8qYJibKolsJTF7/m4t9QtgWwr
 KSx+SQJNrOjwadep1PxZ4HXWwZvjZkwJSY07XJiTNmVlinE9zDJRSiilE7jJkJU4foR2
 EVbtv0zc9expPyht/gWHod01D9ZdRbWNsEvuqbfnpptFNBSh1TG9w02hsLAoRc/lMZHS
 HsHjq9sIVWGL+eK+Cu5BmAphqp+RNupA928dByPFRCWQdEOXTJsN2nHmuT2GNp9SjVB6
 WoSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1699281759;
 s=strato-dkim-0002; d=strato.com;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=Z7GePp/fEoFjvusoKhVqv424v3QYOiYbnJl+Y94S1Cw=;
 b=FzN2kcKJpqBqwRdV3KsT0Yv93D/8YZCY6CQZupRbJ5Giq1VVYWn3b82/LnxsKmTumO
 sCaiW+SJMztjsTb8lRkbwpuQEzQWzffrQM5bmR9bH44jNbHTKqrs8Z0NrHG7wfYP8euO
 tES1siuNKGMCQLZbyEcFIljsNcSrb9MX92k7bxdkkQAA2TiNmy/8/TUjBH7VnK/fO/jE
 2xsfU1pnV7JnY7VO+AF/DprVGLH2Jr02lGcb/71j9cgqoKXZ1KhdZrUV/tDhNpOdT5iw
 mhsjawnOutP7AH9QKQFLbYXfliWgwNb0SMoI4bY263gLbiGkvpbD2LVqsaJCpaR0Ur7s
 blgQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1699281759;
 s=strato-dkim-0002; d=hypervisor.org;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=Z7GePp/fEoFjvusoKhVqv424v3QYOiYbnJl+Y94S1Cw=;
 b=OC8Vxv59cOGP9KWOC3aZgMYpNUPnR3mFRSlvG8d8K+IxaRPhZJfcRuUl4OA6TNQiJb
 twXNF9nvTRCLc+ZbwbGwByV0/BOj+212yIJACwFnxVAE2idC4hoY3vy1d1GJQzEN3hOK
 iZsNra0jAuZ9QLQofhtwwXFWu5MkrTMLrti1P2VOXkdMEwpdp8SuBkeneQEQNAzcN/2f
 g/8Nn7keokwoSEyQS1+6qxr0q3PD3AQpFnkiEHJfottiXRQbseID43TMBGxNN7cHeS6o
 iLuMeb4HDdE02mrmmP7iMYB9UizPu7VYCXjuef3bc03zKQ8okrhOnhyXbK+T2nwUEu6E
 uB/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1699281759;
 s=strato-dkim-0003; d=hypervisor.org;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=Z7GePp/fEoFjvusoKhVqv424v3QYOiYbnJl+Y94S1Cw=;
 b=pXw0gIvLGtLKRIkQ9QnoXzHwjJ/vLx1fs7Fz4OahSjZ3BLKn2HSPiSdM723PyD4oQj
 QXdNxdFIPYXo6tiBIABQ==
X-RZG-AUTH: ":OWgLVUixa/orYEjgByCmMbha6U0z53RZBchi0p8VsT1fAA5ylDfCvwqw4ZH5IcAfMz63lg=="
Received: from darkstar.fritz.box by smtp.strato.de (RZmta 49.9.1 DYNA|AUTH)
 with ESMTPSA id fcf28ezA6EgdzLL
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Mon, 6 Nov 2023 15:42:39 +0100 (CET)
Date: Mon, 6 Nov 2023 15:42:39 +0100
From: Udo Steinberg <udo@hypervisor.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 2/3] hw/arm/virt: Report correct register sizes in
 ACPI DBG2/SPCR tables.
Message-ID: <20231106154239.26dde0ba@darkstar.fritz.box>
In-Reply-To: <20231106150533.1b166fb5@imammedo.users.ipa.redhat.com>
References: <20231103152120.829962-1-peter.maydell@linaro.org>
 <20231103152120.829962-3-peter.maydell@linaro.org>
 <CAFEAcA-iSvg0r7-pRbv07p80Fy4ZEii0Md2DnuGs_=djdBe-HA@mail.gmail.com>
 <20231106150533.1b166fb5@imammedo.users.ipa.redhat.com>
X-Mailer: X-Mailer 5.0 Gold
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=81.169.146.160; envelope-from=udo@hypervisor.org;
 helo=mo4-p00-ob.smtp.rzone.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 6 Nov 2023 15:05:33 +0100 Igor Mammedov (IM) wrote:

> it might be worth mentioning that QEMU impl. uses 32 bit registers and
> can correctly handle 32 bit access only, while 16 (or any other) bit access
> to 32 bit registers won't actually work.  
> 
> ex:
> pl011_write()
>    ...
>    switch (offset >> 2)
> 
> essentially only 1st byte will be accessed correctly,
> the rest will be misplaced as read/write handlers do not account
> for split access possibility.
> 
> So it's not about what linux or NOVA do, but rather fixing
> ACPI description to match what the device model is capable of.

The latest version of Peter's patch series advertises 32-bit access width,
so that should not derail the current PL011 device model anymore.

Independent of that, the PL011 device model should be fixed to also support
8-bit and 16-bit accesses, because the PL011 data sheet says 16-bit and the
SBSA says 8-, 16- and 32-bit accesses are valid, so if the model cannot
handle 8 and 16, it is incomplete/buggy.

Cheers,
Udo

