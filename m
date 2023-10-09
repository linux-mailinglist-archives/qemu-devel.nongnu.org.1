Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5207BE307
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 16:38:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qprNT-0003QI-1w; Mon, 09 Oct 2023 10:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qprNO-0003HR-QH
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 10:36:54 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qprN9-00033M-Ng
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 10:36:54 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 399DB8Lj008843; Mon, 9 Oct 2023 07:36:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=wdphVivksPcEpzXgwxtfmuc5muVTRJbgLjSKlm3eT
 9s=; b=lX4OlqmFUZARAFCZsr6Xmct7xiZc4CcjBzU8UYJB0abOpFchY6t9CI7Re
 x28YSvcAGR1LKJ4hqgjVj4tDrDJ4R2yK9zZVniy3PBxQtJ/zf7ROQBfJHVNUrUKt
 6zEM/VM8+0eGGuCuK81G2FT67UQWPntIVnNwgfTEt/f0IA/EvPgvkKmchn6eoVXe
 evLpokOH0CwHsIyFai4T5s82mcl0mGkzbNic0cMxSquLNmXYq+Qc+47+mEOw1Zyv
 MdOFezCmaXiYGwzRFd7CFnckDNc7+lpTcEdRpiRi6Qp9tyqbXWvnp7DcCnudr81e
 cKfiQu5kGktfvYnIIX0+tJjJzakyg==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3tkhtbtt3m-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Oct 2023 07:36:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqYganDIDFzctMWbD9c1l/B4mlFlezkat1P+NOrRbX7l30MJhaNy39wGYSOlUmXs0ttDOGhK0Sq8Awuu08nFGRDcnc80ZcCfn08w5KYsT78nqokXdOhzdLZZoJHPmLJvIzOyAT4C/VnR6k6k6xXOklAxfYB2ckHBOYPll9rUubwnIZeRxtplwbpBD9bsaPK3kiqTB3tShZZPn7PQdtFUIl5kt7go+b7bCARlIIwlQz25jvyjenCd5oUedgNb1FmBSSzrex4Dp/bUtE3j2usFQXoziRAidKA5spnn6q9ceqL4YKZ8w+JJ8j3tGNLzLX0AwqofSc3/mb9Lny8B8q0e4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdphVivksPcEpzXgwxtfmuc5muVTRJbgLjSKlm3eT9s=;
 b=iXVX4yf17pWdcPDcjNzmbPb3ZKG9AuUg9EoYRW/VNV5w84TzKwq9A4urG1C3PZ1ay75+ikjLnD1bAYsKax0E/NC5oGl0Eb8vgvUYU4cruoOgDnyCfMAG2a0JZQhQFtzppB80dc0vPTvsy11ay2QLSGKljlu+QGhRQz+LnRHDjSk4fWQMHCKTDPvmVVME/WE5nqor7QyXnfMC9MUOGIk21QCKaE4WtJYaTWI5h9c8NCKS6jQBXZFuHdBjFbvcAwFN0IowjCLLsL6Kwz491DMganzy/rEm/mT/32vfSbwWp5oJLURd8YlWUccDb4NpzZqqwoSLTmlRkL2am5m3f2CJ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdphVivksPcEpzXgwxtfmuc5muVTRJbgLjSKlm3eT9s=;
 b=I05YfBChjOmy59L9rl/fsiAUXSCqTOXfvIWfj/MDO0hwhChzWCbZFiKDDargCOYZfnajOZWjPbJo8rUxPdSNFWT3OAbhNHQoztVaaaQ66COxvI4To4O20P+bvCiZWhuZH2Wn3Jp5cSzPFT8Xccal2Rkqw42Md/5PhZQB2FRzukf9nhAZkpcqSLOIb11DPpKSyo5AoyRGNXD3eqGujcgoIzQ0rsRk4vi7iTzmtqNfFihrYtBOr0InCIIq9kbs8k7cIWGsNw0VaUEt//eNURNbFpXjvWMA/AVnqrAgDn7cTF+bdY/OfWgcLBL9uo5SAC+wN30NDMtAQMl57UV3FgIO1A==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by BN0PR02MB7888.namprd02.prod.outlook.com (2603:10b6:408:160::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 14:36:29 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 14:36:29 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, farosas@suse.de, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v12 01/10] migration: New QAPI type 'MigrateAddress'
