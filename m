Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F967BDBB7
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 14:26:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qppKB-0006Zn-98; Mon, 09 Oct 2023 08:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qppK3-0006X5-Nz
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 08:25:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qppK1-0003CO-9v
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 08:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696854315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bJQRFAj1zSpZSYwWybK0ZLzFRMfLbCInEwFFIx57lAA=;
 b=GRIFSOZewUQ1raRhf60rlu+LFpRZhqTG3AH9SchDHqtwvtCFtcbkuGKMbWGXJL0TS7NaJW
 Qny5N4KCQXDFnSL1UNNw70oxX6LJGVQwpx/MDhnza7guTApPeTIDh8C2+2ltxc0Crh/fCX
 IG4GfI2o+ZKMSAn+Dn/TfZzjdaCKApE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-65-lNjHN6ZHPjyykykhxRr9-g-1; Mon, 09 Oct 2023 08:25:12 -0400
X-MC-Unique: lNjHN6ZHPjyykykhxRr9-g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A858101A58B;
 Mon,  9 Oct 2023 12:25:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B5AA4140E963;
 Mon,  9 Oct 2023 12:25:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C15F121E6904; Mon,  9 Oct 2023 14:25:10 +0200 (CEST)
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
Date: Mon, 09 Oct 2023 14:25:10 +0200
In-Reply-To: <ZRsff7Lmy7TnggK9@x1n> (Peter Xu's message of "Mon, 2 Oct 2023
 15:52:31 -0400")
Message-ID: <87sf6k2dax.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

I apologize for the late reply.

Peter Xu <peterx@redhat.com> writes:

> On Tue, Sep 26, 2023 at 10:40:27PM +0200, Markus Armbruster wrote:
>> Peter Xu <peterx@redhat.com> writes:
>>=20
>> > Quotting from Markus in his replies:
>>=20
>> Quoting
>>=20
>> Suggest something like "Markus recently wrote:"
>
> Will do.
>
>>=20
>> >   migrate-set-parameters sets migration parameters, and
>> >   query-migrate-parameters gets them.  Unsurprisingly, the former's
>> >   argument type MigrateSetParameters is quite close to the latter's
>> >   return type MigrationParameters.  The differences are subtle:
>> >
>> >   1. Since migrate-set-parameters supports setting selected parameters,
>> >      its arguments must all be optional (so you can omit the ones you
>> >      don't want to change).  query-migrate-parameters results are also
>> >      all optional, but almost all of them are in fact always present.
>> >
>> >   2. For parameters @tls_creds, @tls_hostname, @tls_authz,
>> >      migrate-set-parameters interprets special value "" as "reset to
>> >      default".  Works, because "" is semantically invalid.  Not a
>> >      general solution, because a semantically invalid value need not
>> >      exist.  Markus added a general solution in commit 01fa559826
>> >      ("migration: Use JSON null instead of "" to reset parameter to
>> >      default").  This involved changing the type from 'str' to
>> >      'StrOrNull'.
>> >
>> >   3. When parameter @block-bitmap-mapping has not been set,
>> >      query-migrate-parameters does not return it (absent optional
>> >      member).  Clean (but undocumented).  When parameters @tls_creds,
>> >      @tls_hostname, @tls_authz have not been set, it returns the
>> >      semantically invalid value "".  Not so clean (and just as
>> >      undocumented).
>> >
>> > Here to deduplicate the two objects: keep @MigrationParameters as the =
name
>> > of object to use in both places, drop @MigrateSetParameters, at the
>> > meantime switch types of @tls* fields from "str" to "StrOrNull" types.
>>=20
>> Suggest
>>=20
>>   Eliminate the duplication follows.
>>=20
>>   Change MigrationParameters members @tls_creds, @tls_hostname,
>>   @tls_authz to StrOrNull.  query-migrate-parameters will of course
>>   never return null.
>>=20
>>   Since these members are qdev properties, we need property machinery
>>   for StrOrNull: DEFINE_PROP_STR_OR_NULL().
>>=20
>>   Switch migrate-set-parameters to MigrationParameters, and delete
>>   MigrateSetParameters.
>
> Will do.
>
>>=20
>> Can you make this patch do just this de-duplication, and everything else
>> (described below) separately?
>
> One thing I can do is to move qdev_prop_str_or_null impl (from you) into a
> separate patch.   I can drop some unnecessary changes too when possible,
> not yet sure what else I can split, but I can try once there.

Suggest to give it a quick try, then see whether you like the resulting
split better than what you have now.

>> > I found that the TLS code wasn't so much relying on tls_* fields being
>> > non-NULL at all.  Actually on the other way round: if we set tls_authz=
 to
>> > an empty string (NOTE: currently, migrate_init() missed initializing
>> > tls_authz; also touched it up in this patch), we can already fail one =
of
>> > the migration-test (tls/x509/default-host), as qauthz_is_allowed_by_id=
()
>> > will assume tls_authz set even if tls_auths is an empty string.
>> >
>> > It means we're actually relying on tls_* fields being NULL even if it'=
s the
>> > empty string.
>> >
>> > Let's just make it a rule to return NULL for empty string on these fie=
lds
>> > internally.  For that, when converting a StrOrNull into a char* (where=
 we
>> > introduced a helper here in this patch) we'll also make the empty stri=
ng to
>> > be NULL, to make it always work.  And it doesn't show any issue either=
 when
>> > applying that logic to both tls_creds and tls_hostname.
>> >
>> > With above, we can safely change both migration_tls_client_create() and
>> > migrate_tls() to not check the empty string too finally.. not needed
>> > anymore.
>> >
>> > Also, we can drop the hackish conversions in qmp_migrate_set_parameter=
s()
>> > where we want to make sure it's a QSTRING; it's not needed now.
>> >
>> > This greatly deduplicates the code not only in qapi/migration.json, but
>> > also in the generic migration code.
>> >
>> > Markus helped greatly with this patch.  Besides a better commit
>> > message (where I just "stole" from the reply), debugged and resolved a
>> > double free, but also provided the StrOrNull property implementation t=
o be
>> > used in MigrationState object when switching tls_* fields to StrOrNull.
>> >
>> > Co-developed-by: Markus Armbruster <armbru@redhat.com>
>> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> > Signed-off-by: Peter Xu <peterx@redhat.com>

[...]

>> > diff --git a/migration/options.c b/migration/options.c
>> > index 6bbfd4853d..12e392f68c 100644
>> > --- a/migration/options.c
>> > +++ b/migration/options.c
>> > @@ -164,9 +164,12 @@ Property migration_properties[] =3D {
>> >      DEFINE_PROP_SIZE("announce-step", MigrationState,
>> >                        parameters.announce_step,
>> >                        DEFAULT_MIGRATE_ANNOUNCE_STEP),
>> > -    DEFINE_PROP_STRING("tls-creds", MigrationState, parameters.tls_cr=
eds),
>> > -    DEFINE_PROP_STRING("tls-hostname", MigrationState, parameters.tls=
_hostname),
>> > -    DEFINE_PROP_STRING("tls-authz", MigrationState, parameters.tls_au=
thz),
>> > +    DEFINE_PROP_STR_OR_NULL("tls-creds", MigrationState,
>> > +                            parameters.tls_creds),
>> > +    DEFINE_PROP_STR_OR_NULL("tls-hostname", MigrationState,
>> > +                            parameters.tls_hostname),
>> > +    DEFINE_PROP_STR_OR_NULL("tls-authz", MigrationState,
>> > +                            parameters.tls_authz),
>>=20
>> The qdev machinery now additionally accepts JSON null as property
>> value.
>>=20
>> If that's undesirable, we need to reject it.
>
> I don't think we have a need to pass in null here, not to mention this is
> only for debugging purpose.

Not sure I understand the bit about debugging.

The point I was trying to make is this.  Before the patch, we reject
attempts to set the property value to null.  Afterwards, we accept them,
i.e. the patch loses "reject null property value".  If this loss is
undesirable, we better replace it with suitable hand-written code.

> The real problem here, IMHO, is current patch will crash if someone
> specifies -global migration.tls_* fields..

Trips this assertion:

    bool visit_start_alternate(Visitor *v, const char *name,
                               GenericAlternate **obj, size_t size,
                               Error **errp)
    {
        bool ok;

        assert(obj && size >=3D sizeof(GenericAlternate));
        assert(!(v->type & VISITOR_OUTPUT) || *obj);
        trace_visit_start_alternate(v, name, obj, size);
        if (!v->start_alternate) {
--->        assert(!(v->type & VISITOR_INPUT));
            return true;
        }
        ok =3D v->start_alternate(v, name, obj, size, errp);
        if (v->type & VISITOR_INPUT) {
            assert(ok !=3D !*obj);
        }
        return ok;
    }

Documented with the start_alternate() method in visitor-impl.h:

        /* Must be set by input and clone visitors to visit alternates */
        bool (*start_alternate)(Visitor *v, const char *name,
                                GenericAlternate **obj, size_t size,
                                Error **errp);

Known restriction of the string input visitor:

    /*
     * The string input visitor does not implement support for visiting
     * QAPI structs, alternates, null, or arbitrary QTypes. Only flat lists
     * of integers (except type "size") are supported.
     */
    Visitor *string_input_visitor_new(const char *str);

A similar restriction is documented for the string output visitor.

> Unfortunately I'm not an expert on qapi.  Markus, does something like this
> look like a valid fix to you?

I'm not sure whether your simple patch is sufficient for lifting the
restriction.  Needs a deeper think, I'm afraid.  Can we make progress on
the remainder of the series in parallel?

I wish we could get rid of the string visitors.

> =3D=3D=3D8<=3D=3D=3D
> commit 19758cbaa99c0bad634babdb6f59f23bf0de7b75
> Author: Peter Xu <peterx@redhat.com>
> Date:   Mon Oct 2 14:26:23 2023 -0400
>
>     qapi: Allow the string visitor to run on StrOrNull
>=20=20=20=20=20
>     Unlike most of the existing types, StrOrNull needs to manage its own
>     allocations.  Provide string_input_start_alternate() for the string v=
isitor
>     so that things like StrOrNull will start to work.
>=20=20=20=20=20
>     Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  qapi/string-input-visitor.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
> index 197139c1c0..263e26596c 100644
> --- a/qapi/string-input-visitor.c
> +++ b/qapi/string-input-visitor.c
> @@ -387,6 +387,15 @@ static void string_input_free(Visitor *v)
>      g_free(siv);
>  }
>=20=20
> +static bool string_input_start_alternate(Visitor *v, const char *name,
> +                                         GenericAlternate **obj, size_t =
size,
> +                                         Error **errp)
> +{
> +    *obj =3D g_malloc0(size);
> +    (*obj)->type =3D QTYPE_QSTRING;
> +    return true;
> +}
> +
>  Visitor *string_input_visitor_new(const char *str)
>  {
>      StringInputVisitor *v;
> @@ -407,6 +416,7 @@ Visitor *string_input_visitor_new(const char *str)
>      v->visitor.check_list =3D check_list;
>      v->visitor.end_list =3D end_list;
>      v->visitor.free =3D string_input_free;
> +    v->visitor.start_alternate =3D string_input_start_alternate;
>=20=20
>      v->string =3D str;
>      v->lm =3D LM_NONE;
> =3D=3D=3D8<=3D=3D=3D
>
>>
>> If it's desirable, we need to document it, and we should probably make
>> it a separate patch.
>>=20
>> To answer the question whether it's desirable, we need to recall the
>> purpose of the properties.  They go back to
>>=20
>> commit e5cb7e7677010f529d3f0f9dcdb385dea9446f8d
>> Author: Peter Xu <peterx@redhat.com>
>> Date:   Tue Jun 27 12:10:13 2017 +0800
>>=20
>>     migration: let MigrationState be a qdev
>>=20=20=20=20=20
>>     Let the old man "MigrationState" join the object family. Direct bene=
fit
>>     is that we can start to use all the property features derived from
>>     current QDev, like: HW_COMPAT_* bits, command line setup for migrati=
on
>>     parameters (so will never need to set them up each time using HMP/QM=
P,
>>     this is really, really attractive for test writters), etc.
>>=20=20=20=20=20
>>     I see no reason to disallow this happen yet. So let's start from this
>>     one, to see whether it would be anything good.
>>=20=20=20=20=20
>>     Now we init the MigrationState struct statically in main() to make s=
ure
>>     it's initialized after global properties are applied, since we'll use
>>     them during creation of the object.
>>=20=20=20=20=20
>>     No functional change at all.
>>=20=20=20=20=20
>>     Reviewed-by: Juan Quintela <quintela@redhat.com>
>>     Signed-off-by: Peter Xu <peterx@redhat.com>
>>     Message-Id: <1498536619-14548-5-git-send-email-peterx@redhat.com>
>>     Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>>     Signed-off-by: Juan Quintela <quintela@redhat.com>
>>=20
>> >      DEFINE_PROP_UINT64("x-vcpu-dirty-limit-period", MigrationState,
>> >                         parameters.x_vcpu_dirty_limit_period,
>> >                         DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD),
>> > @@ -201,6 +204,38 @@ Property migration_properties[] =3D {
>> >      DEFINE_PROP_END_OF_LIST(),
>> >  };
>> >=20=20
>> > +/*
>> > + * NOTE: here we have a trick when converting the empty string (""): =
we
>> > + * need to make sure the empty string ("") will be converted to NULL,=
 as
>> > + * some TLS code may rely on that to detect whether something is enab=
led
>> > + * (e.g., the tls_authz field).
>>=20
>> Suggest
>>=20
>>     * Map JSON null and JSON "" to NULL, other JSON strings to the strin=
g.
>>     * The curious special treatment of "" is necessary, because it needs
>>     * to be interpreted like JSON null for backward compatibility.
>
> Sure.
>
>>=20
>> > + */
>> > +const char *str_from_StrOrNull(StrOrNull *obj)
>> > +{
>> > +    if (!obj || obj->type =3D=3D QTYPE_QNULL) {
>> > +        return NULL;
>> > +    } else if (obj->type =3D=3D QTYPE_QSTRING) {
>> > +        if (obj->u.s[0] =3D=3D '\0') {
>> > +            return NULL;
>> > +        } else {
>> > +            return obj->u.s;
>> > +        }
>> > +    } else {
>> > +        abort();
>> > +    }
>> > +}
>> > +
>> > +StrOrNull *StrOrNull_from_str(const char *str)
>> > +{
>> > +    StrOrNull *obj =3D g_new0(StrOrNull, 1);
>> > +
>> > +    assert(str);
>> > +    obj->type =3D QTYPE_QSTRING;
>> > +    obj->u.s =3D g_strdup(str);
>> > +
>> > +    return obj;
>> > +}
>> > +
>> >  bool migrate_auto_converge(void)
>> >  {
>> >      MigrationState *s =3D migrate_get_current();
>> > @@ -378,9 +413,11 @@ bool migrate_postcopy(void)
>> >=20=20
>> >  bool migrate_tls(void)
>> >  {
>> > -    MigrationState *s =3D migrate_get_current();
>> > -
>> > -    return s->parameters.tls_creds && *s->parameters.tls_creds;
>> > +    /*
>> > +     * The whole TLS feature relies on a non-empty tls-creds set firs=
t.
>> > +     * It's disabled otherwise.
>> > +     */
>>=20
>> Suggest
>>=20
>>        /* TLS is enabled when @tls-creds is non-null */
>
> But this is not the fact.. we probably need to say "non-null and non-empty
> string".  I'll drop it in the new version directly, as I decided to rely
> that on the comment above str_from_StrOrNull().  Let me know if you have
> other preference.

I'll check the new version.

>> > +    return migrate_tls_creds();
>> >  }
>> >=20=20
>> >  typedef enum WriteTrackingSupport {
>> > @@ -827,21 +864,21 @@ const char *migrate_tls_authz(void)
>> >  {
>> >      MigrationState *s =3D migrate_get_current();
>> >=20=20
>> > -    return s->parameters.tls_authz;
>> > +    return str_from_StrOrNull(s->parameters.tls_authz);
>> >  }
>>=20
>> This maps "" to null on use of .tls_authz.  Direct use is wrong.
>>=20
>> The alternative is to map it when it's set.  Then setting it must go
>> through a setter that maps, and direct use is fine.  Observation, not a
>> demand.
>
> Right.  I plan to leave it there until later, though, and make sure all
> reference to it will be correct (using str_from_StrOrNull if needed, or
> migrate_tls_*).
>
>>=20
>> >=20=20
>> >  const char *migrate_tls_creds(void)
>> >  {
>> >      MigrationState *s =3D migrate_get_current();
>> >=20=20
>> > -    return s->parameters.tls_creds;
>> > +    return str_from_StrOrNull(s->parameters.tls_creds);
>> >  }
>> >=20=20
>> >  const char *migrate_tls_hostname(void)
>> >  {
>> >      MigrationState *s =3D migrate_get_current();
>> >=20=20
>> > -    return s->parameters.tls_hostname;
>> > +    return str_from_StrOrNull(s->parameters.tls_hostname);
>> >  }
>>=20
>> Likewise.
>>=20
>> >=20=20
>> >  uint64_t migrate_xbzrle_cache_size(void)
>> > @@ -911,10 +948,9 @@ MigrationParameters *qmp_query_migrate_parameters=
(Error **errp)
>> >      params->cpu_throttle_increment =3D s->parameters.cpu_throttle_inc=
rement;
>> >      params->has_cpu_throttle_tailslow =3D true;
>> >      params->cpu_throttle_tailslow =3D s->parameters.cpu_throttle_tail=
slow;
>> > -    params->tls_creds =3D g_strdup(s->parameters.tls_creds);
>> > -    params->tls_hostname =3D g_strdup(s->parameters.tls_hostname);
>> > -    params->tls_authz =3D g_strdup(s->parameters.tls_authz ?
>> > -                                 s->parameters.tls_authz : "");
>> > +    params->tls_creds =3D QAPI_CLONE(StrOrNull, s->parameters.tls_cre=
ds);
>> > +    params->tls_hostname =3D QAPI_CLONE(StrOrNull, s->parameters.tls_=
hostname);
>> > +    params->tls_authz =3D QAPI_CLONE(StrOrNull, s->parameters.tls_aut=
hz);
>> >      params->has_max_bandwidth =3D true;
>> >      params->max_bandwidth =3D s->parameters.max_bandwidth;
>> >      params->has_downtime_limit =3D true;
>> > @@ -963,8 +999,9 @@ MigrationParameters *qmp_query_migrate_parameters(=
Error **errp)
>> >=20=20
>> >  void migrate_params_init(MigrationParameters *params)
>> >  {
>> > -    params->tls_hostname =3D g_strdup("");
>> > -    params->tls_creds =3D g_strdup("");
>> > +    params->tls_hostname =3D StrOrNull_from_str("");
>> > +    params->tls_creds =3D StrOrNull_from_str("");
>> > +    params->tls_authz =3D StrOrNull_from_str("");
>> >=20=20
>> >      /* Set has_* up only for parameter checks */
>> >      params->has_compress_level =3D true;
>> > @@ -1145,7 +1182,7 @@ bool migrate_params_check(MigrationParameters *p=
arams, Error **errp)
>> >  #ifdef CONFIG_LINUX
>> >      if (migrate_zero_copy_send() &&
>> >          ((params->has_multifd_compression && params->multifd_compress=
ion) ||
>> > -         (params->tls_creds && *params->tls_creds))) {
>> > +         migrate_tls())) {
>>=20
>> Correct only if params =3D=3D current_migration!  Are they equal?
>
> No!
>
> I'll fix that with str_from_StrOrNull().  Definitely not pretty, but I wa=
nt
> to avoid growing this set so I can go back to the
> avail-switchover-bandwidth patch soon.  Let me know if you have other
> suggestions.

We can accept a bit of ugliness for de-triplicating migration parameters
in the QAPI schema.

[...]


