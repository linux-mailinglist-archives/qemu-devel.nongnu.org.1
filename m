Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8016786030
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 20:54:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYsyn-00050k-5m; Wed, 23 Aug 2023 14:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <k.jensen@samsung.com>)
 id 1qYsyk-00050a-OA
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 14:53:18 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <k.jensen@samsung.com>)
 id 1qYsyh-0004M3-P1
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 14:53:18 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20230823185306euoutp01d1a578b3e78dfc95d16177d4bc5ada40~_F_XlFdHe2494724947euoutp01n
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 18:53:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20230823185306euoutp01d1a578b3e78dfc95d16177d4bc5ada40~_F_XlFdHe2494724947euoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1692816786;
 bh=IepP/PwlipXrMWY5Tr0JLHtxdyzPPWVCWJny6gSEwD4=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=oK+Pbos248kuOSqJny0n+3mLKfieTSzTluMTbPZDFP2+/5wy/+fLdtGSeRo6FN7RV
 npcWKBxN8kW5ar7aeIpBD7ssen8RuEv2Q6hgn92GL4ZbmEOb1QlsNogTbwFEzP2h/h
 FjgVj/EwpXwiFmev4i3KOwVBelXvdJAzE4LkCHZ0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20230823185305eucas1p2f7733f888c9698035af32807e3efb0de~_F_Wk7vyK1134011340eucas1p27;
 Wed, 23 Aug 2023 18:53:05 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 0F.5F.42423.09556E46; Wed, 23
 Aug 2023 19:53:04 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20230823185304eucas1p1f809a45cd985eb15346ee5b66a25a406~_F_WTVXSP2571825718eucas1p1K;
 Wed, 23 Aug 2023 18:53:04 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20230823185304eusmtrp2a2afadd1753680bca6dad8dd6d1cb93f~_F_WS4i8d2764727647eusmtrp2N;
 Wed, 23 Aug 2023 18:53:04 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-f2-64e65590a002
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id FD.79.10549.09556E46; Wed, 23
 Aug 2023 19:53:04 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20230823185304eusmtip1d63dc659137945efce9a3c5ad39edfa7~_F_WJv_MC0218202182eusmtip1O;
 Wed, 23 Aug 2023 18:53:04 +0000 (GMT)
