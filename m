Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEB073F496
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 08:37:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE2Jn-00037k-VX; Tue, 27 Jun 2023 02:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1qE2Ji-00037N-CU
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 02:36:46 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1qE2Jf-00062L-Ab
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 02:36:45 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35R4i2L5001710; Tue, 27 Jun 2023 06:36:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=vbnutBBtLYJJ4xpYA7ldpkPfB2AHMv1KmVuRiZMT8ko=;
 b=OqSRvYwp3RZmCos/EUTRLPj7QllkriDV18gen/YylfoJqL4JAPN/WVc40Azv4uJyjwou
 aj60becoqEiMZhWImxq+CgSuehG/R5g73fYLmGaKEgihUFRMz0vySRIFQx0xp6FxpH8c
 tFX7VI0voENof8TjrZQfpmktrEm4pC2Ji5ZsdphAEyssJz3o7mqblHhDE9C6duYgyOQY
 +GA7zHNn47QVSu6g5R28x2qJBUZ0u+vVpm4b2FzrS5j67Y0kas1TP5KXoj5e0HZHLmzc
 S3ruWelQnAi2ucen6ed9ooMFBoulT2Zvgdb3ktEBCHVSPM5Gsxs6MMhq89EVPN3ILKKH fg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdrca430n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jun 2023 06:36:29 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35R4lbDH018838; Tue, 27 Jun 2023 06:36:28 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx4a2vy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jun 2023 06:36:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elCcFywsZZzUAR07RKhZZmkdCK8c7hJ5TrY8EVlfFF+kldpEGH1gS66RDQdGvJ6l5deni5y2u2HFvknr4CDS1PKThZATebrguHeBzvHDxBizAeyiM1d4J49xT4c+JiuRAgnzSJzw/gcGBcY3S2f69N3b1hMQkz/cIuc3ioTkaGCP5jcpv2Ft20qJFG/Qj+k/cmB9E9+eYAbyOrHLImI5P5mKC6vcbVYjYFdD992EpYgWKdMTsd6f1O4hgM6QAhEah9LhfNhBZYkWzMw9Ae3lST85EQnbadrTgNpghaOboPcBrmENJMGdutkUp2eO0iYoJQcg4MEZyKO/yiXtyTkPfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbnutBBtLYJJ4xpYA7ldpkPfB2AHMv1KmVuRiZMT8ko=;
 b=QTj9T7489BIDWthbrqbNoavWgjSlRa72tFr35IXnL8kTPNgpyvj2n2bU9jXBS2P4v5ErfPcPcZjN9/B6BYKnXpoI3oel0aODv3E4PliAklaIgzIKjvFYenPe+MH1JMxS9JCN8WD6Lw3d/iA/UgwwExtRu6BZTel282MapQbhepFv0fYwOmHmd7IF5MVp/HL/6eFgUKSw7OPnOI6ZzMDW2iKzF+0UHdgHAJYgg752DsVALYuUoBPwSiG5KSNv39NvjOZM7vv2PnmIPEuBw8LzK1+dLSpAfMDuRGv7LJOVzrlGrAla9m1G/4syenmrJbkt9m3UpMEuFlx70ig6ttES9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbnutBBtLYJJ4xpYA7ldpkPfB2AHMv1KmVuRiZMT8ko=;
 b=ekULRXzdiJODyzfsJxHWnMjJ/7AALYzkWfmbYsB9ESLb2Ng31Ll9D9ABXVctmVFBYgaWY8zbG7bwQl3ZOJcwi3qJ3PxCRT+c8CMKRaE10CPIMwyzoi0AzswBNyl69sWtVCTv0yBhdg81RfbPH6xFwsJhUeD4aX8fHhaJwUJVN5E=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CH2PR10MB4343.namprd10.prod.outlook.com (2603:10b6:610:a9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 06:36:21 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::79ce:4ec3:af97:fcab]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::79ce:4ec3:af97:fcab%4]) with mapi id 15.20.6500.045; Tue, 27 Jun 2023
 06:36:21 +0000
