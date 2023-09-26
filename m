Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB80A7AF540
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 22:33:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlEid-0003Mn-MP; Tue, 26 Sep 2023 16:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qlEiZ-0003GI-De
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:31:39 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qlEiW-0007QF-LQ
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:31:39 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:550b:0:640:d49b:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 5B77860BB4;
 Tue, 26 Sep 2023 23:31:32 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b41d::1:39] (unknown
 [2a02:6b8:b081:b41d::1:39])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id VVW88s0OreA0-8gphB8x3; Tue, 26 Sep 2023 23:31:31 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1695760291;
 bh=/7cExA5nyrsD7NZbeEvU88rSKIhFYUbb+7YLUYVUpxU=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=iFtn41P0oOHet5LzEzr7LuzBW+EZiR6fbA6U0NXU6XqCXAXf7Ms3ccpN50rPhNtI5
 surXmrbLVvTNy+g6fEjjB1rPvsotm4sLa2ki+ZVEmKfW0PI/83Orax8qdImMihUsgx
 fSdssUqssApfBLW5nC921YMn5NLHl5b5kIlCHxpk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <2e896594-486e-feb8-f52a-70a229eeaa97@yandex-team.ru>
Date: Tue, 26 Sep 2023 23:31:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] i386/a-b-bootblock: factor test memory addresses out
 into constants
Content-Language: en-US
To: Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Juan Quintela <quintela@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 qemu-devel@nongnu.org, yc-core@yandex-team.ru
References: <20230907192944.1609099-1-d-tatianin@yandex-team.ru>
 <20230907192944.1609099-2-d-tatianin@yandex-team.ru>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230907192944.1609099-2-d-tatianin@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
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

On 07.09.23 22:29, Daniil Tatianin wrote:
> So that we have less magic numbers to deal with. This also allows us to
> reuse these in the following commits.
> 
> Signed-off-by: Daniil Tatianin<d-tatianin@yandex-team.ru>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir


