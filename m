Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D770835DEF
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 10:18:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRqPy-0001gd-Nf; Mon, 22 Jan 2024 04:16:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rRqPr-0001cU-TW
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 04:16:29 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rRqPo-0004Tg-8A
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 04:16:27 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40eac352733so9438545e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 01:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705914981; x=1706519781; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NVdJ1l5G9jn1rBjjw7NYRRFNZNCaYHvpzj4eNS9ml7s=;
 b=gVSyuGc2m+BrMa3DExhr/fVklINccvsnE1ml8ozIyzT9Ux4GZqt1QAvXNYWrYaZLye
 7i1DzqSjKppimUF1qQgCS+5CD4gMTCOKjF5OPNvPT8W3OpTa9+S07LvmfwOjkyQK+OFo
 /PetwfvUd1ETjWK8PbXLi4r2TPe+IYxH7tYqDQJS5/5ldSP8cbvugLmhZhENRgUi+iMx
 GAaMAA5GHd1ISXy/GKQh/dCbteIXQIjKdRM8MP9/jsO+LGkO5qzdMatqmpmfeIqxUErv
 m/Lm/k/uaF0Qr+xIJw+MjdQK54dwQeyhSrNW7wApHr10cu1CB6Fwd0N3q21GDfu/lKjd
 rp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705914981; x=1706519781;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NVdJ1l5G9jn1rBjjw7NYRRFNZNCaYHvpzj4eNS9ml7s=;
 b=rSIiUwlp53bPi1skjWFuFvXHqa4l1dPXOxGEM931Bb1+jFoo+l1ZznXz/OLL0ro29s
 WN4vNThXPIfpVStpkE3BoWqUwOAa4jPjYAC38bKdGVGhJOhrVft/oyWC6BibmbipTqf5
 RQQaIjdJhe+kldrX9eXEv4HyKh5ZLRwf4EX6bDvkXbyjpA58amWO1QoTdTTz1QSbrk7F
 DU2qnS0Zjexuif4IE3KM1pTjyZYALouuLr/zbxNhZRqTIuxB4X9ZpuDao2wsLv1btj6V
 sbau0sdGN/c8Xa9MW3KN7PTaknZYltSG0doYUI0VxidnIA0nQWthf+0SOyscyz/8IEaX
 mkIg==
X-Gm-Message-State: AOJu0YzzDwmUpDfqV/YHN7HOV8M6xrolZeGabmTsYsO6uQZTegebP23F
 WAPD0/hsKDir2rdE+tPYXNn73+bikeupDU197RyvVCybLpZUpZkxKX8gjquuarw=
X-Google-Smtp-Source: AGHT+IGgk+B2VCwTumI0YB42RyFQU/5YceTcdY8zRx+G8ETrrJ0jZp17+9IZGnOmGsYtiFDNDdcpOw==
X-Received: by 2002:a05:600c:444b:b0:40e:b21a:7ab4 with SMTP id
 v11-20020a05600c444b00b0040eb21a7ab4mr37022wmn.180.1705914981497; 
 Mon, 22 Jan 2024 01:16:21 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 w14-20020a5d404e000000b00337d9a717bcsm8858354wrp.52.2024.01.22.01.16.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 01:16:20 -0800 (PST)
Date: Mon, 22 Jan 2024 10:16:19 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: Rob Bradford <rbradford@rivosinc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Himanshu Chauhan <hchauhan@ventanamicro.com>, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Alvin Chang <alvinga@andestech.com>, 
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: Re: [PATCH 0/2] Export debug triggers as an extension
Message-ID: <20240122-29d7d206e9ea3ecd46fad930@orel>
References: <20240110040203.1920924-1-hchauhan@ventanamicro.com>
 <e2763db2-fade-482d-b433-1bfce6acf7d3@ventanamicro.com>
 <CAKmqyKOA6OtixYoMJ_qtXj_u0t6rMdHawg0VEvq3-=mK4q6_XQ@mail.gmail.com>
 <3c091744cd4bafeb7c1d177455fa9789822e7209.camel@rivosinc.com>
 <CAKmqyKPkjBBo-2EAL25-3qACSv4c4naGT8V-F5e5as4D=WVa9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKmqyKPkjBBo-2EAL25-3qACSv4c4naGT8V-F5e5as4D=WVa9g@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x330.google.com
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

