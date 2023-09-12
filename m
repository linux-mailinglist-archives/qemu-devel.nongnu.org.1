Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BD979D9DF
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 22:04:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg9cG-0004A1-OJ; Tue, 12 Sep 2023 16:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qg9cE-00049T-DQ; Tue, 12 Sep 2023 16:04:06 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qg9cA-0000iV-Vf; Tue, 12 Sep 2023 16:04:06 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:ba1:0:640:375a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 84B3B61FE7;
 Tue, 12 Sep 2023 23:03:58 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8006::1:28] (unknown
 [2a02:6b8:b081:8006::1:28])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id v3lSEE0Oha60-ETppczay; Tue, 12 Sep 2023 23:03:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1694549038;
 bh=teWdCjd86CUqGolok7o+c9TNzcsQZDVhBUDNumCvjAc=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Ayza5+OpeUJy5o7g55+cakShXadYWGlAmxjxZBh4fDiHPcnv4shvD2PPjO4BEC/ph
 TkIMDH7i4fETmuE6+tsGt5XGt8D60k4Y1ttvzuxHxxRnwAywO60WKbf112hISVRkTU
 l+33tQ4BBzIjWeVcEGGKwUzUr7lAJzbQlSlVGX0E=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <2b3edc30-807a-2f3c-79b8-55d2f027af2d@yandex-team.ru>
Date: Tue, 12 Sep 2023 23:03:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] iotests: distinguish 'skipped' and 'not run' states
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>
References: <20230906140917.559129-1-den@openvz.org>
 <20230906140917.559129-4-den@openvz.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230906140917.559129-4-den@openvz.org>
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

On 06.09.23 17:09, Denis V. Lunev wrote:
> Each particular testcase could skipped intentionally and accidentally.
> For example the test is not designed for a particular image format or
> is not run due to the missed library.
> 
> The latter case is unwanted in reality. Though the discussion has
> revealed that failing the test in such a case would be bad. Thus the
> patch tries to do different thing. It adds additional status for
> the test case - 'skipped' and bound intentinal cases to that state.

Hmm. Do I miss something, or in this patch you only split them, not making "not run" produce an error? So ./check still reports success when some tests are "not run"?

The split itself looks correct to me.

-- 
Best regards,
Vladimir


