Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDF67BB36B
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 10:43:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qogPw-0006w8-Rq; Fri, 06 Oct 2023 04:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qogPu-0006ub-5C
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:42:38 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qogPr-0003ND-UB
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:42:37 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3967rqGa021875; Fri, 6 Oct 2023 08:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=532bnAmoaDB4YomyZUjuQzj6CXtMOklwqV9v6v4rA+U=;
 b=ZrB//QbZI/gYJyyLx7+wsT1TslaKbSjJCf+L3ljyayX4/BBVPK7SUCbq+f9NiAHIEFot
 0rXTrukUkHbetnGHTY55DQrxaZ6o6XjR7ctAfwZzSUw3iE8zx2WhyOkWC139HDgYWuJA
 ZGJHnEpHO/GFWi5xIPPYmdw1i4Bx9rzEhMwZhBQlDTw+UJmJ3znfUrJK7A7oaY74vECp
 7WDPaNFeQG1MOpEVejhAjzT9PXpfzqI1nehEmuAX3fuRKMxa6BsgQiiU9LxffsnmkJOr
 S7p/ILQgnOtEI3YixL+wnN+KHblRhY1x3AtCxytliw2CAg/lLly1K3E9d4WwwzO3SjDT Kg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tebjc38xu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Oct 2023 08:42:26 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3966piLx002971; Fri, 6 Oct 2023 08:42:24 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3tea4a9xad-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Oct 2023 08:42:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDHgHDpvQrjTYGVmmbIREPz5LhB2WPu7zjSP2REqLryE7sa0pNlvclNEE/0hw7/S0libRaQWZiPaxRWMHBk+MH4E6X3stJ+gkBwhZXyUteZiEe8SAICqPgPISed5DoHY3dutkvJXonoZVjlBdWh0lehS3f7jgwLyONnAPJty6/Zq163HO4FoBoUNHhQrA0mkIQbSzD0RQrUOBIdJEAnIYC2ap6xf6+WN3fMAW4ubZlEGw0BybIYqKhkefylyoaobb3ah9JSHV+Gv58QyjBjV0QL6NGt2fppnzYCKAtRyjk6XXVZQ1oG9XOc5+qVAv5SvmViLqDIvWnOVh6MDFfMQJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=532bnAmoaDB4YomyZUjuQzj6CXtMOklwqV9v6v4rA+U=;
 b=QoZfiSMcRZIn+UWGQSX8Bb4g3lI2P0JC0IVryAGkyDPxcY/fwOXIFR6Il+nV03DEGRA8m9qJN6IXmVVjRAmgsEa1Rt2+AnK5fuuK/Hx1DtmDnE65VvXT745zvzB95pTntvtl/OXb9fL0VQOZjkbRUW8Hc8irzSYil46WKDwYOOxUCqXggvgb6fhct9oPCQclvrHF3frzVMgus1lqNxqa6RJfYN8FXra/oN07/ebkBjKp0XSCh3LuxApX2Y79nDRELyJOgKbS7M/c1/JWfiyktWOWsR+3P8Es11VGfXkXqYmxvCXh2O65c3d03t5bY+lNhRkfsr1VB6VpBjlJxGSWlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=532bnAmoaDB4YomyZUjuQzj6CXtMOklwqV9v6v4rA+U=;
 b=NHzNoi5nCmRebMsm4oRP5uU+uWgtCIWxFQ+VJIdsypT3O83tSPrTK5aRMXyk41P+8fY/gwwsXavJ6ZOJZpFVXhOr1qOXhaFz2ONWPcEoVcnpGop8Psca+LqPzvno8DLZwPdqE1NyAB6vsciFxDBpUWboo8ga+DiD/BOeqfblJ6M=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by DM6PR10MB4378.namprd10.prod.outlook.com (2603:10b6:5:211::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Fri, 6 Oct
 2023 08:42:21 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::64b1:cd15:65a5:8e7d]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::64b1:cd15:65a5:8e7d%5]) with mapi id 15.20.6838.039; Fri, 6 Oct 2023
 08:42:21 +0000
