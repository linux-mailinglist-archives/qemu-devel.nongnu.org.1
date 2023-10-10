Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B86B97BFFF0
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 17:07:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqEIz-0004p6-Pq; Tue, 10 Oct 2023 11:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qqEIj-0004my-QB
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 11:05:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qqEIg-00083N-HF
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 11:05:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696950332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lpnTtQnPi6hpGuSRNN/TzYBQudkZ06eVV35xLl8CfkQ=;
 b=YNjVANhN2WyVk9mn4gKP7LXuaPnExxS5MOWvTarJEVxczqjJV5dBlCu7Cjh4wCR5PMcwu8
 n91A/1eQwWm+wDjKtkppkil+sYgz5NpoIkrqOKIsd9CZv/f0SZCHmkWkNvypZfh/dtVdgU
 4j6JXZ/epAYbz3PjcfEtR2gQhyUUhao=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-yd7rfT0eP3-UiIro6jPvOQ-1; Tue, 10 Oct 2023 11:05:18 -0400
X-MC-Unique: yd7rfT0eP3-UiIro6jPvOQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-637948b24bdso13660406d6.1
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 08:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696950318; x=1697555118;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lpnTtQnPi6hpGuSRNN/TzYBQudkZ06eVV35xLl8CfkQ=;
 b=UttwfgIleTn6N1U+EQ15tu5dAh/LpFbOA1y1jbtYtWcYvLCzVjqgeHpWzDNz2apTuB
 /orkM9gIDnKNykzqxY7XFC2hg+eDBjLYZSY3vLfj69XDw/62d8KmE7OBxhyzK+2NG46v
 QdP3aLLgcEK5qXPtaDXQNoQl8AsDeHILA2oAzfZ/Pn80xUPKRB9rmUTirK72J9nUpnDU
 IU5Gul9e8Mj96ZOmWA0oZi9LU89JdPz1Qc2j8ptR4a24VEd3xgQRgO439yhEjXqBT/6R
 vZjxGs+PcuOGTcStzV+BS6GMDfpFgUerVN/ngM4Dr+dFxSxl7Hkwb2Fa/xEkoxG6/poD
 yMSw==
X-Gm-Message-State: AOJu0YzxmY/h++fucBOFOtSt4V1YpOcdS9i87uxvKdA9LQnxjeIWOaTK
 YkVprWi9u8qXLNkwqMXV+Cx1n7zE0AxItsOAmLK/twogkp5ClHneIwrHah7mUze3ctofoa/tS4R
 tnUwPuPNUTY2x/y8=
X-Received: by 2002:a05:6214:2303:b0:668:e31b:5576 with SMTP id
 gc3-20020a056214230300b00668e31b5576mr19816352qvb.1.1696950317959; 
 Tue, 10 Oct 2023 08:05:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFES3HWpd6E6Q0IFEpPRSd5ZI3GY8bHeIlS6Xs7wQ6VdO1ddIznNxD6pVrm4k00iq65pVskRg==
X-Received: by 2002:a05:6214:2303:b0:668:e31b:5576 with SMTP id
 gc3-20020a056214230300b00668e31b5576mr19816328qvb.1.1696950317602; 
 Tue, 10 Oct 2023 08:05:17 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 a10-20020a0ce34a000000b006575372c845sm4778961qvm.119.2023.10.10.08.05.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 08:05:17 -0700 (PDT)
Date: Tue, 10 Oct 2023 11:05:15 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 3/4] migration/qapi: Replace @MigrateSetParameters
 with @MigrationParameters
Message-ID: <ZSVoK6YMgNzrDYGQ@x1n>
References: <20230905162335.235619-1-peterx@redhat.com>
 <20230905162335.235619-4-peterx@redhat.com>
 <87fs30is78.fsf@pond.sub.org> <ZRsff7Lmy7TnggK9@x1n>
 <87sf6k2dax.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87sf6k2dax.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Oct 09, 2023 at 02:25:10PM +0200, Markus Armbruster wrote:
> I apologize for the late reply.

Not a problem - one week is not even bad at all. :)

[...]

> > One thing I can do is to move qdev_prop_str_or_null impl (from you) into a
> > separate patch.   I can drop some unnecessary changes too when possible,
> > not yet sure what else I can split, but I can try once there.
> 
> Suggest to give it a quick try, then see whether you like the resulting
> split better than what you have now.

OK.

