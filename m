Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 357B27C7115
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 17:12:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqxLN-0006Fd-TO; Thu, 12 Oct 2023 11:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qqxLF-0006E0-Pv
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 11:11:13 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qqxL9-0003eO-FY
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 11:11:11 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 39C7H34N029965; Thu, 12 Oct 2023 08:11:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:content-type
 :content-transfer-encoding:mime-version; s=proofpoint20171006;
 bh=PLttAoucIhQ7FCVAGpDQlY8ojoqytw329iXXeJo+I6U=; b=iE+aXMqy5VlO
 bL1FbNM87gGRWCEaEuv9AFgjvkije+jrIIWvctNJjlQyWHff+q0A/R+R7HxZFiKO
 d3chn5S6WCFGsXVCXaIg9BM+CvwFfJLMhBvVDvfDjpTc6jWhShOWo+9O0ub0uQwN
 duaISBgb7SNmHq/hVq5breROAlkJ56xS1asdPxcyqPJ3j/8pz6vrRCAWQGHj2gBx
 3/rkHFOrJ5jCiO1UoX0SNkKj1EKUyR/nL8Hw7eElfZrV7TPDvMUvEGxl95u0Gc7O
 ZPH7yJej5Zx77dIGd9ZpxH/+pXl4oHTPfpVNdde8Tvu3blTszAMqZqgWfPOKG7uw
 rayHD3C3xg==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3tkhu4ujr9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 08:11:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpW2XHTumGmbaLaWosDNvbgu2cpsIjl/RJ4MrHlZcq/qs8XFDwyXVskmGkecMFXpZEjouMchElT0jmGaz3ANj1/Nh4HXwTTAvtgkfQbu+HeGfHlq7wZ9FkiSg15Tj8VfaSkSZRj4MCxt0aqyoNPiREhumzoe5GKbUTKlh72y+5VSZb8/FtqXet0tTa131urcG8QrJQZBZJaCqktOYsI2YOB4u2GTDLCWJcpGJTxka+HJcgJbB7t1H5esc+746KfjIxlWRpcOio3TQUCpvuSQxLV/ZuxJsjUhgAX4NiPV7xSqOR14dvK2a1RrTshqvX0z1MY1Tit/GPSMTrYXhJ7aOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLttAoucIhQ7FCVAGpDQlY8ojoqytw329iXXeJo+I6U=;
 b=lcn89Et5zkuMb/cnfU2bUumyJHZnHXPVQLKZUISw8qM3YJGW3zrjR9jrEFoFRG6dq7N4WSrG17R5uzUvApgIKyXEbMI64xHOVxaDoM4twzMVFz4w0NdHlDIprAjaynzr8dZWQHzhePJMzoTnOQENujrj9+X+9AutpWubK08UghITdtA5JbcaCjU1M0DwFeLb2w5wwFQoSA3GI89CKm7wH3TtbUhFyrN4av8AwV/OlI7VYHTmnedvhBqDrhOehv/f8kfLEImU4Qg5zEb9UzVK1nQocy5PREIz16XZMj+xH9wQ+BlJhDCN2fQ7eD08Pc8e33yfhG2bUCOHN+dWtDE44A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLttAoucIhQ7FCVAGpDQlY8ojoqytw329iXXeJo+I6U=;
 b=t6PuikE5BfVSjjepw85z4PqGduI23bBwBlDcYGHZ62kKruE7Ueri8IXWmUQz3D3WhIcH8WNWoX9NX4bExDqfPqFlpIGalvPhQUViR/iePLc5SNW5ZmRyVjP/iegc1PwNS5ai8OdedWBK5erpEJvcpOKDB8uOYEDpu6bk1jbPEw1edwFFFm2qgRWo+CWwS2inZVC2RihndC1ElktId4vZDFKgggSvGcH7VqSZ9wYSktxY5pWodmdu3iXG+Ax6sX7bgotQh4+hNorugSTw+n30yL0PPMavdIzyojQvyUFZ9siuNG3Ih3FVFYpQ4bQMxLHKmWFefuvO0cJJIQ8rSKzqQw==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by IA0PR02MB9510.namprd02.prod.outlook.com (2603:10b6:208:403::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 15:11:00 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 15:10:59 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, farosas@suse.de, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v13 00/10] migration: Modify 'migrate' and 'migrate-incoming'
 QAPI commands for migration
Date: Thu, 12 Oct 2023 15:10:42 +0000
Message-Id: <20231012151052.154106-1-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR12CA0004.namprd12.prod.outlook.com
 (2603:10b6:208:a8::17) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|IA0PR02MB9510:EE_
