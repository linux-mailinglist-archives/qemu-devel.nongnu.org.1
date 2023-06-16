Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7DB7337EB
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 20:11:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qADuB-0001dV-Nm; Fri, 16 Jun 2023 14:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregory.price@memverge.com>)
 id 1qADu9-0001c7-0A; Fri, 16 Jun 2023 14:10:37 -0400
Received: from mail-dm6nam12on20607.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::607]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregory.price@memverge.com>)
 id 1qADu7-0004Zj-1i; Fri, 16 Jun 2023 14:10:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbNuA94Dzm1J5D7nWiN82/Uo4ioutZkzAfkYgOX1544rGZ+F/UC4dLL0j1upnlqw25a5Bdd+DsnkEJsdB1Utp5fDDUzySj/GrJ4mN9L0WIyacMbWt3vagEZazSCoKDGyl7ss1Dc1TvO4kzvg1R79KyyTmEkPaTSEJxdsk62BUME4ipWYmEayOviwiyJCg2XHpPXBTRRgkymbVzwwWnFklk4BSgtvaDuWLAsLfh7bYkzF2luQpb2rvBrkA9WIt5RIZWKrmldlEdimipzJpWpo+DjBXY09KapGL4tiUkoANJDWxJV47/8uYEk/eTXaXPO7EK/WmgmvEv68+reO1KgQXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJY7KbunT8r7hWpYcde8uDT+I2bn9vWRvisFD+kPpUs=;
 b=jkg6Xv/sMKBNgDvfv98jB2L935E+Pik0CTRU9XU4ovlA8F3p3kMe8PDeRsqUnCme/WzavMgjTQX8u4c9sgEXEOKpNuZ8g8tdn5VlAhrxOIKHJjv0caT/4Q5ezzZHCWQXVBg8pXAJIx75vhi9MHSA27kWxhoyH43OIbyqNkUDk9TgA73Hns1XCy7Dc+c32UNP/1My2zEYg+InkO9UyZL2YkbUoWUCqIUTgUqLrRXDVBvWzdir26tbx07DyVS0D7x0cW9HsBKe8abSJdKeXE6Bcrbsed2XRq/leCQZkyI3j7rC0YhVKM1McRVRJGp0cVD8QKn+v3DAsEBwk/JPVxDxbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJY7KbunT8r7hWpYcde8uDT+I2bn9vWRvisFD+kPpUs=;
 b=habPrhBxQtNjtQnnTLeEU4fU5GW5ELwnoORcORg1Nd2jOsaPBmVKreq2kdTSF4bYKw/bmMwonPbLMZAk7zonAccMbWDdZurJrUMjVU4/qybxQ5QZNiPnpQF5KhCeIOpSSoP7Hqw5iQldnBj4iJ8u+iEA7v9F9N/G1dKtVVc1Jqo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by BL3PR17MB6114.namprd17.prod.outlook.com (2603:10b6:208:3ba::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Fri, 16 Jun
 2023 18:10:28 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7e82:eb7d:47cd:2ebc]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7e82:eb7d:47cd:2ebc%4]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 18:10:28 +0000
Date: Fri, 16 Jun 2023 14:10:24 -0400
From: Gregory Price <gregory.price@memverge.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: "jonathan.cameron" <jonathan.cameron@huawei.com>,
 qemu-arm <qemu-arm@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Subject: Re: A confusion about CXL in arm virt machine