Date: Mon,  9 Oct 2023 14:36:06 +0000
Message-Id: <20231009143615.86825-2-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20231009143615.86825-1-het.gala@nutanix.com>
References: <20231009143615.86825-1-het.gala@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::30) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|BN0PR02MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: 0646728a-3579-4e0b-e429-08dbc8d5202e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DCnYbOU343yKQ/NkWNEfuuGchrtRuxbWfwF3quJAaM5RqqMnfV2RQZoTIF+NUpoBymXfGKgTF2+dIZ2hHpgs3H9fhfzHKlo8gw2dZhejFzSXdjlm0biPPgoNiPjvTjI36wrO/CXEF/VPkqUD6DfXclF0Owm1Jgm0g0A7utg5zIqqw1Pi4DhhdW7ysx2kr/6J+PLyJKYU111OvJiOvMYbMb/znetwAiD+sbB/7sP9KowFCopdWVDTDVbBd2mvslOQEoliJ/uny1kyR+ffqA53IyrqZMrBZjwVISQ2MbzdrOeoACo/nUGI7s65v0Anvdl7fqHQUXlJ32AuFm5eBFAy5yhBb08LChF40pv6yRlHHad6Le9xkVQ/gtMa/PrD66yRd0URX/c0wjoQfLv6ulkNWTsGp1L6WOXEVKeOSQ8LT//oRQ4YO6LVxXQCMjhkTrS4QYo9MZ6JiIZOud+YooJ3GkNYyT1Mul6JbtI+EwiN6u+tD10+9sU8XFzML5m+WrcYPOIzhYfht0FD/gpB+gPtxzoFvJprMeCqQui315PbaVR/MWxchWZLDpitExw52vcTit5WnbzaEQZwVDXRO7wYaD9+LZTqdTwUSZ5pctNXIqdkYfDa3Sm+Nbo1Ufjml6ZP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(396003)(346002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(66899024)(1076003)(52116002)(26005)(2616005)(38350700002)(38100700002)(86362001)(36756003)(107886003)(6506007)(2906002)(4326008)(478600001)(6512007)(8676002)(6666004)(44832011)(5660300002)(6486002)(41300700001)(8936002)(6916009)(316002)(66556008)(66946007)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjZPdE45Q3g2ZmZ5WkNaSHcreDBxdVVab1hOR1lobysreHB1TnhUUDltallw?=
 =?utf-8?B?ak9lMTh2ZkpYRE8zMk94SEgxeWRzdFVZVno5RlNvaXRGUndmMElOQ3BLdExH?=
 =?utf-8?B?c21vVll3K00rK1FadHlVcFByb2xJQnRzc0tkYUR6MlJ0QTVmaTYvL1pRUnhr?=
 =?utf-8?B?Sm4wYW11eS9ScEpyVVd1bG10YW84RzdqaXp4eWNMSjNia1VJd2pvRExmZXNr?=
 =?utf-8?B?ZnhTa1FiaDk0Ly8yNFZ0OVRzcFVqem9NNURKRGt0Sk14Zkw0MEc4RXVrMFBT?=
 =?utf-8?B?NUh3QklHbHF1Ylg3a1J6ZTRWdWMvWFI5bGlDK0RKbndKd3djbHA5YklSbThT?=
 =?utf-8?B?UDN2Vk9sS3g0R2FLRXZKNnNjMFdoVWlCc2ZGYTVqamVFeGRnWm02Y0U1cXJY?=
 =?utf-8?B?M2pIRVl0ZHMzYW4vYUdUV09uRUE0bTFkQUlBY0x1aW5nb2cvWTVXWk9ETnhC?=
 =?utf-8?B?aWF2TUtPV0dhVVZZTkZsS28zZDFJbHI1ZzVIVXcwdnBTbjJkbTlBMXBuNXZO?=
 =?utf-8?B?RjdIbTFHaWorcjc2RzhZekowQzhDaHBIcHR5dXlmNmRmUWFjYUg3WWtINHNa?=
 =?utf-8?B?VE5DWkRNblZSbUtOQkIzZmdnODhMMHJkTTYzMHVUdzRXR3VIQVBndnpPdWRt?=
 =?utf-8?B?OHQrb3JkY1hnVmVWa0Q0b2pNU21MRTdLWHRtT1hlcnRzT1Z6M1MxNFFXRUN3?=
 =?utf-8?B?V2xuRk5YVW9BY0dlZnlXTjE3cGIzQlR6bTkrOEZBaWdFNnFWeWk3NEt4Z2FP?=
 =?utf-8?B?ZVFVajdaaEFpR3g0STZNaHh4eVZoTXdZbGE4QTU3SUpFTndnS1NvUFVnZmVD?=
 =?utf-8?B?QWVlYkRvc2svRUVrQ1lyZFE2dFlhZjRKbHJwVHdvNWg3YnBVVGIzSzNkZ3BL?=
 =?utf-8?B?bjZaM3RGMTUzMVV4SzFVWXp0MkdBc2s3Z055anlHTUliekM1blQ2QytYb0NN?=
 =?utf-8?B?elZhR1UwM3lxL1l2N1NrZitQWXA5RmYvTldOcGROTWtNMVZja3g5d1JHSHBo?=
 =?utf-8?B?MEdoYzZjazRjV3hpYUlZOG5mcWJldGZDNk9XVW5qMXIwK2xTTW5abE9FVVlJ?=
 =?utf-8?B?NTN5OVZmVTJLcFNpbVpNUS9obDdRcmlYckI4a2NqUmhHMnhQMDFBTXpvMkE2?=
 =?utf-8?B?TmlQdFVRcWJFWUJLSHEzWWJaS1lONGxubitSamNKVFNnWHpuWXJSNUQ1elRs?=
 =?utf-8?B?QUFRT2VGTDMyM2RkR1cyMFNHSExPWDc5NDRueVdPdDc5L0oxeFpDcFl1S1NZ?=
 =?utf-8?B?Q2tzUGJxYzhGa2JyQzQyVmQ3NWN3V2p1c1JFWEJhZ2wzMUUrVDlxU0VlckJS?=
 =?utf-8?B?U212aFJURGw0eGZmVThiVEl3S1dSbXIwUld1RjU0QjFrOHpGcjVwTDI5b1ZL?=
 =?utf-8?B?RDNrWHNTRkJoSWtxU2k4Tlp0blN0UVNvQ0pWTFZyQ0s1aTB3RTNyek8xblBk?=
 =?utf-8?B?RiszVlIzRS9BUGRLNUR3ZVpoZ2VieTFhTjljTEo5S1hza2N4LzhaZEsxNU5p?=
 =?utf-8?B?ZUtBbTBDT25kczZ5QTlXM1NWcTdWQ0dpQVNPbGxBRE5STTVMY0kwUUFsSXpX?=
 =?utf-8?B?Z3g2Umt4S0VhQnpqaWVOZEZ5WVpPM3lhRWJwbTVNMFJqTWQ5enhuWEJsYTRZ?=
 =?utf-8?B?MzJ3TW43aGRqWDlyTmN1Zkhha2ZFQnpIaTQzeUE4M1FjcFU2M1Z3YUg4ejN5?=
 =?utf-8?B?RXloaUdDczZZcjZ2bHFDUHRUWmxKMjVHRFFzY2lsVXJ6T0d0V1pNRm16cnhW?=
 =?utf-8?B?dFppdFRnWnJKWUQyb2pqSjZJRThHQ3dobW9La1R3TnUvekRMTm44emNEdDdS?=
 =?utf-8?B?MEttdEw2M2dZQ3grWmUxV2J2eUozRzdWd2hscVRlN2ZENW1DdjlOWXk4OFFw?=
 =?utf-8?B?NWdRbW5JMjZEVHI2NkY0eHZCY2xHTWQxZnJWdnMyZVY2Z3pFVHBLSGpjWkpH?=
 =?utf-8?B?TmgzWUtTRGw3TFIwcFdIRDVQMEc2YXFsMTZ1WDB2dThMYmdqdXJTMUh5eVlt?=
 =?utf-8?B?cUJ3NCtFSURMYTAyNFpIdUJ6U2ZNYmVQNVZhV3RHZ2EzdmRkb2Z5U09lNVF1?=
 =?utf-8?B?K0swQ2V1TTloMEU4ZGhRRXNYOGgvNU9OWklVc3lkVk9Rcmx2R3JXRkFwcEw1?=
 =?utf-8?Q?JConvDElmtxnjLBPIZJfB55wQ?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0646728a-3579-4e0b-e429-08dbc8d5202e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 14:36:29.7999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BlonAyVg9G1BYMQJF+4tAzeIaCqT6gD1QFhFPyPDffW5dqqwTu4GT8K0PuFysA9Ah1fBolkwrlSZfQDP7NFS6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7888
