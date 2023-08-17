Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4298877F08C
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 08:31:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWWWA-0007x5-0N; Thu, 17 Aug 2023 02:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmenzel@molgen.mpg.de>)
 id 1qWWW5-0007vJ-2t; Thu, 17 Aug 2023 02:29:57 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmenzel@molgen.mpg.de>)
 id 1qWWW1-0005zX-VO; Thu, 17 Aug 2023 02:29:56 -0400
Received: from [192.168.0.2] (unknown [95.90.232.56])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id CDB5661E5FE01;
 Thu, 17 Aug 2023 08:29:46 +0200 (CEST)
Message-ID: <6db6de64-224f-40eb-a371-cdb71bfaa493@molgen.mpg.de>
Date: Thu, 17 Aug 2023 08:29:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: qemu-system-x86 dependencies
Content-Language: en-US
To: Fourhundred Thecat <400thecat@gmx.ch>
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-discuss@nongnu.org,
 qemu-devel@nongnu.org
References: <ed59d5cc-587e-ae8a-f367-96e4e58b67ce@gmx.ch>
 <10b32eab-a19a-a656-b8bd-4aef1f00bf11@linaro.org>
 <01d1482b-6b84-b762-f98c-7e0e74087820@tls.msk.ru>
 <b45ba384-ce6e-72ea-a903-466eb94aa3d3@gmx.ch>
 <75824b67-6192-a1c2-b89c-b67818ffb08b@gmx.ch>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <75824b67-6192-a1c2-b89c-b67818ffb08b@gmx.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=141.14.17.11; envelope-from=pmenzel@molgen.mpg.de;
 helo=mx3.molgen.mpg.de
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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

Dear Fourhundred,


Am 17.08.23 um 07:10 schrieb Fourhundred Thecat:
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
> 
> Perhaps there is a good reason for these dependencies, which i don't see?
> 
> Also, I am told that Arch has split all these into separate packages:
> 
> https://archlinux.org/packages/?sort=&repo=Extra&q=qemu&maintainer=&flagged=
> 
> So it looks like my original question might be Debian specific?

Please tell us, how you actually build QEMU (in the past). Building QEMU 
from upstream sources and configuring it with minimal options, why do 
the dependencies from the Debian package matter at all?


Kind regards,

Paul

