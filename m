Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44408740FE6
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 13:16:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qET9R-00063v-RE; Wed, 28 Jun 2023 07:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qET9P-00063h-9E
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:15:55 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qET9M-000084-G4
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:15:54 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35S6KDEI021273; Wed, 28 Jun 2023 04:15:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=FLlugoqs0lEp4vI9S9eCQ5w9sC1u2/Cgupy1koct7d4=;
 b=vLgvYrjIxTFetJuJwQqC5sSLezIQGjLERANdGpYKVpcdIbUUFYSGOIK6Hb1dL983ZY6t
 XgnaPfmhPza0POjmXm3ujoqswtKzac70cwdCK5yvaaZQOBlLNZPFbQMeyxuia+jfO62B
 GR+sPKHYnZqYrd9d5eoU+2fyy/0rSxqq81xClwkfyQ5rkRjfehtztkwgrI+ynrpAfEfZ
 Mr94uQBoaN9wxLYgnJCMYs+zhBIf4DV6gQ5FnoVS4WGTloMAKF6alUaDobeMx3Inx42J
 N4V2aJJ+zxX569GVv/ZWmCQL/dvLELw5CGZE3H9BfO4Wia1tpGCLIZyWxx7qGLq+8Kxj oA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3rfb3xvqa1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Jun 2023 04:15:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/yx7B7V19xNqA8RzfaVmiInnTcgMUZ8wCIcLsuVXRpz4i4GV1hzlDkXW9DLVafFbvj7rOftDPI952IbAzlZn3h7Aif8iyRnqXmpvYHvetQ4zue64xBfSGqhxuZLCUpYrss27ZI1CL9bpVaMpWLzTCOeXai63PJkj/C7Q7iYdYDEllPYxd4cs5xvsGHYNoFy9nYeuIK/u+EIeA7VYY+H2+umirQLdeyYVvFYcFhrfHzJR263OKG3OM9e8WtObnWzxfWMWpoQkzEZAzkACBQ3TCyxChm6aH4myUTLfNaTFkOMZu9zlzUZK1v00kKvILfPvnwkea5fnWI8uKCIySsybA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLlugoqs0lEp4vI9S9eCQ5w9sC1u2/Cgupy1koct7d4=;
 b=Xqp8kpfZ84pv2qs05m/kt0uomBLMVRmexMk99x1wjQXuJQzMXTHYFIRHaBA7+9C3dooT9hDAOP3eC5FMJMoglQJ6Jzr8s58NvMMwfKI4MEkvzGddCOeHWMPNjh09x1+IPPajFL7OZ0rlPve4JIeadJ9Tkl6E2rUwg99c6wUWTaOUSVOHLs9vP6pjHSNA7RCozyKhoFdd5j+KUMKk+oBFL624m82MQfGCi3VgKXjTAiMH1ezqCMXBRS8RvlhqfRnNidaHx2HqX5OzoV/wSelWOY92b2f2QhEKHwD4YRkHUVYPxdXA599FvPKCbjKZYz2Y5Nf7ePSA6kTUfzMDKETYBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLlugoqs0lEp4vI9S9eCQ5w9sC1u2/Cgupy1koct7d4=;
 b=rYsWrUnSAuDKFuwxR179vjg/i7CC6omI2+VOd58ZjibJX1iUVO15MvbLgpFCBIioMvo7oqfV2SuKizUceRAW05nP+KtN+H+kCPjCNOaPLeihLUGEvTk0Ti5rYNKgWRGWhwIoAlv5EIP4xG2XBazGygqnNWz3ObEvCFYAK6e2+pkp48oi0Zv3UQQBqJ2NbuEHPMKQzZSsDJ2zbZDCthNWwoENexMikDTP9xH+tL63PFPJUmGjCidPr18M7VtYaF/xXlWzgA0jlzmlvGHBMOne0HvYYTgq/vR/pL6ULecJNts/LXMe9hxlKTAj9mJX6ndE3mdUzmIUl/7NPybAMIulUQ==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by LV3PR02MB10079.namprd02.prod.outlook.com (2603:10b6:408:19a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 28 Jun
 2023 11:15:45 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920%7]) with mapi id 15.20.6544.010; Wed, 28 Jun 2023
 11:15:45 +0000
Message-ID: <b6c64f09-9fd9-b076-d18e-5f07004f7f2e@nutanix.com>
Date: Wed, 28 Jun 2023 16:45:29 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v6 1/9] migration: introduced 'MigrateAddress' in QAPI for
 migration wire protocol.
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20230606101557.202060-1-het.gala@nutanix.com>
 <20230606101557.202060-2-het.gala@nutanix.com>
 <119c9352-e93f-cb77-f2b0-935d808b0f1e@nutanix.com>
In-Reply-To: <119c9352-e93f-cb77-f2b0-935d808b0f1e@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0097.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::14) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|LV3PR02MB10079:EE_
X-MS-Office365-Filtering-Correlation-Id: 047a4674-3913-49fb-b6cd-08db77c90447
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0oFGftk4o6J/++wHABcbfM5pfuPRB94QN0jrzb+7ViS6JZ+bwliFSGc+QqCXoTNysAuMFYF18ZuZAM88tgrkhxUuEnoKjAcj+XR99NzG+kF20JWso0Tlc259nw4FUP7IAaHpqrRbliBi/RcI5a0UeCUoCZz8SXFg4XU8YVC6g8Tan09UToaSbf1VjeppCOC5FP1qoqxR4UXUuBh27RiM2PzocNwvU7NpttpSp6h85fZdOjWNqmw2xy7Q9VSCU/e1WS/TPh4NEGcREcsnuh3KJm//fGeZx4EhgJgXhcvFZUAKdiSRCFJj2vu/9zkYxBeBV5JSVQ8IEVDSEe9vp04VOnxk65tsFrdIS0PvdfFzE04F5J+pVOO+TpZdB1aeNfHPlxKfZH/oV4aJQpe6nvZQLM5j8SJw7yPMaRPlaGUw5NZ/n8BGZdFn8pFgNtf2UVWDHtMcAvA7+ZJelUZrvF1SLXWDG9MltkacHIATHl1x7pUbLaKEgjc3m/VF4VakM3tRe//izhtmLt3rKYV9fxUvGkMsPhMr/CuCSfTZZwBx16omdJU8o5D2n62MCDJaTRpxMPqk7mx48je65Tulz3x4T4nc1GiT2zW7rpI9bteLXqNWtz4kgQInoffLxdkGTnpk1gZFXwqHI4w8heg7IJuc7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199021)(31686004)(66899021)(36756003)(8936002)(38100700002)(5660300002)(66476007)(44832011)(2906002)(41300700001)(8676002)(31696002)(6916009)(316002)(86362001)(4326008)(66946007)(66556008)(107886003)(6512007)(53546011)(186003)(6506007)(83380400001)(2616005)(6666004)(478600001)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTEyTlVIa3Z1cmVMMkhjTEgzS0FsREdHSjJ6cmVjVERjRmU3NUJSaXF4NzRB?=
 =?utf-8?B?L3hZS1NYZGZDZ0RMeTFGNm54Qi82Y285QzFta2p6UFI5T29GMWpRNXZ2Wlhy?=
 =?utf-8?B?bzhHSW9iZ2lnSVlrS2Z4NEw3bDhHVG5ybjNaU0l5UHc0TVhtcHAraVhLSVQ3?=
 =?utf-8?B?RGZqSER6b2RlUEQ4R0Z6SUxxWHplN2lKSUg5bDBiMG5zWUFrZDRqS21vbWpB?=
 =?utf-8?B?Y0x3RWtWS1g0RE4rSTdpQm5NdzRYWVp5ZWg4OWZSTDRjcERhcVJnZzM3NnJi?=
 =?utf-8?B?Wm1EaDFZSk1GcDc2UGU4c0JJR3BnMnM5bFNXMGQvNENLaTFKOEU2d21BT3pO?=
 =?utf-8?B?M282NEt1RGRVQzk3NEZnOFR6ZWpSV0c0VXNmeTFtNkpxakdHdFAzWnNhcGZX?=
 =?utf-8?B?WGx5NGVQRnp0TlRoeU05bi9Sa2JuOHE5clVkZmhDdzZPVFBIQSswM2xQaTE3?=
 =?utf-8?B?M2xydXVUeWNUVEpETmlvTTZxQlVpOWpSdjg3anBVbGRQZlNrQ3ZtMVg3V2Rq?=
 =?utf-8?B?aFpkaUkzb29mZUk3dTZWNHl4WWQ1Z3k5d25oVFBZU2JvN0tNSVlBdXhFVVdo?=
 =?utf-8?B?VUdualNHRFJ1VDZ2Ykl2WitHSTIzQmhTZ2J2cEJZcWYvSVJKNGlOeDNCMDZK?=
 =?utf-8?B?YU91T1FJRHJFN1l6TjF1TVJBVEE1YkdZN2tvYnZWaERTTkhpWHJrSWNrOXh4?=
 =?utf-8?B?OUk1QmlFQXhjc3dUL2Z0Mi91ano2MlhBYnRYSEl1K0ZaYWVwQ0VDc3lXd0h5?=
 =?utf-8?B?OWs2NVR1WnJOV3dXSW1tRlRIN044aFROY0NhRG95bG5PK3ZOcldGZmRYK3VQ?=
 =?utf-8?B?cEphYXVNdW9ySmU1RjUxRVZHelRFZmtQZHdsTXg2U3Q3TWx1aXF0QVBUZ1pZ?=
 =?utf-8?B?aVErelVXaG5GTkdIWTRaS0NVVnRSditXWVRJTFlKUzlPMkJnU0haK1JFY1k3?=
 =?utf-8?B?WlZNcjFDTVNlMWx0N3kzOEptZFFML2lpZjB1WEhUeXRWckdHZmNaZ0VMRkd2?=
 =?utf-8?B?VUY5UmFldG5lTkkwMjFGUWNYZlFtMDFqR2w1VDF5WUxWMXNDcU5Odkk2bHRK?=
 =?utf-8?B?TDdFWDllL2hneUxURlZuQXJzU0k5T3lvdlZKV09EUkROeHZUaHRnMmx1YUwy?=
 =?utf-8?B?Y3BwTUhRMXhsK2lBQ3NPTDdHNEM1VTVjSWc4MzgyTmVMVDlHZFYwOFdNOStM?=
 =?utf-8?B?VmVWRm14VmtKVDBhcDhhbVVLQUJ4b0NuOG5CWU5RVXNvcStDTUJvL3F4bTBH?=
 =?utf-8?B?emo5WS9WUzhWR2creFZNUHkzNnIvdCsxelZLVHg2czd2NHl1Q3VzK2c0Q201?=
 =?utf-8?B?aUh0amRIYXBuRml6ODVQVmFRSUJOMDdCNWJEUkwwby9oS1Z0RGtvZ2pjRUJJ?=
 =?utf-8?B?bit0NW1yZUlMVDdjYVIxdTBzVG9NWnROREJSc2lGTVNQMkFXMURpUk5sOVc1?=
 =?utf-8?B?ODg5cGkyMlBKSlRQdW9jMHZIQW01bXNjZDBwWjAzcS83cGFjL3VHZy9HMys4?=
 =?utf-8?B?aXB4SDkzdVBlZEtkYXg1b0diTmtSYnJHOVlSYkRMUStFYi9QQ1MySEN5YW1z?=
 =?utf-8?B?RlR5YU5Dd3dCY0QvakJzd0VGY05kZk5mcUxoNTUrNW4vdUV2ZU9XS1hpeTRr?=
 =?utf-8?B?SGIyM25wK0tpMXZkZWNvcDlGUlExQjBjTVJwcWlqSjV2TlF5WXhUTVZaUE9H?=
 =?utf-8?B?V29ieDczSDQ0U1pEOENqTE15TitIRytmS0lMZ21JamJBWUZrWEM0RmFBWDhY?=
 =?utf-8?B?TFV6bldRREltcWw5ZDE1ZGJNdERqN0NHcW9QNTM1RDdhU2Y5R2ZUZ0lnTEFY?=
 =?utf-8?B?NVRqS0ZMZ1YwcjdXaVBYajFDTkZ0cGNFQ0xWSmhnbzNuZG14dHF0ZnhtcEM3?=
 =?utf-8?B?cFhZdG5RUmtLOVJPMzZzT2Y4N29SanF2d3BwTUNDSWFaczlwY05ldWdUTzVu?=
 =?utf-8?B?MmR2VU55VzFkbHZ1VzFIZGExNmptQnlaTmtkeldSQTA5Vjk3MVkxeE5DMWxV?=
 =?utf-8?B?dkd6WW90MTNsVTc0Z3h4aGVRUHJYai9BeU0wZ01TeVRhOTc0MUxFZ0RvQWxm?=
 =?utf-8?B?SDNUM0ZKcHl0aWRvRXpTNkNIUlFMNjFmQ1lKSjQ1QWd5RGYvbWtHcTVVbzhi?=
 =?utf-8?B?NmpCL3pkb05TNkkvSEhXODkzazR1ME4xYjhyQWtwRWVFcTBqMU1zdlpDa3hp?=
 =?utf-8?Q?DYgEnoTG9iEpS5pC/ivhXn7NXqvjBmsgEtUWT0csWYmS?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 047a4674-3913-49fb-b6cd-08db77c90447
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 11:15:44.8957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBpzo+pPwOaSyocGFlHl9+tULGRb01UkH/DfPDxwbk4pUiZ6k4OCHwqwA7GMytUE/lF+JRiWuOEKxyi5WQDYUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10079
X-Proofpoint-GUID: GTJdkHtY7buN_qjL-jK6ogJ2OYMGTL1S
X-Proofpoint-ORIG-GUID: GTJdkHtY7buN_qjL-jK6ogJ2OYMGTL1S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 13/06/23 10:58 am, Het Gala wrote:
>
> On 06/06/23 3:45 pm, Het Gala wrote:
>> This patch introduces well defined MigrateAddress struct and its related
>> child objects.
>>
>> The existing argument of 'migrate' and 'migrate-incoming' QAPI - 'uri'
>> is of string type. The current migration flow follows double encoding
>> scheme for  fetching migration parameters such as 'uri' and this is
>> not an ideal design.
>>
>> Motive for intoducing struct level design is to prevent double encoding
>> of QAPI arguments, as Qemu should be able to directly use the QAPI
>> arguments without any level of encoding.
>>
>> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
>> Signed-off-by: Het Gala <het.gala@nutanix.com>
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>> ---
>>   qapi/migration.json | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 45 insertions(+)
>>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 179af0c4d8..e61d25eba2 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -1407,6 +1407,51 @@
>>   ##
>>   { 'command': 'migrate-continue', 'data': {'state': 
>> 'MigrationStatus'} }
>>   +##
>> +##
>> +# @MigrationAddress:
>> +#
>> +# Migration endpoint configuration.
>> +#
>> +# Since 8.1
>> +##
>> +{ 'union': 'MigrationAddress',
>> +  'base': { 'transport' : 'MigrationAddressType'},
>> +  'discriminator': 'transport',
>> +  'data': {
>> +    'socket': 'SocketAddress',
>> +    'exec': 'MigrationExecCommand',
>> +    'rdma': 'InetSocketAddress' } }
>> +
>>   ##
>>   # @migrate:
>>   #
>
> Hi maintainers, this is just a reminder mail for v6 patchset for 
> modification the QAPI design for migration qapis - 'migrate' and 
> 'incoming-migrate'. From the last discussion, I have modified 
> definitions specifically around QAPIs in patch 1 and 6, and have tried 
> to make it short and consice and meaningful. Please have a look at it 
> and suggest if any changes required. Tagging maintainers who have 
> actively participated in the discussion in last few iterations : 
> Markus, Daniel, Eric, Juan - but regardless other maintainers are also 
> very well welcomed to share their opinions.
>
This is just a friendly reminder mail for v6 patchset discusiion for 
modification of QAPI design for migration qapis. I know the maintainers 
were quite busy with KVM forum during the time I had sent out first 
reminder. Hope to get some positive reviews on the v6 patches soon. 
Thanks in advance !!

Regards,
Het Gala

