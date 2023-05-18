Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 988CD707AAB
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 09:15:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzXpa-00021g-GO; Thu, 18 May 2023 03:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzXpT-0001zc-6G; Thu, 18 May 2023 03:13:39 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzXpR-00074y-2z; Thu, 18 May 2023 03:13:38 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1E1946DB1;
 Thu, 18 May 2023 10:13:25 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id EB9FF626D;
 Thu, 18 May 2023 10:13:23 +0300 (MSK)
Message-ID: <fdb97449-d234-0d98-ed02-733ec1d33ac1@tls.msk.ru>
Date: Thu, 18 May 2023 10:13:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 17/18] aio-posix: do not nest poll handlers
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20230517165116.475123-1-kwolf@redhat.com>
 <20230517165116.475123-18-kwolf@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230517165116.475123-18-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -82
X-Spam_score: -8.3
X-Spam_bar: --------
X-Spam_report: (-8.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.412,
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

17.05.2023 19:51, Kevin Wolf wrote:
> From: Stefan Hajnoczi <stefanha@redhat.com>
> 
> QEMU's event loop supports nesting, which means that event handler
> functions may themselves call aio_poll(). The condition that triggered a
> handler must be reset before the nested aio_poll() call, otherwise the
> same handler will be called and immediately re-enter aio_poll. This
> leads to an infinite loop and stack exhaustion.
> 
> Poll handlers are especially prone to this issue, because they typically
> reset their condition by finishing the processing of pending work.
> Unfortunately it is during the processing of pending work that nested
> aio_poll() calls typically occur and the condition has not yet been
> reset.
> 
> Disable a poll handler during ->io_poll_ready() so that a nested
> aio_poll() call cannot invoke ->io_poll_ready() again. As a result, the
> disabled poll handler and its associated fd handler do not run during
> the nested aio_poll(). Calling aio_set_fd_handler() from inside nested
> aio_poll() could cause it to run again. If the fd handler is pending
> inside nested aio_poll(), then it will also run again.
> 
> In theory fd handlers can be affected by the same issue, but they are
> more likely to reset the condition before calling nested aio_poll().
> 
> This is a special case and it's somewhat complex, but I don't see a way
> around it as long as nested aio_poll() is supported.
> 
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2186181
> Fixes: c38270692593 ("block: Mark bdrv_co_io_(un)plug() and callers GRAPH_RDLOCK")

Is it not a stable-8.0 material?

Thanks,

/mjt