Message-ID: <8db2b6cf-1e32-67eb-f6c0-fe3a4175b410@oracle.com>
Date: Mon, 26 Jun 2023 23:36:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Reducing vdpa migration downtime because of memory pin / maps
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>,
 Michael Tsirkin <mst@redhat.com>, Longpeng <longpeng2@huawei.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Eli Cohen <elic@nvidia.com>, Parav Pandit <parav@nvidia.com>,
 Juan Quintela <quintela@redhat.com>, David Gilbert <dgilbert@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <CAJaqyWdV6pKP0SVZciMiu_HN86aJriZh0HBiwHNkO7+yErXnBA@mail.gmail.com>
 <c59d2d67-d31a-b6e6-54c5-5b81c18d9547@oracle.com>
 <CAJaqyWegsVHEVZt2_mf4wA8MuF7UXmU=UbHJfwyzURDRxfRgmg@mail.gmail.com>
 <bff286b8-0103-1698-c77d-736417396405@oracle.com>
 <CAJaqyWcwFgEH3MCOAhHe20P3oy2_aq2BUkTA9_7wePsT8=GoAg@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWcwFgEH3MCOAhHe20P3oy2_aq2BUkTA9_7wePsT8=GoAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0180.namprd04.prod.outlook.com
 (2603:10b6:806:125::35) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CH2PR10MB4343:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f729218-a07d-4bb0-4553-08db76d8d1e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AdyTZKnNbjqOgQ2sj83P39eSi0Wgdj95+IRzfwxZrFJ6kchEoAF2CTn2hlHeSN7Am11DDzWnANL1fd2jsH9FgY1jNmcreb20T5NyvnXhMGD2RVvi7Cbh55KB7hbRoEbDd3zgWjGY+EVeNstjWyXSmyOVYMb31Rv6sf0jb6RoK1eO8/R37Ajzpt1TsQclC3zuaIM7pggONtTqVZz4op6zkkhuYG9GTBg6kYQUqbiQFo1GMAsKXbkAf444VwBS9/C+zj9dXEsZt6uL3NZu6iaVfqwXb4WGx3KvpIEugUfpqmmID0idFllOlqw7cMFwEquQFbl0vFMteQIkUffN8GEP+T5NdTPodgZRyvzpkfOkVg5l3BvrFMEN2ZJZY8635xuRPXN10Tv84dso1VFhzcgVE9LuuyDeAkmPalxJ3NukGkfN/GX50wza5wyjYBVNc+gx6/qMFE4GfFPPp3WSXkUTZCfcVFaun+QASIZkFv+V/F8etHEbGKuryrVt2UkD8uhtoLxVtneolDSewZAFT6wwkFsG1WYvynGS53GFTJBHakiY1yCMkTEGpxm/sHjqfew6jbPj+eLuxQ9JI4oSPrn80qCxKC2zPvEvts8ecAPXLl0xV8m9ulCQ5Ze4/rra0jHg0mWglMb9tDzi0RB+3SdUtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199021)(6512007)(7416002)(31686004)(66946007)(66556008)(4326008)(316002)(6916009)(66476007)(478600001)(8936002)(36756003)(8676002)(5660300002)(2906002)(54906003)(86362001)(966005)(41300700001)(31696002)(6666004)(6486002)(36916002)(6506007)(186003)(26005)(53546011)(38100700002)(83380400001)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1RwVHlhcXhwNTRkSHNrUFRVZDhjZHVQaXlWZS83UTNEZitsY1hTOVFxSmRx?=
 =?utf-8?B?aDUrRjJrTnE3R25GYWcwRUdvQW9RRDgxVTBvaENNUEVPdTBtcUVJMlRTazNn?=
 =?utf-8?B?cXNzVklJRWpUODZvb05QeGFjY0VFNFVqMzlTWkNOZUlkMXpoQytxWVQ2cFZO?=
 =?utf-8?B?YjU0VE9OUmwxRjNJYldoV3p6eUNDRUNVYnJPVmJocGVYV1FGV2JwSHpqeGZL?=
 =?utf-8?B?Um10SnlBVHlFdXdLa0o4QU5rYjdEMmxUbW9nQlVjOGdteVR4V3FsY05HUHFY?=
 =?utf-8?B?MlM1MG14cmNSL3ZudDNSbXFVV3BJcGw3VjUwekVmRzBiKy9LN2JyaWdnMDho?=
 =?utf-8?B?d0VtZlNMc2Erem4vd2lCQTg4K2RtYjRWQ1JPZU9JK084dTU2UXdWZkorSTJY?=
 =?utf-8?B?cHQ5S1RDOGcrL1FERkd4N3VjMjhmZFpadi82WTRMWllhMlNLRWFNektxejgz?=
 =?utf-8?B?WFgxYjlpczBFd28xQXFnY3dzblYvK0ljZHU1UkhlVGQ2WWR6WFZIMnFudVR4?=
 =?utf-8?B?V2d1MDlMeTNuMjEwbmVaUVNDVTRtZ1l0cmRFcVZCRzIyYnJsSDFkVWxsMDli?=
 =?utf-8?B?bDNVZG5pUHZhTFJjWk5kQ29UcnJDVVVJeWVldTEyL29kQWRlb1U2OTdkWTJm?=
 =?utf-8?B?MVFDNWxEYVZnQlJqVXBiRUNsbVRKbkhza21LTzNwSTAwbmtkV2dacTVhTkF1?=
 =?utf-8?B?Ry92cTVGcHFMa1lUVUhYcWcvZkNSRDI2SXUyd3ZXN001R1RJWGhoZ1lrOUNT?=
 =?utf-8?B?WCt6aVFtb1lhcmlody84ZEg0d3NRekVlTVdSU29jSC9VZ0F3UDg2a1ZuODE1?=
 =?utf-8?B?KzhFRnM0amdiSzFuQmJSbnhGdlhjNWFkMUs2Q1RCNktwdEVwb0JQT3h0Z3dY?=
 =?utf-8?B?N3c5ZG1TTmI5c0dOTVNQalN1QVU0OGVhS2l5aWdpSFJKN1RyRUlpUEpnbXov?=
 =?utf-8?B?U3hMaVVmOExLSXF3S1lZMlI2L2tybnpjOG42NkY0VkxZaGJZK1ZQWHozOWdn?=
 =?utf-8?B?MkdvNW1sRG94bkNHT1NLRWJzTUFJM01aQ1VrSXlaYmx2NFU4ME8yck8wRFlw?=
 =?utf-8?B?K0hubW5od0xoWE5yM0xqelI5bkg1RVlQUWNPb1JvaytHbTNmMHF1UW9Vd3ZY?=
 =?utf-8?B?ejd6d29jS1hJSTBPeDlnRTc5ZVYrRW1tWm1ONFc3bjBMZk5JNW9wdGxCeFY3?=
 =?utf-8?B?dnpjcUt3YTFxNTRUZzhYTTNiZUtZenlINTFCNnJLd0MzZU5kdENzVjhxWEtJ?=
 =?utf-8?B?TU5ZRUxjWDdiQnNFc05Jdkx3U1E4SmdXbGdTNWtVMjNCUzNWUDd4NUFhRk44?=
 =?utf-8?B?QjBaQW5qekVJMk5xeTNpZVRjZVMyc2p2RkRHNFY5aXc0TnE4SUpqckVQYjZL?=
 =?utf-8?B?WEt4TTJ6QmwvcFJLR3plUlRyeERJM0piTnEveVdDamhVNUxsQnhQU1huaGFs?=
 =?utf-8?B?SUtjczJpdDZJZ09KbDIyY0I1b2ZvZEFKaDFTUTJscGdjN0tzUEVJeHlFOVNB?=
 =?utf-8?B?SFZ1NExiQW1XRkk3VUhZemxBM1JuMW4zWGVNcFBybDVSTENQbk14NTFmMmRl?=
 =?utf-8?B?TXFMT0hyQjVrenBvb3piNjQwZk5wYUs1OFVMb1BFYXZrNWd3a3dlbWtwbEJa?=
 =?utf-8?B?bEtxS21FOUZhaCtRMmc2blA5ZDNoSjB5L2kxWlRndU1Odll5a0U0WUV4OTJQ?=
 =?utf-8?B?T0VINHB5TUFPQkp5ZTlIS0xFTkh0RUMzT1pMS0RxWTQySklTSTJ3NWpZMEEx?=
 =?utf-8?B?eWdBM0ZDTFFDb0RSRlM4TVVFZnpMYzRBdDRKcDc4a0xHWE10NUp3eXVpNkVF?=
 =?utf-8?B?OXgwMDN4OE04OG9GTHZLSGdzQWJ3aHBaTElGRlJzSG5Td0M1NWx4eGQwU0FW?=
 =?utf-8?B?cW5uNlR3RzZuU3VYc0xhK2xHMWZvSFo2My9ub0l1NERlUHMrR09SODFGUFhH?=
 =?utf-8?B?R0svNWc3cFJOejdVK0RoUGIwWWFnZG52ZjFydTJNeTErZm8zdWtJTHFaSk5j?=
 =?utf-8?B?dllWLzFzVFVIMWg4NlRtdjd0ZHI4aERhNkxPTUZXMjRPczBVRkh4SExXcUIz?=
 =?utf-8?B?NTRqRE5tbzRBMmtIcXlHdFBHSGRURmNhN21jZGVraGVaQXZraDZlK2RWT3o2?=
 =?utf-8?Q?AYOjZ+kQ/08oe4OhJvsqUbEYL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: d6k5Y3yUt8iLMsPrmimWi1wXdqLnAi/+ijBjC1KRktV1zfaJuJID0a08bxxl4dtpcu5lEa2EHvyyZna+liQeT7qMDXMsGkIR8uoMOS3ZGZ5qDlbAY0n511PXS0LEcu6JF5KsN2QmOCjwRrUybvurOzRzdelGYenDRCA/yuuCR4C6oF7N+LaNHPef31G536CpR9OpawAfgQypppApFLGf+ZROY0DlsJ1uG7BDVaj5s2KgJCzrbnm3w7rbnyA6aK5VyIosBoA4ssQ8MPw7YAjB0gKonezl/oWlukHZoThmM5+tdSoYoMV5XvRSocoAlPnyzdy/b5EousShGGL+2WsN4XNErbx2kvGAu1s/XqDA41zRd0uxEUnp7W3n9EjnCoHgRvKyxAE2LRaOvRRF8YCqLCoVFo7XMZyK7/6tHigtsnNhJlPgBtNbZOkbG9u6U/NWc4fUe0EV4M8rTumxNU7HQ45um20DgfkFbJtBoHMsiwMD9sx0lSHUjjTEBgtXytgE5lY9bvg76C9A991hxF2qYfbMicXdWxaYicPPAK/I4cDM/o92EUs9kDMSiAOnkfWzcpXNz3/2/lFQsC2q4eM0ukleAjFLjDmTj2DcdT9SYasGgCcIJ+kkkk4Y++XlDlCOQ8Z5diSOkDeTxEarMPv+2tZxjyUv+NGbinarHJ7Ub6OUyJ5Uf59MfbfGLoaJkHIY2MkAz0DxfA/pZms12wHhsLSdW0EwgSKnfZMbbtqEpZjWO3SzRUQXj+R5vuoQNJoLY8+PAezuGuvuYfvKTBgMbuD53NjVuDfrMsRFWYr67KsdXBfUX8FZy052F/+mDWMxSqC7mUVXPrFgvvBvoiCYXg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f729218-a07d-4bb0-4553-08db76d8d1e6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 06:36:21.1360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cESAjN0kLSC/1cYrBK8hQ+lUlb02AzmUX8QV7bTwPlervwtDn+md8FkTR/CyXeuRpLDgeg7Ww+51PN/HEBj0dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4343
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_03,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306270061
X-Proofpoint-ORIG-GUID: DHu36AKmQnT-w6oxX2LLp4R_DAkCwlxW
X-Proofpoint-GUID: DHu36AKmQnT-w6oxX2LLp4R_DAkCwlxW
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0a-00069f02.pphosted.com
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



On 6/9/2023 7:32 AM, Eugenio Perez Martin wrote:
> On Fri, Jun 9, 2023 at 12:39 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>> On 6/7/23 01:08, Eugenio Perez Martin wrote:
>>> On Wed, Jun 7, 2023 at 12:43 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>> Sorry for reviving this old thread, I lost the best timing to follow up
>>>> on this while I was on vacation. I have been working on this and found
>>>> out some discrepancy, please see below.
>>>>
>>>> On 4/5/23 04:37, Eugenio Perez Martin wrote:
>>>>> Hi!
>>>>>
>>>>> As mentioned in the last upstream virtio-networking meeting, one of
>>>>> the factors that adds more downtime to migration is the handling of
>>>>> the guest memory (pin, map, etc). At this moment this handling is
>>>>> bound to the virtio life cycle (DRIVER_OK, RESET). In that sense, the
>>>>> destination device waits until all the guest memory / state is
>>>>> migrated to start pinning all the memory.
>>>>>
>>>>> The proposal is to bind it to the char device life cycle (open vs
>>>>> close),
>>>> Hmmm, really? If it's the life cycle for char device, the next guest /
>>>> qemu launch on the same vhost-vdpa device node won't make it work.
>>>>
>>> Maybe my sentence was not accurate, but I think we're on the same page here.
>>>
>>> Two qemu instances opening the same char device at the same time are
>>> not allowed, and vhost_vdpa_release clean all the maps. So the next
>>> qemu that opens the char device should see a clean device anyway.
>> I mean the pin can't be done at the time of char device open, where the
>> user address space is not known/bound yet. The earliest point possible
>> for pinning would be until the vhost_attach_mm() call from SET_OWNER is
>> done.
> Maybe we are deviating, let me start again.
>
> Using QEMU code, what I'm proposing is to modify the lifecycle of the
> .listener member of struct vhost_vdpa.
>
> At this moment, the memory listener is registered at
> vhost_vdpa_dev_start(dev, started=true) call for the last vhost_dev,
> and is unregistered in both vhost_vdpa_reset_status and
> vhost_vdpa_cleanup.
>
> My original proposal was just to move the memory listener registration
> to the last vhost_vdpa_init, and remove the unregister from
> vhost_vdpa_reset_status. The calls to vhost_vdpa_dma_map/unmap would
> be the same, the device should not realize this change.
This can address LM downtime latency for sure, but it won't help 
downtime during dynamic SVQ switch - which still needs to go through the 
full unmap/map cycle (that includes the slow part for pinning) from 
passthrough to SVQ mode. Be noted not every device could work with a 
separate ASID for SVQ descriptors. The fix should expect to work on 
normal vDPA vendor devices without a separate descriptor ASID, with 
platform IOMMU underneath or with on-chip IOMMU.

