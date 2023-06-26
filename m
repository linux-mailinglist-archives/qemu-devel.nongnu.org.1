Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D333A73DBF2
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 11:59:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDizq-00087o-HR; Mon, 26 Jun 2023 05:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qDizn-00087T-Qr
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 05:58:55 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qDizk-0007X4-9p
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 05:58:55 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35Q9ckPD002079; Mon, 26 Jun 2023 09:58:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=U4BzKMil3CMTsJejbCoT6AvLSwfn5L4U59eoqop5WmQ=;
 b=UE8TRsR5cN5FZNgq7TEwkiIy6lIkN6Cn3BLB7ownW0X4cC5OBsyXEkq5SRsUybp04QP0
 F+XDCF1fS3VyEHVAZQH31ZERUZU/xqayEbLJukh/kLuVJPqFn6m2/kqvjev1189KtV8W
 FSLmhppLR9U8aU0f9W72+4z7k3pp6QCq89ZMFvcKMP6tOviY2TRccrnxTHcs/mmXn0Op
 vEOxH5WjfsPACmZZ16llnxBR1UAh/HkM0y3jHZT4us4SrvB1C5zsZKYeMB05Ct5ESvu0
 Nmcao8chLHGCCmN85kvFzmo7o4T7dNqZgGVIOTGcEMLSUpcBm1AZ0QLiF3a882Fji2sb /Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdrca267a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 09:58:46 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35Q9Lakx028284; Mon, 26 Jun 2023 09:58:46 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx2vcjy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 09:58:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PF+FkJZEY9mF3S8Wme+8AQBbV6WWDxc774v2mSfC61ewET/qeviOt5TQsPcyVWS27L1EcqOEkUJG6Yhd8jqjPof85x0Z4/TvzJMW+W30r92473BnRjH3y5y5SdWrxqqzn2wmWEhIg+Q+9QqmrNqWSONlXFVfTXZ4g8tR88HVli2WYkPxgKSEnSo54+DsGcxwopdaoGF31X0FdyXVUoGl57svjNzxKQacIr85FjpiEcRWd7ZWnGZsEoC8Jbj98wWACJhXTW8Dm4k+oj7sDi/is1Bn5knK3SCBcjX/2iERgwjoQd8Y0cLHe6GC1D8g08DpRhaNo8SofrhAOymtvg4iaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4BzKMil3CMTsJejbCoT6AvLSwfn5L4U59eoqop5WmQ=;
 b=NbgnY0qbRQeYyuN6OT1YFRLDsQj7gSl4rNMNl/1viqe7xdx45VJxGS6wWPolx4vKIfURcdZNcfmQplySMDJQKSA3D7N/sSMNodTAlqRwl+EnlbmWDMvftWQeLILfxb9ZoAzEOEmDuLN6If2PQGAVNjtPzH37SSBAWA1mLVSmVCxvxXwENRkwfagLkig3Ye4DDUM9Jg/x0Z4n7S94v+6Ylmjef+mTyB0W5i6rmlXUHJoeDB8kz9cbMFNa8cyRnhm2rYbSvlITE1O7vZrjMBhpC5tYdYzCY77WiSdtmhvQdrE1PVzmrG/YIIgNJ0boMka2WYqM6cY53fKpfJ1G7/PkwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4BzKMil3CMTsJejbCoT6AvLSwfn5L4U59eoqop5WmQ=;
 b=tLHHeOMjNxP2SH2q/YTa/NnFZNi3lCJNLwJoQ5KgA6+Rc2JT/6pqnV0VNLno98CsfUq3xv9AdJAhcBK6velhkB0DTY9AmUVnxuZwSW73jr0dADckAmauV1PPV7o7ziPc03KcfuZqMTZhI5/LYxPJCvZdl8aK4rm1Z4ZW7w4s9xk=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by PH7PR10MB7783.namprd10.prod.outlook.com (2603:10b6:510:2ff::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 09:58:15 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f%5]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 09:58:15 +0000
