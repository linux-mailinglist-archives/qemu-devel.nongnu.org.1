Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4F0826ECD
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 13:48:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMp2l-0007Po-SQ; Mon, 08 Jan 2024 07:47:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rMp2j-0007KR-GN
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 07:47:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rMp2h-00021e-6j
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 07:47:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704718064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jr5JuF/OGoDeYjv4Tduegh0C4DsTaoukrOdt39zcDlo=;
 b=QM8OSdtWbFRVSWPaykhtV2k4y73tLYibiJME7XDT3S0f5xfjn5LFw4OsXXWG1+SeIY1Q+o
 PimeWHk5TwhAXmbDmC8mPhubl6vxsdUgQyxCGzT+zA0ep2RH32vrADbjyyY0dydfqMVScn
 WGBsG4G8t8iJTql9HfOWd7aS897AgW4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-iimRKa7DOICJNt4JWM-LOQ-1; Mon,
 08 Jan 2024 07:47:41 -0500
X-MC-Unique: iimRKa7DOICJNt4JWM-LOQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC61E1C2B66E;
 Mon,  8 Jan 2024 12:47:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.71])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 96CC9492BC7;
 Mon,  8 Jan 2024 12:47:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7909321E6740; Mon,  8 Jan 2024 13:47:39 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Steve Sistare <steven.sistare@oracle.com>,  qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,  Thomas Huth <thuth@redhat.com>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Leonardo Bras <leobras@redhat.com>,  Anthony PERARD
 <anthony.perard@citrix.com>,  Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>,  Stefano Stabellini
 <sstabellini@kernel.org>,  Paul Durrant <paul@xen.org>,  Eric Blake
 <eblake@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH V9 00/12] fix migration of suspended runstate
In-Reply-To: <ZZY2FFq3-CGFbGPN@x1n> (Peter Xu's message of "Thu, 4 Jan 2024
 12:37:40 +0800")
References: <1704312341-66640-1-git-send-email-steven.sistare@oracle.com>
 <ZZY2FFq3-CGFbGPN@x1n>
Date: Mon, 08 Jan 2024 13:47:39 +0100
Message-ID: <87a5pgt2j8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> On Wed, Jan 03, 2024 at 12:05:29PM -0800, Steve Sistare wrote:
>> Migration of a guest in the suspended runstate is broken.  The incoming
>> migration code automatically tries to wake the guest, which is wrong;
>> the guest should end migration in the same runstate it started.  Further,
>> after saving a snapshot in the suspended state and loading it, the vm_start
>> fails.  The runstate is RUNNING, but the guest is not.
>> 
>> See the commit messages for the details.
>
> I was planning to wait for an ack from Markus, but I noticed Markus will
> only be back next week.  So I queued it for now, and we can work on top
> just in case.

Merge into master in commit c8193acc078e297fd46b6229e02b819b65c6702e.

I had a look at the QAPI schema changes [PATCH 02].  They look good to
me now.  Thanks!


