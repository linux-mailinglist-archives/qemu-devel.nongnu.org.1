Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA36D81FF9B
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 14:11:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJCd1-0004S3-Lp; Fri, 29 Dec 2023 08:10:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rJCcy-0004Rv-2n
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 08:10:16 -0500
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rJCcw-0007DK-Bs
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 08:10:15 -0500
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2041ed74956so3085294fac.0
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 05:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703855413; x=1704460213; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Uqt2E7T5C2pgGRECODT/Y7ZwwJRZOXmLON/DGuKLzyc=;
 b=CFOt+B6RhimgPXhBNoBlaqdqAiEkcSTQFm8hfFkbIYx5yTx5WpQgBtPVjiywUXKC8D
 bGJWhnuyZqi0xfMsl2UMirVMk9uKwEoijIMYeulLfdjec0V5jOe6JWj1W73xIdNDdK1e
 t1bP2R2CiroHW/3jXyTUlUsrzPxE8Q2YtATdB4MGilQjWU1g3hWnqacHagOdCfajPDD4
 SBhYTcvBKiiEGHWIttVXI38emtqvpEbHSW/GvdkQ4gZ/v8stWeMasqwN6DMParbY0Yjz
 9KsRONE0kW26J9FgPJdtv/cbAlwblv8TMn9POGr9kJxiD448eVtZcPoKUKOtJ06EGOHc
 KHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703855413; x=1704460213;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uqt2E7T5C2pgGRECODT/Y7ZwwJRZOXmLON/DGuKLzyc=;
 b=TONjRms6jNmHGwGvXxhnUhq4PEFu7Q9nGdiLuHzegWcf7s0iArOKn8Ot/lyz8ai1L5
 eO52YQM+MenQI6z4u/1j3eFsC5X0s4dNwvfj//l4UQQbanslE1ftupKBb1Mms00uclub
 KmcHhypDziFJgw3lj2ZEt3zPjtWfMXfk5mCIBbj0wPrsOxAXai5RK+coI+vRekbl+gNA
 V1fc8fLqMZMORemY2jTN1jLhDCehEtWdkQfccXHfMSsGUIgIKzqGU1QPonkSVmCgESrD
 BdmNzrJ2Lkzo0KLvHDf7NNaY1uEMxdwgvPE6IrLQGJMelnND8yyHokcwnQfmKG5iO1Sp
 g1oA==
X-Gm-Message-State: AOJu0YxqhRHzroMioZyb7J9jTm9t8dVOqVY0f5QFCINhMOP/0Zg9hs6c
 +Xrml841ztoiIIr4uwTTgj9F3jxZ1w6RfIOxYKo=
X-Google-Smtp-Source: AGHT+IHGWnebndbIDNRFpJrU4ITdEiGwc5CTu2SEHCMemM3Kbw4ACdV2LfZkkE2N3JHtlAQ1Sf5WzXiUZa1nDCyEYNw=
X-Received: by 2002:a05:6870:e8c5:b0:204:4136:1e21 with SMTP id
 r5-20020a056870e8c500b0020441361e21mr4691424oan.27.1703855412753; Fri, 29 Dec
 2023 05:10:12 -0800 (PST)
MIME-Version: 1.0
References: <8cceee40e32dab3e1913e50c221475ea@trimaso.com.mx>
In-Reply-To: <8cceee40e32dab3e1913e50c221475ea@trimaso.com.mx>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 29 Dec 2023 08:10:00 -0500
Message-ID: <CAJSP0QX-5ZxxiNejwEUoPE6Gnn=2=tfOb4MpAJNz5j6FYoNGzQ@mail.gmail.com>
Subject: Re: Qemu setting "-cpu host" seems broken with Windows vms
To: xtec@trimaso.com.mx
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x33.google.com
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

On Thu, 28 Dec 2023 at 17:21, <xtec@trimaso.com.mx> wrote:

CCing Paolo, the general x86 maintainer.

Stefan

> I noticed something weird when using "-cpu host" with Windows vms.
> First, I always use it along with ",hv_passthrough" as well.
>
> First, performance: since some years ago, since prior to qemu 6.2 until
> latest 8.2, win10 and win11 vms always worked slower than expected. This
> could be noticed by comparing booting/starting times between vm and a
> bare metal installation, but I particularly measured it when installing
> windows cumulative updates through windows update. On vm, from
> downloading to finishing rebooting it always took 1.5 circa 1.5 hours,
> while just 40 minutes on bare metal.
>
> Second, and more recently, newer windows 11 23h2 seems to have big
> problem with "-cpu host".
> When trying to update from 22h2 to 23h2 I got either black screen or
> bsod after trying to reboot.
> Also, same result when trying to install 23h2 from scratch.
> This on qemu 7.1 and 8.2.
> Did a long search, and finally found the cause which also solved the
> problem for me:
> https://forum.proxmox.com/threads/new-windows-11-vm-fails-boot-after-update.137543/
> I found similar problems and similar solution in other forums as well.
>
> So in my case, physical host cpu is intel core 11th gen; tried using
> libvirt's "virsh capabilities" to see which qemu cpu model better
> matched, and for some reason it gave Broadwell instead of newer
> Skylake...
> Anyway, tried with "-cpu <Broadwell_model>,hv_passthrough", and this
> solved *both* problems: performance finally matched bare metal in all
> aspects, and the windows 23h2 problem was finally gone.
>
> On IRC, it was suggested to try "-cpu host" and "disabling CPU bits" one
> by one until finding the culprit. But I don't know how to do this...
>
> Could someone look into this?
> Thanks.
>