X-MS-Office365-Filtering-Correlation-Id: f9968d77-ed81-49b3-3164-08dbcb357123
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GS2psn7bsqRXxo0yXqxsB0eW3q7jNjW1XYiH73KDadUyhI5kc/FH5ltV+1NBO3iuMRc6NqD4vslmQprpiY8GrcvHwfHwwyTkTl2tGLLkK9UTHvpVlneHfS45WbhsSVRZE1DVO7i5DNi7Og3lv+GXMEW3sigHmJmC5WHae7Wi2wBW7hOGhCbcYZtYHGyyfY2VTGGVmC7RlUdoA/IOFKUel1pZ4WLxOuymeQolfMw2KAYKgoO7LGd9qBy6EVXgWJ/Yr9IUeyTibgeat7Ctr1O5haFls6ssOAE1dsRLLOvNFTfgvs95M8DpPtbTZQ8edPUCJIc7wofwaoC/SEHt/9yBeJ3ka77VEHcMnCNxgVWlajqZ7ozdsGdt6UvBkKeyQp8sf80wuEIRMbN/8Xgxlge37sGhUSKw9EcWAxKOdQiIIxOV1bPSlpqVUYEdMrYrnREpf5CWcL0ZYFa0lX5MJkSlMl6q5L8BmlSspGwOAI89ypQytcRG9o4S4nhnsZ/fHOHghIe6BuZSzifi8XkZHytTwA33UJ9wPp11M3yzt74rKDlT0WRkYnphlj6YtBs5ZzpwJdQpMWh5R4SilPVp+tg7jKYkBQ8HC2M3fp6P01Z0VDU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(6512007)(38350700002)(38100700002)(26005)(2616005)(1076003)(107886003)(478600001)(6486002)(966005)(44832011)(5660300002)(8936002)(4326008)(8676002)(86362001)(2906002)(6916009)(316002)(66476007)(36756003)(41300700001)(66556008)(66946007)(6666004)(52116002)(6506007)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NW9HT0JxSlMzSGc0Rm1iRS9uZkNLeFlOZmZRU2k5NWx3WTBUMmtWV3MvNzQy?=
 =?utf-8?B?eEVjUE9TUWJNd2dLMVAraXpybEhzMXNsWmtaL1M2Z2VhZTFBKzNpVWRUZDlI?=
 =?utf-8?B?S3k0MWVmcUxJajJIWXoyVUo1L251UHVsdU5nN3k4NEY1dmdYMGwyUnZUU0dC?=
 =?utf-8?B?TFMzRERmNlQwaEllY3RadU11bit5em5HZVFQQUdIQmVlWlhMZTU1RlVjL25X?=
 =?utf-8?B?Q2dBUGNGRlJ1cUIwQjFCT01vMjBVdzMwMzVmUUFjc0RjTHNvdnVvK1JtaFBt?=
 =?utf-8?B?dm5CTGgwR09jNFVsb0FVc2ZNdVFrakoyenYrVnRsZFlJeDIxejhudDEwT0NK?=
 =?utf-8?B?akNINVVHT01IaElaUmdaZ1dwaGUxUlAzT1lSTEx1QXRNQlNJMlYzTFFMQWs1?=
 =?utf-8?B?cTBWRWxuNU5NL2ZmZG9kdVBFZng5MGR4MElSVjhTRmNSeDlXZVNwVXlFbGx6?=
 =?utf-8?B?d3V0dTloMGRIK3psTFpaSmhvcDNvbGx5aXYvOStiUTZzYVpMWExPSGdibTVq?=
 =?utf-8?B?RFB3RUlCMDkwd3RMeDFodGlsMkJyWGpFMTZnMWtWd1piZGhZWW5qdHBRTGt6?=
 =?utf-8?B?Y3pmbGdkV1B1SWhTV2pBRHg2dS9GYTBPTzN0WkswaUJ4MC91V3M2T3FCK21y?=
 =?utf-8?B?VTI2ejltSXZmMEc3MDNwZ29KYXRUUTRhbGtCV0YxYXlRS0hwK2ZNdEV3b2RI?=
 =?utf-8?B?THdVWnpNbkZxMlppdWh0Q2xLL3crYzlCMzVjZ2prL0YrNFFIRGFoYmhFQngw?=
 =?utf-8?B?TmhyS0gxb0QxZDR4WDVLRE9iaXNzVmtzL3U2eDJqeGpCandzTmFoVVcyckVK?=
 =?utf-8?B?a042QXRDbG96alRFUTdMdHZFWDRVWE94RkFsb1BoR2NhR2dBbmIyY0RabExT?=
 =?utf-8?B?TVdOL09WcWYzOFFGVXZGdWVJKzlNYXh5Z1lwNmIyc2taTi92UFVxdVFsalJO?=
 =?utf-8?B?MXIvaFcwWWpSK0xzZTFWa053bXk0Uk92Y3dBdXJRTTI4aGVYWmMwZFRsSEJB?=
 =?utf-8?B?V2Q2QXkrMWxNWUJHMTFvWFk2a0h5aHFEMFNGN0NIWXBvQ1BUckIrZXBhN3dP?=
 =?utf-8?B?bktUakxnM2QzVTd0UlJIbHV4UG10UTRrdUlIVFZHN0YxT2NDeFZzTk9MNm4x?=
 =?utf-8?B?ZDVTK0sxOTNmc010bjdmdjZiNTJ5Q0tTeUdWeG9ZZ3U2b3BTSU9XY0dNZ1E5?=
 =?utf-8?B?YWkzVkF5NDl4Vm55L2ZkUFdMODJoWFpmZGpqN2gwdXNXeTVoN0NaQjFmeGc2?=
 =?utf-8?B?THFXUm42SVdFQ2VCQ2xTTHNzalNWM3RDNnE3eHpGTXN6eEpOK3dodFhHdzdE?=
 =?utf-8?B?a0ZadUpLeEZ0RFNhV0E3SFlOOWVwUnFWdGJid0N5WjBmdHpZL0Q3bThSbVl2?=
 =?utf-8?B?dWlWVFBzN05YRHpBYmo2dGhuNWlLbkJhWmxMZGVpUnVaV3QvU0pLWkhvclQ4?=
 =?utf-8?B?OG54SmV6bjNrdWRtdTNZcGJIN1dQU2hnckFiS08wcytUK2dhOGlOMitKVVg0?=
 =?utf-8?B?MVJtYm5wQ3FVbWhrUkN0K2VkSGxqT0oxaVZkTkRXSjI0Y2htRnRFOE5adlU1?=
 =?utf-8?B?ME5GRDk0QlZwemlYUHhhU0U5T3NEMytSNTkzOFIrdmRPMkZvUkZEa3VwOUVI?=
 =?utf-8?B?dFhzV1pLb2lyTkhKMUpNSWdSZWtlMjJNbkVPaVZIUEdqYzhJc3luZFFFSE9n?=
 =?utf-8?B?MjQyNjEyV3RJdzBnc0dYSjNmWm9iQ2FISUVIK096TGdkbDZCN3dJMDBSblVO?=
 =?utf-8?B?M3g1RTh5aVVjSms2YlV3VlVINlEyeFlWVXdtOUtYbmY3NjBxQU5DcXBVNm9D?=
 =?utf-8?B?VFgzT2ZpL1JjVmMyTHZjV1NBYXErTGJKUnJSUU9aT3hZYXpaWExGNnhZUlov?=
 =?utf-8?B?QW9wYmUwMUx2QzgvOHV1d1dQdWQ5K0N2bGdDTmJLVERiVGZ1WTRNZVhuM1lu?=
 =?utf-8?B?N1lqclR2bkZZbXNzTjJZWVlsTVM0eW0zNmRHQXdlQnhRS0pxa093akp2QllG?=
 =?utf-8?B?ajMyOW91WCtMRE40Mis4V1JPQWFtUndmdDFCb3EzdS83TG1TWGFDN2xXNjRX?=
 =?utf-8?B?Qkh2SU1veXBTWmhKM3dGYko1ZlEyVEhPckJwRXhNeVF6UEpQQTVRZk9DZllQ?=
 =?utf-8?Q?RAm2XPq4nUptdR2F74FiM0QsX?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9968d77-ed81-49b3-3164-08dbcb357123
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 15:10:59.6863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYa67L+XLF+fQA89Spn85lALzXjizEybB+bcIrYFZ0eNe0NSJsSv+XAFX45k8yMbRDJ5m5718AfbgpN9W+wxEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9510
X-Proofpoint-ORIG-GUID: R5pamj4YYh4vnCns9Rvx40HYv5Uo0vn2
X-Proofpoint-GUID: R5pamj4YYh4vnCns9Rvx40HYv5Uo0vn2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
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

This is v13 patchset of modified 'migrate' and 'migrate-incoming' QAPI design
for upstream review.

Would like to thank all the maintainers that actively participated in the v12
patchset discussion and gave insightful suggestions to improve the patches.

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
v11: https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg00740.html
v12: https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg02422.html

v12 -> v13 changelog:
-------------------
- qcow2 181 test was only failing. Fixed the code to pass that test
- Added HMP side error propagation in case user entered invalid or wrong uri
  for migration.
 
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

 migration/exec.c               |  74 +++++++++----
 migration/exec.h               |   8 +-
 migration/migration-hmp-cmds.c |  27 ++++-
 migration/migration.c          | 189 +++++++++++++++++++++++++++------
 migration/migration.h          |   3 +-
 migration/rdma.c               |  33 ++----
 migration/rdma.h               |   6 +-
 migration/socket.c             |  39 ++-----
 migration/socket.h             |   7 +-
 qapi/migration.json            | 150 +++++++++++++++++++++++++-
 system/vl.c                    |   2 +-
 tests/qtest/migration-test.c   |   7 +-
 12 files changed, 419 insertions(+), 126 deletions(-)

-- 
2.22.3


