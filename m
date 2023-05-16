Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A3D7043E3
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 05:15:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyl8U-00060X-Lq; Mon, 15 May 2023 23:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1pyl8S-000600-Tf; Mon, 15 May 2023 23:14:00 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1pyl8R-0000ne-5l; Mon, 15 May 2023 23:14:00 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5208be24dcbso9780189a12.1; 
 Mon, 15 May 2023 20:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684206837; x=1686798837;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zVRs6Yz5C7b+Tev1IWL1NxgBHEhLiEnUN1g2dRPAJow=;
 b=e/xcs2T6mOYXyu2dazmqEPJHVo/llmJlbYo5o5aelv7/l1zlvnicGuYHL1D6jMLO2A
 wVT1uPAPlc82pOau9HXUQNAVAj2l169mh1oHEHPl8pTmc+YA2/rQTYFLp9WhPxqDEs3s
 9hMhEyDAuyr9NgKZMKEZhT/qWQXCFYrWcMGfNRQHpMSMbXdWEwVafwIqTxCvfkWhQzmx
 K67lEFPOTASd+1EA/R06hAckrI1aHau7N/ZDjiBNOTEfdgwumcqCRxxWej615vckLKWg
 jXwGlTn2HKHXbuQVKsWb1L0kqRCPRclur2EC26y6DxEbAT+Jo3OzzxNuZSUGOFWciEuJ
 PsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684206837; x=1686798837;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zVRs6Yz5C7b+Tev1IWL1NxgBHEhLiEnUN1g2dRPAJow=;
 b=jhjF0L3EXzoU5rH80XZvTnUh83cOmKGJhELqYxT2kXR8IwsGc6TTxVII6ae1MnTRPA
 hz641qvbBcsptdhxSugfQLRolqrbodMjUdPVo/DCBPpq8l+wQdpCBgCw2fzwa/bR1wVI
 mBwb99DrmUFlPS+TKJ5dmr8JnWuNZXIpq4u/qd+KFL3PQlgyjPdVWWyH4uXJV+gohrMw
 Xv4HWDPw05oAClPWB/lpoA6Sv79r7j8yV5c9On0tneLXMqmG4PNCuplw09y5+brNMivu
 fV/FsUch0eTSLP3u1yKYUP/uuJFTkenmUZ91Vix7vHFmJM3fkS6vfperU2HATU3Tu91x
 Zp8Q==
X-Gm-Message-State: AC+VfDyuEQdYP/17OEGaBHaT1erG/UDbVcPYPDBkjVSuNtCobowwDtqy
 BnzsdLNLJViBNdpvZn5pNNs=
X-Google-Smtp-Source: ACHHUZ64bfEGGRGRhaQOhZPzoJHc77RFLkuMzhwaER109SANmn019jBehyJkox9vxSGSJiRiLcBM1g==
X-Received: by 2002:a17:90a:9906:b0:23f:83de:7e4a with SMTP id
 b6-20020a17090a990600b0023f83de7e4amr33928351pjp.7.1684206836978; 
 Mon, 15 May 2023 20:13:56 -0700 (PDT)
Received: from localhost ([202.168.30.146]) by smtp.gmail.com with ESMTPSA id
 e5-20020a17090ada0500b0024e47fbe731sm367436pjv.24.2023.05.15.20.13.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 May 2023 20:13:56 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 May 2023 13:13:47 +1000
Message-Id: <CSNDHR9JKDCY.27DLV4G9AEEHO@wheely>
Cc: <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>, <npiggin@linux.ibm.com>,
 <vajain21@linux.ibm.com>, <harshpb@linux.ibm.com>, <sbhat@linux.ibm.com>
Subject: Re: [PATCH] target: ppc: Correctly initialize HILE in HID-0 for
 book3s processors
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Narayana Murty N" <nnmlinux@linux.vnet.ibm.com>, "Fabiano Rosas"
 <farosas@suse.de>, "Vaibhav Jain" <vaibhav@linux.ibm.com>, "Narayana Murty
 N" <nnmlinux@linux.ibm.com>, <danielhb413@gmail.com>, <clg@kaod.org>,
 <david@gibson.dropbear.id.au>, <groug@kaod.org>
X-Mailer: aerc 0.14.0
References: <20230420145055.10196-1-nnmlinux@linux.ibm.com>
 <87v8hq8lgz.fsf@suse.de> <87y1mcfvzo.fsf@vajain21.in.ibm.com>
 <87sfckrsd9.fsf@suse.de> <CSMN30SCVNA1.DOF9IMJOJRM5@wheely>
 <814e7c18-39f4-505c-4072-7d580c99af63@linux.vnet.ibm.com>
In-Reply-To: <814e7c18-39f4-505c-4072-7d580c99af63@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52d.google.com
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

On Tue May 16, 2023 at 11:54 AM AEST, Narayana Murty N wrote:
>
> On 5/15/23 12:02, Nicholas Piggin wrote:
> > On Sat Apr 29, 2023 at 12:30 AM AEST, Fabiano Rosas wrote:
> >>>> Could you describe in more detail what is your setup? Specifically
> >>>> whether both guests are running TCG or KVM (info kvm) and the state =
of
> >>>> the nested-hv capability in QEMU command line.
> >>> Currently the issue is seen with any pseries KVM guest running on a P=
owerNV host.
> > Okay originally I thought you were talking about a powernv target
> > that is running a pseries guest and dumping that. But after re-reading,=
 I
> > think you're talking about dumping a pseries target?
>
> yes, The qemu-memory-dump tested on different combinations like pseries
> as well as powernv guests with and without -enable-kvm.

Still not quite sure what you're talking about from that or the v2
changelog.  powernv is not a guest, it is a target machine, and it can't
use -enable-kvm. The target runs on the host which is your hardware. The
machine can emulate Linux/KVM hosting a guest but that's all *inside*
the target and not a property of the target QEMU. powernv just knows it
is executing with MSR[HV]=3D0, LPIDR!=3D0, etc.

> > Questions still remain about why that's the best way to go. If the
> > target was running a nested-HV guest, is it reasonable that the guest
> > can change the endinaness of the target dump on a whim by changing its
> > ILE?
> >
> > Thanks,
> > Nick
>
> But the crash tool expects the endianness of the dump loaded should be sa=
me as
> supplied debug kernel image endianness.

Seems like an important detail to mention in the changelog.

> Detailed test cases we can find at V2 of this patch.
> https://lore.kernel.org/all/20230509104701.12473-1-nnmlinux@linux.ibm.com=
/

The patch may be okay, but changelog needs work. Please explain the
cases using QEMU terminology like host and target, and describe what
the target is doing in a way that's clear you aren't talking about
the QEMU that is the subject of the patch.

Host    Target        Workload
BE      powernv       BE Linux running LE KVM guest
LE      powernv       ...
LE      pseries KVM   etc
LE      pseries TCG

Don't have to enumerate the entire matrix or put it in that format
exactly, but something clear and precise.

ILE does not always match vmlinux being run by target either, mind you.
Generally in early boot. I guess that is an unavoidable gap without
doing more stuff (either make crash work or add a way to set dump endian
or something). That's okay, ILE might be a reasonable proxy, but it
might be worth mentioning in the changelog too.

Thanks,
Nick

