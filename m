Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 462BE777EBB
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 19:03:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU93y-0004vG-Dt; Thu, 10 Aug 2023 13:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@gmx.us>) id 1qU8bD-00054X-T1
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:33:23 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@gmx.us>) id 1qU8bB-0006tz-VO
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.us;
 s=s31663417; t=1691685188; x=1692289988; i=fan.ni@gmx.us;
 bh=Ic34E1rhStu5oBJ08gz/o3kbUbXuZnUVTlGULk/Q6ks=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=dytzl3366sQQ9n/9D6wuVdYhzCHBBE6CgQB7eD4Y/nUiObxr1PUaDaQpySEFhSpZvVPcEU0
 jEy1eAdRZ6Cv5Jv60gcp5+AyC67dpL4fY3RfHMBFDRzi3dbW3O5QJCLjqzghzSHj/8kta+6DP
 SrdAogyL45Na7k1w5NEbD5g2ORqiCSbCvL0dXV4H/3b7kC6W+6+iKFTw+HbmK7ZJrre461/79
 gsyg12b7bkP0+lBYifqtJ/NXxbqYbAIs0bMHJipXGnst61rMeW5GNLREqyQJLBl1tE9vyeSAA
 ddRBux/5didM9hM9qUdX+O92dsg5KIRyn/4KjcZ316SA8RWi/wVA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from debian ([99.13.228.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MJE6F-1qF5ke1eB9-00KiTo; Thu, 10
 Aug 2023 18:33:08 +0200
Date: Thu, 10 Aug 2023 09:32:55 -0700
From: Fan Ni <fan.ni@gmx.us>
To: Maverickk 78 <maverickk1778@gmail.com>
Cc: Jonathan Cameron via <qemu-devel@nongnu.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-cxl@vger.kernel.org
Subject: Re: CXL volatile memory is not listed
Message-ID: <ZNURN6Zzf2hJfmt/@debian>
References: <CALfBBTtUtydebmJuh6JZ5RAXZfx5OgJ+RCug1apbZa4mm17rJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALfBBTtUtydebmJuh6JZ5RAXZfx5OgJ+RCug1apbZa4mm17rJQ@mail.gmail.com>
X-Provags-ID: V03:K1:34c3h0X1GoGb6w3tlWtZc4NsiTaDJ4S1HgxAVUBpatoGVB55JX3
 HtRJskZ0coaxwKVJgE/MarNgvBazmvKfa9j+CAKPLqDLiGFPVf/PbmbZJZa87sbIQxeZ0ja
 CZ92rV2XS5APrNxQHJVoPawZRuajTM4+5n4PO1zgCaHMky9aqPACczDan5rDVdHPAJ5Vaal
 uq5d7tsa4/WL9gfTd1Q5w==
UI-OutboundReport: notjunk:1;M01:P0:0gRq4+nxu1k=;XzOB6oQ5IH2ZLKstESxah76vVh5
 +Ful1GMetCckoAsTwzWweA2e3f/Qi7H0EuHZhv52+lmtIuO+GVSNZ1Q4lTdEbX/UFREfnCL+Z
 /EuKMy3zDxxDQJ07qeLHhOX956OBg/aaE5V13ty273E2qHEZgfAO+j55PTa2XFT5yf2ma5MaU
 Ixu1e8/vwkPfLTtkeWHbndUTNeiBywWI65D/r9tZQIhQLIKmY6K3+oKXHh2PMrd7gMAjV1Mef
 drInTjZTd6rP7CIkqvYn/s/LHBj63eMOhs8PMpmNPvu6Q6NzatpJgqSbm2yXfqDi00Z+ZP3uX
 N3Mw+GgszJEXmyMj4pXkMooGXnW2nk2VPJzzJit+eIF+paZeLl8T7ZLii60Xr+XOBhxO10l4K
 Pe4x4mLBrq3HXNalVNrCTL+0oAwZWZ4Z/CUSrO28CbGvLrcADrDdWYuyG8tFedhq9pUsIcbEO
 KNFfWWMmRnQQSAgsm1JHGy9Y0wrGBR34X90HgPwMvknGGlluVfFeef4CE1OTG3AkC9xv3bk+l
 KR+ORV2kbomimA2ufg8Ah+/YPUhceavk3sLlxIEBCj9tc1ntbHRkhi81gN09scY0PVgg4Ldvi
 K0PVaNml9SUruFdTw6w8t+EPqcrx30hneD9tUphve+QtnLIqhD/LrVyZLvHBkVUvq97KmyKP6
 kpI29IhN9B2TLxWZFk7QU+OQSv7zACxpyJf2QOYZHeYbSHdRHiE+K1l0u8UBYuDBzjAQAn2XT
 KB+03R+NpX6ot4dM87vd5PnDrkT7CLf9oLMIFjN1j4Ke9li8nlKZtQchO2VhoC8wDeBpAYGIb
 J+z4RcjbUz9CUzjIsLsIcPiG0UCyC8EE2wxIjTGh23I7CmD5Aiz6fAPwWxeAQSE/4L4qkiBmv
 pB7vr4ANlQOzNshcdFAIySzo7AhGzdCFZa2wLX84Pe9pGXt/8EnZiZ5dCeIYYxAUYjzCn0v2u
 2f+mxzXte2tqmlUIcYL2da6I2SM=
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.227.17.21; envelope-from=fan.ni@gmx.us;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 10 Aug 2023 13:02:45 -0400
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

On Wed, Aug 09, 2023 at 04:21:47AM +0530, Maverickk 78 wrote:
> Hello,
>
> I am running qemu-system-x86_64
>
> qemu-system-x86_64 --version
> QEMU emulator version 8.0.92 (v8.1.0-rc2-80-g0450cf0897)
>
> qemu-system-x86_64 \
> -m 2G,slots=3D4,maxmem=3D4G \
> -smp 4 \
> -machine type=3Dq35,accel=3Dkvm,cxl=3Don \
> -enable-kvm \
> -nographic \
> -device pxb-cxl,id=3Dcxl.0,bus=3Dpcie.0,bus_nr=3D52 \
> -device cxl-rp,id=3Drp0,bus=3Dcxl.0,chassis=3D0,port=3D0,slot=3D0 \
> -object memory-backend-file,id=3Dmem0,mem-path=3D/tmp/mem0,size=3D1G,sha=
re=3Dtrue \
> -device cxl-type3,bus=3Drp0,volatile-memdev=3Dmem0,id=3Dcxl-mem0 \
> -M cxl-fmw.0.targets.0=3Dcxl.0,cxl-fmw.0.size=3D1G
>
>
> I was expecting the CXL memory to be listed in "System Ram", the lsmem
> shows only 2G memory which is System RAM, it's not listing the CXL
> memory.
>
> Do I need to pass any particular parameter in the kernel command line?
>
> Is there any documentation available? I followed the inputs provided in
>
> https://lore.kernel.org/linux-mm/Y+CSOeHVLKudN0A6@kroah.com/T/
>
> Is there any documentation/blog listed?

If I remember it correctly, for volatile cxl memory, we need to create a
region and then it will be discovered as system memory and shows up.

Try to create a region with "cxl create-region".

Fan
>

