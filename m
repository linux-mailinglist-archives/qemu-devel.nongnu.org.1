Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A750B7A0638
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 15:37:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgmV5-00069D-4Q; Thu, 14 Sep 2023 09:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qgmV2-00061I-SH
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 09:35:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qgmUr-00044V-LS
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 09:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694698503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q6NieRmzf9v1QgqU8g0gm69I6eXYoNcoBX7OD/IWudE=;
 b=ahOyfVHQ3uES4XzbRlFeClGvmM1qobhpcRNBVd71wfUJubMG5L1GQmY1sSBUME+/hPxWIR
 hPnKpIVSsJQyu39kiUqsHwhS/pCF+mOBEM9Oc2xihisFQYhE+VBt9vVYanyk/vN80Cmx3P
 uPvUlhAQMP1rykjb2nwTOABQUfhutnA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-CfDJ0UTxP7y21zv4KOGnuA-1; Thu, 14 Sep 2023 09:35:00 -0400
X-MC-Unique: CfDJ0UTxP7y21zv4KOGnuA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D39E805B29;
 Thu, 14 Sep 2023 13:34:58 +0000 (UTC)
Received: from redhat.com (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2472A10F1BE7;
 Thu, 14 Sep 2023 13:34:57 +0000 (UTC)
Date: Thu, 14 Sep 2023 15:34:55 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 fam@euphon.net, eblake@redhat.com, vsementsov@yandex-team.ru,
 den@virtuozzo.com
Subject: Re: [PATCH v3 0/2] qemu-img: map: implement support for compressed
 clusters
Message-ID: <ZQML/wSOnk1pssqi@redhat.com>
References: <20230907210226.953821-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907210226.953821-1-andrey.drobyshev@virtuozzo.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 07.09.2023 um 23:02 hat Andrey Drobyshev via geschrieben:
> v2 --> v3:
>   * Make "compressed" field mandatory, not optional;
>   * Adjust field description in qapi/block-core.json;
>   * Squash patch 3 into patch 2 so that failing tests don't break bisect;
>   * Update even more tests' outputs now that the field is mandatory.
> 
> v2: https://lists.nongnu.org/archive/html/qemu-block/2023-07/msg00106.html

Thanks, applied to the block branch.

Kevin


