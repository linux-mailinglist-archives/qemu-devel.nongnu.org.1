Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F56A29B5B
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Feb 2025 21:44:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfmFS-0005h4-U7; Wed, 05 Feb 2025 15:43:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tfmFQ-0005g5-CB
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 15:43:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tfmFO-0007sF-GH
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 15:43:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738788225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sT5YAwxkfBYyrwr10jS7PKQ+JRg4tqqbeeEkdGGf69w=;
 b=KqlsMcuq1hyysA+4ZH/hyvP+TwHbWvjmgpITtNRa+aom/YQnuxorRnqPOwbT9ZAvfPh/b+
 iVnHWGUTuAXu3+MTx8UfJJF6qyE9k4rrxadKw62/NIiVeJ7iPjrBemQ/GmE4IW04JH8tGR
 n/j7weBL9pEBQgZvROMEwebqJZVODvk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-EHhKK9d6PqyvswwKBOP4lw-1; Wed,
 05 Feb 2025 15:43:42 -0500
X-MC-Unique: EHhKK9d6PqyvswwKBOP4lw-1
X-Mimecast-MFC-AGG-ID: EHhKK9d6PqyvswwKBOP4lw
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 08DE2195608B; Wed,  5 Feb 2025 20:43:41 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.50])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D9A511800265; Wed,  5 Feb 2025 20:43:37 +0000 (UTC)
Date: Wed, 5 Feb 2025 14:43:35 -0600
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, stefanha@redhat.com, 
 pkrempa@redhat.com, peterx@redhat.com, farosas@suse.de, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 13/16] nbd/server: Support inactive nodes
Message-ID: <gpa4pwf6su3yj3rgwgcbjov7bbhudlda2ksp3qwwqjdxjgtpwe@h65cxz27osj7>
References: <20250204211407.381505-1-kwolf@redhat.com>
 <20250204211407.381505-14-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204211407.381505-14-kwolf@redhat.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Feb 04, 2025 at 10:14:04PM +0100, Kevin Wolf wrote:
> In order to support running an NBD export on inactive nodes, we must
> make sure to return errors for any operations that aren't allowed on
> inactive nodes. Reads are the only operation we know we need for
> inactive images, so to err on the side of caution, return errors for
> everything else, even if some operations could possibly be okay.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  nbd/server.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


