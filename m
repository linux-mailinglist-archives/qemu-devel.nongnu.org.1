Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4653758DEC
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 08:36:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM0mM-00088s-34; Wed, 19 Jul 2023 02:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1qM0mH-00088F-LP
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 02:35:14 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1qM0mE-0008Dg-4x
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 02:35:13 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36J5wtwU007760; Tue, 18 Jul 2023 23:35:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=ydC4RSAHJvUhilam0Gaq9vCtLh3B3Rk4Mcc0Yb2Kn
 nI=; b=askYpGNqB3C/Zc9DyX64B/wR29tVkPQQ9BzmlmzxLcD5barTwK4arfIs3
 9IH/9NEOGu7dP7UpU0wANeyVbideLMYShvpO556rRzB7yiJ7gmBiER8n1uknmVWe
 tK6Y4/rhDNz1Jn+S+FhR0n02ok7obz/m9Z7ZhMPdMK179iNJmThLXcAdYzyemdf4
 h0uWO6AHMKg0qN3LYIJxOrYTxbCSawuPpp9l6y7OQVUckXC/FrbAaUXn+Opj+LGf
 P7wa4UbQJ+ljzJMfXS5VCYB9HK0Hc4OKe3oXKtUhBrZ7h2h6fraQG9uqzFKtf7FT
 FxRDcp0CwFbgKdDIjLFD7TDA28wvg==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3rx2wn0u8f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 23:35:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cd3gj9kCrKrgvx3dWxbQoKQesWJ3yNH+MLh/Tn/pNiT669KXN+sylcBBRVKzxChu1zyBFAdXyTr53Eb+xqKWZ7bJZcXpfdR4bXSnCesCW7app43Htvert4Tc0U7GAK8XYQ2vlQaEvgdqmBhPpo3PPPZr0WgOm3oT4poJBhYFY/UcYUESpgnECqZVoQIoJnNTbnUw+Tye2gKQJR8coI+g3mGKGUY/TDakrYDSxA4l44laWgv9voAJ1TDgAxxuUckJqLU8QkP+L0eXx5prJiMjGAdYC5h4/hnVXbKv5kd+rwUpN3RRBTW869/ZmjcbNKSmHqBf4BsIwNyPVCg4HW5Drg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydC4RSAHJvUhilam0Gaq9vCtLh3B3Rk4Mcc0Yb2KnnI=;
 b=VgML+rwMvJ97sHZ78qoRK8uTDmTGgKm7K8qRAbcAJvi+mryZz3Hmod8WMYpqCJThtDJl40v7qYHgfSLeRWJSe6TyedeElX1zXnVJCC6ERQnQ/tbX6H2OsjVHTaSnhnfepV6tqWZE+lhwOtBSlYxdILnF1IEKWBlgmjppc1EujFm971VJQ/1dL9pNr/fkja4xQ7eBnp/QtlX6VyUSB7i1IQKi1u8UFeRiVdUPo0LOdQmk5qf8pLGkjVpMQddb3/WACoy7JFLZnrHkHrM0ncMR1pQIS3LkHG9ZPm6YLoyzL6OvK00gljyTYfwSS/02QS6wpibBsXXW+5IfpIHzysd21g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydC4RSAHJvUhilam0Gaq9vCtLh3B3Rk4Mcc0Yb2KnnI=;
 b=XYQrBwBmnDbDpQxdhJ6V/lJiTX7co1YJX1Zezum3pBF9GkNV4p1swQj6FPf5G9wwSqVtlrM7YUqHcNCWp+r6Pm3wdSB/bMZzqchRYQkXj/dM+ozBQPJYKnNLF4yFktJ2DS1V3wPKRWI6IfV68oofDlf76BX/xbcwc09Cl0ODJEQI3AvBgYdTrlKUDmq/EXhIPY9tHG+fDIgMc02ru36+C3Ym3H7+GnU9LYfo/V6F0hNkzDRuIT9CdX7uxBy9aDab8okuEzh2TiKBLWX9fjOjGYVZE2qqKHqZ4Xqy8iKJ0pA9xw5CX0w15FRu50v2ZBJMNlp4PlvfvT8d1eauTXAe2A==
