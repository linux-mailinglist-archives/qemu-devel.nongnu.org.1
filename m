Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DE47BB5D5
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:03:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoibS-0004Ns-Na; Fri, 06 Oct 2023 07:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qoibJ-0004NT-Dk
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:02:35 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qoibG-0005BA-I1
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:02:33 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3969EB0c019296; Fri, 6 Oct 2023 11:02:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=gozMOFDYrp+TbL91FYF4lGvOVN8zrM1rrV8FvpM1U9s=;
 b=kutWSwtE8+Rcv7yC4TepnfsK3YJHeBSSbsMlYm8MlotNrg9jQPBnDLroNOqvi2mV1rnO
 VgZGVugnuqVNRwHidabDHWDyp6lQIXDZJd5DxvvQyhHPAi3GgRxUWFDZ1OuXgh0LDmO3
 96BzxCBh3MW9sGa04VUP98axfxSfMnTUOX9VkI3CehGtKH6aNM6SS01qOyVggU0gZm0j
 iClxCO4bhKKX0RCHTaNIvpt0sfbX0lZ37oN+O7MDNIfmAaxD6j1ZQuMru4crwD3Clv8Y
 MWepZKyMqnA4M+NMT+NaN49jTRF++Bww26Fk4B7ZZ1Gx171PvgAvBiIUhdY3yEGLbuRy mA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tebjc3f2v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Oct 2023 11:02:27 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 396B0lij000657; Fri, 6 Oct 2023 11:02:26 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3tea4adqqf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Oct 2023 11:02:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ce6sa5HtmPwPFOmCnFHRb/zFVdpI9Yuyi68UMSnQ3P18uPkAQF0cWoceqgRpoIq5GmYpk0kbl03TLitU0THYcb6ezlFfaQp9JUdqIcrdfBFuILqG/6tbmsAR/EYkV2MKA0/zexWMeuTe8IRX4nKct9ySvJET2CfKWCW2lCRyhucS9eA7F6REoncsayQ72+Fb4QXQubfwpHHfUSM2/ANdHKse76MJ+ncEO3XotooJ8wlRlJZ6IN7QhlWbm/eMFVfFNBXCQIIZ4cms1AAWlmx/OFvk52IoIqjm1SyI0DeMoeWA1NVKQ4Ne7tRKug0kEK4oY8kSoxo5io1f9yFKO+nDQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gozMOFDYrp+TbL91FYF4lGvOVN8zrM1rrV8FvpM1U9s=;
 b=YqF8olerV+nmWFhG/QinC7rnB62Dg1XTd6KMJcpTdlpDjkGseCn2YZDULZnCn2CwPHlX0wqHalAtn4oK/4bVwgtmKkNFU4u8GmHgSX2S1/L/9kv/LRuajOprrtxROfLzzN1P18gqRphp4FulMxmKjflq4xGSV0D5/ldd0dLX/Ae6seQCp0HvVvqEPeT62SEGjpd8Iu10ZVW+6VbBcVSsK4RFx7b0jaUm6wIiIUeVANuAIuDBJvGmgU5GMIKYxDLrITv0dtIK+YdGZEQTloyjtRq3xcpo0Siw4ugnbSOX2hmBAHWVSthcHU5ijT5hyCzxCKBJxuWz3xcqtdrwL9l/HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gozMOFDYrp+TbL91FYF4lGvOVN8zrM1rrV8FvpM1U9s=;
 b=l25MkDVGiyfC29MRFBOjJ1DKb+lchNIErebsppAxHwK5YryCHFQSDVsjdGXdqy1enJOyw4ou7+gPGZ10pnshh553HxDSohP1+w2MUsUmBU6SrhTbos47Mc/0CsowmhVj6wx0DcK654GFyP4IaqczegqHy1kSC9Q9KFduG4+L3pg=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by BLAPR10MB5266.namprd10.prod.outlook.com (2603:10b6:208:331::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 11:02:24 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::64b1:cd15:65a5:8e7d]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::64b1:cd15:65a5:8e7d%5]) with mapi id 15.20.6838.039; Fri, 6 Oct 2023
 11:02:24 +0000
