Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C82073AB00
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 23:03:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCRRB-00059L-RC; Thu, 22 Jun 2023 17:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qCRR9-000597-4u
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 17:01:51 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qCRR6-0005kP-Hg
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 17:01:50 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35MGPImf025422; Thu, 22 Jun 2023 21:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ILiG9RL93jLeFFvdZegVahA9xTPNEOjRb25GLUPsie0=;
 b=Di8LK+IhLq3y4wNUGTWE79oeAl52VLLx3RRQ8AQqWS8zkl+edLAYDev/ajjWLS4s5L9x
 6zMyeiglI4qYM/Wn89KkM8Eeqy1DbnCsKXM5Mlcey6fdb2Ry73n4Bf7OXoo6HgFsU2kT
 yygTmS/vUO1YaLa9CFk92tFSE9ixxZe9MJinGRkGs6EZwjdKCnt1qsnZhRyZl6XiZiEK
 egJTCnbCUh3jWB45PlsxTXnjb7eZInUyVPCWBcNn+CpvpLwlMh27xu1H3U8QmtouPNAI
 04WsGkaREc7ord1kENnIUOY7ppef8/hbOLar3iKLZqm4Sy5d1ziIq1Ylbb9n3lWdNW9Y UQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r95cu2s8v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jun 2023 21:01:39 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35MKU2fd028905; Thu, 22 Jun 2023 21:01:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3r939e4vj2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jun 2023 21:01:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IkaXek+6/Ky/IleRAV5TCghSa1rtAoRVrqoAoYuk8aUWP75itDjJWWWIdXFRFQVwf/1PnIc93GhtriE6Vn391lRY6RahtQfjm3MFLzO16j+owN+IP2jL08xbXlM00WBACyPc5RqtDIPAX75p4LfdHj3hfZAqk3HBBHgqIc+0Yq6iqZLBUzcAZisn5Y8n7BzhDpFdboZswV1RVDFY2kgd8bTb5YsiDj7V1Tp7Y56b474bYrHQs+Y2KdYEN04J1kl2OxA1FZsAuX9Mvz2Tgf5iqv6RgO+esBdKWly9f6v4Sd0DG9vZqqjXDFcNDWcmq6fOzp1qro3UyaDecw2DRPUkBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILiG9RL93jLeFFvdZegVahA9xTPNEOjRb25GLUPsie0=;
 b=aRNamD+TivjThbcAogH1TrSo0C8HlEF7n0pfRBf3dZVP9Ah+8obZSLOgL9w7va6ATCkYKaAbc/nmrgjMe5HnP7nfLFTEFO/M6kw75PVoBEm3w2gaWlmHrlqK6SL6ltbQ22XBi/cnRM1t2STw9lFBU5evG8JUbor9nsxTJSTgdD63itWXWe4neQaE/H99xGoZXUEXIX3Ow0x/yyS08cI5/v36LW7bgIw1AqtmaNypEkejd1Kwty/Vsf4Zr+tRx0bYWT86MB+f42yZQUBS5LJ7/m3l9q31NCcVb74hBRiqNDPj3orItcdn6ubo/DG5iW73ZyHcjGAhGa48kyjnU1tyEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILiG9RL93jLeFFvdZegVahA9xTPNEOjRb25GLUPsie0=;
 b=yl2FdCYV2Xtp7XlwcOlQIiWf+Fh0G1WQfGTXXX4Ayg25LDqEODw/4bVO1yxKg5Vu4qgKIibHlCckuG/fnJqwzHdTTwTmFj+jMTWTfRopvCv9D8sE0RTtRDTHSrwv2flLLDOEynvBsiWZR8kTc+Udseed6xLCO2umnNjxSr8wFcc=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by CYYPR10MB7568.namprd10.prod.outlook.com (2603:10b6:930:cb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Thu, 22 Jun
 2023 21:01:36 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f%5]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 21:01:36 +0000
