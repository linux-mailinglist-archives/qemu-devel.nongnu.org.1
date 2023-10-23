Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E38F7D2EBC
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 11:44:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qurT2-0001wg-67; Mon, 23 Oct 2023 05:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+91fa634947ba19782c4e+7365+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1qurSy-0001wA-SX; Mon, 23 Oct 2023 05:43:21 -0400
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+91fa634947ba19782c4e+7365+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1qurSv-0006ub-LQ; Mon, 23 Oct 2023 05:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=QJnLNJLIKQ/1yQL84M0rKohbw6CIp8aEbajAdE1XPdk=; b=CUdLWyALBJqmFbDGesKzP61pFX
 yMyqMvl8eVP0caNQqIuXFssX8lBUzWgpK0Cz1fE8ycmQ7Zc364gqWYFOTEzYFjujFruaRGkPf/g16
 2GvuZQFH7+oO5B5p06BuB9jm6y2Zb0P3hOi7BsVk8I5q9ZzHdu8NlWI5fNR9PAEQX1FoAvUwcQygR
 BrsvhK9U4XPB2XlRKtxIRyatSt0Ur8ot4pBTYRH2JCADNdaRtv6ro02JzxVUyyL4XCxYYdUYirxQk
 sSvo6tPiHXwM1MjlSxzPFY4mccQVObrvA0FIliR8oJ5LExfja1ipELp+yx7XX+ndJ15ku4AvAk9s8
 aSwfOOyQ==;
Received: from [31.94.4.150] (helo=[IPv6:::1])
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1qurSo-00D2s3-IS; Mon, 23 Oct 2023 09:43:10 +0000
Date: Mon, 23 Oct 2023 10:42:58 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Igor Mammedov <imammedo@redhat.com>
CC: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Marcelo Tosatti <mtosatti@redhat.com>, 
 qemu-block@nongnu.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_11/12=5D_hw/xen=3A_automaticall?=
 =?US-ASCII?Q?y_assign_device_index_to_block_devices?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20231023113002.0e83c209@imammedo.users.ipa.redhat.com>
References: <20231016151909.22133-1-dwmw2@infradead.org>
 <20231016151909.22133-12-dwmw2@infradead.org>
 <20231018093239.3d525fd8@imammedo.users.ipa.redhat.com>
 <3f3487af227dcdce7afb37e8406d5ce8dcdbf55f.camel@infradead.org>
 <20231023113002.0e83c209@imammedo.users.ipa.redhat.com>
Message-ID: <8CBFDABE-6BD7-4924-BB69-EF5EAA04A34D@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+91fa634947ba19782c4e+7365+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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



On 23 October 2023 10:30:02 BST, Igor Mammedov <imammedo@redhat=2Ecom> wro=
te:
>On Wed, 18 Oct 2023 09:32:47 +0100
>David Woodhouse <dwmw2@infradead=2Eorg> wrote:
>
>> On Wed, 2023-10-18 at 09:32 +0200, Igor Mammedov wrote:
>> > On Mon, 16 Oct 2023 16:19:08 +0100
>> > David Woodhouse <dwmw2@infradead=2Eorg> wrote:
>> >  =20
>> > > From: David Woodhouse <dwmw@amazon=2Eco=2Euk>
>> > >  =20
>> >=20
>> > is this index a user (guest) visible? =20
>>=20
>> Yes=2E It defines what block device (e=2Eg=2E /dev/xvda) the disk appea=
rs as
>> in the guest=2E In the common case, it literally encodes the Linux
>> major/minor numbers=2E So xvda (major 202) is 0xca00, xvdb is 0xca10 et=
c=2E
>
>that makes 'index' an implicit ABI and a subject to versioning
>when the way it's assigned changes (i=2Ee=2E one has to use versioned
>machine types to keep older versions working the they used to)=2E
>
>From what I remember it's discouraged to make QEMU invent
>various IDs that are part of ABI (guest or mgmt side)=2E
>Instead it's preferred for mgmt side/user to provide that explicitly=2E
>
>Basically you are trading off manageability/simplicity at QEMU
>level with CLI usability for human user=2E
>I don't care much as long as it is hidden within xen code base,
>but maybe libvirt does=2E

Well, it can still be set explicitly=2E So not so much a "trade-off" as ad=
ding the option for the user to choose the simple way=2E

Yes, in a way it's an ABI, just like the dynamic assignment of PCI devfn f=
or network devices added with "-nic"=2E And I think also for virtio block d=
evices too? And for the ISA ne2000=2E

But it seems unlikely that we'll ever really want to change "the first one=
 is xvda, the second is xvdb=2E=2E=2E=2E"