Message-ID: <38953b82-a667-42c5-83eb-8493ed4bf597@oracle.com>
Date: Fri, 6 Oct 2023 12:02:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost: Perform memory section dirty scans once per
 iteration
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Si-Wei Liu <si-wei.liu@oracle.com>
References: <20230927111428.15982-1-joao.m.martins@oracle.com>
 <20231003095019-mutt-send-email-mst@kernel.org>
 <6e40003d-d2a6-4120-aa78-de26de088d86@oracle.com>
 <20231006054342-mutt-send-email-mst@kernel.org>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20231006054342-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20)
 To BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|BLAPR10MB5266:EE_
X-MS-Office365-Filtering-Correlation-Id: d01e3080-122f-46bf-8b33-08dbc65bb83b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vosRJhGywU0txdPWuQ5//TeN5EI8Z7MaEvu8T2PUzgkIWsBwmWl6HD7gU6k22oz0+RoZJkTKPBzMCi0kaYPKEGG7g5r+ZQe9Jf1aieXW/ugrd/syruSep7cMaAxqNvV9xHs18ywB84b+kmXONrI2amnkX/xYuejTHck/Ft9rLY9G0WSblG9hA2jTxXiFC46IGuhZnnB4opjLqZFN6NHIXm50t3vRX2hMtSbYTyRqNhlXGn+/uncvDuTGsJWIkyRy2PxmKUtgRq0MHukYXBZToDDSSmAN6GvWCbwfOWcXMa5kZIlmP5GOMYwRu5OOOwlds+wJOeccKE6QR5Dub89oDUSR+StL8yF++zd9bnRcVY08Wt2vGzG4LJEQGTk1bBbu8eAELAdQ+ZuGIT/2LfZifig4AOJl5emT3GDDlSi2aP7BhrVxdwrg9gITgJZ4xtyHYKtNaF49wDzFXeX0zVANuKX+/4SmWN9+fhWzew6ajCjDV2cMMObb4L7h6VVOEYkgKH6WFXH4mqcG+S7hRrVm+LMLnEzqiTRMvPs06xSdfvwEqjsUhdYXS11+KPyrnJ5EZRrfjFpoXIvMSUDnwa0a9do7BgDLPIU2dFrzA+YW4jXfzK2IZzojco7x9xjiaGRKwqkIsDTVS1v76ckpfEKA5lfSeN5FcvwS/miqUGlsTWE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(376002)(366004)(39860400002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(31686004)(5660300002)(2906002)(4326008)(8936002)(8676002)(41300700001)(66556008)(316002)(6916009)(66476007)(66946007)(54906003)(2616005)(6506007)(6666004)(36756003)(26005)(53546011)(107886003)(6512007)(86362001)(83380400001)(31696002)(478600001)(6486002)(38100700002)(14143004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3daVStTT0FBK0VJTzhuakxtT2VXRU85eHRTZzA1VTFtdUk1OS9MUEtSSlBv?=
 =?utf-8?B?ZDdPVlVUelhiYU9rV3huSk1acXhDL0FWK2E0NlVPaE1lRVVkdnlQQStBOWth?=
 =?utf-8?B?OWlRb1E4Z1A5WE9YbHFndVNzTGFHYjIrYS9ibk95OWtSWmNFQWFJOTBwK1g3?=
 =?utf-8?B?QWVLbGFnT0RzTjBnNDFuQTNzMEJXU0dEQXVibi8yTEQvNjdJMVhMNkt4S1lR?=
 =?utf-8?B?ZzdBdXNJSGxzSlltVitTckRHMUk2VEluSGgzRVpFVXdRQ0hSUVpsajZ5WUI3?=
 =?utf-8?B?d3k2ZUhpVW14NDM2QWtxZjhZbHhBbzFYOFoyOGkvbC9MVFNGaXlBOEZxd0F5?=
 =?utf-8?B?NWI1RXlEQjB3UHY0TWtQSmRlZ29HQnVQZThwc0dRdW0yWUpyRXFOMjVmMFgr?=
 =?utf-8?B?Ym0xNXpyeStUdWRHZWNob2kyeFJFN2p1c0psZmVCcDhlSnpyY3FZSk5CUlo1?=
 =?utf-8?B?a2dkQ2paaTFKSHpsRXRsbnJLaytmZC9nK0R5RFJDS2lUR1YzaWNoUGlhL0o0?=
 =?utf-8?B?NkJmenIwS2lOL2czUWVweTNpMkI5YzBZRjFXR1AwOWFHL3A5a0JjZUFqS0JF?=
 =?utf-8?B?akFidHE0eFA0cG5nSlZCM2dNZGdxdHRvMG8zUm0wZjZacTdBK0Y3SUhkbzRN?=
 =?utf-8?B?Szd6ck1PL2MyUm8rZEhIWUVxNEM3WGpQZjdHZ2FTOWdZaFZiaFloRFZwaHc3?=
 =?utf-8?B?Z0NlV1BNSTc3ekpRZ1pKNno0Rk1MZkcrSHE5VnI1bjJSZTdzZG84eEx6VHBJ?=
 =?utf-8?B?ZWNtTTJGWEFhbmdNdUZqc3dhM0V0VUpsckFXSnNvM0xCS09oS3hPM2NUcW1Z?=
 =?utf-8?B?ZU9wbWVrNC9XTWc1Q3lvSUp3Ylp0MUhaWFBJOE56Q2hsd21IM0Nob01uVnpu?=
 =?utf-8?B?RGF6bXFUVHZSTW1zam5zY3Y4bWl2MkFMakhITG1taWNtbmtEdnpaV1FEdW5j?=
 =?utf-8?B?SldJdk1PcFcwYUFueGRMU3QvSUxORXB0eVNtK1RoOUsxYmpXUjJ3dk5ieVlW?=
 =?utf-8?B?TmM4L1hiQ05qT3hnZVptd0FUYjBuNWVKYkprTWNkSnMzOFVFNDhzaWZIQy9O?=
 =?utf-8?B?M0NKREVpTGcwRkxiSzV5Sm8ycHNvZEZ3NE5IRTJEQ3ZoUGRqNVdqTVlJRHlE?=
 =?utf-8?B?L0NmeDQzajRkTFFuMzhHNDYrUkE5bDE2bms2amhVL2xadW5VOXFOVWRJZU1D?=
 =?utf-8?B?RDYrOXZRc0pzYzk2cW9hMm9JaGl6VkNIdmVkdytBVXlSMjBHdHQwTFYrVDI2?=
 =?utf-8?B?RnVNUEYrQXdaakRBSEIwczNVdGVrZTNZS3JGUDY4c3hiU3d4Vk1CMUc1VzRX?=
 =?utf-8?B?SjZpSWU2ZlNkRGQrVE1xdVljL0ROR0FITlBrYTBuZzVZeURuVTNmaHEzOWtr?=
 =?utf-8?B?Rkd5OXUrMmR1K0RYYzVpd1J2ajZYWnpaRzl1a0F0d1dKNHFDMDhqMGx0MTd0?=
 =?utf-8?B?NkR0VzBDRTZwMEQ3Q1FlM3JUeEJMTm92LzdBbDJ6NmxZWnlKYnlTZzZzUExh?=
 =?utf-8?B?WFJhSzFON05TR0JTRERXWk5HMkVWNndna2NxelJrTXlHZ2FpaHdZa1loUHlV?=
 =?utf-8?B?eFpaOVFmOWowY2RacDNLUFVFRzFzMVVjNW11azB6U0R5bFlsQkxYZ0VJYW5R?=
 =?utf-8?B?VU51UVExaHVKRG9rVS9NdWFEWmdhY0UvejJJbnVPZ2s5c0w3OVVmeURVNWlo?=
 =?utf-8?B?STR4REVzRTg2dDlQM0RaS01ndWNQMFF1THUrVWdPTmZnN3NYMlZSQmFCcEdZ?=
 =?utf-8?B?dlY4bzVRdDlVa1h3NU9Ka2FFYXBsQWp3RW1ydnhhUENRRmJEcHFvMThRVkdD?=
 =?utf-8?B?ajJXOC9XM3J0aVBPeHZ2ei9kWElPSEJEdERpc0cxaXoxR3U4dEtZNG5qK1Fr?=
 =?utf-8?B?Rmxnb3ZuKzdHTDkzeFRIL3RBUWIzWm9BL2t3NndXZGNqTzNBN212RkxZclp2?=
 =?utf-8?B?VmtYbGZNS0NNMFZXVWI1c3d5QmJTZis1VWsxMHN3QllySFQyL0VrRmxRNisv?=
 =?utf-8?B?OTZYNmNXam5sQ1lSOUZhTURmUmpzUUROR2pjVU8yQ0pYL3NKd3JqdFA0VHBC?=
 =?utf-8?B?bko5RVNLMElIYnljOEVjNmk5MnVIK2NYN0dEd3pHK0cyUU1IdzVjNzZSUlJG?=
 =?utf-8?B?NDF2TU9QT1ZHa09VdWhyVnFSQXZyVlZVcktRclhKajNXZjZPdkJBYnRaSzEz?=
 =?utf-8?B?UUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aGvgap0VY7kJW4Uyz2+p6+J7Q4E3INDEbPGMNcFa7lvZ5JOmWITcwjw/MT3KK9K66Ql1hy8zVdmlDH4SZT3zeIvEA5o7SiTplkoAGq+dRcwUSEIgyH2y0Qa+1R3mKQ/QvkYumGwXoxngWGgpbFIVyoY3PEzPOJ+LzzE/pdeVF0oGjYzFzfCa/bc6VAVZxB/yTkW9rw+mC0ta+z56FtDE60n/FNP7uUWD+4RhPmnvGp60tsmPqI0Pob8Ytyk1rjhwJ1+E09Dyv+ISU328dU1WVkL2RquFnLt53MlKCC5nmUyWVNVod7l/+e49QWyMZ3o9F41J/wiEvWq4GtXc3kzPAL/H9I80+iCwn4W3Hb4XNDLSpfyaxu8SyVOXASS9ciTt4iSjkz5tt5phC1uk0I8WmrcAqq5F8TBv1WKNZeFIC1PgMCl7nhGXKyskJrD8bbadk9uqCfFN9Xrv+y+89dxvncVMhxEIbgsaTixRGGuq2o8giFwbrsc+S5YrTOuAYvaJJjNNRuzh8Fu9EnvgxeSjnj2TpqLo42yEBziIpm1FArZvwLRTT4KavLOEP839m559ZHjvRAS/lfcMGkmrqRC3To0Ohy4tMU1A7WIZVg/82YW29ignkkzOb9nLjLcG9RJHtwDnP8ef6VBqlgA4jBAetw0nzRzYZiPGh4jgKAeP2KFTV17U/MNsNDm5Hl8mBjbLjg1W0ooaWs+qub7FH5jO5v6BoYqoSfhr4WLrtNGMjdRHw0oj+yM4yiFKgPk798l74BE7PBRiJ253JKX0tDlR0g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d01e3080-122f-46bf-8b33-08dbc65bb83b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 11:02:23.9301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nz2AAlwQyTEgleVR8omrk9/ABfghSzJD6K26W88PTea25OTeBBGY/HWOD3Tx1IH5cIhIDDj60fEFBAUZHDYlGoI5kx3Uo/WkGYSOXwUUW7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5266
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_08,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310060080
X-Proofpoint-GUID: eDfHZ_dCzL6Gv8Y_QnkgzThzuKRTaFlG
X-Proofpoint-ORIG-GUID: eDfHZ_dCzL6Gv8Y_QnkgzThzuKRTaFlG
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



