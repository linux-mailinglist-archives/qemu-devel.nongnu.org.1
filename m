Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D75BA91EBCF
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jul 2024 02:31:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sORPi-0001cV-2D; Mon, 01 Jul 2024 20:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sORPa-0001c4-U6
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 20:30:22 -0400
Received: from esa13.fujitsucc.c3s2.iphmx.com ([68.232.156.96])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sORPY-0001nS-DM
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 20:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1719880220; x=1751416220;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=SQ0VXqC6SSCSzJL8SM/m91JIk7IgW/qrJ/ev/EjrtaE=;
 b=QFzXj3TGf8sWZvxxITPuKKax++jqy1AGhtALNv8lQAkrjQgqJJjEUQeD
 JwsJYJFNBHif3H9lQFBZScLJcPPx3vF8XrZsIGYSjyQWdepW6WuVTXr0L
 81e0w+Tdvpn2tgCuwHDFNkltSwNBCw+CslBTSz+w5IRIr1/SwIvDGGrDt
 lAA0DmyBS5IhCMmhuERullFMvjd8YOQ4i8vkjMTVgWbi2TwJdutPiYHqx
 f79oxt/Ro0qbbfUwy3C/8LvrALCtK68/SOA6hL+JZLUNasEeuqUFa+JiH
 G3Ghy8ciCjREVLNDUQsqmlRJTWpmtjSM9R+bOvZIh38CXeJGtRhz7iCvd A==;
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="123480340"
X-IronPort-AV: E=Sophos;i="6.09,177,1716217200"; d="scan'208";a="123480340"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2024 09:30:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmLfhx/UYpPuvNieJZmiwoFPJq9XoiGkC9GAKeKEdSoBTi3QRZDnmyQf792dR5hphnT0hc6L8Mf/9kGEXN8F8u/vBbefLoQv/9OA4Cv2sYrKGOs1oxMnUhubtJUvKHrR1j1OixUKkws/iZNq2/0qrPGf9XzcON7TuKTExrLc01rZ0nmj9vt9ajmrlXve2z8LpbRI5YHKMIaHfjnj2f8jDjoAvYh+jTBLD7LHosM2yLQwnd/F+XfoiyfwEp5yQvd2KbHSSdRwOfzpP+pHkSqaHYoI70RsJwfp1pX27327AaThkCLw7ebwlBdwLLsyLMtrKH702yT2MHAAXOlxYEgzLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQ0VXqC6SSCSzJL8SM/m91JIk7IgW/qrJ/ev/EjrtaE=;
 b=YBH4gbSLRZcl9vQ1XcT7IIemkLWybxdYp79q6zU+uo/AgivCHUsgBEdqWe7RkF49tRE1kBEeYLSaSjGpXbLYwVBkvczFwpgZyZhguvzUIny5LPmr3EUnfCITmvgw6jbvFR4PIUhS/MVVbbY5Nlvv8LHY1k/vxzX90ewb1p0YjDVvRdZ0KniMWlBITX6LZDYknMypkfUSbFtlozPPhDk+CNvnCMgjhP1Nskz4rV0Z+LjF5k6ZCMpGvG1RxjxMUjnGLLnHtxKkS9+1t/9gZo/lsoISrRzyQGFqdvkrDSgRW7jcgQRCFfSRs/yNt4/mxkx2jszezGlgSkaXb9MAz33tYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by OS3PR01MB10234.jpnprd01.prod.outlook.com (2603:1096:604:1e2::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 00:30:06 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%6]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 00:30:06 +0000
To: "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Subject: [BUG REPORT] cxl process in infinity loop
Thread-Topic: [BUG REPORT] cxl process in infinity loop
Thread-Index: AdrMFtW53RjIdVXmRMmn3AEhtLCi7Q==
Date: Tue, 2 Jul 2024 00:30:06 +0000
Message-ID: <OSZPR01MB6453BC61D2FF4035F18084EF8DDC2@OSZPR01MB6453.jpnprd01.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9NmZkOWFjNDAtMWJlNy00YzVmLWE3MWUtODBjZjY5ZWU2?=
 =?utf-8?B?NDFjO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA3LTAyVDAwOjI5OjA3WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|OS3PR01MB10234:EE_
