Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDDAAF123A
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Jul 2025 12:46:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWuxW-0007LA-8A; Wed, 02 Jul 2025 06:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uWuxS-0007Ev-4o
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:44:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uWuxN-0001Z0-Nu
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751453086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=txvlJmZIFjbd0bn3fL4OBQ8bkBiLcKEco6K0PcJcbiE=;
 b=ZzkldKA8cB91keOsBQhbHooVfnj/Kxmwxl4gRRaHvt9q2+tsAd9L15DOsUOhtKTCNVbZIa
 pq0GGFxqDCroZaHl6GGmmpKrrU+UO1IQxiNb0rjtwgGLTjrHPN6vjLxK2XrCI1OW6ENhbL
 qDOmCzrdrlKMdvofwRBrilEn9H/QwIA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-knFmIJpgM2GezJgUubIQDQ-1; Wed,
 02 Jul 2025 06:44:43 -0400
X-MC-Unique: knFmIJpgM2GezJgUubIQDQ-1
X-Mimecast-MFC-AGG-ID: knFmIJpgM2GezJgUubIQDQ_1751453082
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80B621944AA5; Wed,  2 Jul 2025 10:44:42 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.171])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22DCE30001B9; Wed,  2 Jul 2025 10:44:39 +0000 (UTC)
Date: Wed, 2 Jul 2025 12:44:37 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 eblake@redhat.com, armbru@redhat.com
Subject: Re: [PATCH v2] block: include child references in block device info
Message-ID: <aGUNldBcH_MkCxpi@redhat.com>
References: <20250701162124.1313813-1-f.ebner@proxmox.com>
 <aGT4SoV76ViyN6XS@redhat.com>
 <948aea4b-b2bb-4061-b472-073f402a4584@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <948aea4b-b2bb-4061-b472-073f402a4584@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 02.07.2025 um 11:39 hat Fiona Ebner geschrieben:
> Am 02.07.25 um 11:13 schrieb Kevin Wolf:
> > Am 01.07.2025 um 18:21 hat Fiona Ebner geschrieben:
> >> +##
> >> +# @BlockdevChild:
> >> +#
> >> +# @child: The name of the child, for example 'file' or 'backing'.
> >> +#
> >> +# @node-name: The name of the child's block driver node.
> >> +#
> >> +# Since: 10.1
> >> +##
> >> +{ 'struct': 'BlockdevChild',
> >> +  'data': { 'child': 'str',
> >> +            '*node-name': 'str' } }
> > 
> > Is node-name really optional? I don't think we have nodes without a node
> > name any more, do we?
> 
> I'm not aware of any, but @node-name in @BlockDeviceInfo is marked as
> optional too, so I went with that.
> 
> Looking at the git history, missing node-names are auto-generated since
> 15489c769b ("block: auto-generated node-names") or v2.5. The QAPI schema
> says @node-name was added before that in v2.0. Should it be made
> non-optional in @BlockDeviceInfo too?

Yes, I think this can be done.

Markus, a question about the future direction with such changes:
Currently, we only care about JSON level compatibility. In the future,
if we ever get native bindings for some programming languages (is anyone
still working on one?), I suppose a switch from something like
Option<String> to String could be considered incompatible. Would we
want to guarantee compatibility at that level then, or would
applications using the bindings just have to be updated?

Kevin


