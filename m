Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB868B7E56
	for <lists+qemu-devel@lfdr.de>; Tue, 30 Apr 2024 19:22:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1rAu-0006kN-VL; Tue, 30 Apr 2024 13:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1s1rAq-0006iT-R7
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 13:21:49 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1s1rAn-0004vN-7Z
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 13:21:48 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VTRnD3pzXz6K8yJ;
 Wed,  1 May 2024 01:21:20 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id C03CC140518;
 Wed,  1 May 2024 01:21:38 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 30 Apr
 2024 18:21:38 +0100
Date: Tue, 30 Apr 2024 18:21:37 +0100
To: Markus Armbruster <armbru@redhat.com>
CC: fan <nifan.cxl@gmail.com>, <qemu-devel@nongnu.org>,
 <linux-cxl@vger.kernel.org>, <gregory.price@memverge.com>,
 <ira.weiny@intel.com>, <dan.j.williams@intel.com>,
 <a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>, 
 <jim.harris@samsung.com>, <Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan
 Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v7 09/12] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <20240430182137.00006417@Huawei.com>
In-Reply-To: <87h6fkob0t.fsf@pond.sub.org>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <20240418232902.583744-10-fan.ni@samsung.com>
 <877cgkxzal.fsf@pond.sub.org> <Zivk37xBGPsL_yo5@debian>
 <87h6fkob0t.fsf@pond.sub.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, 29 Apr 2024 09:58:42 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> fan <nifan.cxl@gmail.com> writes:
>=20
> > On Fri, Apr 26, 2024 at 11:12:50AM +0200, Markus Armbruster wrote: =20
> >> nifan.cxl@gmail.com writes: =20
>=20
> [...]
>=20
> >> > diff --git a/qapi/cxl.json b/qapi/cxl.json
> >> > index 4281726dec..2dcf03d973 100644
> >> > --- a/qapi/cxl.json
> >> > +++ b/qapi/cxl.json
> >> > @@ -361,3 +361,72 @@
> >> >  ##
> >> >  {'command': 'cxl-inject-correctable-error',
> >> >   'data': {'path': 'str', 'type': 'CxlCorErrorType'}}
> >> > +
> >> > +##
> >> > +# @CXLDCExtentRecord: =20
> >>=20
> >> Such traffic jams of capital letters are hard to read.  What about
> >> CxlDynamicCapacityExtent?
> >>  =20
> >> > +#
> >> > +# Record of a single extent to add/release =20
> >>=20
> >> Suggest "A dynamic capacity extent."
> >>  =20
> >> > +#
> >> > +# @offset: offset to the start of the region where the extent to be=
 operated =20
> >>=20
> >> Blank line here, please.
> >>=20
> >>=20
> >>  =20
> >> > +# @len: length of the extent
> >> > +#
> >> > +# Since: 9.1
> >> > +##
> >> > +{ 'struct': 'CXLDCExtentRecord',
> >> > +  'data': {
> >> > +      'offset':'uint64',
> >> > +      'len': 'uint64'
> >> > +  }
> >> > +}
> >> > +
> >> > +##
> >> > +# @cxl-add-dynamic-capacity:
> >> > +#
> >> > +# Command to start add dynamic capacity extents flow. The device wi=
ll
> >> > +# have to acknowledged the acceptance of the extents before they ar=
e usable. =20
> >>=20
> >> This text needs work.  More on that at the end of my review. =20
> >
> > Yes. I will work on it for the next version once all the feedbacks
> > are collected and comments are resolved.
> >
> > See below.
> > =20
> >>=20
> >> docs/devel/qapi-code-gen.rst:
> >>=20
> >>     For legibility, wrap text paragraphs so every line is at most 70
> >>     characters long.
> >>=20
> >>     Separate sentences with two spaces.
> >>=20
> >> More elsewhere.
> >>  =20
> >> > +#
> >> > +# @path: CXL DCD canonical QOM path =20
> >>=20
> >> I'd prefer @qom-path, unless you can make a consistency argument for
> >> @path.
> >>=20
> >> Sure the QOM path needs to be canonical?
> >>=20
> >> If not, what about "path to the CXL dynamic capacity device in the QOM
> >> tree".  Intentionally close to existing descriptions of @qom-path
> >> elsewhere. =20
> >
> > From the same file, I saw "path" was used for other commands, like
> > "cxl-inject-memory-module-event", so I followed it.
> > DCD is nothing different from "type 3 device" expect it can dynamically
> > change capacity.=20
> > Renaming it to "qom-path" is no problem for me, just want to make sure =
it
> > will not break the naming consistency. =20
>=20
> Both @path and @qom-path are used (sadly).  @path is used for all kinds
> of paths, whereas @qom-path is only used for QOM paths.  That's why I
> prefer it.
>=20
> However, you're making a compelling local consistency argument: cxl.json
> uses only @path.  Sticking to that makes sense.
>=20
> >> > +# @hid: host id =20
> >>=20
> >> @host-id, unless "HID" is established terminology in CXL DCD land. =20
> >
> > host-id works. =20
> >>=20
> >> What is a host ID? =20
> >
> > It is an id identifying the host to which the capacity is being added. =
=20
>=20
> How are these IDs assigned?

Right now there is only 1 option.  We can drop this for now and introduce
it when needed (Default of 0 will be fine).  Multi head device patches
that will need this are on list though I haven't read them yet :(

>=20
> >> > +# @selection-policy: policy to use for selecting extents for adding=
 capacity =20
