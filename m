Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE2E85E1C7
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Feb 2024 16:47:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoTq-0006vw-5K; Wed, 21 Feb 2024 10:25:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcoMA-0003Rf-5z
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:17:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rci0O-0003kL-GL
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 03:31:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708504263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o5drPHodKuTZ+uPSZct+z37z0TdMnZqZ0xLXl+tTB4A=;
 b=aTf4we+u/qXfLOOM3X1jzEVXXf8HCmlQEMcyeaWnbr8D686MkOa+XhBDmsn8Fx2mP2noDZ
 4F/W/Cqo6kpWP60dqfu77DkJlO418JBHgkR2RbisQS3OIy/KCGEn7olHV3HGhIfA2UkAlj
 ThtMV+7+vxN7/9S8wyujsbTzro+5Klw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-7svEpI77NqyBo6kd6XOOcw-1; Wed,
 21 Feb 2024 03:30:54 -0500
X-MC-Unique: 7svEpI77NqyBo6kd6XOOcw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 27A9F28B6AA7;
 Wed, 21 Feb 2024 08:30:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 029821C060AF;
 Wed, 21 Feb 2024 08:30:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D66C821E66D5; Wed, 21 Feb 2024 09:30:52 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Het Gala <het.gala@nutanix.com>,  Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] qapi: Misc cleanups to migrate QAPIs
In-Reply-To: <ZdWzmbOuCVk8GZMn@x1n> (Peter Xu's message of "Wed, 21 Feb 2024
 16:26:01 +0800")
References: <20240216195659.189091-1-het.gala@nutanix.com>
 <87edd61ezt.fsf@pond.sub.org>
 <b1ce8254-24e8-487e-8da0-d8916f53fcb4@nutanix.com>
 <ZdWzmbOuCVk8GZMn@x1n>
Date: Wed, 21 Feb 2024 09:30:52 +0100
Message-ID: <87sf1mxlqb.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Peter Xu <peterx@redhat.com> writes:

> Thanks, Markus.

[...]

> Reviewed-by: Peter Xu <peterx@redhat.com>
>
> Markus, do you want us to pick it up, or let it go via qapi?

I can stick it into my next qapi PR in a few days, if you guys don't
beat me to the punch.


