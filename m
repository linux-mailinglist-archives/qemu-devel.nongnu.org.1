Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0708324BA
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 07:42:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQiYj-0007Oq-MH; Fri, 19 Jan 2024 01:40:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentao.jia@nephogine.com>)
 id 1rQiYg-0007Oc-Sc
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 01:40:54 -0500
Received: from mail-mw2nam10on2115.outbound.protection.outlook.com
 ([40.107.94.115] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentao.jia@nephogine.com>)
 id 1rQiYf-0005PZ-5r
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 01:40:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgXn4zHL5J5MXzefk8/flI3XhVFv6qAfNcv/SeuDVvfdyzeLXZCS0Vf8Z02XW3YI4fSX6kUbCUiRVPEJuNv4FV9RrkSCyGz3SCIY0UvthE6k6BgHfmDEcliHd5XFxYJ44fzyk3BF4V0wtN3S+/JwFWhQTuNgnVX+xJfSxsIG3Abx+zBIeR6ZkBHuDQeB3Y1HaqYgStxoGz8Qnl0Vryo1eBtVJzdGI5+XtSwjcWL9NdfWKe47ba3OXBl/sLqyDjSJVGZcdt8nrynT2UllRg/Bnqok3r3l1BHq13drGXN92yzQNvLNEROKvhBbRSkSVcFjLK/YgX4BNx7F7xY8jk7aQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5R5eB6JMv9HyPUydpNNCvmzxclX1e23cTkV+MB4Hy4=;
 b=MWEe5tEIVR8XhcJf4qySAQ+yIHs3CX3105mdfBaVKyTz6dAEdJJrI9//gE8/gqKuBW3Re8A26N8IohKrQsErU/l9x0raXB87gbwat0TuFJUPT7lyPcdcZvdYTKZqY1px3Z/MRtEOVD5k1cG0F6gxGY9gZKtzUkifh6+U9RXyh6OtpG2C/joNaRsMOOLMeaPJ0HCf7cTgX+RtTpJ3ii0BD9ETRnbiUabLwaVqS5CFrfgoMOsF2dWS8jqCm/UEexs+EDlicKVRHtcWPXjH3OuCUSWiR01pJ8V11aAqZNnxTSrKguLAAlF+mfB/AQs1LhYiTtS/lXKsS12xwC//bW6qLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nephogine.com; dmarc=pass action=none
 header.from=nephogine.com; dkim=pass header.d=nephogine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nephogine.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5R5eB6JMv9HyPUydpNNCvmzxclX1e23cTkV+MB4Hy4=;
 b=jg9GPhSVsy5XfCKfzSw8TAvNQjb0LKCYwVYdwDE7fAGG5Z3VcUO3AQY8x+Fef1BGGMzbZ1UfJ/TR7VRsW0JGgubFho88KV0G0jFkEHDpdboWsQkNsVZSCY73x0+hiR+KSWd11EuM9cyMXjStGBuJu/FBMD65a+u6s0EGCeTLTovDrxRdhK54nCoskLpOKxCCymvYykTnHsOmrjMXIY08y+HtAEl/qcXfiwLvhZ5F4szXYJn/yl3iIe3Ms9MNrqQwmkclCmStV5NbOji2W9KA+3X+3X9sltA3IT/K8p47GlbiIeNr+ohdg43MhPr8+U/z+q66aIQpQU1NiW/7obXhyg==