Message-ID: <fb694464-e059-a919-a9e1-55073b601184@oracle.com>
Date: Thu, 22 Jun 2023 22:01:29 +0100
Subject: Re: [PATCH v3 01/15] hw/pci: Refactor pci_device_iommu_address_space()
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Avihai Horon <avihaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20230530175937.24202-1-joao.m.martins@oracle.com>
 <20230530175937.24202-2-joao.m.martins@oracle.com>
 <ad557a25-0cca-518e-9d0f-f69f8bbd98c6@linaro.org>
 <41a452d7-5b17-d2b8-401e-5b5e7ddb5299@oracle.com>
 <20230622165003-mutt-send-email-mst@kernel.org>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20230622165003-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR06CA0088.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::29) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|CYYPR10MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a7ce98b-6f0b-4f42-6f34-08db7363dd76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V8T7zpY4potyaKOWMy2pnhsI8JNN3DZB5lv1HKUra+GOLZDqOjnOvwruqjG1vLCj4wUZOeGeytgiw4KCbni2/UYeF1LBfn6INniExeUzkfIT9unEOVE9TgSrSzLHKmghv6kVHaPRhXBZj1lYg1PKWTLEGA6TBaVrxlRmCkrOgo4Gh1dAdmBL9WqDA8lTWFTyEhS+Qd0ecpexEvb9gkwMVeJQq6gEi5W1/zbwgX2TNZFUyeQdTU4Rieuir/cSksY8Yzpl3nmSwv7xydMjIes2Mq2FG1ZSXwCEnaatq8BfhdSifZvf1Z4FB6bt82Dluu6/hK9p+Bd1PaiGKAmXogbfVafxwcBgaszDp29XO+tqodiyc8kuJeEcLWuw8tXBufl2BKOtF1ITVvw7KYF05I70BuocybFX9TWiCf3XNISQTaAp3YUgDsDkMr3Yzi4H48l2KeN0LiNG9tm45YwSIQLcH8O5g7gbjDCtGFbKCMaGKO0Fb4IhmMRhTbtYc5ARMWVxBV2JJ2XaSYLaP4ExA5OEBFj/tlKNdAVfg/JhW5+jz6TXMP1WXSUHSjT+SX/EEPWPJqiMYbmgQzRQHE0g2DwEIDpBOCMNUIjRB6qAid7+DOZmj5CRGUDdQvKsy+sRPol5qoyRmpLNCpjVEQOWOssHQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199021)(8936002)(66556008)(8676002)(186003)(966005)(66946007)(66476007)(5660300002)(4326008)(54906003)(6486002)(316002)(6666004)(478600001)(36756003)(41300700001)(26005)(38100700002)(6506007)(6916009)(6512007)(53546011)(7416002)(86362001)(83380400001)(31696002)(31686004)(2906002)(2616005)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEJTUW5NV0NrVFpURS84S1JlVmJZb01MeE9vRzNxYmJiTjB5WXhWNVEwZUlF?=
 =?utf-8?B?K081RklLN2E0MjNBRXRDY2F6VTdKd1hOTEFzbERtZDdtbUJpNDFHRFF0b0RC?=
 =?utf-8?B?ek1UNXVRLzk2b0pQK0c3UFJPNlRoajl6UTZEM1VkN01kV3hhblQ2TG9FUG5v?=
 =?utf-8?B?U3c1Y2Y3bmpyWFl3UDAyUVhBTmlkbFVUenJDTTl2djcwZ21mNUlmeERSaTlw?=
 =?utf-8?B?eFhYN0d0b09WZG05YkZNdC90dDJOdFRGRS9RS1lCUlhpcnppamhUaWJ6cnpo?=
 =?utf-8?B?cjVEMTM2REw1UzhaVVAvNEdQUDJ5UDdWWDBPTG0zY1FxVm1kWXUyTkJpcXln?=
 =?utf-8?B?OWFEWkRBYTlIb1dOR21VL29IOTdMQXRZKzcxVGlvUTBUVGc0c2NDakFGUklx?=
 =?utf-8?B?QWxySlBZWHM1ZHRWR2cxVDljMlFCWnk3Si9VZnZLbjBDamYrc1lJaHZidldD?=
 =?utf-8?B?WnZlUis4YmNjVERrR2N6RHB3K3hjcUVrMFVtaDZSendyS2pKWFhzWFd2RmVG?=
 =?utf-8?B?SmdxVExiSWtoSDdndHY4L2U1cjRvZEtxNENLWXkyN0NmZmI4QnBxRjUvNkN0?=
 =?utf-8?B?ajl1T0pxMytybExYVFhFTmx6dHNaVzdxWDFLcmRxeW9kWEI0VStEWWtxRXVQ?=
 =?utf-8?B?N1lIR09nbU9NRERPQ3lQVWwvVlRxU3BxTzR0QW1QZFd0L0d6VjZPYlVpVWxQ?=
 =?utf-8?B?RWlid01wSVI3a0RaWUZ5UVdoamZuajBZWC8ySFFuYzBzTUcrSHg1d2pDeVJG?=
 =?utf-8?B?N3A2aTVidWlFVVJjZG9TaUNtaFV4QThpdlFUT1RubVJaTXZpYlhOTHZkQ1Yx?=
 =?utf-8?B?a283ek5zNWs5Y3lJMTlLUWdCV3NoZnhoNGRJWU1CeVBiV3JIcGkyc0VaOFZF?=
 =?utf-8?B?M3RXVS9XWmxVdCtlNlBvRXUxbmE4dkh2aEZyVnlmTE1ucjRQNWFVdTJjSllP?=
 =?utf-8?B?S0ZSbk9jZzdMSmlka1dRcjhtL1RDV2V0WW5oRURFbWd5SnZmNU85My9tSmwz?=
 =?utf-8?B?RzJ1UnZ2OWhiWnlzU3lQcHc3bDRRNk5IK0Y2NDlHSmJNSFlMNENiTDYxa25p?=
 =?utf-8?B?bXpMUWY5UXNMUGtwSHJCY0hqTkZEWmN6UWEzT3dUZVJNaVNSbmpCYndoRnFa?=
 =?utf-8?B?U2V4Mk5nVU1hdVlmYm4yTmlyMFdmZHlDb3BmRHcxdWJUMmJrb2Z3MW1JUExy?=
 =?utf-8?B?Q2h1aitTSE16VTU0ZDEveXBlV3B4eDcvbitadnRscmE5MGx3eGJTcnJwNi9O?=
 =?utf-8?B?b21iNVZScVBUMEdqUWZDZko2UFB6SHdZdi94ekZxaTN6Zm9Bbkd0Qmp6U3Rs?=
 =?utf-8?B?dGhuM0pEZXI1Q2w3eGVncndnWFVGL0pCcDc5bUkydFM0SWgxMnlLLzFLK2dH?=
 =?utf-8?B?MHJvVE9TbzE5NEZ5OUFRQUJKQW9TTEFPa1hsbDZjSUZxdkgyRlRpTWNyZXNV?=
 =?utf-8?B?WG02bUgwZWZXWVl5em0yZEpwTFFvSjJFRU9WNzFnNVNSOURKWU9iRTRqSGV2?=
 =?utf-8?B?QXlOVVhmZmFzakhxWnc3ZXdBYmROK0N6RElISjJJcFNtN0dDcUJ4OXZDR294?=
 =?utf-8?B?VFNuK3h1Q0tnWDFPTVV1UE5vekw4NXE4NCt5QStyS1F3VS9MNjg3Q05CdHFy?=
 =?utf-8?B?S09Wc0sxNGpSNis1TWFlWFVBZDh5SVRJM0ZIZ0EraDFEZnFVMm9LZERNNU4w?=
 =?utf-8?B?Qk1KbEJNaTFwdnNUZUdkWmF0RzIrZDloNTJsQ2NoNUY1anJtVG1jL2k3UTkr?=
 =?utf-8?B?TU5xcWVIOXpublNpM2doVUFrWHlKenFGTm9hQVBWYnlqWVYrblFqS1RNRmRN?=
 =?utf-8?B?RVlqYnpaQkZkcVFVcWx3S29HdklaZjVQTUxiVC9CVmo5NUl2YzV1TFIxMEhC?=
 =?utf-8?B?Qnc4V2hQU29JTW9ONUY0RUR6ZkJnRm5hRWJaYnZiWXdPK3pSQUFmSGpHM3B0?=
 =?utf-8?B?bE0rTTcvd1ppaEVwM0RzVWRub2NNc2YySTh3Q1FzeWhYeEUzSWV3NGU3REI5?=
 =?utf-8?B?TlVxSlZKT3h5Y1dQZFR5aEFwU3hHSU03aitsb2svRXRlMzNhWnVqazBibTB3?=
 =?utf-8?B?eHRxNmx3OTdnTmRFNExBdGxuNzZNOEFEYmpQTGI3L1MzVC9kaXZTK0hzdjdR?=
 =?utf-8?B?U1lSTS8vTEVDUXJhNFNnK1ZmTlZ0WWZZU3dxaEZIaUpqaEx5VWk2bUFueGVm?=
 =?utf-8?B?NlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4R+f4JosA3FjStS+iZyGdlH9fdaJXGAlOSArsFTk6F5Ji2HIwhQr/3Y5IB2Ce1cB5TMo/XCS6QTeNRVOBbejBTw0Mty2R/lFtzbcTUFoh4rLFF8hXGW1mjPQ08glKQCmy6rh6NNEz+W4f6vrHgfr/iTH0FAq1rHfcB9ZdmA0IcC+e/+AYJko2hr+6Aw06W35tfqb0bgSETc1rfwOfNSeHgsM7DJKX4pZ5H64u9eYkX/So+QP3M0zFNbGE2cBRPkK1TQVpKimmFwUit/YoFSoAPO87fL2Ev6U08Y9PPY9Dgcxv/DHjVKGch982IdIEX40L63m6ZSEn7Ui8Fou23KFC9bWHN78Gvk0DcbOsUrfSacWVQV4vGZ04lWHZJPzpcymoF2vBzwcp7LhoT6+osfLw7zGi+3yoooQ4ZC9rdL7ZFykKQ5/OaLJpev3fs0Wx6oSHX/DFOFFymU56DZmM9VRhOE6O/EKs/x4xmTu0wOIzdOVLBk+yuYwJew/i8lfMr+RzJb07qnpa0dskUK+gvCFGnbuxE7OpQmnU8tLebTeLP4OMDMqJMbbVfNW0ZhPfN+PnN7qs7LpspNEoXnId8QzSD9yEofFH8bm6Ae9sDJ5QFihJmUgB+wQT2YXxpr9xoJ5ZS+bE9rVWQuKMKS43X5cLOogWamxCUrKw3a+1DdflJspWhYpRWFkTqWSm8/jTts30Qrd9qP20f47EAL8+NWdc7Am+v27zaHriNTr3wVEniJUhp/my1LOvsJ4GztlThrk+aRNrQgj1qsSB1l4coPe/fkbNLl6n7+4XhIbBz8FBreFPZD2VX446r0F1bUrSDTjZpEc1V8xyDExD5XXfZ6eLLVhr2ZnZvYhTZJ+B4uCWUXRWFF8bZIh1bDCi2wBXqezAO/Dns4yttUPb78oHB9KHw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7ce98b-6f0b-4f42-6f34-08db7363dd76
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 21:01:35.9277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mt3pfF31nHibo/LXjG2TEl/Q07i3MPBzUTlqGNWRCY0Av5XWVynAUuxzhMcidGF50s76+rnWPpocEpeJ3CdyCf3UXFgIkh/aUCpy4X92C/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7568
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_16,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220179
X-Proofpoint-GUID: aV8Oz7IYDhEGFCcCDSC5mLmlXqREpB0S
X-Proofpoint-ORIG-GUID: aV8Oz7IYDhEGFCcCDSC5mLmlXqREpB0S
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