Message-ID: <ZIylkIt38MXaTytx@memverge.com>
References: <2023061615433049315231@phytium.com.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023061615433049315231@phytium.com.cn>
X-ClientProxiedBy: SJ0PR03CA0203.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::28) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|BL3PR17MB6114:EE_
X-MS-Office365-Filtering-Correlation-Id: 412e36b9-b6a0-4460-56af-08db6e94f6d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KMGm0Wk1kP8w7mvJkKHQW1VZ3/j1c8r11gkXn53+79gx0FYF5gX95VvVtX/k1c7kzvjIxFoIXrauw1f/S0yZcF4X+515lcqmkiph3yvomoXjWOJshxl2J7KoV3QOy+SzZ04pwPg7Kuvzl4AnmHNUvBhMTFa6U+9749PzfXBWj5XEa86mrUU7xHW1P3DVcJ4Y3Sv0WVGCtnPyGYQf3j7pkEZ7meXnU/qR2nV3esDlo1DmOX1LC44TyCacS6Q2q0O5TCAkBdTNizteGvZTbaD/FpGqjQ29zEI8e5Ez1yG5QGUK8TDmQmAP7HoCqL+oWHCTJ4oyAvG+QhDypF7QKCe/SAloGdNhF5hnXqAhP0Yba6Qe7wDzFWANrGoZxKud1oo/WhbcWKFP0VquiMVW6LaqE+TosSd0mOq8Mnf8WtxXygU6jGa1rPK4QX/zBEuojJpvXkjpEwe1/f3yKoUjrJ8015p4dPH8G2Y7Y6cCKYTtTFt0AVnNJtPe+Yl8GlKNeQZEkO73S9RI8sUOpWvutSSGThJyfHNjoj6dl6i9rFIgqvc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR17MB5512.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(366004)(376002)(346002)(136003)(39840400004)(451199021)(966005)(6486002)(316002)(41300700001)(2906002)(86362001)(6506007)(186003)(26005)(44832011)(2616005)(6512007)(38100700002)(83380400001)(5660300002)(8936002)(36756003)(66946007)(66476007)(8676002)(478600001)(54906003)(6666004)(4326008)(66556008)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qgLhPBfO215PhgOAFevDUKGwZ6SVpxrMKiimrNbyunxn795MnFECjWwPNmK/?=
 =?us-ascii?Q?wjgpMS2xNGT2BhE4NkSnH+11Sw79q24rpTiTcja4FA6e5i3hEp7lesnFeOvt?=
 =?us-ascii?Q?VDd03A0ceuo05uoAFfmdAjojFcBPhQ8LHzYyBDuT42d/dP3AR8A7wi09B4xx?=
 =?us-ascii?Q?QJxR0lkMeWbrXLKpQWEXXjie4QidqyyRkdh5blkJQpwH6thfNjQyatRdnfUo?=
 =?us-ascii?Q?IwKilCePNafyCUuT0tPc8FQl9sFk+sSbftN3IzRE1weygl6tNyf6sfyqAqzz?=
 =?us-ascii?Q?ehi7HS3IuM7Z9h0Q4QCBmA1eC3J6JeVL/E7CaiOn/Zr8kWSfNMfXc9cFy+5v?=
 =?us-ascii?Q?ZuxzqE7bXyvK42/XnyjXKiDvaCWuVTwdH0dQmLQy4sid0RyPgrGiyMt2a7HG?=
 =?us-ascii?Q?Nxjkj/HdC1KmdXKUjv077zTbCHXVv+TgNxkEne5N1sJLt9fhJO5khc2mZ6yv?=
 =?us-ascii?Q?J/N7kCN3s5TqSM+BO1bHemMzml1DMsSyAMNPk3H8rNFs+QytCKuhdJTXSWfd?=
 =?us-ascii?Q?onbAFWYElvQ/gMijZ82HboQ0swttS9z5nDeNqvktAy3dMMKam30gyVDT9nkv?=
 =?us-ascii?Q?j26/UEmbCS3QsXLZkOBByq79yrS9VOYjryPLxvlKjtRX1h+QdoB+JXHJOpbV?=
 =?us-ascii?Q?bIwjz9fb4241Wb3hHxcm1QYyc699JKZ5j/OC8tPVM18auuKmxJ+k/GuLRLcU?=
 =?us-ascii?Q?w+k4CyIcN2OqW7xJvDupO5he9lFsLZpUZIlyw3GTpQIPlqlEaeh5W/B/appS?=
 =?us-ascii?Q?MeZLHz5enec/Czp7BnzG/+SRSiUflgynw7pxkASK3tnSqHe8obPHmAzNRLyQ?=
 =?us-ascii?Q?Fx0/dBcKc4U/TVQUUQS4y+IBxJvijgPSghEpzNY4bq/jxVHFU8r5X+/yKcwR?=
 =?us-ascii?Q?+6JjzOWfTm//Kx3SOOa2nTyYF+kiTnS3HovfX+lCz+uOsEc+dlxPkC6DNbbS?=
 =?us-ascii?Q?rkkY9nrhBVOavmVgOfiAPvpKdxAhi7yly45IGpSZn39Zo1MeF5J4FOUUDPBe?=
 =?us-ascii?Q?VJmk35mINPJ8vflDTzA4CyRYxhWnS2m2Pz7LhlF0N7cm8WBX9JxDDUCZu9K6?=
 =?us-ascii?Q?Kb/DY8omtbKkELkaUhTwdoADv7G6zwkZ20MY3LbrLLyQ77Scy0wFzQz/Qy52?=
 =?us-ascii?Q?UXMgFVbEFJRf5KTM1FcoFOa3zneO12oMErSNuWQpT8YfUYPfxsHMEbZtbKqr?=
 =?us-ascii?Q?LytJUTC99H4qMtgWP3RBcCSD9YI22WfCIWBMU7lCC6Otg40fFaVT/EdlGnv6?=
 =?us-ascii?Q?9D0oBexsVejhVwXApa467otTTML364QllE6KvjpiP2VROVze6pNjUjxM1p0h?=
 =?us-ascii?Q?8RLvx+JlMz8oqXS1s+HzoosC3sOePcc3ApuWfV8OImsAxZwvFB0tFcZfxpL2?=
 =?us-ascii?Q?U/zs+QyPTUVmERHm2n2TqkiXYip+NlFI6S8EPOIHLTLLVJSj8KQ4jTpjYdnI?=
 =?us-ascii?Q?RAM61DNkDt9FKxNnf3bT9kFDi6uMKjdxo3zDoUSKFPqVKzC1yhC2B4/Kjf2M?=
 =?us-ascii?Q?D3YzItV5iOWK6GscqnjHY5uKzBQBAc6JjzNVMCAXPCrN2sB7jK5vCyGVOwj1?=
 =?us-ascii?Q?tvUqwlbEJyA96KKnFP4Etp52pf4KeIbrZqUUCq3xeub0qqW4OHuYAnzRI1RX?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 412e36b9-b6a0-4460-56af-08db6e94f6d0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 18:10:28.0254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HvYeXghQ0PlE2mlhZOc+EtCiESIr2GZ+yAiD+yfGPQrFDr6NS4ct9RsD6U/r2Ak8CfW+iYKW+pRF/ZIUgDbNfBsPeeVlnifh/iduU+7wR1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR17MB6114
