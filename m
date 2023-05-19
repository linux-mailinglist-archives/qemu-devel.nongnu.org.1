Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 247D0709B88
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 17:46:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q02Ia-0006m8-JO; Fri, 19 May 2023 11:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q02IY-0006lv-6z
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:45:42 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q02IW-0001EC-10
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:45:41 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QN9zs3769z6J77x;
 Fri, 19 May 2023 23:41:13 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 19 May
 2023 16:45:33 +0100
Date: Fri, 19 May 2023 16:45:33 +0100
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
 <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
 "Ira Weiny" <ira.weiny@intel.com>, Michael Roth <michael.roth@amd.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Markus Armbruster <armbru@redhat.com>, "Daniel
 P . =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, Eric Blake
 <eblake@redhat.com>, Mike Maslenkin <mike.maslenkin@gmail.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, "Thomas
 Huth" <thuth@redhat.com>
Subject: Re: [PATCH v6 6/7] hw/cxl/events: Add injection of DRAM events
Message-ID: <20230519164533.0000436d@Huawei.com>
In-Reply-To: <6dc139cc-ec19-196f-017a-cb0a415af3e5@linaro.org>
References: <20230519143043.30191-1-Jonathan.Cameron@huawei.com>
 <20230519143043.30191-7-Jonathan.Cameron@huawei.com>
 <6dc139cc-ec19-196f-017a-cb0a415af3e5@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, 19 May 2023 17:34:20 +0200
Philippe Mathieu-Daud=E9 <philmd@linaro.org> wrote:

> Hi Jonathan,
>=20
> On 19/5/23 16:30, Jonathan Cameron wrote:
> > Defined in CXL r3.0 8.2.9.2.1.2 DRAM Event Record, this event
> > provides information related to DRAM devices.
> >=20
> > Example injection command in QMP:
> >=20
> > { "execute": "cxl-inject-dram-event",
> >      "arguments": {
> >          "path": "/machine/peripheral/cxl-mem0",
> >          "log": "informational",
> >          "flags": 1,
> >          "physaddr": 1000,
> >          "descriptor": 3,
> >          "type": 3,
> >          "transaction-type": 192,
> >          "channel": 3,
> >          "rank": 17,
> >          "nibble-mask": 37421234,
> >          "bank-group": 7,
> >          "bank": 11,
> >          "row": 2,
> >          "column": 77,
> >          "correction-mask": [33, 44, 55,66]
> >      }}
> >=20
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >   hw/mem/cxl_type3.c          | 116 ++++++++++++++++++++++++++++++++++++
> >   hw/mem/cxl_type3_stubs.c    |  13 ++++
> >   include/hw/cxl/cxl_events.h |  23 +++++++
> >   qapi/cxl.json               |  35 +++++++++++
> >   4 files changed, 187 insertions(+) =20
>=20
>=20
> > diff --git a/qapi/cxl.json b/qapi/cxl.json
> > index 7e1e6257ce..5e82097e76 100644
> > --- a/qapi/cxl.json
> > +++ b/qapi/cxl.json
> > @@ -55,6 +55,41 @@
> >               '*device': 'uint32', '*component-id': 'str'
> >               }}
> >  =20
> > +##
> > +# @cxl-inject-dram-event:
> > +#
> > +# Inject an event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2)
> > +# This event type is reported via one of the event logs specified via
> > +# the log parameter.
> > +#
> > +# @path: CXL type 3 device canonical QOM path
> > +# @log: Event Log to add the event to
> > +# @flags: header flags
> > +# @physaddr: Physical Address =20
>=20
> Could this be a clearer description?
>=20
> "Physical Address (relative to @path device)"

Makes sense.

>=20
> > +# @descriptor: Descriptor
> > +# @type: Type
> > +# @transaction-type: Transaction Type
> > +# @channel: Channel
> > +# @rank: Rank
> > +# @nibble-mask: Identify one or more nibbles that the error affects =20
>=20
> > +# @bank-group: Bank group
> > +# @bank: Bank
> > +# @row: Row
> > +# @column: Column =20
>=20
> Why do we need bank/raw/col if we have physaddr?

Yes we need them. We don't know the device geometry / internal interleaving
/ address hashing applied to smooth out access patterns etc.

I really don't want to put that level of complexity into the command
line for a device - so just left it to the test tools to squirt in
something valid.

>=20
> These are optional. Shouldn't we check they are valid
> in qmp_cxl_inject_dram_event()? (No clue, just wondering
> if there is some duplication here).

Validation is really hard for these as depends on the above
device implementation complexity.  There is a note on trying to
strike the balance in the cover letter. I'm not sure I have it
right! They are optional in records coming from the device, so
we set validity flags for them in the device record.

Aim here is to be able to inject whatever might be seen on a real device
without having to have QEMU emulate a bunch of device internals
such as mappings to particular DRAM FRU, chip, column, row etc.


>=20
> > +# @correction-mask: Bits within each nibble. Used in order of bits set
> > +#                   in the nibble-mask.  Up to 4 nibbles may be covere=
d.
> > +#
> > +# Since: 8.1
> > +##
> > +{ 'command': 'cxl-inject-dram-event',
> > +  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
> > +            'physaddr': 'uint64', 'descriptor': 'uint8',
> > +            'type': 'uint8', 'transaction-type': 'uint8',
> > +            '*channel': 'uint8', '*rank': 'uint8', '*nibble-mask': 'ui=
nt32',
> > +            '*bank-group': 'uint8', '*bank': 'uint8', '*row': 'uint32',
> > +            '*column': 'uint16', '*correction-mask': [ 'uint64' ]
> > +           }}
> > +
> >   ##
> >   # @cxl-inject-poison:
> >   # =20
>=20


