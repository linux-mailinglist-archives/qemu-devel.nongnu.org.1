Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E253881DB08
	for <lists+qemu-devel@lfdr.de>; Sun, 24 Dec 2023 16:17:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHQDT-0008Oz-IK; Sun, 24 Dec 2023 10:16:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1rHQDJ-0008Of-04
 for qemu-devel@nongnu.org; Sun, 24 Dec 2023 10:16:26 -0500
Received: from jedlik.phy.bme.hu ([152.66.102.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1rHQDD-0004dR-FU
 for qemu-devel@nongnu.org; Sun, 24 Dec 2023 10:16:23 -0500
Received: by jedlik.phy.bme.hu (Postfix, from userid 1000)
 id 0B8B3A00F2; Sun, 24 Dec 2023 16:09:01 +0100 (CET)
Date: Sun, 24 Dec 2023 16:09:00 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Shlomo Pongratz <shlomopongratz@gmail.com>
cc: qemu-discuss <qemu-discuss@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Subject: Re: PCIe with Designware RC.
In-Reply-To: <CAHzK-V2tSJNpTsNe7=Na7_Bg-YR4kP_6THJCKfAN9tumVAXeVg@mail.gmail.com>
Message-ID: <alpine.LMD.2.03.2312241606290.26099@eik.bme.hu>
References: <CAHzK-V1CDcpa5LQzfx8ppU0nZh01AyfPkB-xXQcPqXuue7BJvw@mail.gmail.com>
 <2bf508bc-ce4b-870c-1828-b349c96f8102@eik.bme.hu>
 <CAHzK-V2tSJNpTsNe7=Na7_Bg-YR4kP_6THJCKfAN9tumVAXeVg@mail.gmail.com>
User-Agent: Alpine 2.03 (LMD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
 BOUNDARY="1117279078-1270052612-1703430540=:26099"
Received-SPF: none client-ip=152.66.102.83;
 envelope-from=balaton@jedlik.phy.bme.hu; helo=jedlik.phy.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1117279078-1270052612-1703430540=:26099
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 24 Dec 2023, Shlomo Pongratz wrote:
> Thank you, see comment inside.
>
> On Sun, Dec 24, 2023 at 1:11=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.h=
u> wrote:
>>
>> On Sun, 24 Dec 2023, Shlomo Pongratz wrote:
>>> Hi,
>>> I'm working on a AARCH64 project that uses the designeware
>>> (hw/pci-host/designware.c).
>>> I've copied the designware initialization from hw/arm/fsl-imx7.c and I
>>> hope I've updated the dtsi correctly.
>>> After fixing an issue with the iATU windows (see patch
>>> https://lists.gnu.org/archive/html/qemu-devel/2023-12/msg02643.html)
>>> I've tried to add virtualized NVMe controller.
>>> When I added the lines:
>>>        -device nvme,serial=3Ddeadbeef,drive=3Dnvme0,bus=3Dpcie \  (Or w=
ithout bus=3D)
>>>        -drive file=3D/home/pliops/disk-1.img,if=3Dnone,id=3Dnvme1 \
>>
>> You define drive with if=3Dnone,id=3Dnvme1 but have drive=3Dnvme0 in you=
r
>> device. You should refer to the drive you want the device to use so I
>> think it should either be -device nvme,drive=3Dnvme1 or the if of drive
>> should be nvme0.
>
> This was a typo, All are nvme0.

Then maybe you need to give more details on what do you use as then the=20
difference is only which pcie bus it's connected to. You could try=20
checking in QEMU monitor with 'info qtree' where devices are attached and=
=20
how are they organised and with 'info mtree' where BARs are mapped.

Regards,
BALATON Zoltan
--1117279078-1270052612-1703430540=:26099--

