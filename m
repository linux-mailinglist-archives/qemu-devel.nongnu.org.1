Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E37AA75CA8E
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 16:50:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMrSJ-0003NM-Gt; Fri, 21 Jul 2023 10:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qMrRu-0003CS-6I
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 10:49:42 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qMrRs-0004oH-3L
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 10:49:41 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36LDgFEA003513; Fri, 21 Jul 2023 07:49:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=mwdRW+MdTR8iJH0iLxZ9P37udxvDOnfKoxcXCXxju
 do=; b=nrwAKbOgsDTsqpSpvHVRoEBycxcdfCoALMNsyQvSpN5Cov+sClvWYsBn+
 MGbiS22tZtW6U8zsvHIMrnnglYRkeZGAMtkBkuCZ0T8oMNmRcM1CPt0iGONN5q4n
 mGmEVf7l1scsRDmLoP0ZaPL7og9vvxAxiNENfZIaM2kOwX3huqq/15J+CcbqERHW
 iHIXNcT277ZtVb/dYulOmdfbx+ZzcR8pb7fHF0gVSGTFBg73lEL3z/qIGK6S+leS
 4+SsYB6Mqoi2UPss+SAMUqU+IjSu5bXQVNw877VGNchQJwRxHQwC/Z8Ebt4O19Rj
 fiaF1PCFz69ggyzmcIF9Xh1YIYYzg==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3rx2wn73f8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Jul 2023 07:49:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPR70PfoAg+6ttlObV462S9qm2N2vdCWJ1dPoPDU340exOyad5ZlCcLY0gjjiSuR6dJNX7d8Rqvj8WLcvyBtFl7Li0vs9A2EMOaYCNG73TQLc/+sbPUn+QyLyIqfKABNWV2hd1F+Uc6Kfn9lK9jkgSzq2tDwWiRtJo7MbKBrkQTO+kohNIpnoTcb62+epZDBGuDbXFvAIaGBaBk2ffllvwiihQq9FbQQZiHWHCu678hRHu1BuR6EtFRo0RsqfvCK8XEpzYJ5aVo06H4ERrS5MysH72Ft9YyCF6sWrZByohQKcOdzcvLiozUTvitqYr1mD2OwB+VB4cDpUvNGge7RqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwdRW+MdTR8iJH0iLxZ9P37udxvDOnfKoxcXCXxjudo=;
 b=Fczfs/yOCQeER0McUwO/sFiWrqxR6rVIKOktDrea9EGql872HPXNVj89lMObnulDxADZfngsR8k3p6eb7+WkWw0glcEfyuagR4pb7Tq0nHe1jSn+pIrle4sw68DuV+cNXNaFciorElSUCmPJpXSzA8IguN8eSyc0wtMMjze2sOPHCkH2/GtWpgHJbVwFJ7Pgl5Iqj6sC63xXy0oLw44Z6Dv4YgCHFMDNL1IlOopKMeMLAx+yHSoUyEiq0T/VtNjFMO1k1k1uXmXuRU/Pt95MGzB6yqH0qg61d2pKhMh8C2VPZVA2v8/Fu+AmWoTkmZZw6eArExXiDiqYXGFgFHS/eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwdRW+MdTR8iJH0iLxZ9P37udxvDOnfKoxcXCXxjudo=;
 b=L26AQoBeRJw47u9k8ZJJ3OXW5dpchHQVI1g/mFnYn+JLlbbsb5zCsIIY1J90HFVxlT2fnGhkjITQvBrV6tlCsecOj2NsCv6fLfXczw6efi6ciFBl5XIclEG4asetKo/CHOzk9Ow/fXpZgj7S9qRTA+TXDwom8RAqknVGU2rD4sNygYAVm5oxrl8JyXpUOTw2ABPAnPl+6Chps69bXvDnXYlr5f/OCIfbbQ/lFqz2v0DBVQIjxM8xuIc7XpcxoTfBTyyFLdqSMV6a1Z/aRU84zzo8+rd4wU685hnjSsbAKOKuYow9csrQ/lrH98YxZK0LFnAwE1Cp9Eww+jN58Qtvpg==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by BL3PR02MB8020.namprd02.prod.outlook.com (2603:10b6:208:35b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.16; Fri, 21 Jul
 2023 14:49:34 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::89a1:d75c:813:618e]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::89a1:d75c:813:618e%7]) with mapi id 15.20.6609.022; Fri, 21 Jul 2023
 14:49:34 +0000
