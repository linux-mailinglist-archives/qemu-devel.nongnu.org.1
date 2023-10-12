Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C6F7C71ED
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 17:59:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqy51-00067f-6i; Thu, 12 Oct 2023 11:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qqy4y-00067D-O6
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 11:58:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qqy4w-00049y-Vn
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 11:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697126306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VKoYc2yWFOhY0tXgg9AR5IuuqkYz9R1cL/Uahogl7Xs=;
 b=ZbHoUaOUDoTjfugBJvgwuKOwZW3hU+3K/A9iBM3lMGT9MGmlsrLjYBkg9rOPMnx6YgXRgX
 aWmG3Gcj6Qi+smMtYoJinDDtN5vRP3MiRF/5lRdExNinveCVJzCN+QSVh3oOTxuqQFkiDD
 PXPCBLNs9WLO4rK0gVRCT1N486WRahY=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-bW3889JOMs6y3IqW7uqEqw-1; Thu, 12 Oct 2023 11:58:24 -0400
X-MC-Unique: bW3889JOMs6y3IqW7uqEqw-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-1e97f2cef6aso190918fac.0
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 08:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697126304; x=1697731104;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VKoYc2yWFOhY0tXgg9AR5IuuqkYz9R1cL/Uahogl7Xs=;
 b=G9McLXONnwuklnxhCld2i1vIl2jry55CBCt/O44bCYszsPVRqg34yIUMEyUt9Tf3Ys
 3fhsQqw/D4uGDkUcBUXWaefELKU+hObHExlnmgcy4O1azsQh4tnEKd+ieH/iQtOQeBv5
 5XcZJScaCBy9/d4bY9CvpygGXPWxYVE5sVmNMZbII0hcH4UI1u0Pxk2ws/WTeqktO5Yc
 3W5PlsPQeqaITlHuVMpQ1IiYxjoe8xnksAET5ZttIMQYLE19wlKRuU3C9GoXRtsvA+ae
 XCNDzPAHvqDPY69C7mSW3WsH+w92oiEExUfr9pY70mQz3S368kipIq3mrzDfuDHe/mjc
 5H8Q==
X-Gm-Message-State: AOJu0YxSxGGMcyZfJaZj/gUJ800D1h4O7DioNaLFk02GRB8t8EMh+m6Z
 Nxid81TpiYP9FF8ueGybJWhe8TQtqNALxzW26wEjkzj1zTIxO8yQbclQKYN67LmqTf1eO5vXKsB
 W4n8btLi9fix+N20=
X-Received: by 2002:a05:6870:bacf:b0:1e9:8ab9:11ca with SMTP id
 js15-20020a056870bacf00b001e98ab911camr6061389oab.3.1697126304154; 
 Thu, 12 Oct 2023 08:58:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzotYU6aHVPAMLTH5u2YtSCDTZayMoVbpqb+rVBDgvGe3PTXQkzGh1n/qFAFSD+n5RGqQNqA==
X-Received: by 2002:a05:6870:bacf:b0:1e9:8ab9:11ca with SMTP id
 js15-20020a056870bacf00b001e98ab911camr6061381oab.3.1697126303862; 
 Thu, 12 Oct 2023 08:58:23 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 c18-20020ac84e12000000b004033c3948f9sm6290474qtw.42.2023.10.12.08.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 08:58:23 -0700 (PDT)
Date: Thu, 12 Oct 2023 11:58:21 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 3/4] migration/qapi: Replace @MigrateSetParameters
 with @MigrationParameters
Message-ID: <ZSgXnb7pr3Ru6v+b@x1n>
References: <20230905162335.235619-1-peterx@redhat.com>
 <20230905162335.235619-4-peterx@redhat.com>
 <87fs30is78.fsf@pond.sub.org> <ZRsff7Lmy7TnggK9@x1n>
 <87sf6k2dax.fsf@pond.sub.org> <ZSVoK6YMgNzrDYGQ@x1n>
 <878r8ajngg.fsf@pond.sub.org> <ZSWvYgKcGXlucXx6@x1n>
 <875y3dixzp.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875y3dixzp.fsf@pond.sub.org>
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

On Wed, Oct 11, 2023 at 06:28:26AM +0200, Markus Armbruster wrote:
> >> Something like
> >> 
> >>     {"execute": "migrate-set-parameters",
> >>      "arguments": {"tls-authz": null}}
> >> 
> >> Hmm, crashes in migrate_params_apply(), which is a bug.  I'm getting
> >> more and more suspicious about user-facing migration code...
> >
> > Did you apply patch 1 of this series?
> 
> Since we're talking about "how to set it to NULL before", I was using
> master.

I see.  Then it seems we're good.  The fix just landed master branch
(86dec715a7).

> 
> > https://lore.kernel.org/qemu-devel/20230905162335.235619-2-peterx@redhat.com/
> >
> > QMP "migrate-set-parameters" does not go via migration_properties, so even
> > if we change handling of migration_properties, it shouldn't yet affect the
> > QMP interface of that.
> 
> I see.
> 
> I want to understand the impact of the change from 'str' to 'StrOrNull'
> on external interfaces.  The first step is to know where exactly the
> type is exposed externally.  *Know*, not gut-feel based on intended use.
> 
> I'll have another look at the schema change, and how the types are used.

Thanks.

> 
> >> If the migration object is accessible with qom-set, then that's another
> >> way to assign null values.
> >
> > I see what you meant.  IMHO we just don't need to worry on breaking that as
> > I am not aware of anyone using that to set migration parameters, and I
> > think the whole idea of migration_properties is for debugging.  The only
> > legal way an user should set migration parameters should be via QMP, afaik.
> 
> No matter the intended purpose of an interface, its meaning should be
> clear.  If we accept null, what does it mean?

IMHO here it means anything parsed from migration_properties will be a
qstring and impossible to be a qnull, at least if with that of my (probably
unmature, or even wrong..) fix:

https://lore.kernel.org/all/ZRsff7Lmy7TnggK9@x1n/

+static bool string_input_start_alternate(Visitor *v, const char *name,
+                                         GenericAlternate **obj, size_t size,
+                                         Error **errp)
+{
+    *obj = g_malloc0(size);
+    (*obj)->type = QTYPE_QSTRING;          <---------------- constantly set to string type
+    return true;
+}

I think it means when we parse the string, we'll always go with:

visit_type_StrOrNull():
    switch ((*obj)->type) {
    case QTYPE_QSTRING:
        ok = visit_type_str(v, name, &(*obj)->u.s, errp);
        break;

Finally, parse_type_str().

So it'll be impossible to specify null for -global migration.tls_*=XXX.

I suppose it's fine then?  Because it actually matches with previous when
it was still a string, and we use empty string to show tls disabled.

Thanks,

-- 
Peter Xu


