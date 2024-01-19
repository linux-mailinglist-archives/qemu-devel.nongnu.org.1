Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34351832AE7
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 15:04:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQpTB-0002z2-7j; Fri, 19 Jan 2024 09:03:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xtec@trimaso.com.mx>)
 id 1rQcWI-0000A0-VU
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 19:14:03 -0500
Received: from poodle.tulip.relay.mailchannels.net ([23.83.218.249])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xtec@trimaso.com.mx>)
 id 1rQcWH-0001MF-1w
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 19:14:02 -0500
X-Sender-Id: spamcontrol26|x-authuser|xtec@trimaso.com.mx
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 8F334C2D9E;
 Fri, 19 Jan 2024 00:13:17 +0000 (UTC)
Received: from single-9040.banahosting.com (unknown [127.0.0.6])
 (Authenticated sender: spamcontrol26)
 by relay.mailchannels.net (Postfix) with ESMTPA id D9CA5C34D6;
 Fri, 19 Jan 2024 00:13:16 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1705623197; a=rsa-sha256;
 cv=none;
 b=Y2t72XyU/gB2a7vrNI1OmBBCL5PUeQ2Nj1ZcVHuFaTV3v7VFCJWMZ0coGi1FM8QILZdZl2
 0VBmDrnVg/aG0uBZ9o1pmyD0gORfYXJ3VCljWXUyY2Hq6yj623gBjuM75rjDPeS/nt9oHD
 c8M2jrm21qVNSjM0ZYfFhC4inqPZ17MdeJXU/x1H1Zqfytcq76uD1ajE/APNDEXwT5kl2z
 z1baEKWurRR4fhVouS1FSqmbARIKThm8ZvCOpyX38G7ot/aiS2ztTf7PvyyaN0VUB/jpO/
 FyuhL+VNiuL8gmOJBIaDlQF5pUm4pVnQEYi389dDMBo0IIBsg2DrL4LNN8O7Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1705623197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=kmS5V8hmQvCcZta6GCub6Bhp5wRlpsZqxeeWxUDFdBs=;
 b=0ZWlVwxZYp5h6GlnF3WZAaWTKTcUS4Zta3c650ECbocMd0yrApdlnzFfL3oF1mUyTVCm90
 ZQc9vWXwdbF8GbxIrhzhsIn8dRCjKj8AohCPE18V1dsJxQpaTYxKppbABZEh8sVaMLKmt8
 rGuy/SDyklkq/tWWu6Xzz8Zde6C+KAaS/BVvAAOaVd49QcPHf6X0GPn2Qgc2G190BWxVXx
 r2hfGbm4jd0S2M9LjDxXyE1bFAEeZ0JyEVKM9aZMas174m1+okoxTzsXQXizhQTfNU3AuR
 e1RYH7yR7VLxEGia9OpV2VA/9ZKl5iAslAvXLo+/zrTwhCTBibM9EwfjOYq8Uw==
ARC-Authentication-Results: i=1; rspamd-568947cb6c-w8h7p;
 auth=pass smtp.auth=spamcontrol26 smtp.mailfrom=xtec@trimaso.com.mx
