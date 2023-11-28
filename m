Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2891A7FB67E
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 11:00:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7usx-0003mB-PX; Tue, 28 Nov 2023 05:00:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r7usv-0003ly-Vq
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 05:00:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r7ust-0005im-UM
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 05:00:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701165602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xQrbTtkb8Sww9+MOXCFpxgafpDLA1QjwDhUBAA2iosE=;
 b=DC+v48aPwql7cOvNtlPg9400eiZtHavtrD3kklsMEA94xDasVrNWgsooAlYosNK3oQgwMN
 LsIATQJS72nZ+PCI4M5AhWk/gXvShD8Obr9TzeKb63DgA0ceVg3vob1qWg3PiTnOOsL4nG
 cBQyyx01daDsUkWzMSJsJjkMbN0INbI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-5ZBHJ06oNTuGpJIRqx5TGA-1; Tue,
 28 Nov 2023 05:00:01 -0500
X-MC-Unique: 5ZBHJ06oNTuGpJIRqx5TGA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B4813C0F426;
 Tue, 28 Nov 2023 10:00:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BC7D1C060AE;
 Tue, 28 Nov 2023 10:00:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 35B3E21E6A1F; Tue, 28 Nov 2023 10:59:59 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org,  prerna.saxena@nutanix.com,  quintela@redhat.com,
 berrange@redhat.com,  peter.maydell@linaro.org,  farosas@suse.de
Subject: Re: [PATCH] 'channel' and 'addr' in qmp_migrate() are not
 auto-freed. migrate_uri_parse() allocates memory which is returned to
 'channel', which is leaked because there is no code for freeing 'channel'
 or 'addr'. So, free addr and channel to avoid memory leak. 'addr' does
 shallow copying of channel->addr, hence free 'channel' itself and deep
 free contents of 'addr'
References: <20231128062520.36456-1-het.gala@nutanix.com>
 <87a5qy4aag.fsf@pond.sub.org>
 <db753099-b8a4-4057-9459-5174ff81ddee@nutanix.com>
Date: Tue, 28 Nov 2023 10:59:59 +0100
In-Reply-To: <db753099-b8a4-4057-9459-5174ff81ddee@nutanix.com> (Het Gala's
 message of "Tue, 28 Nov 2023 13:45:34 +0530")
Message-ID: <875y1m19ls.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Het Gala <het.gala@nutanix.com> writes:

> On 28/11/23 12:46 pm, Markus Armbruster wrote:
>> Your commit message is all in one line.  You need to format it like
>>
>>       migration: Plug memory leak
>>
>>      'channel' and 'addr' in qmp_migrate() are not auto-freed.
>>      migrate_uri_parse() allocates memory which is returned to 'channel',
>>      which is leaked because there is no code for freeing 'channel' or
>>      'addr'.  So, free addr and channel to avoid memory leak.  'addr'
>>      does shallow copying of channel->addr, hence free 'channel' itself
>>      and deep free contents of 'addr'.
>>
>> Het Gala<het.gala@nutanix.com>  writes:
> Yeah, I made the changes in v2 patchset.
>>> ---
>>>   migration/migration.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/migration/migration.c b/migration/migration.c
>>> index 28a34c9068..29efb51b62 100644
>>> --- a/migration/migration.c
>>> +++ b/migration/migration.c
>>> @@ -2004,6 +2004,8 @@ void qmp_migrate(const char *uri, bool has_channels,
>>>                             MIGRATION_STATUS_FAILED);
>>>           block_cleanup_parameters();
>>>       }
>>> +    g_free(channel);
>>> +    qapi_free_MigrationAddress(addr);
>>>         if (local_err) {
>>>           if (!resume_requested) {
>> 2. hmp_migrate()
>>
>>     hmp_migrate() allocates @channel with migrate_uri_parse(), adds it to
>>     list @caps, passes @caps to qmp_migrate(), then frees @caps with
>>     qapi_free_MigrationChannelList().
>
> Markus, sorry if I was not able to put point clearly, what I meant is that the local 'channel' variable used in qmp_migrate() i.e.
>
> 'MigrationChannel *channel = NULL', is defined in qmp_migrate() and if the user opts for 'uri' then '@channels' coming from hmp_migrate() will be NULL, and then migrate_uri_parse() will populate memory into 'channel', and that is not getting freed after it's use is over.
>
> I think, that is where memory leak might be happening ?

Aha!

    if (uri && has_channels) {
        error_setg(errp, "'uri' and 'channels' arguments are mutually "
                   "exclusive; exactly one of the two should be present in "
                   "'migrate' qmp command ");
        return;
    } else if (channels) {
        /* To verify that Migrate channel list has only item */
        if (channels->next) {
            error_setg(errp, "Channel list has more than one entries");
            return;
        }
        channel = channels->value;
    } else if (uri) {
        /* caller uses the old URI syntax */
        if (!migrate_uri_parse(uri, &channel, errp)) {
            return;
        }
    } else {
        error_setg(errp, "neither 'uri' or 'channels' argument are "
                   "specified in 'migrate' qmp command ");
        return;
    }

At this point, @channel is either channels->value, or from
migrate_uri_parse().

We must not free in the former case, we must free in the latter case,

Before your patch, we don't free.  Memory leak in the latter case.

Afterwards, we free.  Double-free in the former case.

You could guard the free, like so:

    if (uri) {
        qapi_free_MigrationChannel(channel);
    }


By the way, I the conditional shown above is harder to understand than
necessary.  I like to get the errors out of the way at the beginning,
like this:

    if (uri && has_channels) {
        error_setg(errp, "'uri' and 'channels' arguments are mutually "
                   "exclusive; exactly one of the two should be present in "
                   "'migrate' qmp command ");
        return;
    }
    if (!uri && !has_channels) {
        error_setg(errp, "neither 'uri' or 'channels' argument are "
                   "specified in 'migrate' qmp command ");
        return;
    }

    if (channels) {
        /* To verify that Migrate channel list has only item */

Or even

    if (!uri == !has_channels) {
        error_setg(errp, "need either 'uri' or 'channels' argument")
        return;
    }

Suggestion, not demand.  If you do it, separate patch.


