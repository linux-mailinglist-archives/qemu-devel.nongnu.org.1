Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 419D577CE9A
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 17:00:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVvWR-0008MJ-EW; Tue, 15 Aug 2023 10:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qVvW3-0008Im-Tw
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 10:59:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qVvW1-00086D-HO
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 10:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692111560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FR+A2kM4YKEqCod6Bmurnr5AUhyuxvt/uCwKE32NZYQ=;
 b=YdtXKVFNLpHdsbOKlEJaKwkYehprJKxbNN9OK5HErpqoOb+2A3OXV66Q/SL/dd5XE9aVBG
 PbElaOiN+fqTE1b619CoU22IzMdZAWs5kksuG+aOK4cW58/q550OcR7u6hplFymccFjXs0
 vAFgL08mvWQmWM0ngMzr6i9DYApwdUU=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-ydKK8Cl7NQ2FV60Z_ec5jw-1; Tue, 15 Aug 2023 10:59:17 -0400
X-MC-Unique: ydKK8Cl7NQ2FV60Z_ec5jw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E39F5380671C;
 Tue, 15 Aug 2023 14:59:16 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3497E2026D76;
 Tue, 15 Aug 2023 14:59:15 +0000 (UTC)
Date: Tue, 15 Aug 2023 16:59:14 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH 2/5] qemu-nbd: fix regression with qemu-nbd --fork run
 over ssh
Message-ID: <ZNuSwoWbWSEXmUOL@redhat.com>
References: <20230717145544.194786-1-den@openvz.org>
 <20230717145544.194786-3-den@openvz.org>
 <ZNo20bIZCRjypsIN@redhat.com>
 <df0b3034-e289-61c4-ed11-f3dd53fe66c6@virtuozzo.com>
 <f382936f-31f6-db4b-5d14-308820537b31@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f382936f-31f6-db4b-5d14-308820537b31@virtuozzo.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.04,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 15.08.2023 um 14:17 hat Denis V. Lunev geschrieben:
> Hi!
> 
> Small side note.
> 
> I am 100% sure that I have run this set of tests and
> there was no fault. I have re-run them and once
> again has not get the fault :-)
> 
> The reason for that is quite interesting:
> * the test does not start due to the absence of the
>   'certool' utility from gnutls
> 
> This brings the very important question.
> 
> Should we *FAIL* when important utility is missed
> or skip? I believe that our goal is to fail to avoid such
> cases.
> 
> What do you think?

In general I think it makes sense that FAIL means that the test could
run as expected, but we got an unexpected result (i.e. this is likely a
QEMU bug), and SKIP means that the test couldn't meaningfully be
performed on the host system.

Making more things hard dependencies for the test would mean that it's
harder to miss an instance like this, but it would also make it harder
to run the test suite on a system that doesn't have the dependencies
available (and you might not even have root privileges to install them).

I think I'd leave things as they are now, but recommend that you
occasionally check the tests reported as "not run" to see if you could
easily provide the thing they would need.

Kevin


