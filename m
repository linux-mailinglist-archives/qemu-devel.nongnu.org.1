Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29265B53598
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Sep 2025 16:34:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwiNt-0005l1-PQ; Thu, 11 Sep 2025 10:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uwiNm-0005jj-IP
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 10:34:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uwiNg-0002Ym-JX
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 10:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757601275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PVjOpw6EoV5dG9BS6F1AQX+Z7wfboRWkzUGwOHIrDDY=;
 b=NNsXFGGhEkAT4WOScn1nPou+3KehGNcEkbZDyv0HxAtirH6dfXvolS2ggWxNU1uVyzsYVs
 QfQNDWSI5lQ/BVi2l2gL5iR99yfXl2iaXTgzuZhg0o5FeeXLADYULyX5MJUkNfxno7zJdX
 JxYf7B6HHVhSgzIuNmYlgzry1RPkPI4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-EFhPPiVWNKydRxiWh1zNyw-1; Thu,
 11 Sep 2025 10:34:32 -0400
X-MC-Unique: EFhPPiVWNKydRxiWh1zNyw-1
X-Mimecast-MFC-AGG-ID: EFhPPiVWNKydRxiWh1zNyw_1757601271
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C24141800447; Thu, 11 Sep 2025 14:34:30 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.148])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1ABE519560B1; Thu, 11 Sep 2025 14:34:26 +0000 (UTC)
Date: Thu, 11 Sep 2025 16:34:22 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Hanna Czenczek <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] tests/qemu-iotests: Mark the 'inactive-node-nbd' as
 unsupported with -luks
Message-ID: <aMLd7iqM9SBrF33x@redhat.com>
References: <20250911142922.222365-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911142922.222365-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 11.09.2025 um 16:29 hat Thomas Huth geschrieben:
> From: Thomas Huth <thuth@redhat.com>
> 
> When running "./check -luks inactive-node-nbd", the test currently fails
> because QEMU terminates immediately. The reason can be seen with the
> "-p" parameter of the "check" script:
> 
>  qemu-system-x86_64: -blockdev luks,file=disk-file,node-name=disk-fmt,active=off:
>   Parameter 'key-secret' is required for cipher
> 
> Quoting Kevin: "The test case just isn't made for luks. iotests.py has
> special code for luks in VM.add_drive(), but not in VM.add_blockdev()."
> 
> Thus let's mark it as unsupported on luks to avoid the failure.
> 
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Thanks, applied to the block branch.

Kevin