>
> One of the concerns was that it could delay VM initialization, and I
> didn't profile it but I think that may be the case.
Yes, that's the concern here - we should not introduce regression to 
normal VM boot process/time. In case of large VM it's very easy to see 
the side effect if we go this way.

>   I'm not sure about
> the right fix but I think the change is easy to profile. If that is
> the case, we could:
> * use a flag (listener->address_space ?) and only register the
> listener in _init if waiting for a migration, do it in _start
> otherwise.
Just doing this alone won't help SVQ mode switch downtime, see the 
reason stated above.

> * something like io_uring, where the map can be done in parallel and
> we can fail _start if some of them fails.
This can alleviate the problem somehow, but still sub-optimal and not 
scalable with larger size. I'd like zero or least pinning to be done at 
the SVQ switch or migration time.

>
>> Actually I think the counterpart vhost_detach_mm() only gets
>> handled in vhost_vdpa_release() at device close time is a resulting
>> artifact and amiss of today's vhost protocol - the opposite RESET_OWNER
>> call is not made mandatory hence only seen implemented in vhost-net
>> device today. One qemu instance could well exec(3) another new qemu
>> instance to live upgrade itself while keeping all emulated devices and
>> guest alive. The current vhost design simply prohibits this from happening.
>>
> Ok, I was not aware of this. Thanks for explaining it!
>
>>>>>     so all the guest memory can be pinned for all the guest / qemu
>>>>> lifecycle.
>>>> I think to tie pinning to guest / qemu process life cycle makes more
>>>> sense. Essentially this pinning part needs to be decoupled from the
>>>> iotlb mapping abstraction layer, and can / should work as a standalone
>>>> uAPI. Such that QEMU at the destination may launch and pin all guest's
>>>> memory as needed without having to start the device, while awaiting any
>>>> incoming migration request. Though problem is, there's no existing vhost
>>>> uAPI that could properly serve as the vehicle for that. SET_OWNER /
>>>> SET_MEM_TABLE / RESET_OWNER seems a remote fit.. Any objection against
>>>> introducing a new but clean vhost uAPI for pinning guest pages, subject
>>>> to guest's life cycle?
>>>>
>>> I think that to pin or not pin memory maps should be a kernel
>>> decision, not to be driven by qemu.
>> It's kernel decision for sure. I am with this part.
>>
>>> I'm not against it if needed, but
>>> let me know if the current "clean at close" address your concerns.
>> To better facilitate QEMU exec (live update) case, I propose we add new
>> vhost uAPI pair for explicit pinning request - which would live with
>> user mm's, or more precisely qemu instance's lifecycle.
>>
> Ok I see your problem better now, but I think it should be solved at
> kernel level. Does that live update need to forcefully unpin and pin
> the memory again,
No, it should avoid the unpin&pin cycle, otherwise it'd defeat the 
downtime expectation. The exec(3)'d process should inherit the page 
pinning and/or mlock accounting from the original QEMU process, while 
keeping original page pinning intact. Physical page mappings for DMA can 
be kept as is to avoid the need of reprogramming device, though in this 
case the existing vhost iotlb entries should be updated to reflect the 
new HVA in the exec(3)'d QEMU process.

>   or that is just a consequence of how it works the
> memory listener right now?
>
> Why not extend the RESET_OWNER to the rest of devices? It seems the
> most natural way to me.
Not sure, I think RESET_OWNER might be too heavy weighted to implement 
live update, and people are not clear what the exact semantics are by 
using it (which part of the device state is being reset, and how 
much)... In addition, people working on iommufd intended to make this a 
"one-shot" ioctl e.g. CHANGE_OWNER instead of RESET_OWNER+SET_OWNER:

https://lore.kernel.org/kvm/Y5Ibvv9PNMifi0NF@ziepe.ca/

New uAPI to just change ownership of mm seems a better fit to me...

Thanks,
-Siwei

>
> Thanks!
>
>
>>>> Another concern is the use_va stuff, originally it tags to the device
>>>> level and is made static at the time of device instantiation, which is
>>>> fine. But others to come just find a new home at per-group level or
>>>> per-vq level struct. Hard to tell whether or not pinning is actually
>>>> needed for the latter use_va friends, as they are essentially tied to
>>>> the virtio life cycle or feature negotiation. While guest / Qemu starts
>>>> way earlier than that. Perhaps just ignore those sub-device level use_va
>>>> usages? Presumably !use_va at the device level is sufficient to infer
>>>> the need of pinning for device?
>>>>
>>> I don't follow this. But I have the feeling that the subject of my
>>> original mail is way more accurate if I would have said just "memory
>>> maps".
>> I think the iotlb layer in vhost-vdpa just provides the abstraction for
>> mapping, not pinning. Although in some case mapping implicitly relies on
>> pinning for DMA purpose, it doesn't have to tie to that in uAPI
>> semantics. We can do explicit on-demand pinning for cases for e.g.
>> warming up device at live migration destination.
>>
>>
>>> I still consider the way to fix it is to actually delegate that to the
>>> kernel vdpa, so it can choose if a particular ASID needs the pin or
>>> not. But let me know if I missed something.
>> You can disregard this for now. I will discuss that further with you
>> guys while bind_mm and per-group use_va stuffs are landed.
>>
>> Thanks!
>> -Siwei
>>
>>
>>
>>> Thanks!
>>>
>>>> Regards,
>>>> -Siwei
>>>>
>>>>
>>>>> This has two main problems:
>>>>> * At this moment the reset semantics forces the vdpa device to unmap
>>>>> all the memory. So this change needs a vhost vdpa feature flag.
>>>>> * This may increase the initialization time. Maybe we can delay it if
>>>>> qemu is not the destination of a LM. Anyway I think this should be
>>>>> done as an optimization on top.
>>>>>
>>>>> Any ideas or comments in this regard?
>>>>>
>>>>> Thanks!
>>>>>


