Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F282F7E8525
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 22:35:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1Z98-0002eD-FX; Fri, 10 Nov 2023 16:34:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56783987ff=volodymyr_babchuk@epam.com>)
 id 1r1YKl-00011X-9B
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 15:42:31 -0500
Received: from mx0a-0039f301.pphosted.com ([148.163.133.242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56783987ff=volodymyr_babchuk@epam.com>)
 id 1r1YKj-0003HS-HU
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 15:42:31 -0500
Received: from pps.filterd (m0174677.ppops.net [127.0.0.1])
 by mx0a-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AAKIjQr010025
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 20:42:25 GMT
Received: from eur05-am6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2104.outbound.protection.outlook.com [104.47.18.104])
 by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3u9kkysufj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 20:42:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eY6ZtJoSsG9tNk9ekdvVm/QYnfhlSk7EW4b+sbg041g5M0osff0RNsNWo8IdMhdzxudgbjwgMO3CWCG8u02V+/3AKCXJL1hCwxOie3eyoFHxq9HVJnJ/ocgwu+Y00x46V164sa8sX0mYLFxa6JQYt3PMx62fC9KsFK7m7I6a2hd5u/gztP4OQVc6b9w0BmwoHZE71B/7RiHQI83jSk3v94kjXxAMGOINWE9lDitHH0cM4sX1PopBWRMxxTu/SUE0QcyzJ9YXlm9A3S58ZzGpyNKLPkRmtqcszo5L1w3HzHUT5DFipdezBkr0vYxA8oDTFcLJrNjvRyrQMfz+ET3ROw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/2fdBWpdypUXcPPa7J/eI6gJWXKJUOw+/7CCV+mDS8=;
 b=N2a5Piu/sKiQiS63TzjzEoEGbktF3o6XzmqF/uGP6ux8GspkoTci7iuXYrSk7Z4I3eHBkDZp+M4HBKVTAqk61Yq8+Kmso8mtaiiM8OWXJOuAD6oyJxs08jqRdGnJ2L/WfHg4GWoA1+ii8xM9E3zxdeyxxrD86v5Y/EeKLskgf3LQeMI/y1+/vQ8ei1V6vfKUnXhmA7PWYZ+wFeEqSGjwHmemNeosjs7zinme27aZJkG3SAz2RSU4mrDcSYedxrJ4H5AOTRHU1213CAwx47CBYo09Bqo7qy7vWJKDLAF9WD2CCQtA4HaDpR6RLirUp9aENXQyzQ6Q5yDmndjUUt8fQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/2fdBWpdypUXcPPa7J/eI6gJWXKJUOw+/7CCV+mDS8=;
 b=bst6rT97KGxVTa1xTX8GTGoi2hIuFf/X+2wRrWkLAV0SQy7WbX7Dx3q4Jn7KfiolEZ56MV9YTzgXsaG4hppR/qr6cQy/FFmuTbzJzmc63YQStJmO4bdTQL9on0+oVbSDJ2pRBAyx1zpCjuRuxDxhL8ckcCGPZ+985xbwD39ihSDKqDkNqXkGQs3T0JwhGmSgDVn4xK34wAPhUvcAtJTPwviHfa8oM5exSPHv+Udcb+bSfapfrZmRtMa8oxi/QeyRhyLV8jPdFP0Irjw3OhkXFAMpxM2gfb/sH5EFjv8t/U+bwM2MctjLCjuLHcmQ6IST2hkhk3gvUuz2YfKimlXsYg==
