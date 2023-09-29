Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E599C7B35D4
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 16:37:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmEaN-0003LS-KB; Fri, 29 Sep 2023 10:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1qmEaL-0003L8-1Z
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:35:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1qmEaI-0001Uk-5y
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695998112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qccgq1mrZMWJzRV2B3JRKMU2duSMts+MK35HId1z7Ik=;
 b=KHOQ2GshpFJ3RSNROY6/a1Gp6lAcp4S6rKQUs7zb5kbXVAgi8YpM7I3+1/wkDxWn0jVIVm
 327p2xlTdpDxw7cREykzdwIHdJzM9MYBhJbejOw3/Dz1Onxd5B8GKKw01EFsWsYiipBKkv
 rCGu2I/Mv2GGsIhTB1gyCTxuv5Ytgco=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-4_Y34zYdMmGiWVK3C8AFiQ-1; Fri, 29 Sep 2023 10:35:11 -0400
X-MC-Unique: 4_Y34zYdMmGiWVK3C8AFiQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ABEBF817056
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 14:35:06 +0000 (UTC)
Received: from localhost (unknown [10.39.193.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E8D110EE402;
 Fri, 29 Sep 2023 14:35:06 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: MAINTAINERS still leaves more files uncovered than I'd like
In-Reply-To: <734d189a-1068-a4c2-74b8-4a17346fdc47@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <87lecp6w7x.fsf@pond.sub.org> <87lecpuqui.fsf@redhat.com>
 <734d189a-1068-a4c2-74b8-4a17346fdc47@redhat.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Fri, 29 Sep 2023 16:35:04 +0200
Message-ID: <87il7tujxj.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
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

On Fri, Sep 29 2023, Thomas Huth <thuth@redhat.com> wrote:

> On 29/09/2023 14.05, Cornelia Huck wrote:
>> On Fri, Sep 29 2023, Markus Armbruster <armbru@redhat.com> wrote:
>> 
>>> Where are the remaining unmaintained files now?  Top-scoring
>>> directories, files in sub-directories not counted:
>>>
>>>      $ sed 's,/[^/]*$,/,;s,^[^/]*$,./,' unmaintained-files | sort | uniq -c | sort -nr
>>>
>>>        # directory
>> 
>> (...)
>> 
>>>       40 include/standard-headers/linux/
>> 
>> Given that these are changed via update-linux-headers.sh, we should
>> probably add
>> 
>> F: include/standard-headers/
>> 
>> to the Hosts/LINUX entry? (Some headers in standard-headers are covered
>> in individual sections, but most are not.)
>
> Sounds good, could you please send a patch?

https://lore.kernel.org/qemu-devel/20230929143012.77128-1-cohuck@redhat.com/