Received: from BYAPR02MB4806.namprd02.prod.outlook.com (2603:10b6:a03:42::30)
 by DS0PR02MB9572.namprd02.prod.outlook.com (2603:10b6:8:f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.22; Wed, 19 Jul
 2023 06:35:07 +0000
Received: from BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::82a3:a948:abf6:8676]) by BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::82a3:a948:abf6:8676%2]) with mapi id 15.20.6609.022; Wed, 19 Jul 2023
 06:35:07 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Aravind Retnakaran
 <aravind.retnakaran@nutanix.com>, Shivam Kumar <shivam.kumar1@nutanix.com>,
 Tejus GK <tejus.gk@nutanix.com>
Subject: [PATCH v3 1/2] migration/vmstate: Introduce
 vmstate_save_state_with_err
Thread-Topic: [PATCH v3 1/2] migration/vmstate: Introduce
 vmstate_save_state_with_err
Thread-Index: Adm6CyhxxGDZjD6U80yBMbvyqb8drw==
Date: Wed, 19 Jul 2023 06:35:07 +0000
Message-ID: <20230719063455.128000-2-tejus.gk@nutanix.com>
References: <20230719063455.128000-1-tejus.gk@nutanix.com>
In-Reply-To: <20230719063455.128000-1-tejus.gk@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0060.namprd07.prod.outlook.com
 (2603:10b6:a03:60::37) To BYAPR02MB4806.namprd02.prod.outlook.com
 (2603:10b6:a03:42::30)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR02MB4806:EE_|DS0PR02MB9572:EE_
