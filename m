Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4ABD96DCAD
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Sep 2024 16:55:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smDsv-0000hI-OE; Thu, 05 Sep 2024 10:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=ehJl=QD=zx2c4.com=Jason@kernel.org>)
 id 1smDst-0000Yv-5A
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 10:54:55 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=ehJl=QD=zx2c4.com=Jason@kernel.org>)
 id 1smDsr-0007FA-LB
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 10:54:54 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A6F755C5CC9;
 Thu,  5 Sep 2024 14:54:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD056C4CEC3;
 Thu,  5 Sep 2024 14:54:44 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
 dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com
 header.b="iOJ3Bxe5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105; 
 t=1725548083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UbUvqUbTxXvSxmvdmKVvl8aODTaMQ8d9lp3BwWcHvCM=;
 b=iOJ3Bxe5eqok/NAXaNksuFqJ2cDdyc2uK/NuptUzWov9mi2BA9FYwvQzQJgm2IRE8TJ3X/
 Bz5gEZVAOBA5Uft4TNmMNWxipkGl8HexQCCZPIH1cGH/kmlQFGP37IG8Pq8zpYBEZKXRc2
 XuvF8wzz/IkMBIshSsXD//YubK4R9oU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 61832bb4
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 5 Sep 2024 14:54:43 +0000 (UTC)
Date: Thu, 5 Sep 2024 16:54:41 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: maobibo <maobibo@loongson.cn>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 loongarch@lists.linux.dev, qemu-devel@nongnu.org, xry111@xry111.site
Subject: Re: qemu direct kernel boot on LoongArch
Message-ID: <ZtnGMdFRpTAVPnym@zx2c4.com>
References: <1738d60a-df3a-4102-b1da-d16a29b6e06a@t-8ch.de>
 <49432aed-3ed7-2f07-7f65-311faef96197@loongson.cn>
 <ZtkhtxcJUK-JediY@zx2c4.com>
 <f50c4868-7c2e-1ede-ab19-c67ea0acaab3@loongson.cn>
 <CAHmME9rRJjJ5tHf_xtprkHtWz-ButOOZXVo=E9y8qSyQ-qu6ew@mail.gmail.com>
 <ccc7db47-d065-4e78-bf67-c4e8855c9be4@t-8ch.de>
 <95da2e9e-0905-ad61-6bf9-c2636f2cc5f1@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95da2e9e-0905-ad61-6bf9-c2636f2cc5f1@loongson.cn>
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=SRS0=ehJl=QD=zx2c4.com=Jason@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -67
X-Spam_score: -6.8
X-Spam_bar: ------
X-Spam_report: (-6.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Sep 05, 2024 at 02:11:32PM +0800, maobibo wrote:
> 
> 
> On 2024/9/5 下午1:25, Thomas Weißschuh wrote:
> > On 2024-09-05 06:04:12+0000, Jason A. Donenfeld wrote:
> >> On Thu, Sep 5, 2024 at 5:45 AM maobibo <maobibo@loongson.cn> wrote:
> >>>
> >>> Jason,
> >>>
> >>> With the latest qemu 9.1 version, elf format booting is supported.
> >>
> >> Thanks, I just figured this out too, about 4 minutes ago. Excellent.
> >> And the 1G minimum ram limit is gone too.
> >>
> >> Now working on how to trigger resets.
> > 
> > With "reset" do you mean normal (non-panic) system shutdown/poweroff?
> > Since QEMU 9.1 and a recent kernel you can use the pvpanic device for
> > that in a cross-architecture way.
> LoongArch uses acpi GED device to reboot machine. Now there is no FDT 
> table description and FDT driver for acpi GED device :(

So you mean that QEMU exposes it via ACPI, but not via FDT, and the
kernel doesn't know how to recognize it, even with ACPI?

