Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D21A478FC2F
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 13:16:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc281-00035O-8I; Fri, 01 Sep 2023 07:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qc27z-000342-BI
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 07:15:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qc27x-0000IO-Bi
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 07:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693566948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nLoCC1gKCRI4CkuD+rin304Sm75QZLSCdwSMcz14oXE=;
 b=UN2kyOoz5xNrpGvhexEmSLC1ojmfPPQu6HHX5v6CX5720LEGUwV2Kdd6DfDaKOMPs7plRR
 RRWJ6REqy2EwXy5RJan7T92re90XL8dAZyznLcmezbrrB0zlIa8eMplt8BcIHvFh7uERzg
 CIuZlo3rdripGjZy0bHLF1/M0wP4NIE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-279-lgzgBACMPMyUU0wW-wKfng-1; Fri, 01 Sep 2023 07:15:43 -0400
X-MC-Unique: lgzgBACMPMyUU0wW-wKfng-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB57B1C18C65;
 Fri,  1 Sep 2023 11:15:42 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.166])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4135049310F;
 Fri,  1 Sep 2023 11:15:41 +0000 (UTC)
Date: Fri, 1 Sep 2023 13:15:40 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Dmitry Frolov <frolov@swemel.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, fam@euphon.net,
 hreitz@redhat.com, sdl.qemu@linuxtesting.org
Subject: Re: [PATCH] fix bdrv_open_child return value check
Message-ID: <ZPHH3N8RiMxNa13F@redhat.com>
References: <20230831125926.796205-1-frolov@swemel.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831125926.796205-1-frolov@swemel.ru>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

Am 31.08.2023 um 14:59 hat Dmitry Frolov geschrieben:
> bdrv_open_child() may return NULL.
> Usually return value is checked for this function.
> Check for return value is more reliable.
> 
> Fixes: 24bc15d1f6 ("vmdk: Use BdrvChild instead of BDS for references to extents")
> 
> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>

Did you actually see some failure because of this? If so, what is the
specific case that failed?

Or is this just cleanup based on code inspection?

Kevin