Received: from localhost (106.210.248.7) by CAMSVWEXC02.scsc.local
 (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 23 Aug 2023 19:53:04 +0100
Date: Wed, 23 Aug 2023 20:52:59 +0200
From: Klaus Jensen <k.jensen@samsung.com>
To: Sam Li <faithilikerun@gmail.com>
CC: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel
 <qemu-devel@nongnu.org>, Val Adler <spantamd@gmail.com>
Subject: Re: NVMe ZNS last zone size
Message-ID: <ZOZVi2FVAmj4qnXV@cormorant.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAAx-8+ugwD4a3NEs36afYREKpf8LPj1jUpLNrO7gFugdVs+fg@mail.gmail.com>
X-Originating-IP: [106.210.248.7]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
 CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsWy7djPc7oTQp+lGGydYW3xb3YDm8Xx3h0s
 Fk/XRVncnD6VyYHFY+esu+weT65tZgpgiuKySUnNySxLLdK3S+DKmPL3F3PBB+6Kf89PMjYw
 ruDsYuTkkBAwkfh9ZgZrFyMXh5DACkaJ618vsUE4Xxglurd+YIJwPjNKXPm5ihWmZerhTqiW
 5YwSzZ2dLHBVFyb/hGrZzCjxcvMsZpAWFgFViYMPvzOC2GwCmhLb//xnAbFFBFQk3q4/AzaW
 WSBP4u30FjYQWxgo/urkWSYQm1dAT+LLoyvsELagxMmZT4B6OYDqNSXW79KHMKUllv/jgJgi
 L9G8dTbYVk6BQIk/u3cwQRytKHFz5S82CLtW4tSWW2BnSggc4ZD4d+soI8gcCQEXib0TfSFq
 hCVeHd/CDmHLSPzfOR9qTrHEp0kNLBB2jcS11YtZIVqtJfrO5ECEHSXWrlzIBhHmk7jxVhDi
 Mj6JSdumM0OEeSU62oQmMKrMQvLVLISvZiF8NQvJVwsYWVYxiqeWFuempxYb5qWW6xUn5haX
 5qXrJefnbmIEJpDT/45/2sE499VHvUOMTByMhxglOJiVRHi/+DxLEeJNSaysSi3Kjy8qzUkt
 PsQozcGiJM6rbXsyWUggPbEkNTs1tSC1CCbLxMEp1cA0sf6AypzfeR/eXX0pHflHZklfyR2D
 xb9/L97eLVm0QC78dPWRnTkxn1+pKvyZ9stxNnOp3cuEjp7o0LtLM6TXxtXWL2b6s0fj6sn/
 2xNefw01WnzTWaSIs/n2Sn2je3ZZN6a3lb/YPtXEdPWiFXrfti99+OeobNqb0s4/Ut1PqvQY
 lrxjvBC43zrivH/chZLIxphFp/0nKD4TYd36r4DR22/mwyNhvneT+Mp2HJ7Axmg57UlLTskd
 tgnLtoqp/rQzc5jmoJL6aM/OajtWey+20ppZnMf3NJ/p4V0by+F1O/jE74udhorfBKIbdNKE
 pWQ3ngh4xtOm+GXfH/nuA7/CwsvSTpxL+xDrxpV2T+CmEktxRqKhFnNRcSIAFa8AIY8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xu7oTQp+lGPTu0LD4N7uBzeJ47w4W
 i6froixuTp/K5MDisXPWXXaPJ9c2MwUwRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hka
 m8daGZkq6dvZpKTmZJalFunbJehlTPn7i7ngA3fFv+cnGRsYV3B2MXJySAiYSEw93MnaxcjF
 ISSwlFFi5tlmNoiEjMTGL1dZIWxhiT/Xutggij4ySpx4cZIRwtnMKLHv+C9mkCoWAVWJgw+/
 M4LYbAKaEtv//GcBsUUEVCTerj8DNImDg1kgT2LJJn+QsDBQ+NXJs0wgNq+AnsSXR1fYIWb+
 ZJLoWL0ZKiEocXLmExaIXk2J9bv0IUxpieX/OEAqmAXkJZq3zga7gFMgUOLP7h1MEDcrStxc
 +Qvql1qJz3+fMU5gFJmFZOgshKGzEIbOQjJ0ASPLKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxN
 jMAY23bs5+YdjPNefdQ7xMjEwXiIUYKDWUmE94vPsxQh3pTEyqrUovz4otKc1OJDjKbA8JnI
 LCWanA+M8rySeEMzA1NDEzNLA1NLM2MlcV7Pgo5EIYH0xJLU7NTUgtQimD4mDk6pBqYD3kkH
 G7ZJf1q57G5Z34m1yy85a5qyhVzc8MEmttg29xnb7UqlteUsBqnPuvhlP0UrLUz0i01c3P/v
 6oQ6xe076kRunGowm5KbximymCHpSNLVpOVGN5msm45WVE68oCp7+Vb9YbkKI9+0F7JL/0R9
 TclTy2LZZW3ObVNX/zlGiFvfanqt6ct5d4WXbqoq8WA3y35yo3rXv+BPim0LNyZXyt9LFoua
 1bdYc4n29zKDSINrew5y3Tr29IHuBwZV2WyZSR8KfDfz/pDXj11zuXZuSbCL6ZQ3W32DThzy
 +CiZN2eFwrspb8ybRTw/Lr6ilvOsO7Y0Kfd6siE///EVBqbrNoemixjm//HnPCDwQYmlOCPR
 UIu5qDgRANsL6606AwAA
X-CMS-MailID: 20230823185304eucas1p1f809a45cd985eb15346ee5b66a25a406
X-Msg-Generator: CA
X-RootMTR: 20230823145848eucas1p27f88a6af04a2919d618a844ee5375239
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230823145848eucas1p27f88a6af04a2919d618a844ee5375239
References: <CAJSP0QU7gp1OjmrGhV1Y4jLRF0DYQAG=vn7LTS8SOa0eADW70Q@mail.gmail.com>
 <CAAAx-8KKesRCK1-4-1Yx=SvsmMgxBZKLaCZXPZkKk4vyDkEOVg@mail.gmail.com>
 <CAJSP0QVsStbxhxRJZjNhfEcXbUUaL1d-Qq1g9QtpH762R3CE6Q@mail.gmail.com>
 <CGME20230823145848eucas1p27f88a6af04a2919d618a844ee5375239@eucas1p2.samsung.com>
 <CAAAx-8+ugwD4a3NEs36afYREKpf8LPj1jUpLNrO7gFugdVs+fg@mail.gmail.com>
Received-SPF: pass client-ip=210.118.77.11; envelope-from=k.jensen@samsung.com;
 helo=mailout1.w1.samsung.com
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Aug 23 22:58, Sam Li wrote:
> Stefan Hajnoczi <stefanha@gmail.com> 于2023年8月23日周三 22:41写道：
> >
> > On Wed, 23 Aug 2023 at 10:24, Sam Li <faithilikerun@gmail.com> wrote:
> > >
> > > Hi Stefan,
> > >
> > > Stefan Hajnoczi <stefanha@gmail.com> 于2023年8月23日周三 21:26写道：
> > > >
> > > > Hi Sam and Klaus,
> > > > Val is adding nvme-io_uring ZNS support to libblkio
> > > > (https://gitlab.com/libblkio/libblkio/-/merge_requests/221) and asked
> > > > how to test the size of the last zone when the namespace's total size
> > > > is not a multiple of the zone size.
> > >
> > > I think a zone report operation can do the trick. Given zone configs,
> > > the size of last zone should be [size - (nr_zones - 1) * zone_size].
> > > Reporting last zone on such devices tells whether the value is
> > > correct.
> >
> > In nvme_ns_zoned_check_calc_geometry() the number of zones is rounded down:
> >
> >   ns->num_zones = le64_to_cpu(ns->id_ns.nsze) / ns->zone_size;
> >
> > Afterwards nsze is recalculated as follows:
> >
> >   ns->id_ns.nsze = cpu_to_le64(ns->num_zones * ns->zone_size);
> >
> > I interpret this to mean that when the namespace's total size is not a
> > multiple of the zone size, then the last part will be ignored and not
> > exposed as a zone.
> 
> I see. Current ZNS emulation does not support this case.
> 

NVMe Zoned Namespaces requires all zones to be the same size. The
"trailing zone" is a thing in SMR HDDs.


Cheers,
Klaus

