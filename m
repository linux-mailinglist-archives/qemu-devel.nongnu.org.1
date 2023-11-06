Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C127E2649
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:07:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00Ek-0002oR-9q; Mon, 06 Nov 2023 09:05:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r00Ec-0002mN-RH
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:05:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r00EY-0001db-W5
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:05:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699279541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pD65NxC9SsOFtcmqkdSzLnveDY+EeTkeb86KlLLSh80=;
 b=AaOPdC9JAGSwVEl8efB6CCcRAP0daWOfx8vpL1F/i+Sx/dVfD6Kv6XG9VIMH1QZx5Hyo2p
 SfyJbat1IWG+yOxYIqwjQTee08O7yDQbf1RJjtaM2YskF/ekeqchtNuiJ9xzbs1ftBjgBU
 VOJqVjhF8qdbk+jP19rhCfX2wtD9vto=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-qzB2yvrjPSOsjRhOCD11cw-1; Mon, 06 Nov 2023 09:05:38 -0500
X-MC-Unique: qzB2yvrjPSOsjRhOCD11cw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-66d0b251a6aso55661786d6.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 06:05:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699279538; x=1699884338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pD65NxC9SsOFtcmqkdSzLnveDY+EeTkeb86KlLLSh80=;
 b=KYiD3+QTHZGAQiaabL05qsjZhxtbsWE0+FbUokfES2LOhuIUpQJ43rvQgqJahON0f0
 xjiBi2t73MstDikEuzFGaHMZCTJxJ3uPYL9L8GtrHaGInSzzt2fdkCcT2g4r0DJ2Llz9
 sbORrvVrRXWHqDso9XNUd//+zSP9MGzfvApF+uzj3Px5uDy5bSkl0muVt/Vswu9+1vBv
 iH6mKIJYE14l1w2aN/xRgLbTRuQEZaLjdZ67SFSr24zs9jwm3z+Fyrp7J/hHTpJeJf3W
 dAvt1gpvWM+Kkm1UG8FhwcGL3Tp453b5KQAV9My4nPbldyZa2gEh0JWbuGIx0u/llauC
 w7GA==
X-Gm-Message-State: AOJu0YxCkD6Wpr+y4aVQyaCq+haSA5mhYR9QiPwlBYVdEkUc1PbcbVVV
 2v+QggtDlPQmOcPGmdzqSz5pxnpIxb++KZ8RvYwvlsNA3bQzIGykwm5mmnE33DdiTPKD4jKSQJG
 lWA2rCNnomy3cNtI=
X-Received: by 2002:a05:6214:1c41:b0:66f:aed2:64de with SMTP id
 if1-20020a0562141c4100b0066faed264demr36629235qvb.5.1699279538076; 
 Mon, 06 Nov 2023 06:05:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLhPwsDyZzEP3A+XQ7uMuXskqrXUXdT2FVQXDpHPKyBFz4nCmnNjmykti7+AWSRjqLHMqozA==
X-Received: by 2002:a05:6214:1c41:b0:66f:aed2:64de with SMTP id
 if1-20020a0562141c4100b0066faed264demr36629198qvb.5.1699279537690; 
 Mon, 06 Nov 2023 06:05:37 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 i17-20020a0cfcd1000000b0065b02eaeee7sm3442569qvq.83.2023.11.06.06.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 06:05:36 -0800 (PST)
Date: Mon, 6 Nov 2023 15:05:33 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Udo Steinberg
 <udo@hypervisor.org>
Subject: Re: [PATCH v3 2/3] hw/arm/virt: Report correct register sizes in
 ACPI DBG2/SPCR tables.
Message-ID: <20231106150533.1b166fb5@imammedo.users.ipa.redhat.com>
In-Reply-To: <CAFEAcA-iSvg0r7-pRbv07p80Fy4ZEii0Md2DnuGs_=djdBe-HA@mail.gmail.com>
References: <20231103152120.829962-1-peter.maydell@linaro.org>
 <20231103152120.829962-3-peter.maydell@linaro.org>
 <CAFEAcA-iSvg0r7-pRbv07p80Fy4ZEii0Md2DnuGs_=djdBe-HA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, 3 Nov 2023 15:26:22 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Fri, 3 Nov 2023 at 15:21, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > From: Udo Steinberg <udo@hypervisor.org>
> >
> > Documentation for using the GAS in ACPI tables to report debug UART addresses at
> > https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/acpi-debug-port-table
> > states the following:
> >
> > - The Register Bit Width field contains the register stride and must be a
> >   power of 2 that is at least as large as the access size.  On 32-bit
> >   platforms this value cannot exceed 32.  On 64-bit platforms this value
> >   cannot exceed 64.
> > - The Access Size field is used to determine whether byte, WORD, DWORD, or
> >   QWORD accesses are to be used.  QWORD accesses are only valid on 64-bit
> >   architectures.
> >
> > Documentation for the ARM PL011 at
> > https://developer.arm.com/documentation/ddi0183/latest/
> > states that the registers are:
> >
> > - spaced 4 bytes apart (see Table 3-2), so register stride must be 32.
> > - 16 bits in size in some cases (see individual registers), so access
> >   size must be at least 2.

it might be worth mentioning that QEMU impl. uses 32 bit registers and
can correctly handle 32 bit access only, while 16 (or any other) bit access
to 32 bit registers won't actually work.  

ex:
pl011_write()
   ...
   switch (offset >> 2)

essentially only 1st byte will be accessed correctly,
the rest will be misplaced as read/write handlers do not account
for split access possibility.

So it's not about what linux or NOVA do, but rather fixing
ACPI description to match what the device model is capable of.

> >
> > Linux doesn't seem to care about this error in the table, but it does
> > affect at least the NOVA microhypervisor.
> >
> > In theory we therefore have a choice between reporting the access
> > size as 2 (16 bit accesses) or 3 (32-bit accesses).  In practice,
> > Linux does not correctly handle the case where the table reports the
> > access size as 2: as of kernel commit 750b95887e5678, the code in
> > acpi_parse_spcr() tries to tell the serial driver to use 16 bit
> > accesses by passing "mmio16" in the option string, but the PL011
> > driver code in pl011_console_match() only recognizes "mmio" or
> > "mmio32". The result is that unless the user has enabled 'earlycon'
> >  
> Oops, a line seems to have got deleted here -- should continue
> 
> "there is no console output from the guest kernel."
> 
> > We therefore choose to report the access size as 32 bits; this works
> > for NOVA and also for Linux.  It is also what the UEFI firmware on a
> > Raspberry Pi 4 reports, so we're in line with existing real-world
> > practice.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1938
> > Signed-off-by: Udo Steinberg <udo@hypervisor.org>
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> > [PMM: minor commit message tweaks; use 32 bit accesses]
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > --  
> 
> thanks
> -- PMM
> 


