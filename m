Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAD87BCFCB
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 21:20:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpZJE-000897-2F; Sun, 08 Oct 2023 15:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roman@roolebo.dev>) id 1qpZJC-00088z-Gg
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 15:19:22 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roman@roolebo.dev>) id 1qpZJ5-00065p-Ru
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 15:19:22 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-50306b2920dso4715738e87.0
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 12:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=roolebo.dev; s=mail; t=1696792753; x=1697397553; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8pOLGQT4Z0mvOS0rSb3KL1hv+Q8Wh1Tuq5iQMlGtCnY=;
 b=PXzkZG3zkElciMPmJn8QREmDurJpO+a4/JhMvBDWkvdakWq+MrV9M3RagVv3El/p20
 vvnMsyWyTIXC5sUUMDgMv56/5zsLP3OP5JkA0st/x7C19pa5g7fBinC5hNaNvwZZXMcq
 Wyvz0wMQdWcH62+0mYXp55+ylYgxs9+0kdyhz6GdJ9brD4QKiYwBJOy6pE8epyYdPfiE
 WNz6UefFejh9RPQcuBIiLCkj1j0X0mrfSVdXDc05A9oQP/BUBruZOa9JFXlaT8EfjL/T
 7+Td0iRJXpsL6ptrpHC4E3gzz/bzs3aK5jyhr8mIIIbeOT5RkqpvOz1STqX0ypBOANOx
 eRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696792753; x=1697397553;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8pOLGQT4Z0mvOS0rSb3KL1hv+Q8Wh1Tuq5iQMlGtCnY=;
 b=QqkIxa4GUUx0kVdHV1HMB95EkfPDDDfGDDmCKcACPC+lu/x+gwpOZOCYqN6ihZ5SyR
 STEDOc9zCCbOpVEuOlFe6jmxDOkKA0DyOkEwzH57MFH9gHpRcfqWgSNRoftCDqbXLvFO
 dXrHIdzCwthvbewg9xVWjZKj6Fwjy0HpxdCPv2LF+aGTfUJjvdigwAx7e7Hz5XJkum48
 z8zUN8QdsMuUPjGqDD5CRjAbLwtt7LhDJ5kMolOfKUkbCm1kNE76kuNb7JYY/6+Y3cT+
 v6xUSa3BurwSn/C7kMn61x9dtEaoVzBFWSPaMO9WXF1zAjJUWpDyfWhmQDp0zQAG6qOH
 9LWQ==
X-Gm-Message-State: AOJu0Yzg4FSxoTRRkvT2/MfZnH4SAhUBnMwkLSyKAKnrbYnyoUsQ3DqJ
 x+kF4Jj5/+AUEg1Q+Ts065omiw==
X-Google-Smtp-Source: AGHT+IGyaP2SnYDEfCqNrALV9tn0dVGFqdO2VunxayUJ+hLUV2dHPRPBrlcHjLjqC9U4AhY2j8chsA==
X-Received: by 2002:ac2:4f0f:0:b0:4fe:3724:fdb6 with SMTP id
 k15-20020ac24f0f000000b004fe3724fdb6mr10816213lfr.30.1696792752982; 
 Sun, 08 Oct 2023 12:19:12 -0700 (PDT)
Received: from localhost (95-25-89-116.broadband.corbina.ru. [95.25.89.116])
 by smtp.gmail.com with ESMTPSA id
 v17-20020a197411000000b005047baf3388sm1162412lfe.295.2023.10.08.12.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 12:19:12 -0700 (PDT)
Date: Sun, 8 Oct 2023 22:19:11 +0300
From: Roman Bolshakov <roman@roolebo.dev>
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, dirty@apple.com, rbolshakov@ddn.com,
 lists@philjordan.eu
Subject: Re: [PATCH 2/3] i386: hvf: In kick_vcpu use hv_vcpu_interrupt to
 force exit
Message-ID: <ZSMAr3hhxJryGpya@roolebo.dev>
References: <20230922140914.13906-1-phil@philjordan.eu>
 <20230922140914.13906-3-phil@philjordan.eu>
 <ZSLzq33DgMNYBsQT@roolebo.dev>
 <CAAibmn35JypPWfUophMgONTkgbYFvaaRhuD9+1kif9EOFx9HxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAibmn35JypPWfUophMgONTkgbYFvaaRhuD9+1kif9EOFx9HxQ@mail.gmail.com>
