Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AB57439C2
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 12:42:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFBZU-0007JD-Dq; Fri, 30 Jun 2023 06:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qFBZH-0007Iz-AZ
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 06:41:35 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qFBZE-0007Xf-JR
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 06:41:35 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35U6CZog028166; Fri, 30 Jun 2023 10:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=PKO0m8fxMislnmFmLhMm0X3Y8xzfwPSeuAIM3PbjYC0=;
 b=vzmuMgw2eBpzQvCSY2Jqmy7QW5ymMJishtXjYBq+XlWk4gFimXlMPb063gPGEsPCM5ZI
 wpp8Cz6j9wvUBWzPD0hNZt/7afOYyEC6FRK9pBiDYpHuRh4H3RT0SrQYTNozDVKCzHL2
 qETvcikI7h9/dnvHiA84PsoNa4gqxf7NJ6doVcGXeACT+sNxCwp96YLFc/qg3Tznp+HJ
 tfkA/jNlyNB3SPMjttfDJelTBF4m5ES/s9xyjicDic/QT6AfSOtNx/zBHC7sCX803LLF
 ZCrVOdSFl92y5Tf41yRWtJzysC/997K6l3Y4CqfpCP/89pbzXcrJN6d+v9CI2UbQwjyZ Ew== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdrcafyjg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 10:41:28 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35U8uwrF008610; Fri, 30 Jun 2023 10:41:28 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx8nvyw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 10:41:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQ0vk3FhxtQm1oAVGHvAJmRbcjkmRfq0S1pVePAzILt79b1Vuax8CB2oCKchtPn72abQhwClniVhLVZXA+/132aJKdrmCCWxTO70rHzXUfF37as/jAGrskfdgRgDBOuJdrP3JwrBl+oARoWKDyZ6c+kGV7rPbyMXl4cbC1Lxfj490WH+QdcwRuySxh5YaNjvzPlhSOBEO2uNjm0jR2hpafQxZEIDhSrCyrylaanJXMmEX4gTOuFNbCE6liWTpKthwQlNw/qjNGWGnDCqoPUaVpaw9yHbe2wQINYAfEG2sheChvr/v+0k5r3AshFM4DZzA5bfDIG1d+IfkrlmeCk/oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKO0m8fxMislnmFmLhMm0X3Y8xzfwPSeuAIM3PbjYC0=;
 b=axkS8V6xGNpvLGLg0lD7zWmnFUoQwoDl5eiIHNh6qsq/R6jTg/ZCo1+nUy2dbjPo56U/EJd+cMp6hHN0UmqoCOaFMunXlAPiPsp60uygz6dnAMOrh4yGup6nMb0TDCyD3fz4EENUCRMyu81d3J96+UxqiZA1a+h09ahiXLNKPIFurBoGOoOIbDq/FOAonFYtMcc3E0Fxrn5l+dgxVGvMASLQzQEzbj9ykcP1hIuNEruIIUfQIUZ+CdKdisxRRrlIw6bdrwIZVRdHlUXQIdoP4tpdwGlaK9X335Q1Z1AXpAAN1CZxtIwyQvOQF94bQfC4LdsnNQuuJuiN0BdAKis+Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKO0m8fxMislnmFmLhMm0X3Y8xzfwPSeuAIM3PbjYC0=;
 b=bWH2L9XF0BqWDPd0DgKnJJDT76L/DCn9n7jy8EdVezFd8MKzrPXfZc7wo4mfjwxWreKk/ckor1vTlEhx6PekFtbmDZCDMtMlkxaBJTZ/BebkaHQKbXg/uzwnDM6u6sTwHWcqM0VshpALDUMjZzcWMeZF7yASadTbMjxmZeSG+Cg=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by MW4PR10MB6324.namprd10.prod.outlook.com (2603:10b6:303:1ee::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 10:41:25 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f%5]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 10:41:25 +0000
Message-ID: <908d5776-8539-7f5c-b7c6-ab64d4a85bd9@oracle.com>
Date: Fri, 30 Jun 2023 11:41:20 +0100
Subject: Re: [PATCH v5 4/7] vfio/migration: Return bool type for some vfio
 migration related functions
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, avihaih@nvidia.com,
 chao.p.peng@intel.com
