Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BED70EC85
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 06:24:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1g2L-000111-Qc; Wed, 24 May 2023 00:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <LMa@suse.com>)
 id 1q1g2K-00010o-Eu; Wed, 24 May 2023 00:23:44 -0400
Received: from mail-vi1eur04on060e.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::60e]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <LMa@suse.com>)
 id 1q1g2I-00079C-HL; Wed, 24 May 2023 00:23:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwXB2tuXL1rGQXDs3nF6Mb/NNDHBhbTTZhLXmE2GEeAB4CB6KBfbY5pBHT5loQbuswt3EvqkHSymnqNmnA9bQahvxSexRdOQ7yQUUF8LS3bYSFHhej525e1fZSpcxc5UKvUxLhKNmwvJb1JL3aJ/KWUKDQBT3shKBXr+Ik0GF909mIB0ShpamDmlbqfBGzgwMtWqEHqVCMt1WAhGVwrx3NWZu1Rdh/ngqW26OS+hJfQ0grFL9vAF+NDjkyJIbFPVrf/hf896tEnhsjLEpUC83L9nmRt8cupmZUvEam2JB/1MX9kVvB1jTJwzT7vM+anKSTTIz9KWVMHIlD0fqiAxaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAI6HkmK5u5WXfYUI0NE6v/dSKZ06H/sj/lUHuP1hYQ=;
 b=Xju+UIDrTFSN03UR19PJzTWCfNFE+2W0Mvv7iWRSIh0+ouDdgdxu68PwJbPM8MytZs3L3Ir4Au0Vs0uZIj4PTBpbTIIuwV7fDeTgp6KY9f59j0mGr3ts3Xzayp3hqxOoCvhOoAqENz6dJ0+AnJUlWqnBMOYsd7BSX3cx6e6EmcvZsGac3YUUBvWFK8J7S5CrytmmOQRXKIm1sGsFCHlTgPx77NJN03o4arVcgB+aLko9lkDWyEQEZK30MCkrMKAOBHIV4oQwAbuUxHGtFvq0WbvM0xfNen0HqAH+DgotIJIReuDkMrnGNImC/+UZY6n2XhEScHpxVNIAXQd6cf/3/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAI6HkmK5u5WXfYUI0NE6v/dSKZ06H/sj/lUHuP1hYQ=;
 b=eCrt0koESgADSamsXjF/S4vpLz3GIS7yCnfZKMD4UpjdgKgJ/4Q45r2C34RHGPmdKLghmMR3twhZd4ILvszGc4bIM3ppH+K8LlIMDfzdUkRboGoWXfMS2OZWeGmdga4hfeZgWtiyks2Y3XA2Csz3imZD6yMxIv6JhVnuDl58rGjSJtnTsL6mqvnMpcMKqoTK/WJf9oQ0Wze156pqmoCUIG8uARU34RFvYtx8C8JPAMKYZM5vzwS/DPo1i2CvSC6l3K3EBYKpebS7AUxNjFiJfOmQsC7Y3snP9L3wGoQcO5i9xrGQmeVXdtlOY/Oot2367Qyxe2O8mZAV84cSDwVYMw==
Received: from AM9PR04MB8602.eurprd04.prod.outlook.com (2603:10a6:20b:439::12)
 by AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.25; Wed, 24 May
 2023 04:23:36 +0000
