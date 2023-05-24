Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 724F670F2A9
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 11:24:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1kjX-0003Ds-9Y; Wed, 24 May 2023 05:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <LMa@suse.com>)
 id 1q1kjU-00030u-OG; Wed, 24 May 2023 05:24:36 -0400
Received: from mail-db3eur04on0627.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::627]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <LMa@suse.com>)
 id 1q1kjQ-00047I-Tq; Wed, 24 May 2023 05:24:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSpFYYqxfV9pTOIOrkdKLhLIlvlgHYPhRhipUZ5vL69tkXO9zPgLpr1TGhwKzmBl1ApnbRqStKb4xZf1Su3ia9Eu0d9i2HCKufTeqe/wrGAmfORzIFbKaGaJ5z/BY0j6a8jALLli5hSHJ8et2gtKvxIOBl1ZeR5dRIyStMvYVRCDeJ7BTeQqiH8EJQz+AUO+yho7FWv7QRLB+rBPDeZPFlCCyZejzOz+jT6aEOeIZ2q8I8msrA6/o07MykmcvM9yw9vVSd580U9xZeZIO/ClAd65OGCjx/TB+/fK/W9OGALRzMt0JANoenueNvdCQmHID+aAfNKKVRP1poAF5gIsWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHNHwC1IN8blue4+6kH5xmPgF5O6gEKnnZsCx3zJ7ck=;
 b=L1KpyEgigXgXRgzWYKeoTGCb9JkEi7/nza1pnEmpzdhpgCP9o9/TbfLxpXFcIDJXtPb7bewGJRQgdEdJTdgi3FBv03bLBZsRVXNsMfCA5QhSc8Mxf+T9T+HW3hpvVYV8JfWVw+VEVqfqFVYPN87IuSL6076uZUUiJSB27V2At2rvop4hsAb7zJ0PSSW9tI6SwvvyjAB0q9dDL7q1709MXhLQKvA1gXkO9iN7FHXhZj4aOWti1GD2e4S/PIF1kyFVPbUqlG0GafOZ2EL22p0HngSXQFFv/LqDwfvvFtZdVmc5SrlbiYArHwyDAbWl3VwBQ+k8QLHtj+UmAOUoO+prtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHNHwC1IN8blue4+6kH5xmPgF5O6gEKnnZsCx3zJ7ck=;
 b=byHT3GlciLwoMSDEVelyXTlQyFtpMGQgl8eTqBRXceS0ZH8r7gPLAqSm4S/hYN38VNjIW7INmxSZjIehWVIAd7BSkzRR/cSq/yIAiyHxv1kbV24vrR/sblSCff1MNajOFl1eTYUs44LlMK3se8cl5fkrkrq5aVFEZc+1KWzZrEuUNR3ZjSQ49rDwN4cCbEKOwRnEzzSqG0JV7ZkjGZjBIPRuNVuDIt6hw/6M/dViA7g1UDjRBUg/hkDc1p2H+7WiB4eAUmfR0yV7KDk7iYKg/8R+CaFRsA8+WXi1x2p9/gW08BJ4NjYhoxUy8eqW6K1o83eRkTTMVUwweFLRleM9hg==
