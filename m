Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0627A7337E6
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 20:07:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qADqC-0000n4-0y; Fri, 16 Jun 2023 14:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qADqA-0000mw-AY
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 14:06:30 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qADq7-0003zb-Pe
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 14:06:30 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35GCihs1026814; Fri, 16 Jun 2023 18:06:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Brkl9LTve5zexpjGosmwMyTXTDwhQ+Ehe6A6/62dtXg=;
 b=SUkfB0zdkVynQMzWHtrZ2Bt2kwcRfqpEwX0YRKAHkJ7d1b1gapMvdQ2xIj4zKI1a5WyK
 7UrUG5NOqF1+3gRpFCzB9ljY34tZdKnyGdNzSry1xCpyiZQc6nhw6/WVfABlz1EI7HXK
 rCyiU0IfajNdYhl1reG6/sg1DQD6y1vFlRIf6xwgwRQG168YfmsSv8xTSkF93GUejQU7
 W74SOoUCdKtWsmTaaeIlxWARIjBlZxkpQV2A2HAC82hnz1JZiP7cSNSZaeSTiU4Ntqnu
 +j3TZARexBKqyqM8mVj82seD79LR/p1QfcM9q5taD8KuS4/biNcSalfkFOqFSYe17pqZ uw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h2avpy2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Jun 2023 18:06:24 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35GHkKxP009515; Fri, 16 Jun 2023 18:06:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3r4fm8u6at-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Jun 2023 18:06:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LY12zPdop2ihqDaHTBlf6RcOhocedBnroRakXdpQ4d4qMQjXJzMynltIlMg0p/ftttT+Q+bb5iTP4yTz5YW77OXbMYBGuumHj5ddM4qhnzQJQ305qGzBBS/8K9fqMcbhqxh71yC0uNN1PL9Gzg/3Cy0++bnwHhb9gaYzqpHJeT9FHLs/M7OuAZogoQ/DCxrXr5mhP74EIUEnMveMt396ZK4LXNae8G67NSiYhHWK7u4jdyuBfm4/B2auZzTuNhjLBxgBEEWGinLwWwYroNYWEA6GZWfjLVYUH8DTOnaVH9tAlyYZhGGFhr0CUfUfS3YNsZ9hHY+ozz9TXf6wBoHe4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Brkl9LTve5zexpjGosmwMyTXTDwhQ+Ehe6A6/62dtXg=;
 b=C+R9AXyz30nuFXGiEkBGgro8OdPuAAW845WcNskysYhd5nWOeL7ceQ5mR3c/8pTmygi2upfv8NFy3bDK4vpkmAUqFDQvMERHrAN3E1P/e5F00ZB/3jzqN5OmL2qC21j2SG6f1YaekUkDdWltcoaEz8CDA5R6guiAa2yTQiyflcR6hXfQvP3jN3tKdEQ9Nxl34EmeG5JVd7tDyXMrwIO/HxuEF47M29fxhFgL7NWQrLbyOLYdGIXAUR6P58SN062zPOVjVkLWAfPvarwyf/aoU8znLc2bM5Pr7IMQ2Pa366uEkqQ+XgJYsQfDwnu0BkQJlRU2psO6NTsPZwjaaKbQLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Brkl9LTve5zexpjGosmwMyTXTDwhQ+Ehe6A6/62dtXg=;
 b=en3adJ3uHfkS64jwqkOchXzhQCdM1T40wDqAQ81J+/YAhhT8cSYG3jUTpdv3fjzx7rUgrrlHolEMqrV32mV6vSPmDe1MbRoCFGNh4p0jCnZO0DhKqebL1NH8QjOfJK8ex5GA/fpoH7Wydclub5FSoQgPfA1HkJwMDVWRy1XhcyM=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by CYYPR10MB7567.namprd10.prod.outlook.com (2603:10b6:930:be::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.41; Fri, 16 Jun
 2023 18:06:19 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f%4]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 18:06:19 +0000