[...]

> >> > diff --git a/migration/options.c b/migration/options.c
> >> > index 6bbfd4853d..12e392f68c 100644
> >> > --- a/migration/options.c
> >> > +++ b/migration/options.c
> >> > @@ -164,9 +164,12 @@ Property migration_properties[] = {
> >> >      DEFINE_PROP_SIZE("announce-step", MigrationState,
> >> >                        parameters.announce_step,
> >> >                        DEFAULT_MIGRATE_ANNOUNCE_STEP),
> >> > -    DEFINE_PROP_STRING("tls-creds", MigrationState, parameters.tls_creds),
> >> > -    DEFINE_PROP_STRING("tls-hostname", MigrationState, parameters.tls_hostname),
> >> > -    DEFINE_PROP_STRING("tls-authz", MigrationState, parameters.tls_authz),
> >> > +    DEFINE_PROP_STR_OR_NULL("tls-creds", MigrationState,
> >> > +                            parameters.tls_creds),
> >> > +    DEFINE_PROP_STR_OR_NULL("tls-hostname", MigrationState,
> >> > +                            parameters.tls_hostname),
> >> > +    DEFINE_PROP_STR_OR_NULL("tls-authz", MigrationState,
> >> > +                            parameters.tls_authz),
> >> 
> >> The qdev machinery now additionally accepts JSON null as property
> >> value.
> >> 
> >> If that's undesirable, we need to reject it.
> >
> > I don't think we have a need to pass in null here, not to mention this is
> > only for debugging purpose.
> 
> Not sure I understand the bit about debugging.

The migration_properties here is only used by "-global migration.XXX=YYY".
It's not expected for a normal user to use this interface; one should
normally use QMP or even HMP.  So migration_properties as a whole is for
debugging purpose.

> 
> The point I was trying to make is this.  Before the patch, we reject
> attempts to set the property value to null.  Afterwards, we accept them,
> i.e. the patch loses "reject null property value".  If this loss is
> undesirable, we better replace it with suitable hand-written code.

I don't even know how to set it to NULL before.. as it can only be accessed
via cmdline "-global" as mentioned above, which must be a string anyway.
So I assume this is not an issue.

> 
> > The real problem here, IMHO, is current patch will crash if someone
> > specifies -global migration.tls_* fields..
> 
> Trips this assertion:
> 
>     bool visit_start_alternate(Visitor *v, const char *name,
>                                GenericAlternate **obj, size_t size,
>                                Error **errp)
>     {
>         bool ok;
> 
>         assert(obj && size >= sizeof(GenericAlternate));
>         assert(!(v->type & VISITOR_OUTPUT) || *obj);
>         trace_visit_start_alternate(v, name, obj, size);
>         if (!v->start_alternate) {
> --->        assert(!(v->type & VISITOR_INPUT));
>             return true;
>         }
>         ok = v->start_alternate(v, name, obj, size, errp);
>         if (v->type & VISITOR_INPUT) {
>             assert(ok != !*obj);
>         }
>         return ok;
>     }
> 
> Documented with the start_alternate() method in visitor-impl.h:
> 
>         /* Must be set by input and clone visitors to visit alternates */
>         bool (*start_alternate)(Visitor *v, const char *name,
>                                 GenericAlternate **obj, size_t size,
>                                 Error **errp);
> 
> Known restriction of the string input visitor:
> 
>     /*
>      * The string input visitor does not implement support for visiting
>      * QAPI structs, alternates, null, or arbitrary QTypes. Only flat lists
>      * of integers (except type "size") are supported.
>      */
>     Visitor *string_input_visitor_new(const char *str);
> 
> A similar restriction is documented for the string output visitor.
> 
> > Unfortunately I'm not an expert on qapi.  Markus, does something like this
> > look like a valid fix to you?
> 
> I'm not sure whether your simple patch is sufficient for lifting the
> restriction.  Needs a deeper think, I'm afraid.  Can we make progress on
> the remainder of the series in parallel?

We can move back to using string rather than StrOrNull, but I saw there's
another email discussing this.  Let me also read that first, before jumping
back and forth on the solutions.

Note that my goal prior to this series is introducing another migration
parameter (avail-switchover-bandwidth).  What I think I can do is I'll
proceed with that patch rebasing to master rather than this series; doing
the triplication once more and decouple.  Then we can postpone this series.

Thanks,

-- 
Peter Xu


