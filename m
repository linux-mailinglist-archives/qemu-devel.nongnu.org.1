Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BD0896408
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Apr 2024 07:31:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrtCq-0004p0-OU; Wed, 03 Apr 2024 01:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rrtCp-0004nJ-DT
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 01:30:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rrtCn-000114-Qf
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 01:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712122236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aqE2J08HyML7bB1/UcCq3W5ofaiYc2xqfVeRT/NR6KM=;
 b=IY8UzeMe220baBBG7spQOnew59lYuRFvPpL6gznEi9M5atS+Sca+o6GlltInc7SQvVV7zW
 pm/VE2OdK145bPbDAP9PbOOoE9kZ0jFSlDDhKNeMaKqP3ZJYxUot+eGCivthlkjkXKT1oG
 Nc5R2sUj6gVG7pP19k6F1jdbUjb6hAU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-1rMWmVGzMdunzcymyGs7mg-1; Wed, 03 Apr 2024 01:30:35 -0400
X-MC-Unique: 1rMWmVGzMdunzcymyGs7mg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A8A6101A532;
 Wed,  3 Apr 2024 05:30:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A960200A386;
 Wed,  3 Apr 2024 05:30:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5AD3A21E66C8; Wed,  3 Apr 2024 07:30:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Justinien Bouron <justinien.bouron@gmail.com>
Cc: Eric Blake <eblake@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Gerd Hoffmann <kraxel@redhat.com>,  =?utf-8?Q?Mar?=
 =?utf-8?Q?c-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  qemu-devel@nongnu.org
Subject: Re: [PATCH v2] input-linux: Add option to not grab a device upon
 guest startup
In-Reply-To: <874jcyhlpp.fsf@pond.sub.org> (Markus Armbruster's message of
 "Fri, 22 Mar 2024 06:36:18 +0100")
References: <20240322034311.2980970-1-justinien.bouron@gmail.com>
 <874jcyhlpp.fsf@pond.sub.org>
Date: Wed, 03 Apr 2024 07:30:29 +0200
Message-ID: <87bk6rnhca.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Markus Armbruster <armbru@redhat.com> writes:

> Justinien Bouron <justinien.bouron@gmail.com> writes:
>
>> Depending on your use-case, it might be inconvenient to have qemu grab
>> the input device from the host immediately upon starting the guest.
>>
>> Added a new bool option to input-linux: grab-on-startup. If true, the
>> device is grabbed as soon as the guest is started, otherwise it is not
>> grabbed until the toggle combination is entered. To avoid breaking
>> existing setups, the default value of grab-on-startup is true, i.e. same
>> behaviour as before this change.
>>
>> Signed-off-by: Justinien Bouron <justinien.bouron@gmail.com>
>
> QAPI schema
> Acked-by: Markus Armbruster <armbru@redhat.com>

Missed one little thing: the doc comment needs a (since 9.1).