X-Sender-Id: spamcontrol26|x-authuser|xtec@trimaso.com.mx
X-MC-Relay: Neutral
X-MailChannels-SenderId: spamcontrol26|x-authuser|xtec@trimaso.com.mx
X-MailChannels-Auth-Id: spamcontrol26
X-Trail-White: 03ead1ff56ea5bc5_1705623197279_2925745587
X-MC-Loop-Signature: 1705623197279:826321964
X-MC-Ingress-Time: 1705623197279
Received: from single-9040.banahosting.com (single-9040.banahosting.com
 [66.225.201.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
 by 100.123.135.9 (trex/6.9.2); Fri, 19 Jan 2024 00:13:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=trimaso.com.mx; s=default; h=Content-Transfer-Encoding:Content-Type:
 Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kmS5V8hmQvCcZta6GCub6Bhp5wRlpsZqxeeWxUDFdBs=; b=HYA3Xk0RwRPD3We1YyqTGZ5Xcs
 QVmkTTKw+HhGZsuclERadX7E5TYbd57ZW/BQc5rZmj7D3dVxHuhH6NIsmijTh2oTxjoFBRM2WqO2A
 AkyS1nPfmoYoRWgVVI1Xh2nh4Wj1nwZovzjIS5QU1uSakRqaGnFFkXoXObdJ0WZ0VPFByLQ3Z1ZbS
 ALpr6zzBBvNsOZ07i4L0Z/EWiNAHMOn9gasgfz4gPyynTNwKciovPvm8kPjSobHzPCpuQN8SPeQx2
 9cjZuDNQOzBBO8Tnq1isyg4YPup3g3N4IKAAMI3cAXDZTuGTP32kO/7FP+8WNKBR7NLl3O+r4OgZ7
 EHKRsDdQ==;
Received: from [::1] (port=52354 helo=single-9040.banahosting.com)
 by single-9040.banahosting.com with esmtpa (Exim 4.96.2)
 (envelope-from <xtec@trimaso.com.mx>) id 1rQcVP-0002nF-28;
 Thu, 18 Jan 2024 19:13:14 -0500
MIME-Version: 1.0
Date: Thu, 18 Jan 2024 18:13:09 -0600
From: xtec@trimaso.com.mx
To: Qemu Devel <qemu-devel@nongnu.org>
Cc: pbonzini@redhat.com
Subject: Re: Qemu setting "-cpu host" seems broken with Windows vms
In-Reply-To: <CABgObfbr3kF44ACA0didBCiBgQ87wgJS_H2fAPwyf==CAD3d2g@mail.gmail.com>
References: <8cceee40e32dab3e1913e50c221475ea@trimaso.com.mx>
 <CAJSP0QX-5ZxxiNejwEUoPE6Gnn=2=tfOb4MpAJNz5j6FYoNGzQ@mail.gmail.com>
 <CABgObfbr3kF44ACA0didBCiBgQ87wgJS_H2fAPwyf==CAD3d2g@mail.gmail.com>
User-Agent: Roundcube Webmail/1.6.0
Message-ID: <e2f135de3c1370b4f6db9fb80ac63945@trimaso.com.mx>
X-Sender: xtec@trimaso.com.mx
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-cPanel-MailScanner-Information: Please contact the ISP for more information
X-cPanel-MailScanner-ID: 1rQcVP-0002nF-28
X-cPanel-MailScanner: Found to be clean
X-cPanel-MailScanner-SpamCheck: 
X-cPanel-MailScanner-From: xtec@trimaso.com.mx
X-AuthUser: xtec@trimaso.com.mx
Received-SPF: softfail client-ip=23.83.218.249;
 envelope-from=xtec@trimaso.com.mx; helo=poodle.tulip.relay.mailchannels.net
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 19 Jan 2024 09:03:38 -0500
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

So finally tested with this:
-cpu host,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time,-vmx
The used hyper-v enhancements are the ones generally recommended for 
Windows vms.

Overall it seemed to really work: the performance was like bare metal, 
and the BSOD second problem was also gone (for this I had to test by 
installing another Win11 23h2 vm from scratch and run windows updates).

Also, unlike before, the Windows "suspend" functions also appeared; and 
most surprising: the actually worked.
Tried suspending, worked. Even tried enabling the infamous "fast boot" 
and shutting down vm. Result, it took a little more to shut down, but 
when powering on vm again, it did restore.
Though did each test only once...

Did these last tests because in many QEMU/KVM guides around internet I 
had read that, at least with Windows vms, it was very important to 
disable fast boot because QEMU/KVM did not support it and lead to ugly 
buggy functionalities.
So, did this change over time?

This could apparently imply that the culprit was the "vmx" CPU bit, 
which as already explained it's the one enabling nested virtualization 
inside the vm.
Overall, what would you think? Could this qualify as kind of a bug? Is 
nested virtualization often used in QEMU/KVM vms?
Could it be that Win11 23h2 has problems with this CPU bit?

Oh, and based on the results, I have few additional doubts:

If wanted to do live migration, would it be a matter of just switching 
"host" for "Skylake" or any other "fixed" QEMU CPU model, then just 
checking vm still boots correctly?

When trying "-cpu host,hv-passthrough", I did notice a considerable 
improvement in overall performance than when using 
"hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time"; yet still noticeably 
not like bare metal. Why was this?

In another forum, I read a guy did not have problems updating from Win11 
22h2 to 23h2 on QEMU/KVM; though he used libvirt.
Among his CPU settings, he did not use the CPU passthrough, but a QEMU 
CPU model, which cannot remember which was except that it was a Xeon 
server model. Moreover, among the used CPU bits, there was vmx=on.
If the culprit here was apparently this vmx bit, how it is that for 
others it bore no consequence? The only difference was using a "server" 
CPU model instead of a "client" one. Though they did not talk about 
performance...

Thanks.


El 2024-01-16 11:56, Paolo Bonzini escribió:
> One possibility is that you have Hyper-V enabled with -cpu host but
> not with other CPU models. That's because "-cpu host" enables nested
> virtualization.
> 
> Try "-cpu host,-vmx" and it should be clear if that's the case.
> 
> Based on the pastie that you prepared, that's the main difference
> between -cpu host and -cpu Broadwell-noTSX-IBRS. Nothing else (see
> list below) should have any substantial performance impact; even less
> so should they make things worse.
> 
> Paolo
> 
>                "avx512-vp2intersect": true,
>                "avx512-vpopcntdq": true,
>                "avx512bitalg": true,
>                "avx512bw": true,
>                "avx512cd": true,
>                "avx512dq": true,
>                "avx512f": true,
>                "avx512ifma": true,
>                "avx512vbmi": true,
>                "avx512vbmi2": true,
>                "avx512vl": true,
>                "avx512vnni": true,
>                "full-width-write": true,
>                "gfni": true,
>                "vaes": true,
>                "vpclmulqdq": true,
> 
>                "clflushopt": true,
>                "clwb": true,
> 
>                "fsrm": true,
> 
>                "host-cache-info": false,
>                "host-phys-bits": true,
> 
>                "amd-ssbd": true,
>                "amd-stibp": true,
>                "arch-capabilities": true,
>                "ibpb": true,
>                "ibrs": true,
>                "ibrs-all": true,
>                "ssbd": true,
>                "stibp": true,
> 
>                "kvm-pv-ipi": true,
>                "kvm-pv-sched-yield": true,
>                "kvm-pv-tlb-flush": true,
>                "kvm-pv-unhalt": true,
> 
>                "lmce": true,
>                "md-clear": true,
>                "mds-no": true,
>                "movdir64b": true,
>                "movdiri": true,
>                "pdcm": true,
>                "pdpe1gb": true,
> 
>                "pdcm": false,
>                "pdpe1gb": false,
>                "pku": true,
>                "pmu": true,
>                "pschange-mc-no": true,
>                "rdctl-no": true,
>                "rdpid": true,
>                "sha-ni": true,
>                "ss": true,
>                "tsc-adjust": true,
>                "umip": true,
>                "vmx": true,
>                "xgetbv1": true,
>                "xsavec": true,
>                "xsaves": true,
> 
> (skipped everything vmx-related, since they don't matter with vmx
> itself being false)

