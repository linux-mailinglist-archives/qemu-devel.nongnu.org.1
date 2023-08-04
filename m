Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB044770581
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 18:03:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRxFq-0004yD-89; Fri, 04 Aug 2023 12:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qRxFl-0004o6-79
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 12:02:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qRxFi-000521-3q
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 12:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691164928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KuAZzR22LYMZIllsctLkD+OgAK4Bo2lpgWaVMrJJC1o=;
 b=dDNb5z1v20ff52I0wUFnnDsy/6pqFv7qh0/A9GQ2ri+TMgiHTX0lXIEPhZ3cei75s293qM
 rdEbXIQvLURcolbmHW30+LbWrBE3xwJIOwD7xg6TDCmXFnWJQCIwQaLA81WOfqwmoASIp7
 mngrs/uOnwDxXSnJEaRIDhqzQX4pguY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-G3va52bVPYmh7CKIGvrmRw-1; Fri, 04 Aug 2023 12:02:07 -0400
X-MC-Unique: G3va52bVPYmh7CKIGvrmRw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-63d2b88325bso4599046d6.1
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 09:02:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691164926; x=1691769726;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KuAZzR22LYMZIllsctLkD+OgAK4Bo2lpgWaVMrJJC1o=;
 b=HE7RQVBt96PQ+YUpXXUOAJIePbsxIo1+hGMMjifmGijCzXbk3X8+GYe1WNDrzvh0uv
 Q4ukFqx9dK+HZ7GxTXJt6/YCZUuuDCA83KLfV3V2I+i9kiHBUORJe0RRfK0U3eOtzyUw
 f6pC18BhuCsEV5kv0p1ATVwWimjyL6JkvZzGKPMIeNvFFU5HEQkaoxHkd4sYk2nXRX3m
 0lBxSamw9NLkt2Aig15K8tqf9gOri7n56G06TeBDzXtKULKK8KFOYCbamwQLVUouN7oh
 gkhEezyBMctlZ9hgyFKUdrsZpRpAml57bra6jXIyMngz1UZWQbCq7XYh2DXp0Ccxpe/M
 oaGg==
X-Gm-Message-State: ABy/qLbHANHngbmOlzaCvQY4IQFFwNQy69Juza7oimpTEbc1YwsUnzwg
 vbEm8AG7bHWGOwvJv2wceHUYfxb4rE1NA5nZMpwaG7K78iPzYRuPnUSa9dn264rmw93fWQkaKeX
 Y0XnwFzGSypLQfKQ=
X-Received: by 2002:a05:6214:410d:b0:62b:6c6f:b3e3 with SMTP id
 kc13-20020a056214410d00b0062b6c6fb3e3mr23516912qvb.3.1691164925931; 
 Fri, 04 Aug 2023 09:02:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHnEQJnI9G43Aze32KHTr9dQDl6D3zVJi8Ow9NkF//HhJHWHUANiVUbIlYNY7zAMsnfE9zYwQ==
X-Received: by 2002:a05:6214:410d:b0:62b:6c6f:b3e3 with SMTP id
 kc13-20020a056214410d00b0062b6c6fb3e3mr23516889qvb.3.1691164925623; 
 Fri, 04 Aug 2023 09:02:05 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 i28-20020a0cab5c000000b0063cf49c35f1sm773315qvb.35.2023.08.04.09.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 09:01:56 -0700 (PDT)
Date: Fri, 4 Aug 2023 12:01:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Zhiyi Guo <zhguo@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>,
 Chensheng Dong <chdong@redhat.com>
Subject: Re: [PATCH for-8.2 v2 1/2] qapi/migration: Deduplicate migration
 parameter field comments
Message-ID: <ZM0g8iNXzv9LRo+w@x1n>
References: <20230803155344.11450-1-peterx@redhat.com>
 <20230803155344.11450-2-peterx@redhat.com>
 <87jzub8016.fsf@pond.sub.org> <ZM0EK3A/rnDPImXz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZM0EK3A/rnDPImXz@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Fri, Aug 04, 2023 at 02:59:07PM +0100, Daniel P. Berrangé wrote:
