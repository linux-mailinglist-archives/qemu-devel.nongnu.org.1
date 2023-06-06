Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84691723ADE
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 10:01:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6RcZ-000607-JP; Tue, 06 Jun 2023 04:00:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q6RcA-0005wU-Oc; Tue, 06 Jun 2023 04:00:30 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q6Rc8-00037r-TZ; Tue, 06 Jun 2023 04:00:26 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 29A86AECA;
 Tue,  6 Jun 2023 11:00:10 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A192A9CC2;
 Tue,  6 Jun 2023 11:00:09 +0300 (MSK)
Message-ID: <4604b88b-5499-9e60-2d25-63b93f0517f4@tls.msk.ru>
Date: Tue, 6 Jun 2023 11:00:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 02/17] block: Collapse padded I/O vecs exceeding IOV_MAX
Content-Language: en-US
To: Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230605154541.1043261-1-hreitz@redhat.com>
 <20230605154541.1043261-3-hreitz@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230605154541.1043261-3-hreitz@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.09,
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

05.06.2023 18:45, Hanna Czenczek wrote:
> When processing vectored guest requests that are not aligned to the
> storage request alignment, we pad them by adding head and/or tail
> buffers for a read-modify-write cycle.
> 
> The guest can submit I/O vectors up to IOV_MAX (1024) in length, but
> with this padding, the vector can exceed that limit.  As of
> 4c002cef0e9abe7135d7916c51abce47f7fc1ee2 ("util/iov: make
> qemu_iovec_init_extended() honest"), we refuse to pad vectors beyond the
> limit, instead returning an error to the guest.
> 
> To the guest, this appears as a random I/O error.  We should not return
> an I/O error to the guest when it issued a perfectly valid request.
> 
> Before 4c002cef0e9abe7135d7916c51abce47f7fc1ee2, we just made the vector
> longer than IOV_MAX, which generally seems to work (because the guest
> assumes a smaller alignment than we really have, file-posix's
> raw_co_prw() will generally see bdrv_qiov_is_aligned() return false, and
> so emulate the request, so that the IOV_MAX does not matter).  However,
> that does not seem exactly great.

Why it is not "exactly great"?  To me, it seems to be the best solution.
I'd say we should be able to tolerate "slight" increase over IOV_MAX for
"internal purposes", so to say.  We can limit guest-supplied vector to
IOV_MAX, but internally guard against integer overflow only.

> I see two ways to fix this problem:
> 1. We split such long requests into two requests.
> 2. We join some elements of the vector into new buffers to make it
>     shorter.

This seems to be over-complicated, both of them, no?

/mjt

