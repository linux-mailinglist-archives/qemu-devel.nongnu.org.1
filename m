Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AEED67970AE
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 10:18:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeADP-0004S7-OP; Thu, 07 Sep 2023 04:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qeADN-0004Ru-RK
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:18:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qeADL-000527-It
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694074682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IIMhwAEcLiMmiwvotymR25h4RZPuHS1DGdJ3XoEqqLE=;
 b=R2i5/eD4wEh9Bngmw6NAy4IQITpS3sdzgDo6budMJpFDskC/qRI0aL0YD32gcNVSPbQhzh
 0t9TMn9T6gKaoCoBlGk4iFvLGWSP0y67ITtAo72Ot83IK6QbeQ0LTnNsEGKXyUzW5NplVY
 FVg39FL9EswjOPY2a6/7/bsqswAIn98=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-8gNqr5-gMxyT3qLIgtTEbA-1; Thu, 07 Sep 2023 04:17:59 -0400
X-MC-Unique: 8gNqr5-gMxyT3qLIgtTEbA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E901C181792E;
 Thu,  7 Sep 2023 08:17:58 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5879740ED773;
 Thu,  7 Sep 2023 08:17:58 +0000 (UTC)
Date: Thu, 7 Sep 2023 10:17:57 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PULL 00/14] Block layer patches
Message-ID: <ZPmHNTsXLyvXiahx@redhat.com>
References: <20230904143643.259916-1-kwolf@redhat.com>
 <CAJSP0QV+aADrdBGJD1LyWxeKtFAprK8=mMeDCt-F5_1qx0KYVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJSP0QV+aADrdBGJD1LyWxeKtFAprK8=mMeDCt-F5_1qx0KYVg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Am 06.09.2023 um 17:13 hat Stefan Hajnoczi geschrieben:
> test-bdrv-drain is failing. I think my coroutine wrapper patch might
> be necessary:
> https://gitlab.com/qemu-project/qemu/-/jobs/5029372308#L4907
> 
> I have dropped this patch series for the time being. Feel free to
> remove my patches and send a new revision.
> 
> I will debug the test-bdrv-drain issue.

Hm, I can't reproduce it. And even in CI only seems to have happened in
this one job (ubuntu-20.04-s390x-all).

If you think that it's caused by your patches, I can drop them for v2.

Kevin


