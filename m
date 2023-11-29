Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 049BD7FDE8E
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 18:42:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8OYq-000200-Ky; Wed, 29 Nov 2023 12:41:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.christie@oracle.com>)
 id 1r8OYn-0001yS-0d
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 12:41:17 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.christie@oracle.com>)
 id 1r8OYj-0002Yr-V3
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 12:41:16 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ATFmcDw030782; Wed, 29 Nov 2023 17:41:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=GLhWn4cp+UR/HSS34XUqNkd3PcLVtYGNWNnJDqiHevA=;
 b=BT7bfiLd1XzyqTagfsdZtyuhOfd7lUb/FkXETfWwZ4e3g1vi3W1C1JdPerpJMufYFUgC
 9wFTADC4e2zPBpUkmINE7IjTj0rP4uZ4taKxvdKGYOgbFg+MUiXx8J4U/Js7/Yu5UtwW
 5502Ihx6pcOxwjtR+fZ769fQU0PJAkC69bRISp/VYifpKfnAtsSS/Q2RaqmVTnP0Admh
 2/QrwZwUiXp0EOvzZELxy10Xq3TQQnCCPx6uHBg/fs1rgz8cBqqsq/U9fctoxO3qQBwd
 OOO0Q0Y8mJHEeSAssPVJDpe73uuUsHUs7hfz3AY7fbHB1WMBxNGzbkXEQ4pou26C5gfj Zg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk8yd9ma7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Nov 2023 17:41:03 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3ATGvqJ2013127; Wed, 29 Nov 2023 17:41:02 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3uk7ceq3kf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Nov 2023 17:41:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpaKqTIxpJ6GNGG8LJDRAhh9mcyvE3/rnhnMBQXN5Jg/UdnFJAWjery7gRQiPYvGF8oEWVXDN34U+I51U3gr1AI4TA8bg5/brbXZ1UPXb7Oar+TTpEAKotsngC8eCH47uVvopbu5ZM2yQUQqZQPI6HlKDZsHpKRxY7TemU9tfp1ieG2QB8hQSAeRmAjvYl5VNBrQY3jDFIat29heTscbSrcQ/9sZNqDhxpGn1H4dmv4eUdKqnXxcovTViknpHKiO3YutyPDcbluZnfo/AU/xVbbnC6T3KTZdOPZSGnNqFz1T8fXmRZxGgW16ulSEngrttoqbvuuQpJAfthoxC0xKow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLhWn4cp+UR/HSS34XUqNkd3PcLVtYGNWNnJDqiHevA=;
 b=cCueJJ7SA4spHaafvec0EZMOgKHzhjXE5RnCcidNSsn6VjufgOVSRenryBsSzZZ0UIrcfQGOoO6zEHBDNixoQLA/GQyMU2mddxxm9q4S67CSBVTWveLNC7Bn5sOnRQIL1R61TKUDKfSWpHBfG/HOgbNmz6Y7rYG6nScc45Yrqjy+PEdE2j7IDr/BG1cQa7qMidbLUpcx6sI2pOIajnJETODnlwQ0f3wW0Ssv5wZfIrm2DJkx4+/WUNBNBGGmjv9BaaUz6d2Aow60up6eV2mkPwHIC+XL3+RNwtcJ7T/Vw5pgToQ/mJ5sxDuHZo17OIHDrxL5FMf2aKgcHykKzJuX1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLhWn4cp+UR/HSS34XUqNkd3PcLVtYGNWNnJDqiHevA=;
 b=LoW3I2PJHMz5VK/3s3PHvi0lcjmrpfTP97FcYisIRHf++gF54QXAxvrqT1ZGFT6G/rLOb82OL/0BCGFfTF78xEhfo5iOedfSLAkpt1BZlwQVB8fvm5RxfnEcPoRfTwYigMfh8Q5bfYbIgDLR2HIdHwIf67wYni9zZbQrGK9xMeA=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by DS0PR10MB7400.namprd10.prod.outlook.com (2603:10b6:8:138::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 17:40:59 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::449f:4fd9:2d3e]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::449f:4fd9:2d3e%4]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 17:40:59 +0000
Message-ID: <2146338a-c50b-414d-88b8-54e98818ee58@oracle.com>
Date: Wed, 29 Nov 2023 11:40:58 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] vhost-scsi: Add support for a worker thread per
 virtqueue
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: fam@euphon.net, stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com, 
 pbonzini@redhat.com, qemu-devel@nongnu.org
References: <20231127002834.8670-1-michael.christie@oracle.com>
 <20231127002834.8670-3-michael.christie@oracle.com>
 <kz5krs3kyhhurm7qa7b3alpnakkusbazmturdhamvu3vkmrurm@xxa3edifnphp>
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <kz5krs3kyhhurm7qa7b3alpnakkusbazmturdhamvu3vkmrurm@xxa3edifnphp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0322.namprd03.prod.outlook.com
 (2603:10b6:8:2b::29) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|DS0PR10MB7400:EE_
