Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C70DF82AFF7
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 14:51:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNvRN-0003Hv-R5; Thu, 11 Jan 2024 08:49:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rNvRD-0003HW-Rz
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 08:49:40 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rNvRA-0001mJ-5N
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 08:49:39 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40B8HYOL009798; Thu, 11 Jan 2024 13:49:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=HRrvw6YgqtfOh7RQH8uRkwSsb40vwKoTEFl1l5/CJVo=;
 b=mC0BT2tLOZqy1b55ad82BTkqMTnYYyw+33lran4bsUG3mG/FdvkXwaKYC+46Mukv5+xV
 9XdTF6/TZCDbWEapgQ8qMV0I6sLOnBctF7Ipx+yBIGp4S+sDU5ALp7Kl2ZMllqR8JWZF
 EFprm5VqTJklGtR1vfgjHXLm2kVsu9Ars8vOggLIq87I8/MdMILD381j8r4efr+P287w
 gzZ1LBk1SdZnh9VPA6vKN0hiaxdv5kmbNvrjzQI1q2EO2BtUp/ZIg3uK2y6jIvv67C8v
 HNU3QW84hGjBT8Y+SeSzxc91eTOzOSBaOE86WFWGPTzW0n0UwG8Exz0lxzxaNDcboxlH YQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vjcnv0knm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Jan 2024 13:49:27 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40BCjFlG008836; Thu, 11 Jan 2024 13:49:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3vfuun4p4t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Jan 2024 13:49:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juepCjPrBWhXM3/r4BexRcMPRXuQM3Um6Rcs5Dud+sK3FB00lKLdJ/xlCc8FuALR6bGRmwNKJtakCcy+tpfj7+Zjt/giQZbfdWW7V+w5G9WzKY4FSKRHp9Mh+YXeU0pzSYJoOGFPaQS0HHB/aYTnO9j5IOFLFh7dkFfu0OXcZlf8eyGgH7IFV8jPegLS0sgaMs05Y63EQoWUIwSYN5957hDS2Wm5mgAonT18nUkBbAA4crR25+eqxe+bBLb/HPftPBHSuBYB9H2TTcF1eysaRgcW9yJV8R0xVTuzOMRexCWDjjAlZtE9++ZTvIcekR7pLSypoRxQ+z1Qjo5Z33vJcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRrvw6YgqtfOh7RQH8uRkwSsb40vwKoTEFl1l5/CJVo=;
 b=iW9Rn03RiEEKA1SvvX6ftGfoj09YeAvatKO99WZyX0u0phnIJgfbGLe5dlUBgStDUlh+asYfkSOf6rRDhx2K+n6Vn3N+zOKN0bOhT3Z9ZqCa8R2c+X42rtVMoA+6onzM6WOZbHHR/ARIkfrXYm9nNWKGe8QTID25ahbc1Dy71XvD7+0y4pJAoJkd6r45L4yczi8N/Q+UCVrvrjIq4HtyoImJ7LMShp2mvZkSQJoFqRSG32G7KZZkf5HzmXGyjuZYF4ksqUCBprmInEiVaOFscmeAp/JTRFDajkqcBkJxHWoSQsf6s5ZDvwAHWv7VjRAf9pwVfnaEI7MMC3UtMP0DTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRrvw6YgqtfOh7RQH8uRkwSsb40vwKoTEFl1l5/CJVo=;
 b=uxT+WIORXwp3aHMmskmBHTTieAEhrYQq46eFHVehyHCdB6YW7NQdlzQMhmpu4cg5qcGFyDU6rMHyHN/sVxi2NFTaUYOrdu6NvHHitvSn1Xuiq8CAMrGq4xmLjhd9zKxnG+pt1uRVZ4QFEIfIzO50PXbio3hSXUIMv+GiuKk6f/I=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by CH3PR10MB7988.namprd10.prod.outlook.com (2603:10b6:610:1c2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Thu, 11 Jan
 2024 13:49:23 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7181.018; Thu, 11 Jan 2024
 13:49:23 +0000
Message-ID: <6e1b4b3e-60ff-48bc-8d7b-9f33d0e3805f@oracle.com>
Date: Thu, 11 Jan 2024 08:49:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 2/3] migration: notifier error reporting
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>
References: <1702491093-383782-1-git-send-email-steven.sistare@oracle.com>
 <1702491093-383782-3-git-send-email-steven.sistare@oracle.com>
 <ZZ5E2ubl9XRdXDmh@x1n> <94e1241e-e355-4e96-b86a-e0218a7589c6@oracle.com>
 <ZZ9PgyDQ8QRG4Rqw@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZZ9PgyDQ8QRG4Rqw@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:a03:74::17) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|CH3PR10MB7988:EE_
