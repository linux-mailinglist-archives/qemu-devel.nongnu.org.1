Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B59DA726611
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 18:33:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6w5M-0007NO-Fx; Wed, 07 Jun 2023 12:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=515b4f0f9=Niklas.Cassel@wdc.com>)
 id 1q6w5J-0007N8-Vs; Wed, 07 Jun 2023 12:32:34 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=515b4f0f9=Niklas.Cassel@wdc.com>)
 id 1q6w5G-0002Sx-CW; Wed, 07 Jun 2023 12:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1686155550; x=1717691550;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=6WHTpl8WHScRe22RrqD+O3zwfrnpBIgXkwxgrzf7eAU=;
 b=JJQRiztGApZr+pXvNxP/lcPKLWNiHlGYCdHjYlwAKBXapQFCKZppqfnI
 l6vPYaGBj5YHlB6lhcekwLKxiSmEAPKhDE7knfyRN15MdXEWtMkHwJIx8
 bdgzEd135ui2Nr5aJcjuDDE1ljvEDFjNnv5URSzrdL424jUMJmPgyUIws
 yZox38QJYzjCZ6vJrx4hpH85GTejgV5YGiz2sawQ86Tp/aIPJmXfLN8cC
 wB58HZ6y06IP2mGvWCQle7We3rUGdjIgpo6jmFPT9qNw7IQFa40BplFVx
 O05cvB0uilW7egs7eIkeHVGg4rrPSAi6l96q2uX1Qpy0KW3CVtiahcUqp Q==;
X-IronPort-AV: E=Sophos;i="6.00,224,1681142400"; d="scan'208";a="233036827"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2023 00:32:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzgXQWEInUUUIAHcd5MK1WBl1K3lHrpkimHVpbBIFfok5F8cSooA7qP+bjiAnAVx+iRynfL9esY4B1hOxM3DEreGl74VE+2TbakyEeXjIxIvcin7kVuCuRB51m6B6woYGan6gqYFT1IBU8Uvi1+rP5QATCT+LzOBCmH5resjnEza1xkv3BRiGYRLymnJ7+6DP9pnZMIS1dTyrPjjwo6DQS5FSRt1s+In6V9GNnrg8CwOuzqGzBROAX3vBJOIJKGprQfUlLZ5p0VHE+b2Bv+UqN3APBc/sqLeLwHV3BE4uZJKloeoJnNqqAMSWdsXLrk3u1wptu4FbG/BQLUE2c+AIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WHTpl8WHScRe22RrqD+O3zwfrnpBIgXkwxgrzf7eAU=;
 b=E50ISfgd/qYGgGy5c7JIy0dOr3eIL+f/SoUcBVOG/8bq4rWTw7FjII3QdsYtjMqRHOnARBtyPE6zIyEdyxWvt7uQ43r0fmtpZVC8+rs9K/pq7bxdOUZ512q5f4DO/4x+EZ85XCMf2kA6jens+1x3uKuSaG3yoZ+OdhkBuo9YAycJItyTn1lMUgjv0qdeGXeZzuB9/oqy5yZvXzcsUBjQy3wi7v6IwEesK0OWu40gHJhEfr6GLOM3yQhc9VktOcAkFliZoWKhhuagqHrRg8h3G9ENw1iMgWmROBK5a/ue1OGmADAEek9mvAIQ5qqVufztEc4e1CQN8i99TyNeTv3Y6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WHTpl8WHScRe22RrqD+O3zwfrnpBIgXkwxgrzf7eAU=;
 b=ZnDLtLhAPL11zOgneMqf0yoN7ak++T2CCjjaflC/m5vCDzl6h6t1ZGU7Uid+UKM1ecGF6JEbeqMR2DLV4Mx1cagMb5VPf49Wyc2hVQYZK9bL5BBk7jFXNwUc/g/cGnC96Km6KiPt7k/JA3PqDpctsF0gI30UNs15ssSKpKiEglI=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by PH7PR04MB8521.namprd04.prod.outlook.com (2603:10b6:510:2b8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 16:32:22 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d8ec:2aa9:9ddf:5af9]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d8ec:2aa9:9ddf:5af9%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 16:32:22 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: John Snow <jsnow@redhat.com>
