Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9106D73A99D
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 22:40:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCR68-0007gW-7K; Thu, 22 Jun 2023 16:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qCR65-0007gM-QF
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 16:40:06 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qCR64-0002yZ-17
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 16:40:05 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35MJo6Xi021617; Thu, 22 Jun 2023 20:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ZUqgKghFQhBsy2haRw8/uWns/0F0Zwj9AzbZPFehFsE=;
 b=RrtN+Xlvaa2mzNV3ZSJoVBZrNItu54Yp4wFhbFgg6yxrQCO5pQJiNWf4wzNpWayvC0of
 e+cPKfXjnzFR+PqPHeXpZU3h/tLGXfUaQbOsSPuA00c5tIHhxeq3obCEt0NJEh2nICfE
 plyPOP+eeqQDHiYpVBi+ERyi/06G2AsTWRRYa8ow7s9W67p5b33tKeQT0EZMI5BoQmHP
 WfyWTnzdP3ebHKLK7gZvgFW0g0vnIrWNexUtnVTG0APkH5WJFOTvj+TOjK2J3GJnm5qD
 5puuf09K8igGKS3GuAZOGdREkxONZPnd4jD3fxPlUE8rg77d+Ng5lACC1BU4SoRcfAj+ Ug== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93m3tuqf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jun 2023 20:40:02 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35MJTf8T007757; Thu, 22 Jun 2023 20:40:01 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r9w18f94f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jun 2023 20:40:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dag9X9TuMJnFwNR3r9wW8TPdr6ct7zAAGh2/DCvNVc2Djkv1trnElj2ZWumB5fa7s7SzMnwz867+Oj8lfTHyzir4+k7RW0SN2FeIg/vLOhLYrufazxU/83soWQ/sFGKkPEvFom8r3olIR1a+anPh6BiDvBiCOkbqznxTjsrrT068/VjiaH/DAwe+30fqyQwfxID7X0CoAXCk9w5iMy52Oa0oq8+RYHs/syb0GCDXNkIkBDrSLQ5pUuMxi8SMK70Y1SAZsELKJnzxfAMpdaBWls8eZSRdXp0I8IaI42aO9UXYeRlKNbHGf52ORm4AC2pwkhsrUBHKaKTexA/t6gcmqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUqgKghFQhBsy2haRw8/uWns/0F0Zwj9AzbZPFehFsE=;
 b=JxWb37Uyf8qMtENAa3epbCXhDZgCea8YwbPPw6jIei/Fcgg3/Xwi/fhk8Gt0FnvjGFT3n2RFo3KUkM/2ebyQZld8pR5jGY3uuq5Xy9NFWowCsTAdzVRhI48G49Sm2DVqNXfpP7Qv1T0bxL+/mzdHVkVTEPaegeSmG4ee1g0bzAkRWdbUBYabOTZk9Kr8uPIBIBmLaxkZ/KgpmK1syHfKrykymqiCZzd0o5i9HoYiO9zhJoZb+FIvyDRi9tQwcokRN+9fI1DsjNiAzL3hjiraYtwHqZ0aGBAbtxxDwu6vDsZXw1wEQesTTjABiAewz+VZENSnegnEf+VK4lYXzLrtjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUqgKghFQhBsy2haRw8/uWns/0F0Zwj9AzbZPFehFsE=;
 b=O2osNjtrjBuFRTQ61TpiwVFnYZ2MNYsWDy7U33uA9JM4eAru2qm6qEQo9qFhY8yD/keY6qTu7ebY73tiC8c5B4Fzjw667zmsGuGvS/G/YNenqaqwXo/OKaRGGiUO//G9C5gGp8FvS9wsZ64KtkRo1TK0qhPGuWn/9xITVVnaBRU=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by MW4PR10MB6347.namprd10.prod.outlook.com (2603:10b6:303:1eb::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 20:39:59 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::2743:9347:3bf1:5f11]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::2743:9347:3bf1:5f11%6]) with mapi id 15.20.6521.020; Thu, 22 Jun 2023
 20:39:59 +0000
Message-ID: <3adf97d5-c513-143b-d712-b818e4e4f17f@oracle.com>
Date: Thu, 22 Jun 2023 16:39:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V2] migration: file URI
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <1686163139-256654-1-git-send-email-steven.sistare@oracle.com>
 <87h6qzk7rr.fsf@suse.de>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87h6qzk7rr.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0141.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::8) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|MW4PR10MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: 6422fa6b-d510-4c83-16ac-08db7360d87e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XS37Q5Tf32ZR7Pjx/0BjtLuoUmnuHzIx7++qbfDsoHPy6IjPJzaNS2+ERnxBtViJlpV1M4wWdGh5B98AHEL3pQ/OsP8XYfGPBtpXrmTOVI6VMuWDw2xswLfJNLjqnCSLJ2JI9U06HUEzwNsmAw0VQ27gQep9tC/ou0okYTYNrDOTQEFfuHC/KbF0E87sLAqtxzIrF70hyw7IseAPzUqhgRwwLnq+Q0KWvcg9Hl0ZbR2p6VuBy2PiVvTg4GQMdP1j9Zm/dZ118FGlHIBIoqtyw9NlROov0YGIOfW64YyCHNKYeyb6VGSi9i6j4SkMPf7AJBEf6cFFwjGzjuGbOHfhyWfTTbhuaB5sjZjzanSxGFczzAjqbR8uuCBNLqwtxvcOUd1baTMlQ8OTqgyjKRd/MCzWVSWEzTkVO/rp1/xk/7P8RuaSHquEcf2Q5qs7YiHTznL5/qX4Gg08HdRTEwefHVbBg+Rp3VFhFnjbkPbEYmQh71XCkVFgiqNz4UAs5n8N0DfRym2Yc77auyLsxuu+0R0is0iq7a1Xng/TX2uIkWfWnFyu/TYlPo6mlWeMyibl69umlq7qpsFJQiwY2sYoJXrdSdsrgZFwPM/9809g2dSdWcA9pMjbI6UV4jn/yU28BiDvwe4fRpzLARbipxdO8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199021)(2906002)(41300700001)(8936002)(8676002)(6666004)(478600001)(38100700002)(36916002)(2616005)(83380400001)(26005)(186003)(6512007)(6506007)(53546011)(6486002)(54906003)(86362001)(31696002)(316002)(66946007)(36756003)(4326008)(66476007)(66556008)(44832011)(31686004)(5660300002)(4744005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFBpejRYVVgwKzBhZ2tCRHd2T01qVUdFaEY5QU9kb2lIOGlPOFVUdjlFTVNs?=
 =?utf-8?B?Y2EvbHEvc3ZxT3FtNVF3M2FFSU5iaWhiNStvMTFUNGpqVFJpTlphc3E3T0xF?=
 =?utf-8?B?THB3ZjlpNEdWUTZQK01LV2grWVhhTkg1US9nbUVXa1ExR3BOeXZpc0VrZUVj?=
 =?utf-8?B?c0VIemg2MWdMOWNORjU5N2crN2l0VWp5Z3doMkJub2w4Zk54eUJDbnN5TjBq?=
 =?utf-8?B?ajdocEcramQvQy9BbFIrUHAvRnh6YWR3NGdOZmlYUDFVTUp2YzBnSnpqbFdI?=
 =?utf-8?B?ZzZGNk9tSGJaWkY1VkZaNEFFcnQxNFExZmdIUHZ3WlRSSHE2VTNqcU5heGxR?=
 =?utf-8?B?Q2hNenlqTjZOTUJmSEtpY0xPaThpK0JQR2dJSHNzYndOVlZjc0VQWGt5OW5E?=
 =?utf-8?B?N1FBWWV2TlZESGQ4UGZLRUNvQkRIcXhNWDBUamR1SVExWHFmRkNBZCtidWtD?=
 =?utf-8?B?LzlFSks2MW5TU25mT1dLN2xIS3J2bjB1TStmMkx0VExvOW9LdXdERTFjWmNu?=
 =?utf-8?B?T1lDYmNKbTZjeHFtSThRVjNIUW10ZGZRMkY0aE1INDdrNWl1d0dTcHR5WWdZ?=
 =?utf-8?B?N1o1QXRUSzdwWElzaGhYc29VcGY0R09MTUg5MWU4ZXMyWUNkUUhraUJUdE90?=
 =?utf-8?B?c3BrbGJ6UUo1ZzF1dDJhQkdJZFVRUlBrT2VXNXJmYWU5Q3FyWmY1L1BleGhl?=
 =?utf-8?B?eExjbDVFUWI2UjVrcFFPWkhnd2pJWkhzdHZrWnV0VkdFUVZCYmtuTFJQV1Fj?=
 =?utf-8?B?eUpDWVJZT1J1NmxLSWxmdmVwVnhwcUthWlRJd2EwYnFsRFJmbjI4OXhSV2Fw?=
 =?utf-8?B?UU1qeTM2ZEJwZTg1MHZOTjBLOUNVZFBZN1d0d1BvTXZWanE0NWx3OFV6aDFq?=
 =?utf-8?B?TXRzZGYrQ0lMREZKMWVBQ2x4b0xTbnhMM2xNaTBscXBHSE5ackZ6V3BTdUMv?=
 =?utf-8?B?WWRuOWl0ZzgwZytnVTYyQzVENDhtUzdYcFVTVitXbHphV0k2T0J3ZDFpZVFy?=
 =?utf-8?B?L0d1UGZWa2FkSUc1NkZjbVlkLzZqcDFFbkF2RHkxSUdpbEtpZEM0VlczRzds?=
 =?utf-8?B?RU5uUW5JdFdjYk9PZFltalZ0eUpESHJZaHMrdUR6SWtubmp5amVtNUxPZlZi?=
 =?utf-8?B?bk81UDNlVy93NVVwT3BLbkU1aTdUc25URVk1c09rR0RLSFlMNGEzZERVZXUz?=
 =?utf-8?B?VEwrbi95d00vK1k0RWVydEw3NHJIZ0Y2eWRGMTFycTZQSWJmbWI1UVNNQ2Y2?=
 =?utf-8?B?UzhhZUUybGVNWjFDSHNyajZhZUNRNDh0MGorOHZOR3lmUnBNeDIySHZ3TzVv?=
 =?utf-8?B?ZGdicHU4bUdOUGFQSWZoaHN2MEVzUE5iNysvMlp3S2xiQ2RSalZlYVVJeVhU?=
 =?utf-8?B?V3ZScGZQSjY3ckkvMFdicVh0U0phZ01JcHpMQkNxRWF5eE8rNEQxdCtxak1L?=
 =?utf-8?B?c3Z5MS80NUJWanJzaFU2bWMrMDdrZXZ4SjQ4NDZtaFc3RkMrejFxMWdReG1G?=
 =?utf-8?B?VWNVU2dVTlVYWWVjeU43THhGV2QrYUM0cmtCQjgweWZtdFJkSll2VWJscUxR?=
 =?utf-8?B?eWQwbnY0T3VJLzE2UkZYMDNFQ28yVGk0dHJlZkRQTVZlNGE3R0JSa0dObGpP?=
 =?utf-8?B?YXdFSWlXSkMxNTNvMnhjVWpUT3dibm42dEQ5QkpOZ3FubXpmTjFTQTFGRjVz?=
 =?utf-8?B?T3FsTTFsbkY2dmliYjlPSlg0alBrRlRRSnRpbEFNdHQ3djBCVHhPK1FhbmZV?=
 =?utf-8?B?MzdkV1ZtbFVMVEFORk5wWWhtN2UvL2FsUnJXa2xZcTE3YkY5ejJDZWh4UWxt?=
 =?utf-8?B?VjRaRUVONkErR0hCQWNsSFJSWE5DQ3cya3I3ZU9aUHZTd21FRXgwK0srTlgw?=
 =?utf-8?B?QzBRbGs1NXl0aGVjWTRMcElLRWh3OWFxZHVISUtiNUM3V0hwTkRuZWlRZlNW?=
 =?utf-8?B?QVdqQ2N6VHMwZmpYVVdvdEtIMzQzc3B4L0p6VSs1dkNKRllMVjV1V1ZmaTd4?=
 =?utf-8?B?WEpBUmFVRkhMeEhOY2Q4UGhBQ2QrWmptbk5iM1JFeElyMUY5MVA3QUdIYlR1?=
 =?utf-8?B?Vlk4WitHSGhielZTSUxPWmF2WFhwa1I4SlZobTRCamw1cW5ZMzJsMmwycHMy?=
 =?utf-8?B?YUtuZTRRSDZ6dTE5aFdndlFyOVBlK2xDRGdYejFHdkdIUitjaEFVbWpOTXlP?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NawzOyVqYCgpWK+lRtVAUEgB6q6t3NXtQ2E1abl9aISHXzhJ7dmA7i5J6mhmlg9JcYUq0omDKP/42ABAcNgkcncyjxj8RKmqgmHZwtnD40sMRx1GsShJ2vlFJss8drLkl4qERiMyHM+4N7z8kFoQ1yF9n5C/6bNsxHt8+1FR+CnEjcaRxgB+yCvOka9ZYZHQNIaJftoeqjSzR6GzTHc+LWrOzvj/tOeBRbqYbtsQ+xPKm04OAXcliBCQs6aQoS/iTLHXjUv/95mN/SObFK7Z0GFMYEkdp48WOk9rhHeKXtTUgVE8YIHdAx19NmQAVJaGGyYNETES2AAAMX4hl+vPgWdSfydxyQvpQVRqMLI2cfzO3VUiUAYf0VbbLB5ZJ6o6Mse0nXVHGEyA4AWXMS21w0FaOVBUSPAHku6ayLUt/UIAL92aytk6UHBVqQpxp0dauWBMQHAQHq6/TmHodQu/ew3bvPXYmpRs/N8+TMHV1ZFNsCXKGl6KUxySsPtOUHRCdtcqEgr0pauAN8K6J1S7L0FcrbRJ1VZ9I5QGBar4kjcEWRBSb1hy/Lur333xATJvva2X2x7Ipo5y4cXlGm1rLxnwNxLfr9lgtt3QfHbyQMSEXoSLBzYeYj1LHOnCi1mJZtchpojsYIQgQuKeJ+vDM0vgXu0BSh643ioOvZUeLtNA3HyTc6Bwf9Q3sen0tDHDJLu0tB7q+RdCUqyOc4XxLSzcWIhYuTkyKBR6KThbqFnuXrpvMOCj47JLMbn64V3t9JEUXlc1oJWMtMwLoJ/6Wli7ymJEP9bZhNapOgytxygcuPCV/QByjbXiIaobC6xzKlbRiQhJ4oXvBHRXJmgQzQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6422fa6b-d510-4c83-16ac-08db7360d87e
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 20:39:59.0425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ml/wHVpWdqYS5sRCo3g04jT5byQMHWxsxew1WgKt4YGNcJwoVlsNl4pf5vQd0+nBDwcX+s4l3uDy3GKyUvswYpJIZb9b9EZHuE1Lt7J4njo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_15,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306220177
X-Proofpoint-GUID: HSWbvTNWNDShBr2LhwlPP2wtYJyCY6ia
X-Proofpoint-ORIG-GUID: HSWbvTNWNDShBr2LhwlPP2wtYJyCY6ia
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

On 6/22/2023 8:20 AM, Fabiano Rosas wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Extend the migration URI to support file:<filename>.  This can be used for
>> any migration scenario that does not require a reverse path.  It can be used
>> as an alternative to 'exec:cat > file' in minimized containers that do not
>> contain /bin/sh, and it is easier to use than the fd:<fdname> URI.  It can
>> be used in HMP commands, and as a qemu command-line parameter.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> 
> I'm ok with using this version over mine. I based my series on top of
> this and it works fine.
> 
> I'm preparing a couple of patches with the test case. We'll need a fix
> to common migration code before it can work due to the latest
> migration-test.c changes.

Hi Fabiano,
  I re-submitted my patch, along with an offset parameter requested by Daniel.
Perhaps you can add a test case using the offset?

- Steve

