Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB797BEC08
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 22:54:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpxFx-0007Am-L5; Mon, 09 Oct 2023 16:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1qpxFv-0007AQ-04
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 16:53:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1qpxFs-0001eJ-JQ
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 16:53:34 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 399Kqc3w022046; Mon, 9 Oct 2023 20:53:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=l9k8UfGob7twLhpVR49IuuCXqUZlW3j0q/kEf53Zf0Y=;
 b=fduWJL+3pOS1Dy5p321FckuyfoRkEwLj1M0yXNDjs8xLNTtjD8gFFzZus2lZkxLT8Xfq
 wcRGol+gOLu4lB1fdJ/gPSZpvhQR7Y+lxpXTfUs6/Wxjdh1YMas9QQiioiHZwJ8hr87S
 WLuOh9GBx1mG5voTPeWxV9PU/wtSAh2Tx/tndmHYNePD0ej4oRnRMWhw9CQBRqHlOLp5
 vi8bww/eDMa28uuQY6Mv4LBxrgT79s/2rvaGhUxRd5wm7PzDYfJBB6QlaUjHl1ou3dWk
 /M/t6+bNklsTXYCaY548uUDb6WVMZGXIZr1e6QA0W+hfpbBT1Sj9sKVt8rJYR4o5NINy LQ== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tmj0d8ysc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Oct 2023 20:53:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YS1SxVoa47WWL5G07QlncNuMDJusT9pSTKFRsy+oAv/afFasjHBQ57r3Zzq3qAfrFLGK1tmWwvVjspqbrrTvoauYHHjy8Z2jlefQpQYYDtXtHxRwChS5gNV2AefN03GAN/kID4HFVINO5UZjHTn2Nc1teoLNuYiRAoEaUHv2zTxIYyOrxkKU/U+8UHM8TDzTS+g55kDNYNtrGuBKy6VjQ7L8f1QHb6XHnhfsbfTkCVGW4rVEd8eyumg6SuC25SHsaWjuHsGLCqHgcVCzdbDCLKHhSals/KG0CEkPcOz+x0xJqUHQhEOoeboBBvhAPTceJjyrPkV/+nd0l9Wwa9Wk5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9k8UfGob7twLhpVR49IuuCXqUZlW3j0q/kEf53Zf0Y=;
 b=BXhlGUS55Jtg7zFD9sM2qA2qUM+V3y0x5QEmC5Ja/V077+HofCc/T9FEDJcn2/FN7jeIUJ9rzScUSYaXPbBve9OekdIhfP+Wm517oA+8Igtq9/VJ+wcAMvSlclsX8MMumF+rWnDRKaMdMrVdB+2Wp1aAyRa+uksnmjoQGCJL/d02oVeFcRo4JW4heswuR1fisYf/r9cisGU0TW3rDdCUwUkrVxb9QHfxrcOb8qgdNWhRGRNMvi1n/nglljYtFVT6F6b41QWfPkjiaScv98wminQquiM4+V+5Ug/rpRCXN7mhGXSwQT4LHVCJIRf8wq032pALsN47y0oQuOcS4CnWhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from BN7PR02MB4194.namprd02.prod.outlook.com (2603:10b6:406:f8::18)
 by MW4PR02MB7107.namprd02.prod.outlook.com (2603:10b6:303:74::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 20:53:16 +0000
Received: from BN7PR02MB4194.namprd02.prod.outlook.com
 ([fe80::176:190d:2e2b:4f33]) by BN7PR02MB4194.namprd02.prod.outlook.com
 ([fe80::176:190d:2e2b:4f33%7]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 20:53:15 +0000
From: Brian Cain <bcain@quicinc.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "armbru@redhat.com" <armbru@redhat.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "Matheus Bernardino (QUIC)"
 <quic_mathbern@quicinc.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "ale@rev.ng" <ale@rev.ng>,
 "anjo@rev.ng" <anjo@rev.ng>, "Marco Liebel (QUIC)"
 <quic_mliebel@quicinc.com>, "ltaylorsimpson@gmail.com"
 <ltaylorsimpson@gmail.com>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Subject: RE: [PATCH v2 3/3] target/hexagon: avoid shadowing globals
Thread-Topic: [PATCH v2 3/3] target/hexagon: avoid shadowing globals
Thread-Index: AQHZ99p0kpQSem9BGEaufyVyuucJMrBA/p0AgAAJZICAAOsEIA==
Date: Mon, 9 Oct 2023 20:53:15 +0000
Message-ID: <BN7PR02MB4194900078A1AA6E067FE20FB8CEA@BN7PR02MB4194.namprd02.prod.outlook.com>
References: <20231005222206.2784853-1-bcain@quicinc.com>
 <20231005222206.2784853-4-bcain@quicinc.com>
 <48c5233c-c294-f50d-a438-f7f6a63c113b@linaro.org>
 <187100e7-a516-4024-1739-a08c630d76f3@linaro.org>
In-Reply-To: <187100e7-a516-4024-1739-a08c630d76f3@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4194:EE_|MW4PR02MB7107:EE_
x-ms-office365-filtering-correlation-id: 0b6854a7-9d61-4f56-ca17-08dbc909c25d
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MyWoEMzEtAzg/HUrypIcvJWg3tjUsADsErCSJMdx6E259tLIgohJY2sDxdXF46g6cRYTfLQpz2SC6fpWh544QXDPLAAtaF8NNZz5EFuxrB9C2LfFzByd8ByNH8TX2YB12i/97B4Hefaa1DMb8QftScIlh+k2uF5ufQ8o/kvtzDvB1/wUBBmS6NRH3gPkHCt0tt3wj5hopu7ggkdxcmYwwpVTSkmBZ2u4Y+UnEXMXYFLLwBbLUoCl1MblJ3xmI0V80KIeL3Oum77rXucXFTqTJzVCGO94OeCF9Sa1AqtqGyaeD5He4+tIMi9dKxdkjFjWXdTsLBOY4Tukdx6yv0ukr+aJtfQCc+OvWLGTe/gK92MollgMzDKBijlVbQr2uy3dtVGRfxE73dOrFIjuwNyLqz2a+1pc9IkoETpbTqeMwOgseQLACKJPLZFJs+ONnQZYG2f4TuMb7E9OEZOdcyQgiENS1PNwOEiR1J7IwuRyNnsZ+H5ZLRS/JQJc7ql2blcRadloBuGHjJW1yGlqllRONs2crK6Ia356eKApcMedZA++ix7XQ06aHrfHS1B8nv6jQKdPHek3ApRxqJ8G2V041lcad1TtPVhQcau52ufutOs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR02MB4194.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(376002)(396003)(366004)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(55016003)(6506007)(53546011)(7696005)(9686003)(41300700001)(316002)(478600001)(71200400001)(83380400001)(966005)(2906002)(7416002)(66476007)(66556008)(110136005)(5660300002)(66446008)(64756008)(66946007)(54906003)(76116006)(8936002)(4326008)(8676002)(52536014)(26005)(38100700002)(38070700005)(33656002)(122000001)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OC9sbTU1bzZFMXRpeEZqdVlPek9uU1lUMVZ6MlBaeXUyWnI2NUozNXYrUWUv?=
 =?utf-8?B?ODZiUENEZkQ3SXpXYStSeHo1c3l3aFdHYWZoRTh2bjJzcHpSVkdrL3Q3bWJY?=
 =?utf-8?B?R1U3aUUvNnVJYzJ5Y3Fya2t1ZG9xeHRmd3JnMHdxVFJOcHJCTVJKcWRVUVpo?=
 =?utf-8?B?UkxzNlI0V0ZBSkZrTTlReHFPMkFqSUdFSFQ3SDRQM0FDRFBmLy8xaWJlMXls?=
 =?utf-8?B?L3p2V1FWZ28vQWVLdmpaQlQ3VXd5N0krMlFvOHVVOU4rYThva2RTR3ByMlp2?=
 =?utf-8?B?UGtQQXI3Tis5Y212ajJmUG1nTndzdlFYSEJiaGYreTFDNTBUR1FYWGZDa1hU?=
 =?utf-8?B?cG9DaXpyK2FaQjU2RUFrYVR1VUo0VFJXRHZONkNxWmt5UXVSOXJPNGFZcHR2?=
 =?utf-8?B?OTFvb254bldadWNUU0w1d210ZmJrYlB3SmpqWDhqYmc3OUE1NWlFaytuUDBj?=
 =?utf-8?B?SmtPWGh0cEhXQk0rREtXRkxMQ3JScW5tOHo3RitXbW9Xa255L0krNmY1dFZ5?=
 =?utf-8?B?TjlxREx3c1NFdHEzcjAvTSs0RkIzWk9EUTNnMTRGSGxJb1JSekRSQW81bS90?=
 =?utf-8?B?bXQ0K3Vrc0h6eHRjN0NacGs3TEk1VUVqbXdVODl6S1RiTmpSTU5oSXBQYTgr?=
 =?utf-8?B?YTIzNmVCdlpmdUxSa3hxc1RuVEJxT2FoU1Z1MG1FMWYwMmR4cW93STBoaXAy?=
 =?utf-8?B?RVVEYzBVbE5FVkRTeUt2UVVBcmRoV3Q0VzFDaXpMRys0a3YwSlhFWTA5SHJ2?=
 =?utf-8?B?Tk9QN3FiaTRadlNOcWR3Nk53WW1jQysycy9aUndPbjFxM3J1MEpQVEs4UjBE?=
 =?utf-8?B?MUtuZU5KZnRvd3dZYTkwVTJScFRIWVpWYm1sUVpSV0JzN1pTNi9ucFVSQkRX?=
 =?utf-8?B?NW1SdEFQRzVNcWJNWWRiTlE0UldCalpnZGxSelMwdXBSNWQ5bkxmU0ZXMlg0?=
 =?utf-8?B?aHQvdEwwNUsvSjkzK2xrZ08wN3IzUTNQbWtIbmkzWlZVbThBeTlmQURReFBC?=
 =?utf-8?B?c3grK2V6Y1V1azBjSUc5WklEQkNCNkRJbmhHR0RKRWN6M3U4ekJNQWZSZW1G?=
 =?utf-8?B?dDhMT3JOMWtOM243STk0WFZqYlZteitBODg1elJVN0pmZGNVbjlBN3lKWjBx?=
 =?utf-8?B?ZzNhMzV0b2tYRmoyRVh3Y1F2YWJpK3F4MDFqYzFVUHpubG5XTnN2bGZSVFdC?=
 =?utf-8?B?dXdaelU1S1ZkckZxYjQrT2lROGUvdTBHdmlJZFhRS2hRWisrYVZHTDRYWjRC?=
 =?utf-8?B?Uy9pWUJPMjdjUEZ3VGpvR294VGZQUTR3Tmx3NW9qalVOUmIwYWY4dGNNMExh?=
 =?utf-8?B?NGJGZ2ZjRXg5bXZ2UXpRaUFkaUREU3RFTjM2WkZGUC8zR1daMXpjbldRbUxC?=
 =?utf-8?B?VTl1bnNtU1kreEtKNnFyOUdlOXhLbEhBODRhOVVtalA0eVRGOGhPTjRxZ2lT?=
 =?utf-8?B?dVpnOU1NK052dlBrcExuOGlMSGdXcWU2K3p2VElXczlyVWtGK1p6ZSsxd1dF?=
 =?utf-8?B?OG9ScjAxWU56WlVRK3Y1RjNMT1pSdHN3bTlnZkFDVmlBbENOODJQUmhFSWdy?=
 =?utf-8?B?cm80L3NpKytuSWJaUmZVN2J5Y0ZoNHhpdFpLUWQvS1VuYkVHQU01cVlZUXJ0?=
 =?utf-8?B?U1NqSzFNRDFwb1N1UGJ3ZkFIZFkyZHVpZzBaSEZrZE1xMUNoS0hMR2hQNXhv?=
 =?utf-8?B?bkJWbUo2QUhZaXprdUN6b2JybFBjVll2d09KSWdxSS9iUHhjWkpOUlBVblUv?=
 =?utf-8?B?S29LeEY4b1RhNlhmTGFoNzVHdm1Ca2xZenRmM1BJNzl0OWhFbnd0TVB0Nk1M?=
 =?utf-8?B?c1EwTCtrbGZOZXExNDV5TitCVXk3SWdtdDdhcXNHVVA3L2dUK3lXcGVzVlU4?=
 =?utf-8?B?dVM5R0RPKys3OTladkJ5WVhTK1RLYUE0d09oV3FLeE1jVHZ0cDRMMFlnTkdC?=
 =?utf-8?B?VWV2NmdzcUFWZ2xHK2x3Y0JXc0ZncW9nYVA4UzdwUm9SbFM4azRoNjJzVVls?=
 =?utf-8?B?cWx5UmhhQ29sc1p5YktNV2YzV255WGRINVU1T0dvNlpSYUFFMGk0QWtQWlI3?=
 =?utf-8?B?a2drNlJrc2liQktNODBtTW1tMndzS2lGS3R0Si9oY0V1YzRjM3hBTUc3djJO?=
 =?utf-8?Q?lXu0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ne1zQFd3ZgV15ekwY7084J9KNOH3AUEI3ApUZQgNBOdzkSRxtYlcia7gLeUv5URdM6nmQ7qi23T8Ao3a9sLFNeyqgqTpMB+dZGmHfACzAySVo1BqKzSTJGIjxcg8VlMrylLwrLGeSP2B8zzZQ3MqlUVSPugVuhvFv5NKokqkbt5iy6un1WVrtCuQ4U+ibMNMvo9Qz4XaxJkUg0xniLnIFMzPFriwybfIwzaxV6w5ucunr/oAXJ9+6wszX/0482UrP7gotvnpEulPTSsVTp9+A2X8FDNndtprENYqrMxMsucXD/znDPVF9T+lfH6BAu0VWTe46nLA3DoRgE+jNedK6mOgp69eIuh7fGnIpB03/IpPizKDzpIpErGnlRNXxxgv3NzUeOBsn4RkcZphIN6BVv6sz9GTo2gDg1+AxeERzDo0QVxbvrXwX1fnmovOrx2bbYnc1U6kgPURDkODNXCGhI1rn8wDFQSg0x+PnmArgYAVfMRsUyCJg5w+y+ZuKx+g8vR2L7DkzkeSiH14GZapWqDT9H+XIDwzgThwQJtmkZEPoQYm7tgFmkkuEQcqiKaX+DgyXPrJc6yAquLBGr0SRE3BGmS5u9JyGXZygl4OqctTK3ZWZDGvROT0N8RqHthEfyU+6plT2tSg7yZeLUI+AiEW9MBNfyObUk3HUw7iSJLncNhn/M0Dw3Jo9vvqcchDloa9/tHNFRkkIG0pEvDODY9Lry2agsqDTZ6TeaxX8K0lou2A6cHnytTh3syYtVwy5rSdg9kGjkM3nF70Tym2NdUH2S/JiMzuii7tzDbZuC5Zvh28nxWZEzzPEZpMnDnXHltL7we3MRxHfTgXfsqgi9F/rjsU2QDbad1mumEjxbdj+Ducay/nVqiOOXDqFyK8
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4194.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6854a7-9d61-4f56-ca17-08dbc909c25d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 20:53:15.5466 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XeB5qKF+Ur1lwk0RO6zFckW2eIUQrnTszYJDfrf+Im9Dap1YLyLGaQAxEyaIgXwqFEBiOjPelXwGQDwGubQt3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7107
X-Proofpoint-GUID: B-TqnASxuy_a5dpVzQVWOe6uwSXTTEXh
X-Proofpoint-ORIG-GUID: B-TqnASxuy_a5dpVzQVWOe6uwSXTTEXh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_19,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=980 clxscore=1011
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310090167
Received-SPF: pass client-ip=205.220.168.131; envelope-from=bcain@quicinc.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhpbGlwcGUgTWF0aGll
dS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiBTZW50OiBNb25kYXksIE9jdG9iZXIgOSwg
MjAyMyAxOjQzIEFNDQo+IFRvOiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNvbT47IHFlbXUt
ZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogYXJtYnJ1QHJlZGhhdC5jb207IHJpY2hhcmQuaGVuZGVy
c29uQGxpbmFyby5vcmc7DQo+IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgTWF0aGV1cyBCZXJu
YXJkaW5vIChRVUlDKQ0KPiA8cXVpY19tYXRoYmVybkBxdWljaW5jLmNvbT47IHN0ZWZhbmhhQHJl
ZGhhdC5jb207IGFsZUByZXYubmc7DQo+IGFuam9AcmV2Lm5nOyBNYXJjbyBMaWViZWwgKFFVSUMp
IDxxdWljX21saWViZWxAcXVpY2luYy5jb20+Ow0KPiBsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb207
IFRob21hcyBIdXRoIDx0aHV0aEByZWRoYXQuY29tPjsgRGFuaWVsIFAuDQo+IEJlcnJhbmfDqSA8
YmVycmFuZ2VAcmVkaGF0LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAzLzNdIHRhcmdl
dC9oZXhhZ29uOiBhdm9pZCBzaGFkb3dpbmcgZ2xvYmFscw0KPiANCj4gV0FSTklORzogVGhpcyBl
bWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiBRdWFsY29tbS4gUGxlYXNlIGJlIHdhcnkg
b2YNCj4gYW55IGxpbmtzIG9yIGF0dGFjaG1lbnRzLCBhbmQgZG8gbm90IGVuYWJsZSBtYWNyb3Mu
DQo+IA0KPiBPbiA5LzEwLzIzIDA4OjA5LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToN
Cj4gPiBIaSBCcmlhbiwNCj4gPg0KPiA+IE9uIDYvMTAvMjMgMDA6MjIsIEJyaWFuIENhaW4gd3Jv
dGU6DQo+ID4+IFRoZSB0eXBlZGVmIGB2YWRkcmAgaXMgc2hhZG93ZWQgYnkgYHZhZGRyYCBpZGVu
dGlmaWVycywgc28gd2UgcmVuYW1lIHRoZQ0KPiA+PiBpZGVudGlmaWVycyB0byBhdm9pZCBzaGFk
b3dpbmcgdGhlIHR5cGUgbmFtZS4NCj4gPg0KPiA+IFRoaXMgb25lIHN1cnByaXNlcyBtZSwgc2lu
Y2Ugd2UgaGF2ZSBvdGhlciBvY2N1cmVuY2VzOg0KPiA+DQo+ID4gaW5jbHVkZS9leGVjL21lbW9y
eS5oOjc1MTpib29sIG1lbW9yeV9nZXRfeGxhdF9hZGRyKElPTU1VVExCRW50cnkNCj4gPiAqaW90
bGIsIHZvaWQgKip2YWRkciwNCj4gPiAgICAgIGluY2x1ZGUvcWVtdS9wbHVnaW4uaDoxOTk6dm9p
ZCBxZW11X3BsdWdpbl92Y3B1X21lbV9jYihDUFVTdGF0ZQ0KPiA+ICpjcHUsIHVpbnQ2NF90IHZh
ZGRyLA0KPiA+IHRhcmdldC9hcm0vaW50ZXJuYWxzLmg6NjQzOkdfTk9SRVRVUk4gdm9pZA0KPiA+
IGFybV9jcHVfZG9fdW5hbGlnbmVkX2FjY2VzcyhDUFVTdGF0ZSAqY3MsIHZhZGRyIHZhZGRyLA0K
PiA+IHRhcmdldC9pMzg2L3RjZy9oZWxwZXItdGNnLmg6NzA6R19OT1JFVFVSTiB2b2lkDQo+ID4g
aGFuZGxlX3VuYWxpZ25lZF9hY2Nlc3MoQ1BVWDg2U3RhdGUgKmVudiwgdmFkZHIgdmFkZHIsDQo+
ID4gLi4uDQo+ID4NCj4gPiAkIGdpdCBncmVwIC13IHZhZGRyLCB8IHdjIC1sDQo+ID4gICAgICAg
MjA3DQo+ID4NCj4gPiBXaGF0IGlzIHRoZSBlcnJvci93YXJuaW5nIGxpa2U/DQo+IA0KPiBPSyBJ
IGNvdWxkIHJlcHJvZHVjZSwgSSBzdXBwb3NlIHlvdSBhcmUgYnVpbGRpbmcgd2l0aCBDbGFuZyB3
aGljaA0KPiBkb2Vzbid0IHN1cHBvcnQgc2hhZG93LWxvY2FsIHNvIHlvdSBnZXQgZ2xvYmFsIHdh
cm5pbmdzIHRvbyAoYXMNCj4gbWVudGlvbmVkIGluIHRoaXMgcGF0Y2ggc3ViamVjdC4uLik6DQoN
Ck5vIC0tIEkgZ2VuZXJhbGx5IGJ1aWxkIHdpdGggZ2NjIGFuZCBvbmx5IGRvdWJsZS1jaGVjayB0
aGUgY2xhbmcgcmVzdWx0cyB0byBtYWtlIHN1cmUgSSBkb24ndCBzZWUgYW55IG5ldyBmYWlsdXJl
cyB0aGVyZS4NCg0KQnV0IEkndmUgbm90IHRlc3RlZCAiLVdzaGFkb3ciIHdpdGggY2xhbmcgeWV0
LiAgSSBmb3VuZCB0aGVzZSBieSBhZGRpbmcgIi1Xc2hhZG93PWdsb2JhbCIgdG8gIi1Xc2hhZG93
PWxvY2FsIi4gIEkgdGhvdWdodCBpdCBtaWdodCBiZSB1c2VmdWwgdG8gYWRkcmVzcyB0aGVzZSB0
b28gd2hpbGUgd2UncmUgaGVyZS4NCg0KPiBJbiBmaWxlIGluY2x1ZGVkIGZyb20gLi4vLi4vZ2Ri
c3R1Yi90cmFjZS5oOjEsDQo+ICAgICAgICAgICAgICAgICAgIGZyb20gLi4vLi4vZ2Ric3R1Yi9z
b2Z0bW11LmM6MzA6DQo+IHRyYWNlL3RyYWNlLWdkYnN0dWIuaDogSW4gZnVuY3Rpb24gJ19ub2No
ZWNrX190cmFjZV9nZGJzdHViX2hpdF93YXRjaHBvaW50JzoNCj4gdHJhY2UvdHJhY2UtZ2Ric3R1
Yi5oOjkwMzoxMDY6IGVycm9yOiBkZWNsYXJhdGlvbiBvZiAndmFkZHInIHNoYWRvd3MgYQ0KPiBn
bG9iYWwgZGVjbGFyYXRpb24gWy1XZXJyb3I9c2hhZG93XQ0KPiAgICA5MDMgfCBzdGF0aWMgaW5s
aW5lIHZvaWQgX25vY2hlY2tfX3RyYWNlX2dkYnN0dWJfaGl0X3dhdGNocG9pbnQoY29uc3QNCj4g
Y2hhciAqIHR5cGUsIGludCBjcHVfZ2RiX2luZGV4LCB1aW50NjRfdCB2YWRkcikNCj4gICAgICAg
IHwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfn5+fn5+fn5+Xn5+fn4NCj4g
SW4gZmlsZSBpbmNsdWRlZCBmcm9tIGluY2x1ZGUvc3lzZW11L2FjY2VsLW9wcy5oOjEzLA0KPiAg
ICAgICAgICAgICAgICAgICBmcm9tIGluY2x1ZGUvc3lzZW11L2NwdXMuaDo0LA0KPiAgICAgICAg
ICAgICAgICAgICBmcm9tIC4uLy4uL2dkYnN0dWIvc29mdG1tdS5jOjIxOg0KPiBpbmNsdWRlL2V4
ZWMvY3B1LWNvbW1vbi5oOjIxOjE4OiBub3RlOiBzaGFkb3dlZCBkZWNsYXJhdGlvbiBpcyBoZXJl
DQo+ICAgICAyMSB8IHR5cGVkZWYgdWludDY0X3QgdmFkZHI7DQo+ICAgICAgICB8ICAgICAgICAg
ICAgICAgICAgXn5+fn4NCj4gdHJhY2UvdHJhY2UtZ2Ric3R1Yi5oOiBJbiBmdW5jdGlvbiAndHJh
Y2VfZ2Ric3R1Yl9oaXRfd2F0Y2hwb2ludCc6DQo+IHRyYWNlL3RyYWNlLWdkYnN0dWIuaDo5MjM6
OTY6IGVycm9yOiBkZWNsYXJhdGlvbiBvZiAndmFkZHInIHNoYWRvd3MgYQ0KPiBnbG9iYWwgZGVj
bGFyYXRpb24gWy1XZXJyb3I9c2hhZG93XQ0KPiAgICA5MjMgfCBzdGF0aWMgaW5saW5lIHZvaWQg
dHJhY2VfZ2Ric3R1Yl9oaXRfd2F0Y2hwb2ludChjb25zdCBjaGFyICoNCj4gdHlwZSwgaW50IGNw
dV9nZGJfaW5kZXgsIHVpbnQ2NF90IHZhZGRyKQ0KPiAgICAgICAgfA0KPiAgICAgICAgICAgICAg
ICAgICAgICAgIH5+fn5+fn5+fl5+fn5+DQo+IGluY2x1ZGUvZXhlYy9jcHUtY29tbW9uLmg6MjE6
MTg6IG5vdGU6IHNoYWRvd2VkIGRlY2xhcmF0aW9uIGlzIGhlcmUNCj4gICAgIDIxIHwgdHlwZWRl
ZiB1aW50NjRfdCB2YWRkcjsNCj4gICAgICAgIHwgICAgICAgICAgICAgICAgICBefn5+fg0KPiAN
Cj4gQ2xhbmcgdXNlcnMgZ290IGNvbmZ1c2VkIGJ5IHRoaXMsIElJVUMgTWFya3VzIGFuZCBUaG9t
YXMgaWRlYSBpcw0KPiB0byBvbmx5IGVuYWJsZSB0aGVzZSB3YXJuaW5ncyBmb3IgR0NDLCBlbmZv
cmNpbmcgdGhlbSBmb3IgQ2xhbmcNCj4gdXNlcnMgdmlhIENJICh1bnRpbCBDbGFuZyBnZXQgdGhp
cyBvcHRpb24gc3VwcG9ydGVkKS4gUGVyc29uYWxseQ0KPiBJJ2QgcmF0aGVyIGVuYWJsZSB0aGUg
d2FybmluZyBvbmNlIGZvciBhbGwsIHdhaXRpbmcgZm9yIENsYW5nDQo+IHN1cHBvcnQgKG9yIGNs
ZWFuL2VuYWJsZSBnbG9iYWwgc2hhZG93aW5nIGZvciBHQ0MgdG9vKS4NCg0KSG9wZWZ1bGx5IGl0
J3MgaGVscGZ1bCBvciBhdCBsZWFzdCBiZW5pZ24gaWYgd2UgYWRkcmVzcyB0aGUgc2hhZG93ZWQg
Z2xvYmFscyB1bmRlciB0YXJnZXQvaGV4YWdvbi8gZm9yIG5vdywgZXZlbiBpZiAiLVdzaGFkb3c9
Z2xvYmFsIiBpcyBub3QgZW5hYmxlZC4NCg0KPiBTZWUgdGhpcyB0aHJlYWQ6DQo+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMTFhYmM1NTEtMTg4ZS04NWMwLWZlNTUtDQo+IGIy
YjU4ZDM1MTA1ZEByZWRoYXQuY29tLw0KPiANCj4gUmVnYXJkcywNCj4gDQo+IFBoaWwuDQo=

