Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9979C80F1C4
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:03:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5DO-000146-6g; Tue, 12 Dec 2023 11:02:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rD5DM-00013q-0E
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:02:32 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rD5DJ-00027g-E8
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:02:31 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40c25973988so60977985e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702396948; x=1703001748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AhVnGCK45xBhXjKQjzeUrEBYyzIXyX39Thxixr9iuWQ=;
 b=zgilpVURxe+koFQ2OT05ZQMpHprVB4A5jA4cjvJdxWuWWFClqj703d/sdvjaBpmUMs
 1ONN1Lh4vUArFGqeio8GFZzvs7/tdSRVNH0F2CvTINm78+Eet3YsGZuTKzbV/jOhc/IR
 gSK7d9DAZgUjuM2LpkTN+fQ8m77062jFGGD1osL6S4sQrA1cPW8O3RQd5mfbXGtkJlkl
 K5YLEi0+sZCcg7gSY59mAPjz9xgLOtzL5vlmjj1xN0cSRJ6W4GpmKnLvwkOo1w15XjhY
 S6HGmfZ8Q2cnMVLiU3RxRiVs0tfcnPbp37AjvHXwegOBjoFh1Urmg5Zx6sC/LWjDFWuQ
 ZKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702396948; x=1703001748;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AhVnGCK45xBhXjKQjzeUrEBYyzIXyX39Thxixr9iuWQ=;
 b=sYMli72XaF9/O1VWBEUus4f+acnLvXhDlXkSO7b/6EfgxHLpvVJSNzVkmaWkHqXBYG
 kXsAJamUZWITY4LT5xYGgqr7U9ROs8+f33s3zyIyoULq+kLJSXNFWu+a3bRuO3uXx55A
 YVmE9rapYZCMWjcSPIRN4RGcMQ2Ce97BXy52M27QKrH9wp8Kg08ae8WgxXjTtlaOEQ5Z
 VGy3y8eB3YR/UoTLnKmMbmoRq6jsjj0rja8bJclPLvE27mSYTtlPU3f36OjzyaIZwDg+
 RvhGwu5m19E9Pvi1vHJyTRoGVtUAjhhokvOs0ZVbnq9ziho8ro6kvRUpiqAROAI0BKSE
 GU2w==
X-Gm-Message-State: AOJu0YyDGUH87fMidwGdarJqOIZxPPxeXZQWx3jzKPoTGestsTJiCHiF
 8Q3hVv5jzOsiHYrHF7DILc8SBw==
X-Google-Smtp-Source: AGHT+IEvL5rP0CFCQuL3bg8awKx85yIGG94DtKaPDO094KuG0JQvZPwHnzoFdcp4qzZ7pF74W2BJ4Q==
X-Received: by 2002:a05:600c:4897:b0:40c:a9d:fa1d with SMTP id
 j23-20020a05600c489700b0040c0a9dfa1dmr3366466wmp.142.1702396947793; 
 Tue, 12 Dec 2023 08:02:27 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 w18-20020a5d5452000000b00336367631efsm276868wrv.65.2023.12.12.08.02.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 08:02:27 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 01BFD5F7D4;
 Tue, 12 Dec 2023 16:02:27 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Mykyta Poturai <Mykyta_Poturai@epam.com>,  "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>,  David Woodhouse <dwmw@amazon.co.uk>,  Julien
 Grall <julien@xen.org>,  Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Vikram Garhwal <vikram.garhwal@amd.com>,  Oleksandr Tyshchenko
 <Oleksandr_Tyshchenko@epam.com>,  stewart.hildebrand@amd.com
Subject: Re: Adding MSI support for virtio-pci to QEMU as Xen backend on ARM
In-Reply-To: <alpine.DEB.2.22.394.2312081407250.1703076@ubuntu-linux-20-04-desktop>
 (Stefano Stabellini's message of "Fri, 8 Dec 2023 14:15:16 -0800
 (PST)")
References: <PAVPR03MB10102178A70BF72984FFAF8CD848AA@PAVPR03MB10102.eurprd03.prod.outlook.com>
 <alpine.DEB.2.22.394.2312081407250.1703076@ubuntu-linux-20-04-desktop>
User-Agent: mu4e 1.11.26; emacs 29.1
Date: Tue, 12 Dec 2023 16:02:26 +0000
Message-ID: <87wmtjbe99.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

Stefano Stabellini <sstabellini@kernel.org> writes:

> +Stewart
>
> On Fri, 8 Dec 2023, Mykyta Poturai wrote:
>> Hello everyone,
>>=20
>> I am currently working on adding MSI support to virtio-pci on ARM with X=
en.
>
> Excellent!
>
>
>> As far as I understand QEMU Xen ARM machine that is used for
>> virtio-pci device emulation does not initialize any interrupt
>> controllers. And that makes it somewhat unclear what is the best
>> approach to adding the MSI support. So, I would appreciate some
>> thoughts on this.
>> To trigger the MSI interrupt in Xen guests we basically need to call a s=
ingle DMOP, which I am also implementing.
>
> You should be able to call xen_inject_msi
>
>
>> So far, I have come up with 3 possible approaches:
>> 1. Hooking up the existing GIC code to the Xen Arm machine and extending=
 it with the DMOP call.
>
> No, I would rather avoid this for a couple of reasons. In reality, the
> GIC is emulated by Xen, not QEMU. So letting QEMU think that QEMU is
> emulating a GIC is more error prone than the alternatives and also it
> would allocate resources needlessly.
>
>
>> 2. Writing some new barebones GIC implementation with only the required =
methods (something similar to xen_apic.c).
>> 3. Just hooking up the DMOP call to the existing PCI code based on xen_e=
nabled() check.
>
> I would rather not introduce any more if (xen_enabled()) checks beyond
> the ones we already have unless it is the only option. So I would go
> with option 2). Even better if we could reuse xen_apic.c. xen_apic.c is
> just a stub, which is basically the same thing that we need here.

I guess the APIC part of the name is part of the historical baggage of
x86 - really it's just a xenpv-irq controller?

Anyway yeah I think just move it from hw/i386/xen to hw/xen and maybe
give it a new name with an alias to the old one we can deprecate over
time?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

