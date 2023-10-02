Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 334CC7B51DB
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 13:57:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnHXC-00030b-Fz; Mon, 02 Oct 2023 07:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnHX4-0002zs-Ma; Mon, 02 Oct 2023 07:56:16 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnHX2-0002Y6-U7; Mon, 02 Oct 2023 07:56:14 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 780F926BC9;
 Mon,  2 Oct 2023 14:56:50 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A0DD72C279;
 Mon,  2 Oct 2023 14:56:07 +0300 (MSK)
Message-ID: <9e380190-4147-fc73-3205-112cb854f25a@tls.msk.ru>
Date: Mon, 2 Oct 2023 14:56:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] Fix compilation when UFFDIO_REGISTER is not set.
Content-Language: en-US
To: Pierre Labatut <plabatut@google.com>, qemu-trivial@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20230928125700.1504442-1-plabatut@google.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230928125700.1504442-1-plabatut@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -91
X-Spam_score: -9.2
X-Spam_bar: ---------
X-Spam_report: (-9.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.321,
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

28.09.2023 15:56, Pierre Labatut wrote:
> Signed-off-by: Pierre Labatut <plabatut@google.com>
> ---
>   subprojects/libvhost-user/libvhost-user.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

I'm not sure how subprojects are handled here.  Should we commit things
to a subproject directly? This one does not seem to be wrapped at least,
and has been in contrib/ before moving to subprojects/, so seems to be
ok.

> diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
> index 0469a50101..d4a2eab883 100644
> --- a/subprojects/libvhost-user/libvhost-user.c
> +++ b/subprojects/libvhost-user/libvhost-user.c
> @@ -629,9 +629,9 @@ static bool
>   generate_faults(VuDev *dev) {
>       unsigned int i;
>       for (i = 0; i < dev->nregions; i++) {
> +#ifdef UFFDIO_REGISTER
>           VuDevRegion *dev_region = &dev->regions[i];
>           int ret;
> -#ifdef UFFDIO_REGISTER
>           struct uffdio_register reg_struct;
>   
>           /*

Applied to my trivial-patches tree, thank you!

/mjt