Received: from AM9PR04MB8602.eurprd04.prod.outlook.com (2603:10a6:20b:439::12)
 by AS8PR04MB8964.eurprd04.prod.outlook.com (2603:10a6:20b:42f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 09:24:29 +0000
Received: from AM9PR04MB8602.eurprd04.prod.outlook.com
 ([fe80::e9bc:73d8:7880:68e5]) by AM9PR04MB8602.eurprd04.prod.outlook.com
 ([fe80::e9bc:73d8:7880:68e5%4]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 09:24:29 +0000
From: Lin Ma <LMa@suse.com>
To: Claudio Fontana <cfontana@suse.de>, Fabiano Rosas <farosas@suse.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Kevin Wolf
 <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, =?iso-8859-1?Q?Jo=E3o_Silva?= <jsilva@suse.de>, Dario
 Faggioli <dfaggioli@suse.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [RFC PATCH 4/6] Convert query-block/info_block to coroutine
Thread-Topic: [RFC PATCH 4/6] Convert query-block/info_block to coroutine
Thread-Index: AQHZjb8K1VEZUiL0nUmQTegjiVoIK69pHeoAgAAI/WM=
Date: Wed, 24 May 2023 09:24:28 +0000
Message-ID: <AM9PR04MB8602DA169BFB69DBD9EF0CE9C5419@AM9PR04MB8602.eurprd04.prod.outlook.com>
References: <20230523213903.18418-1-farosas@suse.de>
 <20230523213903.18418-5-farosas@suse.de>
 <232dd28c-9795-c52a-2d6d-627675c146b8@suse.de>
In-Reply-To: <232dd28c-9795-c52a-2d6d-627675c146b8@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8602:EE_|AS8PR04MB8964:EE_
x-ms-office365-filtering-correlation-id: d5ee66cd-7406-4fba-8245-08db5c38acc2
x-ld-processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lBToUzkyLzlM8tpUCZ3GfOkOmTRAtpKM1VQ4iyJbVu3vbDZ6IghulOMiQ8LHq+RszokVpbVY91lBuORxgebYnjrwaN8HRGmt730t53KBeTgaqthL4Aac0CiN+PCkD6bWlBbC+SCO9Lf3epiKuaOF5/li1jNP2LsZPzlswNylpaCQuYE5FzZ3bbJ9QQLRoo9o8SF2XXggFbNNDYqkxoKoK6Cwi+IPQuX+8iRuR8Mg40hlSgWyVRMqbc2m9UGH0e2QJ3l1NTrucedP7qQFYizErB3H+3b1FEs5TY/euXcRU9A9jT/o2UMyzPM+A531ORVcUZSfIEkom5rxMFNJeKHeiMmZFSCPDd/Ttsj2FKUCTjWtuYvzE7Y3adUSnk4P5qzQ1obHnJibVLlU8fFkkud8bsKBc16qq+6DJkgFKNRH0nFzqIH9oBB6fnohopQ0Fss3BEuTpJM+tU3W343FZDfdxRBkLzhr6+hgyjtlzmfa4hIU2kk1giTRTz1M4gwVVaVoPA/nT9vdJTypFww5LzXHwnsf03ev219+Hr00Qy7b1yeKjx2GNoshvr2A9UxALRsXAA/9ym9KYzPSnT/ahCofCr24aOPe6BwLl3VF9u0OjNENRiD5/qLPKf705LObupkK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8602.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199021)(4326008)(33656002)(5660300002)(52536014)(8676002)(8936002)(38070700005)(86362001)(2906002)(55016003)(38100700002)(122000001)(83380400001)(316002)(66574015)(41300700001)(110136005)(54906003)(71200400001)(478600001)(7696005)(186003)(66476007)(91956017)(66556008)(64756008)(66446008)(76116006)(66946007)(53546011)(9686003)(6506007)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?S/6/QCcNq6jyWgfH503pZQd+BWyG3ilbfLF9TfKcx1YYy9gozc5xcwC1NB?=
 =?iso-8859-1?Q?FlMtHMLHg1PocYELDKyVekrsOhh/BkInM15RZCBB46ie0HlNPpRL9iElTQ?=
 =?iso-8859-1?Q?IAlvt5yEg5K8tw2bTNecICFACnzJGHdo9gFR9xM9RBFt5+H/1v8C9PtMf5?=
 =?iso-8859-1?Q?4uRuNAvqiPFrHIA7/tz+uRAGQwqYl48xtYEl9l5kc40cLXTgJMdf1pFW86?=
 =?iso-8859-1?Q?u1EvS1z80i+0kqokahy+9iF6dGP5FWumKbj9NYqNGGFof2gU2bSDr5iJPM?=
 =?iso-8859-1?Q?/bskvNsxl4DZWgfuHWKCGGUSRbExZi/O6GmzKAhshl1IMW2MK/txPz5q2u?=
 =?iso-8859-1?Q?eOPtlUsY1rx36OwdMcWrmEFswmpzAtbdlC7AhC0f2x8VPNPr33yGFfpHyH?=
 =?iso-8859-1?Q?YUD47hzr6ZHAv1NkfbXBlly0I7ikKd3VBLAmTs1T6rKhDxqRkDP4DFZtB/?=
 =?iso-8859-1?Q?MtyzOBkKqlQT2AMkptmqvLl/XM/uOv9y4mM2sWgyxkYzb58rJLick/ER+R?=
 =?iso-8859-1?Q?kop50iJQfzrB8Qhm3uFS3Tn1qyNs8AK4202CLBNP3158yMxXQbHkT1jiYh?=
 =?iso-8859-1?Q?Kbb5I14l2JAhQZ6FSsxf+01NO+vjC2u2hF4LWqVapoZaKFMLEkqhyi9c7K?=
 =?iso-8859-1?Q?ck7Esha5+AlkQQ5agL3FY2s31FurPN0BgDIojyJ1tllzaZ34jNlHzn2bJN?=
 =?iso-8859-1?Q?EcFO7w07Vktu8fjjENLtWQ9Ag+DU+Rmhx6T7IMRUBKhrwB0yIoj4fDJfHk?=
 =?iso-8859-1?Q?e9sY9fTiM9yvJzKjyD7pPYFFrmXGgreCv9tjYUCOVDRdUIGIKSblq3DKJC?=
 =?iso-8859-1?Q?fcHgiL+0inMQHui3d8Fx+JQjJNeUWq5faU7OYZ/O5IDiTnlS7v0skvl1dc?=
 =?iso-8859-1?Q?D4W2ZaysoDxWw97IXR5qwYeKOgUFn86eWUoRyJiyXD9UzfM6ygvTvNn4hK?=
 =?iso-8859-1?Q?T/EuLNILLFzg5cq2BOFTgtgmBoiItIZkballMaOVhEFS47Xi9LZ0MjXVyW?=
 =?iso-8859-1?Q?quFyIZXbPqOXexDR1rzWMZFJBRVWL19wThjjkqUpITYCQy9ZEo91Ds6xT+?=
 =?iso-8859-1?Q?mxciVNdpjnk/0X1uyfbWFspV6F5kty5LUJWT/8E2JepG0dUm2K4vNxb2kh?=
 =?iso-8859-1?Q?Q298d61m3BavI2zn5nXZv/gbfr7c9BKLXG72lEmTlmOvfqBAbmFepyG4nZ?=
 =?iso-8859-1?Q?qhLU1UTx9TzpawjHdyBThn8W4pwC/7j0E+EbbVcckvc7RHW+ZRhlhhnYms?=
 =?iso-8859-1?Q?k9E3DOUFgZ7D7T1iQ9x+6+FZRakDlmJ0nk/zrzJ0T3yDHdKOYYcrP7mx1P?=
 =?iso-8859-1?Q?jyVhnnpyfezfupEIL71pz82iExOhC1pVugObgNJBW1SJB5myuDffk5sbM1?=
 =?iso-8859-1?Q?3HvC6FdpayI/taVSr4VwhTOYka/tMxhK+5gG4AA6iXhsLQVlcWZEMFtMu4?=
 =?iso-8859-1?Q?7EAUh3+ZJt2Ih+9mxFPafihqnhM9C7QLF7q9MDd3IdSGN9JJPMDNtxRgBN?=
 =?iso-8859-1?Q?3ll+p1bKoukYSuIy7HMAVkwaE8jLdpr3sPW+sOO1/2TJYD3QU0uRVu29Ti?=
 =?iso-8859-1?Q?k8//IfR381c2GdAyP/spLBkyz0qqlswdPQ2g7O84LQGWooYteqCzWvNWHJ?=
 =?iso-8859-1?Q?JlTzinhsbgXk8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8602.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ee66cd-7406-4fba-8245-08db5c38acc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 09:24:28.9298 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2RCGtuYAHayU6VGK8GM265BITcivGbi69bUhkR902gAmJge86IwDEhaI09I2MM8M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8964
Received-SPF: pass client-ip=2a01:111:f400:fe0c::627;
 envelope-from=LMa@suse.com; helo=EUR04-DB3-obe.outbound.protection.outlook.com
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

The query-named-block-nodes is only availabe for qmp, not support hmp yet.

Lin

________________________________________
From: Claudio Fontana <cfontana@suse.de>
Sent: Wednesday, May 24, 2023 4:49 PM
To: Fabiano Rosas; qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org; Kevin Wolf; Hanna Reitz; Markus Armbruster; Jo=
=E3o Silva; Lin Ma; Dario Faggioli; Eric Blake
Subject: Re: [RFC PATCH 4/6] Convert query-block/info_block to coroutine

On 5/23/23 23:39, Fabiano Rosas wrote:
> From: Lin Ma <lma@suse.com>
>
> Sometimes the query-block performs time-consuming I/O(say waiting for
> the fstat of NFS complete), So let's make this QMP handler runs in a
> coroutine.
>
> The following patch moves the fstat() into a thread pool.
>
> Signed-off-by: Lin Ma <lma@suse.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Apart from the wrong subject,

why is this change not including the update to:

hmp-commands-info.hx

like the previous one?

Thanks,

C

> ---
>  blockdev.c           | 6 +++---
>  qapi/block-core.json | 3 ++-
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/blockdev.c b/blockdev.c
> index 5d56b79df4..6412548662 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2804,9 +2804,9 @@ void qmp_drive_backup(DriveBackup *backup, Error **=
errp)
>      blockdev_do_action(&action, errp);
>  }
>
> -BlockDeviceInfoList *qmp_query_named_block_nodes(bool has_flat,
> -                                                 bool flat,
> -                                                 Error **errp)
> +BlockDeviceInfoList *coroutine_fn qmp_query_named_block_nodes(bool has_f=
lat,
> +                                                              bool flat,
> +                                                              Error **er=
rp)
>  {
>      bool return_flat =3D has_flat && flat;
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index da95fe456c..0559c38412 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1972,7 +1972,8 @@
>  { 'command': 'query-named-block-nodes',
>    'returns': [ 'BlockDeviceInfo' ],
>    'data': { '*flat': 'bool' },
> -  'allow-preconfig': true }
> +  'allow-preconfig': true,
> +  'coroutine': true}
>
>  ##
>  # @XDbgBlockGraphNodeType:


