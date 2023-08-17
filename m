Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B7B77F029
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 07:12:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWVHR-0002WR-Px; Thu, 17 Aug 2023 01:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <400thecat@gmx.ch>)
 id 1qWVHF-0002UA-TC; Thu, 17 Aug 2023 01:10:33 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <400thecat@gmx.ch>)
 id 1qWVHD-0004X9-Af; Thu, 17 Aug 2023 01:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.ch;
 s=s31663417; t=1692249023; x=1692853823; i=400thecat@gmx.ch;
 bh=frN0Fyt1au05gAKP12yDl0kDPcw1D3ZszjROrbQJ2HU=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
 b=q1FRBbATbR5omb0mXCEdJqoXijDh62eFg9TlEBR36EdRyNt937pGZ08W4aYXWUiKEgjvbgu
 t3oJh8hSdUQTZv+gYIoMlr44cFgO7hT1PTqwunuYsNtQDwTWYEvw7SHQ3NTdygcTeEO+wW+K9
 Q3h1IzC1EDWbaOWoMLiTn02Cn8dFZNc4RprQWAeN4kWxPZvpWQPVkWgvTFwyv/0ecnTmznfXn
 Ek4HQsXHxpt+Ernamx8CSwYP+vTaQ9+orCJRM++62jCwMCqHypr6QygQhfFz9PvLoNt/z3x3O
 LG/rXi/IsYGcx7iTahPKtw2zxiZUUAwQybCbMhrjSgCvYxxxy1Bg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.1.2.16] ([212.25.11.75]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N33ET-1pkp3i2fHx-013OcI; Thu, 17
 Aug 2023 07:10:23 +0200
Subject: Re: qemu-system-x86 dependencies
From: Fourhundred Thecat <400thecat@gmx.ch>
To: Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-discuss@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>
References: <ed59d5cc-587e-ae8a-f367-96e4e58b67ce@gmx.ch>
 <10b32eab-a19a-a656-b8bd-4aef1f00bf11@linaro.org>
 <01d1482b-6b84-b762-f98c-7e0e74087820@tls.msk.ru>
 <b45ba384-ce6e-72ea-a903-466eb94aa3d3@gmx.ch>
Message-ID: <75824b67-6192-a1c2-b89c-b67818ffb08b@gmx.ch>
Date: Thu, 17 Aug 2023 07:10:22 +0200
MIME-Version: 1.0
In-Reply-To: <b45ba384-ce6e-72ea-a903-466eb94aa3d3@gmx.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1://RiIenPGyIb5t4WNQpWYB3V5TOui+TBxfkErY8D+JSo4TbgH5T
 gWyLJn0E6MBouji/UQjBAYVBAFw0edANIQ11j1OT4eAAikIge/mCn5cROS/GGNSy39V63lJ
 2A3GrPzrTuvt4gwElddrtutZW4lKUlLvAbXDvONrDDrLTUl3bZOVnk/ocXYvLILsPgUvnNw
 XIvlf0xFjx3l6oaKF31Dg==
UI-OutboundReport: notjunk:1;M01:P0:a9mWHAc0JYo=;S/x8prKyELM0eSDSvQ3OnouAb89
 7ti1FIxTQ2yg7Nyh5XmFQp2azNZinYy1P5UMlq6lTnlItCssBmYZFCSloL8SgBRS9qkDz76+7
 nHyxlPQKz20Iik0cnuICMzKnjNMn+NT6hmW9cMWLmTf99z65yljmU+tAGb0JkFiNmbLrel/uq
 pB/RrWSHJsCdJdsZotF4O/0HzHSIExvLhwkO+9bzXPtB8asXll9lCltoEKYh5vFmQdbrWcGqv
 Q7ioOwSy4GTPsgccq2Bx5kSlPTkNMyYHEXRP3ktuJxg+8czfDtxatCvRkuIhOZl464ndYPD4q
 dMPtiWFn/zTHK6y+o4JZvlVp9WLC9jC0aZVB3KgPpPHYwQ2S8T8F0Pu+YiHcGPM3tqn8JFIme
 DMoa5D0tYbYJo1Tk+t9LayuVUtBnzwfFPCIwINY0t4Q+JZMvmgJLehxxw4wcHdYZwx+o/RTVi
 YO8fQaTIWWkp/MIz+eGkAxaW9qZcFspp12YxhnHd4rzFbW7QnquSi+xUaIOzNBFfs6Xsc9aSZ
 HbI502xf+XM1nrskIo24QwBt5sD2jmRV7WmQOXOgemHLKT9SkZoj+HJFwjYeHA/m62XoxpHRT
 0Nt+8GxsXdS3JNJ70r/qu4ZID8JJ84k/5rDx+ISussuku40i04QDM4g2Qv/dC4fnH5ZdbuCy9
 5JzGWddBAKC/SoAG4nvIa74NiHybYrpGopURpqW9jwz4GPO4HLvPiThg1/Pg6Uaok8bipSjbo
 B3z3mAoJbuW3EyewqkfvhFAlQt0GN5VbB8S7OF5wtEgG2iUWejIcwHDk+/w7wZbmSmdvoPY0S
 JAwQnG2B68rHgfNEc4N7p5MNQY5dBfVcCphcLOR/Su6kVAN7pebzWoDVAqd6WBGU+APMjmyjr
 sW+HYXnPtEhO7rYQBnD90Vs0Kj9+GV7Ud80G1dKDuYgDm6+OqFNc6Hq5moNfnUPdAZsWZ2psc
 R1lTrQ==
Received-SPF: pass client-ip=212.227.17.21; envelope-from=400thecat@gmx.ch;
 helo=mout.gmx.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

 > On 2023-08-16 15:02, Fourhundred Thecat wrote:
>  > On 2023-08-16 14:52, Michael Tokarev wrote:
>> 16.08.2023 15:37, Philippe Mathieu-Daud=C3=A9 =D0=BF=D0=B8=D1=88=D0=B5=
=D1=82:
>>> Cc'ing Michael
>>>
> why does qemu depend on sound and gstreamer and wayland libraries?
> After all, i am just trying to run VMs on my hypervisor.
>
> If I remember correctly, my previous installation on Debian 10,
> qemu-system-x86 had no such dependencies.
>
> Seems to me like trying to install openssh-server, but it needs full
> gnome environment libraries.

sorry if my question offended people.

Perhaps there is a good reason for these dependencies, which i don't see?

Also, I am told that Arch has split all these into separate packages:

https://archlinux.org/packages/?sort=3D&repo=3DExtra&q=3Dqemu&maintainer=
=3D&flagged=3D

So it looks like my original question might be Debian specific?