> >>=20
> >> Where are selection policies defined? =20
> >
> > It is defined in CXL specification: Specifies the policy to use for sel=
ecting
> > which extents comprise the added capacity =20
>=20
> Include a reference to the spec here?
>=20
> >> > +# @region-id: id of the region where the extent to add =20
> >>=20
> >> Is "region ID" the established terminology in CXL DCD land?  Or is
> >> "region number" also used?  I'm asking because "ID" in this QEMU device
> >> context suggests a connection to a qdev ID.
> >>=20
> >> If region number is fine, I'd rename to just @region, and rephrase the
> >> description to avoid "ID".  Perhaps "number of the region the extent is
> >> to be added to".  Not entirely happy with the phrasing, doesn't exactly
> >> roll off the tongue, but "where the extent to add" sounds worse to my
> >> ears.  Mind, I'm not a native speaker. =20
> >
> > Yes. region number is fine. Will rename it as "region"
> > =20
> >>  =20
> >> > +# @tag: Context field =20
> >>=20
> >> What is this about? =20
> >
> > Based on the specification, it is "Context field utilized by implementa=
tions
> > that make use of the Dynamic Capacity feature.". Basically, it is a
> > string (label) attached to an dynamic capacity extent so we can achieve
> > specific purpose, like identifying or grouping extents. =20
>=20
> Include a reference to the spec here?

Agreed - that is the best we can do. It'sa  magic value.

>=20
> >> > +# @extents: Extents to add =20
> >>=20
> >> Blank lines between argument descriptions, please.
> >>  =20
> >> > +#
> >> > +# Since : 9.1
> >> > +##
> >> > +{ 'command': 'cxl-add-dynamic-capacity',
> >> > +  'data': { 'path': 'str',
> >> > +            'hid': 'uint16',
> >> > +            'selection-policy': 'uint8',
> >> > +            'region-id': 'uint8',
> >> > +            'tag': 'str',
> >> > +            'extents': [ 'CXLDCExtentRecord' ]
> >> > +           }
> >> > +}
> >> > +
> >> > +##
> >> > +# @cxl-release-dynamic-capacity:
> >> > +#
> >> > +# Command to start release dynamic capacity extents flow. The host =
will
> >> > +# need to respond to indicate that it has released the capacity bef=
ore it
> >> > +# is made unavailable for read and write and can be re-added. =20
> >>=20
> >> This text needs work.  More on that at the end of my review. =20
> >
> > Will do.
> > =20
> >>  =20
> >> > +#
> >> > +# @path: CXL DCD canonical QOM path =20
> >>=20
> >> My comment on cxl-add-dynamic-capacity applies.
> >>  =20
> >> > +# @hid: host id =20
> >>=20
> >> Likewise.
> >>  =20
> >> > +# @flags: bit[3:0] for removal policy, bit[4] for forced removal, b=
it[5] for
> >> > +#     sanitize on release, bit[7:6] reserved =20
> >>=20
> >> Where are these flags defined? =20
> >
> > Defined in the CXL specification, it defines the release behaviour. =20
>=20
> Include a reference to the spec here?
>=20
> Is the numeric encoding of flags appropriate?

Could definitely break them out as a bunch of flags / symbolic for
the policy.

>=20
> In general, we prefer symbolic encodings.  Numeric encodings can make
> sense when
>=20
> =E2=80=A2 the encoding is stable, and
>=20
> =E2=80=A2 QEMU doesn't need to decode it, only pass it on to something el=
se, and
>=20
> =E2=80=A2 both the QMP client and the "something else" prefer a numeric
>   encoding.

I don't think that really applies here - though Gregory's shim from
MCTP to this will have to go through a simple dance to fill them in.

>=20
> >> > +# @region-id: id of the region where the extent to release =20
> >>=20
> >> My comment on cxl-add-dynamic-capacity applies.
> >>  =20
> >> > +# @tag: Context field =20
> >>=20
> >> Likewise.
> >>  =20
> >> > +# @extents: Extents to release
> >> > +#
> >> > +# Since : 9.1
> >> > +##
> >> > +{ 'command': 'cxl-release-dynamic-capacity',
> >> > +  'data': { 'path': 'str',
> >> > +            'hid': 'uint16',
> >> > +            'flags': 'uint8',
> >> > +            'region-id': 'uint8',
> >> > +            'tag': 'str',
> >> > +            'extents': [ 'CXLDCExtentRecord' ]
> >> > +           }
> >> > +} =20
> >>=20
> >> During review of v5, you wrote:
> >>=20
> >>     For add command, the host will send a mailbox command to response =
to
> >>     the add request to the device to indicate whether it accepts the a=
dd
> >>     capacity offer or not.
> >>    =20
> >>     For release command, the host send a mailbox command (not always a
> >>     response since the host can proactively release capacity if it does
> >>     not need it any more) to device to ask device release the capacity.
> >>=20
> >> Can you briefly sketch the protocol?  Peers and messages involved.
> >> Possibly as a state diagram. =20
> >
> > Need to think about it. If we can polish the text nicely, maybe the
> > sketch is not needed. My concern is that the sketch may
> > introduce unwanted complexity as we expose too much details. The two
> > commands provide ways to add/release dynamic capacity to/from a host,
> > that is all. All the other information, like what the host will do, or
> > how the device will react, are consequence of the command, not sure
> > whether we want to include here. =20
>=20
> The protocol sketch is for me, not necessarily the doc comment.  I'd
> like to understand at high level how this stuff works, because only then
> can I meaningfully review the docs.
>=20
> > @Jonathan, Any thoughts on this?=20
Makes sense to have a bit of artwork to explain what is going on.
Suitable stuff for the cover letter or patch description for v8
as well as in reply here.  Simple flows should be enough, we don't
need to worry on the messy corner cases (hopefully)

1) Offer extents to a host  + it accepts.
2) Ask for it back, it gives it back.

I can put my non existent artistic talents on it later in the
week if Fan doesn't get there first.

>=20
> Thanks!
>=20


