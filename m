Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4AB817A89
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 20:04:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFIt2-0000ck-Pb; Mon, 18 Dec 2023 14:02:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron.young@oracle.com>)
 id 1rFIsz-0000cS-Nh
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 14:02:42 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron.young@oracle.com>)
 id 1rFIsw-0001jN-TW
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 14:02:41 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3BIHXpQv012910; Mon, 18 Dec 2023 19:02:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=5Z9cFMPpeuUQAJC02M2w4NtcJ0yCY8DFeC0fzQu6pWQ=;
 b=Mfjuw/1yXbVqwu8c8eJXkzZx1aEvMTpNscDFOJkEWqPXrQSrqYK+LbQ4Vd3B+2pAOIs1
 D+QRUtMIajV0W1wXwMVydpEA6F5rzxuvJosvsnzuHWQjlI1nNzAFYOPmbEDxJ0DThCZH
 5IPhu3AmDqtZTqmS1QnbTLVyt0Bc9WoVMWt7WnKgFwSeLIh0bkaiBH/m9CCuptNAU9HH
 Bcatm32unC/eLrgvByRq7Os+BXQCdeV5LZ+RKHXMaFpxTrCN25MOM+hmROcKjIhbhcUm
 gqql0Yszx7+G3bETVlFAY51j/3qR/shC4boyeWoxuua9EBh/+Y5KafG4Xwll5CBbw72m tA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v12aec2ga-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Dec 2023 19:02:35 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3BIIuFiO030846; Mon, 18 Dec 2023 19:02:35 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3v12bbqnds-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Dec 2023 19:02:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCCcvD0ppUYbk6Do43PLmjs2vIXltIc2DDZj4L5Sss/XBlUNy66o06eKIFY1jKnS+T67UxajCCvEmTNSAnw7PIckg5wGv7lvq3fSrzOGUJJkxK5ZtmD4iD857TFeOynuFn7ZDP0EiN85AvJXy0ktp1sBlp/GDrtgWSEv2VKVNDPTr3ZIilVXJVRUfKqggCSAS+RiBXOlJCd3xboHFDLuSddOUZvSST5DoPLEDcYgHajjV9Vcv2SAuvHgkerjuWqeO0M41Rj2RgPuI/66Ah9PdufPm1xXcZNJcdB+OdjiHtvw1Wd69jVqnNbJbhv8nCd5CPWKuEUzTah+lIHT8XNrdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Z9cFMPpeuUQAJC02M2w4NtcJ0yCY8DFeC0fzQu6pWQ=;
 b=Iiu3TE1ENZ5GXKNJxkgIRsIa0ULbUsBcT4/EyfRwKUhoTKNorP4rU3BqTQMMrXsU7Pku1YPiEKGhkghyuyybZq2O14n/tcITGA++4GCg0A5W//qSvJxgyHWN/pdO3XsLLDac/U/2k4DBRRedZq0sM9bb9Xn670G+L9W79SWOaaP2d0Heg3awKSSx7DQPEX0rhfhQ/PAwh+++bwvO2kRHUhfPeji1SBi8M71Ik0Bzd9+oaWxnK/K9yoCmHZW2O8+4AoHHL0Njr62xhzWd5Hf+qDC/AC97hIYwM1apkMrOSlM1oSBxWQ5uG1zlQRdDPMCEGp4OAP+sNhho6RFjZ1AIqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Z9cFMPpeuUQAJC02M2w4NtcJ0yCY8DFeC0fzQu6pWQ=;
 b=vnPl1HolqbXuaJvBkYakwjnkSokkoWG53/zNvV8Y3RLbciN/S8i3iATOn3GljVR3TFpbMw2UWrH/hSgk2MKGp5CLAL3Hhq3V7tKO4wPAmU19myvfQbbijQlbTUd6b3ZfWPxTHR5QRlz4PWVkS7BSlBBnQwQRLjs7Yp+h3+hSCD4=
