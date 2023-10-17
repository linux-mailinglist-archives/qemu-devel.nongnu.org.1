Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 455507CCD89
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 22:09:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsqNG-0002Kp-GW; Tue, 17 Oct 2023 16:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qsqNF-0002KW-5N
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 16:09:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qsqNB-0005iM-Dc
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 16:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697573339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7kZN98mI6gl1iVxiMHvknfAWXs/ZHuWM7BPPQlnUDt4=;
 b=BBjwVHf3X7OdirFoI9iQeigBUWpWhnSv2Djfrv0Mx9Uj7euxyQuA8wWlgzL7bCT0XZkyIO
 okTmB83o2YHMuEPOxyPDS67aYXLu2VyLOAvs/h7nkf4N/bSeAN76WkEnuKYmnlP+Jh4hjW
 FztpONiVwtTUdoN2I3fAI22glF5HCJk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-351-jTKTau-dMfWqSn9L2VHX2g-1; Tue, 17 Oct 2023 16:08:57 -0400
X-MC-Unique: jTKTau-dMfWqSn9L2VHX2g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2FAF629AB3E6;
 Tue, 17 Oct 2023 20:08:57 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 23316492BEE;
 Tue, 17 Oct 2023 20:08:55 +0000 (UTC)
Date: Tue, 17 Oct 2023 22:08:54 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 eblake@redhat.com, den@virtuozzo.com
Subject: Re: [PATCH v3 0/8] qemu-img: rebase: add compression support
Message-ID: <ZS7p1jZ0EeP3IOwq@redhat.com>
References: <20230919165804.439110-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919165804.439110-1-andrey.drobyshev@virtuozzo.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 19.09.2023 um 18:57 hat Andrey Drobyshev geschrieben:
> v2 --> v3:
>  * Patch 3/8: fixed logic in the if statement, so that we align on blk
>    when blk_old_backing == NULL;
>  * Patch 4/8: comment fix;
>  * Patch 5/8: comment fix; dropped redundant "if (blk_new_backing)"
>    statements.
> 
> v2: https://lists.nongnu.org/archive/html/qemu-block/2023-09/msg00448.html
> 
> Andrey Drobyshev (8):
>   qemu-img: rebase: stop when reaching EOF of old backing file
>   qemu-iotests: 024: add rebasing test case for overlay_size >
>     backing_size
>   qemu-img: rebase: use backing files' BlockBackend for buffer alignment
>   qemu-img: add chunk size parameter to compare_buffers()
>   qemu-img: rebase: avoid unnecessary COW operations
>   iotests/{024, 271}: add testcases for qemu-img rebase
>   qemu-img: add compression option to rebase subcommand
>   iotests: add tests for "qemu-img rebase" with compression

Thanks, applied to the block branch.

Kevin