X-MS-Office365-Filtering-Correlation-Id: dfd713e7-ab0b-4122-a08e-08dc12ac1e62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ukWjxygmBNQowrFCitEJS9mbk1j9FzE73NbajFFw2KfdqBqipEksDKOqBEsT4Z10UmL7iZa2U+Z8ZP/MYRMgMCh+96DfHLR46quCgPKo6CAb69Oki66mYQXZG55nqtwpiVbuk7BQvjleXkEC2ggBX6KME2UdqiXVqnatYk8yGJjvDfaummlo08n9cE7xrrgTSFA1zZ0zzFT2KD2GkgN9aDy4CIDcj9WeVKTdsILd+gbzcKfEf3cbHw4wiIDWYm5CSENVOGbu9jCGtyN2Sa/I22Uvb1A18nLinJBCTqqA2iWmhFNCq67KhSEQL1E/DUn9r+IaR9qZT12vTLTmqCoLBZDL9aDRohyACKm6cDJQZx0uycwXOMMsMiK3oXYLi8chNpDqHUMevccx5TXxu3ovuC4NrDpXtNXk+/LVEry5ND0bERYmjqcFVJKtVwl6Lrl4svMcg0Pw08FhFMorBehgO32dkIF/gTKHZHx3Hech56AyempNxVZ6gIr3Z3+jfQdCNHjRYuOToEwXLFSvDp+ovl6l3qfIvyFHZOtBDUk+ET5lPC4msPiAMCe6McXcoMkng4yuYK60/ScPC4gCPo1SU/c8WiKlB90CXzByqQwxeGqKlSEt6g9CS3LR1AQ+ti5Sl7jqZ9/yzNsLWRUIccLg+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(376002)(39860400002)(366004)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(66899024)(83380400001)(36756003)(31696002)(86362001)(41300700001)(38100700002)(6486002)(2616005)(7416002)(26005)(4326008)(6512007)(6666004)(66556008)(66476007)(478600001)(2906002)(316002)(66946007)(36916002)(8936002)(6506007)(54906003)(6916009)(53546011)(44832011)(8676002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZklpaXEvanBHTVZLS1Y3TVlQZS9BN0p5QTZaVzNodDd5ZzhMaVNCeSs3aXFJ?=
 =?utf-8?B?QkUrLzFrakN6SnNnQ3JyVDNLRjVQTWgrbk5sNUVzS1l1SWtqTkcyOEdLMWp4?=
 =?utf-8?B?azJKTHFod1BvOURLNVJjcUxhUXovd3lYYlFCTzk5c05Td1hrZWhRRmpXREts?=
 =?utf-8?B?eHorU3dkZmJkd2YxOUdMQUFNaVJ6U0M4aWdHdnVEOXVuY1YvdjBhZWNKcGhk?=
 =?utf-8?B?VVd2dUNidVJnZzUrVHpXZEhKT014cnRMbmN2VVpJenpuTEZtZmlWYjFMTXlo?=
 =?utf-8?B?aEsvVjNURFlFcmR0Y05tVW1VMVBnT1JWODNoREFwQ1A2WXkwd2NhSy9mMzh3?=
 =?utf-8?B?bzBhNkczTFdTT21kOXhqL05PaDVMRFpENE1MVXJpRlI5WGZ6eVJzTXlwcXZJ?=
 =?utf-8?B?M3Bza0UvSzBQV0hFZ1dLc3ZKMnZlU0JFZXJuOHQwSHhlLyttMjdnamJLdWx3?=
 =?utf-8?B?MGhPclRTUkMrS204QVF1cU8vUnc2SHFjYWl5UFVPUCtEejJaNFpwU01tUis5?=
 =?utf-8?B?UkJTcU95LzY4NmhSTGh3QXRjbU8zOXZScUZoUTlFdmg0S25CT1ZhNkRCMXNS?=
 =?utf-8?B?c01jb0JQc25TTWJkcnZWMERCMlEwdnM1blBFK05WS0Q5K1pRaXZsSFdvVjVV?=
 =?utf-8?B?SXNROVdGTzl6VGxza2pWQ2x3MkV6SzBzWjhrWnlwT2IxTEtWMEM4dUJNRWZF?=
 =?utf-8?B?ZFZmZXZuT3hiVHBKSGRNZ2o3Vk5kRk1OZHRJMjJqVmt3UnpuVXpEYXVaM1FD?=
 =?utf-8?B?NmVVMzI0VC9ZZUMzYnhwWUlFS3FpSmhTTll0YUlCVDl1K2NBQ3U0ZU5JeVFi?=
 =?utf-8?B?RHk3UFhoUllIdUJqMmc5MTBRRGt0U0dqaEl3NXVlbEErczJka0N3OElvazl6?=
 =?utf-8?B?OUNjMGNsV0NWL1FHdjkwNVg2U0o1UENpQ1NzZ1J1QjFFZ0QzZ2FIUlBtaWho?=
 =?utf-8?B?L21CRkQxcVZNOEtxdzZWV3YwNXRQVncydERwUnVJd3RsSkhOYjRFZWhMNU9M?=
 =?utf-8?B?S2xuRUIwR2RIK1FZNGVXZDZwdHdsQ2w2L2owQ1pBYUwxSUl1NXhFWlVEdzVv?=
 =?utf-8?B?Um5uSnNnaWw4R1lPbHprT3hEOHBOZXN2S29xOVVsaGVtWG1lc1VwZnlVQkpt?=
 =?utf-8?B?Nkl1UkYzcmx1di9yY3NQeHF1c0ltc2xaVi9VcXJ4NVdKZXI3bjdJZXRJdGpj?=
 =?utf-8?B?WUJ2RStQeEJ3ckhTRnBic2RDQXpLNnFwZ1hIaDVaT0IwVGRVZ2VvNDhIQ0NX?=
 =?utf-8?B?eFlRQkE3UjNKa2VUZll4NFBoRG8ybUdMQUxFb1pweWtEcVExRzhNbXlOdkN0?=
 =?utf-8?B?VWo4M29sRjFFZWZxVXZnTjRjeVVvZXNMTy9QY0xZK0taTURHbjlRMWRYVHpn?=
 =?utf-8?B?cjk5UWR0T2tGNW9MajcxNk1TbEFxNFMxdklSeGsxZEJLWjhXdHdPUXZ6c1JL?=
 =?utf-8?B?K2xVOTVHdnVFcytQVW1mREFPdC9MaDJCa0p2WTNaZGRqM292UXhFM1ZGbmxx?=
 =?utf-8?B?dTVMa2Z2SDN1amh1c2ltRmMxTGJvN0JUZVNLSG10K013dFNaNWM2cTZ0NUZS?=
 =?utf-8?B?UStDMncyNkNHV1gzc2VWQURCMFNmOGQwV01OMm56cWpadHBOdGNoeml5RFp2?=
 =?utf-8?B?aXQySFdHZXcwSHdhYmVVcCs1SzA5ZkZpQ295NnQydW1vemFTS2RtdWwvWjNo?=
 =?utf-8?B?OXA5MHJGaHg2YlZQVXp5dmliZTI2ZFdKV2gvSENVdGxXaVM2VHg4eVZMUGFy?=
 =?utf-8?B?NGE0bUZ2N1lSWnBacnlEandVRndSUEJHZjEwcG01b0F1L3ZCR1pWNitMaUJy?=
 =?utf-8?B?VDZPR0JxL1JlcDY2S09ueHN5RDc2T0ZWOFE2U0VBZWttZit0bHBzdEhFVUlR?=
 =?utf-8?B?NzlWbWJSMXhrSlBqMWZDRW9lRFQ3eXJwSTJRVVBqUHBSK1UvZnZpUDk1My9K?=
 =?utf-8?B?MXhSdE8yRXpON0MzcEplRGlGVmVvcXJBbS9jdUIvdkpYdGg0dm53TjBLekk5?=
 =?utf-8?B?c1hGbndWalUzQTIwMzRjdlBYMEI0RytSYmVvWU1QRERockxBUWVCRkpwUW5q?=
 =?utf-8?B?WDkzS1JYV1RJdktNdEliR1NjUmNPbldmUm1saTdyemZyRTFjTFBkOFN0NWpx?=
 =?utf-8?B?c3ZnR2pmWHFRT0hNWks5UVFSYkhHKzRaQnNoZFpBb2Ewdk9BR2luN3YxcEd5?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dWzWHf/5DXtL4kWvOCII1+vIrxL/HWisWoeSkgT+rMGBDXI/OGkO5QeMw7avcovt3ZVlzsGVIWmJKY+Q2PEuaAG2fkX4XLXNqKP/j4IPf955Op21DZIXZwezwiZM1uKndd+N8Q9gI5V6dlSoynQPY1pnSXkglpQzzaTgFAPfVHgQxxyq0w9vs5qQjS93ByUH98WaTIxDi82qIgfoQw+TBuW+2hPqYIvFHGWtq0PQd5E2K/P81yk6vs7d3pIZFO/N7lJeetFdIl+lTqVAiS97JenH4kJ3EneRXGXgOjdg2vKD72PjwDpzYoSzq3UwYSBdw545vWoUTXlcimrsTM6diklzyfNoQknrBmX7TUA6sMPVllZV9HHrZWpxIbskcf8d3S3TcugQRquo8ALGRV1+OrZ0zwhhooTO7NW/lE5NsZoa4eKQYQUlybPzf6zFRoiGV0WcwNvX9E9PCdteu0lN956mwsFl0I1eyNbeWt4KlO2a7dTIcqW+hq1bT/0aJCw72Y9ks5XeCH8dnz3qRJg9vD5VdMEXffD2kNGV3Epfj2574bzB8hpNwlPEwuOfYUDEQyilavBu4gZY/k958d0sITm4wbSjgUbXXcqCHKNMCw4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd713e7-ab0b-4122-a08e-08dc12ac1e62
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 13:49:23.4628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OA0pA9kOrLEun9OlyTTL3jISqAG+zO+d8pJBI7t59Bmhmm1LwbnXYvz+1I1Vex/Q+2HlsyZ6RBk0ufAAGt8GJyjP9swfXEfiYNf0YfYZ9Jk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7988
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_07,2024-01-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0 mlxscore=0
 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401110109
X-Proofpoint-GUID: tH4GAqQ6BFZwJw0SDrGospaQH6SLw6Lp
X-Proofpoint-ORIG-GUID: tH4GAqQ6BFZwJw0SDrGospaQH6SLw6Lp
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 1/10/2024 9:16 PM, Peter Xu wrote:
> On Wed, Jan 10, 2024 at 01:08:41PM -0500, Steven Sistare wrote:
>> On 1/10/2024 2:18 AM, Peter Xu wrote:
>>> On Wed, Dec 13, 2023 at 10:11:32AM -0800, Steve Sistare wrote:
>>>> After calling notifiers, check if an error has been reported via
>>>> migrate_set_error, and halt the migration.
>>>>
>>>> None of the notifiers call migrate_set_error at this time, so no
>>>> functional change.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>>  include/migration/misc.h |  2 +-
>>>>  migration/migration.c    | 26 ++++++++++++++++++++++----
>>>>  2 files changed, 23 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>>>> index 901d117..231d7e4 100644
>>>> --- a/include/migration/misc.h
>>>> +++ b/include/migration/misc.h
>>>> @@ -65,7 +65,7 @@ MigMode migrate_mode_of(MigrationState *);
>>>>  void migration_add_notifier(Notifier *notify,
>>>>                              void (*func)(Notifier *notifier, void *data));
>>>>  void migration_remove_notifier(Notifier *notify);
>>>> -void migration_call_notifiers(MigrationState *s);
>>>> +int migration_call_notifiers(MigrationState *s);
>>>>  bool migration_in_setup(MigrationState *);
>>>>  bool migration_has_finished(MigrationState *);
>>>>  bool migration_has_failed(MigrationState *);
>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>> index d5bfe70..29a9a92 100644
>>>> --- a/migration/migration.c
>>>> +++ b/migration/migration.c
>>>> @@ -1280,6 +1280,8 @@ void migrate_set_state(int *state, int old_state, int new_state)
>>>>  
>>>>  static void migrate_fd_cleanup(MigrationState *s)
>>>>  {
>>>> +    bool already_failed;
>>>> +
>>>>      qemu_bh_delete(s->cleanup_bh);
>>>>      s->cleanup_bh = NULL;
>>>>  
>>>> @@ -1327,11 +1329,20 @@ static void migrate_fd_cleanup(MigrationState *s)
>>>>                            MIGRATION_STATUS_CANCELLED);
>>>>      }
>>>>  
>>>> +    already_failed = migration_has_failed(s);
>>>> +    if (migration_call_notifiers(s)) {
>>>> +        if (!already_failed) {
>>>> +            migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
>>>> +            /* Notify again to recover from this late failure. */
>>>> +            migration_call_notifiers(s);
>>>> +        }
>>>> +    }
>>>> +
>>>>      if (s->error) {
>>>>          /* It is used on info migrate.  We can't free it */
>>>>          error_report_err(error_copy(s->error));
>>>>      }
>>>> -    migration_call_notifiers(s);
>>>> +
>>>>      block_cleanup_parameters();
>>>>      yank_unregister_instance(MIGRATION_YANK_INSTANCE);
>>>>  }
>>>> @@ -1450,9 +1461,10 @@ void migration_remove_notifier(Notifier *notify)
>>>>      }
>>>>  }
>>>>  
>>>> -void migration_call_notifiers(MigrationState *s)
>>>> +int migration_call_notifiers(MigrationState *s)
>>>>  {
>>>>      notifier_list_notify(&migration_state_notifiers, s);
>>>> +    return (s->error != NULL);
>>>
>>> Exporting more migration_*() functions is pretty ugly to me..
>>
>> I assume you mean migrate_set_error(), which is currently only called from
>> migration/*.c code.
>>
>> Instead, we could define a new function migrate_set_notifier_error(), defined
>> in the new file migration/notifier.h, so we clearly limit the migration 
>> functions which can be called from notifiers.  (Its implementation just calls
>> migrate_set_error)
> 
> Fundementally this allows another .c to change one more field of
> MigrationState (which is ->error) and I still want to avoid it.
> 
> I just replied in the other thread, but now with all these in mind I think
> I still prefer not passing in MigrationState* at all.  It's already kind of
> abused due to migrate_get_current(), and IMHO it's healthier to limit its
> usage to minimum to cover the core of migration states for migration/ use
> only.
> 
> Shrinking or even stop exporting migrate_get_current() is another more
> challenging task, but now what we can do is stop enlarging the direct use
> of MigrationState*.
> 
>>
>>> Would it be better to pass in "Error** errp" into each notifiers?  That may
>>> need an open coded notifier_list_notify(), breaking the loop if "*errp".
>>>
>>> And the notifier API currently only support one arg..  maybe we should
>>> implement the notifiers ourselves, ideally passing in "(int state, Error
>>> **errp)" instead of "(MigrationState *s)".
>>>
>>> Ideally with that MigrationState* shouldn't be visible outside migration/.
>>
>> I will regret saying this because of the amount of (mechanical) code change involved,
>> but the cleanest solution is:
> 
> :)
> 
>>
>> * Pass errp to: 
>>   notifier_with_return_list_notify(NotifierWithReturnList *list, void *data, Error *errp)
>> * Pass errp to the NotifierWithReturn notifier:
>>   int (*notify)(NotifierWithReturn *notifier, void *data, Error **errp);
>> * Delete the errp member from struct PostcopyNotifyData and pass errp to the notifier function
>>   Ditto for PrecopyNotifyData.
>> * Convert all migration notifiers to NotifierWithReturn
> 
> Would you mind changing MigrationState* into an event just like postcopy?
> We don't need to use migration_has_failed() etc., afaict three events
> should be enough for the existing four users, exactly like what postcopy
> does:
> 
>   - MIG_EVENT_PRECOPY_SETUP
>   - MIG_EVENT_PRECOPY_DONE
>   - MIG_EVENT_PRECOPY_FAILED

Will do.

> Merging postcopy will be indeed the cleanest.  I'm okay if you want to
> leave that for later, but if you'd do that together I'd appreciate that.

Will do.

- Steve

