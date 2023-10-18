Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E89D7CD901
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 12:19:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt3do-0003cy-J1; Wed, 18 Oct 2023 06:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qt3dl-0003c9-OS
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:19:01 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qt3di-0000pS-V4
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:19:01 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:201e:0:640:d29a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 7B8DF626BE;
 Wed, 18 Oct 2023 13:18:53 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b667::1:1d] (unknown
 [2a02:6b8:b081:b667::1:1d])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id pIiCHNHOfKo0-7Y1enm9H; Wed, 18 Oct 2023 13:18:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1697624332;
 bh=oOJNOP6B/GMRy8zHAesza8R02+SzOLcMWLuwFiUU0WM=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=U6nMMYPcnthuUn0/Jr3BjPAJjmSyq5cWtEwS/KROrzXmL/PPGUK8oIERAWiiI6AAL
 dUMrhPWbnMU8ZWGLacyegHYyywdOHDeJhl0NQcFHJ/jUODB8yQtMGiYddsmvGNzIun
 bIp5RTDUF9bHJi9OrHyS6UnLK4OrUvrRUmIC0cXM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <c4dcc22b-da6b-44ae-9a0d-dcdb9b2e35f2@yandex-team.ru>
Date: Wed, 18 Oct 2023 13:18:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/cpu-x86-uarch-abi.py: Fix parameter error of cmd
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20231018100011.685867-1-zhao1.liu@linux.intel.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20231018100011.685867-1-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 18.10.23 13:00, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> When run this script, there's the error:
> 
> python3 scripts/cpu-x86-uarch-abi.py /tmp/qmp
> Traceback (most recent call last):
>    File "/path-to-qemu/qemu/scripts/cpu-x86-uarch-abi.py", line 96, in <module>
>      cpu = shell.cmd("query-cpu-model-expansion",
> TypeError: QEMUMonitorProtocol.cmd() takes 2 positional arguments but 3 were given
> 
> Commit 7f521b023bc28 ("scripts/cpu-x86-uarch-abi.py: use .command()
> instead of .cmd()") converts the the original .cmd() to .command()
> (which was later renamed to "cmd" to replace the original one).
> 
> But the new .cmd() only accepts typing.Mapping as the parameter instead
> of typing.Dict (see _qmp.execute()).
> 
> Change the paremeters of "query-cpu-model-expansion" to typing.Mapping
> format to fix this error.
> 
> Fixes: 7f521b023bc28 ("scripts/cpu-x86-uarch-abi.py: use .command() instead of .cmd()")
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   scripts/cpu-x86-uarch-abi.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/cpu-x86-uarch-abi.py b/scripts/cpu-x86-uarch-abi.py
> index f6baeeff2400..052ddd751424 100644
> --- a/scripts/cpu-x86-uarch-abi.py
> +++ b/scripts/cpu-x86-uarch-abi.py
> @@ -94,8 +94,8 @@
>   
>   for name in sorted(names):
>       cpu = shell.cmd("query-cpu-model-expansion",
> -                    { "type": "static",
> -                      "model": { "name": name }})
> +                    type="static",
> +                    model={ "name": name })
>   
>       got = {}
>       for (feature, present) in cpu["model"]["props"].items():


Oh, right, thanks for fixing:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir


