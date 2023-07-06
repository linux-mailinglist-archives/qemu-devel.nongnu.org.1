Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1225274A588
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 23:09:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHWCG-0007ea-Cw; Thu, 06 Jul 2023 17:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qHWCC-0007e5-9x
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 17:07:25 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qHWC9-0005W0-Cr
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 17:07:24 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 366K3cJu001880; Thu, 6 Jul 2023 21:07:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=BbM14tRUqZx26dZzC0aBorUj5kldEoX3QN2aNlzVe4E=;
 b=o6svDpH8k4yLSnPL6FHXK+DOqPAaikSEnxMRzxP5pPbLd5WatWE09sgn7T9ZsmaNAHBY
 oo0fT82MyMbFhI362ShRlmUnpvFfXO5a2IQqucR9K577Ft+izRC3GMphz24VUu/VdaR6
 g23YRoCrZQg+S60FR4FtP2SsTkC+32vGbzTh0gGPjcwtskZxs3Dkh6tujCCSNEAEVP5Z
 T/GP5KyIAooOnxMTe8PTyurx37gjURItEtsYvXgTAkERINDxfXwb8g+0MW2LYe4TccXo
 3d3fGkuFhrMYlLyOqzvl4mqvirHEIPJK7RbNR/W6Kw0uoNUbaZU3hx8RFs5sr2KAWr7b bA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjc6csve8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 06 Jul 2023 21:07:15 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 366KTABa033386; Thu, 6 Jul 2023 21:07:14 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rjak7sx0n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 06 Jul 2023 21:07:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXZGUtslFZtJ+h3/wnxBbmN9dY4PE+WARf5BXI4R9Dvb96Gw+4XFzTwmAuSKUFa9VHP/+Jj0rbSCMr75klQ8eWwIJQseIdgYW38YD6210BOqHx0j0nGM7FKxoIomXmONEJXZfjUuEzgmSzxbso3gVHSAlQA3T2QCO17WbGEjuD3ePxWr+cc2bocCKsF93rBlFyqSSKque9WiqH+c/tMZZrDAGu8GrOUzVFkBAdPjSetY1PDDQC0CipOZSP5511bJHiOZB4MrsCl23JA7NjKyDTp7rLWzyhxb4807wSLy87KnSvsIz+Do3mwPtZuJlbH1RQr3+s0adNMdm36l+dnIWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbM14tRUqZx26dZzC0aBorUj5kldEoX3QN2aNlzVe4E=;
 b=UtHwayONzNY9n7ZT2KSnEz61Kr+nGBJeZJ1WwO5OZJrqGawWVAO9DhHVm5TkzHpZWc9lf/mtUYvEuMQ6jcLCQrhrDvIFKw1QEQTVvkLxXBLlTXRbRfNq+IH6kZrrm1iKT9J4OzULB8haa9JiugN0JfBxsRxDE6VeCoVpxx3L5J3pFOL7MHIzJZEj2JxouvhJRKu9S6aiK/ebmYbP9Cz9Piu8S5+Kn7wW1hHnoreouKf0OIi1PlRQhDdAjyj4CtFZTg65JmG/nfOpCFF3GN/cWXWw76v8VTT5QOAh7fxvXGs/fzHAFAH5fhlutZaFLHgylEaEPeUvDD0LMYMFAGTs1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbM14tRUqZx26dZzC0aBorUj5kldEoX3QN2aNlzVe4E=;
 b=nSYOxtABDii1MDTybPCwLXgo4ZeTu/XzAtFfKuNj5jpCCY3aoXL0OL1yvOf2WXqBfM4fbhF56wqJqDNCm0rkvylRzDYxMExC+1QcTrkZgohXlxAfpNtCh9e8L1fsAG/Vr2L+SdQuEIH6NLTxzaLMNvQoUF+Y2zb+btwF4n+0U18=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by MW5PR10MB5740.namprd10.prod.outlook.com (2603:10b6:303:19a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 21:07:11 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f%5]) with mapi id 15.20.6565.019; Thu, 6 Jul 2023
 21:07:11 +0000
Message-ID: <d700de55-a7ba-0857-99e9-0af4703312be@oracle.com>
Date: Thu, 6 Jul 2023 22:07:05 +0100
Subject: Re: [PATCH 2/2] i386: Fix MCE support for AMD hosts
Content-Language: en-US
To: John Allen <john.allen@amd.com>
Cc: yazen.ghannam@amd.com, michael.roth@amd.com, babu.moger@amd.com,
 william.roche@oracle.com, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
References: <20230706194022.2485195-1-john.allen@amd.com>
 <20230706194022.2485195-3-john.allen@amd.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20230706194022.2485195-3-john.allen@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P251CA0027.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::32) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|MW5PR10MB5740:EE_
X-MS-Office365-Filtering-Correlation-Id: 2064585b-cb6a-4b11-80d0-08db7e64f75e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HtvzI5/IxaFqCg/Q760VwFIzYBXKjdY1d1pFCtRJ/MqzCZhqov6X17RfHeUJ/wbHPN7WA82i/O6INhdUhdtmvPM0NGmmwQTinOutlBuBonvlfUgNl4GZ0RYPTtJ8QCAh5tZLi4R7nAyWTpjZJ0agedQpGpYKModiGIRcdl3EhDJzUqDLS2C+tDFM+2/FwtatMF/o2zwivz3OYj5IIXpmZvkxuytbRsGcJAm1Nk9Ec97zAKn9eyu5WXEknP0zEJmIN+GP8xJpKN+mCByobc3OHLY9rBxO5vAPO+T3gEIbfqghg6EqrhqbIFCoXfT+pkC8dXIpwMgRv64Stbcoie7Sfs3g4AKezAVaT/hiuvl6DcmkcwZW5wxpyO7oS79ueyuUDO+4A+CJE42eqJnFcapaq99cQySBs0eWmAn0w1ZUw089yhiwvikUGhCzk6xPEIvBjl9M8GvSwjbmqT6THkeCcq/X5/9EkRmHMA741UXGOGji6rg2CE5sZRQXfpkem5c530LEaphoozUtXPrn6I5YIK+1cWFS0bCETQdp8dC4VKvn1DjhPVHewEvFwKOyYSZlRhNJH8Jhzfoce6JqEUMMhuzyt+hpn4GvWtNhygd69Ji0rNFJIW2FWRzGq1xGZ5GS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199021)(41300700001)(66476007)(6512007)(478600001)(54906003)(86362001)(31696002)(38100700002)(6666004)(6486002)(6916009)(66556008)(4326008)(66946007)(36756003)(83380400001)(316002)(2906002)(8676002)(8936002)(2616005)(5660300002)(186003)(53546011)(6506007)(26005)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTVEU2hXNnZ5UC92azlVYXRFRGZJaFl2WjNvR3c0L1F3c1EzMUhZM1hadEd2?=
 =?utf-8?B?c3ZjR1ZEZEJlRWxiT2ZMTVVsWmJuUHMvSTRkcnQyblhQYU9LODkrY3lIeTI4?=
 =?utf-8?B?cGFGYkxpTmVQbGJuVzlrMkRBYkJTNUVRNk45UnhvTWQySjU5bmM0d3RmWDFs?=
 =?utf-8?B?Zm5GR1lGNjY3WTFmeDBrQW5SbHhXZGh4MlBsdEpFQ3Vodm8vWEt5T013WGJI?=
 =?utf-8?B?ZUFDMUI3SzhrSlQzenhNK2E0aGUvT0RUVFBnckNvWTJUU01mRzVnKzRpSDV2?=
 =?utf-8?B?bk5ETml0cXZOeUc2eXREQzhGeXZNR0xzRHZsN0dVYVNZUzVIdmJLYkJubWFB?=
 =?utf-8?B?NWpMN1FQeW5YQWh1eEF1azFnNkc1M2R4UU1rYVY4bFZISXZWb2ZxR1RDOFRB?=
 =?utf-8?B?Y1N6SVQ3KzZOcGpoZ3lCLzdJSEFOSnhlRWUwaExLV2dQakJTWXNaNDhhc2I2?=
 =?utf-8?B?RkxWM0xGNVNQU0ZOQjMranBnRm9PNXE4V2kyYU5pRXVkU2pxdEM1OG1GYVZY?=
 =?utf-8?B?Sk90TWVUaXI4Q0xhQWNNeEhPczYydFhQSXkwbmY1eFdSRlVPNkd0OU9RbTRh?=
 =?utf-8?B?VHNveDVpS0QyRGFIeVQrSjlCdnBBUWVMdC8wbjVvUnRPNGZqMUxwWXRxd0J5?=
 =?utf-8?B?cXVJN3Q1TkpLYUtYSUM4WENLdkc2MSsreGQwd2QyZElTVDk4MTJqNUhxY0xv?=
 =?utf-8?B?N2svL3NKeVhuUFoyNzJNdmVVU2lZbjN0ZS8rNkt0OFc2TVh3WVNrTXhxelB4?=
 =?utf-8?B?TXRkVmlKSGtoQmY5TGgwcUxkbXVXR2VzVTJBTFhTaWxIRmJOOS8zQjh6azZi?=
 =?utf-8?B?V0lKYXMvZk5DK2JaRVBiRDR3a3piVkovRjRMU2pqRStST0RTSVBXNnhlNC9K?=
 =?utf-8?B?dW5OSkNLWjZrUVlBZDc5VTBuTkJMQzByc0tKUEE5RFVXbnpudkR2NE1OZk13?=
 =?utf-8?B?VGU5b2o5Z0x2UnhUYS8vYUMrWjBKZUJaTWtVb09GTUZKZi8zYmZwWS81c1Bj?=
 =?utf-8?B?cGpVTytKTG5aR0I2TDZIVnRnL0tLNUZZWmhaRjFHVW85RGlERWhhNDRjRGFi?=
 =?utf-8?B?TndnOTNSblE3RWlOYVlQTFpoVVhwcE5hbXVFMXY1MVIvQ2k0YzIxZjBiZWs2?=
 =?utf-8?B?NGtxTlhoM0psN29tb2RJRDBsTmFBanU0UG5Fb0VqM3lndGpRRmE4M0g1UGNr?=
 =?utf-8?B?cDFhaFQ1cTd3WTJ3bjJTckJIL1kydGVQRDNoSU9pWEVMRTNwS0dXZEtkMFdI?=
 =?utf-8?B?OWhGNG1hZ0w2amphNGoyZEloSTNwUU82d2VkdTJjVnlSNTI0a3FVNUVmcWVE?=
 =?utf-8?B?cjB2TXhoWU9maTQ3WjVoTUZlUEEvKzZEcTE0TjdsaDJobDQxdlJSM2tzU3lB?=
 =?utf-8?B?aWVzZWxEUEt1MFFGdEwyakJFNXA1Wkc0YlVXR0J0UFhraXFrWWlMTHQwWnB5?=
 =?utf-8?B?cTJnSGNuVzlrK0ZYMWk2UFYxUGViUHV4elN3Ly9CVnErTlpMN2dQZXNKSjZD?=
 =?utf-8?B?SVVoZlBENHpVZWlIZ25sZHltR1AyeVZZbFlxbTVnS1E4WmtTSDloVHhNSklT?=
 =?utf-8?B?ZDRLQncwTVNteUpzcHYybEtIS1ZUSUFCOXA3VnVFN3BnZXZINWtVYmJ4R3F2?=
 =?utf-8?B?a1p1Vm5IczBEVGVDU09RNG1kUGdEYzdkbzk3OXNzRUxWMEYzb0ZJSEltdWVn?=
 =?utf-8?B?QkpQZm85bHAvZHk1QkxDNkdUdHFJVTZMQ1BrZ2RmaHByNHV6ams3UGs2Ykty?=
 =?utf-8?B?a2FCV3lxUHkxTGFPNk1FNythTkZGb2JUZW9MZmo3Z3l2UTN4OEtXZ0xiRFJ4?=
 =?utf-8?B?M1l2VCtFRGdUUFBPZll0aWVCVi93NUxFNWxGZm5ZbHd2cGV1Z0ZUaXVxKytG?=
 =?utf-8?B?S0pUYk5hM2x0VGQxNWJwYkZaZkI1R3ZScitaYmpaVjFYOXVUVkJrcktMODBI?=
 =?utf-8?B?WFpxTnAvSTdFS2M1dGRKWEs3S2IrQTZWakcweEYzcDYvQWRhMGVQanhZOUl3?=
 =?utf-8?B?YW05ME1BaDMxUHc4RFNpUjJiSDZqbWY5MlA2ZnJROGsvRzU4RW9tSUJ4SzhF?=
 =?utf-8?B?UHFqOGVtdkNGRmREYTNxNE5xazQ2MVdNS05qZXFBdjdGdXQ4cCs3ZXNSSTNo?=
 =?utf-8?B?d2hQcjVLNEdyQWU0N003dkM4WnA1ME1wOGg3c1NNdFVnbHBTUGV6OXBCdjVJ?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NtuGIiNsBeAUhRQeTzo3oIsR32+xyRcwZHWHkgKNxDPjLzh2teme1gpBYBtNjtcQMGO7OWlvTb8VIEqkSSEP7H1iDLEIz5nf0gIDnHKwMJNAmfUVfxJwwooURmjgQYX8HbShji9CbebCaUwuWyDa6MGj5B5QqAiQzBJRj6RMB8uTqtUBFEr/T+wz5M1F1a2dpRIjgkWXLLY51nHqFO+GncZY0djVv5pr0PI7fiwjy6L/qLVOMQGaBIBqNjPq+1zy+up2rYDwRH3TAJ+bhk93I2QsO1Ovvk1/KG1mILg/hKwsBxPaZNuCR+8S8Pk30h2Yxp5BWlaSSf8SLBmEKA7O+O+16V5LbGwP7FyzQFE4U6fSv0mrI5CGvosnD48MprU1+PXr/+ebTXlQ0uISu6xJ/RGIGjXCXAujXbsALlQQsO0cYG0OrOAqjUraZhtcy2GR5u0+wFYJWcdSIMrmMAei4LhpZI1TB7dSpRVa/t4F55i1rnqEcpyGZMrxQK5HL1+IHU/fimtaWIO3jxwhBf9ui/h8K6M2RW0vRfeju9HST1HHbS0e9kvfGGniyoANjLIVmbpTep8cS0DYPNN5PQ31v5hOVEcDhXAoP/EK3AlDgtcClCF7TkNlJCHg9TJJYfvdvP9+FMfaPhlQ/9YI++eINDfHwDFvzsQo+u2E+KTkd36b8Ub05IMomAvbBArQVuw/K7HXL0U7TXa3IkyohCisL7CMsPJDiAAiSg6Out5h4rvHC+zMJ9Blg/fuwzQ2YHL0PY4MQ9XhWXZmEZIJKpxl1SFKWL0yNrEB/0iuQXpb0Nj7cPXasS6mMGNvQ1H+Wf02JldcI8pfhnaXxoZLNjABd+/ZW0BIxRWT1CAdVBU02Po=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2064585b-cb6a-4b11-80d0-08db7e64f75e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 21:07:11.7194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LqeIEWUzO4sYVwubJDXFORPQqg54H3haJmSqdFKZSpHmm2EHcW5UaIoYaiZ7MRjxfzedKcB9I7NNc5wAZAmeqvCiUM5bJ0eOhl+9L5reUF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5740
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_15,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307060185
X-Proofpoint-GUID: 0xZAlV6hlhSg5OyySWpzhYkWq04iG4Al
X-Proofpoint-ORIG-GUID: 0xZAlV6hlhSg5OyySWpzhYkWq04iG4Al
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

+x86 qemu folks

On 06/07/2023 20:40, John Allen wrote:
> For the most part, AMD hosts can use the same MCE injection code as Intel but,
> there are instances where the qemu implementation is Intel specific. First, MCE
> deliviery works differently on AMD and does not support broadcast. Second,
> kvm_mce_inject generates MCEs that include a number of Intel specific status
> bits. Modify kvm_mce_inject to properly generate MCEs on AMD platforms.
> 
> Reported-by: William Roche <william.roche@oracle.com>
> Signed-off-by: John Allen <john.allen@amd.com>
> ---
>  target/i386/helper.c  |  4 ++++
>  target/i386/kvm/kvm.c | 17 +++++++++++------
>  2 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/target/i386/helper.c b/target/i386/helper.c
> index 533b29cb91..a6523858e0 100644
> --- a/target/i386/helper.c
> +++ b/target/i386/helper.c
> @@ -76,6 +76,10 @@ int cpu_x86_support_mca_broadcast(CPUX86State *env)
>      int family = 0;
>      int model = 0;
>  
> +    if (IS_AMD_CPU(env)) {
> +        return 0;
> +    }
> +
>      cpu_x86_version(env, &family, &model);
>      if ((family == 6 && model >= 14) || family > 6) {
>          return 1;
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index f25837f63f..63bd7a7d3a 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -530,16 +530,21 @@ static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
>      CPUState *cs = CPU(cpu);
>      CPUX86State *env = &cpu->env;
>      uint64_t status = MCI_STATUS_VAL | MCI_STATUS_UC | MCI_STATUS_EN |
> -                      MCI_STATUS_MISCV | MCI_STATUS_ADDRV | MCI_STATUS_S;
> +                      MCI_STATUS_MISCV | MCI_STATUS_ADDRV;
>      uint64_t mcg_status = MCG_STATUS_MCIP;
>      int flags = 0;
>  
> -    if (code == BUS_MCEERR_AR) {
> -        status |= MCI_STATUS_AR | 0x134;
> -        mcg_status |= MCG_STATUS_EIPV;
> +    if (!IS_AMD_CPU(env)) {
> +        status |= MCI_STATUS_S;
> +        if (code == BUS_MCEERR_AR) {
> +            status |= MCI_STATUS_AR | 0x134;
> +            mcg_status |= MCG_STATUS_EIPV;
> +        } else {
> +            status |= 0xc0;
> +            mcg_status |= MCG_STATUS_RIPV;
> +        }
>      } else {
> -        status |= 0xc0;
> -        mcg_status |= MCG_STATUS_RIPV;
> +        mcg_status |= MCG_STATUS_EIPV | MCG_STATUS_RIPV;
>      }
>  

I was gonna say that we should only handle BUS_MCEERR_AR for AMD, but the way
you came up with, does seem to work from quick testing. And it's better to log
an error that silently ignore it obviously.

>      flags = cpu_x86_support_mca_broadcast(env) ? MCE_INJECT_BROADCAST : 0;

