Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 341B380CF9E
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 16:34:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCiHP-0002WB-1T; Mon, 11 Dec 2023 10:33:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rCiHL-0002Vd-Py
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 10:33:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rCiHI-0006Zi-EA
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 10:33:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702308782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zw/PBdoLMOt0K4Rqk9wgpIWCKyzooKe0XsbAvh7q8+Y=;
 b=CMHJKnI/Znz+FeiDl+nZBvh5j2/oN4am5HhENP3wF2dnjmC7Kla41THXsbvwaCGAwjrJq5
 lYlaxhoZv/TY3weiFXJvH6oumGahdMweX+G8T0/mocnGpX4dfRxsCFCD08uz7652LP9mxO
 hk7iMs/HL2trkf36lOtQoMOulixtnec=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-184-LBOL-iRUPs2Y6tfwDULI_w-1; Mon,
 11 Dec 2023 10:32:08 -0500
X-MC-Unique: LBOL-iRUPs2Y6tfwDULI_w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A8A64285CC3B;
 Mon, 11 Dec 2023 15:32:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 817D43C25;
 Mon, 11 Dec 2023 15:32:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7A82621E6740; Mon, 11 Dec 2023 16:32:06 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,  qemu-devel@nongnu.org,  Michal
 Privoznik <mprivozn@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  qemu-block@nongnu.org,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  "Michael
 S. Tsirkin" <mst@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,
 aliang@redhat.com,  qinwang@redhat.com
Subject: Re: [PATCH v2 1/2] qdev: add IOThreadVirtQueueMappingList property
 type
In-Reply-To: <ZXcVCMU7hYZ6jhp3@redhat.com> (Kevin Wolf's message of "Mon, 11
 Dec 2023 14:56:24 +0100")
References: <20230918161604.1400051-1-stefanha@redhat.com>
 <20230918161604.1400051-2-stefanha@redhat.com>
 <ZXcVCMU7hYZ6jhp3@redhat.com>
Date: Mon, 11 Dec 2023 16:32:06 +0100
Message-ID: <87msugah6x.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Kevin Wolf <kwolf@redhat.com> writes:

> Am 18.09.2023 um 18:16 hat Stefan Hajnoczi geschrieben:
>> virtio-blk and virtio-scsi devices will need a way to specify the
>> mapping between IOThreads and virtqueues. At the moment all virtqueues
>> are assigned to a single IOThread or the main loop. This single thread
>> can be a CPU bottleneck, so it is necessary to allow finer-grained
>> assignment to spread the load.
>> 
>> Introduce DEFINE_PROP_IOTHREAD_VQ_MAPPING_LIST() so devices can take a
>> parameter that maps virtqueues to IOThreads. The command-line syntax for
>> this new property is as follows:
>> 
>>   --device '{"driver":"foo","iothread-vq-mapping":[{"iothread":"iothread0","vqs":[0,1,2]},...]}'
>> 
>> IOThreads are specified by name and virtqueues are specified by 0-based
>> index.
>> 
>> It will be common to simply assign virtqueues round-robin across a set
>> of IOThreads. A convenient syntax that does not require specifying
>> individual virtqueue indices is available:
>> 
>>   --device '{"driver":"foo","iothread-vq-mapping":[{"iothread":"iothread0"},{"iothread":"iothread1"},...]}'
>> 
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>
> When testing this, Qing Wang noticed that "info qtree" crashes. This is
> because the string output visitor doesn't support structs. I suppose
> IOThreadVirtQueueMapping is the first struct type that is used in a qdev
> property type.
>
> So we'll probably have to add some kind of struct support to the string
> output visitor before we can apply this. Even if it's as stupid as just
> printing "<struct IOThreadVirtQueueMapping>" without actually displaying
> the value.

The string visitors have been nothing but trouble.

For input, we can now use keyval_parse() and the QObject input visitor
instead.  Comes with restrictions, but I'd argue it's a more solid base
than the string input visitor.

Perhaps we can do something similar for output: create a suitable
formatter for use it with the QObject output visitor, replacing the
string output visitor.