> On Fri, Aug 04, 2023 at 02:28:05PM +0200, Markus Armbruster wrote:
> > Peter Xu <peterx@redhat.com> writes:
> > 
> > > We used to have three objects that have always the same list of parameters
> > 
> > We have!
> > 
> > > and comments are always duplicated:
> > >
> > >   - @MigrationParameter
> > >   - @MigrationParameters
> > >   - @MigrateSetParameters
> > >
> > > Before we can deduplicate the code, it's fairly straightforward to
> > > deduplicate the comments first, so for each time we add a new migration
> > > parameter we don't need to copy the same paragraphs three times.
> > 
> > De-duplicating the code would be nice, but we haven't done so in years,
> > which suggests it's hard enough not to be worth the trouble.
> 
> The "MigrationParameter" enumeration isn't actually used in
> QMP at all.
> 
> It is only used in HMP for hmp_migrate_set_parameter and
> hmp_info_migrate_parameters. So it is questionable documenting
> that enum in the QMP reference docs at all.
> 
> 1c1
> < { 'struct': 'MigrationParameters',
> ---
> > { 'struct': 'MigrateSetParameters',
> 14,16c14,16
> <             '*tls-creds': 'str',
> <             '*tls-hostname': 'str',
> <             '*tls-authz': 'str',
> ---
> >             '*tls-creds': 'StrOrNull',
> >             '*tls-hostname': 'StrOrNull',
> >             '*tls-authz': 'StrOrNull',
> 
> Is it not valid to use StrOrNull in both cases and thus
> delete the duplication here ?

I tested removing MigrateSetParameters by replacing it with
MigrationParameters and it looks all fine here... I manually tested qmp/hmp
on set/query parameters, and qtests are all happy.

The only thing I see that may affect it is we used to logically allow
taking things like '"tls-authz": null' in the json input, but now we won't
allow that because we'll be asking for a string type only.

Since we have query-qmp-schema I suppose we're all fine, because logically
the mgmt app (libvirt?) will still query that to understand the protocol,
so now we'll have (response of query-qmp-schema):

        {
            "arg-type": "144",
            "meta-type": "command",
            "name": "migrate-set-parameters",
            "ret-type": "0"
        },

Where 144 can start to point to MigrationParameters, rather than
MigrateSetParameters.

Ok, then what if the mgmt app doesn't care and just used "null" in tls-*
fields when setting?  Funnily I tried it and actually anything that does
migrate-set-parameters with a "null" passed over to tls-* fields will
already crash qemu...

./migration/options.c:1333: migrate_params_apply: Assertion `params->tls_authz->type == QTYPE_QSTRING' failed.

#0  0x00007f72f4b2a844 in __pthread_kill_implementation () at /lib64/libc.so.6
#1  0x00007f72f4ad9abe in raise () at /lib64/libc.so.6
#2  0x00007f72f4ac287f in abort () at /lib64/libc.so.6
#3  0x00007f72f4ac279b in _nl_load_domain.cold () at /lib64/libc.so.6
#4  0x00007f72f4ad2147 in  () at /lib64/libc.so.6
#5  0x00005573308740e6 in migrate_params_apply (params=0x7ffc74fd09d0, errp=0x7ffc74fd0998) at ../migration/options.c:1333
#6  0x0000557330874591 in qmp_migrate_set_parameters (params=0x7ffc74fd09d0, errp=0x7ffc74fd0998) at ../migration/options.c:1433
#7  0x0000557330cb9132 in qmp_marshal_migrate_set_parameters (args=0x7f72e00036d0, ret=0x7f72f133cd98, errp=0x7f72f133cd90) at qapi/qapi-commands-migration.c:214
#8  0x0000557330d07fab in do_qmp_dispatch_bh (opaque=0x7f72f133ce30) at ../qapi/qmp-dispatch.c:128
#9  0x0000557330d33bbb in aio_bh_call (bh=0x5573337d7920) at ../util/async.c:169
#10 0x0000557330d33cd8 in aio_bh_poll (ctx=0x55733356e7d0) at ../util/async.c:216
#11 0x0000557330d17a19 in aio_dispatch (ctx=0x55733356e7d0) at ../util/aio-posix.c:423
#12 0x0000557330d34117 in aio_ctx_dispatch (source=0x55733356e7d0, callback=0x0, user_data=0x0) at ../util/async.c:358
#13 0x00007f72f5a8848c in g_main_context_dispatch () at /lib64/libglib-2.0.so.0
#14 0x0000557330d358d4 in glib_pollfds_poll () at ../util/main-loop.c:290
#15 0x0000557330d35951 in os_host_main_loop_wait (timeout=0) at ../util/main-loop.c:313
#16 0x0000557330d35a5f in main_loop_wait (nonblocking=0) at ../util/main-loop.c:592
#17 0x000055733083aee0 in qemu_main_loop () at ../softmmu/runstate.c:732
#18 0x0000557330b0921b in qemu_default_main () at ../softmmu/main.c:37
#19 0x0000557330b09251 in main (argc=35, argv=0x7ffc74fd0ec8) at ../softmmu/main.c:48

Then I suppose it means all mgmt apps are not using "null" anyway, and it
makes more sense to me to just remove MigrateSetParameters (by replacing it
with MigrationParameters).

Then if we can also replace MigrationParameter enum with an internal enum
(alongside with a _str[] array for it) it seems we're all fine to dedup the
3 objects into 1 in qapi schema.

Thanks,

-- 
Peter Xu


