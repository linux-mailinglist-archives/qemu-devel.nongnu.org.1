Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3AE7B795E
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:00:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwmi-00051f-15; Wed, 04 Oct 2023 03:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qnwmf-00050s-8Z
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 03:59:05 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qnwmd-0006Hs-5g
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 03:59:05 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 393JT4lR010676; Wed, 4 Oct 2023 00:59:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:content-type
 :content-transfer-encoding:mime-version; s=proofpoint20171006;
 bh=TNSrkhfuCPV/V5k0ddOWzdc+wYOA09+70FcfmzXRKas=; b=wa2PNxypvSs3
 9BhzIj5QTvrdcn62H9E4UZBAt4jbl0a3DZhThagqyO9+iuPaJQ5Hs81JUSA0kEF5
 PdC7aVL4pZT30ABolN/VNhRld4nzXFQtlklSjoGacAD5LgLSQP2TPkU4qR10XXqe
 MYDVXEpXQQt04DpiIAYyEkPZoNaAQ07nuv/ArpiXgMnGEmH6nSERXTclEzrdL/CK
 88qxgxlBeqs3Mkd3ZD8QeJaaunwRuhX7H76KcKxpMnIEy6EpWZA4H3WnXERR68oH
 fkmi4sLjqqgbBv7cT/mfvn22AcsFEVReIgsT+fEx8V8GbukejOT+8PnYaE61jABx
 YazR5fUdjA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3teh77031s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 00:59:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3LlLWYxMxTloXJGKlz0NaNw2Ulj2JujK3dG6RFIDGv7IHQqfycFS622FyTqNkXPfG+OpaJFoVYnnipDzQ+wiYghwMSCdhOivFQN7/gEeSM98U2115AwmTynqK6BWURwY/U4sTXauTH9p/MJgayhCcajB+NJkOdzcDbsLWPYJKP3ignoFJHCpBKZg3P33CYHnGycuIdVMkDNfKQEH/3y/bcJnQgvO4L18zlnTtT38Qv49VDzz7wEUf4+lnwhx4JHG8+Jb4rQR+1Fcbk6nJRrb+VgqfXQZPhcedcU6Cu2VTjTB0jwwVqw+tXsxBlo6+Nnk1BByIumvbtD0IreRFGY1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNSrkhfuCPV/V5k0ddOWzdc+wYOA09+70FcfmzXRKas=;
 b=jA9TylXNOXhfidbPQD/vtPIgJSH+bk4yrseGv/J97WGchsz9KcGVsfdtsTy7qO14HGj7FDe/GY0mBRLa6RJEk3AlSAe1zBEhV48oouzobE6XndthuwbymxywyQJycbcofDiBKTjOt5OKMzyRDzi9fedVbHOzXUNFghRovaUyKOuNrUccj7SVEZVQ5KqsFD2GUZ5+ahRfCymqPXpjrUJL/ymIVq76hue/EFGBXz8DrWozTxygDvddgg9P1JBKGWM3NdP7IQKtWjpwj31wmNVBYodvGPs4TACcAcl3foc96bz6+d5u8eddXrN3GbCDjdf7TqXZu3qc2qyGvJI3k+Rs2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNSrkhfuCPV/V5k0ddOWzdc+wYOA09+70FcfmzXRKas=;
 b=kMJ3zfFgyIY/P7RiI1SDD4+7XlR9qrSGuvlcAggoDH/UMuvM+fVOR/15RL0UYgZarHHEMC44ipE0VaVxflGhoQB7/ZKkQZqtpI2CxqY6h8dEZUKvXeQMyp4ys/yayddrOpyeHcUOff9DT0bXeTiZeWt5jRFtAnjQRhtA4C/hEJHtyuHskv+bazUdQ8Yy6Vo7ynnfbfv1RqY3/6xqbUuTSQSyDR9yrV0AWXyRqo/JG02Pq+Qy2QLW7yF++i8oEW9JbyD36qa4MyRQa7o26paBeMnwaulM5oj/3/D1PMIj2ODBIRSm5SIsMAe8KM5MBw99HE0VI/nFYISp8/G0Vg7bEw==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by DM8PR02MB8294.namprd02.prod.outlook.com (2603:10b6:8:9::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.33; Wed, 4 Oct 2023 07:58:58 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6838.028; Wed, 4 Oct 2023
 07:58:58 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, farosas@suse.de, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v11 00/10] migration: Modify 'migrate' and 'migrate-incoming'
 QAPI commands for migration
Date: Wed,  4 Oct 2023 07:58:41 +0000
Message-Id: <20231004075851.219173-1-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR15CA0022.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::19) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|DM8PR02MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: baa60f97-4a54-46ce-ea42-08dbc4afc390
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dV8raIz50TPz6niFeNHR15fbo/QBKg0Nxl5JjEYrI2se3DOlfDGBV6PEoXEwesdWupbrjY8Mts+aJrIryTkARxx6Q2cql502X2Rl+omqQs0tcLqzbfadij8urlD0Km4qa23qeAGdNsETFIIMma1j2U2HRfaK29kgIksENjwzJx+GtclAGiHFS8T4d4oHSrevnxRQvXu3fs3EyzO9sKtU5feMY7+3Cv0PAEU7DRBqfHbsPZT8I7FoO68dMcIpFXpuKrpOKVxuGMSWbdX4q3VRZOnPv4gSMLshup8BSHj21sTaketGpvRAIFxmRAoQvwHzimH+SXFMnYOpsasZ8X5b6/NqYc/cI64sEyon2JzNdyYDU4zsfSXKxSumypSvTGY9fJhOK2k1Bzckwqe/et1BK21euFPX4oxL2zNHjg2TgejEEvYxX5feCsX/jfSMCrYnSMv5MX3LoK/imUYxxIRp4jyHxOFPGL6nUqxPfLB5FHO3SJui+VDNiD/a5ZKvsquexiDRMmhD7B4wm/Hr46FOSePmm+8R0ByNrC74Q+ZqW5n9NaV2ICFbBwdiwji4kkUl9kmf6A7twSxUwDW+R/ACWmtWnlRSOR+f36WfUyeBKJM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(1076003)(41300700001)(107886003)(6486002)(2616005)(966005)(52116002)(6916009)(66946007)(6506007)(6512007)(316002)(44832011)(66556008)(66476007)(8676002)(4326008)(5660300002)(8936002)(26005)(478600001)(6666004)(2906002)(83380400001)(38100700002)(36756003)(38350700002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlJvTmFienE3ZGNGZzJlM1lpWjNPd1NReXJaaXRKU1pJNnhPSSswMXVoMGs2?=
 =?utf-8?B?Vi9hM0FqbjNOZElnZ0M1Z2ljc1NXTGJUdGxydVVOdkhnSjJtcndjbVQwTFFT?=
 =?utf-8?B?aXQ0TW8wZzdCemF6bGhrdGJzTWMxcEhrclo0NDB2SmFTYXFQSVZNdjdMZVBL?=
 =?utf-8?B?UmZwSlpNUkYwUWhtV1BXWStBWDUyYkFOcDJPZVEwSFV4TjdSR09OeHhrNWw0?=
 =?utf-8?B?Yk9PeHZocGE4MGpVeEx2RUVzNDRacUYrWkdvckJXdjIxT0QwL2UvTlBTaFZ0?=
 =?utf-8?B?Y1FSMGY3bzJQcXZmMWFtSVFUbDVMTVZUV0Y3RTNwMU13RzI0MlJhRFJWWWxR?=
 =?utf-8?B?RUNoK0hxV2VlL1UrZmJRM3RMSHkwNzZMeEVxdGMwUmRsemY4TUlrWUppcEZm?=
 =?utf-8?B?TG4yMjcwa3RuNDFqaUgvSjlJU0RFRkI3TFZWbTRtazdQaGwwc3NWZWk1R3Q3?=
 =?utf-8?B?d00xYkE4M0lUa25mUkxQNE96RDRaUUc3eGtrZ2dwQWEyYTBURmE1NzlYL1BL?=
 =?utf-8?B?ZGxQOFI4YlVDc0k0MlhmVTdJWGF5S2F3bmxzZDNWaGVTelJlQ255UjRhdFpB?=
 =?utf-8?B?K3pKMkFHK1NCWldhaXJxYWkvMVBWZFdOOXdOblIzdEgzNzcwQk5id1ljWXU2?=
 =?utf-8?B?Z0NJd0NzQkJYbzBlZzJERXMvK0hHalVkbkJJOElsSDZUWTBrTHpuejIzVzg1?=
 =?utf-8?B?L0Y0cEFQS3pmMldvREhIZUVQbE56YU5ibHV1TzUwV3hDMSsvZWF2clE1dUhr?=
 =?utf-8?B?cDVSOWhsUzRoa1FRY3hsOUFkZDZ5SGF1aGhSRUdCTU5XYmdKbFlIdE9GOWlO?=
 =?utf-8?B?SlhLL1Bxa09uT0JSbHI3eTRXcmdsVVZBTWowOC9CbGVtbW44R0QyMmlKeUhF?=
 =?utf-8?B?SHRaU0E0SWRzMFRiaFZORzVwdUt6THpXY1orbVg3cGtsSlh5aEwrL0dWakQz?=
 =?utf-8?B?YisyK3pWa2VwbGlPWStFMTg4d1JPSm9xaCs4ekVsekdvcHUrSVI3c3FTYVYw?=
 =?utf-8?B?VXc4MTBwbnRDME1USjJPNnVOTnhyM056OTdwQThoRXBqMWJVYjBRUWNUYmY5?=
 =?utf-8?B?KzlCa3lFUjRjR2ZKbEppY2FvUVFmNzR4cWhLOUQ2U1NEZzdRdExsandYY0p1?=
 =?utf-8?B?ZVlhSmJ2WWpmNDk4NUVUV3JubWZibVJZTWVwS1ZPc2pGV0FBby9rc0lxYVZm?=
 =?utf-8?B?M3hRN3M2Y0N1SytVNE5Nclc0NnVOUmFTRDFVdm5GczhXWUhDQXAyZCtrYUV1?=
 =?utf-8?B?VUdjUmtsMjEvZEpPcU9aUUpQTFpTNDFmTkhQRjdOLzhHeFc1d2oxcHQ4UkVt?=
 =?utf-8?B?eUUzRHpTSnRWTEEwc3Ntd0F3SGRvS1EwTHlTRmMzWmN0TkRhMnhQckk3S0Zp?=
 =?utf-8?B?MkJHRm1hVmVQMGFkbWU0RFlSMWg2cmdxb1VubHhoc2ZZcm4zWGQ4TTZMK0Fk?=
 =?utf-8?B?UHIwZVJOQndHR2pGdTN3elVsNStyc2RpUWordjJrWGZlUW10SFYrSmdjOUEz?=
 =?utf-8?B?cG5TY1VzR3ZRaFV0aHNpYTFmazQ5Q2lZV1B4ZjJJclVoRlF3TEM5TEQwcitR?=
 =?utf-8?B?MnFzSzhwMmNGRzhadituOFdJcW0zTFc2Uy9tcjBQMWtPQU1YVmtMckNzR2tn?=
 =?utf-8?B?MGl4bkxOcVI0YzY5eWFPSS92Mk5nSmMvVE5HdkttdlZOVUVtenU3QVRvalZF?=
 =?utf-8?B?eDZNK0Nudm1sek5oVDZmM1lORVVVSi9EaW8rMmpQS0hGaVd0eUlBK2NkMGpH?=
 =?utf-8?B?ditBWDJDamhCV1dPVTJnNnB2a05xNFFzSjdsTEhlTXFsR0Uxa2hTOFBIY0Vo?=
 =?utf-8?B?b1lnUjh0LzRDWENIQ3psUDhlUWNma1VZS0o1SjVXamFhU3BuOEtad3puaU1R?=
 =?utf-8?B?c1JyT082YmdQNjBOZjg1alRvK3VEai85eUsvRDRpdXRsMFE2RFFHcEZtbGNh?=
 =?utf-8?B?NlZoTUduM3hmeXplTkswL052c3ZibitlOFp4cGdEYm5DaWRxQ0kzaXhYOGtZ?=
 =?utf-8?B?V3VLbXd3RkNGekhOM2VjdDJvSWxTODNQZk91MndLaFZKZk82R2JJMytkU0ta?=
 =?utf-8?B?cE1NNGIwNUZQKzNmcHpUUHhZMHNsYnkxMGNUUlJzcWRKYVlQakZ3TUtLYnBD?=
 =?utf-8?Q?fBgBngwiG1IWfAlGMlk0SafL5?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baa60f97-4a54-46ce-ea42-08dbc4afc390
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 07:58:58.3761 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UWDy5Ne0Zj6x5hd6kW0tNkVvUpxejQo4Lnzn8MEfCpbKBuV0PEm48zoPGc8dlT4v4hfdR2nvtg5/nLmWl4lzFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8294
X-Proofpoint-ORIG-GUID: YyXF2_r1-pCchBHRJq3AGQhCWJnj_Zwf
X-Proofpoint-GUID: YyXF2_r1-pCchBHRJq3AGQhCWJnj_Zwf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This is v11 patchset of modified 'migrate' and 'migrate-incoming' QAPI design
for upstream review.

Update: Daniel has reviewed all patches and is okay with them. Markus has also
        given Acked-by tag for patches related to QAPI syntax change.
Fabiano, Juan and other migration maintainers, let me know if there are still
improvements to be made in this patchset series.

Link to previous upstream community patchset links:
v1: https://lists.gnu.org/archive/html/qemu-devel/2022-12/msg04339.html
v2: https://lists.gnu.org/archive/html/qemu-devel/2023-02/msg02106.html
v3: https://lists.gnu.org/archive/html/qemu-devel/2023-02/msg02473.html
v4: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg03064.html
v5: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg04845.html
v6: https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg01251.html
v7: https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg02027.html
v8: https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg02770.html
v9: https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg04216.html
v10: https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg05022.html

v10 -> v11 changelog:
-------------------
- Resolved make check errors as its been almost two months since v10
  version of this patchset series went out. Till date migration workflow
  might have changed which caused make check errors.

Abstract:
---------

Current QAPI 'migrate' command design (for initiating a migration
stream) contains information regarding different migrate transport mechanism
(tcp / unix / exec), dest-host IP address, and binding port number in form of
a string. Thus the design does seem to have some design issues. Some of the
issues, stated below are:

1. Use of string URIs is a data encoding scheme within a data encoding scheme.
   QEMU code should directly be able to work with the results from QAPI,
   without resorting to do a second level of parsing (eg. socket_parse()).
2. For features / parameters related to migration, the migration tunables needs
   to be defined and updated upfront. For example, 'migrate-set-capability'
   and 'migrate-set-parameter' is required to enable multifd capability and
   multifd-number of channels respectively. Instead, 'Multifd-channels' can
   directly be represented as a single additional parameter to 'migrate'
   QAPI. 'migrate-set-capability' and 'migrate-set-parameter' commands could
   be used for runtime tunables that need setting after migration has already
   started.

The current patchset focuses on solving the first problem of multi-level
encoding of URIs. The patch defines 'migrate' command as a QAPI discriminated
union for the various transport backends (like socket, exec and rdma), and on
basis of transport backends, different migration parameters are defined.

(uri) string -->  (channel) Channel-type
                            Transport-type
                            Migration parameters based on transport type
------------------------------------------------------------------------------

Het Gala (10):
  migration: New QAPI type 'MigrateAddress'
  migration: convert migration 'uri' into 'MigrateAddress'
  migration: convert socket backend to accept MigrateAddress
  migration: convert rdma backend to accept MigrateAddress
  migration: convert exec backend to accept MigrateAddress.
  migration: New migrate and migrate-incoming argument 'channels'
  migration: modify migration_channels_and_uri_compatible() for new QAPI
    syntax
  migration: Implement MigrateChannelList to qmp migration flow.
  migration: Implement MigrateChannelList to hmp migration flow.
  migration: modify test_multifd_tcp_none() to use new QAPI syntax.

 migration/exec.c               |  72 +++++++++----
 migration/exec.h               |   8 +-
 migration/migration-hmp-cmds.c |  17 ++-
 migration/migration.c          | 190 ++++++++++++++++++++++++++-------
 migration/migration.h          |   3 +-
 migration/rdma.c               |  34 +++---
 migration/rdma.h               |   6 +-
 migration/socket.c             |  39 ++-----
 migration/socket.h             |   7 +-
 qapi/migration.json            | 150 +++++++++++++++++++++++++-
 softmmu/vl.c                   |   2 +-
 tests/qtest/migration-test.c   |   7 +-
 12 files changed, 409 insertions(+), 126 deletions(-)

-- 
2.22.3


