Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB3B7AF5AB
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 23:24:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlFWs-0004Cr-5J; Tue, 26 Sep 2023 17:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qlFWq-0004CT-CU; Tue, 26 Sep 2023 17:23:36 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qlFWn-0001iy-MZ; Tue, 26 Sep 2023 17:23:35 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:550b:0:640:d49b:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 15D9260771;
 Wed, 27 Sep 2023 00:23:29 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b41d::1:39] (unknown
 [2a02:6b8:b081:b41d::1:39])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id SNXJds0Op4Y0-6bt5tmrf; Wed, 27 Sep 2023 00:23:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1695763408;
 bh=+5nojs6wBG7umyWLi5ROS55r8LQQIpkAkxEmHYlv0/4=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=h1Pg81VTjRRwqK+4RebpewoU8qKjY1aWjT8x3A6ZYj4RzyryeBBwnt0raPzXcLCrQ
 8/nqHVINb37vPBcGbmlh7z8ZLA3pi6sk1S2g+PIp9fMFKjGTneL72TcYlfI7xYeatF
 1GMveqdH6jFdEFnp02GOS0fuCFOr2xtoGDdOT0uU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <d3bf04cd-ddd2-ebda-de39-5cd8b8d05e7f@yandex-team.ru>
Date: Wed, 27 Sep 2023 00:23:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/3] i386/a-b-bootblock: zero the first byte of each
 page on start
Content-Language: en-US
To: Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Juan Quintela <quintela@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org
References: <20230919102346.2117963-1-d-tatianin@yandex-team.ru>
 <20230919102346.2117963-3-d-tatianin@yandex-team.ru>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230919102346.2117963-3-d-tatianin@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 19.09.23 13:23, Daniil Tatianin wrote:
> The migration qtest all the way up to this point used to work by sheer
> luck relying on the contents of all pages from 1MiB to 100MiB to contain
> the same one value in the first byte initially.
> 
> This easily breaks if we reduce the amount of RAM for the test instances
> from 150MiB to e.g 110MiB since that makes SeaBIOS dirty some of the
> pages starting at about 0x5dd2000 (~93 MiB) as it reuses those for the
> HighMemory allocator since commit dc88f9b72df ("malloc: use large
> ZoneHigh when there is enough memory").
> 
> This would result in the following errors:
>      12/60 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test                 ERROR           2.74s   killed by signal 6 SIGABRT
>      stderr:
>      Memory content inconsistency at 5dd2000 first_byte = cc last_byte = cb current = 9e hit_edge = 1
>      Memory content inconsistency at 5dd3000 first_byte = cc last_byte = cb current = 89 hit_edge = 1
>      Memory content inconsistency at 5dd4000 first_byte = cc last_byte = cb current = 23 hit_edge = 1
>      Memory content inconsistency at 5dd5000 first_byte = cc last_byte = cb current = 31 hit_edge = 1
>      Memory content inconsistency at 5dd6000 first_byte = cc last_byte = cb current = 70 hit_edge = 1
>      Memory content inconsistency at 5dd7000 first_byte = cc last_byte = cb current = ff hit_edge = 1
>      Memory content inconsistency at 5dd8000 first_byte = cc last_byte = cb current = 54 hit_edge = 1
>      Memory content inconsistency at 5dd9000 first_byte = cc last_byte = cb current = 64 hit_edge = 1
>      Memory content inconsistency at 5dda000 first_byte = cc last_byte = cb current = 1d hit_edge = 1
>      Memory content inconsistency at 5ddb000 first_byte = cc last_byte = cb current = 1a hit_edge = 1
>      and in another 26 pages**
>      ERROR:../tests/qtest/migration-test.c:300:check_guests_ram: assertion failed: (bad == 0)
> 
> Fix this by always zeroing the first byte of each page in the range so
> that we get consistent results no matter the initial contents.
> 
> Fixes: ea0c6d62391 ("test: Postcopy")
> Signed-off-by: Daniil Tatianin<d-tatianin@yandex-team.ru>
> Reviewed-by: Peter Xu<peterx@redhat.com>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir


