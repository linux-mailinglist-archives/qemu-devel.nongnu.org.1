Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ED677E354
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 16:13:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWHFY-0005O9-6w; Wed, 16 Aug 2023 10:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <400thecat@gmx.ch>)
 id 1qWGAQ-0000wv-67; Wed, 16 Aug 2023 09:02:31 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <400thecat@gmx.ch>)
 id 1qWGAN-00084y-Qd; Wed, 16 Aug 2023 09:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.ch;
 s=s31663417; t=1692190943; x=1692795743; i=400thecat@gmx.ch;
 bh=ZqKZIqNiaUo3k/aSX8GhkS97z/ULu2T1WyAbbs3/prg=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=DMdSvwIKOR7L2ypZWpT6EOL6sfViBenpAQjxmaAU6imSxHe+OhcrzcRRy41awyidVivQpyD
 NA5EJ1itB0LGcTZeMRDEZyuqyF8R4iNNBi6uKpd4UBYWJbBzT84YlBPSm/I0AfaBCE14MIRuc
 imjyDeAPB4tloGgo4XJQtScvTWQHFwx3SsuYLAsQC0DsoMXCuDKo3fJ+VV3pITs8mvAXOLjQf
 8nfd33zHqcSjqCgbHpEt5Ym9iqjHaHZBBgTEyOO7CKq4dEynP0Szf/LvZJz/ZMsAxorkbD/P9
 07IUwMpx4UYM/2iHS8WrbpsDRODkW2B+ozPt4D3kDurk/J6Vt6dg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.1.4.32] ([212.25.11.75]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mk0JM-1q3Y7r08Qy-00kOq7; Wed, 16
 Aug 2023 15:02:23 +0200
Subject: Re: qemu-system-x86 dependencies
To: Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-discuss@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>
References: <ed59d5cc-587e-ae8a-f367-96e4e58b67ce@gmx.ch>
 <10b32eab-a19a-a656-b8bd-4aef1f00bf11@linaro.org>
 <01d1482b-6b84-b762-f98c-7e0e74087820@tls.msk.ru>
From: Fourhundred Thecat <400thecat@gmx.ch>
Message-ID: <b45ba384-ce6e-72ea-a903-466eb94aa3d3@gmx.ch>
Date: Wed, 16 Aug 2023 15:02:25 +0200
MIME-Version: 1.0
In-Reply-To: <01d1482b-6b84-b762-f98c-7e0e74087820@tls.msk.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:90x5RQ2CothHJyqrs/OgdNkxAKIy9X4rKp1Yq9Hnr3g3BnxKYiN
 ccKBFduAKTQQmzQ0aPJLFsnX+gXfkbtaGiUyN96lfZdWVsOOif/Lwq4qxBzg1QDAqTkve1Q
 Ewrd28FG5cvUbBAwDqzaJ3TXGG02jOy0HE6pDOYFLepsnG4x+QRP4A/r5i2Lcqm2dCza5n/
 9hyhnH7LAWTAfoPDkiIUQ==
UI-OutboundReport: notjunk:1;M01:P0:qdxVKqdA12U=;ug5SBGqUBElT+QmnZGoyucqNDoG
 SBmwcrlvJDpHNPdrn0M5gsNlwd0o9ryDerJ/UnkymyaE93z7aqxffAEv/VbgfTkkmJ84VkUBx
 Zx6i587uloK6KLy1c3hmx4c/uDMtvGHgPQ5iBFs2F1ZNlha8nyfvamY6v5vTh4J7D7q+YfVAk
 RFJBXz2dAjZOZhAtXrxWXNpH4AtS8IE4WNnTjnX7IaDg+QP/NzZXa3oi6hsA4iRE2QDCiixDI
 F61pqNdUPMQOHbkXsTEMb4uFGb1Mk0eyHFgCQfx19kP2YLXMZY1FC124P/0o4GRANM2UiEbqb
 oC+IKZN19ZFNISpB6B+w5uPr3Rw7bqis7jP2KuyyGCPmzhkv6IFzmK5gGeFoBvwT1TuZWJ1ox
 hLoYgYfkkN6ueZ7hvs9VKTWucSOckQd1yT6HxwNE1UXXP+OGv2VpTCNfgIE5H9ZUaqsPRfWBQ
 eH40iGt/O/xJpqFZ9Fzv9PUFm2ugSkkgBr8fzX5N1bGV33FhX06WLXhcQzZZMKnJG6UU7kEhl
 8pofY6nX6RYBMuF5fW8YROrJOPPnDYIqut9THX81VRTGGfSHkIDnSvcLeLv6F+966lNHWtKh+
 NbyWA5+laMI7L+Sg430i4dtOmgZBSGdmhUu0oIbfCP6hqn3VGszZlL/b3TdHde6dWi/iN7/Yd
 L1xUfaGJea6c+IaYImyuHpJYz0OyxrSY6XsGrV4OCHvKXb9C5dAqwso35BjlXzhSYIbDA8HHj
 J8bIjGloMTIilRVL/KmY2mW0p3tEgNV6KNo6qfF5Gg4g+UNyys4aT6/3s/v75Grgyzh16ZZ70
 iQcT5y5VTjfRYo0eR6KesBgMGX1hrFAGoKOSfrmq8dNnL37YBDoTxn2loP8MSdrq2hdBl5Wlo
 /f2d6RaxBh5xeuxzH4KvfbaUe8mxYp9GlEaLjVIev7AVwPhHJZStBLyW/kFtudyLLEEfC/C4I
 /mAJvQQQve4HdzILlQUbeZGiHx4=
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
X-Mailman-Approved-At: Wed, 16 Aug 2023 10:11:49 -0400
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

 > On 2023-08-16 14:52, Michael Tokarev wrote:
> 16.08.2023 15:37, Philippe Mathieu-Daud=C3=A9 =D0=BF=D0=B8=D1=88=D0=B5=
=D1=82:
>> Cc'ing Michael
>>
>> On 16/8/23 13:52, Fourhundred Thecat wrote:
>>> Hello,
>>>
>>> I am trying to install qemu-system-x86 on Debian 12.
>>>
>>> But through the dependency cascade, it wants to install sound
>>> infrastructure with gstreamer libraries. Which leads to absurd
>>> dependencies, such as:
>>>
>>> =C2=A0=C2=A0 libasound2
>>> =C2=A0=C2=A0 libgstreamer-plugins-base1.0-0
>>> =C2=A0=C2=A0 libopus0
>>> =C2=A0=C2=A0 libwayland-server0
>>> =C2=A0=C2=A0 libusb-1.0-0
>>>
>>> Does this madness come from Debian distribution, or from upstream?
>
> I don't know which madness you're talking about. Is it qemu upstream mad=
ness
> or debian distribution madness?=C2=A0 Maybe if you were be a bit more sp=
ecific
> and share your definition of madness, things would be more clear.=C2=A0 =
But with
> either of the mentioned madness, it might be neither of us are able to
> understand, being both mad.

what I meant is:
why does qemu depend on sound and gstreamer and wayland libraries?
After all, i am just trying to run VMs on my hypervisor.

If I remember correctly, my previous installation on Debian 10, qemu-syste=
m-x86 had no such dependencies.

Seems to me like trying to install openssh-server, but it needs full gnome=
 environment libraries.



