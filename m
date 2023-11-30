Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5F57FF980
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 19:37:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8ltR-0003JR-Aq; Thu, 30 Nov 2023 13:36:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r8ltO-0003JB-FG
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 13:36:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r8ltD-0003E6-Au
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 13:36:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701369350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X0+XPC3vhXhD5VW7XOXmYn7jnDrexm6i7WQX23McNk0=;
 b=EWU1YGmBF8LxgaKbqs0ZMcq+RBL51N7XUaCp6iaYpiYg+T4QTRopDX6rgDCgNuL9fIokNS
 KueoEX1X/OqlFaWkBjQjqM2O/4cvPJrP+K+E6VOzbbljv03SIYvDoys9vf0juChm0HbTYA
 P8nRiZOIGm2Tw9NSSiZF+RAUimsHpjs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-NyIOyL4eOpei5_OVqzsE9w-1; Thu, 30 Nov 2023 13:35:45 -0500
X-MC-Unique: NyIOyL4eOpei5_OVqzsE9w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2CFFA185A783;
 Thu, 30 Nov 2023 18:35:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0813810EA1;
 Thu, 30 Nov 2023 18:35:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F3FA421E6A1F; Thu, 30 Nov 2023 19:35:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Het Gala <het.gala@nutanix.com>,  qemu-devel@nongnu.org,
 prerna.saxena@nutanix.com,  quintela@redhat.com,  berrange@redhat.com,
 peter.maydell@linaro.org,  farosas@suse.de
Subject: Re: [PATCH v4] migration: Plug memory leak with migration URIs
References: <20231129204301.131228-1-het.gala@nutanix.com>
 <ZWjGdg-gic-C1PA_@x1n>
Date: Thu, 30 Nov 2023 19:35:43 +0100
In-Reply-To: <ZWjGdg-gic-C1PA_@x1n> (Peter Xu's message of "Thu, 30 Nov 2023
 12:29:26 -0500")
Message-ID: <87il5j2io0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

> On Wed, Nov 29, 2023 at 08:43:01PM +0000, Het Gala wrote:
>> migrate_uri_parse() allocates memory to 'channel' if the user
>> opts for old syntax - uri, which is leaked because there is no
>> code for freeing 'channel'.
>> So, free channel to avoid memory leak in case where 'channels'
>> is empty and uri parsing is required.
>> 
>> Fixes: 5994024f ("migration: Implement MigrateChannelList to qmp migration flow")
>> Signed-off-by: Het Gala <het.gala@nutanix.com>
>> Suggested-by: Markus Armbruster <armbru@redhat.com>
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
>> @@ -533,18 +533,18 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
>>              error_setg(errp, "Channel list has more than one entries");
>>              return;
>>          }
>> -        channel = channels->value;
>> +        addr = channels->value->addr;
>>      } else if (uri) {
>>          /* caller uses the old URI syntax */
>>          if (!migrate_uri_parse(uri, &channel, errp)) {
>>              return;
>>          }
>> +        addr = channel->addr;
>>      } else {
>>          error_setg(errp, "neither 'uri' or 'channels' argument are "
>>                     "specified in 'migrate-incoming' qmp command ");
>>          return;
>>      }
>> -    addr = channel->addr;
>
> Why these "addr" lines need change?  Won't that behave the same as before?

In the first case, @channel is now null.  If we left the assignment to
@addr alone, it would crash.  Clearer now?