On 06/10/2023 10:48, Michael S. Tsirkin wrote:
> On Fri, Oct 06, 2023 at 09:58:30AM +0100, Joao Martins wrote:
>> On 03/10/2023 15:01, Michael S. Tsirkin wrote:
>>> On Wed, Sep 27, 2023 at 12:14:28PM +0100, Joao Martins wrote:
>>>> On setups with one or more virtio-net devices with vhost on,
>>>> dirty tracking iteration increases cost the bigger the number
>>>> amount of queues are set up e.g. on idle guests migration the
>>>> following is observed with virtio-net with vhost=on:
>>>>
>>>> 48 queues -> 78.11%  [.] vhost_dev_sync_region.isra.13
>>>> 8 queues -> 40.50%   [.] vhost_dev_sync_region.isra.13
>>>> 1 queue -> 6.89%     [.] vhost_dev_sync_region.isra.13
>>>> 2 devices, 1 queue -> 18.60%  [.] vhost_dev_sync_region.isra.14
>>>>
>>>> With high memory rates the symptom is lack of convergence as soon
>>>> as it has a vhost device with a sufficiently high number of queues,
>>>> the sufficient number of vhost devices.
>>>>
>>>> On every migration iteration (every 100msecs) it will redundantly
>>>> query the *shared log* the number of queues configured with vhost
>>>> that exist in the guest. For the virtqueue data, this is necessary,
>>>> but not for the memory sections which are the same. So
>>>> essentially we end up scanning the dirty log too often.
>>>>
>>>> To fix that, select a vhost device responsible for scanning the
>>>> log with regards to memory sections dirty tracking. It is selected
>>>> when we enable the logger (during migration) and cleared when we
>>>> disable the logger.
>>>>
>>>> The real problem, however, is exactly that: a device per vhost worker/qp,
>>>> when there should be a device representing a netdev (for N vhost workers).
>>>> Given this problem exists for any Qemu these days, figured a simpler
>>>> solution is better to increase stable tree's coverage; thus don't
>>>> change the device model of sw vhost to fix this "over log scan" issue.
>>>>
>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>> ---
>>>> I am not fully sure the heuristic captures the myriad of different vhost
>>>> devices -- I think so. IIUC, the log is always shared, it's just whether
>>>> it's qemu head memory or via /dev/shm when other processes want to
>>>> access it.
>>>
>>> Thanks for working on this.
>>>
>>> I don't think this works like this because different types of different
>>> vhost devices have different regions - see e.g. vhost_region_add_section
>>> I am also not sure all devices are running at the same time - e.g.
>>> some could be disconnected, and vhost_sync_dirty_bitmap takes this
>>> into account.
>>>
>>
>> Good point. But this all means logic in selecting the 'logger' to take into
>> considering whether vhost_dev::log_enabled or vhost_dev::started right?
>>
>> With respect to regions it seems like this can only change depending on whether
>> one of the vhost devices, backend_type is VHOST_BACKEND_TYPE_USER *and* whether
>> the backend sets vhost_backend_can_merge?
>>
>> With respect to 'could be disconnected' during migration not devices can be
>> added or removed during migration, so might not be something that occurs during
>> migration.
>> I placed this in log_sync exactly to just cover migration, unless
>> there's some other way that disconnects the vhost and changes these variables
>> during migration.
> 
> The *frontend* can't be added or removed (ATM - this is just because we lack
> good ways to describe devices that can be migrated, so all we
> came up with is passing same command line on both sides,
> and this breaks if you add/remove things in the process).
> We really shouldn't bake this assumption into code if we can
> help it though.
> 
> But I digress.
> 
Regardless of what the guest is doing, I was more talking about VMM. This wasn't
so much about backing the assumption into code for the reasons you just
enumerated but (...)

