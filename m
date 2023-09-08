Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 425D9798405
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 10:27:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeWpM-00044I-43; Fri, 08 Sep 2023 04:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qeWpI-00041s-If; Fri, 08 Sep 2023 04:26:52 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qeWpF-0000l3-54; Fri, 08 Sep 2023 04:26:51 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 570A320030;
 Fri,  8 Sep 2023 11:27:33 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 77E2726885;
 Fri,  8 Sep 2023 11:26:44 +0300 (MSK)
Message-ID: <dfa27597-a036-a3fb-8df3-5483004d0caf@tls.msk.ru>
Date: Fri, 8 Sep 2023 11:26:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PULL for-6.2 0/7] Ide patches
Content-Language: en-US
From: Michael Tokarev <mjt@tls.msk.ru>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Niklas Cassel <niklas.cassel@wdc.com>
References: <20230907034228.4054839-1-jsnow@redhat.com>
 <7ef011cd-09e7-c5f9-dc9d-173ff8f431c8@tls.msk.ru>
 <CAFn=p-aueHBXMFHgw=Y8XYyeaFZKFRc8vJHQ6PQ8gNSqPcii8Q@mail.gmail.com>
 <d5ff2d54-70bb-00e0-d25a-56d1096bed73@tls.msk.ru>
 <528c14dc-329f-f51a-cb8d-350a7a5cb7ee@linaro.org>
 <9eba8794-0535-e072-a15e-b95d1f9a88ff@tls.msk.ru>
In-Reply-To: <9eba8794-0535-e072-a15e-b95d1f9a88ff@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
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

08.09.2023 11:06, Michael Tokarev wrote:
..

> This smells a bit extreme, esp. for the "simplify and document PxCI handling"
> part which is one of the largest patches in whole -stable history.

or maybe it's just the excellent commit comment ;)

/mjt

