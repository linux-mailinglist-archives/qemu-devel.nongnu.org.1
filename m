Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E04376A49B
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 01:13:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQc2y-00078g-UC; Mon, 31 Jul 2023 19:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qQc2w-00078S-Oy; Mon, 31 Jul 2023 19:11:26 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qQc2u-0007mC-Qc; Mon, 31 Jul 2023 19:11:26 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36VF6BJq026917; Mon, 31 Jul 2023 16:11:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=proofpoint20171006; bh=zpQvZq63jOldt0nwfJSG3S+cega7X77CW28+z/
 rKk5E=; b=kbqGX2gOVNW+1uR+oT0wBp8zcBLPfQmiyxxiMSoiqJCt9k8nVlWGr0
 /fxnzcxAZKfpArdkW/xciEioiYXIWSNvf7q9fECb0mtHPnbFy7ViTSBc+NXa4heT
 Ga6v1lk+AUku1gBTk9n7P4jkwo0JXsegrkNKf+zagMDi/RnHpbXg0yyMb9ESCPy3
 yNa10Lm0L+xnytmAjj5Mp6FTHYvL9EghCtQK+eCkvNfT+H/AtoY3ZqiTfyyY+Ghy
 G6khnsdgYkrNobAg0HIGSW7jam4/9/NOtxAxl8swyK2FZiImav2yHdPjKCxIrtq9
 Vz9rGkve3AtcwN6zhfphwzoMRaMfccCg==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3s50a641nk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Jul 2023 16:11:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKVnWefE5jPcq+wJ8i46TuMOetcQa6YkqrCgv77IOH20mp02lt5TzxgiZg9myjS5//Kn1+iVY+csh9QUTILSt+E1yWxcXf4BisWftXvwifNaw26cT7KKOT0hJNliHkuVbegL5DGgQglkkvMHLNMJH90DsMn9soNspuWTKm2vpSVH/EE8eWHhUbVqbfbmGioOk8zFCLNcbZ/5ucHoPKRbeKEp56cnEOvfyUHmUDPBbpd6O6wrfUuMe1ux/AOdpVhZSc/QVaUuRU1Qe23ddRUam6eGDHD4S+j21wI1O8yLOwckv8fApjokpC7iYfu1Cuptr9hz7yRZUxArtg2Gtlzm6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpQvZq63jOldt0nwfJSG3S+cega7X77CW28+z/rKk5E=;
 b=n1r2CIZsptOhs1Jul3+Ssik7aoQBRBrK67itGtSTc48qgkO7luFSrP/RSMIOulPote69KbpZw62nIeg3HU7aDUBFCKGS6XUQ0FoFiwrDM0QVX2+2GaG07o7t5uz6fN54N4jrEDIbgz6i6pwPW0ieKFgeI3cVOQlDwUZoeQpM4wtJ/6LDs82XPvH6aQvT6rhvMDHtlLB753asJ7EkDyM6UxFjd7+wgwIJxDS2b/oid7pa8HIxZmJeBjwhlsDxjmtVc1TZuG9k8xYqpT8ohBTUCKuaYhUNXDSF+C667KvKkTz0Dra7AL1KEgp72L3fOUCUtKvc9P3ReG4HtN87hpd6JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpQvZq63jOldt0nwfJSG3S+cega7X77CW28+z/rKk5E=;
 b=UELjqTQD8dZAodcwbMhIxvrv6+Ibfkds00eh9Z63IF5n17tQJpGc8WeOA08z48+/s2mGCmtYcfszrF3pZydPVJLS+H70thfaemZX9dpOTX+4du4375ue1FR09XM2pzRFQKhbUGEJBsvwOy1OH0a8nsefksRsEQgecncbDv9dwx/7M59RPGlO8cEhRj1Gk9IuI0tjGZD80kpP7BCvRZve7qkrlcvYtjK0YGQ/wEoV8DHy14bC4Y8uw4IrtIqzphM6F1AafFIj7kJyUGz+ZJ22k+3NiTl1SvVx11kXGrPWbBGxh6NH+7MR7OpLHOZkkFGtbZJ92gP8oLiIoqAwqLcfUw==
Received: from BL3PR02MB7938.namprd02.prod.outlook.com (2603:10b6:208:355::20)
 by IA1PR02MB9182.namprd02.prod.outlook.com (2603:10b6:208:42a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.5; Mon, 31 Jul
 2023 23:11:09 +0000
Received: from BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::6abe:dbe0:dc92:9239]) by BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::6abe:dbe0:dc92:9239%3]) with mapi id 15.20.6652.004; Mon, 31 Jul 2023
 23:11:08 +0000
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: Li Feng <fengli@smartx.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam
 Zheng <fam@euphon.net>, =?utf-8?B?QWxleCBCZW5uw6ll?=
 <alex.bennee@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "open
 list:Block layer core" <qemu-block@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 2/4] vhost-user-common: send get_inflight_fd once
Thread-Topic: [PATCH v2 2/4] vhost-user-common: send get_inflight_fd once
Thread-Index: AQHZvuTf0tONfWzQHEWFimKSn57JOK/OtNUAgAAdVACABBYxAIAA4POAgADBe4A=
Date: Mon, 31 Jul 2023 23:11:08 +0000
Message-ID: <89814197-217B-4BF9-9211-3E84FBE6DDAB@nutanix.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230725104256.4861-1-fengli@smartx.com>
 <20230725104256.4861-3-fengli@smartx.com>
 <20230728020156-mutt-send-email-mst@kernel.org>
 <09BB8CEC-26F4-4FC5-A2DB-479FCD5F0548@smartx.com>
 <70D32B59-8B40-45E2-AFEC-0E3395867D15@nutanix.com>
 <8D0EABBD-CB21-4BF4-A96F-CC64CA92C99B@smartx.com>
