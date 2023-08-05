Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 812C7770EB3
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 10:13:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSCOR-00049w-Fr; Sat, 05 Aug 2023 04:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qSCON-00049m-9D
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 04:12:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qSCOL-0000HT-3y
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 04:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691223123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RxxeOX75JUwAYvi/XGpR5MDJL8oQk8KhDJzPmtmSU50=;
 b=XV06DG/GUbCH5lNC8Zv9hq72BhdpythTimgTvA/zOo0sOS4ZB+c2hdf96sHRFeCAR8sqm3
 5ucyEucrWhvOqYTpnzBoCSVuvSv4evdBek9ZQumrWOVbMrpHaTspAsaaNMqEzN0cogjkMy
 Vk08yz87eWjHw3nvT4S2/KDd8VxVKy8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-683-h8IS3EwUNdeh9zLH_jDAIQ-1; Sat, 05 Aug 2023 04:12:02 -0400
X-MC-Unique: h8IS3EwUNdeh9zLH_jDAIQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37FF7185A791;
 Sat,  5 Aug 2023 08:12:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EF665F7FBA;
 Sat,  5 Aug 2023 08:12:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CFFCA21E692A; Sat,  5 Aug 2023 10:12:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Markus
 Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,  Zhiyi Guo
 <zhguo@redhat.com>,  Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,  Juan Quintela <quintela@redhat.com>,
 Eric Blake <eblake@redhat.com>,  Chensheng Dong <chdong@redhat.com>
Subject: Re: [PATCH for-8.2 v2 1/2] qapi/migration: Deduplicate migration
 parameter field comments
References: <20230803155344.11450-1-peterx@redhat.com>
 <20230803155344.11450-2-peterx@redhat.com>
 <87jzub8016.fsf@pond.sub.org> <ZM0EK3A/rnDPImXz@redhat.com>
 <ZM0g8iNXzv9LRo+w@x1n> <ZM0nX8qt1T3aZgNK@redhat.com>
 <ZM0rWiHF8voqOdyp@x1n> <ZM0r8VoF8w5vGw7p@redhat.com>
 <ZM1nXbjxWx9jvbjz@x1n>
