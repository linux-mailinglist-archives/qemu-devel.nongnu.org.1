Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAEA72656E
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 18:05:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6veY-0002oY-Sr; Wed, 07 Jun 2023 12:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q6veS-0002oN-Pk
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 12:04:48 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q6veQ-0006dn-0z
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 12:04:48 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0A151B5E7;
 Wed,  7 Jun 2023 19:04:44 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D1CB3A554;
 Wed,  7 Jun 2023 19:04:42 +0300 (MSK)
Message-ID: <f414ba71-da57-31b9-0d8a-9986ce94c411@tls.msk.ru>
Date: Wed, 7 Jun 2023 19:04:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] vdpa: fix not using CVQ buffer in case of error
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Cindy Lu <lulu@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Hawkins Jiawei <yin31149@gmail.com>
References: <20230602173451.1917999-1-eperezma@redhat.com>
 <47527a58-039e-55e7-3541-bcd7ceb3296a@tls.msk.ru>
 <CAJaqyWeAsSJBhDtGkGTuf+uQsaEMOsNYMzhbwkJ6yAJ1-q+9pA@mail.gmail.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <CAJaqyWeAsSJBhDtGkGTuf+uQsaEMOsNYMzhbwkJ6yAJ1-q+9pA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

07.06.2023 16:52, Eugenio Perez Martin wrote:
> On Wed, Jun 7, 2023 at 12:11 PM Michael Tokarev <mjt@tls.msk.ru> wrote:
..
>> Again, smells like a stable material, is it not?
>>
>> Please Cc: qemu-stable@nongnu.org for other changes you think should be
>> applied to stable qemu series.
> 
> Sorry, I totally forgot. This one should go to stable, yes.

That's okay, nothing to be sorry about. You did a good job
already fixing the issues.

Queued up.

Thank you!

/mjt