Message-ID: <cc6cdb86-13d1-41a4-8936-1d9432f06e7b@oracle.com>
Date: Fri, 6 Oct 2023 09:42:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/15] intel-iommu: Implement get_attr() method
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Avihai Horon <avihaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
 <20230622214845.3980-7-joao.m.martins@oracle.com>
 <2f279132-7d76-835e-c662-baa0c7f8de58@redhat.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <2f279132-7d76-835e-c662-baa0c7f8de58@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::17) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|DM6PR10MB4378:EE_
X-MS-Office365-Filtering-Correlation-Id: 19bd2156-375a-4f38-3e33-08dbc64827fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VUsOthJ5ymo+Q605ipfp9J9/NgcH5jSvcZXEfQXMi+MUPTH7IuJqFdeiN9T+6er+SyHc5k2eFW/zaRX0i4t1lOhJ7ZBfOMhAmrvPkuQqG7m0ZxXynB7f1176z/5ZhTL6tOHJLaX8f6sjuqKI+tm2UnfxXM4g4RtI0KKYQ58w4aHKLp439LryDufSea20SeENj7CfzSLXLOvgm4UVqudkLE+FIy/PdYkfz5bzigapaesWClU4+wm+b6y6JiXmXC0GIO4dEE360prdu6ezTTx+PavPiXcWhDEi9VLUcEAdnKsxViFLc2zwCIDTr6rOLXW0IpuEeEsLyYuHUK7wEq6noeiusXtvRKy7KMXDrLJ1cSgHZ7a+UgKHa3NAXBrLNtZRe88zQ3hkMcioiijHLSipcBcqLgkgcA6leldVJfvZKUuewJFKxMi0TjDnXu84rEXoAbQnVfZ2p8E5KjGRNeShV51SbEYK+boZKAqLDgFbgC6XSYzO6gYC1F1H4vaOWdqt5h0QFn7EDIf8Jy4K5KBSp3He40GczB55QRwPM/tBMY9k71RYnGY0m7lfSMuPjda1otlCOgZ/G7RYuRr+WMg10S/S8VGeWxi0t4jAYMs1C7LwNGz31fQ+cvr4lkBGHNrPj1PcEmIpS74Tm9fqNdUk3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(53546011)(2906002)(7416002)(86362001)(31696002)(38100700002)(36756003)(316002)(6512007)(41300700001)(66946007)(66476007)(66556008)(54906003)(6506007)(2616005)(6486002)(31686004)(6666004)(8676002)(8936002)(26005)(5660300002)(478600001)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NitIMXovbXpJanh5OS8zTGx0QndNWkdBWUdUN3NNQ05DV3E2Y2p3VVh3akxP?=
 =?utf-8?B?ZjhtM3FXZjZyVVRKSlpWL24rSjREUkIzRmI5RXRrNG1BT0duNGxMTVk4Vjhu?=
 =?utf-8?B?WW50VDRYUXFIdE9BUW80R3NyaFZsT0RmNGpXUXpwb0I5UWxNOXJSTTExY3Q1?=
 =?utf-8?B?NnJFbFRwY0xOeHNFa1hpK2xpcHliMmtRZjJHamxoRWc4MU9IWW1JQ3ZST2Zn?=
 =?utf-8?B?bVMvR0hncTJndHl6R2hhZkhxSmN5dXNDT2FsbW9aKzAyQmNtK0lNbEJ4M1Zs?=
 =?utf-8?B?cTJTZnB0ZmRsUU0yMlVBUTFBMXA2M1FBU1FoMUxxeTRpR3ZJc2pXamN1VXhq?=
 =?utf-8?B?ZDMxbDhGaGZGWW96OTljczN2NXo5QUlScngxZFZxNDdoMHArUDhTNnNLWlJs?=
 =?utf-8?B?RGtjTjdJN2lJR3FSK1ZUeU1ySnl4K0ZRVHR3UTZTdjMzWDVobFo5TWUwYTZV?=
 =?utf-8?B?QnF3UFMxSG1mN2Y0SjdvWVp5NUxib1lqbmxSYjJ6NG0yUFZ2T1hkUnl3U2pZ?=
 =?utf-8?B?YnhWRmw1aDJoM2NPTVU5bTNBcGlwb0VUTS9zS2VzV3Z3bUluVmt4azFpUU1T?=
 =?utf-8?B?c00wcEVZR1padExXdnZLSHZzN0NubldoMkkwT3JBVU81OUFNSHQ2Yk9OaUFK?=
 =?utf-8?B?TnF4azNVeTJzemVTU1lObUwweXY3YVN0OVRQSmdKclhUeUdKOWxzQWtlUVVN?=
 =?utf-8?B?U2Y1N21PaHlpODVjVFRZaGhxRDJselJISzJvMDJKWEdLTEpYOTVVZHFxVFF1?=
 =?utf-8?B?em42TWREVGlGRkJaT0JSdmcwV0RSSnpIZVljMGhnTHo5ZW5KWWR5czdMeTMv?=
 =?utf-8?B?Q1laNTRuT1Zjc2dIcVJuci9tWDEvd2dNeDNBKzZUQVJBcWxPMU5RZDR2OERS?=
 =?utf-8?B?UWFNTGFjdjBzN3FCMkFsbnRoZ0toM0I1dTR1NHBtUFIvemJIZmEwbEFYU3R0?=
 =?utf-8?B?NEZpdDRHelRvZzVUTVhIcE1tMFZWaXcwZ3VCd2RmSFROQmdaMjJDb01sZmxs?=
 =?utf-8?B?Q3Zadko4V0VrcUZJRDRGTzhwL3E3dXkvdTFsSFRNVStlcHA3eUNZQzhBRGhy?=
 =?utf-8?B?cjBpcWdLL25tNlVkalhsUnJQajNVa1B0WkRvY3VwTHpTcDU2cjd6aGRoNHlL?=
 =?utf-8?B?OGRGWUhmRzFGdVlUdDZUTHR6akF6THpwbTVZYTVhTFJWY1F5NzF5QUVFclBQ?=
 =?utf-8?B?MiswdlVUdzV3VXQ2azUyRVNGYXh6TGtQWGJPVEJkRHJ0RDVzR2IxdUtYZ2Rx?=
 =?utf-8?B?V0h2ejV3OTZwZUxxVGlVem92OGM1UWJIaG1RTmRPdlVTMTArMmNaaGcydDF3?=
 =?utf-8?B?NnVYM2NJcVUvY2ZCYmRNRjlKaEw4MGE2alRZMTRlTTVCaHNrU2orTGR5TExl?=
 =?utf-8?B?SUxjM3BBZTJRcWNEMExTa1dJNENVVWFiZXF3TEpCSkVMMWZZR25Dd3UzckQz?=
 =?utf-8?B?NHhiWHZMYjUrQks5YVN2aUNxd1BIK0ZvdU41bU42am4xZTRGYktZQzZMWE5o?=
 =?utf-8?B?TXR2d2liMzI1MWROaHZiaXRHZU0vakhGWUxZV2NpM3ZKTUpocThVbHh4RDlC?=
 =?utf-8?B?SzZPWHFEQitDSG5VUjZidFRVN3lZTXQ0TWtrbWwvYmlteWJxOEU5WTNObmM5?=
 =?utf-8?B?MW02REFaZnFPTlhtdVE3SlBsSnJMSHpzOFB4MUI1MjVDeFRmTFdqdlNtZW1O?=
 =?utf-8?B?MWpvNFhacEFhWjFIb0NMRktDcXNVSEFFM1ZEZ3kxMFlBaVRLSzg1TDNuWEZK?=
 =?utf-8?B?bS9GUDRERWxubTA0OGZMNGU5MW9mSmN4NjBtbllMZUVHK0ZtZzRrVnZqYXVv?=
 =?utf-8?B?eHhNQzdFckVrZktOcnpXWHVGdUtQUG1uSTNjRkRscXM5MERmWENoclVoUE1N?=
 =?utf-8?B?eGlBb1UvL2FobjMwRDN2c2hvUlhmUlI2UXd4eDNYWVhNdmFMd21aTjVkdStP?=
 =?utf-8?B?blV3c1NSdis5SmpPRmY4WWMxUG5mcnlCNFRRMFk5d0xvRHd4emgybDBzN0Ex?=
 =?utf-8?B?bmFBMzAvR3dRUjdKV0dxeFlSRnpXMGV1N3ArSTFNbkMrT0szNFBlV1FhSVpQ?=
 =?utf-8?B?YXJYcUQrdjQxM2FBNlpOSml5eHBJTzRUdE5pR2RlUExISnNsV1M5S1J1SnRZ?=
 =?utf-8?B?UFBsbThHR3N3dHorUVIxMC83NnlHNDAxaXU4OXN6b0NiVlBxV0p0Z1QrQ0NF?=
 =?utf-8?B?VVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +ro1bWFruUcqJTlMqEzuVRB+fhy6QrdyT+qkLezR8bW0JRrZYiP7tJv67nthPhEP0xaajOr0+hStQxj+/+taDr1vyo8g+5nxaa7R0b3M3aRI8kLfhhy0o2VNM+R+/PczDjra68S0CnHKJfVoWV+Ame5otuOLiWFdyWfQz7g78Bo55zsjipZOL/DEJ4v1zW1fx5J0B9KtK+HakkqaTx8HrZsnpXPvbW4hPdMqCM0ijWUE68ECCSSr9lzNmHjA3eEiYb1hOXW4cDEMFXg4gDzSfcOspJdITFQRjFi4mxXlJj9vq5nsllpSbNbJikkrSIHwEQcRMWOgzPuMmBxBsyzEJR6ZDn2fdy6iZKR2BxCWFpr8hXF2KDXafMx48varisGrTTFrmbh7Ip5/p5wY4hK9UxEoAatbcG41cMWHbAEHyzWVWawUyNkyHHbe+1nsvEN7H8Qdx2VVl+48mJ3CB9zl6azu9Sj4frGqQDQB5azrEFo3PqRnF31HMRaYs1Bni81OIjZwUTrm7gvZcaf3gLEHkmOnh8ZzrxeP50ntEm6UQwwSrHgjA+bNwZy/9XEvW2iJPZBnuxo1I30oy8JIHk56PxCQg+o5cLrgRlI3nHxNZlYNFKbSDHBCO1nLG/oq2Ye26gCn7PVTXak8GDtbSxGZSWpJiWV28Dz/3f04RsAHebqWw8QzdviarZ1Sc5RGNhRomOqa3QQxAUgGAvqJjRqwC8aXaIYMvwFd3mAZkIs8vrjDSWfn6TjU125EHV2U9KVEqjjfsun1V+sxJLmRbt1LqNcbk6e7CmSe1khfd/FdaJiXeB2yzTsiBezDIGPrnjahoUIjFu8aoayjeuG8Vigu6WoUxInZcrOjnNxjLznVeK+8TKaJ7SSdJJ+M92yKN+ZeVuRaqPklWynBJzy6o3pRjA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19bd2156-375a-4f38-3e33-08dbc64827fd
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 08:42:21.6054 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mcVyolK8bmHbhxEUlCJ/I6cDEVI3dFd0a05FgKTBg5FfQcBMrzeQQLvW75Q+fr0zkhzuT/f33u+vsciUiHrjmAlGJ8KBEEESCnpvAO3s1y4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4378
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_06,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310060061
X-Proofpoint-GUID: d2_qMCNri5HN3Bve3rCAZIraqTwNLceG
X-Proofpoint-ORIG-GUID: d2_qMCNri5HN3Bve3rCAZIraqTwNLceG
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 02/10/2023 16:23, Cédric Le Goater wrote:
> On 6/22/23 23:48, Joao Martins wrote:
>> Implement IOMMU MR get_attr() method and use the dma_translation
>> property to report the IOMMU_ATTR_DMA_TRANSLATION attribute.
>> Additionally add the necessary get_iommu_attr into the PCIIOMMUOps to
>> support pci_device_iommu_get_attr().
>>
>> The callback in there acts as a IOMMU-specific address space walker
>> which will call get_attr in the IOMMUMemoryRegion backing the device to
>> fetch the desired attribute.
> 
> This looks like two patches to me and the previous should be merged with
> the one introducing vtd_iommu_get_attr().
> 

The reason was that one is a bit useless without the other. But I can spread
into two patches. And I can merge the previous to the one introducing
vtd_iommu_get_attr()

> Thanks,
> 
> C.
> 
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>   hw/i386/intel_iommu.c | 40 ++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 40 insertions(+)
>>
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index 1606d1b952d0..ed2a46e008df 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -3861,6 +3861,29 @@ static void vtd_iommu_replay(IOMMUMemoryRegion
>> *iommu_mr, IOMMUNotifier *n)
>>       return;
>>   }
>>   +static int vtd_iommu_get_attr(IOMMUMemoryRegion *iommu_mr,
>> +                              enum IOMMUMemoryRegionAttr attr, void *data)
>> +{
>> +    VTDAddressSpace *vtd_as = container_of(iommu_mr, VTDAddressSpace, iommu);
>> +    IntelIOMMUState *s = vtd_as->iommu_state;
>> +    int ret = 0;
>> +
>> +    switch (attr) {
>> +    case IOMMU_ATTR_DMA_TRANSLATION:
>> +    {
>> +        bool *enabled = (bool *)(uintptr_t) data;
>> +
>> +        *enabled = s->dma_translation;
>> +        break;
>> +    }
>> +    default:
>> +        ret = -EINVAL;
>> +        break;
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>>   /* Do the initialization. It will also be called when reset, so pay
>>    * attention when adding new initialization stuff.
>>    */
>> @@ -4032,8 +4055,24 @@ static AddressSpace *vtd_host_dma_iommu(PCIBus *bus,
>> void *opaque, int devfn)
>>       return &vtd_as->as;
>>   }
>>   +static int vtd_get_iommu_attr(PCIBus *bus, void *opaque, int32_t devfn,
>> +                              enum IOMMUMemoryRegionAttr attr, void *data)
>> +{
>> +    IntelIOMMUState *s = opaque;
>> +    VTDAddressSpace *vtd_as;
>> +
>> +    assert(0 <= devfn && devfn < PCI_DEVFN_MAX);
>> +
>> +    vtd_as = vtd_find_add_as(s, bus, devfn, PCI_NO_PASID);
>> +    if (!vtd_as)
>> +    return -EINVAL;
>> +
>> +    return memory_region_iommu_get_attr(&vtd_as->iommu, attr, data);
>> +}
>> +
>>   static PCIIOMMUOps vtd_iommu_ops = {
>>       .get_address_space = vtd_host_dma_iommu,
>> +    .get_iommu_attr = vtd_get_iommu_attr,
>>   };
>>     static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>> @@ -4197,6 +4236,7 @@ static void
>> vtd_iommu_memory_region_class_init(ObjectClass *klass,
>>       imrc->translate = vtd_iommu_translate;
>>       imrc->notify_flag_changed = vtd_iommu_notify_flag_changed;
>>       imrc->replay = vtd_iommu_replay;
>> +    imrc->get_attr = vtd_iommu_get_attr;
>>   }
>>     static const TypeInfo vtd_iommu_memory_region_info = {
> 

