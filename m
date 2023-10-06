Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D30F7BC06D
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 22:36:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qorXj-0008P9-9f; Fri, 06 Oct 2023 16:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qorXe-0008Ci-P0; Fri, 06 Oct 2023 16:35:22 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qorXQ-0000g9-Sp; Fri, 06 Oct 2023 16:35:10 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:3a8c:0:640:ec94:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 235BE60F3E;
 Fri,  6 Oct 2023 23:35:04 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b403::1:3c] (unknown
 [2a02:6b8:b081:b403::1:3c])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 3ZgUCe5OoSw0-cHyB5Bg8; Fri, 06 Oct 2023 23:35:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696624503;
 bh=D146LDVBw5c/a/eJFUdgYHMSkQQexjRjDseDM1ZzafI=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=qwGAwLEAvANZJ8Th514W6Jd+BsJ6/r5KUbDDvFR3cvVIk+grnwZSj4Cr0/sjn9aMl
 zHsxzI8DXUs4qQW/b5umiSTGtBloUOiBEvfvLiJ3DI2WI+LXXrWDEIV7TsLQCXc4QM
 kz4TZeR5HhpU58JxjKrSSDaZrW06vX/DtZ3P9p1M=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <4fe08e18-d579-47e7-9e40-389afee36d8b@yandex-team.ru>
Date: Fri, 6 Oct 2023 23:35:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] python/qmp: remove Server.wait_closed() call for
 Python 3.12
Content-Language: en-US
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-block@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20231006195243.3131140-1-jsnow@redhat.com>
 <20231006195243.3131140-3-jsnow@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20231006195243.3131140-3-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 06.10.23 22:52, John Snow wrote:
> This patch is a backport from
> https://gitlab.com/qemu-project/python-qemu-qmp/-/commit/e03a3334b6a477beb09b293708632f2c06fe9f61
> 
> According to Guido in https://github.com/python/cpython/issues/104344 ,
> this call was never meant to wait for the server to shut down - that is
> handled synchronously - but instead, this waits for all connections to
> close. Or, it would have, if it wasn't broken since it was introduced.
> 
> 3.12 fixes the bug, which now causes a hang in our code. The fix is just
> to remove the wait.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>


-- 
Best regards,
Vladimir