On 22/06/2023 21:50, Michael S. Tsirkin wrote:
> On Wed, May 31, 2023 at 11:03:23AM +0100, Joao Martins wrote:
>> On 30/05/2023 23:04, Philippe Mathieu-Daudé wrote:
>>> Hi Joao,
>>>
>>> On 30/5/23 19:59, Joao Martins wrote:
>>>> Rename pci_device_iommu_address_space() into pci_device_iommu_info().
>>>> In the new function return a new type PCIAddressSpace that encapsulates
>>>> the AddressSpace pointer that originally was returned.
>>>>
>>>> The new type is added in preparation to expanding it to include the IOMMU
>>>> memory region as a new field, such that we are able to fetch attributes of
>>>> the vIOMMU e.g. at vfio migration setup.
>>>>
>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>> ---
>>>>   hw/pci/pci.c         |  9 ++++++---
>>>>   include/hw/pci/pci.h | 21 ++++++++++++++++++++-
>>>
>>> Please consider using scripts/git.orderfile.
>>>
>> Will do -- wasn't aware of that script.
>>
>>>>   2 files changed, 26 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>>> index 1cc7c89036b5..ecf8a543aa77 100644
>>>> --- a/hw/pci/pci.c
>>>> +++ b/hw/pci/pci.c
>>>> @@ -2633,11 +2633,12 @@ static void pci_device_class_base_init(ObjectClass
>>>> *klass, void *data)
>>>>       }
>>>>   }
>>>>   -AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
>>>> +PCIAddressSpace pci_device_iommu_info(PCIDevice *dev)
>>>>   {
>>>
>>> This function is PCI specific, ...
>>>
>>>>   }
>>>>     void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque)
>>>> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>>>> index e6d0574a2999..9ffaf47fe2ab 100644
>>>> --- a/include/hw/pci/pci.h
>>>> +++ b/include/hw/pci/pci.h
>>>> @@ -363,9 +363,28 @@ void pci_bus_get_w64_range(PCIBus *bus, Range *range);
>>>>     void pci_device_deassert_intx(PCIDevice *dev);
>>>>   +typedef struct PCIAddressSpace {
>>>> +    AddressSpace *as;
>>>
>>> ... but here I fail to understand what is PCI specific in this
>>> structure. You are just trying to an AS with a IOMMU MR, right?
>>>
>> Right. The patch is trying to better split the changes to use one function to
>> return everything (via pci_device_iommu_info) with the PCIAddressSpace
>> intermediate structure as retval, such that patch 3 just adds a
>> IOMMUMemoryRegion* in the latter for usage with the
>> pci_device_iommu_memory_region().
>>
>> I've named the structure with a 'PCI' prefix, because it seemed to me that it is
>> the only case (AIUI) that cares about whether a PCI has a different address
>> space that the memory map.
> 
> 
> yea keep that pls. It should be possible to figure out the header
> from the name.
> 

OK.

I am about to respin v4 series. It mainly reworks the first four patch enterily.
Essentially I'm following Peter's suggestion of picking Yi's old patches[0][1]
and avoid the direct manipulation of an IOMMU MR. The structure is very similar,
but the difference is avoid the direct manipulation of an IOMMU MR[2]. The end
goal in hw/pci is similar, fetching the backing IOMMU attribute from a PCI device.

[0] https://lore.kernel.org/all/20210302203827.437645-5-yi.l.liu@intel.com/
[1] https://lore.kernel.org/all/20210302203827.437645-6-yi.l.liu@intel.com/
[2] https://lore.kernel.org/qemu-devel/ZH9Kr6mrKNqUgcYs@x1n/

>>>> +} PCIAddressSpace;
>>>> +
>>>>   typedef AddressSpace *(*PCIIOMMUFunc)(PCIBus *, void *, int);
>>>> +static inline PCIAddressSpace as_to_pci_as(AddressSpace *as)
>>>> +{
>>>> +    PCIAddressSpace ret = { .as = as };
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +static inline AddressSpace *pci_as_to_as(PCIAddressSpace pci_as)
>>>> +{
>>>> +    return pci_as.as;
>>>> +}
>>>> +
>>>> +PCIAddressSpace pci_device_iommu_info(PCIDevice *dev);
>>>> +static inline AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
>>>> +{
>>>> +    return pci_as_to_as(pci_device_iommu_info(dev));
>>>> +}
>>>>   -AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
>>>>   void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque);
>>>>     pcibus_t pci_bar_address(PCIDevice *d,
>>>
> 

