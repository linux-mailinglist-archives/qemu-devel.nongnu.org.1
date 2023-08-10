Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60230778375
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 00:09:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUDpR-0005Gw-LX; Thu, 10 Aug 2023 18:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qUDpO-0005Gn-Tf
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 18:08:22 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qUDpN-00077b-9b
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 18:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691704992; x=1692309792; i=deller@gmx.de;
 bh=1mT2YbqC2zIdXWoEGREHOQNR8cS4hR0018pxRD6KXRY=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=fC6yCdce0HEw/BqZek4a741dxAtTRwZm/O1qOAhZjowdNRBo+8yjAceIEZlD788bTxUBS2W
 gITDrbF+qhLp9OhFZ5PGOQpElkYgQJDTXy6wwi4zwH9bilywVObmn157xNUJ9oDlZfHzvh7Pc
 gnnEci5E5yVnDL6BwmPHS58TZ/qwsRdF7OYqDj+4bLRY0yYwGxxcGX9/3cxqbvPdiXGe7FlNN
 droAyjkGyOaiBAjwtlmF6ZM0CsxO1DuIBw9MypeXQ7/DPJfArCC3GfU9+wzFO7UrCYzjRroJa
 kGQ2g4PhsTD9zoU+wwJMQ4+xnU/83npqkYJ7/GdjvVRbYaEn0+VA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.144.133]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4hvR-1plUoR0RQl-011l7Y; Fri, 11
 Aug 2023 00:03:12 +0200
Message-ID: <b662c6e4-8905-b6e0-c258-6985a35dd0e7@gmx.de>
Date: Fri, 11 Aug 2023 00:03:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] linux-user: Fix the build on systems without
 MAP_SHARED_VALIDATE
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
References: <20230810215706.1394220-1-iii@linux.ibm.com>
 <20230810215706.1394220-3-iii@linux.ibm.com>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <20230810215706.1394220-3-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Mdc7TRes97p8TTui8hL2CBsc+tTTaXCkfqn1pWI33s+H1qTNBWL
 iruCdAEuppL6AFWXXHICviavo0fpD+uPt6IQP3WQ4NI9uz6bpgtnURvjpyCYERbqySxbEIV
 vjc5Oskju+lrZgT+WfHD0bW1OV3qs5wrzzTdqnX1iOWxS7Er4Hc97VoDyp66stI+yYH32DL
 Ni0NsUANQ6ozczJ2cv5Hg==
UI-OutboundReport: notjunk:1;M01:P0:9BFKodFco04=;Qo1ilJoVkjqHkIoWBbo3RRUuONY
 48eAFOpi3Gt+fgFp7CaXAvqo8vLxaqvzxmscKYZol3Z1HLbWhywoQPqWUlKWv/35398cAwegA
 Upi/UnRIGPC4EHRIjtGzkCPQronIrtdLlbk7N5uoFhCcFUmfHPUT21Kw7jqV0208NYoGA/cR0
 FvvGD7U8kJrov8Pss88Uj519nV+0tmYdGxH15IyU4HrOASoN1zm6pnYlvWTTmoQEDRf/MWZUJ
 a2RbV11ntIZlRkgc/5BbqJRz6zQqVonmR2Qaq43U8lyTL0RUeix25aHvIUoU2E9/Jbk6ug4tJ
 qu2b+01YoScsWJIkRA6KGVXhGGPl7s+Nw4aKNJl0bC68zYkBw0WdAgiaNDQxnZkzQNxbf3WXS
 Lhv5lfyd1t+EV9KjBUjHC2xUdDeWg2jeNWz+QtJCkvn2sgTJgsL285jXaYF54sC+JGuaErY7B
 ui+k9YBYJAmyud5nu7l/bWGnJv+84X9udHDhnSSQeKdQjIo9YD/vi7E+kUyS8kLNB7glBIQ/k
 AIdKwEX207tm94iOjnOBhB+Ypbi3iH5QZ3dipNcQaOWNmgsnOyRMkHNZs1d9EYFbY7mBUxTHY
 YbI4obwd5dL4mOJzKFfUo+XOi5ykJCoP+CgDElAdpk8ETCa33cjNQBci1cGSh3h7Nt388aKoL
 fSdYCyXe8+7aQuuPAQuEDsR3vpQ6YnMHNIUmXL788cYqUoGRd1byLqZeWPjpervPdhp6f0EVv
 Psrp5YNf50SABp3deceQ22fTfYdcd7cZ95aF49RD+Itr7//c5Fubn/2kpkHNl0XGmVnGqp4Wq
 Q8BPzi2FuMFIYHbzNTSLIOKZvXFIJTHftrVcRNBVAxquiwjwvrGiraYo4Gb72gsPvPygYXRxj
 +w/M3/WCjYZW602EMH6TUiNIHDfgyC0drJ7DgzII+unk8i66MOYYd7ahbrHvZPC7FC6pa7ziC
 9qd3oA+1fRWgE3I3vnrPT84IlXs=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-2.156, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 8/10/23 23:51, Ilya Leoshkevich wrote:
> CentOS 7 does not define MAP_SHARED_VALIDATE. Use a definition provided
> by the QEMU's copy of linux/mman.h.
>
> Fixes: 4b840f96096d ("linux-user: Populate more bits in mmap_flags_tbl")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Does it fix the missing MADV_WIPEONFORK as well?
https://gitlab.com/qemu-project/qemu/-/issues/1824#note_1507837354

Helge

> ---
>   linux-user/syscall.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 42f4aed8e84..256f38cdd5d 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -121,6 +121,7 @@
>   #ifdef HAVE_BTRFS_H
>   #include <linux/btrfs.h>
>   #endif
> +#include <linux/mman.h>
>   #ifdef HAVE_DRM_H
>   #include <libdrm/drm.h>
>   #include <libdrm/i915_drm.h>