CC: Niklas Cassel <nks@flawful.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v2 5/8] hw/ide/ahci: PxCI should not get cleared when
 ERR_STAT is set
Thread-Topic: [PATCH v2 5/8] hw/ide/ahci: PxCI should not get cleared when
 ERR_STAT is set
Thread-Index: AQHZmAyiwKDusrJ5mUOPZxqulXEU0a9/gnyAgAAIqgA=
Date: Wed, 7 Jun 2023 16:32:21 +0000
Message-ID: <ZICxEuyDU5K+2GB8@x1-carbon>
References: <20230601134434.519805-1-nks@flawful.org>
 <20230601134434.519805-6-nks@flawful.org>
 <CAFn=p-Zy_Sg1GwzmNUS1WwGTDR2kvxoz8_=9KC9Y_r2Ckd5siA@mail.gmail.com>
 <ZICpza8boQt4v/Yr@x1-carbon>
In-Reply-To: <ZICpza8boQt4v/Yr@x1-carbon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|PH7PR04MB8521:EE_
x-ms-office365-filtering-correlation-id: f86b223d-b14f-4ea0-1765-08db6774c4e6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sXbBCdtpM/5UwbsGEFDkLrmmAkxhDfe3hr5mrfKoWtRpcRcRu2tR1U/SXGp6Ies4UrD9capwoVXumdSmZTzIX5J5+qL/vlMJwscoMRNMqupwCE2FkZgrX2WMMXrvpT3TGNM42R/UB3PdaYMwXpq5wPRK0B4ETHDjnhp4WErppf6n0MvBeadRSvzaSfcVrP39GIe8aa6pGd0e0/gGvsLBMtCskoBW0Zgtnf/cKkqDm666nagvnucGqQS153b6E4s326U4ajrLY9uzznsqmaXwK1atDmZiV09aNKM3xGQzxU+407zIWNmHX0vBogT1iChZGZY90aKhkptUM1Ne+EcmJjlQXDBShtzxIMGZBI9iHlYXCM7WiHk15KNZr8CWHO9HVEP9vJr2cCrd4K5u/2u7T6gR4VtpiSiy23ZSC/lOi92Dtzd+JX/3CIpzCVYEnuXXx423Q7eQG9/7P7RElgWTg+Eccqv+nTy87wUfO1CfyKC0uS3/Dl2gNBDDS+MjhNIjBCy5fXfZkk6wg3/sY5pGCT0Saidd7JVuvnpeSSsVEYtB9IFw6ii5TZ0O4N6P8ckXj84MCjiOAoVl/1lBHZzVWghXNTnnG1J4JzLKEUbhdWQ/RtJMpe3thldcxhaTYHCOddThbJJ9BTxuMUMQztAaZQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6272.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(7916004)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199021)(83380400001)(2906002)(33716001)(86362001)(38070700005)(122000001)(82960400001)(38100700002)(41300700001)(6486002)(316002)(5660300002)(8936002)(8676002)(478600001)(54906003)(64756008)(91956017)(66556008)(71200400001)(66946007)(66446008)(66476007)(6916009)(76116006)(4326008)(6506007)(9686003)(53546011)(6512007)(26005)(186003)(67856001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUxCaGRGaURXaWV4YTNoWFloRHU4V3d0LzBhYSsrRWk3UnJGblRKYkFOZWhE?=
 =?utf-8?B?U0xGWUJjSWc3Wjd5bVd1bW1JT2ovamRMYkQvZy9CWUgwMjdzaTBBb3FWeFlO?=
 =?utf-8?B?YVdRRDl4NWxPUGV5WDdxNlAvYjJYRGl6aWp2bnI4RXJMTUcyOGQrSGhZY3Vs?=
 =?utf-8?B?YnY5SG95OXRqdGVlNHRIalBVcXVNT1cvM1FMcTlmU0x0OCt0R0pHOHhidGdS?=
 =?utf-8?B?KzVBSTZTNkJEM2VXZzE3M1Nvc1hlOGZTMTVnb0NsS3ZZaVFPK0RGYkEzK3hl?=
 =?utf-8?B?NWhvcmJOUlBjY3JjWTVzQjEyRlVndlhTd0pCK2pMR2NmaXNtazNWYnBLZGM4?=
 =?utf-8?B?eXVGV2hZWjZCWSt6cVlCaHNQdnpYRGFTcDFTL0hHdDZ4NFlMTk9NTFgwU2FT?=
 =?utf-8?B?UGEyazVpNk51M0swbFcwYVNGeWhoMUEySlE4RzNsVzFHQzNrUHNEK2tNYjZW?=
 =?utf-8?B?SUJWb2tmTmZTZ25NTWo1bHZRaTZnS01ySEZpM0FaN0tPRGpEciszYTlsQ01W?=
 =?utf-8?B?RC8zNDdCRjk5SWpCNGMyQWRxNlptKzdXNzA2Z3A0ZmdDYmV1RzF4ekpWR3l5?=
 =?utf-8?B?L1NPM2FtN2s1V01EcjZaTjRJV3ZqcEMxMnFFYUIycWRaOU9pUVFUYlNnZUdV?=
 =?utf-8?B?NG4vY2dmdDZMUzVpRTVkQjFjNTI0UDVDUzhjc01HZGVQYWNCOVBnYmZKMUgz?=
 =?utf-8?B?ZXdWN1VFbzhoNFVZT1plYmxxTXpUb05XZ1FGWVN0akswZlRUWm9MMy91SytI?=
 =?utf-8?B?czJTb0hBUktkOG9RRHRhWEFEK0NvcUQyTUhTbms3aTArZTJTeGhPT01XYTlO?=
 =?utf-8?B?czhLMUZYNklQVFJHa3ZTV09WSEQzVnoySXlTeSsya3kyOTl0TDhGTTM5Z3ZX?=
 =?utf-8?B?c0RHMTVFSUQ2MHV2TUdlc2gweGE4U0tyWit2Y3hpSXpCblVBUmliM1hwZ1NO?=
 =?utf-8?B?TWc5enF0RktOYnlZcThvNGhXTGFqenNWUzFMU09Kck9WL21uRmZMNUFoaDE0?=
 =?utf-8?B?cUo1QUpLZGhXd3FGUUVkRXZvcFpySmVJS05UUHdtVXRoQUtSMG9xVkdXejBR?=
 =?utf-8?B?dldvTkZyNXM5WDdmL1FobE5XQzN0Rkl3bzdLaWtpL3RlZjZKR1BiYjhjWGdz?=
 =?utf-8?B?aFMxK2szN0lxUUhQd0wzaFhDVkFyYkdyRS85NXBWcFU1aUJ2eWdPd3lSUHhI?=
 =?utf-8?B?UHFZR28xQ3BJUU9ETktmVTBnUWFoZTFieFFobFdEN1JOYlU2dytMeWZicCtW?=
 =?utf-8?B?SWQxaWJlYWJUQjAvS1JFa3FpQkJ4N1AvYUpIcHdNYnF0b2RFR3RCTXlVNmFW?=
 =?utf-8?B?ZTlQbEZ5NWhDOGJQcFJ1N0ZaaVpqeHowRGNHbzFjRDV0eHk1RUJTOGM0aG5V?=
 =?utf-8?B?endpMXc1MXR3T3VkQ3NxcTJaYy9BcGt3ZDF3T0ljTnpOK0thcGZUZFdGb0V2?=
 =?utf-8?B?S3p5RWFqSWhFa243NXFzNE9STURwbzJjN1F1eUVJZ0pZWHRrU3AzSVRWb2lZ?=
 =?utf-8?B?UWJTOThSSERmNTdUU2pmTVd2Nkp6dndWcUNNT1k4S1dSa3RVQStBWjZYQUUy?=
 =?utf-8?B?YVBVamp6OVkvTVI4WUw3RzJ2UWttb3NqNVVRcmFBbUprZGtkWlh5M1cyS0J2?=
 =?utf-8?B?WjlpUzIwa1Z5SG5UQ3dtcTYrcHovR2hwclU3VGMzZ3VLYWd3V09oQXpTTmw3?=
 =?utf-8?B?V1ZzSWV6QlcyaTZWaElNcXJLZllVa2srbUVWeXNCRDVybEtwb0pEQ0NYbGxG?=
 =?utf-8?B?ckVCTUhYWjJxKzRMdUpZV0N5ZVYyN2pwakRWbjhsOHYzRGpxVERqYUY2b2c0?=
 =?utf-8?B?UWlPNGV5clhuOEhnUGprVEY0OENoNHJXM0NSbEQ1Y1FQd3U2cnhRSk04d0tW?=
 =?utf-8?B?aWZRRjhKdzFsVDd2ZzlMbDh2dzJmdXlIbzE0ckNpUGU4WE5FdzZ2amU3SlRN?=
 =?utf-8?B?Zmt6U0w1VTZBYmlIdTdJOHpIWTNxZnJBWjhpb2VvQ25jRlFSV1I1SnBHRnNa?=
 =?utf-8?B?U2FHQjQ0UmVkSmMrVktOSW5Ca1V2QzQwU2hTQ2dadm92R3NnMkdETHRmbHZ2?=
 =?utf-8?B?WGM1cnBlcTdPelNuV3hYbVdTV3pzLzJKY2ppSXozQ2dFaTRXZEl3d3diYzVY?=
 =?utf-8?B?S1d3eXY2MnlSQ1RrU0p3WjJCWFRZSE1kU0Nxb2JqeFJxR3Z1VmJLNy9uUG1a?=
 =?utf-8?B?T3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C98098F6FE0254D9066049BB9372317@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uaGbYBfxNxmS01huX9egM+B17XgvkeUyq42PNNDlBhSGqyb/L2QuwquaLFF+ro3PcDgKzL3KEWNS98mlKWS7OiZ4c26zH65qvKGQkilgEEWJAKSf7Md/Bnd86XtnW/pTlfeC+vDp7GL0q3qloK9lrt1kDi8vWzQNZSZ+hvtsMA5LNTOXFHbBc2R5DGX1nEhYIePKRH8e9018UmjqjC25UQYLAkPM2I7rAfDZ7SN3yF5Jjh7wORHZU02l2qc2XnUB3E2ZLD9Uty6ll0QAQ0AJ84BUu0yysz/vaW0A3415l9oEORzFac8Co36QpYd5Vd1RnE5bNV0bEJFRQ/mRjcHqgbGlGYX8hJx9seoUhSd6nM1oWTxK96wKl9nrPZaHtXKKCo1O+Qw2bNU/XtvpswOV8sRS/RyG34PjwXwMW9vlFCO6yTG0VYnCVGOq5rGoCsnuwMZUntxLt+a4A8izhaaoL4NK6+4cVK4QJhUgahZPulCDUtGvHTfdbbpmD9mp0ZtXhY1k2EqRaAQF7m+le7IlZzRUgpFLmPafyO5RlKzicNFem2pPpOXByleyDb/o8uoaoLjGIzM8hCR1abeWUzMYZ4ZjwEm5icDbE/3CgmtwmDqNuhteJFs2d8r4ega9sIbPV7gYwYc/OHrecXzFla8qN7VwcKZmL2sbX8bH9bgDdI7e31vfLXGyMAVvY74t98Yk2qVHDpAvLjf+e5SI8YVfJpZAknEEiBFgMYg9Sie1iMRcRG0sKF6pKIPLdFovr1KzmaGiNb4jAFEoccQ9ehC2M91w3M9RDOkFVoFqpo5pKhPa7kaOnI0shu5fK2JcIuY+ELnWQH8JlQXxcbAq3DXU6rLLx9y0oV35PmHzximYsbE=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f86b223d-b14f-4ea0-1765-08db6774c4e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 16:32:21.9897 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ym1n032XUHECYKdbs2ucYHLERofPbq9DUEpiXSKcDFLsUoJPb/fF1cL7+1tpMl6rF5S0m+1V4aplLR6J/qXXXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8521
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=515b4f0f9=Niklas.Cassel@wdc.com; helo=esa6.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

T24gV2VkLCBKdW4gMDcsIDIwMjMgYXQgMDY6MDE6MTdQTSArMDIwMCwgTmlrbGFzIENhc3NlbCB3
cm90ZToNCj4gT24gTW9uLCBKdW4gMDUsIDIwMjMgYXQgMDg6MTk6NDNQTSAtMDQwMCwgSm9obiBT
bm93IHdyb3RlOg0KPiA+IE9uIFRodSwgSnVuIDEsIDIwMjMgYXQgOTo0NuKAr0FNIE5pa2xhcyBD
YXNzZWwgPG5rc0BmbGF3ZnVsLm9yZz4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gRnJvbTogTmlrbGFz
IENhc3NlbCA8bmlrbGFzLmNhc3NlbEB3ZGMuY29tPg0KPiA+ID4NCj4gPiA+IEZvciBOQ1EsIFB4
Q0kgaXMgY2xlYXJlZCBvbiBjb21tYW5kIHF1ZXVlZCBzdWNjZXNzZnVsbHkuDQo+ID4gPiBGb3Ig
bm9uLU5DUSwgUHhDSSBpcyBjbGVhcmVkIG9uIGNvbW1hbmQgY29tcGxldGVkIHN1Y2Nlc3NmdWxs
eS4NCj4gPiA+IFN1Y2Nlc3NmdWxseSBtZWFucyBFUlJfU1RBVCwgQlVTWSBhbmQgRFJRIGFyZSBh
bGwgY2xlYXJlZC4NCj4gPiA+DQo+ID4gPiBBIGNvbW1hbmQgdGhhdCBoYXMgRVJSX1NUQVQgc2V0
LCBkb2VzIG5vdCBnZXQgdG8gY2xlYXIgUHhDSS4NCj4gPiA+IFNlZSBBSENJIDEuMy4xLCBzZWN0
aW9uIDUuMy44LCBzdGF0ZXMgUmVnRklTOkVudHJ5IGFuZCBSZWdGSVM6Q2xlYXJDSSwNCj4gPiA+
IGFuZCA1LjMuMTYuNSBFUlI6RmF0YWxUYXNrZmlsZS4NCj4gPiA+DQo+ID4gPiBJbiB0aGUgY2Fz
ZSBvZiBub24tTkNRIGNvbW1hbmRzLCBub3QgY2xlYXJpbmcgUHhDSSBpcyBuZWVkZWQgaW4gb3Jk
ZXINCj4gPiA+IGZvciBob3N0IHNvZnR3YXJlIHRvIGJlIGFibGUgdG8gc2VlIHdoaWNoIGNvbW1h
bmQgc2xvdCB0aGF0IGZhaWxlZC4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBOaWtsYXMg
Q2Fzc2VsIDxuaWtsYXMuY2Fzc2VsQHdkYy5jb20+DQo+ID4gDQo+ID4gVGhpcyBwYXRjaCBjYXVz
ZXMgdGhlIGFoY2kgdGVzdCBzdWl0ZSB0byBoYW5nLiBZb3UgbWlnaHQganVzdCBuZWVkIHRvDQo+
ID4gdXBkYXRlIHRoZSBBSENJIHRlc3Qgc3VpdGUuDQo+ID4gDQo+ID4gIm1ha2UgY2hlY2siIHdp
bGwgaGFuZyBvbiB0aGUgYWhjaS10ZXN0IGFzIG9mIHRoaXMgcGF0Y2guDQo+IA0KPiBBcmdoIDop
DQo+IA0KPiBJcyB0aGVyZSBhbnkgc2ltcGxlIHdheSB0byBydW4gb25seSB0aGUgYWhjaSB0ZXN0
IHN1aXRlPw0KDQpUbyBhbnN3ZXIgbXkgb3duIHF1ZXN0aW9uOg0KUVRFU1RfUUVNVV9CSU5BUlk9
Li9idWlsZC9xZW11LXN5c3RlbS14ODZfNjQgUVRFU1RfUUVNVV9JTUc9Li9idWlsZC9xZW11LWlt
ZyBndGVzdGVyIC1rIC0tdmVyYm9zZSAtbT1xdWljayBidWlsZC90ZXN0cy9xdGVzdC9haGNpLXRl
c3QgLW8gdGVzdF9sb2cueG1sDQoNCg0KS2luZCByZWdhcmRzLA0KTmlrbGFz

