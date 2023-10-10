Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF89C7C0448
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 21:19:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqIFd-0002ou-0K; Tue, 10 Oct 2023 15:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qqIFT-0002jg-GG
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 15:18:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qqIFR-0004ya-Jt
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 15:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696965508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fptMihuUFzHev400B3vBt4NjOhhXSw7ZQ/SlMAVwIPg=;
 b=PkUZLLQNWfsndgIs0pj2RyUuifTjCt/rP8atz52qVHDhGXTTJiqzBjzSz8YZLGUQIw6R5J
 L2ackxaolvKQ1Z2geXub9SVaf7Eic30l+I3bLkpCzKGi5pfRM0yrdnuyDcw6uWmeysT76+
 QmQAWSFed9ROS1FDHu2+XfLvzba+BV8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-wHbijMmAPUSnFJwinXzMzw-1; Tue, 10 Oct 2023 15:18:25 -0400
X-MC-Unique: wHbijMmAPUSnFJwinXzMzw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B0E8800883;
 Tue, 10 Oct 2023 19:18:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D91D40C6F79;
 Tue, 10 Oct 2023 19:18:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6515B21E6904; Tue, 10 Oct 2023 21:18:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Juan Quintela <quintela@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Thomas Huth
 <thuth@redhat.com>
Subject: Re: [PATCH v3 3/4] migration/qapi: Replace @MigrateSetParameters
 with @MigrationParameters
References: <20230905162335.235619-1-peterx@redhat.com>
 <20230905162335.235619-4-peterx@redhat.com>
 <87fs30is78.fsf@pond.sub.org> <ZRsff7Lmy7TnggK9@x1n>
 <87sf6k2dax.fsf@pond.sub.org> <ZSVoK6YMgNzrDYGQ@x1n>
Date: Tue, 10 Oct 2023 21:18:23 +0200
In-Reply-To: <ZSVoK6YMgNzrDYGQ@x1n> (Peter Xu's message of "Tue, 10 Oct 2023
 11:05:15 -0400")
Message-ID: <878r8ajngg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
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

Peter Xu <peterx@redhat.com> writes:

> On Mon, Oct 09, 2023 at 02:25:10PM +0200, Markus Armbruster wrote:
>> I apologize for the late reply.
>
> Not a problem - one week is not even bad at all. :)

I try to keep conversations moving once they started.

