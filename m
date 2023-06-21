Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4691B738FE2
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 21:17:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC3JJ-0000dv-HL; Wed, 21 Jun 2023 15:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qC3JA-0000ZS-Tl
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 15:16:00 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qC3J8-0000fK-Of
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 15:16:00 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35LDAnm5003640; Wed, 21 Jun 2023 19:15:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=LL6HMfsTf/WReMLivtVzANqD1ov2Pe01fd6roJtRzCw=;
 b=HMxjs0E0wyo8LpP5Fv/PF+cbuTKczALGl4G999TKCPIGq+VuFw3mSOWI39mRI9TtoHUs
 M+/VXY/CCQpd5SMZdWPfWQck8/tx3r0ZC7B6IuPbNm8LuA+qBqe4nSlwo2PsTGZXwk4e
 e/bXkf31cSeb188QckWQaAvO//Lph9lfsWMV/GzIxzyG1L21Y1AaeVqKJOQJ2vLikSa/
 5hp81XNm/BwTeqyAg9YQn4w3vtXobU8zBjDPy/0vzysfhmNslY3NnkosWm/+QbKWSoZe
 3SbjslxL+UKyDiCb2as9bI12PrYY8qu2C6HxLx91QA/LYmE/QuddwjiTFcla1qDBBC1N Dg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r95cu07pf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Jun 2023 19:15:50 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35LIIcaR007121; Wed, 21 Jun 2023 19:15:49 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2049.outbound.protection.outlook.com [104.47.57.49])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r9w16tv47-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Jun 2023 19:15:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QintvXpx4zzC7w/aFQIotgop3AkwPCm8wIrIWUJugvthROu74hCI5WMC8DV/U1VqeaURwABkvIfzNIVcqszJBKmnI+Ah1s+6CAXQQumJIn9PcShwG35MAhXOQ7fMuiEDEb/0CB43tCc80K+kYoobB70qCS3huoEf+zu5J0HQh0zZoU9ogUwj0BGAaljsVqileIv+M5pZ0f5KQ5f1p5MgJdxFt8eFzjYgx35Yn+av66LGzf53LCMtY3yui+JbFcpBCyBt6ujy3oS4uiZP2x3Sx0jBMj/JFw6gah9X5Dz9/vZpDGYPcKDoFerNoowelWwQDTFQyp4KYtdHYBwCXa8whw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LL6HMfsTf/WReMLivtVzANqD1ov2Pe01fd6roJtRzCw=;
 b=WZhsFw0sr2EXsSM80sUhtFDDTUSrLls77twIfois28IqzCzpdevfC1Bj/5l0WFM2tZtrf2D6IalBRVSCVTFHn3tx8MvC18l1kLQkKbDwRHaypxpeANwv5bnR/rJdOT0Y2jzCnVOkt8F1V7zBntmPJbOQ7oEzXtoFyoLeELyH7ejPbixSr4qOyLDpDDU8Hs/9mPPd5tPXTMNeBxzb8ZJH+vVsf2MQrrU1maaiTrE0twhVzsG13aToYTJeDLL8T1qmkPiM9c4GJ1PHUhm9cKXDKHyJRB7Y0MmA30TI667wj8+/18+ZvL88nduCfKSL7rQztO2xXrBAuHk8KShKXGJxzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LL6HMfsTf/WReMLivtVzANqD1ov2Pe01fd6roJtRzCw=;
 b=O8n3LJijr8ggUj8ZhsDrnzk6WVoFnfKi+wDmARhZ+dU6J7twPxY65+pKnUtKzLhREWcE78/OAQkRKJyCqoV409siBk3zHG8OioiWsL68TjvIgkppDGopW2EMepVvR3XasGDKPsTpgaCt7DQ3h0rS9TNGBHvdx87ELjzK6y19teM=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SJ0PR10MB5406.namprd10.prod.outlook.com (2603:10b6:a03:305::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 19:15:46 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::2743:9347:3bf1:5f11]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::2743:9347:3bf1:5f11%6]) with mapi id 15.20.6521.020; Wed, 21 Jun 2023
 19:15:46 +0000
