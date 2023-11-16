Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0921A7EDE13
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 10:59:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Z8s-0003m1-EA; Thu, 16 Nov 2023 04:58:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luis.Machado@arm.com>)
 id 1r3Z8q-0003ld-RE; Thu, 16 Nov 2023 04:58:32 -0500
Received: from mail-am7eur03on2061d.outbound.protection.outlook.com
 ([2a01:111:f400:7eaf::61d]
 helo=EUR03-AM7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luis.Machado@arm.com>)
 id 1r3Z8o-0000FH-BU; Thu, 16 Nov 2023 04:58:32 -0500
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=OEpmAq5cecMCBJQnD9mbHPPoeuGr8bZ+TjFx+rLVXG5/zvbQiX78SuyEWJTjLQE33CaGGzWfWtdcrdxyT/5SRAPlSJypit/uUAnoG90zbceTz5EYtBS2C4U6TPV4kHi36oAcQ62A0uCp6pnbaJJdSLZ0mClc7OygPLII3Pj1Nr6zX3wSaHYVuW6sG8HE9rjv5I2tYlIilQQDRGVT+EbA89IP7lN0P8paMnCYIq3yFfdwMIrg2rtv2MJnSmdeoEYatdaQJ0kL61wG7ryBXksD+WpFQ680qmrrhnC3XYuNP1Qq2M1u4bRYe1S1dsMBQ08snCOT1Cfu3JjBCtWJ/rSnUw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4eOJfeOkkFPFflWbbkQAWhfiAsfV8JZoCxbdsQ3v4Q=;
 b=Cyzgt3azYpWdD8+sRH1857leRkgf4V0dStMgZ3+6GjuCM7YhNdbv1/xFUmuCTbxD8qbZng3DiA4jK44VxfjyZr55+mXW34TwwmlGPJ+JKbTWyEe1b2gOhjfpIbJVX5tQd1deQQcVSn1+jwWpeJsV3xldZu3PvcH5EWu0REf8eoX8n4LOFByZi28fZSIAvx0EQopekWzwHtLlxv0CgTYV9wMXiOOu6enb+u0xrYMdCLVs1qkqS8B2ZAqdKzJO8XRK4UkeTebjR5scFgc9w3oF5SoE0SJk7BgqdoGf23fO3bFTMwXEThi3PbpEzs6X+ZhkcQth5/Tuzv+k37/RHeTXvQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=nongnu.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4eOJfeOkkFPFflWbbkQAWhfiAsfV8JZoCxbdsQ3v4Q=;
 b=lujcFLKCy9SK2qQQa2jcM9uF/ZDSry67tr8pp1rHqlRzOVYhFh/0KcvQOL0MZhSRUntXKtaW7Pj6JYoUj9w5YtysdUGUBaMXBQXo01FVrhilMNrgffMnCSOqkiX96DVeLTiPZpToV3MTGN3gchRF4QYKpy1vM/d739L6nZiduVc=
