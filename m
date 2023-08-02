Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD9576CFD1
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 16:15:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRCbr-00035H-Dd; Wed, 02 Aug 2023 10:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qRCbj-000321-MU; Wed, 02 Aug 2023 10:13:47 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qRCbh-0008QZ-PI; Wed, 02 Aug 2023 10:13:47 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 50C941779F;
 Wed,  2 Aug 2023 17:13:57 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id AFBE81AD05;
 Wed,  2 Aug 2023 17:13:40 +0300 (MSK)
Message-ID: <891f431b-d1f2-d801-219b-1aaae9dfbfeb@tls.msk.ru>
Date: Wed, 2 Aug 2023 17:13:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH] Fix some typos in documentation and comments
Content-Language: en-US
To: Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: libvir-list@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20230730180329.851576-1-sw@weilnetz.de>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230730180329.851576-1-sw@weilnetz.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.102,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

30.07.2023 21:03, Stefan Weil via wrote:
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
> 
> This patch was triggered by a spelling check for the generated
> QEMU documentation using codespell. It does not try to fix all
> typos which still exist in the QEMU code, but has a focus on
> those required to fix the documentation. Nevertheless some code
> comments with the same typos were fixed, too.
> 
> I think the patch is trivial, so maybe it can still be included
> in the upcoming release, but that's not strictly necessary.
> 
> Stefan
> 
>   docs/about/deprecated.rst    | 2 +-
>   docs/devel/qom.rst           | 2 +-
>   docs/system/devices/nvme.rst | 2 +-
>   hw/core/loader.c             | 4 ++--
>   include/exec/memory.h        | 2 +-
>   ui/vnc-enc-tight.c           | 2 +-
>   6 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 1c35f55666..92a2bafd2b 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -369,7 +369,7 @@ mapping permissions et al by using its 'mapped' security model option.
>   Nowadays it would make sense to reimplement the ``proxy`` backend by using
>   QEMU's ``vhost`` feature, which would eliminate the high latency costs under
>   which the 9p ``proxy`` backend currently suffers. However as of to date nobody
> -has indicated plans for such kind of reimplemention unfortunately.
> +has indicated plans for such kind of reimplementation unfortunately.

FWIW, all these changes has been included in my "tree-wide spelling" series.
This particular change:
  https://lists.nongnu.org/archive/html/qemu-devel/2023-07/msg03011.html

/mjt

