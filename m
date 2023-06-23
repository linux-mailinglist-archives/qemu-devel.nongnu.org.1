Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A1173BE5C
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 20:26:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qClTJ-0008GJ-Bj; Fri, 23 Jun 2023 14:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qClTE-0008FX-9X
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 14:25:20 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qClT7-0006bZ-Bm
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 14:25:19 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35NIO8kj002492; Fri, 23 Jun 2023 18:25:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=RmijTJ/xT+HKgI/8jrOml/XJgPjeAIvlBB6HqW8lvGA=;
 b=jO57CqvYPvIsCheXimcfZiIOuXuPQF5C21U2NvacC5/GLHkffcBig/Qu1xC8JbyPusHg
 MtamBqEDNUWCsAcplesxF732RNZFYaXv/iQT2j/P/e5mgWB11xwbMdRnpVWgXwgN44Ie
 1C8qgIau+zMUJ/VZkgbCH24xyzfJp10qk56u3gl5spEdaCAeUtBpuPxLCWkRVWnTZ8pw
 Rwktap5h+GvpissOkc32CMJylIc2Wi8XaVCc/VCFhURBSan/RPLfmZdRfj0DoMHnahJs
 tspAwkH+PzieELYMimSCWgNFaIuOo8YNLlo8qYZD+qQ6LkTMp3erBC9be5BuDtH6A3+W lA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r938dvh4e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Jun 2023 18:25:11 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35NILDMA038732; Fri, 23 Jun 2023 18:25:10 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3r9399f9q5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Jun 2023 18:25:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYkfy7SRbhTmwbjgQorbu4ooCP7FC7iQxuUPyluj3ZjdveV8mQw9cSUHgjRFIs95Xajur3oe+IqkU7Rt92WSzh5PKtYx4Rn6maOhs53qP85Z3cjNDOSif1cSGirvm+ThlEpCdz9MJCO4iwGRt7w+ipCaw7fAk7jIoTH6SZQRqR166bX9seOcMt13cQX5pFCiJzI4E/8apIITmrAe7cYqXWdsN/rjO+ZfzdCmyplmD2mBXCQdloe8xOU2Y6CtgdUls6BN+QdnZKoWRtwYcb6CHO3nVpxn0WvMVf0Fgrfyusc2BoctwhWU/kNialeGJB3u+EUTEPCO3BFXY/5TlJq+Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmijTJ/xT+HKgI/8jrOml/XJgPjeAIvlBB6HqW8lvGA=;
 b=X87sXvUadzRqNSIQ9wQBcDzoUHEsqGt2advOdSNkusyWfXdlovVqODoO8tmd/sfwySV4KUZJBmV+6CtCgY8P/LxXyPvBOSXnXKQ6eEiaIjGnH+bSX6ASvhWZ1zS24XQaCxdrCpdL/SOYhjLz11afEmYOtyxWo9tQrzO7hSNoxF0R3Mlxj0wQN4+cITMcR16im7TEks6rbusfGXrd4OtLcCoS9VNlIrTPj4fPqVTChBmpkX/aHoZtkQ9km+YtKiwG/8mbRSs+Sy6hAHyERGnH7EEee25Aq9Li48Q8/vJe6PHPviKgpb5tE35j6hmC7O9kBxUz3X7MkKvhmQc7CjB57g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmijTJ/xT+HKgI/8jrOml/XJgPjeAIvlBB6HqW8lvGA=;
 b=CWTHtyP0GSb01yTBE06nSim/dJIBaPTMTA1CMwobCAudpambbFMn/kuKeKd63GhrMDvt6BAg7K8I9x+ZLqoeWFr55fJlZdWg2px8glhTJmmsDIG/+qy3mzkp76EVRSRyM2Q2Cevo24E3intumL9W1lMtOC7QgeHE+wuWltvbkbg=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SJ0PR10MB5768.namprd10.prod.outlook.com (2603:10b6:a03:421::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 18:25:08 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::2743:9347:3bf1:5f11]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::2743:9347:3bf1:5f11%6]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 18:25:08 +0000