In-Reply-To: <8D0EABBD-CB21-4BF4-A96F-CC64CA92C99B@smartx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB7938:EE_|IA1PR02MB9182:EE_
x-ms-office365-filtering-correlation-id: fa26622e-6a5e-483c-7952-08db921b6cb2
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i6zGmucCMIA766zmwmjOG7W1/pzwxrOHJ7FNl5DBzAopkPR/ngTmp4/tgHkxhDCEForP2q5K3he+J0tOxt+M97dOpaR75Vn/Sivn6uuR0ssEyCzfJ4Z2RoRdr4cldFpKTyM1+HD+Ko1ryoEpItsS3uCUqtUXW7aurUrsewvsmWLz2eBt9i3+kMthNsS5w0UthkAw2tnl2/Pxi7hVUUwWAeSFU+TC04b2E7ekiZqERaJjaTIMhSLybrvXzZeDhUlQvI1jvNbskuFvYUxu4TDUQQePgOCHptTOTJnssa6n9+1kkZFnoxBvFGjLljUUuq1oTFVQdBQSNe1UaffhSpWRcXSfro9BKr6/A0L/fzIFCz9CpEBjk2oAJ0DXB9Lsea4mQhVGYq8coRuLOPXlP6A8/3rJHnivtevTfFPs8lkDLm7jLidrkX6W4wk2rg2hfLanDxa/F6RTkYmuAJC+HKbWB5j+mCsboWAnCSxcJAd5MP6aaZzsNE1GgDeowyU3Ti5eT4N3i7cY2gE75J4PFgXaVnfB1vkSSzCQUpng5t4cm9PpgVhRpkon+/cpMWA93hoWjNGJjIWyqjq6TQs9ozQjgYA7EYgx58gJGHPtQmaJApyTGn1ztS2U4rXeNTAzeBeTNjKz3qVRlvrW93Udlp5BIw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR02MB7938.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199021)(66476007)(64756008)(26005)(41300700001)(316002)(53546011)(6916009)(4326008)(8676002)(6506007)(8936002)(33656002)(54906003)(122000001)(478600001)(66946007)(66446008)(6512007)(76116006)(91956017)(66556008)(71200400001)(36756003)(6486002)(38100700002)(2616005)(38070700005)(2906002)(83380400001)(86362001)(186003)(7416002)(44832011)(5660300002)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3pvcXRETzlwaDJNZVNVUit5TEZDbnVYcmRLeGVMSFRKVnF0MUtsRFNCWWND?=
 =?utf-8?B?d01yUWlRVXdYaGVoMytONEFoQXFNYXQrdWZINHJRYklTeWJNd0ViWVRvYXBF?=
 =?utf-8?B?blM3dlZYaTNFVXB4WTdBdkd1S2lRd0Q3WnVvWlZCZGRPQTVhY2UvNkNROUt5?=
 =?utf-8?B?eEh2R2t0bXhYNUlldytqbytOVkw3TGJRTU5SSFAwY0FMdE5zVk1NYUFld0Uw?=
 =?utf-8?B?M0FhOFFxdU40d09kVU1qbVd5T1huamMvU3phdThEUS9CRDhxNjZzcjUvWFhp?=
 =?utf-8?B?bUdjbXR5VWxPdjVyK1J5d2w1WHpWVUdUdW1NYmpzLzN3SHpUQ2JDb0t0b25L?=
 =?utf-8?B?a1RSelJEcmRyVGhqT3VsS2MrL2JLT3hzcHlZcjhpdHBWUTZzTnFITjFhb0dL?=
 =?utf-8?B?V2xSUFVKRTN3djRreURmTGNaMCs2WmJTWDc0Nk8yZEdDdFFpaXNtUDF6Q3JQ?=
 =?utf-8?B?NmtCUTZFRG8vaVNPekNnTFZMMU41VlVlZXduNTNRTTVFNC81dTlMVXRUZTlF?=
 =?utf-8?B?Yk5hU203V2wvQkJZRFRGOVRYSmROVFJSTU43aGordXc4RUhYR0pNVS9pRjFD?=
 =?utf-8?B?SFV4ZTFRS1NudytITm5FOExmRjMxa3FUWEJ6cU9TSUs5K29MVkZBVDZOYUt4?=
 =?utf-8?B?cVZBNEtSb3RPYzlibTF1UHJUUG93TnpiRU00ZDhnTTRaT05SV2M4V1JiN0Z3?=
 =?utf-8?B?Y25EMzdhbjFMeUxHNmozSjhvVW1sc2NaSnozUW92MmdMdVJnSDNzUWt6STJB?=
 =?utf-8?B?M0x1Y0JCSnp4TjJuTXlWWFFQWUpZSzNVVW9rMnQ3WFZLVll5V01CUGRRV1Bl?=
 =?utf-8?B?NUpRamkxajJsT0xDZ1lzSVoyaWhSaHVWekFyY1pwMHR2MStrNXdZNEU3d3hj?=
 =?utf-8?B?VDBGblhSazNjc3AwYmlMQWpDQytKZE51T0lLOXdTVjFVcm9KOU9uMlNPWWdR?=
 =?utf-8?B?RFBUQnFMSDBIbGxjKzFZY1hBcWxjNGRqdXd0eUVBRWdHTHVQT3VCS2ViY1R2?=
 =?utf-8?B?VThsaDAxbW9EUXNMZmt2OE9lTDhYVjZjUFZlWG9kVEdXMzhzMXFuTlRuOXps?=
 =?utf-8?B?ZUgySWwyU3NyZ1lycjFkNVg0anduQTVxU1I3TzRQSkxQL2FwQ0ZYU1RvQ1Fs?=
 =?utf-8?B?NUcyUENLaHYvVFRkVE9oRFc4WEY5UWRLWnVjM0Q0WlMyMU9ybEhOUjJaV0hC?=
 =?utf-8?B?Y1UvM2JnWFd1YU5TdjJHZlNja2xMb3gyKzlwb0tQSWZDVG52a0RBZEh3WmMx?=
 =?utf-8?B?QjBVQmxnbVFZQnhkS0RxWXVLQ0Z3N3Z2Nm1PcWdTL1JTMUxaTjBYY092TlZl?=
 =?utf-8?B?NVpNL1pjYVZVL3NqL1EwZXdZOW5MejRFMXpDRkgvUjJzTmV6NXhxUTNJZWF4?=
 =?utf-8?B?MWJkQy8wUXlta1NEYkRxTzRIL2V0K0R2bDFaaUNrVWFZeFUvYTNHZks4MGNs?=
 =?utf-8?B?RGlGcE1nRTJvMTVRRFhjdUVsTkRXOC9ITkNkYkVtWGNyMUNVejhBamhqN0xE?=
 =?utf-8?B?aXZYRFdCQzN3bklsYmNSQjNKZHlEd0dEbkFBR1RMODJINnF2UEJVL0F0S1dk?=
 =?utf-8?B?TzlqcXRpZllrWDBab21lemlzeUdBQkRJMUhpU01jdWZNMnFpVHI4Z3k3azha?=
 =?utf-8?B?ZWZmMWtESDBhcmVwY21mZGRQdW5oMjlKWE1XaFJUVi9GNnhRUlZlTzhoUS9o?=
 =?utf-8?B?L3AvRmdUVlJKMVIxT3NvZmxDYmE2RDNPY2d1Wm5lb0dZM3pmRW93UEE0Rk8x?=
 =?utf-8?B?YzE1eEVPKzhDUGl4aTNJUHhqNXdVRTkvSlUwODROdmcvUVk5SkZ6SWswUnlE?=
 =?utf-8?B?ZkVlMlRBc0M4YWRkWm5uY2J6TUZMVDZ5WWxXMXNMM0lKZThnaHhBVnJuQXZk?=
 =?utf-8?B?di9uME53cVJqUWRHanNML09vL0hjdllNL3VQVk8xVElsNnRXTXpONHFkVUc3?=
 =?utf-8?B?NTEvTzJUYUg2Z3laSlEwVS9DU3cwRFBMR3lpV3pwTWdWZWN1Wmw1MWpKejZu?=
 =?utf-8?B?eVR1cGF4c002eTh3UW9EQnl4Tk05R1hnMjRqZEd6V1llSUFwOHhPdC95TTMy?=
 =?utf-8?B?bnRId29ra0t6ZFNDY0dCaUpzeS9IUGtUTk9sSXVXWVljaElySHR2VkowVTR1?=
 =?utf-8?B?NDNvU0d5Y0VSc0RKcDU2S00yTTEwOUpVZjNkWGtaRmdOUFlYV2dPSng3SE9J?=
 =?utf-8?B?R1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4237FD028A54DF4FB2C8BE72600080D6@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB7938.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa26622e-6a5e-483c-7952-08db921b6cb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 23:11:08.8456 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tygZVOC6P2TWJY2o2DxH82G5H3ovRGh3zuZsgmT3f0SZFGhFpBwFcRzmStGbBSTaPewIymssiA2qz1aCQOgR8WSL19es48XLVZnOF7/lsrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9182
