Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA847DE5A1
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 18:53:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyFNQ-0001F2-OR; Wed, 01 Nov 2023 13:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qyFNN-0001EM-1M; Wed, 01 Nov 2023 13:51:33 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qyFNL-0006U0-48; Wed, 01 Nov 2023 13:51:32 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CECDF2F5C3;
 Wed,  1 Nov 2023 20:51:32 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E656A32B22;
 Wed,  1 Nov 2023 20:51:26 +0300 (MSK)
Message-ID: <0834e809-6255-42e7-b72c-e0a21dd15901@tls.msk.ru>
Date: Wed, 1 Nov 2023 20:51:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] qemu-img: rebase: stop when reaching EOF of old
 backing file
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, den@virtuozzo.com
References: <20230919165804.439110-1-andrey.drobyshev@virtuozzo.com>
 <20230919165804.439110-2-andrey.drobyshev@virtuozzo.com>
 <b19cfb5c-658f-4bf2-a872-7eaa252d68b4@tls.msk.ru>
 <676efe0e-0c13-433b-9ca5-18c14920050d@virtuozzo.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <676efe0e-0c13-433b-9ca5-18c14920050d@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

01.11.2023 18:38, Andrey Drobyshev wrote:
> Hi Michael,
> 
> Since this series is already merged in master, I'm not sure whether it's
> necessary to forward this particular patch to qemu-stable, or it should
> rather be cherry-picked to -stable by one of the block maintainers.

It's been my job lately to pick something up for stable, once it gets
applied to master.  But it is usually the patch author or subsystem
maintainer to mark a change as a candidate for -stable, - I can't decide
about every change out there, since I don't have enough expertise in
every area.  You Cc: qemu-stable@ and I pick it up.  I do look at stuff
being applied to master from time to time though, and ask if I see
something which might be worth to pick, as in this case.

BTW, there's another change in this series which might be a good candidate
too, - "qemu-img: rebase: use backing files' BlockBackend for buffer
alignment".  Once again, I dunno if it's worth to pick it up or not,
it's basically up to you to decide.  Basically, you understand much
better what the implications are and if the change fixes actual bug.

/mjt