x-ms-office365-filtering-correlation-id: 4fdf94aa-4d0f-4ca0-97c0-08db88224aee
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mXGCp+zMjKCOy2sULL7KaDbH3z0acERB1eAKIj37yhz9LF7JyEFDEobtCER8OQ464uX80KGdOuKzW4Z0zWmq7aYvk0yLYUR8P0qE0fNfZjWdUJpMTt8ORsLzKLwOQboplCTb6EFJuhIYNEfarlOr9rs1atHtgXHH0y5tQUxjrzK5fCJ6t/FsOso3fQyySA94vCz+HK5Af2QHblmeNbifXPkPz/PC923eIKh9JJQObsx5FiViqYsm2EvbdmJ/u26ZNiecAaIQ+/55+4Wu0SKlvu5ZLrZiLWKotq1Bu6Zaes81VxPC/G2t2U3LXgLfQf7WE8zYjMeCyFVXDfxIRHoeTBHtch4z7J0Ub1glzL1XesbCuCTloqgK+GaF8uP0xkMBxp8iGEBBEQGmkOMsjNeTQ/4btQR4wO6/clHjU2ywXTD2TFk5W3f0XiuybUrXD/MGgLP4z9L0GWW9w0kxQQrloBRxfAduFMT2eQlSSsACGzPOi26R++PnFFPwU/Rp82RvTh73geX0F/9Gt7NC2I8aw71Rgqnnap9azZpZc3yPbOuOtLUvrVrJcQuRGXSc9zGZOMyPHfz4+OynVtTJ8rbyE8RI6lGMoQjrkVGdVWb36zs12p9dPtWrX/0LxYvj2ZM1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4806.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(396003)(39860400002)(366004)(136003)(376002)(451199021)(107886003)(6506007)(71200400001)(83380400001)(1076003)(38100700002)(186003)(26005)(38350700002)(478600001)(6486002)(54906003)(66476007)(6512007)(41300700001)(8676002)(66446008)(2906002)(8936002)(66556008)(6916009)(66946007)(316002)(4326008)(5660300002)(36756003)(52116002)(2616005)(64756008)(122000001)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clNTem5ZaVAraEg4NXhFVXhLaG45a0RaQlowMGtOUk5BejhRL1dtOHJBUEFr?=
 =?utf-8?B?aTdxeDQzSmwrN2NtanVGUTJiM2Rna3JYdHBZRGlmSDEyOUxncFBGQlFVeVFP?=
 =?utf-8?B?clEraVQzQVR2WkR6TVkxUXRQeWN2VlJFUlVJc0NMeHdWbTY3QUppTk52WTRM?=
 =?utf-8?B?RDZXTGpWaTk3THZ2ZytSRnMvam82YThGdFQ2MHh3dy9aK2hwb01EK2lZSjRI?=
 =?utf-8?B?ak1HbFdkemYyU3FFQ1BlUkQ1QlNnTWh1a1VJeUllWTBIeHhUUFdCMnAzeVJW?=
 =?utf-8?B?VmY5eUQ5VVlVcUtkYWJKWlV5RzVHUzJPcU5EVnlTRjBYNHltNllQb2huNlJk?=
 =?utf-8?B?QXFyOFQ5WHl3OEk1YjJ0N3lvTEtBenRlcVhZajdSM0F2Rk9WYVMrSFZleEJs?=
 =?utf-8?B?ZWVPRTdzQVpCUVZpTUQwM0l0dllJYjlDMTYxL1FOTW9pbzdTRUpDMGw1cDFU?=
 =?utf-8?B?Vms1bUZzaDN4RmVjT0xOUmxmQkhQdXk1ZXdYbWoyRjdHY0J1TTM0NGdaU1BF?=
 =?utf-8?B?OGNiYWVKN0xXZDEycjdpdTVSTkZTckNqTzI0UldOWkNMc2pWNERCWS8wV05l?=
 =?utf-8?B?RC9nNVdhOUc2RFUxcDdmR2V6VkVKYkNUT1IyaWVqa1lhOW1CR3A0aDduTjBa?=
 =?utf-8?B?SzU1RGtWZ2NtL0R5Rml5eTdxcWs2QUtYY3p5NjJYcXN0RTRtVTNjMXJPdllW?=
 =?utf-8?B?RTVZSEs0Ykx0clUycEI4YWl6aHR5a1lqTGwwdm0wb3FYM0xkUlRjT2k4d3o4?=
 =?utf-8?B?cU5pNVVvM0xUNWRnNExxSlF5RmpBS3R1aGJWMkREUU1CWlVCcEdpbFhhMW5D?=
 =?utf-8?B?N2M4b3FrYVVaSGpOTm82V0FJTkNSbHoyVG81SmZQMW9uQzhNOTFab3hzajBT?=
 =?utf-8?B?S0V3Mk5JNXlleEliUXROSlByb3RhUTZ4YklSY1REdGFFaVFURDhBZmY2a1do?=
 =?utf-8?B?NVllRWZsZUp0eFNIcXc1bHF2QzcvelFNUUlteDRHMUFvU0NQbFpaOWRKLy9p?=
 =?utf-8?B?Wm5KaGdoVzJma1BJTnVycE1HdWFTbldDYWhrSjJjRzBpSm5QbkVaZXFHT3BL?=
 =?utf-8?B?U24wVUVRWDFtd1NtZi9ERTJBWDVJQUUxc1lPSGRPTCs2OEpkMEdGUlNYbSt0?=
 =?utf-8?B?RjIzd1NNVlR1Zzd5aTREeHUvRkZEbTVCdnRpZmNnTVViWDNzNm9peUNPK0VX?=
 =?utf-8?B?TTVjRkNGSkFsYzFYaEZIL1V5a0JRT3oyT3p2eUsrS3ZLdk16VWFENTJuQmlo?=
 =?utf-8?B?RllpTlRnM2dUV3Jod3RlMUcvZk4zSG5iV293Vkh6aHFrd05FVGxMNnhheDl5?=
 =?utf-8?B?eWhYbUtRcDNkRkxNaHk4MlZFN3NSYkpqR2NRc1c4ZkpxVVljV2ZhdHhlNzlU?=
 =?utf-8?B?R1ZKMXExK0VuL0lDNzZOR0VEN1R6UmRUWXlvNU9kTnM1enB1ZExaWE1PMUdW?=
 =?utf-8?B?LzBhM1l0bVRIREplRDh3cnB6d3djU2xmOXpSQjR2T1BVMit5UHVRYUJreW80?=
 =?utf-8?B?SEl0Y1RDOHFtTkh2dUdhY1diNXVia28zS3N2d3FtUERzcGJJMXFGREF3VXQ5?=
 =?utf-8?B?ckg2VGFadG9NT0Ruak83WHpmN0RybmhBTlpTd0NMSG9BZERIVDJ0KzhtczJX?=
 =?utf-8?B?ZmpxRXdlcTFaMngzOEFxaHZpQWtLSTFXaWs2Q2Nzb0M4OU1FTitFRnByM1BU?=
 =?utf-8?B?MVdqbmJ6YzVMZVIvNGxmdnpqOXJUdE1TR281cWhUZzR6dXV5NW5BN2tCMDZ6?=
 =?utf-8?B?Qk4wWS9tYzJUSkd3akJtMDlpUW5XbVZMcHgwWnhvWlFXTVkxVlNHWmZ5a0Rl?=
 =?utf-8?B?YWYrYS9VekREZXRhcXRtamk0bzVDS1hZR1hnTXNEQzJ2WG1WUmVoTUhzYXlX?=
 =?utf-8?B?ZlFhSzJkMGFNNXZaV3hmWFVUMi92ZDUxV0VnQTR6SU1CdTJpRGp6czlYaGNu?=
 =?utf-8?B?VHRpakxtaTFUQ3dHOVpoVW5veXMrU3lPOStGYWlWYjFBdk92UndpQ3ZHYk1h?=
 =?utf-8?B?R0Mwc1B0ZDlnSWJuMkJyZE9jeTZ0QlBRY0gwY2FxUW8yVDh1QlZVc0x3YXkr?=
 =?utf-8?B?ejZXaUhPTkRFTWxYcHN6SnBTcitVcGFFS0NMWExWdVhhZXBseFJXYnVCSnZ0?=
 =?utf-8?Q?Biv+wp/Oqq2+XVo6IjTN2zv8U?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4806.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fdf94aa-4d0f-4ca0-97c0-08db88224aee
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 06:35:07.0211 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7EWiFWO105hhfYTE9YHU3AhmrIzpPAOdVvFw+SPZDxD+xe6oT4xu2s7D1uYJ4Qk6PDbDZZ3pMox3zs9fdsAJ4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9572
X-Proofpoint-GUID: LqqbnCR3rf1QBZvpFnM89d6OtHlczYzJ
X-Proofpoint-ORIG-GUID: LqqbnCR3rf1QBZvpFnM89d6OtHlczYzJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_03,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=tejus.gk@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Q3VycmVudGx5LCBhIGZldyBjb2RlIHBhdGhzIGV4aXN0IGluIHRoZSBmdW5jdGlvbiB2bXN0YXRl
X3NhdmVfc3RhdGVfdiwNCndoaWNoIHVsdGltYXRlbHkgbGVhZHMgdG8gYSBtaWdyYXRpb24gZmFp
bHVyZS4gSG93ZXZlciwgYW4gdXBkYXRlIGluIHRoZQ0KY3VycmVudCBNaWdyYXRpb25TdGF0ZSBm
b3IgdGhlIGVycm9yIGRlc2NyaXB0aW9uIGlzIG5ldmVyIGRvbmUuDQoNCnZtc3RhdGUuYyBzb21l
aG93IGRvZXNuJ3Qgc2VlbSB0byBhbGxvdwl0aGUgdXNlCW9mIG1pZ3JhdGVfc2V0X2Vycm9yIGR1
ZQ0KdG8gc29tZQlkZXBlbmRlbmNpZXMgZm9yIHVuaXQgdGVzdHMuIEhlbmNlLCB0aGlzIHBhdGNo
IGludHJvZHVjZXMgYSBuZXcNCmZ1bmN0aW9uIHZtc3RhdGVfc2F2ZV9zdGF0ZV93aXRoX2Vyciwg
d2hpY2ggd2lsbCBldmVudHVhbGx5IHByb3BhZ2F0ZQ0KdGhlIGVycm9yIG1lc3NhZ2UgdG8gc2F2
ZXZtLmMgd2hlcmUgYSBtaWdyYXRlX3NldF9lcnJvcgljYWxsIGNhbiBiZQ0KZXZlbnR1YWxseSBk
b25lLg0KDQpBY2tlZC1ieTogUGV0ZXIgWHUgPHBldGVyeEByZWRoYXQuY29tPg0KU2lnbmVkLW9m
Zi1ieTogVGVqdXMgR0sgPHRlanVzLmdrQG51dGFuaXguY29tPg0KLS0tDQogaW5jbHVkZS9taWdy
YXRpb24vdm1zdGF0ZS5oIHwgIDQgKysrLQ0KIG1pZ3JhdGlvbi9zYXZldm0uYyAgICAgICAgICB8
ICAyICstDQogbWlncmF0aW9uL3Ztc3RhdGUuYyAgICAgICAgIHwgMTIgKysrKysrKysrLS0tDQog
MyBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KDQpkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9taWdyYXRpb24vdm1zdGF0ZS5oIGIvaW5jbHVkZS9taWdyYXRpb24v
dm1zdGF0ZS5oDQppbmRleCBkMWI4YWJlMDhkLi4yZWI2MDAyYjNjIDEwMDY0NA0KLS0tIGEvaW5j
bHVkZS9taWdyYXRpb24vdm1zdGF0ZS5oDQorKysgYi9pbmNsdWRlL21pZ3JhdGlvbi92bXN0YXRl
LmgNCkBAIC0xMTk0LDkgKzExOTQsMTEgQEAgaW50IHZtc3RhdGVfbG9hZF9zdGF0ZShRRU1VRmls
ZSAqZiwgY29uc3QgVk1TdGF0ZURlc2NyaXB0aW9uICp2bXNkLA0KICAgICAgICAgICAgICAgICAg
ICAgICAgdm9pZCAqb3BhcXVlLCBpbnQgdmVyc2lvbl9pZCk7DQogaW50IHZtc3RhdGVfc2F2ZV9z
dGF0ZShRRU1VRmlsZSAqZiwgY29uc3QgVk1TdGF0ZURlc2NyaXB0aW9uICp2bXNkLA0KICAgICAg
ICAgICAgICAgICAgICAgICAgdm9pZCAqb3BhcXVlLCBKU09OV3JpdGVyICp2bWRlc2MpOw0KK2lu
dCB2bXN0YXRlX3NhdmVfc3RhdGVfd2l0aF9lcnIoUUVNVUZpbGUgKmYsIGNvbnN0IFZNU3RhdGVE
ZXNjcmlwdGlvbiAqdm1zZCwNCisgICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKm9wYXF1ZSwg
SlNPTldyaXRlciAqdm1kZXNjLCBFcnJvciAqKmVycnApOw0KIGludCB2bXN0YXRlX3NhdmVfc3Rh
dGVfdihRRU1VRmlsZSAqZiwgY29uc3QgVk1TdGF0ZURlc2NyaXB0aW9uICp2bXNkLA0KICAgICAg
ICAgICAgICAgICAgICAgICAgICB2b2lkICpvcGFxdWUsIEpTT05Xcml0ZXIgKnZtZGVzYywNCi0g
ICAgICAgICAgICAgICAgICAgICAgICAgaW50IHZlcnNpb25faWQpOw0KKyAgICAgICAgICAgICAg
ICAgICAgICAgICBpbnQgdmVyc2lvbl9pZCwgRXJyb3IgKiplcnJwKTsNCiANCiBib29sIHZtc3Rh
dGVfc2F2ZV9uZWVkZWQoY29uc3QgVk1TdGF0ZURlc2NyaXB0aW9uICp2bXNkLCB2b2lkICpvcGFx
dWUpOw0KIA0KZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9zYXZldm0uYyBiL21pZ3JhdGlvbi9zYXZl
dm0uYw0KaW5kZXggOTVjMmFiZjQ3Yy4uZWExY2MxYTI2YiAxMDA2NDQNCi0tLSBhL21pZ3JhdGlv
bi9zYXZldm0uYw0KKysrIGIvbWlncmF0aW9uL3NhdmV2bS5jDQpAQCAtMTAwMCw3ICsxMDAwLDcg
QEAgc3RhdGljIGludCB2bXN0YXRlX3NhdmUoUUVNVUZpbGUgKmYsIFNhdmVTdGF0ZUVudHJ5ICpz
ZSwgSlNPTldyaXRlciAqdm1kZXNjKQ0KICAgICBpZiAoIXNlLT52bXNkKSB7DQogICAgICAgICB2
bXN0YXRlX3NhdmVfb2xkX3N0eWxlKGYsIHNlLCB2bWRlc2MpOw0KICAgICB9IGVsc2Ugew0KLSAg
ICAgICAgcmV0ID0gdm1zdGF0ZV9zYXZlX3N0YXRlKGYsIHNlLT52bXNkLCBzZS0+b3BhcXVlLCB2
bWRlc2MpOw0KKyAgICAgICAgcmV0ID0gdm1zdGF0ZV9zYXZlX3N0YXRlX3dpdGhfZXJyKGYsIHNl
LT52bXNkLCBzZS0+b3BhcXVlLCB2bWRlc2MsICZsb2NhbF9lcnIpOw0KICAgICAgICAgaWYgKHJl
dCkgew0KICAgICAgICAgICAgIHJldHVybiByZXQ7DQogICAgICAgICB9DQpkaWZmIC0tZ2l0IGEv
bWlncmF0aW9uL3Ztc3RhdGUuYyBiL21pZ3JhdGlvbi92bXN0YXRlLmMNCmluZGV4IGFmMDFkNTRi
NmYuLjM1YTliNjdhZmMgMTAwNjQ0DQotLS0gYS9taWdyYXRpb24vdm1zdGF0ZS5jDQorKysgYi9t
aWdyYXRpb24vdm1zdGF0ZS5jDQpAQCAtMzE1LDExICszMTUsMTcgQEAgYm9vbCB2bXN0YXRlX3Nh
dmVfbmVlZGVkKGNvbnN0IFZNU3RhdGVEZXNjcmlwdGlvbiAqdm1zZCwgdm9pZCAqb3BhcXVlKQ0K
IGludCB2bXN0YXRlX3NhdmVfc3RhdGUoUUVNVUZpbGUgKmYsIGNvbnN0IFZNU3RhdGVEZXNjcmlw
dGlvbiAqdm1zZCwNCiAgICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKm9wYXF1ZSwgSlNPTldy
aXRlciAqdm1kZXNjX2lkKQ0KIHsNCi0gICAgcmV0dXJuIHZtc3RhdGVfc2F2ZV9zdGF0ZV92KGYs
IHZtc2QsIG9wYXF1ZSwgdm1kZXNjX2lkLCB2bXNkLT52ZXJzaW9uX2lkKTsNCisgICAgcmV0dXJu
IHZtc3RhdGVfc2F2ZV9zdGF0ZV92KGYsIHZtc2QsIG9wYXF1ZSwgdm1kZXNjX2lkLCB2bXNkLT52
ZXJzaW9uX2lkLCBOVUxMKTsNCit9DQorDQoraW50IHZtc3RhdGVfc2F2ZV9zdGF0ZV93aXRoX2Vy
cihRRU1VRmlsZSAqZiwgY29uc3QgVk1TdGF0ZURlc2NyaXB0aW9uICp2bXNkLA0KKyAgICAgICAg
ICAgICAgICAgICAgICAgdm9pZCAqb3BhcXVlLCBKU09OV3JpdGVyICp2bWRlc2NfaWQsIEVycm9y
ICoqZXJycCkNCit7DQorICAgIHJldHVybiB2bXN0YXRlX3NhdmVfc3RhdGVfdihmLCB2bXNkLCBv
cGFxdWUsIHZtZGVzY19pZCwgdm1zZC0+dmVyc2lvbl9pZCwgZXJycCk7DQogfQ0KIA0KIGludCB2
bXN0YXRlX3NhdmVfc3RhdGVfdihRRU1VRmlsZSAqZiwgY29uc3QgVk1TdGF0ZURlc2NyaXB0aW9u
ICp2bXNkLA0KLSAgICAgICAgICAgICAgICAgICAgICAgICB2b2lkICpvcGFxdWUsIEpTT05Xcml0
ZXIgKnZtZGVzYywgaW50IHZlcnNpb25faWQpDQorICAgICAgICAgICAgICAgICAgICAgICAgIHZv
aWQgKm9wYXF1ZSwgSlNPTldyaXRlciAqdm1kZXNjLCBpbnQgdmVyc2lvbl9pZCwgRXJyb3IgKipl
cnJwKQ0KIHsNCiAgICAgaW50IHJldCA9IDA7DQogICAgIGNvbnN0IFZNU3RhdGVGaWVsZCAqZmll
bGQgPSB2bXNkLT5maWVsZHM7DQpAQCAtMzc3LDcgKzM4Myw3IEBAIGludCB2bXN0YXRlX3NhdmVf
c3RhdGVfdihRRU1VRmlsZSAqZiwgY29uc3QgVk1TdGF0ZURlc2NyaXB0aW9uICp2bXNkLA0KICAg
ICAgICAgICAgICAgICB9IGVsc2UgaWYgKGZpZWxkLT5mbGFncyAmIFZNU19WU1RSVUNUKSB7DQog
ICAgICAgICAgICAgICAgICAgICByZXQgPSB2bXN0YXRlX3NhdmVfc3RhdGVfdihmLCBmaWVsZC0+
dm1zZCwgY3Vycl9lbGVtLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdm1kZXNjX2xvb3AsDQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBmaWVsZC0+c3RydWN0X3ZlcnNpb25faWQpOw0KKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZmllbGQtPnN0cnVjdF92ZXJzaW9uX2lk
LCBlcnJwKTsNCiAgICAgICAgICAgICAgICAgfSBlbHNlIHsNCiAgICAgICAgICAgICAgICAgICAg
IHJldCA9IGZpZWxkLT5pbmZvLT5wdXQoZiwgY3Vycl9lbGVtLCBzaXplLCBmaWVsZCwNCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm1kZXNjX2xvb3ApOw0KLS0gDQoyLjIy
LjMNCg0K

