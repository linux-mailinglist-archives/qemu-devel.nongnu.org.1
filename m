Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B72F7F1F29
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 22:28:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Bmy-0007jZ-HR; Mon, 20 Nov 2023 16:26:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r5Bmw-0007jE-G2
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:26:38 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r5Bmu-000100-Cn
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:26:38 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AKIn3IU012397; Mon, 20 Nov 2023 21:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=SL+PnRQnx6zLgBW2lB2dgkWGFo5B0bUvrPaT4V2C3zk=;
 b=aMamwXT2RZjPV5W2D7VKFK/UEmcXzJgleZ/XJa6jBejPmSP8Wavo5yEY7M/msnJkDbed
 IfalyzE+40zBjdLwiAEYNnRFR+Gm6kAFU6vAvd/HZw2AfRmocX2TInSeLTEQPwQXTAHN
 5/TWpgITqDKnavpyQ4Yw3wZaddiqSthxUIRU4ui+pptmT+qhzZ+cTA3LEmO1c7nCQX9M
 bIvmBCSkGjf6KhkYxnX2K4FIY2OsfkdIfKJaAwyUPtu1+ryseAVUPPCDdKOv09vfxoeJ
 6vZQ+AIFsaFrDxn7OCTpGIqGs2LCbu1hTzvTTTAoVeMjDjdDlDCAGG5LKbb2troU3LVB 9w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uemvubmx5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Nov 2023 21:26:33 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3AKJww7O002394; Mon, 20 Nov 2023 21:26:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3uekq6094d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Nov 2023 21:26:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLLBSTelda9YeVCMV8uqKBDHPtwuTXx9fF105ONl/MLl6U6kQXJdlFyPevuS8LXJ01WlVPtSXk7Gg5BrltdLb4hgx7s4hQshovvPMScQR0Dq7DfWVgwEEa/C21PALyC0F3nf5vXR31/Oeu1oZyVoVuMgvfAHXtYX0EKylvxPgeH2JOxYHLAQ1l7vmQ/hMVxPhar2iBkOak134JStr3zcDKURGfawep/r/4hTgCdjY28a5vz8KJ6+qCy/jIqGoNBszE4UfilD3Wsed0swVEsfagD40thrvmKbIsYA9psFx48pGifNyL5nCNdRRb40zGXiK1/qtXUjZNYx2u4PIbFWww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SL+PnRQnx6zLgBW2lB2dgkWGFo5B0bUvrPaT4V2C3zk=;
 b=MKdOjvCKF82VFcSyKsve37f40NrpBXbzCvwQN73bJzGreZwvRLVoY89qnFPK2UAbqam0hf3uWOLg+0JS4xlxA29LzZyK5rfpRD2Dwag7xmElbQdLAgojRskhN7JW0TplQ7SdkXocX7+m9U3Oyy0AsFOV5e7E3ZAEZF/8EqxZMOZpqsRXn3fPYEF2FEB5OimLHVDxJnlGx+Km2XiNF8X9ZLKGgEklAnGU9suYKKDu1ZXYYMJuO+NOoHalcP23rlhvsuf+kJzNDVlRdqcZLH2FBbUJ5GZz27h8BKLGOUCUs9ldItHeoTCH6whZTtxQbTzBQ3wyubK8cENfyDFMrRFcfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SL+PnRQnx6zLgBW2lB2dgkWGFo5B0bUvrPaT4V2C3zk=;
 b=cPQia3TtCzJTAFvRaRnGolsmoZTAS7kdjU4Wov8HMQyVv5BBdxeEFHr5spOInSrb8fUVguO5EHfiTmA4MJ7zV62dkdGt/zAmSnh69JTJA/7QXQLXX9W3QULMQFRVqWu/slOmJMePweaYYL7U3h/w2IAyGqDsavDj6vUrjOQNoPM=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by BY5PR10MB4164.namprd10.prod.outlook.com (2603:10b6:a03:210::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 21:26:30 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 21:26:30 +0000
Message-ID: <d15c5f15-3f58-4eac-a6d6-509c169b2a43@oracle.com>
Date: Mon, 20 Nov 2023 16:26:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 02/12] cpus: stop vm in suspended state
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
References: <1699900440-207345-1-git-send-email-steven.sistare@oracle.com>
 <1699900440-207345-3-git-send-email-steven.sistare@oracle.com>
 <ZVu6ohk8_8xzyL-x@x1n> <87zfz840fu.fsf@suse.de>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87zfz840fu.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0014.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::27) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|BY5PR10MB4164:EE_
X-MS-Office365-Filtering-Correlation-Id: beaeac4b-35b2-4434-f1e1-08dbea0f5c94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yFzX2y0hvsFjqk+ptRUjaiIChnRqbEU6d1haDa69xxVyzTIm0Sv3Epi3q81inMhqadKioyMPkh6LfB/0jkqI3Sj6yDM7NvF43AVGyDAC1zX42EJiix54ju+tJKnCVBogx1o/ZQnuFjmWbh5Z99HwV0GL7T3D2XC+4mUY8gQ7kIR6eGLL2NbZGawyRzuHvyb6wmuTtxMiGXWIndM6P+vBks1fgSadWhrE2D7oSlX+Ur7XFBxaZuq7xojkWqsNTY2YlCExpu/VBx5PXoiSjp0eyt8bQpoqcWBEI+8O7MYO5hybkwAi+r3dja2QuhMWNwmgkQw9Mqda0H4eNtXOsyG8trfJbgROSeFYoJQB5qcFUwt/WBZ+14yKMPLX46o07Y5EIeuWGQM89y9Ogxh6/wDchIsu9CDY+ddV0AS8StD/1oSR/xVyyw8DavgNbtZM18LrAmEJUYP2czmQOvVPk8fSbax/7p48/9lx0PKyqdfSRaI4irP6mPWO7ht438T8QNKanenrSZ40LT3rVNixSLgEe1JI3CEzxNkSnv7yLmbN8T3BfIe5/fLQmhXMSlYIKzWXIxnUaxuDAc7zIIzeAnzKsCKo3w8lANybhsTJkqlXPe4KDLPZ7N87KOvnNKTlDx9PgQTxrihlGOsrM3occjzoPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(346002)(39860400002)(366004)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(83380400001)(6512007)(53546011)(26005)(41300700001)(4326008)(8676002)(8936002)(38100700002)(15650500001)(2906002)(44832011)(5660300002)(478600001)(6486002)(6506007)(36916002)(6666004)(110136005)(66476007)(66556008)(66946007)(54906003)(316002)(36756003)(31696002)(86362001)(31686004)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U05YNDBNYXo1ZEdIOUxuWXN2RWMzMktVbFhINGFSblhieCt5bXhFME13bXMw?=
 =?utf-8?B?aEliQ1pSeGEyWDdYNU5tVlRZL3dvaEdTVStOWmRLWjNwaHhxcDdPREJOcllO?=
 =?utf-8?B?NFRPL2tQeGRwOHpjWWF3ak1sR01yMVZJU0FjN2Nxb1M0Y0g5SkkrVVVVNVEv?=
 =?utf-8?B?OWloelNSZmdNeGh2a3kxQmdoelNNcDZJQmw5amtsaXJNQlF6OVJ6YkRwQ1dI?=
 =?utf-8?B?ZTFoclVVbVRGM2xiS2U4YUVYNktsYmxjYy81eTRSTTZ6L3hvYlB1S25JK2Nz?=
 =?utf-8?B?ODA1SThMbFRUTzgzbFRmVnZUbXYzMG9pUHNHd1VVNFZNMUtZejBuTVhrL2hN?=
 =?utf-8?B?RENxeTIySUpKcnhKU0h1cFZ3UUdjVTdwcEpVQStINUNmczJoa1doZW12M01s?=
 =?utf-8?B?cGVnazJ0bENiclVTek90dTlwMzEwQ21Xb21oRmRyUjNsWnoxWEQyQklkbFJF?=
 =?utf-8?B?b1htSm56OC9qczFyc1ZPYVpFbElqUkJQNm9tKzlqU3lYcmY2a1hLbzQxMHlR?=
 =?utf-8?B?SW5RcnFrcmJmWlN2ME5QdFU3QlJZRmgrSHVNQ2I4c29uSVZwK2oyU3VVNmIz?=
 =?utf-8?B?cFlsdlJQM3dzOEdnbm5QZWlIY1V3QkRNYmpYamhCVDdiL1dVVk1xSUlPWjdX?=
 =?utf-8?B?aXU5VGhuMUZSUmJiSEhPa0NaQ21UL0VwdmJLc05ybzNTQjd1SnNLS0tJK2RU?=
 =?utf-8?B?ZXJucGwxa3hpU3pyL2hTQ1Z6cTIwSEtQN3ltanNlc1oxOHJsYzI3WmoyclZt?=
 =?utf-8?B?NzZYalRTa3VLOVZ5c0JLY09KU3RXcTliZndXRHFWTEt1cXNFd2JMeGZ2dGVJ?=
 =?utf-8?B?ZFFMQy9Ta0xhMkJsdGUrTUNNSnFCZExHRXZ3cVNUZllXaktBU0E0T0Z5d0g5?=
 =?utf-8?B?QUNZN3ZQNUphNVFWamdlRFpUNmxlV2tSblp2VFZZdXAyYW01dmNYMVVCUzlS?=
 =?utf-8?B?Ui82emk5V1dXa3lJbk9qRTg5UzdBVGM3Y1ExV3QrMms4OVh3TmQ3UzFOZFhl?=
 =?utf-8?B?TjkrK1J6YkRyNzNvcEtPUUozWTZHVWR2eWptRy8wSmt4WUY4SXZmQ3NPWnVW?=
 =?utf-8?B?VDJHdWkwQ3daMmtwV0xjR2M5Qml2Lzd4SUJvbzM1UkYrczlTRUpDdjdlc0g5?=
 =?utf-8?B?L3pTVXhtNy9ucUFGTldJUkhVaGZocmdxeVZxWStxakhJR2FLUlJmS0FUT29Z?=
 =?utf-8?B?djUyYXl2Rnhpc2hJNUpuazdXQ2xJUkNqRldIMFRwa2NhYjJyaHV5UEt5bWR2?=
 =?utf-8?B?d0NIU1NmT2ZRMmNPVjljR3pKK1V5Qi80RWt1VUh0NHZGZFJCUVpjaElEQ1BM?=
 =?utf-8?B?NnJuQ0NiMm1iV3ByNEZJak5xSGRHdGgxMmNFMHlkSHVyRnd3UU1LVyt4S2tv?=
 =?utf-8?B?NXV1bFFnVVN3VmhxVmVwVWJYc1Z2blhLTVFVRG1lZ1hMam9rdHArSVZLaUlW?=
 =?utf-8?B?SnRkVEdZbE9Va2toYmM4aGRZYWlwRjg3VU4zU2NrdkxvZDhacFJuRWI0ZkY4?=
 =?utf-8?B?S005M0VqbWNPb250b2ZGTG9KLzdob2IzSVNxVk5LZkoyV2Q1eTdHU09ibEZq?=
 =?utf-8?B?S0FVZnZpeGMvYU1hR0NwTG5JZDFHdW1xUkRzdnZFYTl6ckJlWU1aaDNZYTh6?=
 =?utf-8?B?L1BobjZ2QlNCSTZlcVY2SWxMenVlUENCbHB0RGZUT1RZQjZQNmN4R0hQcUhP?=
 =?utf-8?B?Ni9lSTF0aHNrZ2hhanArL0Q2MUVBcUx1UmhYZ3pFb1ZNcm5keTQ1Ym11MGNS?=
 =?utf-8?B?NmJNSitFdHFHMUhNQkJtTjhjV3NCYTVSMElxWUJ1ZXh6UERhRERPeXdEVnlO?=
 =?utf-8?B?aFhQdkRkNWdEZXp1T0d0ZDY5U0JjejFMcjhkZkdaa1kxTnBhdGM5aXZXN0Nv?=
 =?utf-8?B?aEY4RC93U04zUEJJdHlWckF6Vlp1cU91K09WUGZrZjFxd3lxd29RdjVtTEZl?=
 =?utf-8?B?WmFGaGlHdlhGamZrZlR0Y2Y5Y09PVEpQNTNMeUpxdWNoM3RBRDZ5RmhWbmFL?=
 =?utf-8?B?eWhKWkVydmhCNGs0b3ltSStDZWp4UnNycFdVejFabzRzNktIVFBuS1JpWnFw?=
 =?utf-8?B?ZkhWNUtHTkE5bk9SaDRpMWhLZUpZbEJXVjB2b0tSRnBValovOFBhZ2dld3pK?=
 =?utf-8?B?Ymx5QzJGak9MUk1ha01ZakRnaWRqdFRJd0FzNDExYUY4MGVKYmxlNElld2tD?=
 =?utf-8?B?bXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vrkkdTYiAQvcYZ1UVieCoNhyo4Lx/Sp/CSWuKKkcxAGvCk29SdX7seKqYV6S24kmV6ie0qaJQaL7q9HHpXrJdJFphp8i9fmk7fjdapDIJDXPX8RdBGS3hMfr+/HoILPMvsoT/3VSZ2PB8g1Iscq1jNzhQLilYgGSA86yHdtziP2i69ashNWZBelYM7ZuzeICIzpYVLsY2ddTLCo1W0Xz6Q1R/EzQFjEn5OShvk2XwNmg9j8L1FenOniAwD2RtKKeQ8GvTS2kjqout9G0rgyKkCkPHHqvRxFqyUBws4YhS1AYijfMpM3zrtfPutkptCSx0mGZ3uozj2SJ9jwj4ropQQTHmI22FoIUg0GqEzolH+/xmBLWwomMIXyPgB60x4F1vIfaW9B2AQNIY95srh6QVlxsYtCYa8GAX57MQ2khDe/x+2FhthlIFHTtFERP6HFaFcXQcouE5yIOQshmERZ4Zt6rP1kiz8CVnUNkdmqmmHcyJKZRa2YKteX3teeYpDZUTvxPUweGr4aODm3jW76ToMGWeW8EMDwVuo3xNJ5c2zsJrvoLGlO+chXDVaB+ecT5Volj0sGqlboi5nN1s5Vv5c39k2BdJYSUBkBsxgzrYJ2y5+MzEraG2c28mS7QvoCR3VmTbdii+j10sn6HApVBMFeC/OrudWAmtStykAp0/HwpuqcIKS4laRSjYOrvGXJRKpUb/yru490heYSySci5OrG0KaaGChqXBaWxQ5eaw4yV+G6dkSTjdcMVzVIScPH0ZS8XCmSkrQBuf1Pg6psom55Iy2rHE7QZrBSJ0mNcjtg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beaeac4b-35b2-4434-f1e1-08dbea0f5c94
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 21:26:30.3184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGgqhBBWoWckv1yu8JPmQf0knQvvUwKcE/H62ovOZuswrHTHEIEZ9yLdmX0S7XuV9fJ8NmE9UPpXHYjLZtOZ01QlsKLunCybA/EV/4xsxp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4164
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_22,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311200156
X-Proofpoint-GUID: toV6UugqYAXdcbCnpCZkRs9l3O0fLb-S
X-Proofpoint-ORIG-GUID: toV6UugqYAXdcbCnpCZkRs9l3O0fLb-S
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 11/20/2023 3:47 PM, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
>> On Mon, Nov 13, 2023 at 10:33:50AM -0800, Steve Sistare wrote:
>>> A vm in the suspended state is not completely stopped.  The VCPUs have been
>>> paused, but the cpu clock still runs, and runstate notifiers for the
>>> transition to stopped have not been called.  Modify vm_stop_force_state to
>>> completely stop the vm if the current state is suspended, to be called for
>>> live migration and snapshots.
>>>
>>> Suggested-by: Peter Xu <peterx@redhat.com>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>>  system/cpus.c | 8 ++++++--
>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/system/cpus.c b/system/cpus.c
>>> index f72c4be..c772708 100644
>>> --- a/system/cpus.c
>>> +++ b/system/cpus.c
>>> @@ -255,6 +255,8 @@ void cpu_interrupt(CPUState *cpu, int mask)
>>>  static int do_vm_stop(RunState state, bool send_stop, bool force)
>>>  {
>>>      int ret = 0;
>>> +    bool running = runstate_is_running();
>>> +    bool suspended = runstate_check(RUN_STATE_SUSPENDED);
>>>  
>>>      if (qemu_in_vcpu_thread()) {
>>>          qemu_system_vmstop_request_prepare();
>>> @@ -267,10 +269,12 @@ static int do_vm_stop(RunState state, bool send_stop, bool force)
>>>          return 0;
>>>      }
>>>  
>>> -    if (runstate_is_running()) {
>>> +    if (running || (suspended && force)) {
>>>          runstate_set(state);
>>>          cpu_disable_ticks();
>>
>> Not directly relevant, but this is weird that I just notice.
>>
>> If we disable ticks before stopping vCPUs, IIUC it means vcpus can see
>> stall ticks.  I checked the vm_start() and indeed that one did it in the
>> other way round: we'll stop vCPUs before stopping the ticks.
>>
>>> -        pause_all_vcpus();
>>> +        if (running) {
>>> +            pause_all_vcpus();
>>> +        }
>>>          vm_state_notify(0, state);
>>>          if (send_stop) {
>>>              qapi_event_send_stop();
>>
>> IIUC the "force" is not actually needed.  It's only used when SUSPENDED,
>> right?

When not suspended, the force flag causes a stopped state to be forced even
if current is a different stopped state.

> That's the overloading I'm complaining about. We're using "force" to say
> both: "include suspended" and: "set the state". This is basically taking
> knowledge from the callsite being the migration code and encoding it in
> that flag.
> 
> I'd prefer something like:
> 
> static int do_vm_stop(RunState state, bool send_stop, bool set_state,
>                       bool include_suspended);

This function has always been tailored for use by migration code and no other
callers.  Migration would always pass set_state=true and include_suspended=true.
We have no use case for other combinations and no test for them.

To my mind, "force" naturally implies both behaviors.  We force the machine into the
specified stop state, completely stopping suspended execution.

Perhaps renaming vm_stop_force_state would erase the old association of "force" with 
only forcing runstate, such as vm_stop_all().

- Steve