Received: from SN4PR13MB5727.namprd13.prod.outlook.com (2603:10b6:806:213::12)
 by MW3PR13MB4121.namprd13.prod.outlook.com (2603:10b6:303:5b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 06:35:44 +0000
Received: from SN4PR13MB5727.namprd13.prod.outlook.com
 ([fe80::4ae0:9319:cd44:9350]) by SN4PR13MB5727.namprd13.prod.outlook.com
 ([fe80::4ae0:9319:cd44:9350%4]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 06:35:44 +0000
From: Wentao Jia <wentao.jia@nephogine.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, Rick Zhong
 <zhaoyong.zhong@nephogine.com>, Jason Wang <jasowang@redhat.com>
Subject: RE: FW: [PATCH] vhost-user: add VIRTIO_F_IN_ORDER and
 VIRTIO_F_NOTIFICATION_DATA feature
Thread-Topic: FW: [PATCH] vhost-user: add VIRTIO_F_IN_ORDER and
 VIRTIO_F_NOTIFICATION_DATA feature
Thread-Index: AdokPrZLsAJfb0btQhCy7EbMDce/EgY4mSYwAAJ9PgAABGqn8AAAz8ygAfvHuzAAhk7OgAA1l2oAAAD22YAAB9kDgACXz1iA
Date: Fri, 19 Jan 2024 06:35:44 +0000
Message-ID: <SN4PR13MB5727D5A7AD34F7169E2A236F86702@SN4PR13MB5727.namprd13.prod.outlook.com>
References: <SN4PR13MB5727A538887598415C5A37D28681A@SN4PR13MB5727.namprd13.prod.outlook.com>
 <SN4PR13MB5727D7B4E7CC91345135A5058661A@SN4PR13MB5727.namprd13.prod.outlook.com>
 <CACGkMEvwanHfheCMo-gDjzx1DrX51AMtoaYJ9PcE0yYmZdA+Uw@mail.gmail.com>
 <SN4PR13MB5727A90B141E383127F1E25D8661A@SN4PR13MB5727.namprd13.prod.outlook.com>
 <SN4PR13MB572773EF8D25A2E2C5AE48608661A@SN4PR13MB5727.namprd13.prod.outlook.com>
 <SN4PR13MB57274870E6BBFC76749E8D96866F2@SN4PR13MB5727.namprd13.prod.outlook.com>
 <CACGkMEu6X2L-eawwsy_pE1mVVDU7V=Qe_51YrK16W-kKu4BGxA@mail.gmail.com>
 <SN4PR13MB572738F10FAE449DDBD735D686732@SN4PR13MB5727.namprd13.prod.outlook.com>
 <CACGkMEtHQHmhBAF6WguUSHr+iFMmOjvTshqpGzkvE=QtkgVVPA@mail.gmail.com>
 <SN4PR13MB5727AF7CB6E6CF563B618F1386732@SN4PR13MB5727.namprd13.prod.outlook.com>
In-Reply-To: <SN4PR13MB5727AF7CB6E6CF563B618F1386732@SN4PR13MB5727.namprd13.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nephogine.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN4PR13MB5727:EE_|MW3PR13MB4121:EE_
x-ms-office365-filtering-correlation-id: a88021c0-dc50-44da-29b5-08dc18b8dd4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ++WXsWBZid14xxVYb+d269STm3pM/SWghaNzttoHg/52jm1lyS76CehfX92aicISBq3hFq1JM/gqsn/Nn/qYc7s16UKdpjFKGIXEVd72dj8HH/IZI++xcF/jeNbzOmRTLkdmZfvRO3Cc3E1zKgfot68BwLI0Ef+BzinNtB5iKAYhvUTOss7YsTpmdxN7WY8AAoda8F5FHZneWUeyBm2O8UgzYENedc7vos+z+dH0n14vDySaBjK0C+KFJfnMVMbxTiPAtMrXcsbK0Tf6yOcfMUXT+ATK1HiPfpZOF0/jLRvVX1aehFZh/SzKpS6otpmE5P0SySPlmLpCNa+3Wzz9SFaoYyMYe+OV+RwhoFDDcEJePI0u91FuJ2tmo3HFmcshM6gwr5MnFtsFEo2VHlXs/BT/PGHfIZCw3JgGP7LYzwi2/BtZ3HZtAFXUtf/K7dT3yQ1tseWxrcDx1w9nNl39jxqrX/2f/nHmInsDLdwku4ejNO2JGOPCEwO8Ql3xJhCDnAWBaWGL6qxmST+jckeRIlPpPgOxYTh9oEemrKYS+PpQY9y75FJ03LMvZV7zPn17A+bDmh4Nu6OX5Vj+B0ZmPViKIlriHSBPHiFqchZGaiVJ7PhRCZAISKgT+9fEWQxl
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR13MB5727.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(366004)(376002)(39840400004)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(55016003)(38070700009)(6506007)(8676002)(5660300002)(8936002)(83380400001)(26005)(76116006)(6916009)(71200400001)(64756008)(4326008)(478600001)(316002)(9686003)(54906003)(7696005)(66556008)(66476007)(66446008)(66946007)(52536014)(44832011)(122000001)(38100700002)(2906002)(86362001)(41300700001)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVNnNVhZOXVFbStnU2hzMGVBZnJxNVc3WTR0R2F4ckMyQU1sTXRMa2JzSFZW?=
 =?utf-8?B?cmU4ejMxZjk4Z0NNa0ZrRWN2WUFScncxRzZmaUcwWDFKWmNoTU9ua1U4TWdP?=
 =?utf-8?B?VTl6VnRRVU9GRm9xakJRT0RneEJZcHRSTGgxd1VUVWw4djFqR1RDL2ZDd0sr?=
 =?utf-8?B?cytqQk0rcGxoNzN1OEZFenZkNHhNQWpZTXRQV1d2OEpkQ05vSm1meFIza2Zm?=
 =?utf-8?B?N3IwcDBOTExwMXdVbTZMQkNKSXdyLzkycFZUbVVNOGM3d3J5bHorSTZBWFNt?=
 =?utf-8?B?ZVp3Vk44OHFDcE9LR08wNmdHdnVydWpSQjJwMEJJaGdHRi82SmovTnRtOGl4?=
 =?utf-8?B?L29XT3p4bU16SkFDT3I2V1RVTzNKTDZMdVZEZ2FZK2Jmc29hbm9NTXFuVk9T?=
 =?utf-8?B?Tnp2Ymxma1lqLzU3MGlmcUppTXkvelkrWnBQRHM3QmZBWU5MNCtZVDJMeGFx?=
 =?utf-8?B?MUtPU3RURXpDbWEwUzU5Nld6VG4zV0Z0Y1ZDNm90QUdQTnprcjB0QUJPOC82?=
 =?utf-8?B?ZDVEc3NKWlhUUlRLdHNYSUxobUt6N1pXVElQcFZPLzBxcmV1NGNzV1dPb0s1?=
 =?utf-8?B?bUtxd2M0Sjl5dDZDMnI2Mm44NjhQNUxFTU9GcDBJQ0NvT1BJNzFqc2grd1FK?=
 =?utf-8?B?MFVscUhGQzdJVmR3Y0w3azVVN3NmVjYzak1hUmdqbDdwc1FUVFdLLy9KL1Bs?=
 =?utf-8?B?bEEvZDlQeDVUN0c3STVMaVdXK2xxUERlZUIxQ3Vadm5KbzFDUzF1TVhOdVpG?=
 =?utf-8?B?ek1IUDYrQU9yWXExYWp5cTZBcG81WnpyTnl6S1NnYjA3QmQxbkNTSUdYUmJQ?=
 =?utf-8?B?TUNmamVydTNPalhpVEhFUEJWdjlFTWRVR3J2MGtsS0k5YUsvRzdnbERhRDdj?=
 =?utf-8?B?c1RQdTFQdXNjemZ0NlZld3Z0SkwyQWM0L1k2WDNVM0JLeU9CQ0VOQXQwMmpx?=
 =?utf-8?B?bEFKSk1QNGsyZjdqc3pvb0tuZkxlRlRSTk1jWWwxVVBaWklhaWJVQm5qMXk2?=
 =?utf-8?B?YmJtSGNsZTZpZDBsSHpmQXYrY0FtYmR1N1dkZExFQzhyZTVlR055R2tkeElN?=
 =?utf-8?B?eEhHSmJhMkdadlhQcStwaUhRMmVGeWwxQzdtZE5iQlptQUlneWYzRlczNFRp?=
 =?utf-8?B?VzU1ZUxBVnBVcGg2RVpRUEJUSXRqY2NsNlFBYjlWdStwM1g5MWp5RjVvMEY0?=
 =?utf-8?B?MS9ocHd4eWh1Q1ZycjJiaW9iL2ZrV1g1WFVjdkVzdGt3ZkkvZXdWV2Evc0Vy?=
 =?utf-8?B?U3hnek9kUUtObS9FR3NFcG44MVFBblFhNXhzakVnWll0Y1c1VUVXdk4yYVJK?=
 =?utf-8?B?aFVYb002WENkOExDVHFWdFBoVU54R21LcXhBWWlTdmVuN01aa3k5aFRPck9p?=
 =?utf-8?B?UlpMUmN1djNnQ1NBL2ExVnJWLzd1M2Y4T1dOMFFub0l2V2xPOENjdU96cHJn?=
 =?utf-8?B?b2Y3a0kwcVBueStaY3I5aTBqMS9kaVFvMUJkd2lQeFBzYjNCZUpzZzMvMVZu?=
 =?utf-8?B?Y3YrLzBzOHc1VStid2RISXlEK1JZaTNpY1hSMFBGeGx0VDdYZGdxUUw0MXlW?=
 =?utf-8?B?aWJsQi9la2tBM3JDNExOeDZKV2JiQmxtYXl6clUybXR1RlFlbFVrWlU3d2s1?=
 =?utf-8?B?ZnJWYkhGeTZ0Q0Z2TDBOeUZOVTZJWElNUUd2TVBLUmRLUHlJV05MY29oSWtv?=
 =?utf-8?B?WS9janV3STlSajRDVFRTNUwvWmFpOHUxdFh0eTBHR3JYdHUxSVdRSCt2eDJI?=
 =?utf-8?B?S2I2SDNUVGJnZ1lpL3FESTFQWm40V2tCaXJ4czZNYjFRTlFCTk1Za0oxYjBj?=
 =?utf-8?B?L21tdG10TlozMytLMWR0N0xrK3hZRXBuNGlodkgyajUzNkhYa0IveHNSaUJ3?=
 =?utf-8?B?YTZBSDdpMm95TitLbTJDaTdPcGY0bDJRQmRnZ2RuL1IzM2d3d0Y4RFhIOG9N?=
 =?utf-8?B?NUdTRmgydlBwcEFmR1JPUGFQT1I2bjNPK1VuSkJTL1dOTWM0Tk9WdDhDS21n?=
 =?utf-8?B?Y3VnYWI0aElncnF6cDdtYnJNLy9XaWZtRFJ3SGEyNXBQbjZPZWk2dU1LdDFQ?=
 =?utf-8?B?MDE0bmhGMlBUclFSZVRLa2luZjlPV0J3bkIxVXd0Mlo1ZnI2c3BOUkZFbFgw?=
 =?utf-8?Q?sYD7a/YZWwzwSpu+XRZDQYHe1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nephogine.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR13MB5727.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a88021c0-dc50-44da-29b5-08dc18b8dd4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 06:35:44.5451 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aQbRsPpgIcJ4KFpsfSlU64KLOBuEYeh3FXTjS6Blm9LNGZ3Pf2bfvBHryRhR6f90pIj8eeBVcpTQj//Mp/LTzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR13MB4121
Received-SPF: pass client-ip=40.107.94.115;
 envelope-from=wentao.jia@nephogine.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

DQpWSVJUSU9fRl9JTl9PUkRFUiBhbmQgVklSVElPX0ZfTk9USUZJQ0FUSU9OX0RBVEEgZmVhdHVy
ZSBhcmUgaW1wb3J0YW50IGZlYXR1cmUNCmZvciBkcGRrIHZkcGEgcGFja2V0cyB0cmFuc21pdHRp
bmcgcGVyZm9ybWFuY2UsIGFkZCB0aGUgMiBmZWF0dXJlcyBhdCB2aG9zdC11c2VyDQpmcm9udC1l
bmQgdG8gbmVnb3RpYXRpb24gd2l0aCBiYWNrZW5kLg0KDQpTaWduZWQtb2ZmLWJ5OiBLeWxlIFh1
IDx6aGVuYmluZy54dUBjb3JpZ2luZS5jb20+DQpTaWduZWQtb2ZmLWJ5OiBXZW50YW8gSmlhIDx3
ZW50YW8uamlhQGNvcmlnaW5lLmNvbT4NClJldmlld2VkLWJ5OiAgIFhpbnlpbmcgWXUgPHhpbnlp
bmcueXVAY29yaWdpbmUuY29tPg0KUmV2aWV3ZWQtYnk6ICAgU2h1amluZyBEb25nIDxzaHVqaW5n
LmRvbmdAY29yaWdpbmUuY29tPg0KUmV2aWV3ZWQtYnk6ICAgUmljayBaaG9uZyA8emhhb3lvbmcu
emhvbmdAY29yaWdpbmUuY29tPg0KLS0tDQogaHcvY29yZS9tYWNoaW5lLmMgICB8IDIgKysNCiBo
dy9uZXQvdmhvc3RfbmV0LmMgIHwgMiArKw0KIGh3L25ldC92aXJ0aW8tbmV0LmMgfCA0ICsrKysN
CiAzIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvaHcvY29y
ZS9tYWNoaW5lLmMgYi9ody9jb3JlL21hY2hpbmUuYw0KaW5kZXggZmI1YWZkY2FlNC4uZTYyMGY1
ZTdkMCAxMDA2NDQNCi0tLSBhL2h3L2NvcmUvbWFjaGluZS5jDQorKysgYi9ody9jb3JlL21hY2hp
bmUuYw0KQEAgLTQwLDYgKzQwLDcgQEAgR2xvYmFsUHJvcGVydHkgaHdfY29tcGF0XzhfMVtdID0g
ew0KICAgICB7ICJyYW1mYiIsICJ4LW1pZ3JhdGUiLCAib2ZmIiB9LA0KICAgICB7ICJ2ZmlvLXBj
aS1ub2hvdHBsdWciLCAieC1yYW1mYi1taWdyYXRlIiwgIm9mZiIgfSwNCiAgICAgeyAiaWdiIiwg
IngtcGNpZS1mbHItaW5pdCIsICJvZmYiIH0sDQorICAgIHsgVFlQRV9WSVJUSU9fTkVULCAibm90
aWZpY2F0aW9uX2RhdGEiLCAib2ZmIn0sDQogfTsNCiBjb25zdCBzaXplX3QgaHdfY29tcGF0Xzhf
MV9sZW4gPSBHX05fRUxFTUVOVFMoaHdfY29tcGF0XzhfMSk7DQoNCkBAIC02NSw2ICs2Niw3IEBA
IEdsb2JhbFByb3BlcnR5IGh3X2NvbXBhdF83XzFbXSA9IHsNCiAgICAgeyAidmlydGlvLXJuZy1w
Y2kiLCAidmVjdG9ycyIsICIwIiB9LA0KICAgICB7ICJ2aXJ0aW8tcm5nLXBjaS10cmFuc2l0aW9u
YWwiLCAidmVjdG9ycyIsICIwIiB9LA0KICAgICB7ICJ2aXJ0aW8tcm5nLXBjaS1ub24tdHJhbnNp
dGlvbmFsIiwgInZlY3RvcnMiLCAiMCIgfSwNCisgICAgeyBUWVBFX1ZJUlRJT19ORVQsICJpbl9v
cmRlciIsICJvZmYifSwNCiB9Ow0KIGNvbnN0IHNpemVfdCBod19jb21wYXRfN18xX2xlbiA9IEdf
Tl9FTEVNRU5UUyhod19jb21wYXRfN18xKTsNCg0KZGlmZiAtLWdpdCBhL2h3L25ldC92aG9zdF9u
ZXQuYyBiL2h3L25ldC92aG9zdF9uZXQuYw0KaW5kZXggZThlMTY2MTY0Ni4uMjExY2E4NTlhNiAx
MDA2NDQNCi0tLSBhL2h3L25ldC92aG9zdF9uZXQuYw0KKysrIGIvaHcvbmV0L3Zob3N0X25ldC5j
DQpAQCAtNzYsNiArNzYsOCBAQCBzdGF0aWMgY29uc3QgaW50IHVzZXJfZmVhdHVyZV9iaXRzW10g
PSB7DQogICAgIFZJUlRJT19GX0lPTU1VX1BMQVRGT1JNLA0KICAgICBWSVJUSU9fRl9SSU5HX1BB
Q0tFRCwNCiAgICAgVklSVElPX0ZfUklOR19SRVNFVCwNCisgICAgVklSVElPX0ZfSU5fT1JERVIs
DQorICAgIFZJUlRJT19GX05PVElGSUNBVElPTl9EQVRBLA0KICAgICBWSVJUSU9fTkVUX0ZfUlNT
LA0KICAgICBWSVJUSU9fTkVUX0ZfSEFTSF9SRVBPUlQsDQogICAgIFZJUlRJT19ORVRfRl9HVUVT
VF9VU080LA0KZGlmZiAtLWdpdCBhL2h3L25ldC92aXJ0aW8tbmV0LmMgYi9ody9uZXQvdmlydGlv
LW5ldC5jDQppbmRleCA3YTI4NDZmYTFjLi5kYzBhMDI4OTM0IDEwMDY0NA0KLS0tIGEvaHcvbmV0
L3ZpcnRpby1uZXQuYw0KKysrIGIvaHcvbmV0L3ZpcnRpby1uZXQuYw0KQEAgLTM5NDksNiArMzk0
OSwxMCBAQCBzdGF0aWMgUHJvcGVydHkgdmlydGlvX25ldF9wcm9wZXJ0aWVzW10gPSB7DQogICAg
ICAgICAgICAgICAgICAgICAgIFZJUlRJT19ORVRfRl9HVUVTVF9VU082LCB0cnVlKSwNCiAgICAg
REVGSU5FX1BST1BfQklUNjQoImhvc3RfdXNvIiwgVmlydElPTmV0LCBob3N0X2ZlYXR1cmVzLA0K
ICAgICAgICAgICAgICAgICAgICAgICBWSVJUSU9fTkVUX0ZfSE9TVF9VU08sIHRydWUpLA0KKyAg
ICBERUZJTkVfUFJPUF9CSVQ2NCgiaW5fb3JkZXIiLCBWaXJ0SU9OZXQsIGhvc3RfZmVhdHVyZXMs
DQorICAgICAgICAgICAgICAgICAgICAgIFZJUlRJT19GX0lOX09SREVSLCB0cnVlKSwNCisgICAg
REVGSU5FX1BST1BfQklUNjQoIm5vdGlmaWNhdGlvbl9kYXRhIiwgVmlydElPTmV0LCBob3N0X2Zl
YXR1cmVzLA0KKyAgICAgICAgICAgICAgICAgICAgICBWSVJUSU9fRl9OT1RJRklDQVRJT05fREFU
QSwgdHJ1ZSksDQogICAgIERFRklORV9QUk9QX0VORF9PRl9MSVNUKCksDQogfTsNCg0KLS0NCg0K