> The *backend* can disconnect at any time as this is not guest visible.
> 

(...) more like what can lead Qemu to disconnect the backend.

I guess I am reading your comment as backend being the secondary process on
vhost-user (or vhost kernel thread) can just disconnect voluntarily, regardless
of what Qemu might be doing.

>>
>>> But the idea is I think a good one - I just feel more refactoring is
>>> needed.
>>
>> Can you expand on what refactoring you were thinking for this fix?
> 
> Better separate the idea of logging from device. then we can
> have a single logger that collects data from devices to decide
> what needs to be logged.
> 

OK, that makes sense. Presumably, such logger abstraction would be aware of all
the different sections from all vhost device representation, and it scans
everything related to sections. VQ might make sense to still be part of the device.

>> My thinking on this bug was mostly to address the inneficiency with the smallest
>> intrusive fix (if at all possible!) given that virtually all multiqueue vhost
>> supported QEMU have this problem. And then move into a 'vhost-device for all
>> queues' as it feels like the problem here is the 'device per queue pair' doesn't
>> scale.
>>
>> At the end of the day the problem on this is the vhost object model in log_sync
>> not scaling to amount of queues. But you could also argue that if the log is
>> shared that you can just log once for all, plus another one for each deviation
>> of normal behaviour, like the points you made in the earlier paragraph, and thus
>> the thinking behind this patch would still apply?
> 
> The thinking is good, but not the implementation.
> 
Yeah, I got that from the beginning :)