References: <20230630073637.124234-1-zhenzhong.duan@intel.com>
 <20230630073637.124234-3-zhenzhong.duan@intel.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20230630073637.124234-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0043.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::22) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|MW4PR10MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: df08e5ca-f2bc-4891-4c4f-08db79568dbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hqAh3IHJLAuFk5TMU2a0QcPwbvVxKzf2W77LTHkRy0GeEFDLGDzok0nOYcK8VkyPtWRsmdRsPIz2f21x7qZVVx/U/G+ixF2b0OOKXIWqZtsMZt3swtI9wqYKK3G0LAH3t6cY66Ben0uk3yLaXQQ6pnqWWvDRWagIeYGft3Da18sMbntTSxjhUvo57u8VNI12aQZf2f8HU3warNRFBnycu1T6iOb5jRbdtC/03MCnZ7sm2wUDC/wbqHu0DaLPimm8oKEnYFQCdO8wxPfGm4FGI0S4mgMvwsBopXrC1PvbSaVFX7xwJd9B0xfn5gALswW3Yso6M2EDM/C7/VrRCdv/wdwjMBjS4Hg2lvu8TLX7f13e61WbTX3dPJkp1+P8qIJjYfsFUT9ZUtZaUFnmh5IhiEFoM+0u5HiFN6jtkN5IuPBjezrlg8c+BHL6WtrVuFzykFT+iaPu9OLtZEKmD5O/cUqpar2BHal+9PhWx2R+YaRANj8jKo+VGEpURbsg4rCoiIM8HAIFZIw92NLIh5yomTAK6fOVeahNvwVRVniUriM8IbaiGktVc5TvBTBQbju/oDduR1s041UM74HoICIBc0qXQkfK15UadwXpPwIy0nF26n16/4qLYwG/oGp3SzgU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199021)(31686004)(86362001)(8936002)(8676002)(5660300002)(31696002)(26005)(6506007)(53546011)(6486002)(478600001)(66946007)(66556008)(66476007)(4326008)(6512007)(41300700001)(316002)(6666004)(186003)(2616005)(2906002)(83380400001)(66574015)(36756003)(38100700002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c084cEh2UDJmZ0czUlU5WGVOR3ViLy9wN2kyVlZwYkduRXpYRC9NMmdFQjBh?=
 =?utf-8?B?SG9QTW10TkNtWklXWkNYRFp3M0xFMmdxeW9rTHdoMk5sWS9DRis4cWM5QXNu?=
 =?utf-8?B?Tk93VDVPRDlYWjBXZ2hwaHFhVzFBeHIzRHFjbDljb2kzcCtLTDRoTVg4TmQx?=
 =?utf-8?B?N3lUbWQ1WGxWcGJaaFIrVm54Vk93RWxiRzF2UzdJOEdzRUNMeXVvNENuMkRI?=
 =?utf-8?B?a0xPUm1xTmg2THdKN3ZsdWNQczNuZWFLam9ianZWUlNYYmpLa2l0VmxaMy95?=
 =?utf-8?B?UmN3VzNaYjVlaXVKZTdHL1NTWnEyL2duWHJmR2s1b2dIdVZ6TjVXUXNhYjds?=
 =?utf-8?B?cmdybzdvNk9oK3BYQ3EzRXhMWW5OTlZtZTdwR3ZCakVQN05MWEtZTUpsajRJ?=
 =?utf-8?B?dTlDRmtBZ0lPbkFSdnlpbEVzNFVWMnlaZjBYRjRiUEZGbUlDRWE2Sm5uS2Rk?=
 =?utf-8?B?UkVmVm9vWG1wbWxJb2gvaGdMS0U3a2lCbVFxSDJ2alBoT3VOM3JJcC9UUVRs?=
 =?utf-8?B?V3NSd1JqNHh5d3VPb2VqeCtmdlQvMy9TMWxrU1ljKzk5WXdFMEcvYlo1TFhV?=
 =?utf-8?B?TTJEaWdFN1IydEVuMjBWNk5BaHV3anlnenh3VjF1dGVidWFUSEg1S1VORnB5?=
 =?utf-8?B?NFdWVTNJcVNEMVVLd0JHVlUzK0szcmpJZFc1ZEJDZEVOSTRmTGlaZzQ1SHJW?=
 =?utf-8?B?N0tzbVp6NW8xMHlSeDhtbElqc21DTWUrVDhBZDJRS2NkT2lsL0lTR01nTGZ2?=
 =?utf-8?B?eHB4WTlkSnlnaXVIbFVvSDIwL0IzOFBlUlZvZjdNWktKaVUycVhoQ1JZRFR0?=
 =?utf-8?B?cWx5TXdDZENaRUlDRHI2NUF6ZTBuMnFmSVpzUWY3Njl2RENHQ2dFSWIxSGV4?=
 =?utf-8?B?ZmlmZzY5YVBsbGVRQU0xcUZONmlUdmhoNXRnNVNBZ1ZkemJITU5LYVVIRmR5?=
 =?utf-8?B?ZEhpdGtHQ1NydU56cllBWWUrcE1KS0IzMEJpS1ZRUEFSZVd4RkwxSlNSaFB3?=
 =?utf-8?B?clg2cEZGbHR3OXM0L241RFdKWG0vaS9mdU1kd0RVRFRWUmRCMFZIRjBiTzdN?=
 =?utf-8?B?amNmV3RJL2owNkMxVzMrQXZrVE1FOGovV1pBMEVmakUvOVZwa2JsY3o5YTZM?=
 =?utf-8?B?VHU5MWovRlBYQW9RaFRrcm4zK3lYZkZmWDdQUmFNMVZMMjRTdHhMbjFFbkdi?=
 =?utf-8?B?OGhsS2FrUm9WSUwwZmNCU3NsZmN0ZzlHSGxIUGhxcnpDYmxlUysyNEhLZ3Bq?=
 =?utf-8?B?VW42OEtaWjhxVFJoeEl5Y1IvL1M2a29sR3JCak0ycE9tcysxQVpHVnZvcDQw?=
 =?utf-8?B?WmszekNxbHVTMC8wMnJ6Q2kvRkxYMWxjeitDdFdRNHZpZk43QTZHb0VnSitT?=
 =?utf-8?B?SUk3OXVqdVVJWEVlVG1CVGJTVHJkSmQyRGZ5VW1QVWhKY0JITUwrWHNmNmh1?=
 =?utf-8?B?S0FZOXNTOXBlYUhkaHVXSUc0UVUxRjc2Q0RxNnpMMllOb3o3SWZzWWZndkRp?=
 =?utf-8?B?WUowak9oN2d1OFZ6QnA3OWU1Y2U3YjdqcGRwVGpOdTErNGxCczJkWm5WOUxn?=
 =?utf-8?B?Mk5heTJRWGU5bW1pRTA3SGI3TWZSWlVXME0rUFR5LytKcXhJYWNsRTBjNW9o?=
 =?utf-8?B?cHcrOUNYMGxIRmw1ZEFWbEZyYmxmUGxNbFNBWTdmUENDZDdPcUtZUGo5SEEy?=
 =?utf-8?B?dFNONTY4NHM4RzY1TGxVR3lpVE0wK1czbDZUMC85bUw5NklsYWhEK1o2dTMw?=
 =?utf-8?B?TUFnNGwyT25WOVBRYXdqMWlDWFRwZG1OOVhXREZUWDhIbnR2MEY4V204a2du?=
 =?utf-8?B?cXNNbmoxTzNtSmQwVG1FUTNnaStDMGQ4ZXRQK0dFQzJaWGljWUhjdW9VaEVG?=
 =?utf-8?B?L29jYmVJZlNQWkVQN25lV21Xdy9vaFRsM2lwT3FwUitleTFOUFVMcE5IQWNt?=
 =?utf-8?B?T3FKV09PQ3FmNlM4S0JMUmt3QWRCMXRLYmFOSUx6aDF6MkptWW5IcGNoYzg0?=
 =?utf-8?B?aFZIWEtyZE5FWlIybUlBVlRDZVkvOXhvWkxmQ21BU3ZOZnpGaVFiZTkxaVlD?=
 =?utf-8?B?ZlQvWHhpTDhTKzRpaG50azVPcUV4MGE1R0lYMFlMSTBzR3F6Y1J3bTQrTGZj?=
 =?utf-8?B?SFIrek90bnIramg0Q2l2T1VGK1o4Yjg3cUV1dU9FZyt3RzBhOUVlVXZqanZU?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yTsTzj1o9Nn0B1+CI6C5MESbaz4APvP5PhVSmC8iMf+Z1Z85LIKvbMhUBXwWphGJg0y8dkHsFgMQi3sa+MA3r8Pwz6VTmaPeVcbyIoD8WXphVXwFX8LKK6vudQmxYhBX9AQMs9+ICtXP6cHSqz9bcE2qVjmpRw4J7nbYKnROHzuVT14azEr3gmCdIXAKeLFY9NxdfoYt20ko55ScyMSlI9eyzKNAwbA0hV7rHFjTpJ3DAaVNszZ3HQXfkqr1EV06EhpP2k5L/pnALpPpTmQjF9SXgXbgf044kUdaMH5wPRV3Ukt9V1jikkWThT1BW/a1rW91ZJ/cKD7SIb5DuFUwE1QtMmpcS+4jHa3/+inkOSV7olMYapROSagQEDBitrEk36moCAaASl3eNBBkhaSyatzPq85Qq7LMv6mIZIWAwnrto61N9aO/jcLQY6/Vjza5N2f73goAoCNxacC66XwWnKvkTggu4xWhbMZTGhrgY0AwFwWhOYBRxEAd4i/HbQtVFXRnwphKrLBQYx7FxcKZYPTn3C7RuFEgAYZzR+5q9Vtw7ZANFb6SJ1umDeQ4Xwmbpv8+K2PyziqjN038nhYUmlx4wwEx/VCINT5kWpkZrmDI3bAOP9vxG5UMuRG8a5PzRza3k30uo1MfSHoZbNzyyInASMb1hPOkiAgcWYijFc0IzwI/TmFdRLOT+QmHhePyiSSn2j+N+PnpsXUHGsS9YujcB2Cl//NgT7YvH1LqbmowOWT60+NeiPg9fScx3pMPVGDM5fmsSUBLTNZ8jZ2kitDxHYqk3pUdHNeHZXGF0fpxtZuEYIvX5qGujVjGMKEWYNIkmdPCfguhZe1d8KUgXw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df08e5ca-f2bc-4891-4c4f-08db79568dbd
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 10:41:25.7407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VnssJEQ5nw2H6qQBVucefFkaD9dbvQiNdrIFeNIO+1+wfVfp15XJFTZdT3YtZQ4nbL+/SPStVQ5U8v96yujmXQ3ZRsN2eGOdMP9Cke7FFD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6324
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300090
X-Proofpoint-ORIG-GUID: BpEokJO2oXNjYARsLpVJB16v14mN8JCV
X-Proofpoint-GUID: BpEokJO2oXNjYARsLpVJB16v14mN8JCV
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

On 30/06/2023 08:36, Zhenzhong Duan wrote:
> Include:
> vfio_block_multiple_devices_migration(),
> vfio_block_giommu_migration(),
> vfio_block_migration(),
> vfio_migration_realize().
> 

Maybe some brief commit message would be useful as to why we are renaming it
("Migration disabled" no longer applies as that is being removed):

Make vfio_migration_realize() adhere to the convention of other realize()
callbacks by returning bool instead of int. In doing so, change also the the
functions used in vfio_migration_realize() return path to have bool too.

But see a remark below -- I think if you move the rename patch to be the last
one, you will have less to rename (?) Unless we really want to rename everything
that vfio_migration_realize() ends up calling to return bool. In which case my
comment then no longer applies. I generally favour not loosing error information
until last minute, but OTOH Error is provided so errors will be propagated in
some way.

> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/vfio/common.c              | 16 ++++++++--------
>  hw/vfio/migration.c           | 19 ++++++++++++-------
>  include/hw/vfio/vfio-common.h |  6 +++---
>  3 files changed, 23 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 77e2ee0e5c6e..00fef5aa08be 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -381,19 +381,19 @@ static unsigned int vfio_migratable_device_num(void)
>      return device_num;
>  }
>  
> -int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
> +bool vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
>  {
>      int ret;
>  
>      if (multiple_devices_migration_blocker ||
>          vfio_migratable_device_num() <= 1) {
> -        return 0;
> +        return true;
>      }
>  
>      if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
>          error_setg(errp, "Migration is currently not supported with multiple "
>                           "VFIO devices");
> -        return -EINVAL;
> +        return false;
>      }
>  
>      error_setg(&multiple_devices_migration_blocker,
> @@ -405,7 +405,7 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
>          multiple_devices_migration_blocker = NULL;
>      }
>  
> -    return ret;
> +    return !ret;
>  }
>  
>  void vfio_unblock_multiple_devices_migration(void)
> @@ -433,19 +433,19 @@ static bool vfio_viommu_preset(void)
>      return false;
>  }
>  
> -int vfio_block_giommu_migration(VFIODevice *vbasedev, Error **errp)
> +bool vfio_block_giommu_migration(VFIODevice *vbasedev, Error **errp)
>  {
>      int ret;
>  
>      if (giommu_migration_blocker ||
>          !vfio_viommu_preset()) {
> -        return 0;
> +        return true;
>      }
>  
>      if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
>          error_setg(errp,
>                     "Migration is currently not supported with vIOMMU enabled");
> -        return -EINVAL;
> +        return false;
>      }
>  
>      error_setg(&giommu_migration_blocker,
> @@ -456,7 +456,7 @@ int vfio_block_giommu_migration(VFIODevice *vbasedev, Error **errp)
>          giommu_migration_blocker = NULL;
>      }
>  
> -    return ret;
> +    return !ret;
>  }
>  
>  void vfio_migration_finalize(void)
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 1db7d52ab2c1..09fa4714a085 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -802,13 +802,13 @@ static int vfio_migration_init(VFIODevice *vbasedev)
>      return 0;
>  }
>  
> -static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
> +static bool vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
>  {
>      int ret;
>  
>      if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
>          error_propagate(errp, err);
> -        return -EINVAL;
> +        return false;
>      }
>  
>      vbasedev->migration_blocker = error_copy(err);
> @@ -820,7 +820,7 @@ static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
>          vbasedev->migration_blocker = NULL;
>      }
>  
> -    return ret;
> +    return !ret;
>  }
>  
>  /* ---------------------------------------------------------------------- */
> @@ -835,7 +835,12 @@ void vfio_reset_bytes_transferred(void)
>      bytes_transferred = 0;
>  }
> 