> [...]
>
>> > One thing I can do is to move qdev_prop_str_or_null impl (from you) into a
>> > separate patch.   I can drop some unnecessary changes too when possible,
>> > not yet sure what else I can split, but I can try once there.
>> 
>> Suggest to give it a quick try, then see whether you like the resulting
>> split better than what you have now.
>
> OK.
>
> [...]
>
>> >> > diff --git a/migration/options.c b/migration/options.c
>> >> > index 6bbfd4853d..12e392f68c 100644
>> >> > --- a/migration/options.c
>> >> > +++ b/migration/options.c
>> >> > @@ -164,9 +164,12 @@ Property migration_properties[] = {
>> >> >      DEFINE_PROP_SIZE("announce-step", MigrationState,
>> >> >                        parameters.announce_step,
>> >> >                        DEFAULT_MIGRATE_ANNOUNCE_STEP),
>> >> > -    DEFINE_PROP_STRING("tls-creds", MigrationState, parameters.tls_creds),
>> >> > -    DEFINE_PROP_STRING("tls-hostname", MigrationState, parameters.tls_hostname),
>> >> > -    DEFINE_PROP_STRING("tls-authz", MigrationState, parameters.tls_authz),
>> >> > +    DEFINE_PROP_STR_OR_NULL("tls-creds", MigrationState,
>> >> > +                            parameters.tls_creds),
>> >> > +    DEFINE_PROP_STR_OR_NULL("tls-hostname", MigrationState,
>> >> > +                            parameters.tls_hostname),
>> >> > +    DEFINE_PROP_STR_OR_NULL("tls-authz", MigrationState,
>> >> > +                            parameters.tls_authz),
>> >> 
>> >> The qdev machinery now additionally accepts JSON null as property
>> >> value.
>> >> 
>> >> If that's undesirable, we need to reject it.
>> >
>> > I don't think we have a need to pass in null here, not to mention this is
>> > only for debugging purpose.
>> 
>> Not sure I understand the bit about debugging.
>
> The migration_properties here is only used by "-global migration.XXX=YYY".
> It's not expected for a normal user to use this interface; one should
> normally use QMP or even HMP.  So migration_properties as a whole is for
> debugging purpose.
>
>> 
>> The point I was trying to make is this.  Before the patch, we reject
>> attempts to set the property value to null.  Afterwards, we accept them,
>> i.e. the patch loses "reject null property value".  If this loss is
>> undesirable, we better replace it with suitable hand-written code.
>
> I don't even know how to set it to NULL before.. as it can only be accessed
> via cmdline "-global" as mentioned above, which must be a string anyway.
> So I assume this is not an issue.

Something like

    {"execute": "migrate-set-parameters",
     "arguments": {"tls-authz": null}}

Hmm, crashes in migrate_params_apply(), which is a bug.  I'm getting
more and more suspicious about user-facing migration code...

If the migration object is accessible with qom-set, then that's another
way to assign null values.

>> > The real problem here, IMHO, is current patch will crash if someone
>> > specifies -global migration.tls_* fields..
>> 
>> Trips this assertion:
>> 
>>     bool visit_start_alternate(Visitor *v, const char *name,
>>                                GenericAlternate **obj, size_t size,
>>                                Error **errp)
>>     {
>>         bool ok;
>> 
>>         assert(obj && size >= sizeof(GenericAlternate));
>>         assert(!(v->type & VISITOR_OUTPUT) || *obj);
>>         trace_visit_start_alternate(v, name, obj, size);
>>         if (!v->start_alternate) {
>> --->        assert(!(v->type & VISITOR_INPUT));
>>             return true;
>>         }
>>         ok = v->start_alternate(v, name, obj, size, errp);
>>         if (v->type & VISITOR_INPUT) {
>>             assert(ok != !*obj);
>>         }
>>         return ok;
>>     }
>> 
>> Documented with the start_alternate() method in visitor-impl.h:
>> 
>>         /* Must be set by input and clone visitors to visit alternates */
>>         bool (*start_alternate)(Visitor *v, const char *name,
>>                                 GenericAlternate **obj, size_t size,
>>                                 Error **errp);
>> 
>> Known restriction of the string input visitor:
>> 
>>     /*
>>      * The string input visitor does not implement support for visiting
>>      * QAPI structs, alternates, null, or arbitrary QTypes. Only flat lists
>>      * of integers (except type "size") are supported.
>>      */
>>     Visitor *string_input_visitor_new(const char *str);
>> 
>> A similar restriction is documented for the string output visitor.
>> 
>> > Unfortunately I'm not an expert on qapi.  Markus, does something like this
>> > look like a valid fix to you?
>> 
>> I'm not sure whether your simple patch is sufficient for lifting the
>> restriction.  Needs a deeper think, I'm afraid.  Can we make progress on
>> the remainder of the series in parallel?
>
> We can move back to using string rather than StrOrNull, but I saw there's
> another email discussing this.  Let me also read that first, before jumping
> back and forth on the solutions.

In my "QAPI string visitors crashes" memo, I demonstrated that the crash
on funny property type predates your series.  You merely add another
instance.  Moreover, crashing -global is less serious than a crashing
monitor command, because only the latter can take down a running guest.
Can't see why your series needs to wait for a fix of the crash bug.
Makes sense?

> Note that my goal prior to this series is introducing another migration
> parameter (avail-switchover-bandwidth).  What I think I can do is I'll
> proceed with that patch rebasing to master rather than this series; doing
> the triplication once more and decouple.  Then we can postpone this series.
>
> Thanks,