Received-SPF: none client-ip=2a00:1450:4864:20::12a;
 envelope-from=roman@roolebo.dev; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Sun, Oct 08, 2023 at 08:39:08PM +0200, Phil Dennis-Jordan wrote:
> On Sun, 8 Oct 2023 at 20:23, Roman Bolshakov <roman@roolebo.dev> wrote:
> 
> > On Fri, Sep 22, 2023 at 04:09:13PM +0200, Phil Dennis-Jordan wrote:
> > > When interrupting a vCPU thread, this patch actually tells the
> > hypervisor to
> > > stop running guest code on that vCPU.
> > >
> > > Calling hv_vcpu_interrupt actually forces a vCPU exit, analogously to
> > > hv_vcpus_exit on aarch64.
> > >
> > > Previously, hvf_kick_vcpu_thread relied upon hv_vcpu_run returning very
> > > frequently, including many spurious exits, which made it less of a
> > problem that
> > > nothing was actively done to stop the vCPU thread running guest code.
> > > The newer, more efficient hv_vcpu_run_until exits much more rarely, so a
> > true
> > > "kick" is needed.
> > >
> >
> 
> Hi Roman,
> 
> Thanks for the review and test of this patch and the preceding one!
> 

My pleasure. Thanks for submitting the patch and confirming the need of
the feature on x86 HVF.

> > I see severe performance regression with the patch on a Windows XP
> > guest. The display is not refreshed properly like a broken LVDS panel,
> > only some horizontal lines appear on it.
> 
> 
> I assume that's with patch 3/3 applied as well? The fact you've
> repro'd it with just these patch would explain why I've not been able
> to fix it on the APIC side…
> 

Yes, I applied with patch 3/3 and then retested only with the first two
patches.

> > FWIW. I recall a few years ago I submitted a similar patch that does
> > something similar but addresses a few more issues:
> >
> > https://patchwork.kernel.org/project/qemu-devel/patch/20200729124832.79375-1-r.bolshakov@yadro.com/
> >
> > I don't remember why it never got merged.
> >
> 
> Looks like the VM kick might be a more complex undertaking than I was
> anticipating. I'll try to repro the problem you ran into, and then look
> over your original patch and make sense of it. Hopefully an updated version
> of your 'kick' implementation will work well in combination with the
> newer hv_vcpu_run_until() API from patch 3/3. I'll keep you posted.
> 

Apparently I left a note that some interrupts weren't delivered even
with my patch and I was not able figure out the reason back then. I had
another attempt to debug this two weeks later after I submitted v4 and I
can find a WIP branch on github where I added a Debug Registers support
patch and some tracepoints:

https://github.com/qemu/qemu/compare/master...roolebo:qemu:hvf-debug-kick

Perhaps that's where we should start from besides the obvious need of
rebase.

With regards to hv_vcpu_run_until() I can find the following thread:
https://lists.nongnu.org/archive/html/qemu-devel/2020-06/msg09468.html

> hv_vcpu_run_until() was also evaluated on macOS 10.15.5 but it degrades
> VM performance significantly compared to explicit setting of
> VMX-preepmtion timer value and hv_vcpu_run(). The performance issue was
> observed on Broadwell-based MacBook Air and Ivy Bridge-based MacBook
> Pro.
> 
> macOS 11.0 Beta deprecated hv_vcpu_run() and introduced a special
> declaration for hv_vcpu_run_until(), that's not available 10.15 -
> HV_DEADLINE_FOREVER (UINT64_MAX, which is bigger than maximum value of
> VMX-preeemption counter). Perhaps the performance issue is addressed
> there.

All discussion with Paolo might be helpful, particurlarly:
https://lists.nongnu.org/archive/html/qemu-devel/2020-06/msg09893.html

> So, I've tried Big Sur Beta and it has exactly the same performance
> issue with hv_vcpu_run_until() while hv_vcpu_run() works as good as it
> worked on 10.15.5. I've submitted FB7827341 to Apple wrt the issue.

In November 2020, Apple responded to FB7827341 that there's an issue on
QEMU side.

Regards,
Roman