With your later patches where you remove vIOMMU migration blocker and have a
common return path in vfio_migration_realize() I suspect you will need to only
rename vfio_migration_realize() and you negate all the values accordingly in
that function, and thus hopefully reducing (...)

> -int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
> +/*
> + * Return true when either migration initialized or blocker registered.
> + * Currently only return false when adding blocker fails which will
> + * de-register vfio device.
> + */
> +bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>  {
>      Error *err = NULL;
>      int ret;
> @@ -874,17 +879,17 @@ int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>      }
>  
>      ret = vfio_block_multiple_devices_migration(vbasedev, errp);
> -    if (ret) {
> +    if (!ret) {
>          return ret;
>      }
>  
>      ret = vfio_block_giommu_migration(vbasedev, errp);
> -    if (ret) {
> +    if (!ret) {
>          return ret;
>      }
>  
>      trace_vfio_migration_realize(vbasedev->name);
> -    return 0;
> +    return true;
>  }
>  

(...) to just this one last chunk?

>  void vfio_migration_exit(VFIODevice *vbasedev)
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 93429b9abba0..b3014ece2edf 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -225,9 +225,9 @@ typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
>  extern VFIOGroupList vfio_group_list;
>  
>  bool vfio_mig_active(void);
> -int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp);
> +bool vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp);
>  void vfio_unblock_multiple_devices_migration(void);
> -int vfio_block_giommu_migration(VFIODevice *vbasedev, Error **errp);
> +bool vfio_block_giommu_migration(VFIODevice *vbasedev, Error **errp);
>  int64_t vfio_mig_bytes_transferred(void);
>  void vfio_reset_bytes_transferred(void);
>  
> @@ -252,7 +252,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
>  int vfio_spapr_remove_window(VFIOContainer *container,
>                               hwaddr offset_within_address_space);
>  
> -int vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
> +bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
>  void vfio_migration_exit(VFIODevice *vbasedev);
>  void vfio_migration_finalize(void);
>  