Received: from AM6P195CA0035.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:81::48)
 by GV2PR08MB8752.eurprd08.prod.outlook.com (2603:10a6:150:b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 09:58:18 +0000
Received: from AMS0EPF00000199.eurprd05.prod.outlook.com
 (2603:10a6:209:81:cafe::d) by AM6P195CA0035.outlook.office365.com
 (2603:10a6:209:81::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20 via Frontend
 Transport; Thu, 16 Nov 2023 09:58:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF00000199.mail.protection.outlook.com (10.167.16.245) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.20 via Frontend Transport; Thu, 16 Nov 2023 09:58:18 +0000
Received: ("Tessian outbound 385ad2f98d71:v228");
 Thu, 16 Nov 2023 09:58:18 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 1c0e06036fce6f9c
X-CR-MTA-TID: 64aa7808
Received: from fbe5ca8f1f8c.1
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 69155729-6D86-45E8-84A6-88EBAD15F78C.1; 
 Thu, 16 Nov 2023 09:56:46 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id fbe5ca8f1f8c.1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Thu, 16 Nov 2023 09:56:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjkZkBroOdfScNTimc+0KSQdl7maocUA50JW+nT1oiKekRh33WuLnXAVSFnelbOXbR0ZRBLAdWBfpygCly1wEJwL+baH7I/zBYxEUXaOhRhweyLytsoNrT7TgYOWZup5WE1Cis1340AaHl61KtZPRke/HlaZQFnJfkMPWjf8cCiZMkEe+Gm+ShAG6aCxMZZ5vx18gJ76wf5oSUKghp3KwguOmSOSP5US9Yx30ObvdiGS2GZUfvhQFfj5fiGbAoKSY685thqxfg2Tk7A2+OElY8yJgLpn8/YCfkYHwEJwjLi38oBFjtFsEusBjZoijazUXG4aUju7mmCU2wfKU7olMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4eOJfeOkkFPFflWbbkQAWhfiAsfV8JZoCxbdsQ3v4Q=;
 b=OfS9oJY0pRL2+AVK9OyKVek0cctwJS6XgElYObu3khIDTNTNDvgVKqeOA+TiEh+VZyMpjpTgDdVUjtyZiCa5g3CCvZ8nXjvnAo4tVTJDnSE88X1Pq9g3ud/MhoTE1QavjbPpMHBvrjtWrBCRKiWGQNebg5wUoWLslp4Yb20v568/0EAndkVgLPWgzPVE7c1Eo1IoqGZUaRbBaobutUMGRQGug/FGucxieQgWUB/CNSQt2gzUaXlcUyF5NNC0LwWgCJklCIdAoYWNn88Q9mGrcyxH0o23trJC8Rcc1REk1NbhTAJEbQzNoD35j5u0g9GyLUrgav0/Bp1CRA66De4pMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4eOJfeOkkFPFflWbbkQAWhfiAsfV8JZoCxbdsQ3v4Q=;
 b=lujcFLKCy9SK2qQQa2jcM9uF/ZDSry67tr8pp1rHqlRzOVYhFh/0KcvQOL0MZhSRUntXKtaW7Pj6JYoUj9w5YtysdUGUBaMXBQXo01FVrhilMNrgffMnCSOqkiX96DVeLTiPZpToV3MTGN3gchRF4QYKpy1vM/d739L6nZiduVc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com (2603:10a6:803:c4::31)
 by AM9PR08MB6260.eurprd08.prod.outlook.com (2603:10a6:20b:283::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 09:56:44 +0000
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::e05e:c012:f1f9:eb51]) by VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::e05e:c012:f1f9:eb51%4]) with mapi id 15.20.7002.018; Thu, 16 Nov 2023
 09:56:44 +0000
Message-ID: <37df0557-faf0-4667-925f-fcc7deac4f52@arm.com>
Date: Thu, 16 Nov 2023 09:56:40 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 06/23] tests/tcg: add an explicit gdbstub register tester
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Luis Machado <luis.machado@linaro.org>, Ilya Leoshkevich
 <iii@linux.ibm.com>, qemu-s390x@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, "gdb@gnu.org" <gdb@gnu.org>
References: <20231107142354.3151266-1-alex.bennee@linaro.org>
 <20231107142354.3151266-7-alex.bennee@linaro.org>
 <CWXN9HF4AXGM.19H4A5BU366S1@wheely> <87il62vip5.fsf@draig.linaro.org>
Content-Language: en-US
From: Luis Machado <luis.machado@arm.com>
In-Reply-To: <87il62vip5.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO2P123CA0089.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::22) To VI1PR08MB3919.eurprd08.prod.outlook.com
 (2603:10a6:803:c4::31)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI1PR08MB3919:EE_|AM9PR08MB6260:EE_|AMS0EPF00000199:EE_|GV2PR08MB8752:EE_
