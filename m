Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5457D5A40
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 20:14:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvLv5-0007kI-St; Tue, 24 Oct 2023 14:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qvLv1-0007WV-4I
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 14:14:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qvLut-0005kT-Mz
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 14:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698171248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rmPJ9Uh1bDf6LR646VZJEumDFg+BcPrqKG3uIudyTeQ=;
 b=a4pcoquH/IY1vxnmNAnCm3WIp9gMJQuHpwSquvUxOH/gHH1OCeP/fi5xqKOTVj/IP09FhM
 3679ALOiuVr6QIdl8saCjEpjqkTBPSLTwoos9VwprHGNPIv/bvHfSJecSDSSKdhihXW6+7
 BmSyTIQpJNqcjjyhfJJMOO16kwdVJqQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-8YbPv2tAPeGocaCOHXzx4g-1; Tue,
 24 Oct 2023 14:14:04 -0400
X-MC-Unique: 8YbPv2tAPeGocaCOHXzx4g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68E23381459F;
 Tue, 24 Oct 2023 18:14:04 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BD9982166B27;
 Tue, 24 Oct 2023 18:14:02 +0000 (UTC)
Date: Tue, 24 Oct 2023 13:14:01 -0500
From: Eric Blake <eblake@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 02/12] qemu_file: Use a stat64 for qemu_file_transferred
Message-ID: <umpbv4qghflhubmfetanz6glvsgadn3yuybcarkyq6v2hd5awe@iylnmrsyqrv2>
References: <20231024151042.90349-1-quintela@redhat.com>
 <20231024151042.90349-3-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024151042.90349-3-quintela@redhat.com>
User-Agent: NeoMutt/20231006
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
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

On Tue, Oct 24, 2023 at 05:10:32PM +0200, Juan Quintela wrote:
> This way we can read it from any thread.
> I checked that it gives the same value than the current one.  We never

s/than/as/

> use to qemu_files at the same time.

s/to/two/

> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/migration-stats.h | 4 ++++
>  migration/qemu-file.c       | 5 +++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


