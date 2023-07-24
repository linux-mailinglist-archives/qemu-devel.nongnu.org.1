Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CB975F929
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 16:00:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNw6l-0000sy-62; Mon, 24 Jul 2023 10:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Evanzhang@archeros.com>)
 id 1qNrLA-0003xj-Cn
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 04:54:54 -0400
Received: from [2406:e500:4420:2::61c]
 (helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Evanzhang@archeros.com>)
 id 1qNrL5-0000tu-Oy
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 04:54:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVL+0b+SepVbvAUugpQ2payLbtRzZA44bVdosq+d6jmNs4hPrRnQP6Zv0lt0fByvmX+rVEvYNHaMcWioNzMCHMsQFUCAIoyZQDYOl12M/pgP6hZCgEZPcnvJVTE1I7zIo6pNgKA8AgQz61qx7KMUt0rMr7hgDT9YmjcU2DfyrVdxs1F6XwtT4G/dy2uW32hfG9AfwcR/by37mOu/SmjoGpSIsE4QVqUURx7VUP5CaPMiRNAV6zhXUwt5txH6aIyTVoham11CqdDQ5LtWcqJEw+U+xrcW5Lzy4r+7FAOA8oE6WZwBonBI7g+QvIQYdLpm2ocWESnXm0B5F3d0tIvVOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhF6QayrvrFxLHD6hKb/EggW1o2KgKgIVwUoZRAxKqk=;
 b=VXADGTXD1ChmTKapqPqhXPXHfhHfcsbTOG57EB5fRPiSzAaGnbzJ1eTDYtRtoHu5vzrVDC7UweM2jOK+HvZ1NWeHpMk48TcdjSwHB+gqYnYjI2yebO1idwJAhKzFtAHtGD/K33Of/APtj0cgOuiV9zIZnavD8cl8t2x4arEByDL1yGS2DufX6/9uTZKxAYesNYkhBwd6S4OAdEW6tcvd/rpHHki3TbpwIa92HLTjNT87lhMWxDX4R87Chm30p9EPOC6J1AyET3l8fOfJ33YjbYOJecDax7pNpQdKZRHVvWJwX860sOwuEq90OAsVkNa9HhF9zXgzJsZKXVI/xCFrxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=archeros.com; dmarc=pass action=none header.from=archeros.com;
 dkim=pass header.d=archeros.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=archeros.com;
Received: from ZQ0PR01MB1015.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:e::13) by ZQ0PR01MB1031.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 08:54:36 +0000
Received: from ZQ0PR01MB1015.CHNPR01.prod.partner.outlook.cn
 ([fe80::801d:e216:d86d:2c4d]) by
 ZQ0PR01MB1015.CHNPR01.prod.partner.outlook.cn ([fe80::801d:e216:d86d:2c4d%4])
 with mapi id 15.20.6609.026; Mon, 24 Jul 2023 08:54:36 +0000
From: Evanzhang <Evanzhang@archeros.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com,
	pbonzini@redhat.com,
	Evanzhang <Evanzhang@archeros.com>
