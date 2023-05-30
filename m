Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8246A7157BD
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 09:57:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3uDN-0001Oe-NW; Tue, 30 May 2023 03:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q3uDH-0001OT-AZ
 for qemu-devel@nongnu.org; Tue, 30 May 2023 03:56:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q3uDE-00043U-0v
 for qemu-devel@nongnu.org; Tue, 30 May 2023 03:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685433370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eCzA3naR0xjphXPwyKjaBf7yrKHIVk3sTeexl0+087I=;
 b=e1tnfu3owFsIeWeu8qWkzUyindfZEim4NsEJ/T4THdsVM6xKcUtNPNUBLLLWREu4I4asA7
 KkJnCludTpXP0Qo1pTsdHjUXQHAPutBOK7TCB5Aqml7Gq7nHSCIRxb/IZH91N5dx5O/lUf
 AEWuDxp6Crm0CCYDy3W5/YN7TgSFFaU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-b8NF-_sQP_qkIfJCuDIIZA-1; Tue, 30 May 2023 03:56:07 -0400
X-MC-Unique: b8NF-_sQP_qkIfJCuDIIZA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 18A9A101B047;
 Tue, 30 May 2023 07:56:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E96682166B25;
 Tue, 30 May 2023 07:56:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D93CD21E692E; Tue, 30 May 2023 09:56:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org,  prerna.saxena@nutanix.com,  quintela@redhat.com,
 dgilbert@redhat.com,  pbonzini@redhat.com,  berrange@redhat.com,
 eblake@redhat.com,  manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
Subject: Re: [PATCH v5 1/9] migration: introduced 'MigrateAddress' in QAPI
 for migration wire protocol.
References: <20230519094617.7078-1-het.gala@nutanix.com>
 <20230519094617.7078-2-het.gala@nutanix.com>
 <87sfbkjow3.fsf@pond.sub.org>
 <af2e5fbe-75f5-d6dd-df8c-8894cc5b0056@nutanix.com>
 <87edmyuwzc.fsf@pond.sub.org>
 <99b3e516-2a4a-aa48-8bc2-7bb886b8db52@nutanix.com>
Date: Tue, 30 May 2023 09:56:05 +0200
In-Reply-To: <99b3e516-2a4a-aa48-8bc2-7bb886b8db52@nutanix.com> (Het Gala's
 message of "Tue, 30 May 2023 13:02:27 +0530")
Message-ID: <878rd6tfqi.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Het Gala <het.gala@nutanix.com> writes:

> On 30/05/23 12:28 pm, Markus Armbruster wrote:
>> Het Gala<het.gala@nutanix.com>  writes:
>>
>>> On 25/05/23 11:04 pm, Markus Armbruster wrote:

[...]

>>>> Aside: a more powerful type system would let us extend SocketAddress
>>>> with additional variants instead of wrapping it in a union.
>>>
>>> Markus, what do you mean by additional variants here in context of socket? Can you give a small example.
>>
>> As is, we have a nest of two unions:
>>
>> * The outer union has branches @socket, @exec, @rdma.
>>
>> * Branch @socket is the inner union, it has branches @inet, @unix, ...
>>
>> A more powerful type system would let us extend SocketAddress instead,
>> so MigrateAddress has everything SocketAddress has, plus additional
>> branches @exec, @rdma.  Naturally, the type of the discriminator also
>> needs to be extended, so that it has everything SocketAddress's
>> discriminator type has, plus additional members @exec, @rdma.
>
> Okay, so you mean something like :
>
> +# Since 8.1
> +##
> +{ 'union': 'MigrateAddress',
> +  'base': { 'transport' : 'MigrateTransport'},
> +  'discriminator': 'transport',
> +  'data': {
> +    'inet': 'InetSocketAddress',
> +    'unix': 'UnixSocketAddress',
> +    'vsock': 'VsockSocketAddress',
> +    'fd': 'str',
> +    'exec': 'MigrateExecCommand',
> +    'rdma': 'InetSocketAddress' } }
>
> Even I agree that directly leveraging this is the best option, but then wouldn't it introduce redundancy ? we would not be able to leverage socket union right in that case or am I missing something.

Yes, there's redundancy, due to QAPI's insufficient expressive power.

Is the cleaner external interface worth the (internal) redundancy, and
possibly coding complications that go with it?


