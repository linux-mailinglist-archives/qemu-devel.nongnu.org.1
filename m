Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CA67B7E44
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 13:34:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo08T-0005qe-9L; Wed, 04 Oct 2023 07:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qo08Q-0005qH-NE
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 07:33:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qo08P-0006LB-8N
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 07:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696419224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UPb3FJDcewBGqcPmYkSjLtNPYLKficWWn5541vuGqrs=;
 b=PPhG61ajyw5awxaHwtls7J6EB7IDhEzDCOb2xL5fUv3mMeRASak9mDEicHXM+vsRn0zSUb
 cVNjNb1g+qctUaImbOO9zC2Nn+DxaUViGNZzfd3lVKEjQkynTh8k8Q//4GK2Iyr6Q3NMwW
 GRtLeCrIW3rC4qogBaVxN+DKRTdeK3s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-yGsIjcDJOi6_YVc80Y20RA-1; Wed, 04 Oct 2023 07:33:38 -0400
X-MC-Unique: yGsIjcDJOi6_YVc80Y20RA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C055381163A;
 Wed,  4 Oct 2023 11:33:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9DD8D47CD2;
 Wed,  4 Oct 2023 11:33:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9707821E6904; Wed,  4 Oct 2023 13:33:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH] hw/virtio/virtio-pci: Avoid compiler warning with -Wshadow
References: <20231004075536.48219-1-thuth@redhat.com>
 <87bkdeiri9.fsf@pond.sub.org>
 <c3e2e15d-f4dd-a5bd-eab7-f4db9f93626e@redhat.com>
Date: Wed, 04 Oct 2023 13:33:36 +0200
In-Reply-To: <c3e2e15d-f4dd-a5bd-eab7-f4db9f93626e@redhat.com> (Thomas Huth's
 message of "Wed, 4 Oct 2023 13:08:26 +0200")
Message-ID: <87il7mfwq7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Thomas Huth <thuth@redhat.com> writes:

> On 04/10/2023 12.58, Markus Armbruster wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>> 
>>> "len" is used as parameter of the function virtio_write_config()
>>> and as a local variable, so this causes a compiler warning
>>> when compiling with "-Wshadow" and can be confusing for the reader.
>>> Rename the local variable to "caplen" to avoid this problem.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>

[...]

>> I see the same warning in virtio_read_config().  Care to patch that,
>> too?
>
> Patch is already on the list:
> https://lore.kernel.org/qemu-devel/20231004095302.99037-1-thuth@redhat.com/

Awesome, thanks!


