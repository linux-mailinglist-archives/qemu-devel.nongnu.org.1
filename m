Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 971E376EF24
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 18:10:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRauK-000748-3E; Thu, 03 Aug 2023 12:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qRauJ-000740-34
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 12:10:35 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qRauH-0004Xf-Im
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 12:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691079030; x=1691683830; i=deller@gmx.de;
 bh=Ps5ESWctYf8WZ27Bf4a/jSM1NgU1W/AF1AtXhzGZF+U=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=N1Y3MGbr9Sg2oa1y/R/sayyhhSKslyHOuEGXMY1C3D9W9gfVvaqKFBvHLegbA6YuTQn9vfN
 6tb+dembilafohjqPXyTgmh0RnZCjpxk8mUGwPnHpECpD/t1BtHzJ45KqMH0aWi0KjXHpiBv8
 ORmvGIGB2BoraQjPGIRJ/EN/r8rRP39ufmoF9JR6AU2i+2Ki3od9GeMn1+XzFMKKDVGXqt+Vm
 kxyI9zvlI+t78sMsRygkmgGLQyuWxwBl818RV0Wft9gyhjPXoovusoduTXsefuhehYB0f20oh
 +fLuOOiRdrJ4eUkhac6O4dyoqtv7KxD/YQwFXT/dprym8IghxgtQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.147.53]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McYCb-1pqtdz2xNV-00cvVP; Thu, 03
 Aug 2023 18:10:30 +0200
Message-ID: <c685729a-f02c-701c-b2d6-769a9abf7fe2@gmx.de>
Date: Thu, 3 Aug 2023 18:10:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 00/14] linux-user: brk fixes
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
Cc: akihiko.odaki@daynix.com
References: <20230803015302.407219-1-richard.henderson@linaro.org>
 <CACPK8XfNiGiprxYd-J+E-oFqPsRVPfQa7+e5hX8DFw0OudT85A@mail.gmail.com>
 <cd9b0651-475d-1b11-d648-594b52d48bd1@gmx.de>
 <CACPK8XcdO4KpBfUZmxLNRLLcAOfM9D39be=m4O72kO0+_GiuQQ@mail.gmail.com>
 <ZMvBTMpi9jDVWDiP@p100> <a023f15a-9e6c-1975-a395-c8fac0340ba0@linaro.org>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <a023f15a-9e6c-1975-a395-c8fac0340ba0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RkCcWNVJ90Eh7zHxfqemwdSxrHPIXCDwzkEqdRBmzuz0aruI2c1
 VU//xDF5mp2M6oRifVATOojMjLxkruMKQYP9RzyTs4L+y9yD3B24yhsx0m95ONk7q7Ipplq
 a21YVUx5nUuzB6+YhuZ9XI+BxNkS3nqLLltoymh+JoFZJcPD2Iq5TpiCtpoA93dzVR299fI
 KsD6/JtvgecI/UaPoj+uA==
UI-OutboundReport: notjunk:1;M01:P0:/9it0Lv4ZP4=;Q1aNF8E1PkGC4p1DqdQcAuHvoP3
 nFxjYNqYG89AVaSv0K6nV3k9GnR0y9sQVwZ+yKZ+/ISJQdFuKzuBPMkL2wN9/nGx62ZNTweXH
 D5OU65qm662N7A55oaX1vrZO5YK28wBhnOCmUub02yPFdFwm5Qdau2AP8GK2Umu9K5gfrwL9k
 G8OVqsUOkDM+kOT5Jr5CZI7SFOHSroTSAhLs4NLhVNe8zPIbjpY2HE19JDWXgRTZOee30QFL8
 7QOXVx731mGTchyu7NMAWh3bgzQx23dZw9BAURPEKeSgeddP/kYQN2+K/9tnPt8LcWM3UDOyC
 efi33jKW30XvJQUHSqBAmkW3+vrTP8p7qELzT47foq0ogl9bwCZg9BzSxGsdPYMA/GWv3infA
 kgYmIfRXo1p+OV0Cq6scDSgUmEziAZdBgzPGK59EY8AReNmh+cJ2eI2WxvlcmFeksGYjO6gRd
 nw6mEElZKXIhUoFgsMHKVw/YM3KLxpvUQ0lMO5FWuyawupdcgCLwHs/KrCrD5pjsjwWcTopSu
 pYabq2jW91bp3XvcS1YgPInRzIoSzIw2kY+4BqZrEa79uMdh/uiwk8UquhSShYWAC8RZcRNer
 gHUg46UX68nypVsOFvZYlBWb4UdKXpwlrzefzjgsUcCvX/VpdNR7DNLQnSDoVvI2rTxa1VGzK
 xwXv0CkEiLDUTn6/71Sj0IY+1uILDEElc/Sk2otS9N4MriuTot9q5Oez7Ko30OwT2hwilDH4n
 wyaDp+0x8t/azNlHnaHTjz4c2AUteypcsigpkiSbd3gmj/SlxDXSR1sEjEkflQtM5a9n2gltu
 iw1j7S95CIBudAC3FzgrWXukqUFSd/8uPKmGQio19mrcd6/Iq3lXqIR4B/NRUVLU+OmElwsjS
 dM6xXtF4D7LQWpF3XvpPdOL9Yhb8XSwktcnUrEPfBWZGKqHLhil1ikNd6AZtwNTob4l6r1u3j
 bN5nEGY972y3z65/8HUBYNeQw8w=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/3/23 17:20, Richard Henderson wrote:
> On 8/3/23 08:01, Helge Deller wrote:
>> If it does, it replaces patches 1,2 & 4-6 from Richard's v7 patch
>> series.
>
> The patch you gave below has no overlap with 1,2,4,5 at all.

Yes, ignore this.... Your patch series is fine as-is....
(the brk()-host-page-alignment issue is the only one left I think)

Helge


