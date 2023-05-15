Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1E87032EF
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 18:30:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyb4G-0007Vc-S1; Mon, 15 May 2023 12:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pyb4E-0007TL-VR
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:28:59 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pyb4C-0006Jj-Gs
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:28:58 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34FD2Nqe008162; Mon, 15 May 2023 09:28:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=GS0kb2DqCV9nbGjnNOye58a1GbJ0MKYsKEI6nHN4OhQ=;
 b=olnEnQDW8J7teJ6rJNAhGfR3WVclwouXpTKK+CI/aMQIGHbUUFzT7evsxk326ukcLO/M
 sJz5vbYZDwAWKd81vNo9Sk2SUgpzki2gAB5L4YyQO1c1akz8mbcvlkk7cb9BsUzLRf4a
 NgGhSdltz8ADE0otByDPlteUdPixQEvFyOXWxL/kwkpnPl5JyW5ReEx3x25iPqKEwajZ
 hnR+sVDUcmeb3zA9j9I/tL+fYiJTswhOtX3SnA7wTYcL//Bh+FJcNDKVyTyPMy9mvEIc
 lButxocmJaQ8pLAbRRDLGDXPrIzZ5g8h/tr0Jt/1jEEokgNn3jI4OyuMsJffkGcr3xLE dw== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3qj6f73fv9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 May 2023 09:28:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ttb503kILJGnoQRndeAUoMdib2hRQ7X5/2JT4Bm3QuA2hjWrzPy9QKQxfxl8UVaiCNCH+eSmFrwVg3UcpgrbimYNV6RtLBUR1gGFV9DCz2LWRirP4FElCUrpLbRnciFfutk0sN30UqI7FvvaIGspnNLSjMQad5BXSKM2w8Etqpwi5G8EdxYWj8BWY3jODIchUkB9VSZ+uTyQ8ee8bWUQxf/zxErfBS5DEuaXEWg7jlCKphcG/5m+5rH+OIonpk+1dIrf5s0SGJVoJFzYYTBtFUw3B+vVY+mJS3TxF6SvqqZQ6gk2yUFHCpVA/Z+WTixThMRp/F5FdQPGvUWZJCjuOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GS0kb2DqCV9nbGjnNOye58a1GbJ0MKYsKEI6nHN4OhQ=;
 b=Unssmn/fv+p60L4xgB4dm0yxnYQWRsA4yyHSLmfUDE67LBRC0O4IOuan1GIH/4O95Cr8Xrg8JHU/5SGDDFYyTcHRokQU9NL2lYzvNSt1zkH3t/NNxMr36kw2ts4kKTQfJ30YE2fRbwnbw2pqjT9tHGyNufmgbdeM8U2JJFyeyk9VdFAjVQDYHSnSZSEmv4QuiOWDWIdNlCEqAHLWSlYaaoB71EBlpC9DDJPG6tl9fJ9e59WwHakiPxCkoarat1mNnIffontxx4nS2zBiQL6TcNFu8xqasUtZqWGP319LC03ZKrovcTK99yD2oCXjwLEIafh1vgDtI723FMECu3RWjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GS0kb2DqCV9nbGjnNOye58a1GbJ0MKYsKEI6nHN4OhQ=;
 b=pFEFQpTNTAquFD/89FJVA4VqunkfxIxc11aVAOLfB9mELjVIhN72wp41u18xGolX8yFq64JkbpzGFDLcLewdrm/6C6xBddaQz8dm5co80ONVwXtrHkQ/8UCOTsFfWHNgikJNOwgY7FzHM/a6ADhQeFuzTDOyv8BoKyj4+jEIRxuTr2iqtdd5orphYePTIR9QI4kAvOS1W0z4Qsrig/v5tZDwzH27UjwPalxRJeqJb7ftTPiRXjcVE3v4Z1tGE93JkbxG/pJaqsg1PEF3lhZKhTs1+Kr0lZVP/iGgpBusd1z1JM4rwuQvA+RkwxQLVSiItYwNAFfIrHGNZDoU3O+W1w==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by DM6PR02MB6811.namprd02.prod.outlook.com (2603:10b6:5:21a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 16:28:49 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 16:28:49 +0000
Message-ID: <a07c6e54-cf96-41ae-ce6e-531f23f5d2aa@nutanix.com>
Date: Mon, 15 May 2023 21:58:37 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v4 3/8] migration: converts socket backend to accept
 MigrateAddress struct
From: Het Gala <het.gala@nutanix.com>
To: quintela@redhat.com
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, prerna.saxena@nutanix.com, dgilbert@redhat.com,
 pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com,
 manish.mishra@nutanix.com, aravind.retnakaran@nutanix.com
References: <20230512143240.192504-1-het.gala@nutanix.com>
 <20230512143240.192504-4-het.gala@nutanix.com> <ZGIGxf5WaHwasY1p@redhat.com>
 <71658ac2-6aa9-cde3-0eb9-82dae3c7ed0b@nutanix.com>
 <87wn19y7mw.fsf@secure.mitica>
 <381c8c37-3e9f-43e2-4920-3f9ea09ad54a@nutanix.com>
In-Reply-To: <381c8c37-3e9f-43e2-4920-3f9ea09ad54a@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0110.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::7) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|DM6PR02MB6811:EE_
X-MS-Office365-Filtering-Correlation-Id: e1472e3d-0843-4114-ab38-08db5561760c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JrPfEN9aPLzrdB3KRyRdKX+4SvKkS4o8NzdKs6hRBfnFKx+9dc6XYTCrXXuFk3Foy/HJDS4gcZu/OAstaVPqOxh4WVyauWfRXHUvChxF5ckUF/gKiiDm1p5/ByksDDIUhGM5NDn/Ay7WWZv0xiBJ+hyibHNFBy6dfA1iWhfVGouLNp3U4QqH9ff7/O6hoauOkOBcgrD+SOn/Hyx9Uu0KWRU3Ia64epmIaovWjdrwvz83HkgJKaxrqcvsTNWTrEjoAZJRpe9L0LJQu4GJIXKzijh1hvgP2llOvoO9J+HwOYmyLIx4YiFcSoK/5uxBYjGS31y+eZUiYo4oCMrvhfyufKD2yjsmZagINn169fpmobmxng7RGVxWg0fbo8rI3RniWyXuVAPuFFmxmWN6hIv3NEWvte1Gcul2geKn1woMonJSCsxaYUSAFXp1ynM4A49t6BMSnSy2XxU67Ep6uF+znR8neucZfiBvUgNog3gGCEmbFtY4Wp9Sfoz+U4zQT7CeXU2BQvNbUo6fJ69+SFMOOhZcOPQBqfcO4NoS+IG/X/CmK9u5pwXhMVaIMC3trDOfolvndJrVRNptuxvPJPCjZeUWYiXhEOjRQ+FqdB0Ug3MQ0mBKsZCVB47jK4gJ3TxW00aUls5o5aMWvez7XE4ljw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199021)(36756003)(86362001)(316002)(66946007)(66476007)(4326008)(6916009)(66556008)(478600001)(6486002)(5660300002)(8676002)(8936002)(6666004)(2906002)(44832011)(38100700002)(41300700001)(31696002)(6512007)(2616005)(186003)(53546011)(107886003)(26005)(6506007)(83380400001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmkvV01KMDExVGduTG1mb2NUdU9VODNhdy9GTEoxZUh5bzZ3ek5rTnJEeC80?=
 =?utf-8?B?UmRpV1dLQ3dxaGlZcWlINktHRlNlbHMzR2hJb0tRcGUvYTFUcythRnVIcEVC?=
 =?utf-8?B?TzF4RjFkT3F2cm9iSTN1VHhkYlV1RW4wZFJlTnNJelZTY2pEUmRqQWF4QTlz?=
 =?utf-8?B?NFpVcXpFakw0QnVyYXlJRzZaQ1ZnSDlwa1VCQ3EwTlVTWUlqZHNvbHcyTmdI?=
 =?utf-8?B?U1JiWkZIaXRlQ1Arc3hjOTlYL0xGSUFZK3NMbjZkNTdtam5UV1ZTU0I1VGl1?=
 =?utf-8?B?bThXOXQxTmtCZWtuWkE4UXVKQ0VwNGJsKzFJTGR0YWl1WkZsRkJVTGVEcFBJ?=
 =?utf-8?B?SkRPS2xGMjVNeTNjYkFGQUc5eGcvNUZ0dGlEVHA0WWM1WjhoUU9teUpMUUp5?=
 =?utf-8?B?WTNyZVg1clBTYk9FYVlxZGpGV0tmM3JkdVpxUnZmN2I1Rk9MZUF5aUREcXUv?=
 =?utf-8?B?VnBxODJVQUNYZFpGeEwrbkxsTm5WQTJTYk1SbXBoTTJyT1lRRXZXL0hSKzM0?=
 =?utf-8?B?WUwrTUsxTGp1WjhEeWhPTTloMXVPY3oyMVluSG1kYUpWK0tqS082bCtvVlhn?=
 =?utf-8?B?QnZqV25zeWlHOEQ3YWE1eW5KTk9tRWovRTVmZnhiMmZuYlp5Vlo2R2VORFU1?=
 =?utf-8?B?djRmQ1JtWlJvRlE1OXQzd0pUQm9hSlJ6WlJSOVBqZGJKUUhma1JHYVh3aFFm?=
 =?utf-8?B?ZFhHQ0ZtM1JNSU5xLyt3UHd3QTZDOVV3Zk5FSXRLNkF0NUlhSlNJNU1RbHpz?=
 =?utf-8?B?a3NiTkdZbTE3YjdzZDI2QURzVTV6NkdoMUxlMmszQWZZWE8rVlJ6b2FTaDhr?=
 =?utf-8?B?K3Rxc3Y0bFh5UEhNSGpJZTljYVY0cTkwVVkwcElIVUlYWW5nSzhLbjhZcnNF?=
 =?utf-8?B?VFZ0TUZBT09xKzJPZGRSYit4WWdvMU4xV1lFYUVadXVMcGdPNXhGL0I1Sm9F?=
 =?utf-8?B?eDd6QzV3ODZRcU5EUlIyQUJVTjM4UDJWTXVqaXVLcW1WWVBsYUtrdHNrODZo?=
 =?utf-8?B?Mk0vWkYzaWZEVTdtVlVmUnFWbGdIS3NRMDI4U3FxYW5oblYyZXVZdzhpZFht?=
 =?utf-8?B?b2NuTFYvY0hoY0Rxc090U0RQQzFXcHd4QnVnekxNd1h3VmVzcHdDMWZJTXll?=
 =?utf-8?B?eDljQmNpNG1Odng0VWdDN1RZWnE2OU1kaE83TWlTNjh1VkVMVTF4c0RXZW9y?=
 =?utf-8?B?MWlEaFo3ZUNnMmpNa25LeGJzWkhqTDhNUUtiNDJrN3lPb0V0VG1GYmtzSkhq?=
 =?utf-8?B?eEY3TFdSeFV6VW94NGtQYTA5S0hpcmROdTNEVHQ4VEloUGRHSDBGNmVqMXdx?=
 =?utf-8?B?NmJnVkg1OWk0Y0hnQjRFSGdFSExOa296THMySjN6a0dVWkR1L1g0SHJKM2ox?=
 =?utf-8?B?S2h4MTFFd0dnakNpeUxkZjJlaU1GYVluQkQwakFYWEdWcEdtOC9CNEcxYnIv?=
 =?utf-8?B?azFNZ1pyTy9TSUNMamVkMVp4M3RyQ1A0TXRueThhMENyN1hIVU5GZTJBOWZl?=
 =?utf-8?B?SmkvMHJaMHZ5MCsvdUFhOGxVdmhSV3kyUFMyU1dmMjBxZFhqMExBQW5XRis4?=
 =?utf-8?B?N1ZUOWgrWU4ycnJoRSt5aGhHMWVDbEpzdU9jRk1nenErSXFEZG9rTzlQUnoz?=
 =?utf-8?B?S0tDbzQxS3ZZN09xamF4Y3JlQjIxN211bEVqcjFMSzVtSDVpRnFxTW5rS1cz?=
 =?utf-8?B?VTZ4dFIrYXBJWis5U3hDdUpwcmVGWE13Y3BZV0dZSlJXSUcxZTVobXJNUFk3?=
 =?utf-8?B?dk9QekZUaHFocnQrNHJMMWRNUXY0M3hVS3gzZFRubFIyenZxVDZReVQrNlJp?=
 =?utf-8?B?ekZEWFpQVUF0eWZjMDBzcW85UnoxdjVBRXhEaTZ2WHB6OUlBYzVHYndrdkZU?=
 =?utf-8?B?U0Z5bmxOdUYxV2w1alM3VVE3TkVTN0pjcG9UMFg3Z0ZOVW0xcHBqRGdySnFk?=
 =?utf-8?B?eTRYWWJjTkovZkwwSkFBN1pjQUxXTy9wckpuQVNPSFhmY1B6RmZWa1RoUm9a?=
 =?utf-8?B?c3MyRHhSUkp5WGdjM3pON0pnWHBqZUE2NEV1MVFnUStVQlRZTTJwY1BuR1Fn?=
 =?utf-8?B?VDZYQWQ2OU1iWmw0azhXb2kvV0NqUTFmL2VrM29KT3Jxb3N5alZUQUNjdnY3?=
 =?utf-8?Q?xSZNuNadBBW8SDWHujzXFsZRW?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1472e3d-0843-4114-ab38-08db5561760c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 16:28:48.8433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /WoUmum6bmULALNAmi7S0+6seViou2eKEuqd1CbSK8Zz2QsVeoUsp7yyrpHYg89nGiV9UFzVryoEagWYR9rX6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6811
X-Proofpoint-GUID: Ac2A8YzKWDN6ZJM7O-4eMnMNGmNEtifx
X-Proofpoint-ORIG-GUID: Ac2A8YzKWDN6ZJM7O-4eMnMNGmNEtifx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_13,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.811, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 15/05/23 8:46 pm, Het Gala wrote:
>
> On 15/05/23 8:16 pm, Juan Quintela wrote:
>> Het Gala <het.gala@nutanix.com> wrote:
>>> On 15/05/23 3:47 pm, Daniel P. Berrangé wrote:
>>>> On Fri, May 12, 2023 at 02:32:35PM +0000, Het Gala wrote:
>>>>> Socket transport backend for 'migrate'/'migrate-incoming' QAPIs 
>>>>> accept
>>>>> new wire protocol of MigrateAddress struct.
>>>>>
>>>>> It is achived by parsing 'uri' string and storing migration 
>>>>> parameters
>>>>> required for socket connection into well defined SocketAddress 
>>>>> struct.
>>>>>
>>>>> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
>>>>> Signed-off-by: Het Gala <het.gala@nutanix.com>
>>>>> ---
>>>>>    migration/exec.c      |  4 ++--
>>>>>    migration/exec.h      |  4 ++++
>>>>>    migration/migration.c | 44 
>>>>> +++++++++++++++++++++++++++++++------------
>>>>>    migration/socket.c    | 34 +++++----------------------------
>>>>>    migration/socket.h    |  7 ++++---
>>>>>    5 files changed, 47 insertions(+), 46 deletions(-)
>>>>>
>>>>> diff --git a/migration/exec.c b/migration/exec.c
>>>>> index 2bf882bbe1..c4a3293246 100644
>>>>> --- a/migration/exec.c
>>>>> +++ b/migration/exec.c
>>>>> @@ -27,7 +27,6 @@
>>>>>    #include "qemu/cutils.h"
>>>>>      #ifdef WIN32
>>>>> -const char *exec_get_cmd_path(void);
>>>>>    const char *exec_get_cmd_path(void)
Maintainers please advice. If I want to see thatthe build is proper, how 
to enable WIN32 support on a CentOS guest operating system (what all 
dependencies to install, what to configure for a build which supports 
WIN32) ? Any pointers ?
>>> Even this, I will shift it to the 2nd patch, where I need to move
>>> exec_get_cmd_path() out accross other file (migration.c).
>> great.
>>
>>>>>    {
>>>>>        g_autofree char *detected_path = g_new(char, MAX_PATH);
>>>>> @@ -40,7 +39,8 @@ const char *exec_get_cmd_path(void)
>>>>>    }
>>>>>    #endif
>>>>>    -void exec_start_outgoing_migration(MigrationState *s, const char
>>>>> *command, Error **errp)
>>>>> +void exec_start_outgoing_migration(MigrationState *s, const char 
>>>>> *command,
>>>>> +                                   Error **errp)
>>>>>    {
>>>>>        QIOChannel *ioc;
>>> Sure, Juan. Will change this in the 2nd patch itself instead of
>>> here. I am not very convinved why should we have a different patch all
>>> together for this, because we are just using this code outside this
>>> file in my opinion? But if you still think so, I can make a different
>>> patch for that.
>> It is up to you.
>
> For now, I will keep it with 2nd patch. If any other maintainer also 
> thinks that it should be a separate patch all together of windows 
> support for exec, I will make a new patch for that. But thankyou for 
> your suggestion 😁
>
>>> Juan, I get your point. But I think, we won't be needing local_err at
>>> all, if I use g_autoptr for 'channel' and 'saddr' is a part of
>>> 'channel'. Let me have a v2 patchset and if it is still not
>>> convinving, we can have a discussion on this.
>>>> THis leaks 'channel', and free's 'saddr' which actually  belongs
>>>> to channel.
>>>>
>>>> With my comments on the previous patch suggesting g_autoptr for
>>>> 'channel', we don't need any free calls for 'saddr' or 'channel'.
>>> Right. With g_autoptr used for freeing 'channel' in last patch, we
>>> wont have to worry about freeing 'saddr' at all. Thanks Daniel
>>>
>>> if (local_err) {
>>>      qapi_free_SocketAddress(saddr);
>>>      error_propagate(errp, local_err);
>>>      return;
>>> }
>>> And after changing the position for assigning 'saddr' and using
>>> g_autoptr for 'channel' I believe we can get rid of 'local_error'
>>> variable too and replace it with 'errp'. Please suggest if I am
>>> missing something here. TIA!
>> great.  That is much better.
> Ack.
>>>>>    -void socket_start_outgoing_migration(MigrationState *s,
>>>>> -                                     const char *str,
>>>>> -                                     Error **errp)
>>>>> -{
>>>>> -    Error *err = NULL;
>>>>> -    SocketAddress *saddr = socket_parse(str, &err);
>>>>> -    if (!err) {
>>>>> -        socket_start_outgoing_migration_internal(s, saddr, &err);
>>>>> -    }
>>>>> -    error_propagate(errp, err);
>>>>> -}
>>>>> -
>>> Actually Juan. I don't need this function at all, because parsing of
>>> uri into socketAddress using socket_parse is already done. So there is
>>> no use of having this function in the first place, so I decided to
>>> delete this fucntion all together. Same with incoming function.
>> What I mean is that this code was already there.  And it was doing it
>> wrong.  The parts that I corrected you were using this pattern, chcking
>> that err was NULL, intsead of cheking that saddr is NULL.
> Yes, I get your point. But that function is useless if socket_parse() 
> function is not needed. So have omitted the function all together as 
> socket parsing is already done in earlier patches.
>> Later, Juan.
> Regards,
> Het Gala