Received-SPF: none client-ip=2a01:111:f400:fe59::607;
 envelope-from=gregory.price@memverge.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Fri, Jun 16, 2023 at 03:43:31PM +0800, Yuquan Wang wrote:
> Hi, Gregory
> 
> There is one confusion about CXL in QEMU I hope to consult. 
> If you have some time to look at this email, I would have better understanding of CXL 
> emulation in QEMU.
> 
> On docs/system/devices/cxl.rst ,  Gregory wrote:
> A very simple setup with just one directly attached CXL Type 3 Volatile Memory device::
> qemu-system-aarch64 -M virt,gic-version=3,cxl=on -m 4g,maxmem=8G,slots=8 -cpu max \
> ......
> 
> As the current master branch of QEMU has not yet complemented the CXL option/expansion 
> in arm virt machine, how this example command lines worked? Or here used another branch 
> rather than master?
> 
> Many thanks
> Yuquan

As of today, the qemu/qemu.git master branch does have the required
patch for volatile region support: adacc814f541af9281c922e750d8ba4b90c1a73e

however, the last time i tested it on x86, the master branch was
incapable of enabling these regions with the latest kernel (6.3.x)
despite that kernel having sufficient support to do so.  I have not dug
into what the discrepency between master and johnathan's working branch
are just yet.

Last I tested cxl-2023-05-25 branch of Johnathan's fork is working on x86: 

https://gitlab.com/jic23/qemu/-/tree/cxl-2023-05-25

I have not worked with the ARM machine, but Johnathan may be able to
comment on the state of ARM support for this code.

~Gregory