Message-ID: <340b5f58-0924-6f8e-6f82-0462a5cc22cc@oracle.com>
Date: Fri, 23 Jun 2023 14:25:05 -0400
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
 <ZJIeR7svXvtHdgs4@x1n> <6adfae20-60fe-ae08-1685-160b2a1efab5@oracle.com>
 <ZJNdcyrv0TzFUKMy@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZJNdcyrv0TzFUKMy@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0071.namprd12.prod.outlook.com
 (2603:10b6:802:20::42) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SJ0PR10MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: e6fe531a-c40e-4493-0cd3-08db74172c79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cUmANlvFC6vJ06LjS8zk5WaQqLR1UCPuRHMmKTpiTTOqEuov0kS+LlBXOMEr5vdYlnDdYz09/7Xq29BygKNQUn+ev4gfTEgzivpZuXYdWYRUsEt3tuJui/HNQWPaCBccdrO8LF8yhtYi5PN5PH4rlxqlBMAd3VIwbIK4LjRWTHYeHcKmAJkxskS/5uskzM7I3F+3vNt+dqmvV+jZe5BnkISa5XAwbMJIIb8KBMmeGzoFWPhV15bBMWRD6/TtbMgba+1ycz/FxfHaLr/GYcYvwPIMVoOLOP1pnzi36wTedgGKX6pKwNcsujUFR/gyWHKXAz/WsAp/mglvOEPdxGN0MN3eedOdeqRwoL+pzvrMvwE3xlDRAg4MeFwiLKXzo9d3DLyaHaUJQKID5dMwAgwqdrSCVkLeoXayRA9HV7PItkSki4AW2Ygg7YLJ+ApK4ryFu6Cgv+c4suryfTeNg1TqFuHlnF0XOPicsFYpVYSFCWaTUxoRIwlDImBifqMoIX4YX1GLLQcMS3Rq5shWaMR+SRjSqiRigX4nArGxyeJxetiTeMVO8ZsbDB/rjDzthYtfQaKP1xotEZ/+BhFe4ovraZJkTNM0RTj163zd4PNY5J1lgIZ8PSRwwNkSgvaEY1y3+QPhzLh59wr5NDJEAJyZog==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199021)(478600001)(15650500001)(31686004)(53546011)(83380400001)(26005)(6506007)(41300700001)(6512007)(38100700002)(2616005)(5660300002)(86362001)(4326008)(66556008)(44832011)(54906003)(66476007)(66946007)(6916009)(31696002)(2906002)(6666004)(8936002)(8676002)(36916002)(316002)(6486002)(186003)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlEyc0hiMmVWbTNQbWtLQlZZTStHRFEvTDdIU0FKbEw4Qkt1N2svczVmL09U?=
 =?utf-8?B?ZGNIOURUT2pLelAwLzdZejJaR3luSml2OVIyTEFDZXRNamRGdG83WHBiVFg5?=
 =?utf-8?B?cS9oRlQzS3lHdTNadStRTnpGVFpOU1JCOTFnakZhMFJ5NWt0eGlMQlZpRHZh?=
 =?utf-8?B?c09mbGZLczNUL3lFZ2FMYUNmNkQyUTZWSUIyUGhHcU1TU2E2K3dLODQ0UVhw?=
 =?utf-8?B?TTJjcGZxZ2dFa2dTT3RiRlNWTmxFcm1ZWVJsQkM2dGlFVzFoSjNQQ1E4RnBo?=
 =?utf-8?B?WnhBajBHbU1GZ2NVeHdkOHZyWUNsUU5SZkZYQnhuaUsvZzIrSC9oc2Z0ZzRo?=
 =?utf-8?B?VEI5Q3NENlZjSG15RmczejgwV2F4WVFBcDUvVXNma3MzVkFIMmZPU2dxaGpB?=
 =?utf-8?B?UlBNZDl0RUdodlJKVFB2MFp5VXRoZFpjQ2kvMW0xZlZvakp5YmtQeEJ2RVlP?=
 =?utf-8?B?WmdOWnQrR3NJWHF5OTRybDFVeDhMWE9SMVZueWZNcnhMT1BkRHY4Uk5DbWNk?=
 =?utf-8?B?VjdVZ2o0dG5FS2swamhVeXU5cUF1eFRMcmJ4YndwN1dJSVpqNk9ZS29hS1Bu?=
 =?utf-8?B?dFhRK3luaEUxR0wxbXJjekhBd2JVdEtUdWx4VDNLaDhobVNQL2Y4WUdtaHNR?=
 =?utf-8?B?ZjZzSVVtbHlCMjNOd3Z1Tk9razZJMjVHdkZzWWlpNHdhNzZNNUk3T0RkMkN2?=
 =?utf-8?B?L2xpcmF4RjBDR1BCL1ZSaDE4MEF3ZjBETzkwTmc4M01BbUcwUnRqTGJDeUQw?=
 =?utf-8?B?bFZXUnh2L1VxZnFNbFBjV1N5WVBZdHFCbVBHQzcxdUpMK1kzYVYvT3Z0bGlU?=
 =?utf-8?B?cllnUmsySGF1YTQ3ODRrVlQ0WnJGbWJHQitEN0EzMGM5Z0N0M0FSbVFRZVky?=
 =?utf-8?B?ckxSaXZzYlNoQitZN1A5L3hFRzYvM2J0TjRXU3FDZVNvNEFXVlhlMWJjcFJV?=
 =?utf-8?B?UHBzOUw3YTNmWEIxd284NVoyOE5tclV5Ums2ZkJrdkxVc0dQWURmQ2FHeUM3?=
 =?utf-8?B?R3hTanhGbTd4UlBXRGNrTlZWNVZyU1Y4cmtlYWl3MURacERHT2ZOeXJpekFO?=
 =?utf-8?B?OGM5Ly8vaU5yWThJOVljWDY3MURkQ2FJRmtSNnlxdHRNS29tY2xCRytSb0pJ?=
 =?utf-8?B?ZjRRbFk2N3BmSHlJNXRZMFh3RnE2OHdoNzdiNjl4Q2NrZDRQTjV6b05CNXkv?=
 =?utf-8?B?ZUJzai9NQkRoM3U4VFFGb3BaM0ZLQzd5Y0lBMHR0S2JTKy9WdUp4WXFLU3pR?=
 =?utf-8?B?UDBlOWVTQzJaWUVQU0dmQWd6NXEySTJvOTU2d1NabStTaFdaVFBKQjFvaGEv?=
 =?utf-8?B?NlVpOWxSOXlmSDJ4Y1hFYWZIcHFKNXVLS0lYc2dFM2Y4UnJDbnpYNy8vcjJB?=
 =?utf-8?B?Zml6YW9GWlNjZGdYSW1SNG1Gd3FuR2JvSm4zbmM4SWxocW5GdkwxRU1Jemtk?=
 =?utf-8?B?QnZ6WVR1S0RQY1ZOclIwS200VHZmbnR1ZnZkek1KTzQ1QzUreUh0eVFTbnpT?=
 =?utf-8?B?d29WNmthUXhNRXhTMktoZzJjanVvWmgzeERBeUtTTENKM3pWdTN4N254VW1C?=
 =?utf-8?B?RzdsaCtGcjMwaGt3eVZlRUJtZnorQTZER0t2NTFTaTFtV2pBeVFrYjZ0Sm5O?=
 =?utf-8?B?YXF2dnBjR3dIN1hVdkY5QlQ0TXhPYnErZDI5NVFySXNPbTV1Y0YvYXRDSEYv?=
 =?utf-8?B?RkpvZGNKTER4NlFIcVRRWTdQVzJKTXEvVENyb3dHb3R6MlJhYURMV0R5SzhR?=
 =?utf-8?B?QlZZa2w3Q3MzTTFVaC8xNTVhQ3F1dEJhQTIyQzY0Zmo4VW9xYjdwdVAzZnZO?=
 =?utf-8?B?c0RoZENES2tSSm9vM2xublJyWHBHbFNBVlFmY0p0V3BnRzFmQ3lvVTJURU8x?=
 =?utf-8?B?VGRMNlhhUWlhVElxNWV6WUdKL0RiTXAwR3pETFZBM0RZemx3Zk4zWG0wNUdX?=
 =?utf-8?B?cEhiRDJsaTZUQVpQWWhybmJocVpIOUFHVVYxcGJZV213SzVXbDVCNCt1WnYy?=
 =?utf-8?B?VHlmb2hMUGlDV2huMEtrcTFjL1o1b1FaYkVWMlJFZkJMTE95K2dBZTVaRDA2?=
 =?utf-8?B?STRMREdtaGd4cXRuUHBjWE9wVTZrMTRJMnEvd2x2Ym1vT0t6MHB6KzlFck9E?=
 =?utf-8?B?eUc3b1BHTERrZDljdUJYcEtlRkp0TWZtSE1RaXN3TWlwbHI5ZnczbFlLdEZu?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FaPvea0j/AlGREU5CQ7PNmK5FLdnk5YQC0hJk1eqAT1ng+jfkmfTobubcoHvbkFMWdqregRbAmr9c7h4hbAesVTFsECTXxxJ/LQjEXrQqPyAti209Yl1pYUB0EQDkw6EgZqyPZnb24dozXoAM0OYXLr0Ef8mqZmR4OsBklxyuobuMNFl+7YgEOMmdeHFlRB9Puscys4M1jtANP/MSkgBeAL8Kz5Ux0sJMRZfDYkOG0f1QouYuBfc1n2DrowWpyl+YsrpuyYVxTC0VFHxrCDtI9DSCFcXLGaLFIWcvqB8aqkU91kx418I6ebviGPyYCj5/xQ6TX2FMGwT07/ar4mr5+89m1I8cRLYSryktQ7KXRgwLX4KmJLkOQjGipQf/c698BBErsNn5QodU4RYtjI4CJjszxBidEEKBpTaXtYXAL6nO5d7KWeEzHC0yrhwcpJhfHLMxaVKYK12wu1fGcNcpcr/Fzx1nNF3jphY1w/HJOLkJKKx6vusZe5PII76Czb+6bEWCgGnJI+cYXjF4dBIXfmSDqI8cepI3ygy3rJ1dQ56I44YWcF3jPjPHQgFtG0fY04KtoQ6A3j3yXfRM56KumRzWesCH2T+hCwQFbDZNbx18by5824RHFZ7HD2OJ7a4Fgj9O6gE90FaqVQM5rFLrTuEtqGvYQMSf4Ze35FZkF4IHycQ/dBc7XBLAu6pCTj2y0Z6b8X7O4WeXyrWycos5bJTTrfUuwR72My3Q+EDuc7jKUObLkfUNSXumw1IUAVncnqMqc7g5fB8Xu9ud27DAw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6fe531a-c40e-4493-0cd3-08db74172c79
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 18:25:08.3530 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4iiYKUQtRBcu0FEDDw8gGoL5jWWPZwg4/1jnTx5O/NOkNSoDykAhUskkrtUPDvGnCCiLskpAH6IXLt1cN0aLpT38qt4N4KExbmNmb/rtzAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5768
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_10,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306230164
X-Proofpoint-GUID: 0t9zblIES6x61ybih8hSyTRO6u7gl2zl
X-Proofpoint-ORIG-GUID: 0t9zblIES6x61ybih8hSyTRO6u7gl2zl
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/21/2023 4:28 PM, Peter Xu wrote:
> On Wed, Jun 21, 2023 at 03:15:42PM -0400, Steven Sistare wrote:
>> On 6/20/2023 5:46 PM, Peter Xu wrote:
>>> On Thu, Jun 15, 2023 at 01:26:39PM -0700, Steve Sistare wrote:
>>>> Migration of a guest in the suspended state is broken.  The incoming
>>>> migration code automatically tries to wake the guest, which IMO is
>>>> wrong -- the guest should end migration in the same state it started.
>>>> Further, the wakeup is done by calling qemu_system_wakeup_request(), which
>>>> bypasses vm_start().  The guest appears to be in the running state, but
>>>> it is not.
>>>>
>>>> To fix, leave the guest in the suspended state, but call
>>>> qemu_system_start_on_wakeup_request() so the guest is properly resumed
>>>> later, when the client sends a system_wakeup command.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>>  migration/migration.c | 11 ++++-------
>>>>  softmmu/runstate.c    |  1 +
>>>>  2 files changed, 5 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>> index 17b4b47..851fe6d 100644
>>>> --- a/migration/migration.c
>>>> +++ b/migration/migration.c
>>>> @@ -496,6 +496,10 @@ static void process_incoming_migration_bh(void *opaque)
>>>>          vm_start();
>>>>      } else {
>>>>          runstate_set(global_state_get_runstate());
>>>> +        if (runstate_check(RUN_STATE_SUSPENDED)) {
>>>> +            /* Force vm_start to be called later. */
>>>> +            qemu_system_start_on_wakeup_request();
>>>> +        }
>>>
>>> Is this really needed, along with patch 1?
>>>
>>> I have a very limited knowledge on suspension, so I'm prone to making
>>> mistakes..
>>>
>>> But from what I read this, qemu_system_wakeup_request() (existing one, not
>>> after patch 1 applied) will setup wakeup_reason and kick the main thread
>>> using qemu_notify_event().  Then IIUC the e.g. vcpu wakeups will be done in
>>> the main thread later on after qemu_wakeup_requested() returns true.
>>
>> Correct, here:
>>
>>     if (qemu_wakeup_requested()) {
>>         pause_all_vcpus();
>>         qemu_system_wakeup();
>>         notifier_list_notify(&wakeup_notifiers, &wakeup_reason);
>>         wakeup_reason = QEMU_WAKEUP_REASON_NONE;
>>         resume_all_vcpus();
>>         qapi_event_send_wakeup();
>>     }
>>
>> However, that is not sufficient, because vm_start() was never called on the incoming
>> side.  vm_start calls the vm state notifiers for RUN_STATE_RUNNING, among other things.
>>
>>
>> Without my fixes, it "works" because the outgoing migration automatically wakes a suspended
>> guest, which sets the state to running, which is saved in global state:
>>
>>     void migration_completion(MigrationState *s)
>>         qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
>>         global_state_store()
>>
>> Then the incoming migration calls vm_start here:
>>
>>     migration/migration.c
>>         if (!global_state_received() ||
>>             global_state_get_runstate() == RUN_STATE_RUNNING) {
>>             if (autostart) {
>>                 vm_start();
>>
>> vm_start must be called for correctness.
> 
> I see.  Though I had a feeling that this is still not the right way to do,
> at least not as clean.
> 
> One question is, would above work for postcopy when VM is suspended during
> the switchover?

Good catch, that is broken.
I added qemu_system_start_on_wakeup_request to loadvm_postcopy_handle_run_bh
and now it works.

    if (global_state_get_runstate() == RUN_STATE_RUNNING) {
        if (autostart) {
            vm_start();
        } else {
            runstate_set(RUN_STATE_PAUSED);
        }
    } else {
        runstate_set(global_state_get_runstate());
        if (runstate_check(RUN_STATE_SUSPENDED)) {
            qemu_system_start_on_wakeup_request();
        }
    }

> I think I see your point that vm_start() (mostly vm_prepare_start())
> contains a bunch of operations that maybe we must have before starting the
> VM, but then.. should we just make that vm_start() unconditional when
> loading VM completes?  I just don't see anything won't need it (besides
> -S), even COLO.
> 
> So I'm wondering about something like this:
> 
> ===8<===
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -481,19 +481,28 @@ static void process_incoming_migration_bh(void *opaque)
>  
>      dirty_bitmap_mig_before_vm_start();
>  
> -    if (!global_state_received() ||
> -        global_state_get_runstate() == RUN_STATE_RUNNING) {
> -        if (autostart) {
> -            vm_start();
> -        } else {
> -            runstate_set(RUN_STATE_PAUSED);
> -        }
> -    } else if (migration_incoming_colo_enabled()) {
> +    if (migration_incoming_colo_enabled()) {
>          migration_incoming_disable_colo();
> +        /* COLO should always have autostart=1 or we can enforce it here */
> +    }
> +
> +    if (autostart) {
> +        RunState run_state = global_state_get_runstate();
>          vm_start();

This will resume the guest for a brief time, against the user's wishes.  Not OK IMO.

> +        switch (run_state) {
> +        case RUN_STATE_RUNNING:
> +            break;
> +        case RUN_STATE_SUSPENDED:
> +            qemu_system_suspend();

qemu_system_suspend will not cause the guest to suspend.  It is qemu's response after
the guest initiates a suspend.

> +            break;
> +        default:
> +            runstate_set(run_state);
> +            break;
> +        }
>      } else {
> -        runstate_set(global_state_get_runstate());
> +        runstate_set(RUN_STATE_PAUSED);
>      }
> ===8<===
> 
> IIUC this can drop qemu_system_start_on_wakeup_request() along with the
> other global var.  Would something like it work for us?

Afraid not.  start_on_wake is the only correct solution I can think of.

- Steve