Received: from AM9PR04MB8602.eurprd04.prod.outlook.com
 ([fe80::e9bc:73d8:7880:68e5]) by AM9PR04MB8602.eurprd04.prod.outlook.com
 ([fe80::e9bc:73d8:7880:68e5%4]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 04:23:36 +0000
From: Lin Ma <LMa@suse.com>
To: Fabiano Rosas <farosas@suse.de>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Kevin Wolf
 <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, =?iso-8859-1?Q?Jo=E3o_Silva?= <jsilva@suse.de>, Claudio
 Fontana <cfontana@suse.de>, Dario Faggioli <dfaggioli@suse.com>, Eric Blake
 <eblake@redhat.com>
Subject: Re: [RFC PATCH 4/6] Convert query-block/info_block to coroutine
Thread-Topic: [RFC PATCH 4/6] Convert query-block/info_block to coroutine
Thread-Index: AQHZjb8K1VEZUiL0nUmQTegjiVoIK69o0uzS
Date: Wed, 24 May 2023 04:23:35 +0000
Message-ID: <AM9PR04MB860233F22701D1A5483216EAC5419@AM9PR04MB8602.eurprd04.prod.outlook.com>
References: <20230523213903.18418-1-farosas@suse.de>
 <20230523213903.18418-5-farosas@suse.de>
In-Reply-To: <20230523213903.18418-5-farosas@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8602:EE_|AS4PR04MB9338:EE_
x-ms-office365-filtering-correlation-id: 0fad1a7d-adef-4ff1-8f8c-08db5c0ea454
x-ld-processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: apHQufyBS9lvN2RdY00n2Qd6PMqhCaFwFkXRJ5X7b+9TxamjVFOKKPrTIkNXWm1vZzba/d4FOq4rXk4dIT/moUE6I//Dcr8Md1yy6m11ETqqHdpaCAXJelb3z26v2NSpdkxeHCRi2ju7c2ctGNp5IfW6eIO37zCiix6JZasLUl2hIW74qA2rZMF1LeZAwbJ6c3BLA2oPGCp1ArMrV7SdYi90806s9Z/fhgZNMNCFse6RjB5Vs4EBqnAVqknHZiMmvtefAXU7DT3371La8QLrsu6/LJ4cDTkQroq3nxXUwn18wK/fwRWsgEDOr1LAHWPOToB5K3bMLh9Dr+MdS2wQfD1uwgnzpjQgkJPhJ328kzyc+mGpzC+I7zfEsu4fgYUNN7fmmx+Kmql/jY7XBPm+dXHp6YL1LiBzJ7KoPlJbFuMDAFBtiGceXVBwIqtHydL494gbTL+n7tBJXsH6A3Qa2t9CIwEr/WnOH6+uImp2vg86r4czsWKgXd8WqEuKa0eef5ORec58YcjSOOoNFHLBByFyph9XekFk+VEhXwFQLvUFYOjKCHCjU+mXZWMulGnEP6OtlCTB0lJyVvWcEyanRiCGDFEjnPluDS/WT2tAlkZmWfTOsNgc2p0dTxJrBcoS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8602.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199021)(8676002)(83380400001)(8936002)(55016003)(66556008)(478600001)(4326008)(33656002)(86362001)(38100700002)(91956017)(66946007)(64756008)(66476007)(122000001)(66446008)(52536014)(76116006)(5660300002)(110136005)(54906003)(316002)(2906002)(71200400001)(7696005)(186003)(41300700001)(38070700005)(6506007)(26005)(9686003)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IPGY/IVFV8L5NqH+zqFG5c2riLM64kgEuibWl/Q5zvpDVQ6qrMH9gJzFZd?=
 =?iso-8859-1?Q?V/vrDsW3aLt0heqDG9yFHY8enDwtL90Ry/VZzIbH0HXlCWIu1GoXh2OeQ/?=
 =?iso-8859-1?Q?QW0p2lQt7yRgbgtaFN8DE8UiVQ8GLR5jwi95PCW/lHATSFtQnrY1CIK3Jq?=
 =?iso-8859-1?Q?M4dAXhbgh/QQJroM2y6yEAPFYDx6tZuNz0WG0JZntVUIaQR5dEl8j3oPnN?=
 =?iso-8859-1?Q?lr1kNfTVqpeDSVxxe+RxCfSvRxz3Bhge/DQogSbp0ggsmt16byszCgoSZo?=
 =?iso-8859-1?Q?Ugm1OINYPUf53g6TlX0QIBWD7FJc17VRrxKReHRJBAOjm0O2wMMbiIJPG7?=
 =?iso-8859-1?Q?r8gxWuxwK5j6q/GseP4Noy+FdCHFFAGQeFn2ra5fsvqclUK3OOy11PJEez?=
 =?iso-8859-1?Q?i31MiodCJL1J/qH40xE42b/PDNn9DI0kDJCdljDChv5NkIlxTmEfQBKqDr?=
 =?iso-8859-1?Q?8oA0u4wy5ptS8Te8DD32dJqztZdAwSVl3W/5zwRU0CBfHWKqMupstcyDWa?=
 =?iso-8859-1?Q?s7jBn06mEyZ2Q6KzYBMgOzGtKeY0NE2UWsGYOQqa85ZsxgJfvzfLnDN2yl?=
 =?iso-8859-1?Q?2UuBR9IiMe+b4svL2/sXw4FpfTqR7Mu4yxAji7f/93Ya7iNQG8VGUhBwA9?=
 =?iso-8859-1?Q?QLkdrWDupLsD7qpB+kLMXTXYI8mncBRR45DGpDNxn06vjmZmvJTXYvr3f1?=
 =?iso-8859-1?Q?Q+EsWvnYGY4ye6H8j4YHxtULy3RpV6Ks8AcWfsfjg66wvhrEzoGJhN+h21?=
 =?iso-8859-1?Q?jwKUqOiGal0Fn1BiY8yqTqmlD4Z3yqdH3gu45XxfNJ1UGK3ZXUTYiDirqs?=
 =?iso-8859-1?Q?tneyCgwfn8jGR50k5SEEWTGg3f0EdjFXQ+bFoCQqT00E2VH5nzKhwPEoUb?=
 =?iso-8859-1?Q?v9nmXAMni7Dr1j6LKcORKh1AQhs9Rg5H3JgTaFVn94E55nc7xhcclqQDXt?=
 =?iso-8859-1?Q?+lJh6TFgs8sM+FDq651IxMkJW+E8dM/PgyrhVPfLVEMUdlCTXN7HiJ+8fo?=
 =?iso-8859-1?Q?IuxQCKHU5W9A2OntMVp2gPrS4BTzldeg+LIwo/OjDJBWBVFVjz1DHdjbAj?=
 =?iso-8859-1?Q?uQx8mmD8MEn0WPOrPOwneAbNMo7nvpyR9ScSy/96tXXYUElkJkMdBGLeFb?=
 =?iso-8859-1?Q?9OKA5crb8VhJOJgtYBFuSHACJ66fiOMrruAUu8g7mKAy3KucRD/AvmQmrA?=
 =?iso-8859-1?Q?0k9yBiDGjYYXRfn9MVCwwj9r4DmMKk03llvukFrWLX1Fo9GTfpwl1jE0yV?=
 =?iso-8859-1?Q?ZffU6QhTVpHyPCgjbmZh9jfwZxN3WHISvP9p0RLWiTMzIis9sDeCPncuoS?=
 =?iso-8859-1?Q?4l88ytRiP7v9wRi+PknA7AJYvLFN1IzBCbHnCUTWw6SL1bEkhWMbYL6tnh?=
 =?iso-8859-1?Q?CFG55iPKej2OgAwmAGJk0AOv5EtntLNmwd78ConfQWIRRlO3UeN3mnxxp1?=
 =?iso-8859-1?Q?Y+EiR4wedInS/3tjrK5I2rmwrkS0cPsZufPrmiUwAOHhwLlObb2b89YNZa?=
 =?iso-8859-1?Q?Em0aXv8WOzZrvtffNSvzFx32SF/Tf63BLuOwjFb37rmvOr36Gu7p9GprcX?=
 =?iso-8859-1?Q?OIx8i4NAj8ty6AX6Se3A7vSoVVuc30NQoRevkgNjZXD2dLzKrw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8602.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fad1a7d-adef-4ff1-8f8c-08db5c0ea454
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 04:23:35.8775 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t/gBfrV5swMglOMMy9GWAE6CozgFlEERoDm2cBdzz1H98MXb027tGn0JqK4IlRL9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9338
Received-SPF: pass client-ip=2a01:111:f400:fe0e::60e;
 envelope-from=LMa@suse.com; helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The commit title/message are duplicated to previous one, Here should
use "query-named-block-nodes" instead.

Lin

________________________________________
From: Fabiano Rosas <farosas@suse.de>
Sent: Wednesday, May 24, 2023 5:39 AM
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org; Kevin Wolf; Hanna Reitz; Markus Armbruster; Jo=
=E3o Silva; Lin Ma; Claudio Fontana; Dario Faggioli; Eric Blake
Subject: [RFC PATCH 4/6] Convert query-block/info_block to coroutine

From: Lin Ma <lma@suse.com>

Sometimes the query-block performs time-consuming I/O(say waiting for
the fstat of NFS complete), So let's make this QMP handler runs in a
coroutine.

The following patch moves the fstat() into a thread pool.

Signed-off-by: Lin Ma <lma@suse.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 blockdev.c           | 6 +++---
 qapi/block-core.json | 3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 5d56b79df4..6412548662 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2804,9 +2804,9 @@ void qmp_drive_backup(DriveBackup *backup, Error **er=
rp)
     blockdev_do_action(&action, errp);
 }

-BlockDeviceInfoList *qmp_query_named_block_nodes(bool has_flat,
-                                                 bool flat,
-                                                 Error **errp)
+BlockDeviceInfoList *coroutine_fn qmp_query_named_block_nodes(bool has_fla=
t,
+                                                              bool flat,
+                                                              Error **errp=
)
 {
     bool return_flat =3D has_flat && flat;

diff --git a/qapi/block-core.json b/qapi/block-core.json
index da95fe456c..0559c38412 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1972,7 +1972,8 @@
 { 'command': 'query-named-block-nodes',
   'returns': [ 'BlockDeviceInfo' ],
   'data': { '*flat': 'bool' },
-  'allow-preconfig': true }
+  'allow-preconfig': true,
+  'coroutine': true}

 ##
 # @XDbgBlockGraphNodeType:
--
2.35.3


