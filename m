Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 373AB7FFB3A
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 20:26:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8mfA-000651-SL; Thu, 30 Nov 2023 14:25:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1r8mf8-00063f-RZ
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 14:25:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1r8mf7-0003h1-0b
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 14:25:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701372324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7XiaLtDyU29CSmXeSwtmjzPgm0kqdCqhi5x7bOkyqpg=;
 b=e1AamZZJf5MsX+37Vk8/OEctvlNwFxZ2TcDD0LlDsGW/jK4MCW0H8TX24sXxC9mAEtYSzG
 Sbz+fXZhYpDkPe93b6gLl4wW8JVHzjdVzp3rzYPEYEdC/hc09oczjz6VyLPXDiNGhHMGbA
 ouLSkcvQUOXIExhnsWEq32zBvYFhFAk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-XCzFcOqaNLKo4dYsnH-k4w-1; Thu, 30 Nov 2023 14:25:21 -0500
X-MC-Unique: XCzFcOqaNLKo4dYsnH-k4w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC865811E86;
 Thu, 30 Nov 2023 19:25:20 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.190])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9033B40C6EB9;
 Thu, 30 Nov 2023 19:25:19 +0000 (UTC)
Date: Thu, 30 Nov 2023 13:25:18 -0600
From: Eric Blake <eblake@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v2 2/2] block: stream: Allow users to request only format
 driver names in backing file format
Message-ID: <4dgtqbmcno7d5mapg27od3ubjl7uqhm5hjxqtro423n4r27zoq@s33vu5a7lxow>
References: <cover.1701360249.git.pkrempa@redhat.com>
 <13ca32193b29046fa5a0d046f4d45a902eecfb4b.1701360249.git.pkrempa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13ca32193b29046fa5a0d046f4d45a902eecfb4b.1701360249.git.pkrempa@redhat.com>
User-Agent: NeoMutt/20231103
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Nov 30, 2023 at 05:06:04PM +0100, Peter Krempa wrote:
> Introduce a new flag 'backing_file_format_no_protocol' for the
> block-commit QMP command which instructs the internals to use 'raw'
> instead of the protocol driver in case when a image is used without a
> dummy 'raw' wrapper.

Same long name as in 1/2; if we come up with a nicer name (my proposal
in 1/2 was backing-mask-protocol; but I'm open to others), we should
keep the two patches consistent.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


