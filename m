Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 504F97CF0A5
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 09:06:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtN69-0005Au-Ed; Thu, 19 Oct 2023 03:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtN65-0005AQ-7E
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 03:05:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtN62-0007BJ-6B
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 03:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697699129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yoDm+2FEpRFsb1REVhaEoYV9XjaS8XO15H9ZTXWn18Q=;
 b=IEnHSALrN+wlVNmZHNbAGQ5rPVJS5adnJGZgXSbTEH0U00RzO32q72S70cG+42MO1yoxth
 ZNB22RFnl6ruw1mjt7vn4Usw64cXrXEQLlPMXR+waQ0gbuJVoEgknVI6hAjQzoo6a2/OMF
 lLbTHQDxMGp4F3Q2a6qak0iCOU3yfJg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-iiKb4GunND61fYqcom10Sg-1; Thu, 19 Oct 2023 03:05:14 -0400
X-MC-Unique: iiKb4GunND61fYqcom10Sg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E50C23827977;
 Thu, 19 Oct 2023 07:05:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C298B25C8;
 Thu, 19 Oct 2023 07:05:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BF0BA21E6A1F; Thu, 19 Oct 2023 09:05:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  qemu-block@nongnu.org,
 qemu-devel@nongnu.org,  eblake@redhat.com,  eduardo@habkost.net,
 pbonzini@redhat.com,  hreitz@redhat.com,  kwolf@redhat.com,
 raphael.norwitz@nutanix.com,  yc-core@yandex-team.ru,
 den-plotnikov@yandex-team.ru,  daniil.tatianin@yandex.ru
Subject: Re: [PATCH 4/4] qapi: introduce CONFIG_READ event
References: <20231006202045.1161543-5-vsementsov@yandex-team.ru>
 <87sf692t0i.fsf@pond.sub.org>
 <ae494c44-1bd6-435e-8bd8-0ec2ba9ceaa6@yandex-team.ru>
 <877cnkzasr.fsf@pond.sub.org>
 <a55e8b57-3411-4587-affd-3bc0635af4fe@yandex-team.ru>
 <878r80tdyd.fsf@pond.sub.org>
 <20231018064912-mutt-send-email-mst@kernel.org>
 <ZS+6g+vtYz9Uh6G3@redhat.com> <87o7gwp29r.fsf@pond.sub.org>
 <ZS/KhowbXegXtYxA@redhat.com> <ZS_s0RE0ES9mvFar@gallifrey>
Date: Thu, 19 Oct 2023 09:05:12 +0200
In-Reply-To: <ZS_s0RE0ES9mvFar@gallifrey> (David Alan Gilbert's message of
 "Wed, 18 Oct 2023 14:33:53 +0000")
Message-ID: <877cnjks7r.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
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

"Dr. David Alan Gilbert" <dave@treblig.org> writes:

> Using x- for events makes sense to me; the semantics of events can be
> quite subtle; often you don't find out how broken they are until you
> wire them through libvirt and up the stack; so it's not impossible
> you might need to change it - but then without the x- the semantics
> (rather than existence) of the event is carved in stone.

It is carved in stone unless feature 'unstable' is declared.  The name
gets no vote.

We may elect to name unstable QAPI things 'x-FOO' to help humans.

[...]


