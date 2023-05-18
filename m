Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F611708993
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 22:35:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzkJu-0003h6-Gt; Thu, 18 May 2023 16:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1pzkJn-0003er-Hq
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:33:47 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1pzkJg-00046Q-Fe
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:33:43 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 35F1C7043;
 Thu, 18 May 2023 23:33:35 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0E02C64B9;
 Thu, 18 May 2023 23:33:32 +0300 (MSK)
Message-ID: <ddef6f32-e314-e0d8-f755-015dad9c90f8@tls.msk.ru>
Date: Thu, 18 May 2023 23:33:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v10 8/8] apic: disable reentrancy detection for apic-msi
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, Alexander Bulekov <alxndr@bu.edu>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Mauro Matteo Cascella <mcascell@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>, David Hildenbrand <david@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Bandan Das <bsd@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Darren Kenny <darren.kenny@oracle.com>, Bin Meng <bin.meng@windriver.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jon Maloy <jmaloy@redhat.com>,
 Siqi Chen <coc.cyqh@gmail.com>
References: <20230427211013.2994127-1-alxndr@bu.edu>
 <20230427211013.2994127-9-alxndr@bu.edu>
 <20230518162205-mutt-send-email-mst@kernel.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230518162205-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -94
X-Spam_score: -9.5
X-Spam_bar: ---------
X-Spam_report: (-9.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.544,
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

18.05.2023 23:22, Michael S. Tsirkin пишет:
> On Thu, Apr 27, 2023 at 05:10:13PM -0400, Alexander Bulekov wrote:
>> As the code is designed for re-entrant calls to apic-msi, mark apic-msi
>> as reentrancy-safe.
>>
>> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
>> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> 
> feel free to merge with rest of patchset - who's going to
> merge it btw?
>

https://gitlab.com/qemu-project/qemu/-/commit/50795ee051a342c681a9b45671c552fbd6274db8

Author:     Alexander Bulekov <alxndr@bu.edu>
AuthorDate: Thu Apr 27 17:10:13 2023 -0400
Commit:     Thomas Huth <thuth@redhat.com>
CommitDate: Fri Apr 28 11:31:54 2023 +0200

FWIW

/mjt