Message-ID: <6adfae20-60fe-ae08-1685-160b2a1efab5@oracle.com>
Date: Wed, 21 Jun 2023 15:15:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V1 2/3] migration: fix suspended runstate
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1686860800-34667-1-git-send-email-steven.sistare@oracle.com>
 <1686860800-34667-3-git-send-email-steven.sistare@oracle.com>
 <ZJIeR7svXvtHdgs4@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZJIeR7svXvtHdgs4@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0338.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::13) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SJ0PR10MB5406:EE_
X-MS-Office365-Filtering-Correlation-Id: da8efa50-0b67-4e0c-70a4-08db728beab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eB4yj2sC2heTXhrPscKnIL/uBeqc+zPFFKKUI8icRqwEIZyncxh2le2P4L0rhyjPpUFNGWacGRMhK2ra6bLgDHnwwzI8+2xZGyv5fUw0bIUoBhyvQh1xwi6hR0+yxNr/FNXDfFrnI5p33NedyRjwC/G1myRCDDBXYpUfJWK3WRrOxgmKyaJfNgdE9RsMhGnefT/haHplwqimPBrKZlNJO+/115NswWA6gxOfjc3jROqFOdmXjsxXXYZNKFz+d9ZVlRFmZ1dFPCquAR8XXPdsq8nPRqpNALxk8J7RN1oujjHHt6Ax7wxgEryuXVcgKdXTaxRaUvIQlMOwsq/EtVuExM5Ax/NoA+fhhk07EHTLcGKfU6eKn07RShycm0X+Wf/Wbj8bLf2UYmj0fwVqK/69MGCSlU612gkpqp323RMBJN9aGQxWBQphElG5BtGUID06DPB4ET2q16ppfkpxHEfsz+Zf5uM/fe1q8KJ5mx9rbLwDFfFM5WheAmB9iYgv4UabraPafZM+Di1cZcmNXJXInFxvChSUU8JPfzl7PKe/Abu+YNlIFdN8GwwFcrxDXXeh75rGAoTM7bebkNwA4zdeV9akHqzGXjgheuii/1Whjl2kBDLklNeeaCgPVuyQwhPr9YNH25vGxXM5js0EqlP2+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(346002)(136003)(39860400002)(376002)(396003)(451199021)(66946007)(66556008)(316002)(4326008)(66476007)(41300700001)(6512007)(8676002)(8936002)(6506007)(53546011)(6916009)(186003)(26005)(2616005)(54906003)(36916002)(6666004)(6486002)(2906002)(5660300002)(15650500001)(44832011)(478600001)(38100700002)(31696002)(31686004)(83380400001)(86362001)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2FpdjUrS0hXK1FjRkttRDQ5c1hFMmJzajdlT3g4S3lpejNmQzE1eTJUaUJO?=
 =?utf-8?B?ZnhRQThCNmFGTTRKR0JVYStFT1k2N0ZkdmJ6Q0YrZlhhWlRZanBCTllsWHY1?=
 =?utf-8?B?b29tUVVsZ2FRMlNtYnJmOFFMWHdmOGIwd2lsLzE5eGttdENONmZvNUxHbmlP?=
 =?utf-8?B?em1NRzVMbjhsNHM5UTZEOVJtSFVzUno2ZTdPL3JwOW96aklZSyt1Ny9pWTZp?=
 =?utf-8?B?N1Vjc2ZqWHRmbVRldmFRMUpLMnk2Sk9SeUI2Z0h5cDZhMytlWGdVK0RzVWZp?=
 =?utf-8?B?ZmdKZXFERlFxOUVuUm10TnYrcWU5T3dadEl6cTBCUjM5U24zNnhnZ3V0K1ky?=
 =?utf-8?B?L0Q5RGtYenFYaUZqYU5MSkZPbFpnUlRyTXY5NUZkcm1KQjRxcHcwSjdIbjB4?=
 =?utf-8?B?YTE5NTBoaGd2R1lUTmVHVzJhT0J0UllUbFJESGVOZk9DUUhJYTVGcXdZY0Rp?=
 =?utf-8?B?THBsaitkREh2emJkQmhwVmtzeXl1TDZkd0NIRG5ERDJEZHZEa1hHTmtxR2Fu?=
 =?utf-8?B?S25NcHhmYnFkZm9tR3Q1UG9mRHByc2EvZ21lc3VmTlcyMXJqTDhrWWY5Y3Rw?=
 =?utf-8?B?eS9hNFdNd0l1SnMxMmduR3dBMlFNZUkwWkVzT3Y3bmtPeGcvcHl4b1grY2Fx?=
 =?utf-8?B?dWIvbWM2cG1TUHdEOEJtL2lCSDlEcXJMb3ZleWlLK2phTEJqUVgxVG45Q2My?=
 =?utf-8?B?VzNKUWI0bDRLd09scWdSM3lIWWtJS1JMekUzcitmK05OckN2RkdKVnJHYUZ6?=
 =?utf-8?B?cWZxbm9TeTc0bHhPT2x4TDhtK1dmSmo1NUYzWEIrOWhNQ3lHT1FSNVd3c1RC?=
 =?utf-8?B?ejBtWGRiSmNuWjJUKytBQVhyWU1ERVFwQnkvVzlmRmRNSUVqRzNMbFkrbVVn?=
 =?utf-8?B?QWprQmlNbldRL0l3NS81SWpadC8xaE0rUHVFK3hrOENIRWhVNXo1ZVYzZzJY?=
 =?utf-8?B?U0pDM3FFeXFiQ0JMYlkwOVhrQThsVW5zY2M4RGNycCtuWFgycGdLVWhBYUh2?=
 =?utf-8?B?SlYzRVprR1kvOE5aNTA4R0VFR1A3eFRydFEzSlJ3M1dQc3A1UzlNcjZSVnZW?=
 =?utf-8?B?Sms5dk5nWU4ySnlSQ0JQVXIvOUQrZS9TSHpDQXMvbGFYR1dYY1Q1VEZDZ3Nr?=
 =?utf-8?B?NGwvYTM2aFMyYm10aXJqUGRtTzl4SSszb3VTTUp2S2pLU0IrMDQ5aUVIYXlV?=
 =?utf-8?B?WlRlVStETC9zSElTUnpPNElVUnB6Z1l1aWpvUm9ieS9sZDh1WUcwTTdSNDNw?=
 =?utf-8?B?WmI5YS9BNG0rZ0h5OVI1WGZMc0hkeC9kemxnb21TTEdMMzA3ei9wWVgzV2Ft?=
 =?utf-8?B?U3Y1cm5abU1vVjdYN1VHY01wdjEzRFROVDdCbFczNVdLZHhKZU5PdEhPendK?=
 =?utf-8?B?WkdLWkE5TTE3T0hVSHVkanlnZTBrUWZWWFhKeU1rOXdKWEg1SVVZZDdmWHFH?=
 =?utf-8?B?T3Q2eThkSVJGOE1vRklWYTdNYWoyMVN0dHpKamh2emlxaTdWZzNtQ1h2SWwv?=
 =?utf-8?B?MHNXQktyZUJaRlQ2aHVKSk5pYzRKcEpQMkRZYXd0dE8wYWorQWlRSkpkdkJ4?=
 =?utf-8?B?bXI0V0U4QkVxOVRUMkQrbExWL3dlVEp5T1p3aEp2RW5KTXlHVXVqdzZock5k?=
 =?utf-8?B?QlNYUy9WaWgxMUlEWjRzM0g4aEFNempsM0NRdGV6K2xVVmlGOUpZeTJya24r?=
 =?utf-8?B?ZFNLK0U1Y0grZFF0UmhlRjlqS1l6TnptL1pZMGxURmhmQ0ZmeDI3R0lxaXpZ?=
 =?utf-8?B?YWxJY0FFdmZ1SDh3eEhLOG8rai9Zc1NPYnlRbEV0UWx5S2FCODdwOHlWVGlm?=
 =?utf-8?B?cUx6TG1mUnl2WGp2QjhmREdxb3ZoL0Zpcm9LMnJmUXdaNmt0cjJGUTgrb2RP?=
 =?utf-8?B?WmV2UWlSYytLakRUdkc0OWhDbWp6VjBHNnNBTDRiWkxGRTFjblo3WTg0cFNn?=
 =?utf-8?B?eUNqU0YzMWsrcXRwT3l3ZkdicHR1MlNGcTIwQmdrME1NQ242WkFNdkZ1NkR0?=
 =?utf-8?B?UTJRV2hOWkZLd2Y1VlByckRTb1VsZGlQL2RkRVlZWTVWTmt6SFJmTjM3cmVp?=
 =?utf-8?B?R01pNm8xTDlZS0xBNGVGRWRPWHhHOVJ4QlRqMHdCaWQ1Q1ZhcTZyK0ZsSCtr?=
 =?utf-8?B?bS9ETDVGQzFqTE02c3l6NWh5eFRuMGhFdjJkRVNLcHRnQlRoaDVoZHprb1lj?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IYqz+7mJa4rJidey0E+Wu/qrBXvy/IxdPhRvs4fjHcIv6iD/KMfT8R45HJBTPuB1y7k0hX8iczk/VwdbjISN76nxtT2cmz8B/Es+BLAq6uX1IBq4DTu0BfJ2tuCOkXTGPMwNlu2MeKbO/ft3jCwTJT1g5h05T2mVXoHCGwVCztvYw9tIuRLOV8yZQKmMNBdEO/oxqnlNtcN7o2h5adKK9KW1DjH6Tx3a0QKHQbGNljUuDcbwEyxmV4Z+o0p3HdIOP3FdkBWyNEgYFatG7XPkCgi5G1XqW7PbtOze3xtK/i2O6/1eimmTfQ1Q6KDC/cfKRpfxY6L+J4F7aONklxh9QBNsiKLjM78OIVVvAPfCP12QXiuVUoC2/jVX0M2mIcriFzrvwBrqcEUcmS0X8dvGroLdIYQBtiS5avEMG4TO9AWi6Tp15Jzj9jun42625KFH/meXrFTRJgAvyae+eALwMH35wQmq4PBI18TE6n+phoz6tL4zSJJgZlkCxOHPq6/ju+3fQt515RbdoHz0RDEjjVnHLYbZtrbpSTf5EEboql/+UsjscyOLsCgck3k7A9gcLnYOIZ/G/iMVnBsGrJPwHtKDvQo0Z6e2Sowxv4jLgrhBEDPydop8UJfUpVUeN6aTXWOqOx4Ffvxt0aYgMQ/xlw6nM8qP00qMmiUR9cgtyPU66Dols39+yfdtKq9JSQmM15abqUz53FVi/s5odb5awZDHD1eLb+XEYx19EjMC0s5E6sKJlsJ6IfzufQgurct+/vdukDgLczpyAJ/bDNK1ew==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da8efa50-0b67-4e0c-70a4-08db728beab4
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 19:15:46.8061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0XrgAFDngArkHNbXAJwj8DOt6AZ816+/myPPqiTDNkFbLXQ3IPDXK4LPcquw2Df7ktO7Xh8kApRjdX4xwFp5Vp2szX2ExnUtJjLBEhgWF5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5406
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_11,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306210161
X-Proofpoint-GUID: 9xyrSMvxg4NCwzNqGGGhYTUNUTmo49X4
X-Proofpoint-ORIG-GUID: 9xyrSMvxg4NCwzNqGGGhYTUNUTmo49X4
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 6/20/2023 5:46 PM, Peter Xu wrote:
> On Thu, Jun 15, 2023 at 01:26:39PM -0700, Steve Sistare wrote:
>> Migration of a guest in the suspended state is broken.  The incoming
>> migration code automatically tries to wake the guest, which IMO is
>> wrong -- the guest should end migration in the same state it started.
>> Further, the wakeup is done by calling qemu_system_wakeup_request(), which
>> bypasses vm_start().  The guest appears to be in the running state, but
>> it is not.
>>
>> To fix, leave the guest in the suspended state, but call
>> qemu_system_start_on_wakeup_request() so the guest is properly resumed
>> later, when the client sends a system_wakeup command.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>  migration/migration.c | 11 ++++-------
>>  softmmu/runstate.c    |  1 +
>>  2 files changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 17b4b47..851fe6d 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -496,6 +496,10 @@ static void process_incoming_migration_bh(void *opaque)
>>          vm_start();
>>      } else {
>>          runstate_set(global_state_get_runstate());
>> +        if (runstate_check(RUN_STATE_SUSPENDED)) {
>> +            /* Force vm_start to be called later. */
>> +            qemu_system_start_on_wakeup_request();
>> +        }
> 
> Is this really needed, along with patch 1?
> 
> I have a very limited knowledge on suspension, so I'm prone to making
> mistakes..
> 
> But from what I read this, qemu_system_wakeup_request() (existing one, not
> after patch 1 applied) will setup wakeup_reason and kick the main thread
> using qemu_notify_event().  Then IIUC the e.g. vcpu wakeups will be done in
> the main thread later on after qemu_wakeup_requested() returns true.

Correct, here:

    if (qemu_wakeup_requested()) {
        pause_all_vcpus();
        qemu_system_wakeup();
        notifier_list_notify(&wakeup_notifiers, &wakeup_reason);
        wakeup_reason = QEMU_WAKEUP_REASON_NONE;
        resume_all_vcpus();
        qapi_event_send_wakeup();
    }

However, that is not sufficient, because vm_start() was never called on the incoming
side.  vm_start calls the vm state notifiers for RUN_STATE_RUNNING, among other things.


Without my fixes, it "works" because the outgoing migration automatically wakes a suspended
guest, which sets the state to running, which is saved in global state:

    void migration_completion(MigrationState *s)
        qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
        global_state_store()

Then the incoming migration calls vm_start here:

    migration/migration.c
        if (!global_state_received() ||
            global_state_get_runstate() == RUN_STATE_RUNNING) {
            if (autostart) {
                vm_start();

vm_start must be called for correctness.

- Steve

>>      }
>>      /*
>>       * This must happen after any state changes since as soon as an external
>> @@ -2101,7 +2105,6 @@ static int postcopy_start(MigrationState *ms)
>>      qemu_mutex_lock_iothread();
>>      trace_postcopy_start_set_run();
>>  
>> -    qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
>>      global_state_store();
>>      ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
>>      if (ret < 0) {
>> @@ -2307,7 +2310,6 @@ static void migration_completion(MigrationState *s)
>>      if (s->state == MIGRATION_STATUS_ACTIVE) {
>>          qemu_mutex_lock_iothread();
>>          s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>> -        qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
>>  
>>          s->vm_old_state = runstate_get();
>>          global_state_store();
>> @@ -3102,11 +3104,6 @@ static void *bg_migration_thread(void *opaque)
>>  
>>      qemu_mutex_lock_iothread();
>>  
>> -    /*
>> -     * If VM is currently in suspended state, then, to make a valid runstate
>> -     * transition in vm_stop_force_state() we need to wakeup it up.
>> -     */
>> -    qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
> 
> Removal of these three places seems reasonable to me, or we won't persist
> the SUSPEND state.
> 
> Above comment was the major reason I used to have thought it was needed
> (again, based on zero knowledge around this..), but perhaps it was just
> wrong?  I would assume vm_stop_force_state() will still just work with
> suepended, am I right?
> 
>>      s->vm_old_state = runstate_get();
>>  
>>      global_state_store();
>> diff --git a/softmmu/runstate.c b/softmmu/runstate.c
>> index e127b21..771896c 100644
>> --- a/softmmu/runstate.c
>> +++ b/softmmu/runstate.c
>> @@ -159,6 +159,7 @@ static const RunStateTransition runstate_transitions_def[] = {
>>      { RUN_STATE_RUNNING, RUN_STATE_SUSPENDED },
>>      { RUN_STATE_SUSPENDED, RUN_STATE_RUNNING },
>>      { RUN_STATE_SUSPENDED, RUN_STATE_FINISH_MIGRATE },
>> +    { RUN_STATE_SUSPENDED, RUN_STATE_PAUSED },
>>      { RUN_STATE_SUSPENDED, RUN_STATE_PRELAUNCH },
>>      { RUN_STATE_SUSPENDED, RUN_STATE_COLO},
>>  
>> -- 
>> 1.8.3.1
>>
> 