From: Het Gala <het.gala@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Prerna Saxena <prerna.saxena@nutanix.com>, "quintela@redhat.com"
 <quintela@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>, Manish Mishra
 <manish.mishra@nutanix.com>, Aravind Retnakaran
 <aravind.retnakaran@nutanix.com>, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v9 08/10] migration: Implement MigrateChannelList to qmp
 migration flow.
Thread-Topic: [PATCH v9 08/10] migration: Implement MigrateChannelList to qmp
 migration flow.
Thread-Index: Adm74pAz9n8FphtzYkCF0WoaOKzSow==
Date: Fri, 21 Jul 2023 14:49:34 +0000
Message-ID: <20230721144914.170991-9-het.gala@nutanix.com>
References: <20230721144914.170991-1-het.gala@nutanix.com>
In-Reply-To: <20230721144914.170991-1-het.gala@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PH0P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::17) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR02MB4343:EE_|BL3PR02MB8020:EE_
x-ms-office365-filtering-correlation-id: 32e7c924-9c6e-40ea-1039-08db89f9b2ad
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xWNbIBakDgJX5tzhJ6dWhMT7F+ibxA46JZ85GjIfDbV/qcKEhpZYVpgwxBFOOKpLSH6An/JAlFkbV/oP0NxGsm9xwGko3kn/MFUU/HISrcZ3rZG1psa74w/X6pt/zYseA07GaUvIXeLHZSwxUdxZdY1fZCJHIReoBn5U2NDnrhJULRvNPqV4Si+IKiVLS4sfb/LXbyWdKAxfdpRKwKTb8QWTd18nWOXTpcOMFmBv2NBREacdeXGeQsUAwpykgnTThmm5r5/eW9QbN35wuejJKVVRn/GabuIOZhIg3ZKpDFVQmNDvM9YL3kDnX70pfYLkQ9kZtpfjd8y3sVccPKTndZy/AUVE6qEDuiCBFe4XYs30uKdbhloAPDV0td5bBM6NhG9/0PZsarm2lOuzxzBdcjJ5V09Jq8cqaoSDSdWFMJAln4tPgXYCn9QiODcqNMttZK/4GP9psENebrf1fctQAyh84s18gZpYqd8xexKTpelAP5cYNMifk+0DgJQC4LZgy4FwHvimehlyqjCryQe+SCEs3zIMzC89wCKsf9DDOn4GVSG7rEyQPMY2kFy6p877vTTeYXZ5/Vleh7mBfW3xYmqK1jBUMBH3h7y+ceK67clh14wFKIK7YvTpNI09sUvW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199021)(6512007)(1076003)(122000001)(38350700002)(38100700002)(83380400001)(186003)(2616005)(6506007)(26005)(107886003)(44832011)(2906002)(8676002)(8936002)(5660300002)(71200400001)(36756003)(6486002)(478600001)(316002)(52116002)(64756008)(66446008)(4326008)(6916009)(41300700001)(54906003)(66476007)(66556008)(86362001)(66946007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDdYUlRjQTZEM3hYamphclhUQjhQV3F5Tk1XYmtjQjQ3RXN5MXJ4ODhrK25K?=
 =?utf-8?B?NkduU3pwY1hSMXB1ZnpFZjhlS1hKbXplMmhrR2xYcy9Wbmh3Sy9UR05YRHp0?=
 =?utf-8?B?ZWxKVC9VMlcyK3BHZUZvSEliaGtrYTFmZWtLTVhWdVZxU3BoWEtrN0U2YzNF?=
 =?utf-8?B?b0JRYUxBcFp2QVJzTWU0T0xiZ24wd2xvbmpUZ2lNZWhLYUNhME9IOG1SbmdL?=
 =?utf-8?B?ck5DSDZhb0ZHUS9tdFFyQURrNXdaUTZjeVZwRHhoSHU5RXoyYXBjM0lYbEU2?=
 =?utf-8?B?dEl1amRWQ0hsenJ1Q092RVNUc0Z0QzJoVExlSmFid05qNUtrUkxUN2xyRXd0?=
 =?utf-8?B?QW1pT0htTUtuNHNGVHVZNmRFTWppZ1FTNUZjZEQzZmRJeWdqZmNtTitDWENM?=
 =?utf-8?B?akQzUko2OUJJTER6ck8zRXJCRkFLMnFCWmNCWU9ta21rUElCN0dhVHdSU1VP?=
 =?utf-8?B?dTMxOVFYNU9zNHNYdHFieTROMXU0QjhwWmljUnlMZG9LMDBBYnBUQk44QVhy?=
 =?utf-8?B?Wk9OS0R0OTZhM1lLb0lZVU5uRXFZMXpBcWY4MzdRSTZMNHZNTHNtOG5XV3Zq?=
 =?utf-8?B?azgwUWU0cFRJR0dIRmhiUmg4aldjVHpHWkU4amFTNGZUSzl5bzJ5RFQ2VlZQ?=
 =?utf-8?B?RHhJczZ4cFR5SHUxNjNmSEhLNXJJZDFLOFRLOEpVR01BcFVDNmR1V1h3YkUv?=
 =?utf-8?B?T0lHa2g5OEN3Vlg1cDNjUGtwTW1wQ0xkVXRvZU1aeUkrOGF0NFRNL01ab3pT?=
 =?utf-8?B?Y2E4WVFvVFZmUk1OSFd1V0tGVVo3blMzNzExdXQzZlMxeDhwMFF1Tzk3WlRK?=
 =?utf-8?B?WUZIKzlnR0FZa2k3czNMZVdrb0VLbHQzY0xzYy8wVlR5NlAzY2lyRTlmWUFP?=
 =?utf-8?B?ZXg0WDhZeHNCVng5SVdoYndjTUtqWjYvamd4MjMwYmVBTkVJNVl2VDZqaXBp?=
 =?utf-8?B?NkFzWEVlcWtsQmpoOERnbWQxV01rRWdhM2FkOGZjRy9vbnR6Y1RNNXAyNzlE?=
 =?utf-8?B?dlR6WUh6RUNjMUFEeU5iUmtJdVYxWUVhaDlBSitIUjdCbDR2QU5kWkdlT2xQ?=
 =?utf-8?B?L1RYVWxJV0tpekxxOWxGM0NUTnM2RFIyMFBDN0NQdDRuM0QreTR3TitzNE05?=
 =?utf-8?B?OVY5c3JNZ2YrTThuSFJoazdxSGtybHV4SzhyZFBjblpPYmx5T08vM3VIVnpX?=
 =?utf-8?B?ZXRVZkxQTkxUSndJbHJOWG1YWVdibVpzSTc3V3Y2dS9CazI1bTRQaU5lT0tl?=
 =?utf-8?B?ZmhmVjQ2RXdoYS9OdjkxVG1rMXQyemFvVVJhOHp2ZlZzSWVGdHpvNnMxR2dk?=
 =?utf-8?B?dWY5NnpOUXNHVEVnU1BzaS9nL1JPb3BtTXlNd2lNaS9iaUpScE9TTzNYVUdy?=
 =?utf-8?B?UDR0ZWREaGpkK01KQi9mQUxncmVQNk1UMFZjaFpKT3pSQytQelY5UUM4elFz?=
 =?utf-8?B?REY2UE5IclBKTWpjZkliay9xaXJsV0lsZGJhQ0ozVXZKZWZSaW5LejFweWR2?=
 =?utf-8?B?VEtFd25pUko0ZkNldm9aRWF4d2dMWlN3REMyM1VKYjFtd1kvQWN1Mi80dGpF?=
 =?utf-8?B?OVpKdmc0bFFWbDUrWWtOOVZCQ1N2K05FMTBCcXkwbzhya2RUekgzd0ZqS2Zj?=
 =?utf-8?B?R1NBZnlER2tJNDZldkliVElXK0hEMVNiWUVEdUwwM2ZDT0M0VlhrT3lDN3VB?=
 =?utf-8?B?UVBXTEVOUDJuYzlhQVBlbmZBM00xVDlwRTJKTXRBQ0J6SVZEd1doaUpPSHpQ?=
 =?utf-8?B?dXp3TkNxZUlFZTc4WCt3QlV6OElwajJQRFZNcWpPV000WmRZREFEekhWdVdN?=
 =?utf-8?B?dEkxMEZUdnpFN1UzVU9vWjFTSlMzU2srVFpWYVQxOW9rRitlNEhCMHQ4aDFD?=
 =?utf-8?B?emN5N0hVNldHYkNSalAyclZsNUg1aHRGeFJwQUtNeUJNRTRsYWl3MUhnN3Vp?=
 =?utf-8?B?NWI2OHZEQ3Z4MGJhaVE4UmszSm5VbUQxKy91Uy9ZblVXZm5iU0h2TUxUdDg5?=
 =?utf-8?B?WEI1WnU3bk5HT2VRMWRMVFhpOXdKVlN5c3pBVS9ZeW81UDVvaHFxMFRNYnhR?=
 =?utf-8?B?dFJ0ZGVIL1JkRzg0cjFXZFJaY1l6QloyRlo0cHJxTmJVQUI3ZEkwcXFtbnA1?=
 =?utf-8?B?d0Z1MDlTeTYrZ1BIQ1RNNHg1Z2N1eEttRGhFYmU5YW05QU5xMXc3N08vVWsx?=
 =?utf-8?B?aEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e7c924-9c6e-40ea-1039-08db89f9b2ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 14:49:34.0516 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ruuCeSIGlv0RcJuBYi4Eh2zS7jr3fLDZRCtA33jN/s9vQCs2Aj9+v55DEuHJj0dUMacx7WfGi1Iiocqq0o03Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8020
X-Proofpoint-GUID: aiBP8e32sveKdKINk9aStjntqaNpGE3d
X-Proofpoint-ORIG-GUID: aiBP8e32sveKdKINk9aStjntqaNpGE3d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_09,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
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

SW50ZWdyYXRlIE1pZ3JhdGVDaGFubmVsTGlzdCB3aXRoIGFsbCB0cmFuc3BvcnQgYmFja2VuZHMN
Cihzb2NrZXQsIGV4ZWMgYW5kIHJkbWEpIGZvciBib3RoIHNyYyBhbmQgZGVzdCBtaWdyYXRpb24N
CmVuZHBvaW50cyBmb3IgcW1wIG1pZ3JhdGlvbi4NCg0KRm9yIGN1cnJlbnQgc2VyaWVzLCBsaW1p
dCB0aGUgc2l6ZSBvZiBNaWdyYXRlQ2hhbm5lbExpc3QNCnRvIHNpbmdsZSBlbGVtZW50IChzaW5n
bGUgaW50ZXJmYWNlKSBhcyBydW50aW1lIGNoZWNrLg0KDQpTdWdnZXN0ZWQtYnk6IEFyYXZpbmQg
UmV0bmFrYXJhbiA8YXJhdmluZC5yZXRuYWthcmFuQG51dGFuaXguY29tPg0KU2lnbmVkLW9mZi1i
eTogSGV0IEdhbGEgPGhldC5nYWxhQG51dGFuaXguY29tPg0KLS0tDQogbWlncmF0aW9uL21pZ3Jh
dGlvbi5jIHwgNzcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0K
IDEgZmlsZSBjaGFuZ2VkLCA1MCBpbnNlcnRpb25zKCspLCAyNyBkZWxldGlvbnMoLSkNCg0KZGlm
ZiAtLWdpdCBhL21pZ3JhdGlvbi9taWdyYXRpb24uYyBiL21pZ3JhdGlvbi9taWdyYXRpb24uYw0K
aW5kZXggNmUwYThiZWFmMi4uYWNmODBiMzU5MCAxMDA2NDQNCi0tLSBhL21pZ3JhdGlvbi9taWdy
YXRpb24uYw0KKysrIGIvbWlncmF0aW9uL21pZ3JhdGlvbi5jDQpAQCAtNDI2LDkgKzQyNiwxMCBA
QCB2b2lkIG1pZ3JhdGVfYWRkX2FkZHJlc3MoU29ja2V0QWRkcmVzcyAqYWRkcmVzcykNCiB9DQog
DQogc3RhdGljIGJvb2wgbWlncmF0ZV91cmlfcGFyc2UoY29uc3QgY2hhciAqdXJpLA0KLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIE1pZ3JhdGlvbkFkZHJlc3MgKipjaGFubmVsLA0KKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1pZ3JhdGlvbkNoYW5uZWwgKipjaGFubmVsLA0K
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCiB7DQorICAgIGdf
YXV0b3B0cihNaWdyYXRpb25DaGFubmVsKSB2YWwgPSBnX25ldzAoTWlncmF0aW9uQ2hhbm5lbCwg
MSk7DQogICAgIGdfYXV0b3B0cihNaWdyYXRpb25BZGRyZXNzKSBhZGRyID0gZ19uZXcwKE1pZ3Jh
dGlvbkFkZHJlc3MsIDEpOw0KICAgICBTb2NrZXRBZGRyZXNzICpzYWRkciA9ICZhZGRyLT51LnNv
Y2tldDsNCiAgICAgSW5ldFNvY2tldEFkZHJlc3MgKmlzb2NrID0gJmFkZHItPnUucmRtYTsNCkBA
IC00NjUsNyArNDY2LDkgQEAgc3RhdGljIGJvb2wgbWlncmF0ZV91cmlfcGFyc2UoY29uc3QgY2hh
ciAqdXJpLA0KICAgICAgICAgcmV0dXJuIGZhbHNlOw0KICAgICB9DQogDQotICAgICpjaGFubmVs
ID0gYWRkcjsNCisgICAgdmFsLT5jaGFubmVsX3R5cGUgPSBNSUdSQVRJT05fQ0hBTk5FTF9UWVBF
X01BSU47DQorICAgIHZhbC0+YWRkciA9IGFkZHI7DQorICAgICpjaGFubmVsID0gdmFsOw0KICAg
ICByZXR1cm4gdHJ1ZTsNCiB9DQogDQpAQCAtNDczLDcgKzQ3Niw4IEBAIHN0YXRpYyB2b2lkIHFl
bXVfc3RhcnRfaW5jb21pbmdfbWlncmF0aW9uKGNvbnN0IGNoYXIgKnVyaSwgYm9vbCBoYXNfY2hh
bm5lbHMsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTWlncmF0
aW9uQ2hhbm5lbExpc3QgKmNoYW5uZWxzLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCiB7DQotICAgIGdfYXV0b3B0cihNaWdyYXRpb25B
ZGRyZXNzKSBjaGFubmVsID0gZ19uZXcwKE1pZ3JhdGlvbkFkZHJlc3MsIDEpOw0KKyAgICBnX2F1
dG9wdHIoTWlncmF0aW9uQ2hhbm5lbCkgY2hhbm5lbCA9IGdfbmV3MChNaWdyYXRpb25DaGFubmVs
LCAxKTsNCisgICAgZ19hdXRvcHRyKE1pZ3JhdGlvbkFkZHJlc3MpIGFkZHIgPSBnX25ldzAoTWln
cmF0aW9uQWRkcmVzcywgMSk7DQogDQogICAgIC8qDQogICAgICAqIEhhdmluZyBwcmVsaW1pbmFy
eSBjaGVja3MgZm9yIHVyaSBhbmQgY2hhbm5lbA0KQEAgLTQ4MywyMCArNDg3LDI5IEBAIHN0YXRp
YyB2b2lkIHFlbXVfc3RhcnRfaW5jb21pbmdfbWlncmF0aW9uKGNvbnN0IGNoYXIgKnVyaSwgYm9v
bCBoYXNfY2hhbm5lbHMsDQogICAgICAgICAgICAgICAgICAgICJleGNsdXNpdmU7IGV4YWN0bHkg
b25lIG9mIHRoZSB0d28gc2hvdWxkIGJlIHByZXNlbnQgaW4gIg0KICAgICAgICAgICAgICAgICAg
ICAiJ21pZ3JhdGUtaW5jb21pbmcnIHFtcCBjb21tYW5kICIpOw0KICAgICAgICAgcmV0dXJuOw0K
KyAgICB9IGVsc2UgaWYgKGNoYW5uZWxzKSB7DQorICAgICAgICAvKiBUbyB2ZXJpZnkgdGhhdCBN
aWdyYXRlIGNoYW5uZWwgbGlzdCBoYXMgb25seSBpdGVtICovDQorICAgICAgICBpZiAoY2hhbm5l
bHMtPm5leHQpIHsNCisgICAgICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJDaGFubmVsIGxpc3Qg
aGFzIG1vcmUgdGhhbiBvbmUgZW50cmllcyIpOw0KKyAgICAgICAgICAgIHJldHVybjsNCisgICAg
ICAgIH0NCisgICAgICAgIGNoYW5uZWwgPSBjaGFubmVscy0+dmFsdWU7DQorICAgIH0gZWxzZSB7
DQorICAgICAgICAvKiBjYWxsZXIgdXNlcyB0aGUgb2xkIFVSSSBzeW50YXggKi8NCisgICAgICAg
IGlmICh1cmkgJiYgIW1pZ3JhdGVfdXJpX3BhcnNlKHVyaSwgJmNoYW5uZWwsIGVycnApKSB7DQor
ICAgICAgICAgICAgcmV0dXJuOw0KKyAgICAgICAgfQ0KICAgICB9DQotDQotICAgIGlmICh1cmkg
JiYgIW1pZ3JhdGVfdXJpX3BhcnNlKHVyaSwgJmNoYW5uZWwsIGVycnApKSB7DQotICAgICAgICBy
ZXR1cm47DQotICAgIH0NCisgICAgYWRkciA9IGNoYW5uZWwtPmFkZHI7DQogDQogICAgIC8qIHRy
YW5zcG9ydCBtZWNoYW5pc20gbm90IHN1aXRhYmxlIGZvciBtaWdyYXRpb24/ICovDQotICAgIGlm
ICghbWlncmF0aW9uX2NoYW5uZWxzX2FuZF90cmFuc3BvcnRfY29tcGF0aWJsZShjaGFubmVsLCBl
cnJwKSkgew0KKyAgICBpZiAoIW1pZ3JhdGlvbl9jaGFubmVsc19hbmRfdHJhbnNwb3J0X2NvbXBh
dGlibGUoYWRkciwgZXJycCkpIHsNCiAgICAgICAgIHJldHVybjsNCiAgICAgfQ0KIA0KICAgICBx
YXBpX2V2ZW50X3NlbmRfbWlncmF0aW9uKE1JR1JBVElPTl9TVEFUVVNfU0VUVVApOw0KLSAgICBp
ZiAoY2hhbm5lbC0+dHJhbnNwb3J0ID09IE1JR1JBVElPTl9BRERSRVNTX1RZUEVfU09DS0VUKSB7
DQotICAgICAgICBTb2NrZXRBZGRyZXNzICpzYWRkciA9ICZjaGFubmVsLT51LnNvY2tldDsNCisg
ICAgaWYgKGFkZHItPnRyYW5zcG9ydCA9PSBNSUdSQVRJT05fQUREUkVTU19UWVBFX1NPQ0tFVCkg
ew0KKyAgICAgICAgU29ja2V0QWRkcmVzcyAqc2FkZHIgPSAmYWRkci0+dS5zb2NrZXQ7DQogICAg
ICAgICBpZiAoc2FkZHItPnR5cGUgPT0gU09DS0VUX0FERFJFU1NfVFlQRV9JTkVUIHx8DQogICAg
ICAgICAgICAgc2FkZHItPnR5cGUgPT0gU09DS0VUX0FERFJFU1NfVFlQRV9VTklYIHx8DQogICAg
ICAgICAgICAgc2FkZHItPnR5cGUgPT0gU09DS0VUX0FERFJFU1NfVFlQRV9WU09DSykgew0KQEAg
LTUwNSwxMSArNTE4LDExIEBAIHN0YXRpYyB2b2lkIHFlbXVfc3RhcnRfaW5jb21pbmdfbWlncmF0
aW9uKGNvbnN0IGNoYXIgKnVyaSwgYm9vbCBoYXNfY2hhbm5lbHMsDQogICAgICAgICAgICAgZmRf
c3RhcnRfaW5jb21pbmdfbWlncmF0aW9uKHNhZGRyLT51LmZkLnN0ciwgZXJycCk7DQogICAgICAg
ICB9DQogI2lmZGVmIENPTkZJR19SRE1BDQotICAgIH0gZWxzZSBpZiAoY2hhbm5lbC0+dHJhbnNw
b3J0ID09IE1JR1JBVElPTl9BRERSRVNTX1RZUEVfUkRNQSkgew0KLSAgICAgICAgcmRtYV9zdGFy
dF9pbmNvbWluZ19taWdyYXRpb24oJmNoYW5uZWwtPnUucmRtYSwgZXJycCk7DQotI2VuZGlmDQot
ICAgIH0gZWxzZSBpZiAoY2hhbm5lbC0+dHJhbnNwb3J0ID09IE1JR1JBVElPTl9BRERSRVNTX1RZ
UEVfRVhFQykgew0KLSAgICAgICAgZXhlY19zdGFydF9pbmNvbWluZ19taWdyYXRpb24oY2hhbm5l
bC0+dS5leGVjLmFyZ3MsIGVycnApOw0KKyAgICB9IGVsc2UgaWYgKGFkZHItPnRyYW5zcG9ydCA9
PSBNSUdSQVRJT05fQUREUkVTU19UWVBFX1JETUEpIHsNCisgICAgICAgIHJkbWFfc3RhcnRfaW5j
b21pbmdfbWlncmF0aW9uKCZhZGRyLT51LnJkbWEsIGVycnApOw0KKyAjZW5kaWYNCisgICAgfSBl
bHNlIGlmIChhZGRyLT50cmFuc3BvcnQgPT0gTUlHUkFUSU9OX0FERFJFU1NfVFlQRV9FWEVDKSB7
DQorICAgICAgICBleGVjX3N0YXJ0X2luY29taW5nX21pZ3JhdGlvbihhZGRyLT51LmV4ZWMuYXJn
cywgZXJycCk7DQogICAgIH0gZWxzZSB7DQogICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJ1bmtu
b3duIG1pZ3JhdGlvbiBwcm90b2NvbDogJXMiLCB1cmkpOw0KICAgICB9DQpAQCAtMTcwOSw3ICsx
NzIyLDggQEAgdm9pZCBxbXBfbWlncmF0ZShjb25zdCBjaGFyICp1cmksIGJvb2wgaGFzX2NoYW5u
ZWxzLA0KICAgICBib29sIHJlc3VtZV9yZXF1ZXN0ZWQ7DQogICAgIEVycm9yICpsb2NhbF9lcnIg
PSBOVUxMOw0KICAgICBNaWdyYXRpb25TdGF0ZSAqcyA9IG1pZ3JhdGVfZ2V0X2N1cnJlbnQoKTsN
Ci0gICAgZ19hdXRvcHRyKE1pZ3JhdGlvbkFkZHJlc3MpIGNoYW5uZWwgPSBnX25ldzAoTWlncmF0
aW9uQWRkcmVzcywgMSk7DQorICAgIGdfYXV0b3B0cihNaWdyYXRpb25DaGFubmVsKSBjaGFubmVs
ID0gZ19uZXcwKE1pZ3JhdGlvbkNoYW5uZWwsIDEpOw0KKyAgICBnX2F1dG9wdHIoTWlncmF0aW9u
QWRkcmVzcykgYWRkciA9IGdfbmV3MChNaWdyYXRpb25BZGRyZXNzLCAxKTsNCiANCiAgICAgLyoN
CiAgICAgICogSGF2aW5nIHByZWxpbWluYXJ5IGNoZWNrcyBmb3IgdXJpIGFuZCBjaGFubmVsDQpA
QCAtMTcxOSwxNCArMTczMywyMyBAQCB2b2lkIHFtcF9taWdyYXRlKGNvbnN0IGNoYXIgKnVyaSwg
Ym9vbCBoYXNfY2hhbm5lbHMsDQogICAgICAgICAgICAgICAgICAgICJleGNsdXNpdmU7IGV4YWN0
bHkgb25lIG9mIHRoZSB0d28gc2hvdWxkIGJlIHByZXNlbnQgaW4gIg0KICAgICAgICAgICAgICAg
ICAgICAiJ21pZ3JhdGUnIHFtcCBjb21tYW5kICIpOw0KICAgICAgICAgcmV0dXJuOw0KKyAgICB9
IGVsc2UgaWYgKGNoYW5uZWxzKSB7DQorICAgICAgICAvKiBUbyB2ZXJpZnkgdGhhdCBNaWdyYXRl
IGNoYW5uZWwgbGlzdCBoYXMgb25seSBpdGVtICovDQorICAgICAgICBpZiAoY2hhbm5lbHMtPm5l
eHQpIHsNCisgICAgICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJDaGFubmVsIGxpc3QgaGFzIG1v
cmUgdGhhbiBvbmUgZW50cmllcyIpOw0KKyAgICAgICAgICAgIHJldHVybjsNCisgICAgICAgIH0N
CisgICAgICAgIGNoYW5uZWwgPSBjaGFubmVscy0+dmFsdWU7DQorICAgIH0gZWxzZSB7DQorICAg
ICAgICAvKiBjYWxsZXIgdXNlcyB0aGUgb2xkIFVSSSBzeW50YXggKi8NCisgICAgICAgIGlmICh1
cmkgJiYgIW1pZ3JhdGVfdXJpX3BhcnNlKHVyaSwgJmNoYW5uZWwsIGVycnApKSB7DQorICAgICAg
ICAgICAgcmV0dXJuOw0KKyAgICAgICAgfQ0KICAgICB9DQotDQotICAgIGlmICghbWlncmF0ZV91
cmlfcGFyc2UodXJpLCAmY2hhbm5lbCwgZXJycCkpIHsNCi0gICAgICAgIHJldHVybjsNCi0gICAg
fQ0KKyAgICBhZGRyID0gY2hhbm5lbC0+YWRkcjsNCiANCiAgICAgLyogdHJhbnNwb3J0IG1lY2hh
bmlzbSBub3Qgc3VpdGFibGUgZm9yIG1pZ3JhdGlvbj8gKi8NCi0gICAgaWYgKCFtaWdyYXRpb25f
Y2hhbm5lbHNfYW5kX3RyYW5zcG9ydF9jb21wYXRpYmxlKGNoYW5uZWwsIGVycnApKSB7DQorICAg
IGlmICghbWlncmF0aW9uX2NoYW5uZWxzX2FuZF90cmFuc3BvcnRfY29tcGF0aWJsZShhZGRyLCBl
cnJwKSkgew0KICAgICAgICAgcmV0dXJuOw0KICAgICB9DQogDQpAQCAtMTc0Myw4ICsxNzY2LDgg
QEAgdm9pZCBxbXBfbWlncmF0ZShjb25zdCBjaGFyICp1cmksIGJvb2wgaGFzX2NoYW5uZWxzLA0K
ICAgICAgICAgfQ0KICAgICB9DQogDQotICAgIGlmIChjaGFubmVsLT50cmFuc3BvcnQgPT0gTUlH
UkFUSU9OX0FERFJFU1NfVFlQRV9TT0NLRVQpIHsNCi0gICAgICAgIFNvY2tldEFkZHJlc3MgKnNh
ZGRyID0gJmNoYW5uZWwtPnUuc29ja2V0Ow0KKyAgICBpZiAoYWRkci0+dHJhbnNwb3J0ID09IE1J
R1JBVElPTl9BRERSRVNTX1RZUEVfU09DS0VUKSB7DQorICAgICAgICBTb2NrZXRBZGRyZXNzICpz
YWRkciA9ICZhZGRyLT51LnNvY2tldDsNCiAgICAgICAgIGlmIChzYWRkci0+dHlwZSA9PSBTT0NL
RVRfQUREUkVTU19UWVBFX0lORVQgfHwNCiAgICAgICAgICAgICBzYWRkci0+dHlwZSA9PSBTT0NL
RVRfQUREUkVTU19UWVBFX1VOSVggfHwNCiAgICAgICAgICAgICBzYWRkci0+dHlwZSA9PSBTT0NL
RVRfQUREUkVTU19UWVBFX1ZTT0NLKSB7DQpAQCAtMTc1MywxMSArMTc3NiwxMSBAQCB2b2lkIHFt
cF9taWdyYXRlKGNvbnN0IGNoYXIgKnVyaSwgYm9vbCBoYXNfY2hhbm5lbHMsDQogICAgICAgICAg
ICAgZmRfc3RhcnRfb3V0Z29pbmdfbWlncmF0aW9uKHMsIHNhZGRyLT51LmZkLnN0ciwgJmxvY2Fs
X2Vycik7DQogICAgICAgICB9DQogI2lmZGVmIENPTkZJR19SRE1BDQotICAgIH0gZWxzZSBpZiAo
Y2hhbm5lbC0+dHJhbnNwb3J0ID09IE1JR1JBVElPTl9BRERSRVNTX1RZUEVfUkRNQSkgew0KLSAg
ICAgICAgcmRtYV9zdGFydF9vdXRnb2luZ19taWdyYXRpb24ocywgJmNoYW5uZWwtPnUucmRtYSwg
JmxvY2FsX2Vycik7DQorICAgIH0gZWxzZSBpZiAoYWRkci0+dHJhbnNwb3J0ID09IE1JR1JBVElP
Tl9BRERSRVNTX1RZUEVfUkRNQSkgew0KKyAgICAgICAgcmRtYV9zdGFydF9vdXRnb2luZ19taWdy
YXRpb24ocywgJmFkZHItPnUucmRtYSwgJmxvY2FsX2Vycik7DQogI2VuZGlmDQotICAgIH0gZWxz
ZSBpZiAoY2hhbm5lbC0+dHJhbnNwb3J0ID09IE1JR1JBVElPTl9BRERSRVNTX1RZUEVfRVhFQykg
ew0KLSAgICAgICAgZXhlY19zdGFydF9vdXRnb2luZ19taWdyYXRpb24ocywgY2hhbm5lbC0+dS5l
eGVjLmFyZ3MsICZsb2NhbF9lcnIpOw0KKyAgICB9IGVsc2UgaWYgKGFkZHItPnRyYW5zcG9ydCA9
PSBNSUdSQVRJT05fQUREUkVTU19UWVBFX0VYRUMpIHsNCisgICAgICAgIGV4ZWNfc3RhcnRfb3V0
Z29pbmdfbWlncmF0aW9uKHMsIGFkZHItPnUuZXhlYy5hcmdzLCAmbG9jYWxfZXJyKTsNCiAgICAg
fSBlbHNlIHsNCiAgICAgICAgIGlmICghcmVzdW1lX3JlcXVlc3RlZCkgew0KICAgICAgICAgICAg
IHlhbmtfdW5yZWdpc3Rlcl9pbnN0YW5jZShNSUdSQVRJT05fWUFOS19JTlNUQU5DRSk7DQotLSAN
CjIuMjIuMw0KDQo=

