Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACDC71F71B
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 02:25:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4saH-0000Jl-Fd; Thu, 01 Jun 2023 20:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3mjZ5ZAYKChcF1xA6z3BB381.zB9D19H-01I18ABA3AH.BE3@flex--seanjc.bounces.google.com>)
 id 1q4saF-0000JD-15
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 20:23:59 -0400
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3mjZ5ZAYKChcF1xA6z3BB381.zB9D19H-01I18ABA3AH.BE3@flex--seanjc.bounces.google.com>)
 id 1q4saD-0007UJ-Bi
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 20:23:58 -0400
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-53f6f7d1881so1344188a12.3
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 17:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1685665435; x=1688257435;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=kfVTz/MFdf1BdTl2DJtaA5MVU5d+x7qUPBQRynuzbEs=;
 b=lsng6iSxrqz9R88Q59ewsOGcDaYkTH4vRqDXC5iFszzkH/L48SReX+ccLn2qqVohKu
 SqRTT3wIMGLiTNYWwIKvQpUQy1rlArmCydKGFHXCUSm4HDybF/yCCEi4ngNdiHPHHIAO
 IvE9MObzfShr0WlQx7CjRaOodhTuihevv7Kvb25V0NnX+aCj6e89Z3iKFeAL+lLhSweK
 djWxmTAZR53Gd6ZwAEJJraDzBmWjEDJjAVLEUoTCsaFeXmgf0aQGIJKaiMkaQzmwqMTm
 MDcuVqxl1ntCRLEQ+YYvdB2O6IC0xaDBz4EXjfHWwXcBoneakB4xjWXpWdEkTnS2DRwX
 Al0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685665435; x=1688257435;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=kfVTz/MFdf1BdTl2DJtaA5MVU5d+x7qUPBQRynuzbEs=;
 b=I6WUETBogZ7lc4EqBfaAfh5ncE/UMIsfzvTHcFuUiyIqgXZyRvlw2sFeCxtRazO+RV
 3Rw5SEwBRPCmU4oTbj1mwjHh+57NR7baLtJT7d/wLLxFI74UbPgoc/N9pLVP5c1/occd
 8lc9whr5wVsMaENiDt1JQqguD2nI3QM6YQQNICiCUGA3S+gkjiwgPzNknR5jMVT5MfJd
 5qkNbkKOmvh2Bpg7vTiPCooXO4NwgvL5xiVnHqYNS4blkd4pFqnILirgY3u4XyiARgIr
 eZaTtD6viHnU7ygqH6VpNdGxgv45Dh2Dzvc5sVu0KmYoXcjPDSU4ZrBw/a8CtnIsSTRE
 CLkg==
X-Gm-Message-State: AC+VfDwNSGzcWnbvd6HX3k4P4r+huNDtqTSQ+JoRiSQzDPwOf9U/pEkt
 LXC6rNbsYQZKR3H15ieKro0ivW3mzuk=
X-Google-Smtp-Source: ACHHUZ4sKaezOgXXrB+dL2dh8BcQkqJaicrwtBGNqgWl2x1iGIzS7OMmnpETOlVJ/dFfp6qtQmgVV4r4kJ8=
X-Received: from zagreus.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:fd47:0:b0:53f:5067:64ec with SMTP id
 m7-20020a63fd47000000b0053f506764ecmr2104111pgj.0.1685665434956; Thu, 01 Jun
 2023 17:23:54 -0700 (PDT)
Date: Thu, 1 Jun 2023 17:23:53 -0700
In-Reply-To: <9a4edc66-a0a3-73e4-09c5-db68d4cfbb68@digikod.net>
Mime-Version: 1.0
References: <2f19f26e-20e5-8198-294e-27ea665b706f@redhat.com>
 <4142c8dc-5385-fb1d-4f8b-2a98bb3f99af@digikod.net>
 <9a4edc66-a0a3-73e4-09c5-db68d4cfbb68@digikod.net>
Message-ID: <ZHk2mVcBycjKCfGw@google.com>
Subject: Re: [ANNOUNCE] KVM Microconference at LPC 2023
From: Sean Christopherson <seanjc@google.com>
To: "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 James Morris <jamorris@linux.microsoft.com>, 
 Marc Zyngier <maz@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, 
 "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 Kees Cook <keescook@chromium.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
 Wanpeng Li <wanpengli@tencent.com>, Alexander Graf <graf@amazon.com>, 
 Forrest Yuan Yu <yuanyu@google.com>, John Andersen <john.s.andersen@intel.com>,
 Liran Alon <liran.alon@oracle.com>, 
 "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
 Marian Rotariu <marian.c.rotariu@gmail.com>, 
 "Mihai =?utf-8?B?RG9uyJt1?=" <mdontu@bitdefender.com>, 
 "=?utf-8?B?TmljdciZb3IgQ8OuyJt1?=" <nicu.citu@icloud.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Thara Gopinath <tgopinath@microsoft.com>, Will Deacon <will@kernel.org>, 
 Zahra Tarkhani <ztarkhani@microsoft.com>, 
 "=?utf-8?Q?=C8=98tefan_=C8=98icleru?=" <ssicleru@bitdefender.com>,
 dev@lists.cloudhypervisor.org, 
 kvm@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, qemu-devel@nongnu.org, 
 virtualization@lists.linux-foundation.org, x86@kernel.org, 
 xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::549;
 envelope-from=3mjZ5ZAYKChcF1xA6z3BB381.zB9D19H-01I18ABA3AH.BE3@flex--seanjc.bounces.google.com;
 helo=mail-pg1-x549.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

On Thu, Jun 01, 2023, Micka=EF=BF=BDl Sala=EF=BF=BDn wrote:
> Hi,
>=20
> What is the status of this microconference proposal? We'd be happy to tal=
k
> about Heki [1] and potentially other hypervisor supports.

Proposal submitted (deadline is/was today), now we wait :-)  IIUC, we shoul=
d find
out rather quickly whether or not the KVM MC is a go.

