Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE627E9CE4
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 14:16:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2WnL-0007Em-53; Mon, 13 Nov 2023 08:16:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r2WnJ-0007Dc-EO; Mon, 13 Nov 2023 08:16:01 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r2WnH-00017M-J5; Mon, 13 Nov 2023 08:16:01 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5bdfbd69bd5so3164817a12.1; 
 Mon, 13 Nov 2023 05:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699881357; x=1700486157; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kpueWlW5n9vLLdLrCbXytmXpg7CDwSs6EwHN7O4V9eo=;
 b=EIJlHg/YMlhWLO9WdPQcPBD43kFyBJCNR+r2Doq0QvymHxn17FJrvMiCUI6ZgGh6iz
 wcfbc/QHENr3Md+Rm2/0/NuQ+G9OAGK+sRaH46GlpR8o/KYDEWG2sx5ExIs/MMBBrN1L
 SUrAaNdB9yIAztS/0xo+DWw8iXmyMwsSRHo16lJsUPphrAHvtQ6ywh6xXM4I5r7MSFy5
 gt5z3MMnZfTBF7bFfKZd+G6w5AlrGeDpMEczTb9HmkugnUsHe/t17KkTTyLPuFS1deq6
 v+fSMa1n9HPPgHvh9hfQuEgRl7W1wMp1TxVprPMDbqFFaOrK4hEkGXpUpuU8nKrc53vq
 A8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699881357; x=1700486157;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kpueWlW5n9vLLdLrCbXytmXpg7CDwSs6EwHN7O4V9eo=;
 b=QuOuBlqfFcScilBXCm8FB84N162dqX/z0ogRkygtj9yYhGmXH2eHO6Ycmu+k6SS4W/
 kf7ZXVPcVuRcefFZHQzrsiOSHYsJVJXAsJ3PolACj5GTjc8Gb0Vy4rEvNbXQI1gs7K8C
 xftw2tBYpLLy1H3PLK72s5qq0ZYxMNwl+2a8A4dIcYCBWLmnSwu9wE3ywhAGvaHqeKZr
 z6os2A3wFAOSm4t1D4XkBm8yX/q3WEZaEX/1RFrTeNMEwEvDLoqebm+bS5YZ0adMX4HJ
 YYjtQ/d8SzQkKXw0z+A0X+D4rE9+RB8epgaokkXbOXdq9IAP/WfO5O/p3sbEmIOeHudb
 vbTw==
X-Gm-Message-State: AOJu0YyHQNBULuboU64II1qZX1Lw3+xjFgC+HFu3dQbfJiLY0M4d8FVo
 geS/FewlMYnVF8U2JRUrGU5uO4x0HsQ=
X-Google-Smtp-Source: AGHT+IEpAYzTm3j/ig4omE+pHCGzml4TAIF4qb3sATS1RUiD4nxhZAmS3bAyTXus2PYLaWn/K8WIQg==
X-Received: by 2002:a17:90b:1d82:b0:280:963d:9c5 with SMTP id
 pf2-20020a17090b1d8200b00280963d09c5mr9842572pjb.21.1699881357065; 
 Mon, 13 Nov 2023 05:15:57 -0800 (PST)
Received: from localhost (121-44-82-40.tpgi.com.au. [121.44.82.40])
 by smtp.gmail.com with ESMTPSA id
 p12-20020a17090ad30c00b002790ded9c6dsm3682389pju.31.2023.11.13.05.15.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 05:15:56 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Nov 2023 23:15:50 +1000
Message-Id: <CWXPNBOJTWCV.24ODSFNXQ0WEX@wheely>
Cc: <clegoate@redhat.com>, <qemu-devel@nongnu.org>, <mikey@neuling.org>,
 <vaibhav@linux.ibm.com>, <jniethe5@gmail.com>, <sbhat@linux.ibm.com>,
 <kconsul@linux.vnet.ibm.com>, <danielhb413@gmail.com>
Subject: Re: [PATCH v2 00/14] Nested PAPR API (KVM on PowerVM)
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20231012104951.194876-1-harshpb@linux.ibm.com>
In-Reply-To: <20231012104951.194876-1-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x536.google.com
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

This will have to wait until the next release. There should not be
big changes to rebase on. I'll take a better look before then.

Linux now has this merged upstream so it will be much easier to test.

I posted some RFCs for new avocado tests including a KVM guest boot
(https://lists.gnu.org/archive/html/qemu-ppc/2023-10/msg00260.html).
Byt I guess it won't be too easy to adapt that to test the new API
until there is a usable distro image with support. We should open an
issue for that.

Thanks,
Nick

On Thu Oct 12, 2023 at 8:49 PM AEST, Harsh Prateek Bora wrote:
> There is an existing Nested-HV API to enable nested guests on powernv
> machines. However, that is not supported on pseries/PowerVM LPARs.
> This patch series implements required hcall interfaces to enable nested
> guests with KVM on PowerVM.
> Unlike Nested-HV, with this API, entire L2 state is retained by L0
> during guest entry/exit and uses pre-defined Guest State Buffer (GSB)
> format to communicate guest state between L1 and L2 via L0.
>
> L0 here refers to the phyp/PowerVM, or launching a Qemu TCG L0 with the
> newly introduced option cap-nested-papr=3Dtrue.
> L1 refers to the LPAR host on PowerVM or Linux booted on Qemu TCG with
> above mentioned option cap-nested-papr=3Dtrue.
> L2 refers to nested guest running on top of L1 using KVM.
> No SW changes needed for Qemu running in L1 Linux as well as L2 Kernel.
>
> There is a Linux Kernel side patch series to enable support for Nested
> PAPR in L1 and same can be found at below url:
>
> Linux Kernel patch series:
> - https://lore.kernel.org/linuxppc-dev/20230914030600.16993-1-jniethe5@gm=
ail.com/
>
> For more details, documentation can be referred in either of patch
> series.
>
> There are scripts available to assist in setting up an environment for
> testing nested guests at https://github.com/iamjpn/kvm-powervm-test
>
> A tree with this series is available at:
> https://github.com/planetharsh/qemu/tree/upstream-kop-1012
>
> Thanks to Michael Neuling, Shivaprasad Bhat, Kautuk Consul, Vaibhav Jain
> and Jordan Niethe.
>
> Changelog:
>
> v2:
>     - Addressed review comments from Nick on v1 series.
> v1:
>     - https://lore.kernel.org/qemu-devel/20230906043333.448244-1-harshpb@=
linux.ibm.com/
>
> Harsh Prateek Bora (14):
>   spapr: nested:  move nested part of spapr_get_pate into spapr_nested.c
>   spapr: nested: Introduce SpaprMachineStateNested to store related
>     info.
>   spapr: nested: Document Nested PAPR API
>   spapr: nested: Introduce cap-nested-papr for Nested PAPR API
>   spapr: nested: register nested-hv api hcalls only for cap-nested-hv
>   spapr: nested: Introduce H_GUEST_[GET|SET]_CAPABILITIES hcalls.
>   spapr: nested: Introduce H_GUEST_[CREATE|DELETE] hcalls.
>   spapr: nested: Introduce H_GUEST_CREATE_VPCU hcall.
>   spapr: nested: Initialize the GSB elements lookup table.
>   spapr: nested: Introduce H_GUEST_[GET|SET]_STATE hcalls.
>   spapr: nested: Use correct source for parttbl info for nested PAPR
>     API.
>   spapr: nested: rename nested_host_state to nested_hv_host
>   spapr: nested: keep nested-hv exit code restricted to its API.
>   spapr: nested: Introduce H_GUEST_RUN_VCPU hcall.
>
>  docs/devel/nested-papr.txt      |  500 +++++++++++
>  hw/ppc/spapr.c                  |   32 +-
>  hw/ppc/spapr_caps.c             |   63 ++
>  hw/ppc/spapr_hcall.c            |    2 -
>  hw/ppc/spapr_nested.c           | 1439 ++++++++++++++++++++++++++++++-
>  include/hw/ppc/spapr.h          |   21 +-
>  include/hw/ppc/spapr_cpu_core.h |    7 +-
>  include/hw/ppc/spapr_nested.h   |  361 ++++++++
>  target/ppc/cpu.h                |    2 +
>  9 files changed, 2368 insertions(+), 59 deletions(-)
>  create mode 100644 docs/devel/nested-papr.txt