Subject: [PATCH v1] rtc/mc146818rtc: improve rtc performance
Date: Mon, 24 Jul 2023 16:54:21 +0800
Message-Id: <cover.1690188072.git.Evanzhang@archeros.com>
X-Mailer: git-send-email 2.9.5
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0006.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::18) To ZQ0PR01MB1015.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1015:EE_|ZQ0PR01MB1031:EE_
X-MS-Office365-Filtering-Correlation-Id: 65bd6c82-886d-4ce9-87a9-08db8c239b79
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JfjtPBGAkWLPwxS+sYWmVkf967lF83A1i9o0gACK/vKAHNVxODEsC+pdCKNZQXyTZ7ENsTmWlkj5Ybfg2YtACpRD+n45MIAOzXSQWg2TvwQGD/0t6WYMgcIl+4e+Skpzd5Uu6ItaFo057UAX1TjawEcrhvCedIDAkEZ9bhcmcPr+mLyQvQnsl+/npjLtDulW2T6vebB4KI5CUBY6AGt4mMUN06E8a5DsTueb+sVzEJQepo9kdYYHYqIHU0OId7Dly6IBQEzDBYkI6R2ibxDAWt9yyGLSQBxy5rbdDTISv6sKrKnESBjfmOJx3OxiGm69HcAPINHY3+Iv/obdI2zuc7nuWBRcuzJmFuBimmVmWD0W7sS7uKibJjFcsMCJY5ENTicOt7+wSF9VJz0Zj5vpK6MIbOtKxeTqFQfPyI8qPxvrV9C++7SYw2NkdnGJ1bfuZYUieNyrT9mhwJqRJjkCV56k7hUDzpC39bv4Qoid0KC6IE3YbOK/2wooVkC0mT5rh07REOTy4nYxvbyeOeo5fosE6eoQ8YIFBcPOv9r4djlMy+vj2nseyvwdE1NDRJrNno/LfdyHi/crXnrgUHoX1I7R4CLYESQQjY5JFyrDAwj4QcVuxfKlW5ROMXL5pFYR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ0PR01MB1015.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230028)(396003)(136003)(39830400003)(346002)(366004)(451199021)(6666004)(508600001)(84970400001)(38100700002)(38350700002)(86362001)(52116002)(66476007)(66556008)(66946007)(40160700002)(2616005)(4326008)(6916009)(83380400001)(2906002)(41300700001)(4744005)(8936002)(107886003)(8676002)(40180700001)(26005)(36756003)(5660300002)(186003)(41320700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W6pylMPe0KglFIUlTMz51Z8/ZAzk43fGTkeimdldfXRwmnZU1cphsrmW53IX?=
 =?us-ascii?Q?OwPVb3+iIe2WHuur/6Arch8yl3CamXf4vVnulf54l+slA/9VJDOGK+ZsEQtT?=
 =?us-ascii?Q?3jBMHmlRMgJxlT6Kbr9KJbkBwRQ28DeqNSX6s0xMe0jImBeTF6BJz4vK0XF1?=
 =?us-ascii?Q?zAPFQU/TgfpnMmJM5SKKQ0eJ9PgzHViwd0aGmYYOVnFzCR7HgOn27DI0maZ0?=
 =?us-ascii?Q?/c0b7Y5Ze1j3suvoe0u+Tq4RUZ3sVny8yGB14gpWlp+qkM/8AhUWVrtBd+gl?=
 =?us-ascii?Q?tU882l7eymUwf7w6JEXVkLk3k3iXj3PdOecansfrKLUb0QsJoiI6eGvSD2MF?=
 =?us-ascii?Q?UoeaqiBBu6ZuE80Iq+CIEPp2UzuA/I6OEV9QlpGKCnhPkv7PM2hvZSrgesmq?=
 =?us-ascii?Q?6+59MJZ3EwiKnkgQ/ygo9IjSZckcwE7uQ5oner5OUetaY7Ht4KflIKBlpwkT?=
 =?us-ascii?Q?bsxgk5rIWbsT1fTf2zExmk/8x3J2GhiVh3IaV5pNawuM4ZYs5GJE1LQitJtF?=
 =?us-ascii?Q?bg7s00wL+VppPUzBrp+rGEWP6DqfREy9MJsDaV4p7ABwBxPTeud6xAu7xe03?=
 =?us-ascii?Q?Vme3caKXCcRYXXDU0ETvrUbccvx13Z+dx3MksvpYSLOkL7E4oH1v8Vnw4Afn?=
 =?us-ascii?Q?1+w2wpchuW0C0dVSb4Wy3YM1fF77vh0U1KKfA02tWQhDxCyZnvi+A/lAhW9m?=
 =?us-ascii?Q?iZRVccYl1j6zfZxTM1LYDNAraBqLoRRUKrz8YaT6SpVdtReYEqXrTfZKY6Ar?=
 =?us-ascii?Q?7zb9Eh8BkcxdwPztE9yAKw7ze7Dr1RyF57xw7f5RQEEQHwOYum31Nn3gBEDo?=
 =?us-ascii?Q?85sXHBUCvZ++F7hvrJCJ9y+N6fpZrMUzdNhGH73lR1ZTdDGdcZwCOHHkdP1V?=
 =?us-ascii?Q?y2uKlr5/iQlvQVg1lnW2DAJZB/xMK7yF40hdL19tsUwzCSMYycoBpNzWveAD?=
 =?us-ascii?Q?GjSPqTRNz7M7xOpdiB19fmXFxOvQKiI1WY0Je/jF1KvPwpP2mLIYWwsc7Bj6?=
 =?us-ascii?Q?+ACqzLSoK0EDtwRuOFgZ6mJreOoNBJZrlpgGYTfQAM78TA+sa0c2XkAT7Y6P?=
 =?us-ascii?Q?6bMtSe/RXVo/VTNFseElDgUGfE5tp8loeaEbT4bLG+PhKVg19FIOJ7/SwfEW?=
 =?us-ascii?Q?XdkxLGRBNF697WCjVt0MTHyrEn1WqiEvcTKeeHVayH8lOR5hZQ+Px10aZRkj?=
 =?us-ascii?Q?FV0WHnaENh1jLbF0z01juEa6TG+J0vu/7a9be3+xmC20/MQZ8XN9YXDnKmAA?=
 =?us-ascii?Q?MwpHfbNe9GPktPsDlooNEuMCjiYLMGCreM2a9hvUALsrbXaW+iPfVo+EWjGu?=
 =?us-ascii?Q?oJ2DtIK32RNLJNWp7OqS2qu8BAoe61cHBfzDBANuGXym4vZlAGzwD7ZMmLDK?=
 =?us-ascii?Q?n5BGOaasD+NhIktLE3syMG8O3bfMfo88vzprEZNX3RN4Se6etKrcuT/xcFAk?=
 =?us-ascii?Q?KidC+5i+QeNYNik1OpDyWfmaeiYFV9R+ZhZViMh5fUexvKcRJRrFJqHj9VmK?=
 =?us-ascii?Q?1XLyYT1+nPuXtjF/HKHhHwi+2s6ObhDHXkytMy7RTZwm4XeaO2kJ6U1JVFJg?=
 =?us-ascii?Q?vkMkyySLark0QQC1FhG4pM0GtAfkcHvEBumECMzObeLjVWCgxMg3pwnb51T7?=
 =?us-ascii?Q?aQ=3D=3D?=
X-OriginatorOrg: archeros.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65bd6c82-886d-4ce9-87a9-08db8c239b79
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1015.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 08:54:36.4836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8387253c-f44a-4a28-8058-3e5c20af6b4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iSrX2Ppxg9tP9gV5KVxQYDsvepLdKYzV/LGUw1TrIE8lpN7TyyeW40hpRnbPQtGI3QYkJhUpuxBgwr5DI2MeNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1031
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2406:e500:4420:2::61c
 (failed)
Received-SPF: pass client-ip=2406:e500:4420:2::61c;
 envelope-from=Evanzhang@archeros.com;
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, PDS_HP_HELO_NORDNS=0.001,
 RDNS_NONE=0.793, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 24 Jul 2023 10:00:13 -0400
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

1.hw/rtc/mc146818rtc.c:48
  open #define DEBUG_COALESCEDOD
2.create win7 4u 4g vm
3.Play 1080p video full screen
4.observe qemu log message
  DPRINTF_C("cmos: coalesced irqs decreased to %d\n",
  s->irq_coalesced);
4.perf kvm stat record -a -p $(pidof qemu-kvm) sleep 600
  perf kvm stat report --event=vmexit
5.record EXTERNAL_INTERRUPT

Evanzhang (1):
  rtc/mc146818rtc: improve rtc performance

 hw/rtc/mc146818rtc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.9.5