Message-ID: <99f22a56-a7e4-069b-5e03-b892806409a4@oracle.com>
Date: Fri, 16 Jun 2023 19:06:14 +0100
Subject: Re: [PATCH] vfio/migration: Fix return value of
 vfio_migration_realize()
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20230615081851.326816-1-zhenzhong.duan@intel.com>
 <67af377f-a8b7-c879-516e-9544d6a4fab2@oracle.com>
 <SJ0PR11MB6744E8D7540A3B9E540A9F69925BA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <186c9e07-c1e6-74ae-0a4f-7d6bc0c8ceb6@oracle.com>
 <SJ0PR11MB674488BE146A88E35D763C639258A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <2f3ee2ab-e37b-c429-e604-b62440d37278@oracle.com>
 <SJ0PR11MB6744FA7630BA42F4DBFB30FA9258A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <b5023864-f56e-24b5-4e1b-007184484c2f@oracle.com>
 <c28aa967-ef65-a8be-8ae5-b04c604ba988@redhat.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <c28aa967-ef65-a8be-8ae5-b04c604ba988@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4PR09CA0003.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::6) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|CYYPR10MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: 51f9aa47-fbe8-428d-3585-08db6e9462e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UKSx82NNidHlorp5UU5jaJngm2v7/BBW4F2LRHLCZGSxzxLuu6UczzkX8ZSP0ly6C1KGUrX9dZ4XU9JrQrqufYZ9l2shieE1Qqdp2YcSf4omeJJGY/3TZ0Z5cgS5VYRbzk09/zzNpFEgu2cVsh6ZQmOEPpvei9rP8AvosnhyufdAqy86+Y+wi07KNmvI2i35BrDM6DTjZcWDEkS/wZg6zFDMRu0Ejn9VfX8ZtL0Rt4NZupOAs+gSHPSo63TVWpeRhzeaZb5HVPTkru3FMLsUXD0lRaZLGX8++ua3YcUk6eT7gTwX+ewNEzBNT/f7rYcFrH3k3J+VQ8F6GhEXeLEWmUjsBNYF5XrxmYvxkG+ihgxakxky7rrGnSVfscFjr3HKe9cQ9Bp5ZgZWR76VOrU2d7Nw8hD6dAi+Z1CZ1dKqL9qsa1CjeXOTElirBVFnGJzCUp/BsGMSeAKb+gqP7AWiNxBryGi4frIzg4YLwLe8Fx7XcxflrBHk2L1enuqk0ZppgJhXInKWLc984ceRmLDwxQa/hfRMmBqcXzriakzifdRuTFRr1VWjDbknvAPwCEzV4I0SVUOjqzBGMPjPXHU7X4rbZYj5tliPJ9lCAgS0EMQ94gsDrzo8zWNQ9tG81pmD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(136003)(346002)(366004)(396003)(376002)(451199021)(478600001)(36756003)(66476007)(66946007)(66556008)(38100700002)(4326008)(110136005)(54906003)(5660300002)(8676002)(86362001)(31696002)(8936002)(2906002)(316002)(41300700001)(83380400001)(6666004)(2616005)(6486002)(26005)(6506007)(53546011)(186003)(66574015)(6512007)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UngwWU9oemlwT3ZESmozUjZDbWVkZ2RMelZZUjJTT1FrR0ZLWmZUU2FGWFpa?=
 =?utf-8?B?M2pHL3lNOVFyU3Jmbk5heHo2YXo5ZnVvRHdiWjQwOUx3blRzK1pvb2VyOXRy?=
 =?utf-8?B?MHhIQjV3V29teHVYUEM2OXVsYyszbEtsSVlHOXAzQVBtakdwWVk2VGdPT2R5?=
 =?utf-8?B?UFgyMWJTQzJoWWhzUTI0QXl2ZjUrY2hTaG5PUGdGT1ZjV2gyQ1lFYUtPZEZQ?=
 =?utf-8?B?K21lSDlhMVpEQzA3SFUxc3F2UTV3Q3o2SlcyL0NNUHdnSy91bXZhQWZNTERT?=
 =?utf-8?B?VllweTNoMWs3aHUxZTZ4Q2ZNWWhCQmN6bUJZa1huSDRmbHNYV0w5SC96LzJu?=
 =?utf-8?B?SVBPcHFtQXRGeUU2ZWRQeFk4SktmcGhGdWVrSDlLTUNDcVRZSFowMEx3b3U4?=
 =?utf-8?B?MzJqR3BvR0s3SEdnb0FNZGYydjFTbHpqaVlJZlU2TDhtSmJOZmhwVnNOVHhk?=
 =?utf-8?B?cHhjSWdkN1NkczRoelBXcWc2cnFlMGJLTnNSMEZDUFgwaTdNZVZ1K1huWDlu?=
 =?utf-8?B?ZE9wdnVBQW1mQzl2SnVaVENkY0V4VkRqeFJRUDZWTXNZQU1vVHBXRGl3VWM2?=
 =?utf-8?B?RDF1V29BZVN1bDUzTWFHZE55MEVHdE05eUlWLzJZWXdDcTFLUHkvV012ZGNH?=
 =?utf-8?B?eGNhN2JjSDlTQXZTeGFZS3FPWTRUVHp4VWdudm5SeTdFTkxDRkdkYkF4blRk?=
 =?utf-8?B?NXp2bzYzWlU1U092M3doYTlXK2REYTdvajVDUDlraXRmQ1JQbmVyVGsrc1BC?=
 =?utf-8?B?bmdnajlDc2h6NjVOdDhJemV0WjRNeDNvcTBYbkQxZUhnVzBXaFliY2p5VWpT?=
 =?utf-8?B?dEZoVjkvS0hsMlNtYkUzdTFTWDhzY3JRYkRoODE0bWEra2htZWxzZEp4L1l0?=
 =?utf-8?B?dVNxLy9BdjN4UEUvM0FUME51K0dTc21BdHd2bERXZ28yUU9Udk8yVjhnRncr?=
 =?utf-8?B?clkvaHRRT3c3MFJRYTIrbWV6OGdvZStST1h3ZWNCVWxvVWp2QjFmejc5V3Ix?=
 =?utf-8?B?QnNuYXJXUE92YUtMRnZKelQ2cEkrNFRFNDh6M0gyWk1pS2R5bDlNMDcvWkVY?=
 =?utf-8?B?bzlPVDk4ZEZiY3FzMlF4OGplc010RTNDVWtPTFpOODhIZ2ExVVBUQkVXWk1L?=
 =?utf-8?B?ZXdUOGoydkJVWnNOWC92aEIxYjZLVGJDdHJ5ZklHM21oaXozNVVvc1dhZ1E0?=
 =?utf-8?B?V1JSZm5vb1ArMFFKcGFCWkdyVEdZbzF4RXExUGtoQThTN0FaZ2VjbVJ1SHVa?=
 =?utf-8?B?SlZNQ3IrR1NDT1Y3amhOblhPaVE5Z1kveUJGQmNBNS9VMm8vNXRkWHNCazhx?=
 =?utf-8?B?VWZpVkk5UU9NcFRxQmh3SUpCOXV0bmd6dkZYdEhtcTlhSzJJNUFYOGZHdERW?=
 =?utf-8?B?UjdrNWZ4SUFTS01RRDlCS1prRFJ5UldNUVBJbzVESmVTeENGdW1WY1pOVzhz?=
 =?utf-8?B?K1pKVjZ2bWFObmpsTXVXamVYNXdxTW9aYWV1amo1MG1VM29CNXptaXdpQldz?=
 =?utf-8?B?SXJFWkRlOGROQzBjNjVSUWp4UGViT2RzSkdtVjhjaUV6NElXV1dCUWtFRTJv?=
 =?utf-8?B?UmhVQzJQeHRId2EvQStxcWhTbUZwblpQQ0RkNzJDYjd5RHYydzFwTnBSdWhn?=
 =?utf-8?B?T1lTVkhkdGZpeHJkdkZybm51a3U4VlByeHhuMmprS2RzcGJ2TjNONTcwdGNQ?=
 =?utf-8?B?TFZReTZoYWQ1MWxSYkJ6elpTdVJGZmlORzZOQktOTEhFUGVpbko2YWNMWENw?=
 =?utf-8?B?M2RNOHR2NUFGUlBoOFNiZzZGNzlEU3JmUHltUVRXZ1VLakxzdTc3MDVXWFFO?=
 =?utf-8?B?bWhKTzVKZU45MzF3TGNEZHVNZFhQeVBTdlRnZnpvb1JvdjhQSW92Y0kxakh6?=
 =?utf-8?B?dWR5Y1k5NnJyYjlUNW1DRkdlNnIrV2JETHVxdlZmZlZHYmF3VzQ2U1c1L1lJ?=
 =?utf-8?B?Q1EvVEUrMHQrMkNGWEdCeDNPTGQ3RmcwMWV6NFVwYTFwMjdEd3VScXVLK2t0?=
 =?utf-8?B?cGU5QkNlbFhhWENDRDNRM1M5L1pNdVhjU3hleEFuMmtndkZzRFhKeWhwZFpL?=
 =?utf-8?B?VWF3Z0tWdzVXTGk2SGFxeDNqejU5ZWlrdkVNM1doa2J5OU5YeWFkS0pTTDRn?=
 =?utf-8?B?NWJaM000MGsxNDBIazI4STZjTTlta0puUGhyWTNmMzB0SCtaZmpjNTI0a1d4?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6KrUCGj32Re1aeKw0+4qYFlbbgjsTvk3WMbNJy4We61SeAr2aCD/0Omc6y8PN37KVGh+UotGTzZR5o6PcisPv17Az8ZE1mom1eJbI8h2m9E4wuxz14ceO0sceAd33+5AZj/TaKYshm3zJUL+h8ogb12iznIgLlRefZFFbxSpis1erB17PnRBJAAKCUy7liqp7XaboR0FZkxp4BsalvwgK8icOiDvbeomJ+oAvzHtkXhczlffONcTlx2GE7mKI8p05YJZSNLJUgWPhr4VWduRovsz6ufBNy//fNPnJe+ruXQf4jIeVJIF/rRFu3Sbh+DBqBztUHSfI/xcSsnqhRJxfcMt/ax843ZgesyCuDvcOvv9kzmuA2L1uqjU0eO+BDn9W8QiE7Qecri9y2XCVhq6eRYl1VAy2jmtXLUxtNjVQ7IRN9o4+QvuOSVUi4K6KFgB1HBvGocLnIKQSOc0C1/s/gk2gWrUMA8OTBNpp+juo6gC49Vvr/2dYZ9evp8ap0LzjnUFHykowOcD/e3MnbmdxMAkTY88bH8izrIqANpd7VhOXunryUeVkd4tTHnduerSpxatHSE1Gw4hG8iAfgiKBx3vijjY5dtFVfpkycSYI48dDU3av7GAvno0cPMjpDpkiUgxpVvBagfm+LpzWHvk9pzZXMjZb3snYGe/Kcgn9FQbxtPztw15z0MUBwZd37F1udFYUax5CYt3hT0A0g6BvdQ8/iGY4H1l6tmBSkebaHcwC1pAlxojq4vNi0BldQfQePaK4tZmaEozSXFX5AoVqzRqDgRJ+JPYqTzQvQOSwEYO7qtOYKts1Ks7WaVZiBx5
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f9aa47-fbe8-428d-3585-08db6e9462e6
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 18:06:19.8317 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vGH5VWaShPV+ct3hvrNBZkM/Lxj8q+gkkmwpbJ/cjRHUp2FXAbMHzmnkqtzQR+TcaxAARGL/EHDFe/RyczzRi2MpJW8+8KnV7eopwAu9UDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7567
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_12,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 phishscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306160163
X-Proofpoint-ORIG-GUID: Bag3BmZAxzt6PHwhpzYE9zTfpDxx9DLX
X-Proofpoint-GUID: Bag3BmZAxzt6PHwhpzYE9zTfpDxx9DLX
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 16/06/2023 15:04, Cédric Le Goater wrote:
> On 6/16/23 12:12, Joao Martins wrote:
>> On 16/06/2023 10:53, Duan, Zhenzhong wrote:
>>>> -----Original Message-----
>>>> From: Joao Martins <joao.m.martins@oracle.com>
>>>> Sent: Friday, June 16, 2023 5:06 PM
>>>> To: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>>>> Cc: alex.williamson@redhat.com; clg@redhat.com; qemu-devel@nongnu.org;
>>>> Peng, Chao P <chao.p.peng@intel.com>
>>>> Subject: Re: [PATCH] vfio/migration: Fix return value of
>>>> vfio_migration_realize()
>>>>
>>>> On 16/06/2023 03:42, Duan, Zhenzhong wrote:
>>>>>> -----Original Message-----
>>>>>> From: Joao Martins <joao.m.martins@oracle.com>
>>>>>> Sent: Thursday, June 15, 2023 6:23 PM
>>>>>> To: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>>>>>> Cc: alex.williamson@redhat.com; clg@redhat.com;
>>>>>> qemu-devel@nongnu.org; Peng, Chao P <chao.p.peng@intel.com>
>>>>>> Subject: Re: [PATCH] vfio/migration: Fix return value of
>>>>>> vfio_migration_realize()
>>>>>>
>>>>>> On 15/06/2023 10:19, Duan, Zhenzhong wrote:
>>>>>>>> -----Original Message-----
>>>>>>>> From: Joao Martins <joao.m.martins@oracle.com>
>>>>>>>> Sent: Thursday, June 15, 2023 4:54 PM
>>>>>>>> To: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>>>>>>>> Cc: alex.williamson@redhat.com; clg@redhat.com;
>>>>>>>> qemu-devel@nongnu.org; Peng, Chao P <chao.p.peng@intel.com>
>>>>>>>> Subject: Re: [PATCH] vfio/migration: Fix return value of
>>>>>>>> vfio_migration_realize()
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 15/06/2023 09:18, Zhenzhong Duan wrote:
>>>>>>>>> We should print "Migration disabled" when migration is blocked in
>>>>>>>>> vfio_migration_realize().
>>>>>>>>>
>>>>>>>>> Fix it by reverting return value of migrate_add_blocker(),
>>>>>>>>> meanwhile error out directly once migrate_add_blocker() failed.
>>>>>>>>>
>>>>>>>>
>>>>>>>> It wasn't immediately obvious from commit message that this is
>>>>>>>> mainly about just printing an error message when blockers get added
>>>>>>>> and that well
>>>>>>>> migrate_add_blocker() returns 0 on success and caller of
>>>>>>>> vfio_migration_realize expects the opposite when blockers are added.
>>>>>>>>
>>>>>>>> Perhaps better wording would be:
>>>>>>>>
>>>>>>>> migrate_add_blocker() returns 0 when successfully adding the
>>>>>>>> migration blocker. However, the caller of vfio_migration_realize()
>>>>>>>> considers that migration was blocked when the latter returned an
>>>>>>>> error. Fix it by negating the return value obtained by
>>>>>>>> migrate_add_blocker(). What matters for migration is that the
>>>>>>>> blocker is added in core migration, so this cleans up usability
>>>>>>>> such that user sees "Migrate disabled" when any of the vfio
>>>>>>>> migration blockers are
>>>>>> active.
>>>>>>>
>>>>>>> Great, I'll use your words.
>>>>>>>
>>>>>>>>
>>>>>>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>>>>>>> ---
>>>>>>>>>   hw/vfio/common.c    | 4 ++--
>>>>>>>>>   hw/vfio/migration.c | 6 +++---
>>>>>>>>>   2 files changed, 5 insertions(+), 5 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c index
>>>>>>>>> fa8fd949b1cf..8505385798f3 100644
>>>>>>>>> --- a/hw/vfio/common.c
>>>>>>>>> +++ b/hw/vfio/common.c
>>>>>>>>> @@ -399,7 +399,7 @@ int
>>>>>>>>> vfio_block_multiple_devices_migration(Error
>>>>>>>> **errp)
>>>>>>>>>           multiple_devices_migration_blocker = NULL;
>>>>>>>>>       }
>>>>>>>>>
>>>>>>>>> -    return ret;
>>>>>>>>> +    return !ret;
>>>>>>>>>   }
>>>>>>>>>
>>>>>>>>>   void vfio_unblock_multiple_devices_migration(void)
>>>>>>>>> @@ -444,7 +444,7 @@ int vfio_block_giommu_migration(Error **errp)
>>>>>>>>>           giommu_migration_blocker = NULL;
>>>>>>>>>       }
>>>>>>>>>
>>>>>>>>> -    return ret;
>>>>>>>>> +    return !ret;
>>>>>>>>>   }
>>>>>>>>>
>>>>>>>>>   void vfio_migration_finalize(void) diff --git
>>>>>>>>> a/hw/vfio/migration.c b/hw/vfio/migration.c index
>>>>>>>>> 6b58dddb8859..0146521d129a 100644
>>>>>>>>> --- a/hw/vfio/migration.c
>>>>>>>>> +++ b/hw/vfio/migration.c
>>>>>>>>> @@ -646,12 +646,12 @@ int vfio_migration_realize(VFIODevice
>>>>>>>>> *vbasedev,
>>>>>>>> Error **errp)
>>>>>>>>>       }
>>>>>>>>>
>>>>>>>>>       ret = vfio_block_multiple_devices_migration(errp);
>>>>>>>>> -    if (ret) {
>>>>>>>>> +    if (ret || (errp && *errp)) {
>>>>>>>>
>>>>>>>> Why do you need this extra clause?
>>>>>>>
>>>>>>> Now that error happens, no need to add other blockers which will
>>>>>>> fail for same reason.
>>>>>>>
>>>>>>
>>>>>> But you don't need the (errp && *errp) for that as that's the whole
>>>>>> point of negating the result.
>>>>>>
>>>>>> And if there's an error set it means migrate_add_blocker failed to
>>>>>> add the blocker (e.g. snapshotting IIUC), and you would be failing here
>>>> unnecessarily?
>>>>>
>>>>> If there is an error qdev_device_add() will fail, continue execution is
>>>> meaningless here?
>>>>> There is ERRP_GUARD in this path, so it looks (*errp) is enough.
>>>>>
>>>>> If I removed (errp && *errp) to continue, need below change to bypass
>>>>> trace_vfio_migration_probe Do you prefer this way?
>>>>>
>>>>>      if (!*errp) {
>>>>>          trace_vfio_migration_probe(vbasedev->name);
>>>>>      }
>>>>>
>>>>
>>>> I am mainly questioning that the error testing is correct to test here.
>>>>
>>>> IIUC, the only one that can propagate any *new* error in
>>>> vfio_migration_realize is the calls to migrate_add_blocker failing within the
>>>> vfio_block* (migration code suggests that this happens on snapshotting).
>>>> Failing to add migration blocker just means we haven't installed any blockers.
>>>> And the current code presents that as a "Migration disabled" case. If we want
>>>> to preserve that behaviour on migration_add_blocker() failures (which seems
>>>> like that's what you are doing here) then instead of this:
>>>
>>> Current behavior(without my patch):
>>> "Migration disabled" isn't printed if migrate_add_blocker succeed.
>>> "Migration disabled" is printed if migrate_add_blocker fail.
>>>
>>> I think this behavior isn't correct, I want to revert it not preserve it, so
>>> I used !ret.
>>> Imagine we hotplug a vfio device when snapshotting, migrate_add_blocker failure
>>> will lead to hotplug fail, then the guest is still migratable as no vfio
>>> plugged.
>>> But we see "Migration disabled" which will confuse us.
>>>
>>
>> /me nods
> 
> Yes. Overall, the reason for which migration is not supported or is
> disabled is not very clear today (for the user). It might need some
> more adjustments, like this one, before we remove the experimental flag.

I think the "Migration Disabled" was an UX oversight when we refactored blockers
into vfio_migration_realize(). The actual migration is *not* disabled, it is
just that the message or tracepoint shouldn't be printed. The reasons why it is
blocked / not supported are clear in code right now.

> It will also help QE to define test scenarios and track expected results.
> 
>>   >>
>>>>     return !ret;
>>>>
>>>> you would do this:
>>>>
>>>>     ret = migration_add_blocker(...);
>>>>     if (ret < 0) {
>>>>         error_free(...);
>>>>         blocker = NULL;
>>>> +        return ret;
>>>>     }
>>>>
>>>> +    return 1;
>>>>
>>>> Or something like that. And then if you return early as you intended?
>>>
>>> Yes, this change make sense, I also want to add below:
>>>
>>>       if (!pdev->failover_pair_id) {
>>>           ret = vfio_migration_realize(vbasedev, errp);
>>> -        if (ret) {
>>> +        if (ret > 0) {
>>>               error_report("%s: Migration disabled", vbasedev->name);
>>>           }
>>>
>> Makes sense. Checking errp above before printing the tracepoint (like you
>> suggested) is also an option taking the discussion so far, but perhaps the
>> return type to be bool to make it clear to callers that this is not no longer an
>> error code? Maybe let's wait for others on what style is generally preferred in
>> error propagation.
> 
> I think the code should follow the qdev_realize() prototype, which returns
> a bool.
> 

That makes sense, it makes the decision a lot simpler.

> Thanks,
> 
> C.
> 
> 