X-Proofpoint-ORIG-GUID: Wb7Vz9SRstEvxsX1_nsF1SYPG6DPE9hI
X-Proofpoint-GUID: Wb7Vz9SRstEvxsX1_nsF1SYPG6DPE9hI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_15,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=raphael.norwitz@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

DQoNCj4gT24gSnVsIDMxLCAyMDIzLCBhdCA3OjM4IEFNLCBMaSBGZW5nIDxmZW5nbGlAc21hcnR4
LmNvbT4gd3JvdGU6DQo+IA0KPiANCj4gDQo+PiAyMDIz5bm0N+aciDMx5pelIDA2OjEz77yMUmFw
aGFlbCBOb3J3aXR6IDxyYXBoYWVsLm5vcndpdHpAbnV0YW5peC5jb20+IOWGmemBk++8mg0KPj4g
DQo+Pj4gDQo+Pj4gT24gSnVsIDI4LCAyMDIzLCBhdCAzOjQ5IEFNLCBMaSBGZW5nIDxmZW5nbGlA
c21hcnR4LmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4gDQo+Pj4gDQo+Pj4+IDIwMjPlubQ35pyIMjjm
l6Ug5LiL5Y2IMjowNO+8jE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IOWGmemB
k++8mg0KPj4+PiANCj4+Pj4gT24gVHVlLCBKdWwgMjUsIDIwMjMgYXQgMDY6NDI6NDVQTSArMDgw
MCwgTGkgRmVuZyB3cm90ZToNCj4+Pj4+IEdldF9pbmZsaWdodF9mZCBpcyBzZW50IG9ubHkgb25j
ZS4gV2hlbiByZWNvbm5lY3RpbmcgdG8gdGhlIGJhY2tlbmQsDQo+Pj4+PiBxZW11IHNlbnQgc2V0
X2luZmxpZ2h0X2ZkIHRvIHRoZSBiYWNrZW5kLg0KPj4+PiANCj4+Pj4gSSBkb24ndCB1bmRlcnN0
YW5kIHdoYXQgeW91IGFyZSB0cnlpbmcgdG8gc2F5IGhlcmUuDQo+Pj4+IFNob3VsZCBiZToNCj4+
Pj4gQ3VycmVudGx5IEFCQ0QuIFRoaXMgaXMgd3JvbmcvdW5uZWNlc3NhcnkgYmVjYXVzZSBFRkcu
IFRoaXMgcGF0Y2ggSElKLg0KPj4+IA0KPj4+IFRoYW5rcywgSSB3aWxsIHJlb3JnYW5pemUgdGhl
IGNvbW1pdCBtZXNzYWdlIGluIHYzLg0KPj4+PiANCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IExpIEZl
bmcgPGZlbmdsaUBzbWFydHguY29tPg0KPj4+Pj4gLS0tDQo+Pj4+PiBody9zY3NpL3Zob3N0LXNj
c2ktY29tbW9uLmMgfCAzNyArKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tDQo+
Pj4+PiAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pDQo+
Pj4+PiANCj4+Pj4+IGRpZmYgLS1naXQgYS9ody9zY3NpL3Zob3N0LXNjc2ktY29tbW9uLmMgYi9o
dy9zY3NpL3Zob3N0LXNjc2ktY29tbW9uLmMNCj4+Pj4+IGluZGV4IGEwNmYwMWFmMjYuLjY2NGFk
YjE1YjQgMTAwNjQ0DQo+Pj4+PiAtLS0gYS9ody9zY3NpL3Zob3N0LXNjc2ktY29tbW9uLmMNCj4+
Pj4+ICsrKyBiL2h3L3Njc2kvdmhvc3Qtc2NzaS1jb21tb24uYw0KPj4+Pj4gQEAgLTUyLDIwICs1
MiwyOCBAQCBpbnQgdmhvc3Rfc2NzaV9jb21tb25fc3RhcnQoVkhvc3RTQ1NJQ29tbW9uICp2c2Mp
DQo+Pj4+PiANCj4+Pj4+ICAgIHZzYy0+ZGV2LmFja2VkX2ZlYXR1cmVzID0gdmRldi0+Z3Vlc3Rf
ZmVhdHVyZXM7DQo+Pj4+PiANCj4+Pj4+IC0gICAgYXNzZXJ0KHZzYy0+aW5mbGlnaHQgPT0gTlVM
TCk7DQo+Pj4+PiAtICAgIHZzYy0+aW5mbGlnaHQgPSBnX25ldzAoc3RydWN0IHZob3N0X2luZmxp
Z2h0LCAxKTsNCj4+Pj4+IC0gICAgcmV0ID0gdmhvc3RfZGV2X2dldF9pbmZsaWdodCgmdnNjLT5k
ZXYsDQo+Pj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdnMtPmNvbmYudmly
dHF1ZXVlX3NpemUsDQo+Pj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdnNj
LT5pbmZsaWdodCk7DQo+Pj4+PiArICAgIHJldCA9IHZob3N0X2Rldl9wcmVwYXJlX2luZmxpZ2h0
KCZ2c2MtPmRldiwgdmRldik7DQo+Pj4+PiAgICBpZiAocmV0IDwgMCkgew0KPj4+Pj4gLSAgICAg
ICAgZXJyb3JfcmVwb3J0KCJFcnJvciBnZXQgaW5mbGlnaHQ6ICVkIiwgLXJldCk7DQo+Pj4+PiAr
ICAgICAgICBlcnJvcl9yZXBvcnQoIkVycm9yIHNldHRpbmcgaW5mbGlnaHQgZm9ybWF0OiAlZCIs
IC1yZXQpOw0KPj4+Pj4gICAgICAgIGdvdG8gZXJyX2d1ZXN0X25vdGlmaWVyczsNCj4+Pj4+ICAg
IH0NCj4+Pj4+IA0KPj4+Pj4gLSAgICByZXQgPSB2aG9zdF9kZXZfc2V0X2luZmxpZ2h0KCZ2c2Mt
PmRldiwgdnNjLT5pbmZsaWdodCk7DQo+Pj4+PiAtICAgIGlmIChyZXQgPCAwKSB7DQo+Pj4+PiAt
ICAgICAgICBlcnJvcl9yZXBvcnQoIkVycm9yIHNldCBpbmZsaWdodDogJWQiLCAtcmV0KTsNCj4+
Pj4+IC0gICAgICAgIGdvdG8gZXJyX2d1ZXN0X25vdGlmaWVyczsNCj4+Pj4+ICsgICAgaWYgKHZz
Yy0+aW5mbGlnaHQpIHsNCj4+Pj4+ICsgICAgICAgIGlmICghdnNjLT5pbmZsaWdodC0+YWRkcikg
ew0KPj4+Pj4gKyAgICAgICAgICAgIHJldCA9IHZob3N0X2Rldl9nZXRfaW5mbGlnaHQoJnZzYy0+
ZGV2LA0KPj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2cy0+
Y29uZi52aXJ0cXVldWVfc2l6ZSwNCj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdnNjLT5pbmZsaWdodCk7DQo+Pj4+PiArICAgICAgICAgICAgaWYgKHJldCA8
IDApIHsNCj4+Pj4+ICsgICAgICAgICAgICAgICAgZXJyb3JfcmVwb3J0KCJFcnJvciBnZXQgaW5m
bGlnaHQ6ICVkIiwgLXJldCk7DQo+Pj4+IA0KPj4+PiBBcyBsb25nIGFzIHlvdSBhcmUgZml4aW5n
IHRoaXMgLSBzaG91bGQgYmUgImdldHRpbmcgaW5mbGlnaHTigJ0uDQo+Pj4gSSB3aWxsIGZpeCBp
dCBpbiB2My4NCj4+Pj4gDQo+Pj4+PiArICAgICAgICAgICAgICAgIGdvdG8gZXJyX2d1ZXN0X25v
dGlmaWVyczsNCj4+Pj4+ICsgICAgICAgICAgICB9DQo+Pj4+PiArICAgICAgICB9DQo+Pj4+PiAr
DQo+PiANCj4+IExvb2tzIGxpa2UgeW91IHJld29ya2VkIHRoaXMgYSBiaXQgc28gdG8gYXZvaWQg
YSBwb3RlbnRpYWwgY3Jhc2ggaWYgdnNjLT5pbmZsaWdodCBpcyBOVUxMDQo+PiANCj4+IFNob3Vs
ZCB3ZSBmaXggaXQgZm9yIHZob3N0LXVzZXItYmxrIHRvbz8NCj4+IA0KPiBUaGlzIGNoZWNrIGlz
IG1haW5seSBmb3IgdGhlIHZob3N0LXNjc2kgY29kZSwgdGhhdCBkb2VzbuKAmXQgbmVlZCBhbGxv
Y2F0ZSB0aGUgaW5mbGlnaHQgbWVtb3J5Lg0KPiANCj4gVGhlIHZob3N0LXVzZXItYmxrIGRvZXNu
4oCZdCBuZWVkIHRoaXMgY2hlY2ssIGJlY2F1c2UgdGhlcmUgaXNuJ3QgYSB2aG9zdC1ibGsgZGV2
aWNlIHRoYXQgcmV1c2UgdGhlIGNvZGUuDQo+IA0KDQpNYWtlcyBzZW5zZS4NCg0KPj4+Pj4gKyAg
ICAgICAgcmV0ID0gdmhvc3RfZGV2X3NldF9pbmZsaWdodCgmdnNjLT5kZXYsIHZzYy0+aW5mbGln
aHQpOw0KPj4+Pj4gKyAgICAgICAgaWYgKHJldCA8IDApIHsNCj4+Pj4+ICsgICAgICAgICAgICBl
cnJvcl9yZXBvcnQoIkVycm9yIHNldCBpbmZsaWdodDogJWQiLCAtcmV0KTsNCj4+Pj4+ICsgICAg
ICAgICAgICBnb3RvIGVycl9ndWVzdF9ub3RpZmllcnM7DQo+Pj4+PiArICAgICAgICB9DQo+Pj4+
PiAgICB9DQo+Pj4+PiANCj4+Pj4+ICAgIHJldCA9IHZob3N0X2Rldl9zdGFydCgmdnNjLT5kZXYs
IHZkZXYsIHRydWUpOw0KPj4+Pj4gQEAgLTg1LDkgKzkzLDYgQEAgaW50IHZob3N0X3Njc2lfY29t
bW9uX3N0YXJ0KFZIb3N0U0NTSUNvbW1vbiAqdnNjKQ0KPj4+Pj4gICAgcmV0dXJuIHJldDsNCj4+
Pj4+IA0KPj4+Pj4gZXJyX2d1ZXN0X25vdGlmaWVyczoNCj4+Pj4+IC0gICAgZ19mcmVlKHZzYy0+
aW5mbGlnaHQpOw0KPj4+Pj4gLSAgICB2c2MtPmluZmxpZ2h0ID0gTlVMTDsNCj4+Pj4+IC0NCj4+
Pj4+ICAgIGstPnNldF9ndWVzdF9ub3RpZmllcnMocWJ1cy0+cGFyZW50LCB2c2MtPmRldi5udnFz
LCBmYWxzZSk7DQo+Pj4+PiBlcnJfaG9zdF9ub3RpZmllcnM6DQo+Pj4+PiAgICB2aG9zdF9kZXZf
ZGlzYWJsZV9ub3RpZmllcnMoJnZzYy0+ZGV2LCB2ZGV2KTsNCj4+Pj4+IEBAIC0xMTEsMTIgKzEx
Niw2IEBAIHZvaWQgdmhvc3Rfc2NzaV9jb21tb25fc3RvcChWSG9zdFNDU0lDb21tb24gKnZzYykN
Cj4+Pj4+ICAgIH0NCj4+Pj4+ICAgIGFzc2VydChyZXQgPj0gMCk7DQo+Pj4+PiANCj4+IA0KPj4g
QXMgSSBzYWlkIGJlZm9yZSwgSSB0aGluayB0aGlzIGludHJvZHVjZXMgYSBsZWFrLg0KPiBJIGhh
dmUgYW5zd2VyZWQgaW4gdGhlIHByZXZpb3VzIG1haWwuDQo+IA0KDQpPbiByZS1yZXZpZXcgSSBh
Z3JlZSBpdOKAmXMgZmluZSBzaW5jZSB2YWMtaW5mbGlnaHQgaXNu4oCZdCBzZXQuDQoNCj4+IA0K
Pj4+Pj4gLSAgICBpZiAodnNjLT5pbmZsaWdodCkgew0KPj4+Pj4gLSAgICAgICAgdmhvc3RfZGV2
X2ZyZWVfaW5mbGlnaHQodnNjLT5pbmZsaWdodCk7DQo+Pj4+PiAtICAgICAgICBnX2ZyZWUodnNj
LT5pbmZsaWdodCk7DQo+Pj4+PiAtICAgICAgICB2c2MtPmluZmxpZ2h0ID0gTlVMTDsNCj4+Pj4+
IC0gICAgfQ0KPj4+Pj4gLQ0KPj4+Pj4gICAgdmhvc3RfZGV2X2Rpc2FibGVfbm90aWZpZXJzKCZ2
c2MtPmRldiwgdmRldik7DQo+Pj4+PiB9DQo+Pj4+PiANCj4+Pj4+IC0tIA0KPj4+Pj4gMi40MS4w
DQoNCg==

