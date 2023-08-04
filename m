Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AB276FA2E
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 08:36:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRoPG-0006Uk-Sp; Fri, 04 Aug 2023 02:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qRoP6-0006To-1s
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 02:35:18 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qRoOw-0002QQ-VB
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 02:35:11 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1DF2417E36;
 Fri,  4 Aug 2023 09:35:20 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 961D11B5B2;
 Fri,  4 Aug 2023 09:35:00 +0300 (MSK)
Message-ID: <1b821287-82f0-6b07-0293-385a218916f3@tls.msk.ru>
Date: Fri, 4 Aug 2023 09:35:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PULL 22/22] cryptodev: Handle unexpected request to avoid crash
Content-Language: en-US
To: zhenwei pi <pizhenwei@bytedance.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Gonglei <arei.gonglei@huawei.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>, Xiao Lei
 <nop.leixiao@gmail.com>, Yongkang Jia <kangel@zju.edu.cn>,
 Yiming Tao <taoym@zju.edu.cn>
References: <cover.1691101215.git.mst@redhat.com>
 <15b11a1da6a4b7c6b8bb37883f52b544dee2b8fd.1691101215.git.mst@redhat.com>
 <7406c7df-4c4a-2566-6abc-9fa2eb0dccd2@tls.msk.ru>
 <3d594b74-e7cf-0974-0940-28ddbe379b8b@bytedance.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <3d594b74-e7cf-0974-0940-28ddbe379b8b@bytedance.com>
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

04.08.2023 09:10, zhenwei pi wrote:
..
>> This smells like a stable-8.0 material. Please let me know if it is not.

> Both this one [1] and the previous one [2] should be table-8.0 material, I think.
> 
> [1][PULL 22/22] cryptodev: Handle unexpected request to avoid crash
> [2][PULL 21/22] virtio-crypto: verify src&dst buffer length for sym request

I picked up the 21 one (virtio-crypto) already without questions (for both 8.0 and 7.2)
since it fixes a CVE, but I wasn't 100% sure for the 22 one (cryptodev).

Thank you for letting me know.

/mjt

