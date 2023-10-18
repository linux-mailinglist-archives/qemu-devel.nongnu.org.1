Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 202727CE0C3
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 17:08:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt88d-0003Fc-3x; Wed, 18 Oct 2023 11:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qt88a-0003Ek-VZ; Wed, 18 Oct 2023 11:07:09 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qt88Z-0006Tv-5A; Wed, 18 Oct 2023 11:07:08 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-692d2e8c003so6149922b3a.1; 
 Wed, 18 Oct 2023 08:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697641625; x=1698246425; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=odmBRIF7WCqjkV0ef5UtbyFIFTaw871JJ/DWQKCAe8g=;
 b=AvYtXMKOrPQLW2pz5G9HtNyfuN5W9fOpuq92V5cwIkgmMxNRX8dmfKEqGrxBXRTXN+
 uuI5jUBYLlXYOcxqWEPD17LecV3Q0zeo8onEAES9lkD7lynLMdaY2ZYv9T1XvWofzTM6
 xRSYFWvcDD6wF10O51fEl7lUUF7MsvNC2FAx5GTckcuRrPi+bWK5mM++70KVt2UhV9yd
 542jJtjJ4yBk45vFHSdtPcZKyD8CqtQxKl1pteNXFx0UySo746X6O76uxbflOmt+gpBJ
 AZ5nK046nU2lJmyeajfp7FNomq6MVRxqVSLxoWQbZDchT40sxzOY2AdH4QSlkvWIPkyB
 7bUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697641625; x=1698246425;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=odmBRIF7WCqjkV0ef5UtbyFIFTaw871JJ/DWQKCAe8g=;
 b=OVPnrcy2U4CB0EJpjkhQjiFNBuUaYc73Wo74pvd38zlZbUlVaoMxGTiRjeEdaOwbyw
 z2+d7HlmC+20w3i7ZPpndxWyz5CMiM1rKqOvpRxvm9NSqAcjlJCjCFIH9KHdjpAQykFN
 8SZCQyvw7G4bPP3GSQMmmHh/oQGK5Kh5wFLEpPVUv8nSZSANJRdkaczQRWntaF4BKkZV
 V/yZet2vYGF54JEWhmSlb0bQAAtR/iQzcbiDF2TIwt7jMFjkSctmvahkEGGCgeAcAYb8
 n0uEtE6QX0JtuQ7qAzBOMkQ+QpO/6FFMKNI94JBN/00TMEUHC8hjw/7lzOkGV/luvq1w
 vbLw==
X-Gm-Message-State: AOJu0YxRrQOLNvzWRgJANQFxsenIwZYPlw/ZS+B8qN7DG7/eOIHkw2bi
 loETlmztlrhEIRFkFwhLLAY=
X-Google-Smtp-Source: AGHT+IGf0b0TiqdLOubn/YE30kMNoERPH8AwBaNknp4R7sa1iVOyC5xnR/oksWpWXIGL15OLcF8N2A==
X-Received: by 2002:a05:6a20:3d14:b0:15e:9923:3e35 with SMTP id
 y20-20020a056a203d1400b0015e99233e35mr7107453pzi.19.1697641624750; 
 Wed, 18 Oct 2023 08:07:04 -0700 (PDT)
Received: from localhost (61-68-209-245.tpgi.com.au. [61.68.209.245])
 by smtp.gmail.com with ESMTPSA id
 x1-20020a654141000000b00565dd935938sm1619192pgp.85.2023.10.18.08.07.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 08:07:04 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Oct 2023 01:06:59 +1000
Message-Id: <CWBNQ9QDEYH8.3QL9E2V4ZF26G@wheely>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "David Gibson" <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3 0/4] Add BHRB Facility Support
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Glenn Miles" <milesg@linux.vnet.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230925174351.617891-1-milesg@linux.vnet.ibm.com>
In-Reply-To: <20230925174351.617891-1-milesg@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
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

On Tue Sep 26, 2023 at 3:43 AM AEST, Glenn Miles wrote:
> This is a series of patches for adding support for the Branch History
> Rolling Buffer (BHRB) facility.  This was added to the Power ISA
> starting with version 2.07.  Changes were subsequently made in version
> 3.1 to limit BHRB recording to instructions run in problem state only
> and to add a control bit to disable recording (MMCRA[BHRBRD]).
>
> Version 3 of this series disables branch recording on P8 and P9 due
> to a drop in performance caused by recording branches outside of
> problem state.

Thanks for these, they all look good to me.

With P10 CPU, Linux perf branch recording appears to work with this
series, and I confirmed that Linux does disable BHRB in MMCRA at
boot, so it should not take the performance hit.

It had a couple of compile bugs, no matter I fixed them, but I often
trip overppc32 and user-mode when working on TCG too, so building
with --target-list including ppc64-softmmu,ppc-softmmu,
ppc64-linux-user,ppc64le-linux-user,ppc-linux-user is good to catch
those.

Thanks,
Nick

>
> Glenn Miles (4):
>   target/ppc: Add new hflags to support BHRB
>   target/ppc: Add recording of taken branches to BHRB
>   target/ppc: Add clrbhrb and mfbhrbe instructions
>   target/ppc: Add migration support for BHRB
>
>  target/ppc/cpu.h                       |  24 ++++++
>  target/ppc/cpu_init.c                  |  39 +++++++++-
>  target/ppc/helper.h                    |   5 ++
>  target/ppc/helper_regs.c               |  35 +++++++++
>  target/ppc/insn32.decode               |   8 ++
>  target/ppc/machine.c                   |  23 +++++-
>  target/ppc/misc_helper.c               |  46 +++++++++++
>  target/ppc/power8-pmu-regs.c.inc       |   5 ++
>  target/ppc/power8-pmu.c                |  48 +++++++++++-
>  target/ppc/power8-pmu.h                |  11 ++-
>  target/ppc/spr_common.h                |   1 +
>  target/ppc/translate.c                 | 101 +++++++++++++++++++++++--
>  target/ppc/translate/bhrb-impl.c.inc   |  43 +++++++++++
>  target/ppc/translate/branch-impl.c.inc |   2 +-
>  14 files changed, 374 insertions(+), 17 deletions(-)
>  create mode 100644 target/ppc/translate/bhrb-impl.c.inc


