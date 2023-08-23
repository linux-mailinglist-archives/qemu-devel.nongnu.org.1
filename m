Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F907856B1
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 13:23:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYlxL-0007m9-QQ; Wed, 23 Aug 2023 07:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYlxI-0007lh-Nv
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 07:23:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYlxG-0005et-8A
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 07:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692789797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=bfmTzlAhWGe03UxTmi+10qIsSNFoMPavdP6wO+SkjcM=;
 b=Efs3Z1p1nQ8BgB7/UzO74d27joE5SL251F0+ppg163dd/I6U/hd8PNnghk2DXJRLWZ6XZG
 Q0LNvPnPEvPXKYMeEB8h15Dp2SyAP8hcUckIxoJgwEj2BOjD1o1hzYTfFnw/brIitEgjvK
 z0QerUat+PD7tRYyHkSUI3SquRKfiXk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-170-RCy3YWL5M_m3h4q_PlTVCg-1; Wed, 23 Aug 2023 07:23:14 -0400
X-MC-Unique: RCy3YWL5M_m3h4q_PlTVCg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC20D8D40AB;
 Wed, 23 Aug 2023 11:23:11 +0000 (UTC)
Received: from localhost (unknown [10.39.192.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C5A5840D2839;
 Wed, 23 Aug 2023 11:23:00 +0000 (UTC)
Date: Wed, 23 Aug 2023 07:22:59 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Aarushi Mehta <mehta.aaru20@gmail.com>,
 Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Alberto Garcia <berto@igalia.com>, Alessandro Di Federico <ale@rev.ng>,
 Alexander Bulekov <alxndr@bu.edu>, Alexander Graf <agraf@csgraf.de>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Alistair Francis <alistair.francis@wdc.com>,
 Ani Sinha <anisinha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, Anton Johansson <anjo@rev.ng>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Anup Patel <anup.patel@wdc.com>, Ari Sundholm <ari@tuxera.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, BALATON Zoltan <balaton@eik.bme.hu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Bin Meng <bin.meng@windriver.com>, Bin Meng <bmeng.cn@gmail.com>,
 Brad Smith <brad@comstyle.com>, Brian Cain <bcain@quicinc.com>,
 Cameron Esfahani <dirty@apple.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Chris Browy <cbrowy@avery-design.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>,
 Cleber Rosa <crosa@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Corey Minyard <cminyard@mvista.com>,
 Corey Minyard <minyard@acm.org>, Cornelia Huck <cohuck@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, "Denis V. Lunev" <den@openvz.org>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Ed Maste <emaste@freebsd.org>, Eduardo Habkost <eduardo@habkost.net>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Eric Auger <eric.auger@redhat.com>, Eric Blake <eblake@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Fabien Chouteau <chouteau@adacore.com>, Fam Zheng <fam@euphon.net>,
 Felipe Balbi <balbi@kernel.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Francisco Iglesias <francisco.iglesias@xilinx.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Gonglei <arei.gonglei@huawei.com>, Greg Kurz <groug@kaod.org>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Halil Pasic <pasic@linux.ibm.com>, Hanna Reitz <hreitz@redhat.com>,
 Hannes Reinecke <hare@suse.com>, Hao Wu <wuhaotsh@google.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Hongren Zheng <i@zenithal.me>, Huacai Chen <chenhuacai@kernel.org>,
 Huai-Cheng Kuo <hchkuo@avery-design.com.tw>,
 Hyman Huang <yong.huang@smartx.com>, Igor Mammedov <imammedo@redhat.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Ilya Dryomov <idryomov@gmail.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Jan Kiszka <jan.kiszka@web.de>, Jason Herne <jjherne@linux.ibm.com>,
 Jason Wang <jasowang@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Jeff Cody <codyprime@gmail.com>, Jia Liu <proljc@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, Jiri Slaby <jslaby@suse.cz>,
 Joel Stanley <joel@jms.id.au>, John Snow <jsnow@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Juan Quintela <quintela@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Laurent Vivier <lvivier@redhat.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Li Zhijian <lizhijian@fujitsu.com>,
 Luc Michel <luc@lmichel.fr>, Luigi Rizzo <rizzo@iet.unipi.it>,
 Lukas Straub <lukasstraub2@web.de>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Michael Rolnik <mrolnik@gmail.com>, Michael Roth <michael.roth@amd.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Patrick Venture <venture@google.com>,
 Paul Burton <paulburton@kernel.org>, Paul Durrant <paul@xen.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Lieven <pl@kamp.de>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Richard W.M. Jones" <rjones@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Rob Herring <robh@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, Ryo ONODERA <ryoon@netbsd.org>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Sergio Lopez <slp@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Song Gao <gaosong@loongson.cn>, Stafford Horne <shorne@gmail.com>,
 Stefan Berger <stefanb@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Stefan Weil <sw@weilnetz.de>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Su Hang <suhang16@mails.ucas.ac.cn>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Sven Schnelle <svens@stackframe.org>,
 Thomas Huth <huth@tuxfamily.org>, Thomas Huth <thuth@redhat.com>,
 Titus Rwantare <titusr@google.com>, Tony Krowiak <akrowiak@linux.ibm.com>,
 Tyrone Ting <kfting@nuvoton.com>, Vijai Kumar K <vijai@behindbytes.com>,
 Vikram Garhwal <fnu.vikram@xilinx.com>,
 Vikram Garhwal <vikram.garhwal@amd.com>,
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 WANG Xuerui <git@xen0n.name>, Warner Losh <imp@bsdimp.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Xie Yongji <xieyongji@bytedance.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Zhang Chen <chen.zhang@intel.com>,
 zhenwei pi <pizhenwei@bytedance.com>
Subject: Starting the QEMU 8.2 release cycle
Message-ID: <20230823112259.GA820132@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Ad70x3oXfpjYzo1s"
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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


--Ad70x3oXfpjYzo1s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
The QEMU 8.2 release cycle has begun. I am merging qemu.git pull
requests for this release. You do not need to CC me on pull requests
because I am monitoring qemu-devel.

The proposed schedule is as follows:

2023-08-22 	Beginning of development phase
2023-11-14 	Soft feature freeze. Only bug fixes after this point. All feature changes must be already in a sub maintainer tree and all pull requests from submaintainers must have been sent to the list by this date.
2023-11-21 	Hard feature freeze. Tag rc0
2023-11-28 	Tag rc1
2023-12-05 	Tag rc2
2023-12-12 	Tag rc3
2023-12-19 	Release; or tag rc4 if needed
2023-12-26 	Release if we needed an rc4

Please let me know if these dates are inconvenient. I may adjust the
last date depending on my availability at the end of 2023.

Add the following milestone to issues that need to be tracked for this
release:
https://gitlab.com/qemu-project/qemu/-/milestones/10

You can update the changelog here:
https://wiki.qemu.org/ChangeLog/8.2

The release schedule is here:
https://wiki.qemu.org/Planning/8.2

Thanks,
Stefan

--Ad70x3oXfpjYzo1s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTl7BMACgkQnKSrs4Gr
c8iqWQf/RdTmkfoFvsFugU9VPa9J5udGfjtvRyeWTc1EeIB/s0nYb27gOC/UslIm
vFGC+uileb8OEeDIp2rZ68Nx38tx9fCy4G4pNjO7RblRSp28xgoS7zOUHsUfpt2K
ntP4uZAPrH+Pn0BuefTZ3JMYaqNtipAWWKq4yr3aFh5GVakYKRV6YJWzr5PbGPSO
6eJX2PNt+nsPfdbT0dq4ncf//6OMTuvoswlVca62lwUNOO0UcHiBSGAbWZzqqu0l
uQyr2QKNSePr3v5/V/mSnH3O0B/lv+uF+07d4IoJN/MGnIQLTwIRLvwSq83WGmAS
LB42g0nU7W4uUzDdl5Qy2Leuw3dCpQ==
=Cv0s
-----END PGP SIGNATURE-----

--Ad70x3oXfpjYzo1s--