Message-ID: <6d028624-beb9-c372-60f0-4a5559bae332@oracle.com>
Date: Mon, 26 Jun 2023 10:58:03 +0100
Subject: Re: [PATCH v3 2/3] vfio/pci: Fix a segfault in vfio_realize
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "avihaih@nvidia.com" <avihaih@nvidia.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20230621080204.420723-1-zhenzhong.duan@intel.com>
 <20230621080204.420723-3-zhenzhong.duan@intel.com>
 <6a2dc503-34a2-a129-3932-ab9cd61cf5cf@oracle.com>
 <SJ0PR11MB6744C00029419ED5B1E7CF4A9221A@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <SJ0PR11MB6744C00029419ED5B1E7CF4A9221A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:3:17::33) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|PH7PR10MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c1b643d-bd3c-4fb2-3174-08db762bdc07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uz5NYoz4ekcOUYUqNaoiKNtX6w4UHw5u2inal9JRS/KdIHeWUweQl6oufXToYm2nDVoM3YbeqKFXdZgOLzWPchJD0xJ4RSdi5faJtDUIDpcPFHf5ArXlcYrq6LU/59OrnzaHzlEnmwiIyoc7Rv5AUwoQemleT1ecUAWV3EO06UwRglnIQyO2d5tEvaeHmnVRUrpK6LjPYVZH+onQaV6R8iVrFgHZET2MmkIC3xxiNJ/m35APMSCgyyzZgm1LMXjMvQMHQ80GmjPHuy5tjSZ6+0b4aEC/SlTXUybVKXWQazXqaeQqUjD6qKrYVUO13YTBLyBPIlNJqF85DYrI/AMVXsM7JHdu9BvMHWC9AzRUVb7t17ozxzXoIODjlPXiSUu13cxJ1To3Zlu/VDuo816A1KGlqWYtDb1w2zj67is2ceV7202GnDGIyKK0Af6x3yNezP5qdFtC8YmRDWJb6Lg9wTQTUIKXjcqqBxB4xzTUZqAU/bUb7k7ncVDv2cJCpTMm67QlbE+VE55alcDhdVn2kepqQ0y5jmE5xuzLtbKiv8/g8AhGfsoJTlvOFgTqIqtjqdQUqPyyAkqWRpMfHm7v0KXNH8jCSUh7hKt/Wdx1oX9U+SRfPeq4AZTvWgrF0OsX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(396003)(39860400002)(136003)(366004)(346002)(451199021)(26005)(2906002)(186003)(2616005)(38100700002)(53546011)(6512007)(6506007)(5660300002)(83380400001)(8936002)(41300700001)(66556008)(66476007)(66946007)(8676002)(6666004)(36756003)(31696002)(54906003)(478600001)(86362001)(4326008)(6486002)(6916009)(316002)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjVla0ZzdVlSSmpQWnpWK0lReDljQlBYeXlxUTZpdys2cGdGTGZTL2pKMnBm?=
 =?utf-8?B?dlFQUWxFNlFWeEZMWW1IZkNEVDJrQmdtOXlzQTlWbWpSMmIxd3RnbCs5UTkw?=
 =?utf-8?B?elNsbEN1V1k3cmxLMzVGUG8ydTIyblAwYWpyVllNQjl3OTZnVnlTNnBPRGlZ?=
 =?utf-8?B?enllZHVZTVRwd3ZETGMvV0VvUUEyUDIwK3JaUTlSdDAwNjZRMkFUNzNFelRl?=
 =?utf-8?B?Y1krcUU1TnJ3VGhhTmN6ZS9QcHpVMzQrQzJSSko1LzNkb0lSd0FtYTAzUzNF?=
 =?utf-8?B?QXdIUExDcGlNamNrNXJjc0hJSEpSaXAvK0dscDJKZWJvN3VCK2VUNlhZV0VI?=
 =?utf-8?B?YWR4aTh0bElLblc4U2F4MkJqeW5JeWNaeEpsWUdHendRUUtmdVdzVWN4MHQr?=
 =?utf-8?B?OFkvd1c3MzgwbURzQ3ZrUVZwajFhY09oY0RBdGh1MFhvSGorUE1IeVArUVJH?=
 =?utf-8?B?Zm45aElaVFhScDliYnMvbCtIOVRwc3BpcFJGTGI0SklLKzk5cFUzTEFpaWtY?=
 =?utf-8?B?ZnZhUHRpQ2xqRkozdGJIYjh2UDhrSUEyMkRJRUpWUEhEazZRWUtJbStON0hy?=
 =?utf-8?B?SGFIUlRxbGFxOE9UYkxkODVxV3pjNkFKdEMrK2lYUlErOEIzR3I3aTc2Z1I0?=
 =?utf-8?B?endqZ09vR1NaMEl3eEdXZTRqVFg3ZGkwMzgwQ0RSOUtPVnlxZ1Y4QUVIcFgw?=
 =?utf-8?B?QXJYSVBrY1Z2MnRJbWlGdDFGZWZIWEorSEpzdzg2QVdrM0NJRHFBa1dCdisw?=
 =?utf-8?B?MTJTNnRPM2VJMGRmWEt3b3hRTzJrdVg4cGlFQ3hmb002bzdlWEpvY1lKTThk?=
 =?utf-8?B?R0IwV1ZBQ2xjTklBcEZxOFBCdXVuRGdWZVN3Y3hVSVlZMkNWdGFkODRTT2pX?=
 =?utf-8?B?Q1IrR0dpMEd6WkNTTFBrYk1oTE5OWXF6a0lGcVFhOHRhNFRNRkVVVUJROVV4?=
 =?utf-8?B?OVF4UDBYM3l4YjJ4a1dYejJnQVczZTRtTDR3R0trZEdwTXF0V3NwaDhlejUy?=
 =?utf-8?B?ZC8wME5IWERmQ0RNdW0zelZzR1VpOUJURTRiWlhaaGRmZDIvVTh3Um1HUjRq?=
 =?utf-8?B?NkZLMGVPa00xRXROWHQ3dXFzdk9RYUJVeDdMY3hTTEo4Z2JSWHV3czUvaVlh?=
 =?utf-8?B?YVpXMjRrL0ltb0dLNjRtZlVNYm1lQkRMT0FRV0Exa3kweWlrTnlMbkZELzRU?=
 =?utf-8?B?VkNHWWUrNHFVd2p3ZHkxNWVldXBsSE9ZZ3dIV1hYRmJiMnY2RTJhZmYyQWxG?=
 =?utf-8?B?aUVUWnh4SHVtYVYzN1VSL1pkcm5OdGwxQkN5MVduNCswR2VZcXFGZUs5VTYv?=
 =?utf-8?B?NkFrdmFDZldqcHdkZlRqV2xRSFdLUk43NFNkY1JZUVAzY1lWZHdGU3htcFl2?=
 =?utf-8?B?Z3BaWkhYcHBPRDZUSjFpNnFZNWJsYmN3ell3TDlFcStDQ0gzNmUxSU5LYmpU?=
 =?utf-8?B?ZTAwMEhVeEppZjN2YXQrcTk3cUFWcWdFRzk3NDAvVU5YbGcrbDVhdXhLWUQ5?=
 =?utf-8?B?TDIrWEVQV09scUlGazVMSHJaV0xHRzBkU3J5UHF3eEg4eGU1eTQvdWRrSDVa?=
 =?utf-8?B?SXdUSzRBTjJ3WjI3RzBLYldaN0toVFFtR0JHNXJnZGpIQmVkc0VZcnZ4SzhQ?=
 =?utf-8?B?ZFh3cURqdWNUdUR4clprL1N2dHhCTWtic0MwWGF1cVFSODRib1FpNkE2cEhv?=
 =?utf-8?B?cTFGbmxDZTJKU1F0WlFsKzJDMzcxVzYvZXpERHRxSloxNHlrZ0ZqMEVJT1lx?=
 =?utf-8?B?QVZEMVBqZ0JzL093Tnh5d0ZtdWtrdGZ6ZnV1bXlram1leC9NWEdxS3F4WUJz?=
 =?utf-8?B?VUpZdklqVkJuY3VCNVZIVTRTWUxsOE43cEd5UU8rMDV4c2lZY292ck14K2FR?=
 =?utf-8?B?V0NWZ2NQNW81RkloOTRFS0JGdjZsL1J6TUpoay8yVHEwYUVhb004SmlDSlU2?=
 =?utf-8?B?RFhwZFhUOGVsc2NGMXF6cnArVml0N1pGczY0MHU0eFcyb3lqVW9QVmwrWEZW?=
 =?utf-8?B?ajd4eHNPWDhrNVpGZVpNOGczNUVySWRSczdtYW1CdUNGTzJnblNjcjZYVkJp?=
 =?utf-8?B?VURpbzFLOTg4OFRDMkNGbDF4Vzl2MEZodnpMdGp3Y1JybkppVUtuNmtYbzcz?=
 =?utf-8?B?RUFRQXlwUkhvUzQ3dkVKalM5TzNuaXpTTUszckh6ZXRJcFlKRzdHdDRwN2M1?=
 =?utf-8?B?ekE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bSQEWvPyQJDjrBapJ8nYn6n9xP1OJ2s0YDfpekeDBjG698lgYugCWiJ2n8XmmLgFdc7DCuuATHKjPi8TddCFr6M+m5/F6WxB71paVAjXGRJX793VgR1w+XVT+lSQIiOAEQ8/tV9OBcu4CBinWJRo6KZu9d2tiXdJR2ZXigXHqgshUGU5fscXriuy/5pqBOmX6QqFdetegXc2ncSaai1Sgp3uzKj+1nwjxtVVX4zjqRGRHojtwRRM/wZ7mx5v+GkpnTOyn59h/zRs9u1ilpf9zihJxcqyvJ+YALBl9dzok6kgicxcA30WJsz+qb/mONHjgbk/m/NetZL6jADH8RElZlyrhWlLUgrpjD0mbbZ1CpVLsiXXJttbWEGVcdOevarMBSjW+Or6NmQAf0BlhhdCDDQjpJkBAeFjBM1ux2ChwgkQpAe/Qr9XmbDd71dzysC5y0RTiC2n5vzVY91plLhKbm/IvD5ZQeAJWqnA8qqbOgNI1tFkWFHDGCSRU7ICal7nkV/ZdxKcs8/+VwcUF87xedcLW3fzccDOas4Nsb7X+kLMy6xpuyM0+2pvZqPvUC4TiPooOq6jp3/DRj8BnfVIF5dL0wF9Wd8k0wbXRTjR0F3Oa6XjKvZAjCFGcUBi3Ken3StOuKRCjeNiEUgeIQqH8517GeXZyz2E5NW7MWdHRysB7AclKQQomRSMnd0+pTRDJFxo8ocI/5XhYPvRPZ7ChZt7fECwHfpllvyNbRlRb1lES3DpCvS/9zslSpyQOkQcnMETLM2fMFcYreuaM9cL1n+cO5IH4NHyjlm5k40zX1ZE2QvCNyDaKSj+3wE85HoMWDxN4kyApZJTtdATojAp8A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1b643d-bd3c-4fb2-3174-08db762bdc07
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 09:58:15.3366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQQjlruLtjHoa7xFAQtxPzOSERH4zxbEcCA+HMr//6fE+JfScDtEpHxGLlYyvh+wRtJqiTZd9fA2Hw4ydc31dWRyafUMiaOkrO93NT7lnOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7783
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_06,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306260090
X-Proofpoint-ORIG-GUID: eKcbjjfjX2D4oJtT53y2PA8pM1XziYHt
X-Proofpoint-GUID: eKcbjjfjX2D4oJtT53y2PA8pM1XziYHt
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 25/06/2023 07:01, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Sent: Wednesday, June 21, 2023 7:09 PM
>> To: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>> Cc: alex.williamson@redhat.com; clg@redhat.com; qemu-devel@nongnu.org;
>> avihaih@nvidia.com; Peng, Chao P <chao.p.peng@intel.com>
>> Subject: Re: [PATCH v3 2/3] vfio/pci: Fix a segfault in vfio_realize
>>
>>
>>
>> On 21/06/2023 09:02, Zhenzhong Duan wrote:
>>> In case irqchip_change_notifier isn't added, removing it triggers segfault.
>>>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>  hw/vfio/pci.c | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c index
>>> c71b0955d81c..82c4cf4f7609 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -3222,7 +3222,9 @@ static void vfio_realize(PCIDevice *pdev, Error
>>> **errp)
>>>
>>>  out_deregister:
>>>      pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
>>> -    kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
>>> +    if (vdev->irqchip_change_notifier.notify) {
>>> +        kvm_irqchip_remove_change_notifier(&vdev-
>>> irqchip_change_notifier);
>>> +    }
>>
>> If the first patch ends up being pursued (which I am not quite sure) it should
>> be folded in the previous patch, as the out_deregister is used starting your
>> patch 1.
> Sorry for late response, just back from vacation.
> 
> out_deregister isn't only for vfio migration, there are some other jump sites to out_deregister in vfio_realize. Take below code for example:
> 
>     if (vdev->display_xres || vdev->display_yres) {
>         if (vdev->dpy == NULL) {
>             error_setg(errp, "xres and yres properties require display=on");
>             goto out_deregister;
>         }
> 
> I can reproduce a segmentation fault when hotplug a vfio device using below cmd:
> (qemu) device_add vfio-pci,host=81:11.1,id=vfio1,bus=root1,xres=1 Connection closed by foreign host.
> 
> After fix:
> (qemu) device_add vfio-pci,host=81:11.1,id=vfio1,bus=root1,xres=1
> Error: vfio 0000:81:11.1: xres and yres properties require display=on
> (qemu)
> 

Makes sense. Let's keep it separate then.

> Thanks
> Zhenzhong
> 
> 

