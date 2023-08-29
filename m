Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9DB78C66F
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 15:48:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaz53-0000Zb-1f; Tue, 29 Aug 2023 09:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qaz50-0000ZT-IS
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:48:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qaz4y-0005zw-2l
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693316902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QjqVRv85N2u92+rxAbkAXV+/faW79IfWOiZEzq0r4yg=;
 b=TC9FIDZLKKAFA2TnI4d0TMwwAvxCxBh4CkOCuHbMgBU0xU0Sa0m2RsOGR26LY1yn9J2t2S
 2+RStqY8hWLiHS4KD0BfTzaR56awx+3/ihOgeMlwwwpjgKfpeN9zqN4HnbBbXTN0u17A36
 wxWgyEM5vS2JiGqUSURHuWV+azcOkK8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-7pMhxMhjNFu0l8jzrhxbqQ-1; Tue, 29 Aug 2023 09:48:21 -0400
X-MC-Unique: 7pMhxMhjNFu0l8jzrhxbqQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-94a35b0d4ceso335524466b.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 06:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693316900; x=1693921700;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QjqVRv85N2u92+rxAbkAXV+/faW79IfWOiZEzq0r4yg=;
 b=LERABf2pZwVGmMB//RQGhBNJsBjjvDmavKb6SZWOVF7q6NM+NC4bMVjX0IC5axS7CP
 LkPmyzUr46J+f3Fau75YXBdM5s4i+kSApDUzvAUvT5beqv+/SH0uDiYwyGN10VzUPC+w
 +apX78nzljMHZWUFSq851jSOh11X8G3xYJeRoLXX9kvQx4dlnYvwaTxtZYuW4X+HRhtU
 LQ/UozpjiKdj95ynjMJZv1w0Q1cgIUFfEJFtq2I/NICI90H2WeM8j9h3CnBLO9o0031P
 JpCB0HMZ2jxCuC3IAboQN1zOGpygK+PBQ4h7yJV8LW4Pf0DytvxzCcv+WQx61WS8ZJN4
 Mgdg==
X-Gm-Message-State: AOJu0YyFwu0/NxvR4B85sR3dQMtc9rh4p2WRTu4Vs9278MOBgDWGTePG
 kETBrEHJG/WSlhZzo/MpMj5G3YH9q9gJ32dXnMBQNVx2HkmL66FCZYIpDoQe3eO160o69OmEdZi
 AENu5Pbm/DlcHeRo=
X-Received: by 2002:a17:906:3145:b0:9a1:e58d:73b8 with SMTP id
 e5-20020a170906314500b009a1e58d73b8mr12838567eje.72.1693316900246; 
 Tue, 29 Aug 2023 06:48:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfFMit0HP5ltGBB+Xyb8l2N2UL1RzWbcdiVZUSwwuqewYtsUkEBwSElPEYpllJli51iBqzpA==
X-Received: by 2002:a17:906:3145:b0:9a1:e58d:73b8 with SMTP id
 e5-20020a170906314500b009a1e58d73b8mr12838551eje.72.1693316899866; 
 Tue, 29 Aug 2023 06:48:19 -0700 (PDT)
Received: from redhat.com ([2.55.167.22]) by smtp.gmail.com with ESMTPSA id
 bj13-20020a170906b04d00b0099cf9bf4c98sm5972374ejb.8.2023.08.29.06.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 06:48:19 -0700 (PDT)
Date: Tue, 29 Aug 2023 09:48:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 qemu-devel@nongnu.org, Gowtham Siddarth <gowtham.siddarth@arm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: PCIe: SLT attribute mismatch: 0xFF020100 instead of 0x20100
Message-ID: <20230829093909-mutt-send-email-mst@kernel.org>
References: <56aa4acb-d54c-a457-5a32-9258cec1ac96@linaro.org>
 <CAFEAcA81xq_yEXYdtAXtkqcdR=MHagSNf5rXOtt+AwohMY_=BQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA81xq_yEXYdtAXtkqcdR=MHagSNf5rXOtt+AwohMY_=BQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 29, 2023 at 02:14:51PM +0100, Peter Maydell wrote:
> On Tue, 29 Aug 2023 at 12:40, Marcin Juszkiewicz
> <marcin.juszkiewicz@linaro.org> wrote:
> >
> > I am working on aarch64/sbsa-ref machine so people can have virtual
> > machine to test their OS against something reminding standards compliant
> > system.
> >
> > One of tools I use is BSA ACS (Base System Architecture - Architecture
> > Compliance Suite) [1] written by Arm. It runs set of tests to check does
> > system conforms to BSA specification.
> >
> > 1. https://github.com/ARM-software/bsa-acs
> >
> >
> > SBSA-ref goes better and better, yet still we have some issues. One of
> > them is test 822 ("Check Type 1 config header rules") which fails on
> > each PCIe root port device:
> >
> > BDF 0x400 : SLT attribute mismatch: 0xFF020100 instead of 0x20100
> > BDF 0x500 : SLT attribute mismatch: 0xFF030300 instead of 0x30300
> > BDF 0x600 : SLT attribute mismatch: 0xFF040400 instead of 0x40400
> >
> > I reported it as an issue [2] and got response that it may be QEMU
> > fault. My pcie knowledge is not good enough to know where the problem is.
> >
> > 2. https://github.com/ARM-software/bsa-acs/issues/193
> >
> >
> > In the comment Gowtham Siddarth wrote:
> >
> > > Regarding the SLT (Secondary Latency Timer) register, the expected
> > > values align with the ACS specifications, registering as 0. However,
> > > a discrepancy arises in the register's attribute, intended to be set
> > > as Read-Only. Contrary to this intent, the bit field seems to
> > > function as> Read-Write. Ordinarily, when attempting to write to the
> > > register by configuring all bits to 1, the anticipated behaviour
> > > should involve rejecting the write operation, maintaining the value
> > > at 0 to uphold the register's designated Read-Only nature. However,
> > > in this scenario, the write action takes effect, leading to a
> > > transformation of the register's value to FFs. This anomaly could
> > > potentially stem from an issue within the emulator.
> >
> > Does someone know where the problem may be? And how to fix it?
> 
> I don't know enough about PCI to be sure here, but it sounds like
> what you're saying is happening is that the test case writes all-1s
> to some PCI register for the root port device, and expects that where
> some bits in it are defined in the spec as read-only they don't get set?
> 
> Which registers exactly is the test case trying to write in this way ?
> 
> I've cc'd the QEMU PCI maintainers.
> 
> thanks
> -- PMM


yes, this is a bug.


static void pci_init_mask_bridge(PCIDevice *d)
{
    /* PCI_PRIMARY_BUS, PCI_SECONDARY_BUS, PCI_SUBORDINATE_BUS and
       PCI_SEC_LETENCY_TIMER */
    memset(d->wmask + PCI_PRIMARY_BUS, 0xff, 4);


note there's a typo: PCI_SEC_LETENCY_TIMER should be
PCI_SEC_LATENCY_TIMER.

But the express spec says:
	This register does not apply to PCI Express. It must be read-only and hardwired to 00h. For PCI Express to PCI/PCI-X
	Bridges, refer to the [PCIe-to-PCI-PCI-X-Bridge] for requirements for this register.


So, only for the pci express to pci express bridges, and only for new
machine types, we need to override the mask to 0:

	d->wmask[PCI_SEC_LATENCY_TIMER] = 0;


-- 
MST