Date: Sat, 05 Aug 2023 10:12:00 +0200
In-Reply-To: <ZM1nXbjxWx9jvbjz@x1n> (Peter Xu's message of "Fri, 4 Aug 2023
 17:02:21 -0400")
Message-ID: <87zg35x60f.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

> On Fri, Aug 04, 2023 at 05:48:49PM +0100, Daniel P. Berrang=C3=A9 wrote:
>> On Fri, Aug 04, 2023 at 12:46:18PM -0400, Peter Xu wrote:
>> > On Fri, Aug 04, 2023 at 05:29:19PM +0100, Daniel P. Berrang=C3=A9 wrot=
e:
>> > > On Fri, Aug 04, 2023 at 12:01:54PM -0400, Peter Xu wrote:
>> > > > On Fri, Aug 04, 2023 at 02:59:07PM +0100, Daniel P. Berrang=C3=A9 =
wrote:
>> > > > > On Fri, Aug 04, 2023 at 02:28:05PM +0200, Markus Armbruster wrot=
e:
>> > > > > > Peter Xu <peterx@redhat.com> writes:
>> > > > > >=20
>> > > > > > > We used to have three objects that have always the same list=
 of parameters
>> > > > > >=20
>> > > > > > We have!
>> > > > > >=20
>> > > > > > > and comments are always duplicated:
>> > > > > > >
>> > > > > > >   - @MigrationParameter
>> > > > > > >   - @MigrationParameters
>> > > > > > >   - @MigrateSetParameters
>> > > > > > >
>> > > > > > > Before we can deduplicate the code, it's fairly straightforw=
ard to
>> > > > > > > deduplicate the comments first, so for each time we add a ne=
w migration
>> > > > > > > parameter we don't need to copy the same paragraphs three ti=
mes.
>> > > > > >=20
>> > > > > > De-duplicating the code would be nice, but we haven't done so =
in years,
>> > > > > > which suggests it's hard enough not to be worth the trouble.
>> > > > >=20
>> > > > > The "MigrationParameter" enumeration isn't actually used in
>> > > > > QMP at all.
>> > > > >=20
>> > > > > It is only used in HMP for hmp_migrate_set_parameter and
>> > > > > hmp_info_migrate_parameters. So it is questionable documenting
>> > > > > that enum in the QMP reference docs at all.
>> > > > >=20
>> > > > > 1c1
>> > > > > < { 'struct': 'MigrationParameters',
>> > > > > ---
>> > > > > > { 'struct': 'MigrateSetParameters',
>> > > > > 14,16c14,16
>> > > > > <             '*tls-creds': 'str',
>> > > > > <             '*tls-hostname': 'str',
>> > > > > <             '*tls-authz': 'str',
>> > > > > ---
>> > > > > >             '*tls-creds': 'StrOrNull',
>> > > > > >             '*tls-hostname': 'StrOrNull',
>> > > > > >             '*tls-authz': 'StrOrNull',
>> > > > >=20
>> > > > > Is it not valid to use StrOrNull in both cases and thus
>> > > > > delete the duplication here ?
>> > > >=20
>> > > > I tested removing MigrateSetParameters by replacing it with
>> > > > MigrationParameters and it looks all fine here... I manually teste=
d qmp/hmp
>> > > > on set/query parameters, and qtests are all happy.
>> > >=20
>> > > I meant the other way around, such we would be using 'StrOrNull'
>> > > in all scenarios.
>> >=20
>> > Yes, that should also work and even without worrying on nulls.  I just=
 took
>> > a random one replacing the other.
>> >=20
>> > >=20
>> > > >=20
>> > > > The only thing I see that may affect it is we used to logically al=
low
>> > > > taking things like '"tls-authz": null' in the json input, but now =
we won't
>> > > > allow that because we'll be asking for a string type only.
>> > > >=20
>> > > > Since we have query-qmp-schema I suppose we're all fine, because l=
ogically
>> > > > the mgmt app (libvirt?) will still query that to understand the pr=
otocol,
>> > > > so now we'll have (response of query-qmp-schema):
>> > > >=20
>> > > >         {
>> > > >             "arg-type": "144",
>> > > >             "meta-type": "command",
>> > > >             "name": "migrate-set-parameters",
>> > > >             "ret-type": "0"
>> > > >         },
>> > > >=20
>> > > > Where 144 can start to point to MigrationParameters, rather than
>> > > > MigrateSetParameters.
>> > > >=20
>> > > > Ok, then what if the mgmt app doesn't care and just used "null" in=
 tls-*
>> > > > fields when setting?  Funnily I tried it and actually anything tha=
t does
>> > > > migrate-set-parameters with a "null" passed over to tls-* fields w=
ill
>> > > > already crash qemu...
>> > > >=20
>> > > > ./migration/options.c:1333: migrate_params_apply: Assertion `param=
s->tls_authz->type =3D=3D QTYPE_QSTRING' failed.
>> > > >=20
>> > > > #0  0x00007f72f4b2a844 in __pthread_kill_implementation () at /lib=
64/libc.so.6
>> > > > #1  0x00007f72f4ad9abe in raise () at /lib64/libc.so.6
>> > > > #2  0x00007f72f4ac287f in abort () at /lib64/libc.so.6
>> > > > #3  0x00007f72f4ac279b in _nl_load_domain.cold () at /lib64/libc.s=
o.6
>> > > > #4  0x00007f72f4ad2147 in  () at /lib64/libc.so.6
>> > > > #5  0x00005573308740e6 in migrate_params_apply (params=3D0x7ffc74f=
d09d0, errp=3D0x7ffc74fd0998) at ../migration/options.c:1333
>> > > > #6  0x0000557330874591 in qmp_migrate_set_parameters (params=3D0x7=
ffc74fd09d0, errp=3D0x7ffc74fd0998) at ../migration/options.c:1433
>> > > > #7  0x0000557330cb9132 in qmp_marshal_migrate_set_parameters (args=
=3D0x7f72e00036d0, ret=3D0x7f72f133cd98, errp=3D0x7f72f133cd90) at qapi/qap=
i-commands-migration.c:214
>> > > > #8  0x0000557330d07fab in do_qmp_dispatch_bh (opaque=3D0x7f72f133c=
e30) at ../qapi/qmp-dispatch.c:128
>> > > > #9  0x0000557330d33bbb in aio_bh_call (bh=3D0x5573337d7920) at ../=
util/async.c:169
>> > > > #10 0x0000557330d33cd8 in aio_bh_poll (ctx=3D0x55733356e7d0) at ..=
/util/async.c:216
>> > > > #11 0x0000557330d17a19 in aio_dispatch (ctx=3D0x55733356e7d0) at .=
./util/aio-posix.c:423
>> > > > #12 0x0000557330d34117 in aio_ctx_dispatch (source=3D0x55733356e7d=
0, callback=3D0x0, user_data=3D0x0) at ../util/async.c:358
>> > > > #13 0x00007f72f5a8848c in g_main_context_dispatch () at /lib64/lib=
glib-2.0.so.0
>> > > > #14 0x0000557330d358d4 in glib_pollfds_poll () at ../util/main-loo=
p.c:290
>> > > > #15 0x0000557330d35951 in os_host_main_loop_wait (timeout=3D0) at =
../util/main-loop.c:313
>> > > > #16 0x0000557330d35a5f in main_loop_wait (nonblocking=3D0) at ../u=
til/main-loop.c:592
>> > > > #17 0x000055733083aee0 in qemu_main_loop () at ../softmmu/runstate=
.c:732
>> > > > #18 0x0000557330b0921b in qemu_default_main () at ../softmmu/main.=
c:37
>> > > > #19 0x0000557330b09251 in main (argc=3D35, argv=3D0x7ffc74fd0ec8) =
at ../softmmu/main.c:48
>> > > >=20
>> > > > Then I suppose it means all mgmt apps are not using "null" anyway,=
 and it
>> > > > makes more sense to me to just remove MigrateSetParameters (by rep=
lacing it
>> > > > with MigrationParameters).
>> > >=20
>> > > It shouldn't be crashing,  because qmp_migrate_set_parameters()
>> > > is turning 'null' into  "", which means the assert ought to
>> > > never fire. Did you have a local modiification that caused
>> > > this crash perhaps ?
>> >=20
>> > I think it just got overlooked when introducing tls-authz to not have =
added
>> > that special code in qmp_migrate_set_parameters(), the other two are f=
ine.
>>=20
>> Oh right yes, pre-existing bug.
>
> So do we really care about "null" in any form over "" (empty str) here for
> tls-* parameters?

In my opinion, the use of "" was a design mistake.  Here's my argument:

commit 01fa55982692fb51a16049b63b571651a1053989
Author: Markus Armbruster <armbru@redhat.com>
Date:   Tue Jul 18 14:42:04 2017 +0200

    migration: Use JSON null instead of "" to reset parameter to default
=20=20=20=20
    migrate-set-parameters sets migration parameters according to is
    arguments like this:
=20=20=20=20
    * Present means "set the parameter to this value"
=20=20=20=20
    * Absent means "leave the parameter unchanged"
=20=20=20=20
    * Except for parameters tls_creds and tls_hostname, "" means "reset
      the parameter to its default value
=20=20=20=20
    The first two are perfectly normal: presence of the parameter makes
    the command do something.
=20=20=20=20
    The third one overloads the parameter with a second meaning.  The
    overloading is *implicit*, i.e. it's not visible in the types.  Works
    here, because "" is neither a valid TLS credentials ID, nor a valid
    host name.
=20=20=20=20
    Pressing argument values the schema accepts, but are semantically
    invalid, into service to mean "reset to default" is not general, as
    suitable invalid values need not exist.  I also find it ugly.
=20=20=20=20
    To clean this up, we could add a separate flag argument to ask for
    "reset to default", or add a distinct value to @tls_creds and
    @tls_hostname.  This commit implements the latter: add JSON null to
    the values of @tls_creds and @tls_hostname, deprecate "".
=20=20=20=20
    Because we're so close to the 2.10 freeze, implement it in the
    stupidest way possible: have qmp_migrate_set_parameters() rewrite null
    to "" before anything else can see the null.  The proper way to do it
    would be rewriting "" to null, but that requires fixing up code to
    work with null.  Add TODO comments for that.
=20=20=20=20
    Signed-off-by: Markus Armbruster <armbru@redhat.com>
    Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
    Reviewed-by: Eric Blake <eblake@redhat.com>

> To fix this tls-authz bug we can add one more QTYPE_QNULL to QTYPE_QSTRING
> convertion, but I'd rather just use "str" for all tls* fields and remove
> the other two instead, if "null" is not important to anyone.

"Important" sounds too much like absolutes :)

I think we have a tradeoff here.  If perpetuating the unclean and ugly
use of "" is what it takes to de-triplicate migration parameters, we may
decide to accept that.

> In all cases, I've appended with the two patches I'm currently testing
> with.  It should also fix the tls-authz crash over 'null' by just rejecti=
ng
> that.  But I'm open to anything - the patch (more than RFC) is more for
> reference of whether we can drop the two objects in qapi/migration.
>
> Thanks,


