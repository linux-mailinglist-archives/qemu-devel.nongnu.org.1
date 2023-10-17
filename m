Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC577CB9E9
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 07:20:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qscUt-000092-L3; Tue, 17 Oct 2023 01:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qscUp-00007z-8o; Tue, 17 Oct 2023 01:19:59 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qscUi-0007mQ-3T; Tue, 17 Oct 2023 01:19:59 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 509472ADC1;
 Tue, 17 Oct 2023 08:20:05 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8965B2F82A;
 Tue, 17 Oct 2023 08:19:48 +0300 (MSK)
Message-ID: <0f479df3-2563-4186-b83b-be1dc2fcae8a@tls.msk.ru>
Date: Tue, 17 Oct 2023 08:19:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] virtio: Drop out of coroutine context in virtio_load()
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, quintela@redhat.com, peterx@redhat.com,
 leobras@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 qemu-block@nongnu.org, qemu-stable@nongnu.org
References: <20230905145002.46391-1-kwolf@redhat.com>
 <20230905145002.46391-3-kwolf@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230905145002.46391-3-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

05.09.2023 17:50, Kevin Wolf wrote:
> virtio_load() as a whole should run in coroutine context because it
> reads from the migration stream and we don't want this to block.
> 
> However, it calls virtio_set_features_nocheck() and devices don't
> expect their .set_features callback to run in a coroutine and therefore
> call functions that may not be called in coroutine context. To fix this,
> drop out of coroutine context for calling virtio_set_features_nocheck().
...
> Cc: qemu-stable@nongnu.org
> Buglink: https://issues.redhat.com/browse/RHEL-832
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

It looks like this change caused an interesting regression,
   https://gitlab.com/qemu-project/qemu/-/issues/1933
at least in -stable.  Can you take a look please?

BTW, Kevin, do you have account @gitlab?

Thanks,

/mjt

