Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0793C725B55
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 12:11:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6q7z-0005O1-TD; Wed, 07 Jun 2023 06:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q6q7x-0005Nm-30
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 06:10:53 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q6q7v-0002cc-Fb
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 06:10:52 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 629DDB46A;
 Wed,  7 Jun 2023 13:10:50 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9C2ABA2ED;
 Wed,  7 Jun 2023 13:10:49 +0300 (MSK)
Message-ID: <47527a58-039e-55e7-3541-bcd7ceb3296a@tls.msk.ru>
Date: Wed, 7 Jun 2023 13:10:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] vdpa: fix not using CVQ buffer in case of error
Content-Language: en-US
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
Cc: Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Hawkins Jiawei <yin31149@gmail.com>
References: <20230602173451.1917999-1-eperezma@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230602173451.1917999-1-eperezma@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.094,
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

02.06.2023 20:34, Eugenio Pérez wrote:
> Bug introducing when refactoring.  Otherway, the guest never received
> the used buffer.
> 
> Fixes: be4278b65fc1 ("vdpa: extract vhost_vdpa_net_cvq_add from vhost_vdpa_net_handle_ctrl_avail")
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
>   net/vhost-vdpa.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Again, smells like a stable material, is it not?

Please Cc: qemu-stable@nongnu.org for other changes you think should be
applied to stable qemu series.

Thanks,

/mjt


