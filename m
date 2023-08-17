Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D88777F0EA
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 09:10:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWX7Y-0005jO-OH; Thu, 17 Aug 2023 03:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qWX7J-0005iQ-K9; Thu, 17 Aug 2023 03:08:27 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qWX7G-000758-PC; Thu, 17 Aug 2023 03:08:25 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6C7401B067;
 Thu, 17 Aug 2023 10:08:17 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 162181FCC2;
 Thu, 17 Aug 2023 10:08:10 +0300 (MSK)
Message-ID: <b40783c1-a031-961f-ed18-1216ea6c7fc2@tls.msk.ru>
Date: Thu, 17 Aug 2023 10:08:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: qemu-system-x86 dependencies
Content-Language: en-US
To: Fourhundred Thecat <400thecat@gmx.ch>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-discuss@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>
References: <ed59d5cc-587e-ae8a-f367-96e4e58b67ce@gmx.ch>
 <10b32eab-a19a-a656-b8bd-4aef1f00bf11@linaro.org>
 <01d1482b-6b84-b762-f98c-7e0e74087820@tls.msk.ru>
 <b45ba384-ce6e-72ea-a903-466eb94aa3d3@gmx.ch>
 <75824b67-6192-a1c2-b89c-b67818ffb08b@gmx.ch>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <75824b67-6192-a1c2-b89c-b67818ffb08b@gmx.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -100
X-Spam_score: -10.1
X-Spam_bar: ----------
X-Spam_report: (-10.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.165,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

17.08.2023 08:10, Fourhundred Thecat wrote:
>  > On 2023-08-16 15:02, Fourhundred Thecat wrote:
>>  > On 2023-08-16 14:52, Michael Tokarev wrote:
>>> 16.08.2023 15:37, Philippe Mathieu-Daudé пишет:
>>>> Cc'ing Michael
>>>>
>> why does qemu depend on sound and gstreamer and wayland libraries?
>> After all, i am just trying to run VMs on my hypervisor.
>>
>> If I remember correctly, my previous installation on Debian 10,
>> qemu-system-x86 had no such dependencies.
>>
>> Seems to me like trying to install openssh-server, but it needs full
>> gnome environment libraries.
> 
> sorry if my question offended people.

Yes, your question did.  Declaring a few dependencies which you personally
dislike as "madness" does not help.

> Perhaps there is a good reason for these dependencies, which i don't see?
> 
> Also, I am told that Arch has split all these into separate packages:
> 
> https://archlinux.org/packages/?sort=&repo=Extra&q=qemu&maintainer=&flagged=
> 
> So it looks like my original question might be Debian specific?

As I always ask people asking similar questions (there are a lot): which
problem are you trying to solve?

Do you know how many binaries, for example, coreutils package contain?
Just imagine how many useless binaries are installed on your machine!
This package definitely needs to be split into single package per binary,
with proper dependencies between them and for every other package out
there which uses any binary from coreutils.  Or else it is a complete
waste of disk space, and it also needs security support/updating even
if a bug is found in an unused binary..

I know this attitude. I've been like this too, when I just come to *nix
and noticed how many various files are installed on the system.  No, this
is not how the system works.

Pathological example aside, - most distributions out there enable all
(or actually most) features of software they include. If you want fine
control, you can take a look at gentoo and their 'use' flags.  You can
build software exactly for your use case, with only the features your
use case needs.  This works.  Also, this takes time, - to figure out
which features are needed, which are supported as 'use' flags, and
finally to build stuff.

Some features in qemu can be build modular.  Some (eg usb device support,
hello libusb dependency) can not.  For things which can be made modular,
Some distributions ship each possible qemu module within its own package.
In debian I've choosen a mixed approach, by grouping some things together
to make life of users *simpler* yet to allow eliminating large deps
(like whole X11 stack for the gui part).  It's the same thing - by making
too many packages you make it too difficult for the users to use some
features, because it's impossible to figure out which additional packages
they need to install, - to eliminate the "usage madness", so to say, when
something should work according to qemu docs but it doesn't due to missing
package and there's no one here to help figure out which package it is.
Even after I've split qemu-block-extra package with some less-often-used
block drivers (each with its own deps), users started filing bugs saying
this or that block backend does not work, - giving headache and frustration
both to the users and to me as the maintainer.

Sure thing what you've asked is debian-specific, because these are all debian
packages, be it qemu or anything else.  And sure qemu-system-x86 (which is
another trade-off, - I don't ship package per architecture in debian, but
group "similar" architectures together) is a debian package.

An example, qemu in debian does not depend on gstreamer (and e.g. libopus is
pulled by gstreamer).  On my servers which run qemu-system-x86, gstreamer is
not installed.   For the audio-related "issue", there are 2 dependencies, -
libsndio and libausound, both small libraries without much deps.  These,
together with a few other modules in qemu-system-common, are often used on
a headless server to run regular guest systems, - I see no reason to split
that stuff further, and it will definitely make things more difficult for
regular (incl. headless) usage.

If you dislike the trade-off I've choosen, feel free to switch to some other
distribution (e.g. gentoo), or file bugs in debian bts with good reason for
each change you want to be made.

/mjt