Received: from SA1PR10MB6294.namprd10.prod.outlook.com (2603:10b6:806:251::8)
 by IA1PR10MB6808.namprd10.prod.outlook.com (2603:10b6:208:428::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 19:02:33 +0000
Received: from SA1PR10MB6294.namprd10.prod.outlook.com
 ([fe80::bd1e:52bd:a521:ebf5]) by SA1PR10MB6294.namprd10.prod.outlook.com
 ([fe80::bd1e:52bd:a521:ebf5%2]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 19:02:33 +0000
From: Aaron Young <aaron.young@oracle.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, Aaron Young <aaron.young@oracle.com>
Subject: Re: [PATCH] hw/acpi: propagate vcpu hotplug after switch to modern
 interface
Thread-Topic: [PATCH] hw/acpi: propagate vcpu hotplug after switch to modern
 interface
Thread-Index: AQHaLRqRJIJhDGyJfEu6v/xCa4l/krCvbsVf
Date: Mon, 18 Dec 2023 19:02:33 +0000
Message-ID: <SA1PR10MB62941E3CFD24F8FF555B9F939490A@SA1PR10MB6294.namprd10.prod.outlook.com>
References: <cover.1702398644.git.Aaron.Young@oracle.com>
 <0e8a9baebbb29f2a6c87fd08e43dc2ac4019759a.1702398644.git.Aaron.Young@oracle.com>
In-Reply-To: <0e8a9baebbb29f2a6c87fd08e43dc2ac4019759a.1702398644.git.Aaron.Young@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR10MB6294:EE_|IA1PR10MB6808:EE_
x-ms-office365-filtering-correlation-id: 3c063b57-d025-4ce9-356b-08dbfffbe40c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vsC+W233+8axv0tHg6UADlyKUXzrTW2e9S7UJEq31GMESk4QFJtHtIPLZIMxylXgQzqc5mwSgMXTUIW6lYhoQNT9v1OSPHvRoZqn8h0LJsCENT4eKhhjjuRzrGnabjtmX6vcA3rhNZkmjbSY/bbQRc0UPPxEKU0xxBsoyx34sVtnQPuMy2ZFK6hXKMb47wZyf+XMpZ7qR1eAqABUQNXXwmcolnVSQIHOA8ObgN/f8zi3y55tN0RJNYvbNunCf9mi6znB3NpI9i8RKoWZ0UpACh9Ohm9sU41atTK7SvVmq45GKB9Kz6QWF4w/ZDqP6F+Ig1363hbxscJglWMab1U9s2JGC/x8QEYgJv27e0qyVNBXXghSbRoGQNxv28AD7wu7Jdac+U38lWXq1PzuvZOqB7VyVMKd1rr1u63B5XQ38c7Cd5eSbeyVNEjJrFLQb/fdFjxJFEbsP58I/WJ0LnvYBS9sLwEfyZdKL3AwnTPBy3xF6RBxVRXzvhYTEYAR9k/BOPKgvZMNR4WwNvr/Iko/jSX9Wx+/nx24lZQ1z9KkRPEMOIqhw+lQphzJ+n7f5Dq9j/HO5Hbk52c7QhE2z+EbO3Wqh7B1uB7BVc87YnRCVRYjVan/wbblaxGTI9WeGIUB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR10MB6294.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(2906002)(5660300002)(38070700009)(41300700001)(86362001)(33656002)(122000001)(71200400001)(38100700002)(26005)(107886003)(55016003)(83380400001)(66556008)(66946007)(64756008)(66446008)(66476007)(91956017)(76116006)(6916009)(316002)(54906003)(478600001)(53546011)(7696005)(6506007)(9686003)(8676002)(4326008)(8936002)(52536014)(44832011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iqPiqFAf89aukAYbLm1XPFDxt8BxhhpILGMcW2mH9q//1mgspxRZKGJ6Ic?=
 =?iso-8859-1?Q?4STOKnpLhq03kfXU6xfoFKtuWQFvZQz1gfFcqO08bJfzTP4pIQbIww6l5k?=
 =?iso-8859-1?Q?DpLglt+wzOGhSDNGdq9lopp1o7txC2TU3YBCzKi7oX3Bx06qO34sVs579Y?=
 =?iso-8859-1?Q?GIXeLZzYurT1VLmICX/EOfsMuuSFzCZF+gbsbQfUYu/GEf3NmdDlaX8bhr?=
 =?iso-8859-1?Q?b5FIuUy7IK7EMsPxgaNk/myqnIn/ZsI+ywgZSSBxB9OP+FDUmUzCORXH3U?=
 =?iso-8859-1?Q?uBUoHbrwv9WjNUEbZqIeF6H1cTzZofG6eO/klKDFrIQ0c05V9a5xBNth/x?=
 =?iso-8859-1?Q?MeVVo/3oWot9RuJYgU4bLmQEWCFCCP6op036B4I1OvA1ao4/8DtOMtRYH+?=
 =?iso-8859-1?Q?tVFGWb9fOceSQ6ZKWFOI7fxTqdV7udWAVswmZpTEO4skXu3Mgzf2p+b1yi?=
 =?iso-8859-1?Q?00/apQyesF5nknWXWcrsNv7vLtjlgm+QZ/hEu18/qp+m5tLs9Igmo5nQ76?=
 =?iso-8859-1?Q?vHnJs0Qb72wVUR8zspqiEbGYRt/JOnPylOe4EdRm0BJ9zK9INIFlIl5dSh?=
 =?iso-8859-1?Q?mC+lqoQS/6K1zSgU1sR4kUyo368yrowTPZKoue9K6ljfDPICUoDb552ixZ?=
 =?iso-8859-1?Q?FuaOWVJpwS6iAy2Ctb/ZFnWuUIKNAWbrhXpvgIcLnA4TizlKnWJcq+tIfe?=
 =?iso-8859-1?Q?Pi/pa19nPIAC+5eBkC/Pm7wdqYzGy6Rq8HObk98bL3bD7rVBius7E7HXEP?=
 =?iso-8859-1?Q?erPz3T1ZB/4UZduhqYuEUbzFkRpbD/33436v+WhIJf52fiaGBZAdSMUm9k?=
 =?iso-8859-1?Q?6u6/d0ICsJjZEDHF6FG2TnO6sxjUsT5y23G9fXaTTsgQvqE55rbrrEEDNJ?=
 =?iso-8859-1?Q?pIRTLOgeowDsDdXZnNUA3D1uIl+VAUWa7upNwFE8YkApGaB/WGKpz0+myB?=
 =?iso-8859-1?Q?+6u0+nRVpnMQAH7ZGFaxQ41CSbh00NcTCif4nU24nShne8O1UlQxKAEONA?=
 =?iso-8859-1?Q?GogCy7GH7qdQQsrFICLjl6x83OoADZYWgRYTpygpHd8EqG+ky8YUPrS2ku?=
 =?iso-8859-1?Q?rDKBZ8c6UD8w6UdwE1c/MYbSrZYEGRi39BuJWnGPn48+Cig2kb0ccvUbAS?=
 =?iso-8859-1?Q?wA+29lSVopsCxfPouWrK2UVgkaEVZHqCS88ItgcbVlPARqV7RGXYrrRiZD?=
 =?iso-8859-1?Q?kYLJUFEvUDSeuQtHmB80k0vJnBAScqsVxJ7tGW8cOctNQZjeJy4RjguLMk?=
 =?iso-8859-1?Q?iv2SxkKp2T+5YgUNn8kreH1B4+3Uh1GsPRa4SGRm/6YiLN0dSoguspPlel?=
 =?iso-8859-1?Q?djgHtYvLxw9HsP02DRxw7PAPXOpJLKByzB9LHBSiZmHaNW/XkpFaXhbqXz?=
 =?iso-8859-1?Q?Mdfya0odiRmglTHoeudbT4y9UnqrlYesL3PIj7s++DcfqWwpwPyIjAQyuF?=
 =?iso-8859-1?Q?mqGKc4dcAesyGFsvFOtPsYAbRoQQECZIQBgGmuoMYjsqiCYPlinjfghCdk?=
 =?iso-8859-1?Q?7cpo52XytyFLUtvTOJL7OdjPZ7N2vd96ntE/aG5JpqPD8nTH1lmLg9XMS3?=
 =?iso-8859-1?Q?6jtsu4RoQN0edj9CfowjovDcRb1KV/MkxE6YWU0+g3jDrTdqeOXS62sLrj?=
 =?iso-8859-1?Q?f8Yfla/sVUZam80cofnxNJP+pUVEOdTA1L?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Cnlp8NcPGOAPBehC4zfIo1vCRjxgu49YNzXtXTaASHrHPQlGtDTSU4SYcbuda2P9wQsibcNEsMT9s6pIDahv2JpIV+Fusw7vEKIC0gna3E17+Xl94HpO1f1A96xR4qY6CIrHJpVrNYdxzqouVTcuWv5wKPHYbH8IUmm7nsF7r/e2k684BJwXvWaIqYNzdymq2bgYw07dhZDzsy22131NDqDYpPYTtDZqPVKqpQn8O/KUddoQVyWc4EyRN8Ex0Jp+tW43NFlbz6l1aVte6Pq3XMwiLTO7MfGK2EqBgKprGW0RUeYrSa+0RF/Gvei9AHKqRe6yL+CnCB24ZXE1td5B3wD+OCaA2CO36sZo6b20vs0xjgrb6/BOCEQt+dAKVW4VqmWIlPkffXSbDG3ACONKGRzfhFk41GiZu2K4DlX/YyQYgAWuMpdBBTJ6w5kJPvvaIzdXRyBxSMlaDDIi3Q/srJ70Gy+HbT12k4pSqrkhFK6yofIkqHpUXWHeXcikTGNyGKfPp7+OXC7B6WUmyx01UyktxafwMAOvM5A9zXbU/Y1GGsP7/RtAWBwQiaURsz+XmqZzPbhDb/xocaOEu6Q701rV+K99Ftsu3LhrkZb1hek=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6294.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c063b57-d025-4ce9-356b-08dbfffbe40c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2023 19:02:33.0689 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wFRDOlSUNfk+HIME3W+ehFwgEX0AAoPYyTyuJ/MakG4JhTK57Uhz68+BtL21rQGA1QetooSKH1A3wlsMvlVxzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6808
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-18_12,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312180140
X-Proofpoint-ORIG-GUID: 1g32clv0XXtRjucqSHG6EyGi27wCQ9tx
X-Proofpoint-GUID: 1g32clv0XXtRjucqSHG6EyGi27wCQ9tx
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=aaron.young@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi.  I wanted to follow up with information to test/reproduce this BUG/issu=
e.=0A=
=0A=
 Steps to reproduce:=0A=
=0A=
 1. Use the following options with QEMU (configured with OVMF):=0A=
    -S -smp 2,maxcpus=3D260,sockets=3D2,cores=3D65,threads=3D2=0A=
=0A=
 2. Start QEMU and when QEMU reaches the paused state (due to -S),=0A=
    issue the following command from the QMP Shell:=0A=
    device_add driver=3Dqemu64-x86_64-cpu socket-id=3D1 core-id=3D64 thread=
-id=3D0 =0A=
=0A=
 3. Continue booting the VM and OVMF will report the following error=0A=
    to the OVMF debug log indicating the BUG/error condition:=0A=
    QEMU v2.7 reset bug: BootCpuCount=3D3 Present=3D2=0A=
=0A=
 BTW: This BUG often results in intermittent OVMF Exceptions/ASSERTs as wel=
l.=0A=
=0A=
 Thanks,=0A=
=0A=
 -Aaron=0A=
=0A=
=0A=
________________________________________=0A=
From: qemu-devel-bounces+aaron.young=3Doracle.com@nongnu.org <qemu-devel-bo=
unces+aaron.young=3Doracle.com@nongnu.org> on behalf of Aaron Young <Aaron.=
Young@oracle.com>=0A=
Sent: Tuesday, December 12, 2023 8:51 AM=0A=
To: qemu-devel@nongnu.org=0A=
Cc: mst@redhat.com; imammedo@redhat.com=0A=
Subject: [PATCH] hw/acpi: propagate vcpu hotplug after switch to modern int=
erface=0A=
=0A=
If a vcpu with an apic-id that is not supported by the legacy=0A=
interface (>255) is hot-plugged, the legacy code will dynamically switch=0A=
to the modern interface. However, the hotplug event is not forwarded to=0A=
the new interface resulting in the vcpu not being fully/properly added=0A=
to the machine config. This BUG is evidenced by OVMF when it=0A=
it attempts to count the vcpus and reports an inconsistent vcpu count=0A=
reported by the fw_cfg interface and the modern hotpug interface.=0A=
=0A=
Fix is to propagate the hotplug event after making the switch from=0A=
the legacy interface to the modern interface.=0A=
=0A=
Cc: "Michael S. Tsirkin" <mst@redhat.com>=0A=
Cc: Igor Mammedov <imammedo@redhat.com>=0A=
Signed-off-by: Aaron Young <aaron.young@oracle.com>=0A=
---=0A=
 hw/acpi/cpu_hotplug.c | 20 ++++++++++++++++----=0A=
 1 file changed, 16 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/hw/acpi/cpu_hotplug.c b/hw/acpi/cpu_hotplug.c=0A=
index 634bbec..6f78db0 100644=0A=
--- a/hw/acpi/cpu_hotplug.c=0A=
+++ b/hw/acpi/cpu_hotplug.c=0A=
@@ -59,7 +59,8 @@ static const MemoryRegionOps AcpiCpuHotplug_ops =3D {=0A=
     },=0A=
 };=0A=
=0A=
-static void acpi_set_cpu_present_bit(AcpiCpuHotplug *g, CPUState *cpu)=0A=
+static void acpi_set_cpu_present_bit(AcpiCpuHotplug *g, CPUState *cpu,=0A=
+                                     bool *swtchd_to_modern)=0A=
 {=0A=
     CPUClass *k =3D CPU_GET_CLASS(cpu);=0A=
     int64_t cpu_id;=0A=
@@ -68,23 +69,34 @@ static void acpi_set_cpu_present_bit(AcpiCpuHotplug *g,=
 CPUState *cpu)=0A=
     if ((cpu_id / 8) >=3D ACPI_GPE_PROC_LEN) {=0A=
         object_property_set_bool(g->device, "cpu-hotplug-legacy", false,=
=0A=
                                  &error_abort);=0A=
+        *swtchd_to_modern =3D true;=0A=
         return;=0A=
     }=0A=
=0A=
+    *swtchd_to_modern =3D false;=0A=
     g->sts[cpu_id / 8] |=3D (1 << (cpu_id % 8));=0A=
 }=0A=
=0A=
 void legacy_acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,=0A=
                              AcpiCpuHotplug *g, DeviceState *dev, Error **=
errp)=0A=
 {=0A=
-    acpi_set_cpu_present_bit(g, CPU(dev));=0A=
-    acpi_send_event(DEVICE(hotplug_dev), ACPI_CPU_HOTPLUG_STATUS);=0A=
+    bool swtchd_to_modern;=0A=
+    Error *local_err =3D NULL;=0A=
+=0A=
+    acpi_set_cpu_present_bit(g, CPU(dev), &swtchd_to_modern);=0A=
+    if (swtchd_to_modern) {=0A=
+        /* propagate the hotplug to the modern interface */=0A=
+        hotplug_handler_plug(hotplug_dev, dev, &local_err);=0A=
+    } else {=0A=
+        acpi_send_event(DEVICE(hotplug_dev), ACPI_CPU_HOTPLUG_STATUS);=0A=
+    }=0A=
 }=0A=
=0A=
 void legacy_acpi_cpu_hotplug_init(MemoryRegion *parent, Object *owner,=0A=
                                   AcpiCpuHotplug *gpe_cpu, uint16_t base)=
=0A=
 {=0A=
     CPUState *cpu;=0A=
+    bool swtchd_to_modern;=0A=
=0A=
     memory_region_init_io(&gpe_cpu->io, owner, &AcpiCpuHotplug_ops,=0A=
                           gpe_cpu, "acpi-cpu-hotplug", ACPI_GPE_PROC_LEN);=
=0A=
@@ -92,7 +104,7 @@ void legacy_acpi_cpu_hotplug_init(MemoryRegion *parent, =
Object *owner,=0A=
     gpe_cpu->device =3D owner;=0A=
=0A=
     CPU_FOREACH(cpu) {=0A=
-        acpi_set_cpu_present_bit(gpe_cpu, cpu);=0A=
+        acpi_set_cpu_present_bit(gpe_cpu, cpu, &swtchd_to_modern);=0A=
     }=0A=
 }=0A=
=0A=
--=0A=
1.8.3.1=0A=
=0A=
=0A=