X-MS-Office365-Filtering-Correlation-Id: 70ba11a5-cbc4-4c8b-377b-08dbf1025988
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2urPUOvIwshgb1ypoVXCD/AE5kYFor8IYzPCogipJYVQFJgZegOg8EwxK7xBbzgvlemnnvkb7JvQko4v8lzvRaRHSuArz2Y7AmhHn2oKoOZKrDfY2L9xyeZQoFpZMK2JmJYzqWxWHADpTqUgQvWzlL1e92M8RvKqNVdeLZDOE+sEO5VpPPtDVK9Xa/t4i6Xlj4rA1VGZQdXVhO/OR774d/Un3PGYffd7vXyJp8R+C0UCxCaBVlGpCSXWP5r0jrttVm9ZOhuIZiH+R0Y2G4+twhJEmVWYfVHxH8/UshcwHZ1UWkXn+75BKGjJzpcxJrinDi6qVDspYI8jv3zzb8EqTilV1HzF4BnyF44g4vPoIqZuOw3pmnJqmhz/B8bbwZ6Ngr0B7m4iH8TpJlY1zNSl9p0OT3Y6p+hbhT2Qdzv8KBfqotfccHtCyURFl3OrGyb1/949g4j0dyMbgP1pSrqhviICiYCFj+Cx4bKj30PoPLsRLu2o2JYHiQ7Yu+mNDwEYUwxtEepU9ZtfHCHD2GetjRZQE5EeOP7LMkEalyCdPm7TXYthExgfYUkljih3QBvj0IkTXETqkH657Ge3Pdus/AqrbTP9dZ4JGZFCod1lu4iUAI4k67oXEMOQ/xEYb9xmDuQVb+PBtY5FdeZNj7t0ZCTqXiPw/YnwKWqmTdAs0yVp7u9kduOStcSpJwkwgv17
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(136003)(39860400002)(396003)(376002)(230273577357003)(230922051799003)(230173577357003)(64100799003)(451199024)(1800799012)(186009)(31686004)(36756003)(2906002)(5660300002)(6512007)(53546011)(86362001)(83380400001)(38100700002)(26005)(41300700001)(6506007)(2616005)(478600001)(6486002)(66476007)(66556008)(66946007)(316002)(4326008)(8676002)(8936002)(6916009)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajAwQXdCNC9UU3ExZExGRUd6Q1B0cXhrQ2NybDRiUDhkSGN1eFRGNG81WFF0?=
 =?utf-8?B?dUdRVktWZzFsT2dleEtqTVorWjRLTktWY3JKVk5xcTlhclA5SkNUR0NPdEhZ?=
 =?utf-8?B?ajV5b0c1WFNWMzU0NkhaVlF0V212Q0NnRTBIaSt3M05RNy9jWjlveGY5RW5O?=
 =?utf-8?B?VU1Md3JtdTFLK1gyckJpQUFUclFNZElQLzU2U1lFUjVNQ3ltMklmSFVObkRK?=
 =?utf-8?B?YTA4QXpEOFo4dzBRQzlXMllHUzhTTnFGMGJJSVkweTIwQUhTREFhZ2xWak9O?=
 =?utf-8?B?aHBmeWVYdDhPZ2VkZmg2L285STQyNTNBeDM0dk41ejI0WmJ1TmRvKzV1dUpT?=
 =?utf-8?B?TEJMeG9LL2VDb0Mva21TUW5UZncvVldXTC9WNDg4emh4RFhkZGZqU2poVkZE?=
 =?utf-8?B?bVd6TitJN0oxeUpLVlpWUUFxYndHRXBjMTdXU21iM1BXbnZPUVNjTkkxL04x?=
 =?utf-8?B?T1B6KzdZNWg5TGRuU1BpNEZXRUZiRUZOTWtvSEJiOVU1TjFHcWZCNmVveFBi?=
 =?utf-8?B?ZFYxR2dzU0ZoUEEvMjlxUWVkOG9mY0N0eVoyT0IvdmxFSWdnUzNvRk5ZTVJz?=
 =?utf-8?B?Z2ZiRUlOVUlqQ0pqUEVtMmMwQzZOa0paQW5ES2tMamdVQmF0emZNV0lNWUda?=
 =?utf-8?B?ci9SeGhmY242WmpURVl5VVNjelJyL1c4S2F0L0hlelhjcEwxZEkrMWxuOXd5?=
 =?utf-8?B?OW1JZm1GeEdWMklSRld6cXlHMGxNR2FxNzNjbTF2cFQ5VjhzaDQ3RzRTcncx?=
 =?utf-8?B?TmRBUjJZMFp5MEY0YTdoVHlyZkhZeDhpSXp2RlRXekQrRnlTVnFyeDYrWkQw?=
 =?utf-8?B?TEp6NXR0NHBUN3dSSzU0SjJMbVVRbWQ4aUVJTTl3NzVCS0pzR0g5OTVTSXYx?=
 =?utf-8?B?djMyMWVnc0dGNTNKQWFYNDlDbE9ONFpKeHJjUHB2cnQ0Mm5oSjVjNlg3a0F4?=
 =?utf-8?B?S21VMFpsakNobHA3SUtvMHVndFI4R3BRZjkvczgrK1JtKzdWcUg4UU9SdnYr?=
 =?utf-8?B?S01DcHlmaXduTVBlOWJDYUQyb1VCRnhINE12U2tCRUxYdm9BZVVwcVpiTHVL?=
 =?utf-8?B?UHFJeWM4ZjZ4MFRVbkhPaW1HTjRTZ0dRSjJvcGpSTXJlUS93UmJOcTM0RWJR?=
 =?utf-8?B?S2N5OSs3eDFLUFhyWmtEZVUvVFNyV0NVTlQ5alJNc0M5c2VQRmpqaGUvR1NW?=
 =?utf-8?B?SzZ6RnVLUVVSR2JTMUV5ZVZwTWlVd0M0STA0WEJ4UlRoKzhzQlU4NDZsUUZv?=
 =?utf-8?B?ZWZJUmVsb0tHOXJIQ1hPeW1aM1V4K05hcU5xQVJCMytQNEJaUWxwYy8ycWQ0?=
 =?utf-8?B?V2NlS2doRkVjSW8rb2ZSUWNYNTA3cFRxeExPRFpUYktXU0JUeGM2TWxsZDhr?=
 =?utf-8?B?MklBdE5EUzQzeUpEaDNxWlhDUk10cGQ4VFIwdnBuc2VJdk1PWHdUR0orYzF2?=
 =?utf-8?B?TTBLaWxXVkVNbXZiRkp4aUljbVpaVkVTcDExT0hIZDJBS25RQ2VXdHI1K05n?=
 =?utf-8?B?QzJKdFdFME9zNUF6Q1ExL2VwYzk5VFl1MXRYRG5wMUNRTWFFbjVnS003L3lH?=
 =?utf-8?B?OG4xajZKa0s2QkNUZlFyVmpkUHY2RHFkSjNXbGZNMmp3eDB5aUE5R1FycWEy?=
 =?utf-8?B?bjZwQ2pDZCtYdGYwV1M0Ti9nQ211V1hkbzIyZGlVYTM2eHU5OEE3VllUbjFM?=
 =?utf-8?B?a3Jrd3lGUldlZXhPcGJDVHpUNlhIbytiaVhyUlBTaDFEcEl1NFVmVzU5WHhh?=
 =?utf-8?B?MzJJcGZNbEZNcjhLM0RlZ2tPRnI1TFVuKzBpWHA4ajhvWThxeFpuN1VCb0lS?=
 =?utf-8?B?YU1VRzBJYUFSOUtEWW4wQ2tWcGRwb3pyckN1R2dHMlRzeWVGcU9SR1I5Q2ZP?=
 =?utf-8?B?OG1PNjE3WWs5ZjAveTZ3aXJ3VE1KS2JyL09pQ0VmdVlvZU41empqMC81YVdC?=
 =?utf-8?B?RnA4d3Q1YzhnRUIwUXNSR0pqZDY1WWJOY3BuR0tJSXVvNUo1Q3pxZXlJV0VK?=
 =?utf-8?B?cmxkN2U0WmVuYzNtcm5KU0hQVjV2d0p6VEhkU2tnQytrWHdMbmpMVW5HaS9v?=
 =?utf-8?B?MU1qUWpJMnB1NDV3NUpjRWlJWklBYy9jZFNadlR5ODVWbXNvdGpqakZpMjlG?=
 =?utf-8?B?ZldvL3lnd29IaUZLelMzT1JsNkMrRHNaaG5ERmtKRTEraG9RU1VMNE5haFhx?=
 =?utf-8?B?b3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yZUjm0GHf7TMn+4nC8pCHErw1kRLDEOVPzXb7AB/Pd2qU0EB3qh3HYDBi50PAlBVLoI57i/OWgbIRrG2ip3IvviqbCdyZJ6E5So0B3WrSciSLwghgbeseW/hF03M5c0pmZAWUen8AmbEcmuOz1cErtAOcCbrnzHpt4w9xw4Re9ic+ZXV2n8fLOnt9bSwvyhTxMYK46Yivp8l/WUhN1thASO+mL07TOLR0qY99euyPNxYDLkE8eg3kgKYLEAnTOtoyaJYZnDDj9JbFLltA44IU/Nl1YrRfOjKkEyyhKi/Vx2oeKAHnlYlgGW8StI75vMiGvfjwLFiEbRbxOA2i/JoWJ212GGCbhu02gzHPSmzYty5RP4Wjs2pn3BwPRQ8WO7mSJmh0AoE8qAne5XFR0gWaH4jG9wHIzlXZQw0j3I1rY4iybfJWBNYPBneaOPl2ZqjdPskxhhhFQkf0kZWVhOrjD4lpMD0+6qN/Vns7dEMxhCQpE2y78l0Csoe6efQp6ERgURlLuY4Hh/XVz6VOHXaMHu15ZsfIaM3m/mKEgZuvpFIEG6jOM8wzcap8KDPVkLhCxhF017YGHbf2GnPiBFEmpsSTBLDnOtrsbPkE8R3NyEXh5mKj+teHNL2DKeF1RG95mTykLp9r4p2upzxgB4VYF30n4VM7DwOrPp55Pi7PLofmbUOiZ/DyDaKe/AD3cWw14oi/GMsbiLWX2LyfVK8NujFSA8ZqtNr2T5Dju8dmwuX0iHXHm4BhHLXGexNIPsomYssj0hewn75HWjtQo+N8ychSsfgAyVF6QwtWjHfyIvYrT9+C8cNjyaZjFCBkKOw
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ba11a5-cbc4-4c8b-377b-08dbf1025988
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 17:40:59.8715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G0e04rd/PWThc986FukA+vUPt9PYZEHvtuPoR3XF473R5NxYufdVgnFkZo/2BNyLM/oT1ddWZ3vlxDMK5L19vC1sD3N+t6rXnvxgewz5Tq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7400
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_15,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 mlxscore=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311290135
X-Proofpoint-ORIG-GUID: XUSs-xy1wPuNEHXgvsiJjMsPET5n8TTT
X-Proofpoint-GUID: XUSs-xy1wPuNEHXgvsiJjMsPET5n8TTT
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=michael.christie@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 11/29/23 3:30 AM, Stefano Garzarella wrote:
> On Sun, Nov 26, 2023 at 06:28:34PM -0600, Mike Christie wrote:
>> This adds support for vhost-scsi to be able to create a worker thread
>> per virtqueue. Right now for vhost-net we get a worker thread per
>> tx/rx virtqueue pair which scales nicely as we add more virtqueues and
>> CPUs, but for scsi we get the single worker thread that's shared by all
>> virtqueues. When trying to send IO to more than 2 virtqueues the single
>> thread becomes a bottlneck.
>>
>> This patch adds a new setting, workers_per_virtqueue, which can be set
>> to:
>>
>> false: Existing behavior where we get the single worker thread.
>> true: Create a worker per IO virtqueue.
>>
>> Signed-off-by: Mike Christie <michael.christie@oracle.com>
>> ---
>> hw/scsi/vhost-scsi.c            | 60 +++++++++++++++++++++++++++++++++
>> include/hw/virtio/virtio-scsi.h |  1 +
>> 2 files changed, 61 insertions(+)
>>
>> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
>> index 3126df9e1d9d..77eef9474c23 100644
>> --- a/hw/scsi/vhost-scsi.c
>> +++ b/hw/scsi/vhost-scsi.c
>> @@ -165,6 +165,57 @@ static const VMStateDescription vmstate_virtio_vhost_scsi = {
>>     .pre_save = vhost_scsi_pre_save,
>> };
>>
>> +static int vhost_scsi_set_workers(VHostSCSICommon *vsc, bool per_virtqueue)
>> +{
>> +    struct vhost_dev *dev = &vsc->dev;
>> +    struct vhost_vring_worker vq_worker;
>> +    struct vhost_worker_state worker;
>> +    int i, ret;
>> +
>> +    /* Use default worker */
>> +    if (!per_virtqueue || dev->nvqs == VHOST_SCSI_VQ_NUM_FIXED + 1) {
>> +        return 0;
>> +    }
>> +
>> +    /*
>> +     * ctl/evt share the first worker since it will be rare for them
>> +     * to send cmds while IO is running.
>> +     */
>> +    for (i = VHOST_SCSI_VQ_NUM_FIXED + 1; i < dev->nvqs; i++) {
>> +        memset(&worker, 0, sizeof(worker));
>> +
>> +        ret = dev->vhost_ops->vhost_new_worker(dev, &worker);
>> +        if (ret == -ENOTTY) {
>> +            /*
>> +             * worker ioctls are not implemented so just ignore and
>> +             * and continue device setup.
>> +             */
> 
> IIUC here the user has asked to use a worker for each virtqueue, but the
> kernel does not support it so we ignore it.
> 
> Should we at least print a warning?
> 

We should. I'll add it.