X-MS-Office365-Filtering-Correlation-Id: db135627-eb03-4b72-29fe-08dbe68a8f4d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: NOcPpXMYqvAGLr026LdqrGSX6LZPk3J6ivQxOyqxvwHnTRAt90EDZSfMFmJK3brC90v120NWg+3uy4qJ/wfVjlqPycoRL/BTEKFCqkGps4xQw2TrsH6B1ng5uWscRJstuD3JlrCColcc4Rf9C96Bmvx5RF9bSCtgKCRqMal0hUfxDi8qbz890dds6D8S8gx4TBlht6hmBDAsU62zgv4vNZTZ/2poy7CAx1c5sutmslf6VCGVh6iuIGxsBeKTK6FsvMGZOH3Pwx6rpLOwGEYM5Vfrs2pw5f/mpmFosEw7bDDcSxkZYZjkPs9VgxuWwPqa3rIWL0YvSgUw/BK2HDtaQC1wb3fjZUdprK5TF3WWhQjWcIQcs/BeXR8WQQd+2CH8WtLoKByQZD60aMHOwY0EKSho+i7jRaawp5mhrthx5QvJw6d3fGKZ4dzyK9GZ1y1F/46Y2HsdmkF7J83SnpIVh5NsNveCX8UvhBt3qwo1izOJaejaTN0jPqBzQdhlc1+VdZT0JIYEwGi0R2uKGWZZtgXt75vEHrWrmplc7GzSXDrb6GpjK4vtqQ5gVlf80dTC46ER6h4OzcORvtB4+uaBxf3nKc/kC07UTwneY/ViO6GEXjG1Ine6aNcyZrZAlFfc
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI1PR08MB3919.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(66556008)(66946007)(66476007)(54906003)(110136005)(316002)(2616005)(83380400001)(26005)(478600001)(53546011)(6666004)(6506007)(6512007)(6486002)(36756003)(66574015)(38100700002)(7416002)(5660300002)(84970400001)(2906002)(44832011)(31686004)(41300700001)(31696002)(86362001)(4326008)(8676002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6260
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF00000199.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7d04472e-9183-4f09-a9c5-08dbe68a5639
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ntatgjdQujIGGcbdoPrMgvwnGtR1P3IjxzPY6o++cVyYQ+658ziFaxvrC2xmSjo5hYzJ6hNummaZBbIe0wk2G3muFOfUmIb4S1AItMaJD7BlDG6Ono3//x6d72yPU/ALhuD76rTutR8n+RG9x9xpWNfGQyGO8SgzIOc1B1siDazDxvZAg2W3wBcP62acWv22ErBvMlYat+Jz3PmjwVkFScqgZ65J/7NM0NxoQLIoeJso0pX8wQpaGATGY2lzTemTAZWZxc8yKNDxkNOH+Iu4FKYiAyEmn8N6zJvTFiTLXWbivia5J6LCjzRGR7hRZziRrOcUnbOOTUR2NQQOMLW2+tXcG60Hwq8mlCbSAt3thCkYFQsQXacDMefvwWtmbbpZgSBDY6UtF3GUUha9VxSXu0JSBnGa7QCx5OdeIoki6J9cHNgiA1fNa49onW2kMeZvbYP106sF70rZI+2o2hzsbzkGU6WHNrEkWh6Vs4xtdpm2wX/hzwJwmuMZlaXPIrNYyFy/v7mCtd45QipASvjuUrfbV05oMgWSlNzMqFpLVCgWIgZRk6Rwj7XI1/h3SVhv+i00LmYqXSi1S4WlXELwkunccpD3EkpHFRxA1bm68NIUsE1o4cTKk7KW8RzdARrNfyNatKcK2CBvqqJPO+hO6LXBMIFPrbXfXWv3n2RfEDrehQwjCXbu8b5TBji3j+c9jvuhq5/aGF1blOXKma7MqkfPLyx+CQY4DSgCAhOnVjStjMbC3+BB+yZR3iuKBx6l
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(451199024)(1800799009)(82310400011)(186009)(64100799003)(40470700004)(36840700001)(46966006)(40460700003)(82740400003)(66574015)(336012)(83380400001)(53546011)(6512007)(26005)(6506007)(6666004)(2616005)(316002)(54906003)(110136005)(4326008)(70206006)(8676002)(70586007)(450100002)(36756003)(8936002)(84970400001)(36860700001)(40480700001)(2906002)(41300700001)(44832011)(86362001)(5660300002)(31696002)(31686004)(81166007)(6486002)(356005)(47076005)(478600001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 09:58:18.6037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db135627-eb03-4b72-29fe-08dbe68a8f4d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000199.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8752
Received-SPF: pass client-ip=2a01:111:f400:7eaf::61d;
 envelope-from=Luis.Machado@arm.com;
 helo=EUR03-AM7-obe.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

On 11/15/23 20:56, Alex Benn=C3=A9e via Gdb wrote:
> "Nicholas Piggin" <npiggin@gmail.com> writes:
>
>> On Wed Nov 8, 2023 at 12:23 AM AEST, Alex Benn=C3=A9e wrote:
>>> We already do a couple of "info registers" for specific tests but this
>>> is a more comprehensive multiarch test. It also has some output
>>> helpful for debugging the gdbstub by showing which XML features are
>>> advertised and what the underlying register numbers are.
>>>
>>> My initial motivation was to see if there are any duplicate register
>>> names exposed via the gdbstub while I was reviewing the proposed
>>> register interface for TCG plugins.
>>>
>>> Mismatches between the xml and remote-desc are reported for debugging
>>> but do not fail the test.
>>>
>>> We also skip the tests for the following arches for now until we can
>>> investigate and fix any issues:
>>>
>>>   - s390x (fails to read v0l->v15l, not seen in remote-registers)
>>>   - ppc64 (fails to read vs0h->vs31h, not seen in remote-registers)
>>
>> binutils-gdb.git/gdb/rs6000-tdep.c has:
>>
>> static const char *
>> rs6000_register_name (struct gdbarch *gdbarch, int regno)
>> {
>>   ppc_gdbarch_tdep *tdep =3D (ppc_gdbarch_tdep *) gdbarch_tdep (gdbarch)=
;
>>
>>   /* The upper half "registers" have names in the XML description,
>>      but we present only the low GPRs and the full 64-bit registers
>>      to the user.  */
>>   if (tdep->ppc_ev0_upper_regnum >=3D 0
>>       && tdep->ppc_ev0_upper_regnum <=3D regno
>>       && regno < tdep->ppc_ev0_upper_regnum + ppc_num_gprs)
>>     return "";
>>
>>   /* Hide the upper halves of the vs0~vs31 registers.  */
>>   if (tdep->ppc_vsr0_regnum >=3D 0
>>       && tdep->ppc_vsr0_upper_regnum <=3D regno
>>       && regno < tdep->ppc_vsr0_upper_regnum + ppc_num_gprs)
>>     return "";
>>
>> (s390 looks similar for V0-V15 lower).
>>
>> I guess it is because the upper half is not a real register but an
>> extension of an existing FP register to make a vector register. I
>> just don't know how that should be resolved with QEMU.
>>
>> Should we put an exception in the test case for these? Or is there
>> something we should be doing differently with the XML regs?
>
> Yeah I suspect this is just inconsistency between targets on gdb. My
> naive assumption was XML should match the displayed registers but it
> seems there is additional filtering going on.
>
> It seems in this case the registers are still there and have regnums (so
> I assume the stub could be asked for them) but the names have been
> squashed. I guess we could detect that and accept it?
>
>>
>> i386 gdb does similar:
>>
>> static const char *
>> i386_register_name (struct gdbarch *gdbarch, int regnum)
>> {
>>   /* Hide the upper YMM registers.  */
>>   if (i386_ymmh_regnum_p (gdbarch, regnum))
>>     return "";
>>
>>   /* Hide the upper YMM16-31 registers.  */
>>   if (i386_ymmh_avx512_regnum_p (gdbarch, regnum))
>>     return "";
>>
>>   /* Hide the upper ZMM registers.  */
>>   if (i386_zmmh_regnum_p (gdbarch, regnum))
>>     return "";
>>
>>   return tdesc_register_name (gdbarch, regnum);
>> }
>>
>> So, I'm not sure how they don't fail this test. Does QEMU just
>> not have YMM/ZMM in XML regmap?
>
> No I think we only send the core one with XMM regs and there are no
> additional registers sent via gdb_register_coprocessor.
>
>>
>> Thanks,
>> Nick

FTR, luis.machado@linaro.org doesn't exist anymore.

As for the XML, it serves as an architecture hint/description of what featu=
res and registers
are available.

GDB will process that and will potentially include additional pseudo-regist=
ers (so QEMU doesn't
need to do so, unless it is some pseudo-register not accounted by gdb).

The rest of the features/registers gdb doesn't care about, it will just add=
 them to the end of the
list, and will assign whatever number is next. GDB will be able to read/wri=
te them, but nothing more
than that.
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