X-Proofpoint-GUID: GaNs1nvG0jWSZ04eBLlR486ms0vOnVEY
X-Proofpoint-ORIG-GUID: GaNs1nvG0jWSZ04eBLlR486ms0vOnVEY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_12,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This patch introduces well defined MigrateAddress struct
and its related child objects.

The existing argument of 'migrate' and 'migrate-incoming' QAPI
- 'uri' is of type string. The current implementation follows
double encoding scheme for fetching migration parameters like
'uri' and this is not an ideal design.

Motive for intoducing struct level design is to prevent double
encoding of QAPI arguments, as Qemu should be able to directly
use the QAPI arguments without any level of encoding.

Note: this commit only adds the type, and actual uses comes
in later commits.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/migration.json | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/qapi/migration.json b/qapi/migration.json
index 8843e74b59..4e4c39a9bd 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1478,6 +1478,47 @@
 ##
 { 'command': 'migrate-continue', 'data': {'state': 'MigrationStatus'} }
 
+##
+# @MigrationAddressType:
+#
+# The migration stream transport mechanisms.
+#
+# @socket: Migrate via socket.
+#
+# @exec: Direct the migration stream to another process.
+#
+# @rdma: Migrate via RDMA.
+#
+# Since 8.2
+##
+{ 'enum': 'MigrationAddressType',
+  'data': ['socket', 'exec', 'rdma'] }
+
+##
+# @MigrationExecCommand:
+#
+# @args: command (list head) and arguments to execute.
+#
+# Since 8.2
+##
+{ 'struct': 'MigrationExecCommand',
+  'data': {'args': [ 'str' ] } }
+
+##
+# @MigrationAddress:
+#
+# Migration endpoint configuration.
+#
+# Since 8.2
+##
+{ 'union': 'MigrationAddress',
+  'base': { 'transport' : 'MigrationAddressType'},
+  'discriminator': 'transport',
+  'data': {
+    'socket': 'SocketAddress',
+    'exec': 'MigrationExecCommand',
+    'rdma': 'InetSocketAddress' } }
+
 ##
 # @migrate:
 #
-- 
2.22.3


