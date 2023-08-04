Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D27276F905
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 06:37:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRmXM-0006qI-CO; Fri, 04 Aug 2023 00:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qRmX9-0006ez-Qe
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 00:35:34 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qRmWu-0005YE-Pg
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 00:35:20 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3668717DE0;
 Fri,  4 Aug 2023 07:35:26 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D23641B541;
 Fri,  4 Aug 2023 07:35:06 +0300 (MSK)
Message-ID: <7406c7df-4c4a-2566-6abc-9fa2eb0dccd2@tls.msk.ru>
Date: Fri, 4 Aug 2023 07:35:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PULL 22/22] cryptodev: Handle unexpected request to avoid crash
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 zhenwei pi <pizhenwei@bytedance.com>, Gonglei <arei.gonglei@huawei.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>, Xiao Lei
 <nop.leixiao@gmail.com>, Yongkang Jia <kangel@zju.edu.cn>,
 Yiming Tao <taoym@zju.edu.cn>
References: <cover.1691101215.git.mst@redhat.com>
 <15b11a1da6a4b7c6b8bb37883f52b544dee2b8fd.1691101215.git.mst@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <15b11a1da6a4b7c6b8bb37883f52b544dee2b8fd.1691101215.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
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

04.08.2023 01:21, Michael S. Tsirkin wrote:
> From: zhenwei pi <pizhenwei@bytedance.com>
> 
> Generally guest side should discover which services the device is
> able to offer, then do requests on device.
> 
> However it's also possible to break this rule in a guest. Handle
> unexpected request here to avoid NULL pointer dereference.
> 
> Fixes: e7a775fd ('cryptodev: Account statistics')
> Cc: Gonglei <arei.gonglei@huawei.com>
> Cc: Mauro Matteo Cascella <mcascell@redhat.com>
> Cc: Xiao Lei <nop.leixiao@gmail.com>
> Cc: Yongkang Jia <kangel@zju.edu.cn>
> Reported-by: Yiming Tao <taoym@zju.edu.cn>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> Message-Id: <20230803024314.29962-3-pizhenwei@bytedance.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

This smells like a stable-8.0 material. Please let me know if it is not.

Thanks,

/mjt

