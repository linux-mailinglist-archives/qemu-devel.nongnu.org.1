Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5513382F80F
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 21:36:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPqAH-0004Fm-Ua; Tue, 16 Jan 2024 15:36:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rPqAF-0004FR-TZ
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 15:36:03 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rPqAE-00041K-24
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 15:36:03 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40GKEC4j013043; Tue, 16 Jan 2024 20:35:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=hi4kOke410xbdAZDUbEg+dYzVXNCaGZGxcGhvnwXWzk=;
 b=Rf7sVO/ZDL6PmfcpgaIpcK+IF4cOx+WR4Wci71vvJTG95kNvgGLq/wiLkHgdj9rI4jyi
 yfMS06Io0kRmgZq1kAVAZbmSD/JvytVgZ4dTRocg9fzsbPDrV1StY16du2T7iz+BRPdl
 iBqDsJkFQlEuWTI8yNacrIYL+5rLryBNXuAYqV/vLbdraRCpC0m087zfyDNewWan3C/U
 t3N1ye4C7uw34nGFigMwftBp0Hn3G6GqNkETIluVWJcjMflLQNfn9AoYIh7KfVi01+pe
 8UHQd2QH61QlOnX0jTeTMn0B6Gv5WC/Q3Py1z2HcXhewRa2h+c7smx0VgB8OOZIAdxgn wA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vknu9nqwt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jan 2024 20:35:59 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40GIsU0h005161; Tue, 16 Jan 2024 20:35:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3vkgyet2ec-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jan 2024 20:35:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOb8lUuttw1cnl9CqQMcOfnODbbtEwNA+MkMbz+aoWiVNuAn9TtK/bS5ugLbnHkiuPoNplVcFaqgyMvO+J8vOlS+Plq/pzzWKGmGe5BUZ2zVDukJR5dt+sz1dJ3vdhH8CYyvuiWn0AKVuZM2uq+0xppss3OnJi9UktJbCBwpM4/qc6s7zyuVsx9Wyh/Yoo5bq0vvLQ9i4eTp4ekYRaiAOFvm9oWQ8WsP2R5xj4PMTjRu2FZi6Y97bezvkdBLQqd3ixZzxBIvkrw3n9hg3PYDw3hMq/Lihqvq+3yvQIYku1bgEyCSYkenjZn1Wo4TCuC7KusMTjGjeg7ghNKkyW9SGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hi4kOke410xbdAZDUbEg+dYzVXNCaGZGxcGhvnwXWzk=;
 b=NQ309EUkZGt3bkPVEeCvBHsmwZD8WfzKs1mvJPy/4RNlFTe2SBTOgaYzxSyBJzppyL3JGON1oRRzLhCKvahacKbtSqBYMy7LOCe1PG8hv25b2xsDVsTwAURh+Ff0ZVBoN0SQM7vN6wf1oeW8q0Urn4sAZc5Oku2eNTqwuzVd7UyORKI8peTRfqyNDX+LTdxorDxfihFEPdv7StqJ6UuXJZlwX4qdDb3xyUAkFGVIS08D9F+eT9PcjIK2B/4Dr75k2i+10daqUXrSvdovkMhEj0Z5oFtaHqZXEt7++0w03CmstMegKQ2OnvPF+W/k5byQ8ckw2zuSjOMY9D9Yajx7hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hi4kOke410xbdAZDUbEg+dYzVXNCaGZGxcGhvnwXWzk=;
 b=cmLiHhBMK3mIhDbzMvV+AVyXXZ0XT+OHTng+L6cuOwp7VdapyvAfeXbCcz29s1VrJtn+TcAiPLiI9zbXw2Arr3ejP2WgF+lgZmVWuih0tlOn2qfJpPPMJpx9CfSiBmWNc4tmORYEktyZRLWmKo+NPxDNGGQNFUoe+gzRYLE9AD4=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by DM4PR10MB6208.namprd10.prod.outlook.com (2603:10b6:8:8d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Tue, 16 Jan
 2024 20:35:55 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7181.026; Tue, 16 Jan 2024
 20:35:55 +0000
Message-ID: <d12792a3-1d34-4819-9f95-5cbddbacf1a0@oracle.com>
Date: Tue, 16 Jan 2024 15:35:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 03/11] migration: convert to NotifierWithReturn
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <1705071910-174321-1-git-send-email-steven.sistare@oracle.com>
 <1705071910-174321-4-git-send-email-steven.sistare@oracle.com>
 <ZaTURPKv4_tZtIBH@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZaTURPKv4_tZtIBH@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0076.namprd05.prod.outlook.com
 (2603:10b6:a03:332::21) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|DM4PR10MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: 80535fab-71dd-4316-56ac-08dc16d2bd16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kZxJgNT0VjQWcrzkCCTfL+GebY0ELybr/iLSKvD2xSlh8YRckak96CUVABc6T5mBniYe/j3RTGkcNjH5cAeqvw6lyIt3Xwmq9hPpBm2KEB3XjNkKXh8Ttu8ukgtVRIAAuBgZshKU3Pc/xxIihjpbYiZumrd9NKjhctQnAiJon4qj/Gf+7unG7feUbcdIXV42ypVGWBTTrDobJ/tlRy19n5hkRLyk1b2uTCggGN95cvFWIOSsXhaiEuUPLsgKgo9tn+n3jksoTlB+ze4pjT9LUaopEa7ns++z6RKe/sAl24019jkvmgY0w5GyLDAODvQ3tVtqzK4b7e1oUAzYd4Rv0oueLfjqW0qN6JGXu7P8Ia6YBoRdTN1EZpMzacGiHKBssXldDgkO57SRuJnGjcSzIXvRie/UXqpHgwaQBRydihOPdp1Ct8ILVdWJWZ0rAU7tjEG4OISlKP2Tf5bRVgcjsh3gDiLatjtC5925/r2zbjUHQbmetjgL64RuNJ2wjyVjR6TZD/LvURtNJGbl7KwnuComeF+Oj16cD7lB4WTJZcrywNqUMGUWzA6D6MRlqcwfc+z4rwRk/Exu7tQPVm3Yumz3DY3cBKxj4MBo+JqBYF4X6o+uSYuwBP8b5fOZVLx1mgUHqbk+uegMSnK0KTM7PQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(39860400002)(376002)(396003)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(41300700001)(53546011)(36916002)(6512007)(478600001)(26005)(2616005)(6506007)(8936002)(2906002)(5660300002)(7416002)(66556008)(966005)(6486002)(66946007)(66476007)(316002)(36756003)(6916009)(8676002)(38100700002)(4326008)(44832011)(86362001)(83380400001)(54906003)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnlpN0Z5T2ZydUxWL3Bsa2l5MS9IYVBWV2wwT2JoVWF6VDE1Umpkb2Q0bTVk?=
 =?utf-8?B?dFQ4SU9EQVozK1RmRStZSFJ6WmdJMkg3TTdCeEZOR1dPNlpKYk1KemFndVhI?=
 =?utf-8?B?NEdyUWwwK3U5WThqY1gzRGFlUDhROWp5VGtESjRidVFXY3RzVHJiZi9uYzZw?=
 =?utf-8?B?aFNJYm5odi9Delo2N290K3BiQTc5eGZzYy92dkVZcVpRRHVZWnMxMW5HT1k5?=
 =?utf-8?B?bnNzWEdEQ2hMdkdHNC83b3VMQUdWUGNNb0dJK3VOUXg5T0VrTnBReWplamZW?=
 =?utf-8?B?dGpDUDVEWUsxNk9IRmhLeHFERFZiWW1DWm00Rjd2ZWVRQTZFOWNTRjZ1bGds?=
 =?utf-8?B?NEUyT1NsVlVsQ2NDa0pjZDY1U0oxTUZsNEovT0QrL0VWNGQzVExhUms0c1JV?=
 =?utf-8?B?VmNtWGg2TEdZaTFmWFlYd1JDc28xUyszSkFwT0hmVUxTM0pqUE5EN0dPU25H?=
 =?utf-8?B?YTVKWkJUN1BrZG0wN3lPWVVEM1NxY0FuNTc1SUhCTDN3QWZsSXNLMHR4MFF3?=
 =?utf-8?B?bHBaeDRoU3pIZ3pzbHlhbzJBa0laSitJT0hldGFRWUUvMUlIYkNsenJwY3lN?=
 =?utf-8?B?Y1Mxa1UxMDRuK1FtRVFCbHBpczlySzA3amN1eE9yOUlubVdEUjBnUzlsRnc0?=
 =?utf-8?B?a21WUUZrMjV3ZDNtZitrTVRJVWd1WHJ4Ty95R1pyY1hRVGYvbmV6aWhxdlky?=
 =?utf-8?B?U05uNVBVaWpGV1RpeFFKNTVtNEU4SStJcmRRZm1EUUZFd21NZUZaMUp0ZEUx?=
 =?utf-8?B?WEFaQUFsRU4xazZlc3lxUVdSeDBtWkNNNDZxWmxUWVUzMHo3MHFKdlZHSVNi?=
 =?utf-8?B?Q21NSUlLUlU2UXpkUVZaalNVOHM1SE9hdThWSzUxTWdUYzA0WnJFZ3dYSkJz?=
 =?utf-8?B?dEhtVWNJdWpja3VYTkVtdHVDNEE3ZTRoK0ovWUh0TDY5OHltbmhTeGVJTW4v?=
 =?utf-8?B?RVBYdHo0NkZkeFZ1K1NJMlFGT0diZnU1VWZQeDFCM2JZR29xZ2dxUFZZRUpp?=
 =?utf-8?B?VFVzV28zTUVjbEZLNDV3OHlseUQvWlpiNW92REQ5aHRjVUJtTFJROTZBRDR4?=
 =?utf-8?B?U1I1cmdxbTVGeEdDMkZyWDVQRDdVdHdkTzBrUC8zankrRTRFa2FFT1l2M1Er?=
 =?utf-8?B?Uyt4Qk8vTGFWcXVLUlVHeng5YUQ1UFgyb09Lc2ROZUlrZVVHWUxHUzlyNEpi?=
 =?utf-8?B?dzRCdkd1cEIvNmVpclR1UXBmaENxWDM1cnh5bkc1THJ1THdyZEhOcDZhNFlT?=
 =?utf-8?B?alNnOUJYSk9pUUhsU0RVN3ZaSU1NNzErZnBHaVpreHo5ZGxBZHpGTElEa1dr?=
 =?utf-8?B?cUZzNC83UHFkZHBTZXJUOVBMbEJJRmZvVkJ4akxjQ0hYQXFhK2RQZklrT1Bn?=
 =?utf-8?B?YnVzaUVYRFZvUGFWZVllMUV6dmxMOTFYS0VsK3ZrTzBRQUhCWlJBcGpiaFNJ?=
 =?utf-8?B?MFh5SWlRUi9vRW80SVpTRlB3cGZUV04yaHhnS0lMUGo0UDRRb1czZk5uT2RS?=
 =?utf-8?B?azBidW1sUHlMOTRwc0Rzc2tMNWlEbjFNcGFaMVZsa3JTQkxBMkxIQXlEVEJa?=
 =?utf-8?B?OEdkdzlKcEQwSG4rWDVleGxZQlJNTkV2dXZ3a2w5TDBaWEhGdFJxY3FUTklR?=
 =?utf-8?B?V2FiMCt4Z3ZxbkdRS2dNVyt5SitOdXRpWFdTRnpIN3EyT3J3S1RrS1cxS2k2?=
 =?utf-8?B?d3JscmVKQUx2azE1WEptYzl1M0U0RXovU2pZZnM2Ui8wT08zcXRtQ0YrQi9k?=
 =?utf-8?B?U0gvRUdhSC9paE4xS3g2YlJYeWZKbHA3eWp1c0lBV3hhdUhjK3czZ3hGQUZk?=
 =?utf-8?B?WlZ0RzRoOEZGa3NvUktGZlI0TEhmem5jY2s2M0lObDhLRDBGYVIza25UdnNX?=
 =?utf-8?B?c1NsaHl2MG1jdHZ2d09Ed0VGbWU0S0J3UTlRSmdhcmY1UklieVU0NTF6NFBw?=
 =?utf-8?B?cHBrTVloTVlKZm1QMHBIZUx4cEs5UlR5RmNOVkNhQWpUTUNxVXVubHVCRVE1?=
 =?utf-8?B?RXkxeFRaZUt2cEovdEVRa3JFSU5QN3FMczBUVkJTQW1DZHBnVjVmbVQ1bWJT?=
 =?utf-8?B?VCtiRzlYbmE4NDJpek9PVXkrT09UT0dxV0g3ZWx3TmxtazdzM1R0RkRkR2pa?=
 =?utf-8?B?YVZ5b0FXUWlBWTZSWG9FQmpPYnBHdUxsUkZvMlhNRHlwamRJM0ZFendwYlc2?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rwrBrdiLtlYgkOjsYtuBNCZEE+dzEEzXJ1DcFci0l9Scm11mUecfX+5nR9udHi3UWurXUcw0eTWxbdT9r14Ykdi1i4EvzN4IvGMVNL2wRq9TbULh0ccJFsfWrIper54OkWAQb4YxplgXYE2PUYhx0rXCTtaI3/vI8rkPV9vP/HOw/lXQMsBhdwHS0BES+l4bKFb76eCZOc4QUCp5IeoNHhEmF0uuF1lfO7QR9U9l99rWtelLYkbcKfJGBwxcrgtSirD73Z7Y4KMbRrf0xTU+EzrQtefWRPP61k7Dzj79sH+ZYEMmsiDbWnO2Dt0E1mmuXxasTfDFrptTyooZ4lRPaw030fAAPEIcbGmIDvbbAs7K3r6M6+AQj/bHzMuQPfYkZqYv6D/RXjlfTKwbC2IoBy+7ewwLKWxLnwYNONvpeL/oPFBvH5P3jfrVF0r4/7R8/hQYqs6UDErDoYiM97aCgKXesyBSAs3lAFJbxzBkh2+oo4UrYb5coCPYZhiuZWagE6VxgE8byqEHSbNpxPmyRJ9GDjjrdhqM77vgTMuKslsGdzHIEMqdoUStNbzebU7y0/O2i5uup9xhEgFx1O8HiMvjE5c93MX0zpBqE9ScMzM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80535fab-71dd-4316-56ac-08dc16d2bd16
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 20:35:55.2327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jy81CxrPBNX43qZP3NIksDO8NRlp/tTN+HjIsxWZjl+6DZ10PjUH1+7SedX1iS+BOs3+VaI0aKNHg2WjG10VfZu+9Ry/5CUTZjCfQyR87E0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6208
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_12,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401160162
X-Proofpoint-ORIG-GUID: kmi9tOevANz23iIJaIPNYrZ-qmIW3B1t
X-Proofpoint-GUID: kmi9tOevANz23iIJaIPNYrZ-qmIW3B1t
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/15/2024 1:44 AM, Peter Xu wrote:
> On Fri, Jan 12, 2024 at 07:05:02AM -0800, Steve Sistare wrote:
>> Change all migration notifiers to type NotifierWithReturn, so notifiers
>> can return an error status in a future patch.  For now, pass NULL for the
>> notifier error parameter, and do not check the return value.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>  hw/net/virtio-net.c            |  4 +++-
>>  hw/vfio/migration.c            |  4 +++-
>>  include/hw/vfio/vfio-common.h  |  2 +-
>>  include/hw/virtio/virtio-net.h |  2 +-
>>  include/migration/misc.h       |  6 +++---
>>  migration/migration.c          | 16 ++++++++--------
>>  net/vhost-vdpa.c               |  6 ++++--
>>  ui/spice-core.c                |  8 +++++---
>>  8 files changed, 28 insertions(+), 20 deletions(-)
>>
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index 7a2846f..9570353 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -3529,11 +3529,13 @@ static void virtio_net_handle_migration_primary(VirtIONet *n, MigrationState *s)
>>      }
>>  }
>>  
>> -static void virtio_net_migration_state_notifier(Notifier *notifier, void *data)
>> +static int virtio_net_migration_state_notifier(NotifierWithReturn *notifier,
>> +                                               void *data, Error **errp)
>>  {
>>      MigrationState *s = data;
>>      VirtIONet *n = container_of(notifier, VirtIONet, migration_state);
>>      virtio_net_handle_migration_primary(n, s);
>> +    return 0;
>>  }
> 
> I should have mentioned this earlier.. we have a trend recently to modify
> retval to boolean when Error** existed, e.g.:
> 
> https://lore.kernel.org/all/20231017202633.296756-5-peterx@redhat.com/
> 
> Let's start using boolean too here?  Previous patches may need touch-ups
> too for this.
> 
> Other than that it all looks good here.  Thanks,

Boolean makes sense when there is only one way to recover from failure.
However, when the notifier may fail in different ways, and recovery differs
for each, then the function should return an int errno.  NotifierWithReturn
could have future uses that need multiple return values and multiple recovery 
paths above the notifier_with_return_list_notify level, so IMO the function 
should continue to return int for generality.

- Steve

