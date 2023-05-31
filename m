Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FB0718969
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 20:32:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Qc0-0003wJ-7t; Wed, 31 May 2023 14:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1q4Qbx-0003tS-NV
 for qemu-devel@nongnu.org; Wed, 31 May 2023 14:31:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1q4Qbv-0001Br-Jj
 for qemu-devel@nongnu.org; Wed, 31 May 2023 14:31:53 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34VBxHHT017273; Wed, 31 May 2023 18:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=XNcMzBKvbS1aPmNaAV2Jiisy2x7EKOJirKXbuOyY44c=;
 b=LJgt1OvWMW1xvJ1qGPGEugIvdGP8ym8ag5/eeTYXBWJPsVdtTgjzoRlRxMC4mSCgLGWF
 tmACyyaMdNFS2So13cEbygzuXjWYTSM0efhPwMVv44DrdMy+ur81w/fr0UY/G5UBmGJM
 u27IR7LoRqHM9UTt90RD7w1ariAQSfK4Eb9Y+quzJrKVRyBimATPeVlfyj2oiKjzbRGk
 0HBch/rpO3v071JSVeAwBhrDgiQwKDiquyfOWDJ/LNSQATXjYs0gD47jC2aLpx3n+wGs
 mFefmjf7yHoHkMDtsvvkgMqLsHKrGanmkHlv5AxvxwOrRS8q5H9mo0oEDXxlR3YGLBDA ng== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qx1yk1gma-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 May 2023 18:31:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENTS10Z1r94ePeis/OARmMQduaXvGyXjd3VYnJ2ZGOwzI7/E4i9XGwjXONlku84ybjiHbSBloNm+tQL7FWkUSjRLUh//a1xhIJ/RtE+jJFXILgsf4BkB7btCImDkDEdhHij8dphmUSBavVJ+L4mOU61bK7VZ/kSN/db22RA9Rgs568oilD0or2uneyMfcuWLSaiWw/B6FWERYHF5DJEg15hnkf3uRPcIsngVGYIKSfsFRtm1N4Vewmddi+mFwgV1laJXFTzhe+7mQuNu3DUWbRfSi+7nH8YpegV+gOS1Y4gWQ+9X9gjTYLAkdwYNmrSInDqvj/MXssFaS3FmTBMSiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNcMzBKvbS1aPmNaAV2Jiisy2x7EKOJirKXbuOyY44c=;
 b=H+BTFdwzh9RnWAjieoaLb/+zLzrEFrctAakYSlRQNmZAUHfH8Sjg69KyBYdzc9IXxTYRrckHQeHksZv594LRoIATpDp5Pas2rz5EfTinuwYzq6Fx/323aNre0fWRF84uEXaDKYuL82AC0HfGSBzSGve2sjAdSU5G9AfSx2oGOSanFr7YqA+k6Kak+WyEHNULSD5Tlygkf2iLRRgysTJA1cKqBhzm+2cT+K0O4Y/tn6eEU10leEgn+fS/eBfuJIil5zMx/oFfqBdWvy82RjPDNvTqUdR2LRlQ+7AyuYTifURPOz8gMSnDF+Z8kxYuCOmQ9gO+mOMDuNgW/QQttOVhlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4205.namprd02.prod.outlook.com (2603:10b6:805:35::17)
 by DM6PR02MB6762.namprd02.prod.outlook.com (2603:10b6:5:212::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 18:31:34 +0000
Received: from SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::948c:d843:8389:cfeb]) by SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::948c:d843:8389:cfeb%4]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 18:31:34 +0000
From: Brian Cain <bcain@quicinc.com>
To: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 =?utf-8?B?RGFuaWVsIFAuQmVycmFuZ8Op?= <berrange@redhat.com>
CC: qemu-devel <qemu-devel@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>, Erik
 Skultety <eskultet@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 "Matheus Bernardino (QUIC)" <quic_mathbern@quicinc.com>, "Marco Liebel
 (QUIC)" <quic_mliebel@quicinc.com>
Subject: RE: How do you represent a host gcc and a cross gcc in lcitool?
Thread-Topic: How do you represent a host gcc and a cross gcc in lcitool?
Thread-Index: AQHZk7RXiRg4rDIxy0mHNHW+RtrYo690s91Q
Date: Wed, 31 May 2023 18:31:33 +0000
Message-ID: <SN6PR02MB4205D202EFB6D6A256ECB93FB8489@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <87wn0obuk6.fsf@linaro.org>
In-Reply-To: <87wn0obuk6.fsf@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4205:EE_|DM6PR02MB6762:EE_
x-ms-office365-filtering-correlation-id: 76cd7ed5-0637-4f59-dd61-08db620542df
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0IJs/V8a3r844zaopHfSJTlm2NJ1ghNrUMdss4pM233Wdu8jksrrLNuOQiNk1Yrs2EnKrV8huUkjiI7lHL15wg+Jl2usj2tqiKz0QfR61JcOLjomLrMhTClI2eCscf8xPji1hUnmhbTM3wJmzaY5fbwiJX+zn3nbZgTYmMcM9C/vS6a6H8yEkGTIWR3OvfTdf4/E2DZO6e8LaGrv0qlRgYozlfk0cXRdkeE0zt6/z3bggzO88kwTxryGNM/OHPbbjGlOAEZjaCU2emkLsklsGm748Tqj7q5MMvdALwG5nMuf/oL14Wthp0ZbD7l8x+hgH0w8iaRwkYfwx455msNe+Rmksamr0O2ziw6QzCcpy3jJwYsFIVnszn4ieRO+YazG6KDuUwD7zhCdhyQba8rW7KjDq6rTEK6s5+7JMHi2RZriDzVB9aiFG5aHLcadu+b/AFk72qfl7y0oJmcysfqUp4I0b6qEe5bCp0rGBdLygNPqIfvdqM0mCansxpN0zND4paLDwy7weFRNXQDDBJ7N3QJmvcFlY0MeBjelcd2shN94oTe5OicXWgFCsA4JHUcldjeDdgWnQtB6jCZv8+lcVpO9oFoH8SPkuL5yKSDGgwc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR02MB4205.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199021)(966005)(186003)(107886003)(41300700001)(38100700002)(83380400001)(53546011)(9686003)(6506007)(26005)(66574015)(7696005)(110136005)(478600001)(54906003)(71200400001)(66946007)(66556008)(66446008)(76116006)(64756008)(122000001)(55016003)(66476007)(316002)(5660300002)(2906002)(52536014)(8676002)(8936002)(38070700005)(33656002)(4326008)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkZwZllOVHUrb2ZSeStoT3g4WTVURXBSb2RUbDNiYXduTDFiV2hFeXRDWi9k?=
 =?utf-8?B?REdxblBMRVRCOXA1OGF2SnhhdlVyeXc0VHFRODlydW9vclg2NnVoakxyYVRh?=
 =?utf-8?B?MVUwSzFrU1U3MnllemhSa1k5WCsrcUFubEt3bXlCRWxzZGt4dUxLNXF6YTFB?=
 =?utf-8?B?TEZPOUg0aXZRWUFQTjNVQjRLUXVpRTJwNFlqRU8wVEdyenZVUFp3dHZYUTJV?=
 =?utf-8?B?TEZTWGd6VEJxSFJyR1JXQ2I4anFSaXVZRXhVM0lXRTFCV01ZYUxvVlJWSHdX?=
 =?utf-8?B?eS9lMDVqbVlEN2Y4MnFtc1BuRVQ1ckNMc2JkQTlzN0lIYVFGNVVyb2xBcjF6?=
 =?utf-8?B?TVNQRDA3OHpvT0VvTkJhbmppRVh1Uld2d0pRZlFLV2pBUUlnTkpZTXBUUDNM?=
 =?utf-8?B?QzZEUVpYdVJRZnZxcVg5elkzRzh4YSt3RmJqWTlOd25hVExKclhXSU0vVm1E?=
 =?utf-8?B?eXVwT0xsZjdzeHNJQzR0Wk40R3JsWTJHWjdkaHRlblJ4ZDF5MkpWeTRYVTAy?=
 =?utf-8?B?TW96bGVWaW9ETmVXSlVFZTVnbDNhcjc5bWYyVmlyN3lKRTBINy9jUFBzZlMr?=
 =?utf-8?B?d3J0Tk4yMFIyc25TMEpLOEJnSXllY2xRSjUrTXdSUGNxbUpqeko5ajVOeG04?=
 =?utf-8?B?N2hWMytSL2ZWaFpCV1BuZGt2ckl0SmNXR1BCbFk3bkQ4QkhvbS8za1o5OGt1?=
 =?utf-8?B?cXVDRlNrbDVwNHEyQmt2TkQrbmVqeWJ1REJZUW8vOWtraHp5ZXUvcCtBbkRI?=
 =?utf-8?B?MVo4VW5SbkRuRElxM0hGdkRzMXVteGJzM2k1UUp3QWhsZ2IrZXZWR2ZaRjBT?=
 =?utf-8?B?Q1BsQTVOZFhTOVZPVStadDhZV2RacHlRZTFFUEE5MUpyZDVlL1RIeTJ3d05k?=
 =?utf-8?B?R0grQW5kaG5WOEtlb3N3SjczVDA0TDdSZEI0ZmxTSUZsZTJyWHZJRDZLVEt4?=
 =?utf-8?B?UXAwNk9YQmt3Rzc2bTF4MGQyczJTK0pTNHdmeWs5U2krUDZteGhRWm5KbmMv?=
 =?utf-8?B?Q3dhVzdiYjZ2RHdLb0hXZzNyOEhhUWJBUklZRWl0cHBWRnRRNld0a3o1UVMx?=
 =?utf-8?B?WVlKNnlyVU1DdFk5SDR5dzh1djk3aXFWVDc3MDNaQWNSUENINHFZd1o1ZjRD?=
 =?utf-8?B?a1JWazZkMHZ5ZngrY0ErcElZaVU2WUV2MktCMitmR0ZqQ2UwTlZBVVVoRzFm?=
 =?utf-8?B?V2RvTkFGQlkvSjBFd3YvK0oxQ09obEs1VzM0d1pYcVhScG8yT01RMTBzN3pU?=
 =?utf-8?B?MFhKeE5ESEN3MzRkQm1uQytEem1HOGc2YlZXVVc4NWovS1FuVHFBaHVsbGlk?=
 =?utf-8?B?QVg5Ui9DMlFKNGJPWWdEaDRlMkwvWm5zTkFVTlFoaklJcUVLc2Q1aExzelpv?=
 =?utf-8?B?YjhZWUo4VWo3S25HMERZVjRXaFliQnVWMDhWSVdiNlhnSjNMaW9JYTRZQU8x?=
 =?utf-8?B?TTdLbVlPQ2UwMTZVSWRSZFdUQjA1OHVsMjlzS1ZYSG5qVWhWSXhkY2ZOdkdt?=
 =?utf-8?B?NnVRTWdyak5hUWV4VkNDY3pzVmxCNnJ6bFhIYjZNY0xvaGNUN0dBT2JURzRi?=
 =?utf-8?B?V1g0T2xGbTNCZTJndnpNOWl0TERaYUphOGlnZlZYTlBSaHFSYlpSV1IwOGNi?=
 =?utf-8?B?cElqRTVpNWEzaDMvaXdibGhsZVJrVWRLTTlmbDZGRFNZN3FDcmZSK2RZdHpT?=
 =?utf-8?B?dUlZTkNVdnQrTzdrRkl5OUEvTGgzdlNVWURhU21OMU52Yi9QVFh6aHovcFpZ?=
 =?utf-8?B?Y2tic01DOExnZW5WNWdyK2h0Tm9TMmhaSUQ1MU5vd2xZUEw2WlFyS2YwczdM?=
 =?utf-8?B?YjhzZnoyQXhGZ1A1R2ljYVlUMlBYUEpkS092NUtlemtkVmF0S3JGcENkUlB4?=
 =?utf-8?B?YXlPckpNOEs4cyt5dVF2VTlWbHplU2dFQUgxRTZrS09BZjhGRXg2NU1TTWN2?=
 =?utf-8?B?L1B6MUh5ZzAvdmg5ekFqOVBBdGhWRCtSbTlZNThRaFp0WUhOYkk0OXlBazNV?=
 =?utf-8?B?cm5EaWowcTM2dC83cFAxUDk4YVFmbTc3YjVJeGI2TkE2VnlrREl5ZktCV2U5?=
 =?utf-8?B?UDNiRk9FRTl5b3Y5ZHh6aStxOWU1WjZZT2ZxbHJXdlBMSklOaUlBRlVtTTdl?=
 =?utf-8?Q?GkvZQbNkR9Y+tEs7MfDtfeNnB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eEppeFBmMDYwbExySXgxSzBjZ0RDMG50YUkrTzI1RXNic1REL3d6dFFFMnd1?=
 =?utf-8?B?SnlLMkJIR0d6WUJSeDhMWUpMeFozdXV6dHd1UnMrN1QvMUNORU0wV2orQVAx?=
 =?utf-8?B?YVRFS0RNTTFQT0pLQzhPU2JEQlVSb1RTeGVrZHAxZ3pBYWxBZkpoRHdCYjNk?=
 =?utf-8?B?UWNaYnZFczRQSzc2UEUrTnpCblF0YS9qRjNvMjJsUm5ST0FETmFDVGZkd1pZ?=
 =?utf-8?B?MXYwRUZNenpEN1hJZ0g2MkcwdjVrODlaTFVKWjRTbzdkZ1Fudzhpb2FqQWlu?=
 =?utf-8?B?aXYyU1FJK21URjVhd3RZT1pNWldQTDU4MllLTExDNFVhSW8zWHlnM0kzSUth?=
 =?utf-8?B?SVRhNHk5V0NjVXNCckNXM0pWTnRzMHp5ZjlvRTRqS2c2c3IyRGtqZGN5a1cr?=
 =?utf-8?B?N05WY1lBeEVHTHhkSTlhdFcwVTJGa2F3QWlvanJsYVFjQXk5Wk9kUE5Ba3ho?=
 =?utf-8?B?dWF2UHhyTVJWNHJRUytFY3NqcWUxWUYrdEQrOXlvU0ZGcm1Sa1hSQUh1WkVt?=
 =?utf-8?B?SHRWVzRyZUlvdDh4R1JBQTNrV0YrN2Zub2NSUFlCNUVYK0dQS0VqaUlBejgx?=
 =?utf-8?B?VVdHZE41a1pYdzFjamNVcDRXMWNoUEdoU2I0S3BoUlN3WjA1WCs1YzU2ZG5h?=
 =?utf-8?B?d1pUNXlaeHRGdEd6WEhmOExQYlkvWGtOSE9Jdi9MaTcrVG1NMEc0MExtOHJS?=
 =?utf-8?B?Z01QMEliNEpOZ1NBSFpJbnpSN3E2K092OUVWWnhyRFZHSTBTVmVieE1neWM0?=
 =?utf-8?B?Ulo1V2hUbXMzWjNDNWh3RFBEUWNzRlYxdXVOVmd1YjV5WW1xb2t6UWk5cXd4?=
 =?utf-8?B?ZGNCamVzWThkaTBOdXFLMUc5c25mTSt5V3NrQ3RIL1lwMjR1OHZ5cUFja2Zq?=
 =?utf-8?B?b2VJbGFtcUJ1a2VQck1pdEMrYmpHSGxWZ0pOQ3FLek5BS3JlWms0aEFVb0hs?=
 =?utf-8?B?bWwyOWFuQnJ4SDdvVU5ialVQTUFnYVpWMW5yMXd4NGF1b1MzVGE3M3BXUStZ?=
 =?utf-8?B?R21xcmxxdk1JN1RIRVdUTjdZZXNZUkdNR0VFRzdQSEpRUFBjQzZYek5VSEgw?=
 =?utf-8?B?RWVNRHhpSFRKcDRCb1FJWHVoVytRd3l3aFlLbE5OaC9JWkdLVGtjMHVwblpn?=
 =?utf-8?B?ZGJEcy9WNy94dXhMbmN6VGRyTFB4V1pDZXRRK2pFaHZseHBXUXRWbHlPSlhN?=
 =?utf-8?B?N3dqa3hheWVkbWI2QXFBbkVjaHNXU2Rvamtra09ZMWFXVkRSbTd5RDFZZ0Ny?=
 =?utf-8?Q?vpXt45ZuVclJ5Lw?=
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4205.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76cd7ed5-0637-4f59-dd61-08db620542df
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 18:31:33.9334 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iBA5OYSBdLLpYHtSOZ/Pnrlz2vakvxQhyjoIYktcfkmVToaMDiAQfVorWmo/mhX6ALCbl5ZFsZLLwp4N6WAaMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6762
X-Proofpoint-ORIG-GUID: tbJhWLef-_tdSr1kxKulqIadG-Zswb4K
X-Proofpoint-GUID: tbJhWLef-_tdSr1kxKulqIadG-Zswb4K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_13,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305310156
Received-SPF: pass client-ip=205.220.168.131; envelope-from=bcain@quicinc.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleCBCZW5uw6llIDxh
bGV4LmJlbm5lZUBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIE1heSAzMSwgMjAyMyA2
OjI0IEFNDQo+IFRvOiBEYW5pZWwgUC5CZXJyYW5nw6kgPGJlcnJhbmdlQHJlZGhhdC5jb20+DQo+
IENjOiBxZW11LWRldmVsIDxxZW11LWRldmVsQG5vbmdudS5vcmc+OyBNaWNoYWVsIFRva2FyZXYN
Cj4gPG1qdEB0bHMubXNrLnJ1PjsgRXJpayBTa3VsdGV0eSA8ZXNrdWx0ZXRAcmVkaGF0LmNvbT47
IEJyaWFuIENhaW4NCj4gPGJjYWluQHF1aWNpbmMuY29tPjsgUGFsbWVyIERhYmJlbHQgPHBhbG1l
ckBkYWJiZWx0LmNvbT47IEFsaXN0YWlyIEZyYW5jaXMNCj4gPGFsaXN0YWlyLmZyYW5jaXNAd2Rj
LmNvbT47IEJpbiBNZW5nIDxiaW4ubWVuZ0B3aW5kcml2ZXIuY29tPg0KPiBTdWJqZWN0OiBIb3cg
ZG8geW91IHJlcHJlc2VudCBhIGhvc3QgZ2NjIGFuZCBhIGNyb3NzIGdjYyBpbiBsY2l0b29sPw0K
PiANCj4gV0FSTklORzogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiBRdWFs
Y29tbS4gUGxlYXNlIGJlIHdhcnkgb2YNCj4gYW55IGxpbmtzIG9yIGF0dGFjaG1lbnRzLCBhbmQg
ZG8gbm90IGVuYWJsZSBtYWNyb3MuDQo+IA0KPiBIaSwNCj4gDQo+IFdoaWxlIHRyeWluZyB0byBj
b252ZXJ0IHRoZSBkZWJpYW4tcmlzY3Y2NC1jcm9zcyBkb2NrZXIgY29udGFpbmVyIHRvIGFuDQo+
IGxjaXRvb2wgYmFzZWQgb25lIEkgcmFuIGludG8gYSBwcm9ibGVtIGJ1aWxkaW5nIFFFTVUuIFRo
ZSBjb25maWd1cmUgc3RlcA0KPiBmYWlscyBiZWNhdXNlIGRlc3BpdGUgY3Jvc3MgY29tcGlsaW5n
IHdlIHN0aWxsIG5lZWQgYSBob3N0IGNvbXBpbGVyIHRvDQo+IGJ1aWxkIHRoZSBoZXhhZ29uIGNv
ZGVnZW4gdG9vbGluZy4NCg0KSSB0aG91Z2h0IHdlJ2QgZml4ZWQgdGhpcyBjb250YWluZXIgZGVm
aW5pdGlvbiBzbyB0aGF0IHdlIG9ubHkgZG93bmxvYWRlZCB0aGUgaGV4YWdvbiB0b29sY2hhaW4g
aW5zdGVhZD8gIERvIHdlIHJlYWxseSBuZWVkIGEgaG9zdCBjb21waWxlciBmb3IgdGhhdCBjb250
YWluZXIgYnVpbGQ/DQoNCk9yIGFtIEkgbWlzdW5kZXJzdGFuZGluZyBhbmQgeW91J3JlIHJlZmVy
cmluZyB0byBmZWF0dXJlcyByZXF1aXJlZCB0byBzdXBwb3J0IGlkZWYgcGFyc2VyPyAgRG9lcyAi
aGV4YWdvbiBjb2RlZ2VuIiByZWZlciB0byBoZXhhZ29uJ3MgVENHIGdlbmVyYXRpb24gb3IgaGV4
YWdvbiBjb2RlIGl0c2VsZiAocmVxdWlyZWQgYnkgdGVzdHMvdGNnKT8NCg0KPiBBZnRlciBzY3Jh
dGNoaW5nIG15IGhlYWQgZm9yIGEgd2hpbGUgSSBkaXNjb3ZlcmVkIHdlIGRpZCBoYXZlIGhvc3Qg
R0NDJ3MNCj4gaW4gb3VyIGNyb3NzIGltYWdlcyBkZXNwaXRlIHRoZXJlIGJlaW5nIG5vIGV4cGxp
Y2l0IHJlcXVlc3QgZm9yIHRoZW0gaW4NCj4gdGhlIGRvY2tlciBkZXNjcmlwdGlvbi4gSXQgdHVy
bmVkIG91dCB0aGF0IHRoZSBnY292ciByZXF1aXJlbWVudCBwdWxsZWQNCj4gaW4gbGNvdiB3aGlj
aCBpdHNlbGYgaGFkIGEgZGVwZW5kZW5jeSBvbiBnY2MuIEhvd2V2ZXIgdGhpcyBpcyBhIGJ1ZzoN
Cj4gDQo+ICAgaHR0cHM6Ly9idWdzLmRlYmlhbi5vcmcvY2dpLWJpbi9idWdyZXBvcnQuY2dpP2J1
Zz05ODc4MTgNCj4gDQo+IHdoaWNoIGhhcyBiZWVuIGZpeGVkIGluIGJvb2t3b3JtIChhbmQgb2Yg
Y291cnNlIHNpZCB3aGljaCBpcyB0aGUgb25seQ0KPiB3YXkgd2UgY2FuIGdldCBhIHJpc2N2NjQg
YnVpbGQgb2YgUUVNVSBhdCB0aGUgbW9tZW50KS4gSGVuY2UgbXkgaGFja3kNCj4gYXR0ZW1wdHMg
dG8gZ2V0IGdjYyB2aWEgc2lkZSBlZmZlY3Qgb2YgYW5vdGhlciBwYWNrYWdlIGZhaWxlZC4NCj4g
DQo+IEhlbmNlIHRoZSBxdWVzdGlvbiBpbiAkU1VCSkVDVC4gSSB0cmllZCB0byBhZGQgYSBtYXBw
aW5nIHRvIGxjaXRvb2wgZm9yDQo+IGEgcHNldWRvIGhvc3RnY2MgcGFja2FnZToNCj4gDQo+ICsg
IGhvc3RnY2M6DQo+ICsgICAgZGVmYXVsdDogZ2NjDQo+ICsgICAgcGtnOg0KPiArICAgIE1hY09T
Og0KPiArICAgIGNyb3NzLXBvbGljeS1kZWZhdWx0OiBza2lwDQo+IA0KPiBob3dldmVyIHRoaXMg
ZGlkbid0IHdvcmsuIERvIHdlIG5lZWQgYSBuZXcgbWVjaGFuaXNtIGZvciB0aGlzIG9yIGFtIEkN
Cj4gbWlzc2luZyBhIHdheSB0byBkbyB0aGlzPw0KPiANCj4gUmlzY1YgZ3V5cywNCj4gDQo+IEl0
J3MgY2xlYXIgdGhhdCByZWx5aW5nIG9uIERlYmlhbiBTaWQgZm9yIHRoZSBRRU1VIGNyb3NzIGJ1
aWxkIGZvciBSaXNjVg0KPiBpcyBwcmV0dHkgZmxha2V5LiBBcmUgeW91IGd1eXMgYXdhcmUgb2Yg
YW55IG90aGVyIGRpc3Ryb3MgdGhhdCBiZXR0ZXINCj4gc3VwcG9ydCBjcm9zcyBjb21waWxpbmcg
dG8gYSByaXNjdjY0IHRhcmdldCBvciBpcyBEZWJpYW4gc3RpbGwgdGhlIGJlc3QNCj4gYmV0PyBD
b3VsZCB5b3UgYmUgcGVyc3VhZGVkIHRvIGJ1aWxkIGEgYmluYXJ5IGRvY2tlciBpbWFnZSB3aXRo
IHRoZQ0KPiBjcm9zcyBjb21waWxlcnMgYW5kIGxpYnJhcmllcyByZXF1aXJlZCBmb3IgYSBkZWNl
bnQgY3Jvc3MgYnVpbGQgYXMgYW4NCj4gYWx0ZXJuYXRpdmU/DQo+IA0KPiBUaGFua3MsDQo+IA0K
PiAtLQ0KPiBBbGV4IEJlbm7DqWUNCj4gVmlydHVhbGlzYXRpb24gVGVjaCBMZWFkIEAgTGluYXJv
DQo=