x-ms-office365-filtering-correlation-id: 5c6c029b-5f8d-430f-9405-08dc9a2e1f4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?utf-8?B?dkIwQTY2aUtWL0F2bTZuRlVRTFgrR0EwVnpWU3pMbFV6dEVoemIvQ0Rrd2Vs?=
 =?utf-8?B?UmxURzlTVmltcW1vSUg1ZEpUSGwyQVFZWERhaHVsVzRQWit6aGJTMjNEZjhW?=
 =?utf-8?B?TEI1V1FWMnR1OGhWUEwydFdZSGs5L1dNZHdGSGF6MzljcTB2TGI0UUhLK1JU?=
 =?utf-8?B?OWkwWU52NGNnQUtoWFFXdUNNSC9tWTVNZjZ0aHFWT0NFL3IvdHViU3hoMHVR?=
 =?utf-8?B?NkFaZVYrZ3d5MWE4QkMvS0ZpandHYWRWWlhvbzlsbHVmS0xlcDFzd202U1dE?=
 =?utf-8?B?UzFMaklXdkI2QStQSGNuY2FSNjZIWVBjSmdmcXZkMnlrd0M5UGh3NjB2Y2R0?=
 =?utf-8?B?Vk1tajZTTUdmUVVBa1ZUTFNwTTVybVh6eVFrZlIrWTlaSUhKWjFZUnM3WWZL?=
 =?utf-8?B?MG41TWlEangzSDNOMkpyZllqSnhyL1hZbnY3NnZNS1piYityd0RSR2FzWktn?=
 =?utf-8?B?aWIxRzF2TG5OeVd2akVpd09Wd1Jvd0IwZmJUUHZqMG9sZXliSFZZckZ2YUwy?=
 =?utf-8?B?OVZsdWRVUWlsZ0ZjNlhVSElkcWhSaG1HMFNsMXpNMTl0MVlKUFdVa2dmOHpK?=
 =?utf-8?B?RVRLTjlFbndCMXVGeFdzTGFSNUFscVEwOVJ3OEZjckY1N1dZQllaQWFoMzJ1?=
 =?utf-8?B?WmdlZHROajlmL2owUG1hM0s0TXdhcU5CT1BvdWt2c0dLVmlpakZ5bTZsRG9r?=
 =?utf-8?B?N3ExY01ldnJpZzBnWUE5UjVmeXhmVEwvNHFJc3YwN1NPZVFGUTJFb0dhYkph?=
 =?utf-8?B?cjI5dm9jWkR4eXczSVlVeVJ4c2QralIvTVdIVHZZVENvVUUxUlRaNk1kZ1hT?=
 =?utf-8?B?dXUxMTdXT3ErM0NvM1V3K2taNmdpdVVwd3h2REhtVFBOd3JzSzVOZmJQVnZi?=
 =?utf-8?B?c2FJbVdwS2l6bk82TzBIRnVtNVlKWWZxWGZicGJXV3ljcDZaelRqZWNuMGdj?=
 =?utf-8?B?a3Y2Q1FndE9la08rbUs2Y1hNVVRmTkNoVFlkVjU3dVZ1VGdQbmx6YmFOcDBO?=
 =?utf-8?B?dk1tQmQ0WVEzcXU2QUgxNVRiTC9RSmlkS0dyOU9Lb1VGeE4vc2tubzhzU0J4?=
 =?utf-8?B?QnNqZ29IemlJK0Z1TjBGWndiQ0FiVUdWRWx1eVo4dVpGTnFnWkhQK3JTVzBp?=
 =?utf-8?B?UDh2bU4rN2hnbmpXMWhFSGgwdGVyTDJjK0w2V0xweVRpVytTdHdqVWo5NVc1?=
 =?utf-8?B?TUY3b01iVWdRb2dYRGt2M1VwM0F0ay9XQmtvOG84QStDbDd5T2k2S3Mzb0Rl?=
 =?utf-8?B?SHBZSmE4d3RhUytvUWhEcWVRelJhclQ4QS9Db0t3eTRXQlRRTVFxeGV1VVB0?=
 =?utf-8?B?UVJTK3FoT1hhQWtzNGhzTmkrUlhUSmJtemZWUjJpb0NPcVVUY2JjWnExdjJh?=
 =?utf-8?B?N0k5ZjVFRHV0T3BSTXlPTEdBOEdjV3l5cEM5VVA0RHlEZnViN1FRd1U4L3ZK?=
 =?utf-8?B?Q2pvUGpheVUvUXJDeHl2a0txWmRkdDJXR3JMMEtpd0VEOFgzamE0SXhKVWxN?=
 =?utf-8?B?QS8wb24yaTNaTmtrcmRlcng5blZCVlBib2NpbFpwVFhmZmo5V0hHSnRjNlBR?=
 =?utf-8?B?T3FkUTlRYXJRRUZxRThQMUt6OWZ0VnB5U09YSC9Ddk5HeitQUFZySzh1djJs?=
 =?utf-8?B?RkhYc3V1VlR4TTRFK3pIYUlQY3JVTSswOTA1QTZKVXRlOExWejJxU3RiWHhK?=
 =?utf-8?B?Y1FJVVpqd282dFhra3ErWE1tb3ZoOURQQzh2VFBCWm1oUkNvNG5rRmw2MkxD?=
 =?utf-8?B?VDVJblV0U2VUd2ZzZFRZNjlMN2JSWVJheFd3SURVTGk0Y1phZCtuM1JnU1Qy?=
 =?utf-8?B?VG4xRUJscThXcnU5ZWFzM293M2hXckNHZHVoREhtdXhPcHFtK2FUN0FLdUpK?=
 =?utf-8?B?cHk2cWlqM2QzS3VPZzNOSjErUzRNTUZvcENzQWRCWSsxL0dwSjdtS2xaQ3ho?=
 =?utf-8?Q?jfdIsmlkFJw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(1580799027);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmJFZll3Lzl6QzU2TlI2VkwrRnVVVHBpY2p3dXNXU25sbXFVc3h6cEwwS0Y4?=
 =?utf-8?B?VHlMVXJCRWtqUGFLMVVBekhmRUZNOUlVRGpaODdBTFlIN1hzWTB2aDhFT2lz?=
 =?utf-8?B?b2lnUVhpTVNpTGRxTVFkUmNtUEttdE1EUk1SRE1YTEpEc1FOSjNzYzYrc2RF?=
 =?utf-8?B?YVZUVTdCOEJFa0MwNDhzVjFLTGNOYUpSK21sRGNUNWsrZDZHMkl4QUZqVk1X?=
 =?utf-8?B?LzIrS2xGak8zTWxpSDJoSEltamtxOUVBV3FkdHNRd3RmZEF0Y3FsaGNaUG5I?=
 =?utf-8?B?MG9PNTV2NVNNVU9UV0VROFZFS21pRjN5dUtGaENUbnNqdU9Rc3RzNnhrS2lS?=
 =?utf-8?B?VCtWRkIxdmtSSDJJRE92RXR3cXMvUk5Xa0g5SXlCR3BwZ1dIMkJqZEw1TTVY?=
 =?utf-8?B?OENTaFJqT1JHU0Q5UGJXV1hPK1R4Z3BXcnhHZnl3Y2tKUS9zN2czalJHY1Zr?=
 =?utf-8?B?cVZEZEo3OFY1cHQ2OTl5eTQrSTBMN25RaU91SlJ2NGpQQTFveENvVURHVnJ5?=
 =?utf-8?B?Y2t3UHh4aGducmQ4cDNQc1lvM2YvR1BUb2NKdlFnSnhFaFpqNGxULzNEcklE?=
 =?utf-8?B?bUd1RkErWnhaK1BrOVcxQVBsRVZhSjdjL2YrMXBTZEh2Ui9SVzhlTzVtSU4v?=
 =?utf-8?B?NFppWThXdCtOMnhUR0tTZDdycHB0VTU0UGRGdWxzcUNsaUphYnBzTmV1MjVU?=
 =?utf-8?B?bWdQbVVXeTJvNU9zc3gxc3NLYjZGR013UWdjb2t6YTVMQzdwN1BIWTh1V0V2?=
 =?utf-8?B?YXp2UTFYeENmYWZNRGVtQ3ArWGZlYUdrNjdWK2h3UGZyWWh3R0YrWjdnQjN2?=
 =?utf-8?B?NEpMRms0cnNURGRYdkpCYmJWdXNtREg1c3ozME0rb1ljK0lEN2tyaHU4M3Nx?=
 =?utf-8?B?VDBxSHl5QnM2QnczRG9NRm50OHMrTzU2SnZJWXRWOUhrSWNkRHlhR20zWURz?=
 =?utf-8?B?T0FnMDdjRzVwZDBDbTIvTmExN2FYVVNvYlEwZksvWE0rZittNU9GT3dVaEc2?=
 =?utf-8?B?Zk1PQThLS3V2aVB0YlUrS1hSblBXdTRSNVlWbmtCV3d2aHhwTkVoNGxPTUxV?=
 =?utf-8?B?TjBKejRtVDlvSFFBK3dHVjk0elFsOCtrbDViVmw2ejZqaUlDdDkrQXlUQ3Vx?=
 =?utf-8?B?alpHaXhVM29wVFZYczYrK21ENFlWSy9wanpXQkNRakNDVTB6NTE3Q2dDN3A3?=
 =?utf-8?B?NVR2djJoQmRUR0dMQjMrVVY5Z3VLc1NxYVd1Z2VENGhLVjVJQUFoWFhQalFh?=
 =?utf-8?B?NUZTbXoyc2RzMDdwZmtlNjB0WmdVZVpaeTAxTi9qOTIwckZCbVRveUhWMklZ?=
 =?utf-8?B?RlVEL0E1aXdlSUtDclVYem9tMW9YOGJSZ0diUTZKV1ZJZHYwV2VjRlBTbGlj?=
 =?utf-8?B?NUIya1Z5VnhyVDcrQmw1M3N5Uk55MmpiVnpxZTVXak12dUJjc1BCUCtuUEJm?=
 =?utf-8?B?U0pYTjZINS9saVU1cTRDUlN0eklHdFNUM0pTb1BWUkRMTnZKWnBwSTgzUS90?=
 =?utf-8?B?ak5DZ3ZqWHRIQ2tOMTQ3Z2FLY1pzSFlxWTVQTXlpVmhVcllwby9rUFFxUnZF?=
 =?utf-8?B?NW9iSzdtNWpCMnJkMHhhN3IvYitITE9sT2lESC9KaS9RYThLZFo5bWxidXlH?=
 =?utf-8?B?enNzN0l4OGZHcjM4SGpneXBBcTlLVW5OMXQxaEQzWkFqMnZKakRQUWdtbFpK?=
 =?utf-8?B?UFQ0L09VSmpEdDFOSkFTeUxqZndnRXVlTHpRa0xqbjBJOXVxcWhrbHdZMUNk?=
 =?utf-8?B?NjRCTi9JSzArTmUxVndBMmlXYndSS0c3Wkw5aEdpVXpmcnRSVy9Od2UyenVD?=
 =?utf-8?B?S0xCQ0I2QWtlQ0dZNUJjSzB1dC9aaDlTNzVWdjdXaUJaRTgvQ1pwdlhvZFla?=
 =?utf-8?B?RElBcUVpOGZSZXZqVUVobGVJYTRVQjB4d2ErQlVFUm9BRGl6bjJYSWdHUHdy?=
 =?utf-8?B?MXM2T1RpVTVVaVpMQS9CcTg4a0RRMFhUai9MMlphZmdWUWlFelFRS3dxVDZ2?=
 =?utf-8?B?TjYxT0hXRVF6cGJJVDBrSU8wUnNtcXJwcE5YdnlwNW1lcmIyN1V3YzdZZDk4?=
 =?utf-8?B?STVvcFVxc3F0ZWM0THNyQkt3Nnp1NlErUTZUTFdnbHdsQ1NEd3pZVkxEWnZI?=
 =?utf-8?Q?iwy+KhuYKI9URX7VyCAr8YZGz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 98AQxl1pcavYsbv31K+nGP8RXGAH2NIV6DElXrN1qqR6na+JlZ/oXEvB8aONx2iQsc4SAMvNcnbSN88z2FxGTesiCdnzel7rkIl4DUp8rTkh/xH/KbOBhkGt6gbTMyFlCINsEQSs4VaPCPqhEFCinuF+3zfNioXHy7jgTwDL0Jhd/IdmPPNgsiDxLhElW/BjbujKZTbSjnx9RGGaH/fEZBNZjloTpiliuFV0CUQBLjfZRIjZ0nCZV/2HOhETZ++Oavle2eNycLXtFT5DBm2BmvydAor5XY1jgcjyrW9gvNb7smDbCA2MlOjwIOFPABF8GQS4CBDAzMbZe355lku88i1AF0gK2YUobe/h3E9U0zj8iFLv7erMYBIwaCw7hEyo3eCcaQewJxQOZYL+Z9yZb5DvP1q5JMR/hdaVXKkPRI0jK/GUXyIEGO/zy5mXs+W5vSDhjuN3F34HtZlTdDWpaGM5JmyT4aXrBOVAAw+TMALfr7GsvqazEqmT8wZ0x2Ribqgu8EZOZTBoGre1Yu/8rGOvcweMQsG3DI8nN6LktRXIxDgUFIJPWDSDVWdoiml9JLkMWq8RJfIdlxITGOKee2cLWvhF2sA/BMx9xeEKJANo1ssdEdPsLz/d9kf/+doo
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6c029b-5f8d-430f-9405-08dc9a2e1f4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 00:30:06.3785 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HYk9fMRch/5i4p/9xFqiL9H8BuhnlKLiZgpqRrZtdljUtJmzC4cljcbbNBvPx3nKUwFxkpQKnwZP1jdNKcus6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10234
Received-SPF: pass client-ip=68.232.156.96;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa13.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
From:  "Xingtao Yao (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