Received: from VI1PR03MB3710.eurprd03.prod.outlook.com (2603:10a6:803:31::18)
 by DB3PR0302MB8991.eurprd03.prod.outlook.com (2603:10a6:10:437::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Fri, 10 Nov
 2023 20:42:21 +0000
Received: from VI1PR03MB3710.eurprd03.prod.outlook.com
 ([fe80::8e03:368:1fd7:1822]) by VI1PR03MB3710.eurprd03.prod.outlook.com
 ([fe80::8e03:368:1fd7:1822%5]) with mapi id 15.20.6977.019; Fri, 10 Nov 2023
 20:42:21 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Subject: [PATCH v1 0/7] xen-arm: add support for virtio-pci
Thread-Topic: [PATCH v1 0/7] xen-arm: add support for virtio-pci
Thread-Index: AQHaFBZmaVN/T3ga/0u6YH/qKSa+kg==
Date: Fri, 10 Nov 2023 20:42:20 +0000
Message-ID: <20231110204207.2927514-1-volodymyr_babchuk@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.42.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR03MB3710:EE_|DB3PR0302MB8991:EE_
x-ms-office365-filtering-correlation-id: b1a98c57-c0c6-4742-3b2b-08dbe22d8979
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NEm95aYqkTLqH4zBnYWe3+H+iSocvVpzVCaGNnOiLxZy2eOOlrYQUenr8WGkNYat2xdShxx3zc2k4wCAF8t3xBK18SOnX6EVFHHkiVdIx7DNgmdwCrGMRECUv7qyczJBnlzD4S4m4O3icGTiUQWMA/3svQxqAetVsOAyTCYVNhHJtc6naKbql01x5pjRGmaH9pRHZgG4Wim7ctFYDjqW34vPiqNKPFXb4gb4SqS9pH/pFeS1L0oXzO3s3+ykHTtpEYbOi2WandRH2KVI3a5+wpMtnapsDjTomFjd+QjxIe7XPm2ma+/LXm3/JBcKOayTkY/xoozG/HOLhwmi6K6zfCIr7D4+qoCTf7foRLVigJ/Iqla2sTf7EnIk1NfGqMxM2uVMy1Mo1Lji/rhY9x2iJu1QU7ydiFljCd92TowaH9ixMqLSFIHX7Z514THEZEqHlEr0Kv6JNWFhAiJCA9CmjCIkjMSDtvxc0B50za6OtGQkL1N9E2ra/uX1X5fsEqJQ2hx2vvF1S33UYtv0dOQNSdHQ6jiQyAxG5YuvetD0U5kKYqvq9Ebs8naT7v5klOfG0mX3df0gvv/hupSrlXycLmu9BWAsuUIP7a8aAIxMJCyvPDIgF0Ept16MQ0tRX4tU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR03MB3710.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(41300700001)(2906002)(8936002)(4326008)(86362001)(5660300002)(38070700009)(8676002)(316002)(36756003)(83380400001)(107886003)(38100700002)(478600001)(2616005)(1076003)(6512007)(6486002)(71200400001)(122000001)(6506007)(55236004)(91956017)(76116006)(66556008)(66446008)(26005)(6916009)(64756008)(66476007)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lRdmt/KnUcPTiYSEf+WPS5eio2/4UEQ8V5cAGHbnxvA8Q4ulQJzK5QCD5M?=
 =?iso-8859-1?Q?PTMzxH6XxwOkOcXresocKAitKXlyHHoM1eeZhoqH69rmcL6giKJIHio6wa?=
 =?iso-8859-1?Q?L2ljgvH0l4yJOnlkIvdrSd5EK+rxa3fwNOj1bgihLmBH1OUK1AbutXW90J?=
 =?iso-8859-1?Q?zfTXnmmuCZXwExlPiTf5pcom+Hgi6p1wyoXvyFUGIGp1qhcisI772lBNDn?=
 =?iso-8859-1?Q?rhc45MNfayZYVbUgEA4GgfoaBXF5EhYPWmnHq6Pwmwp+EbyBW32ZSr//6i?=
 =?iso-8859-1?Q?UHxVzFpDG1czVnTHZNxcqa67ioZpGPOndc5bnciVTM5RdyvQoZAfd6DPeJ?=
 =?iso-8859-1?Q?s3gi4zdylC3rhYuRcNaR/Bek+Dch9hdsUmzr1Clz6fqbBUp0Kvr2QYKNMz?=
 =?iso-8859-1?Q?bfKSrWxbjazftZ6L6o159+7ayRaoEnLmsZO26xAL/SpJINnjPznibt/7Is?=
 =?iso-8859-1?Q?H0NgN9HP6iNjdFiS6pc3fP9LDJ696Xfimh1Rrqv+MJglYcPrjxYToTXn2/?=
 =?iso-8859-1?Q?o2LZ2v85YpFjpi0buH2BLPStSeef8RvMR4lxJZ5ALXiVNMyPBAmstF0xSz?=
 =?iso-8859-1?Q?3MtWbTyGSqsl4+EFlHTr7ZguJpCl5NEaQUZr/urO4qsG6sL1qzh9GUUa66?=
 =?iso-8859-1?Q?JvXMbp4lDsPgWODoJ6a9Z71eIJlSQWnXjzIBPEOt93LEOKovJY9nlJOpZW?=
 =?iso-8859-1?Q?NVTbkkrQtTJ+e7HhOsiXlIjYxTZevyL8KRc80z3JeC28LT0Lu7uA9zBT5+?=
 =?iso-8859-1?Q?+dLlXuRYZjqJC5wj7pBu+pbGwTQ5ll9bbttHfH6YjGkkyrRhTSDCOF2QCk?=
 =?iso-8859-1?Q?hdAnT4BkepIDcqH/GLRYg2lCrYhvVBEbvumEjCF8vY3gNlFKt9y1zxSyq9?=
 =?iso-8859-1?Q?5Pch9LMlRD4PXiVQDalAoi4jvhL98eBFkyiBKpM/XyBiXPagZfdo7sdIp3?=
 =?iso-8859-1?Q?9xUPO5YDssx5C3wOCantjSwdD9I5tGTeKd9uSCKKYE+1bFK8PyhiAposrh?=
 =?iso-8859-1?Q?Q7sP1UhJ5YHwNHNTR17PotB15o8CDm4QmZ4meCNcBuk8vBccShPLaGzipw?=
 =?iso-8859-1?Q?iupcJ5ralsqsqFChqaSMD9Vcdr5aXWfKeADth+XWs9RM+NyulkLEMGP/R/?=
 =?iso-8859-1?Q?EjFr4Jxj91hGtRoWSqgOv92ciEv9Q0gk01EuVCvMwaa+S8uLVZesYyK0oL?=
 =?iso-8859-1?Q?AC7rEH7ZgqmJaeKzP/c2D7nQvYmoli+hdVkF1E1aa39R9LrTc7VC77NbI5?=
 =?iso-8859-1?Q?0Ef2FbnSv0Em9pJ7nVxd+rDdH7cR2H/ksL/Q12EpFmWG6iw9kPT3xmgDoJ?=
 =?iso-8859-1?Q?fy1DXcd48rQ+gbJfEcYzOn+AnDZbNuOaW84TBwueOgERwKgx1aS5PVam/6?=
 =?iso-8859-1?Q?HAciFpq0ZHmG+IIFCxGSIU2lBLobmXIsuGXsBSFwatD2xHE4/x85//EPiD?=
 =?iso-8859-1?Q?bs5ZaJ269M28F96ncMKjPHxbC5ZGlzC+7LPC0iaLIF7jXdUoKQTLV08hjc?=
 =?iso-8859-1?Q?M3MVLzupbm1AQF9Ylqjy7Y4GXCdg61dwEnTO2nkty6OAK3N8NCIhwyC6L+?=
 =?iso-8859-1?Q?4OKo7fmYYmFx5odePMgVxVdKkdDU+Vp2w1JgYO60YXad+OLHE2Ac7vxjtK?=
 =?iso-8859-1?Q?pVQWVD4LV9Y+3Z5Go0plzdmWdoeYcGPnL8iYN1JMBOwCmVyk21uyAqGw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3710.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a98c57-c0c6-4742-3b2b-08dbe22d8979
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 20:42:21.0811 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AR/eZS15CVDmU3AxKbydLn/Yi7loWO62xQFJO9y2GZt/p4ECHYZeJX8zo9EVNnp11SCdIvtJG3iGvo8gZ1tTHPC/eQlkfdABL3z7aJDBUGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB8991
X-Proofpoint-GUID: DGPYwnFmwz1pWPTp8zPJNBgUsM-Ra09E
X-Proofpoint-ORIG-GUID: DGPYwnFmwz1pWPTp8zPJNBgUsM-Ra09E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_18,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 clxscore=1011 bulkscore=0
 priorityscore=1501 mlxlogscore=562 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100172
Received-SPF: pass client-ip=148.163.133.242;
 envelope-from=prvs=56783987ff=volodymyr_babchuk@epam.com;
 helo=mx0a-0039f301.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 Nov 2023 16:34:26 -0500
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

Hello,

This patch series adds the basic support for virtio-pci for xen-arm
guests. The main changes are in "xen_arm: Add basic virtio-pci
support", while another 5 patches are adding groundwork. First 4
patches are required to run QEMU device model in a driver domain, not
only in Dom0.

Oleksandr Tyshchenko (6):
  xen-block: Do not write frontend nodes
  xen-bus: Do not destroy frontend/backend directories
  xen_pvdev: Do not assume Dom0 when creating a directrory
  xen-bus: Set offline if backend's state is XenbusStateClosed
  xen_arm: Set mc->max_cpus to GUEST_MAX_VCPUS in xen_arm_init()
  xen_arm: Add basic virtio-pci support

Volodymyr Babchuk (1):
  xen: xenstore: add possibility to preserve owner

 hw/arm/xen_arm.c                 | 188 ++++++++++++++++++++++++++++++-
 hw/block/xen-block.c             |  11 +-
 hw/i386/kvm/xen_xenstore.c       |  18 +++
 hw/xen/xen-bus.c                 |  16 ++-
 hw/xen/xen-hvm-common.c          |   9 +-
 hw/xen/xen-operations.c          |  12 ++
 hw/xen/xen_pvdev.c               |   3 +-
 include/hw/xen/xen_backend_ops.h |   2 +
 include/hw/xen/xen_native.h      |   8 +-
 9 files changed, 253 insertions(+), 14 deletions(-)

--=20
2.42.0