On Mon, Jan 22, 2024 at 03:42:10PM +1000, Alistair Francis wrote:
> > > From memory the "debug" property is for the original debug spec:
> > > https://github.com/riscv/riscv-debug-spec/releases/tag/task_group_vote
> > >
> > > That was ratified and is an official extension. AFAIK this is what is
> > > in physical hardware as well.
> > >
> > > The actual PDF says draft though, I'm not sure what's going on there.
> > >
> > > The debug spec doesn't have a Z* name, so it's just "debug", at least
> > > AFAIK.
> > >
> > > "sdtrig" seems to be a new backwards-incompatible extension doing
> > > basically the same thing. What a mess
...
> >
> > I've done a bit of digging and I agree things are quite messy. Here are
> > my discoveries:
> >
> > The debug option and the code for triggers was added in these commits:
> >
> > c9711bd778 target/riscv: cpu: Enable native debug feature
> > 38b4e781a4 target/riscv: machine: Add debug state description
> > b6092544fc target/riscv: csr: Hook debug CSR read/write
> > 1acdb3b013 target/riscv: cpu: Add a config option for native debug
> > 95799e36c1 target/riscv: Add initial support for the Sdtrig extension
> >
> > In March 2022 - since the commit refers to the Sdtrig extension name
> > and from the date this was an implementation not of the ratified 0.13
> > debug spec (which did not have Sdtrig as a separate extension) but
> > rather a version of the in development 1.0 debug spec.
> 
> Yeah... We used the "stable" from master. That is our mistake there.
> 
> I'm pretty sure we targeted the 0.13. The "Sdtrig" was only added in
> the v4 as the changelog says: "mention Sdtrig extension in the commit"
> 
> >
> > It's not trivial to tell if it's closer to the ratified 0.13 version or
> > the (hopefully soon to be frozen) 1.0 version.
> >
> > As the only part of the debug specification to be implemented is the
> > triggers then effectively the debug option is x-sdtrig.
> >
> > I don't think there is any way for code running on the machine to
> > identify what version of the debug is implemented - the appropriate
> > register is only available for external debug. Once 1.0 is frozen then
> > the presence of Sdtrig isa string would indicate 1.0 trigger support is
> > available.
> >
> > According to JIRA - https://jira.riscv.org/browse/RVS-981 the debug
> > specification should freeze this month.
> >
> > How about considering this as a solution:
> >
> > - Add a new x-sdtrig option that defaults to false
> > - Deprecate debug option - but retain it with default on
> 
> We can't deprecate a ratified spec. The 0.13 just seems to call it
> "debug" so that's what we are stuck with
> 
> > - Add warning if triggers are used and x-sdtrig is not enabled
> > - Update the trigger implementation to match frozen spec
> 
> We will need to support two versions, as there are two ratified specs.
>

We'll likely want to be allowed to deprecate ratified extensions as riscv
evolves. Despite best intentions, extensions may be designed and ratified
which ultimately fail to be of much utility, and new extensions will
supersede old extensions. If QEMU keeps every extension it adds, then
we'll slow progress on new extensions by maintaining old extension code.
The old extensions will also bitrot or waste CI resources getting tested
for no reason.

I don't know the history of 'debug' and 'sdtrig', other than what I've
read above, but, to me, it looks like 'debug' might be one of the first
extensions which should be deprecated. Assuming we have a long enough
deprecation period, then I think it's always safe to attempt a
deprecation. If somebody shouts, then it can always be taken back off the
chopping block.

Thanks,
drew