SGksIGFsbA0KDQpXaGVuIEkgZGlkIHRoZSBjeGwgbWVtb3J5IGhvdC1wbHVnIHRlc3Qgb24gUUVN
VSwgSSBhY2NpZGVudGFsbHkgY29ubmVjdGVkIA0KdHdvIG1lbWRldiB0byB0aGUgc2FtZSBkb3du
c3RyZWFtIHBvcnQsIHRoZSBjb21tYW5kIGxpa2UgYmVsb3c6DQoNCj4gLW9iamVjdCBtZW1vcnkt
YmFja2VuZC1yYW0sc2l6ZT0yNjIxNDRrLHNoYXJlPW9uLGlkPXZtZW0wIFwNCj4gLW9iamVjdCBt
ZW1vcnktYmFja2VuZC1yYW0sc2l6ZT0yNjIxNDRrLHNoYXJlPW9uLGlkPXZtZW0xIFwNCj4gLWRl
dmljZSBweGItY3hsLGJ1c19ucj0xMixidXM9cGNpZS4wLGlkPWN4bC4xIFwNCj4gLWRldmljZSBj
eGwtcnAscG9ydD0wLGJ1cz1jeGwuMSxpZD1yb290X3BvcnQwLGNoYXNzaXM9MCxzbG90PTAgXA0K
PiAtZGV2aWNlIGN4bC11cHN0cmVhbSxidXM9cm9vdF9wb3J0MCxpZD11czAgXA0KPiAtZGV2aWNl
IGN4bC1kb3duc3RyZWFtLHBvcnQ9MCxidXM9dXMwLGlkPXN3cG9ydDAwLGNoYXNzaXM9MCxzbG90
PTUgXA0KPiAtZGV2aWNlIGN4bC1kb3duc3RyZWFtLHBvcnQ9MCxidXM9dXMwLGlkPXN3cG9ydDAx
LGNoYXNzaXM9MCxzbG90PTcgXA0Kc2FtZSBkb3duc3RyZWFtIHBvcnQgYnV0IGhhcyBkaWZmZXJl
bnQgc2xvdCENCg0KPiAtZGV2aWNlIGN4bC10eXBlMyxidXM9c3dwb3J0MDAsdm9sYXRpbGUtbWVt
ZGV2PXZtZW0wLGlkPWN4bC12bWVtMCBcDQo+IC1kZXZpY2UgY3hsLXR5cGUzLGJ1cz1zd3BvcnQw
MSx2b2xhdGlsZS1tZW1kZXY9dm1lbTEsaWQ9Y3hsLXZtZW0xIFwNCj4gLU0gY3hsLWZtdy4wLnRh
cmdldHMuMD1jeGwuMSxjeGwtZm13LjAuc2l6ZT02NEcsY3hsLWZtdy4wLmludGVybGVhdmUtZ3Jh
bnVsYXJpdHk9NGsgXA0KDQpUaGVyZSBpcyBubyBlcnJvciBvY2N1cnJlZCB3aGVuIHZtIHN0YXJ0
LCBidXQgd2hlbiBJIGV4ZWN1dGVkIHRoZSDigJxjeGwgbGlzdOKAnSBjb21tYW5kIHRvIHZpZXcN
CnRoZSBDWEwgb2JqZWN0cyBpbmZvLCB0aGUgcHJvY2VzcyBjYW4gbm90IGVuZCBwcm9wZXJseS4N
Cg0KVGhlbiBJIHVzZWQgc3RyYWNlIHRvIHRyYWNlIHRoZSBwcm9jZXNzLCBJIGZvdW5kIHRoYXQg
dGhlIHByb2Nlc3MgaXMgaW4gaW5maW5pdHkgbG9vcDoNCiMgc3RyYWNlIGN4bCBsaXN0DQouLi4u
Li4NCmNsb2NrX25hbm9zbGVlcChDTE9DS19SRUFMVElNRSwgMCwge3R2X3NlYz0wLCB0dl9uc2Vj
PTEwMDAwMDB9LCBOVUxMKSA9IDANCm9wZW5hdChBVF9GRENXRCwgIi9zeXMvYnVzL2N4bC9mbHVz
aCIsIE9fV1JPTkxZfE9fQ0xPRVhFQykgPSAzDQp3cml0ZSgzLCAiMVxuXDAiLCAzKSAgICAgICAg
ICAgICAgICAgICAgPSAzDQpjbG9zZSgzKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
PSAwDQphY2Nlc3MoIi9ydW4vdWRldi9xdWV1ZSIsIEZfT0spICAgICAgICAgPSAwDQpjbG9ja19u
YW5vc2xlZXAoQ0xPQ0tfUkVBTFRJTUUsIDAsIHt0dl9zZWM9MCwgdHZfbnNlYz0xMDAwMDAwfSwg
TlVMTCkgPSAwDQpvcGVuYXQoQVRfRkRDV0QsICIvc3lzL2J1cy9jeGwvZmx1c2giLCBPX1dST05M
WXxPX0NMT0VYRUMpID0gMw0Kd3JpdGUoMywgIjFcblwwIiwgMykgICAgICAgICAgICAgICAgICAg
ID0gMw0KY2xvc2UoMykgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgID0gMA0KYWNjZXNz
KCIvcnVuL3VkZXYvcXVldWUiLCBGX09LKSAgICAgICAgID0gMA0KY2xvY2tfbmFub3NsZWVwKENM
T0NLX1JFQUxUSU1FLCAwLCB7dHZfc2VjPTAsIHR2X25zZWM9MTAwMDAwMH0sIE5VTEwpID0gMA0K
b3BlbmF0KEFUX0ZEQ1dELCAiL3N5cy9idXMvY3hsL2ZsdXNoIiwgT19XUk9OTFl8T19DTE9FWEVD
KSA9IDMNCndyaXRlKDMsICIxXG5cMCIsIDMpICAgICAgICAgICAgICAgICAgICA9IDMNCmNsb3Nl
KDMpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA9IDANCmFjY2VzcygiL3J1bi91ZGV2
L3F1ZXVlIiwgRl9PSykgICAgICAgICA9IDANCmNsb2NrX25hbm9zbGVlcChDTE9DS19SRUFMVElN
RSwgMCwge3R2X3NlYz0wLCB0dl9uc2VjPTEwMDAwMDB9LCBOVUxMKSA9IDANCm9wZW5hdChBVF9G
RENXRCwgIi9zeXMvYnVzL2N4bC9mbHVzaCIsIE9fV1JPTkxZfE9fQ0xPRVhFQykgPSAzDQp3cml0
ZSgzLCAiMVxuXDAiLCAzKSAgICAgICAgICAgICAgICAgICAgPSAzDQpjbG9zZSgzKSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgPSAwDQphY2Nlc3MoIi9ydW4vdWRldi9xdWV1ZSIsIEZf
T0spICAgICAgICAgPSAwDQpjbG9ja19uYW5vc2xlZXAoQ0xPQ0tfUkVBTFRJTUUsIDAsIHt0dl9z
ZWM9MCwgdHZfbnNlYz0xMDAwMDAwfSwgTlVMTCkgPSAwDQpvcGVuYXQoQVRfRkRDV0QsICIvc3lz
L2J1cy9jeGwvZmx1c2giLCBPX1dST05MWXxPX0NMT0VYRUMpID0gMw0Kd3JpdGUoMywgIjFcblww
IiwgMykgICAgICAgICAgICAgICAgICAgID0gMw0KY2xvc2UoMykgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgID0gMA0KYWNjZXNzKCIvcnVuL3VkZXYvcXVldWUiLCBGX09LKSAgICAgICAg
ID0gMA0KY2xvY2tfbmFub3NsZWVwKENMT0NLX1JFQUxUSU1FLCAwLCB7dHZfc2VjPTAsIHR2X25z
ZWM9MTAwMDAwMH0sIE5VTEwpID0gMA0Kb3BlbmF0KEFUX0ZEQ1dELCAiL3N5cy9idXMvY3hsL2Zs
dXNoIiwgT19XUk9OTFl8T19DTE9FWEVDKSA9IDMNCndyaXRlKDMsICIxXG5cMCIsIDMpICAgICAg
ICAgICAgICAgICAgICA9IDMNCmNsb3NlKDMpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICA9IDANCmFjY2VzcygiL3J1bi91ZGV2L3F1ZXVlIiwgRl9PSykgICAgICAgICA9IDANCmNsb2Nr
X25hbm9zbGVlcChDTE9DS19SRUFMVElNRSwgMCwge3R2X3NlYz0wLCB0dl9uc2VjPTEwMDAwMDB9
LCBOVUxMKSA9IDANCm9wZW5hdChBVF9GRENXRCwgIi9zeXMvYnVzL2N4bC9mbHVzaCIsIE9fV1JP
TkxZfE9fQ0xPRVhFQykgPSAzDQp3cml0ZSgzLCAiMVxuXDAiLCAzKSAgICAgICAgICAgICAgICAg
ICAgPSAzDQpjbG9zZSgzKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPSAwDQphY2Nl
c3MoIi9ydW4vdWRldi9xdWV1ZSIsIEZfT0spICAgICAgICAgPSAwDQpjbG9ja19uYW5vc2xlZXAo
Q0xPQ0tfUkVBTFRJTUUsIDAsIHt0dl9zZWM9MCwgdHZfbnNlYz0xMDAwMDAwfSwgTlVMTCkgPSAw
DQpvcGVuYXQoQVRfRkRDV0QsICIvc3lzL2J1cy9jeGwvZmx1c2giLCBPX1dST05MWXxPX0NMT0VY
RUMpID0gMw0Kd3JpdGUoMywgIjFcblwwIiwgMykgICAgICAgICAgICAgICAgICAgID0gMw0KY2xv
c2UoMykgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgID0gMA0KYWNjZXNzKCIvcnVuL3Vk
ZXYvcXVldWUiLCBGX09LKSAgICAgICAgID0gMA0KDQpbRW52aXJvbm1lbnRdOg0KbGludXg6IFY2
LjEwLXJjMw0KUUVNVTogVjkuMC4wDQpuZGN0bDogdjc5DQoNCkkga25vdyB0aGlzIGlzIGJlY2F1
c2Ugb2YgdGhlIHdyb25nIHVzZSBvZiB0aGUgUUVNVSBjb21tYW5kLCBidXQgSSB0aGluayB3ZSBz
aG91bGQgDQpiZSBhd2FyZSBvZiB0aGlzIGVycm9yIGluIG9uZSBvZiB0aGUgUUVNVSwgT1Mgb3Ig
bmRjdGwgc2lkZSBhdCBsZWFzdC4NCg0KVGhhbmtzDQpYaW5ndGFvDQo=

