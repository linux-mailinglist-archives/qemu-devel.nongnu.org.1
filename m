Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCE8718315
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 15:47:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4M9m-0000EH-1T; Wed, 31 May 2023 09:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1q4M9R-0008Sg-NT
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:46:16 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1q4M9O-0000pO-9P
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:46:09 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34V8UwWE026777; Wed, 31 May 2023 06:46:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=fVyTNFF01u4HuZ8TfWgK4zln16eUlsIwofmi0ra/C0c=;
 b=SJnr8/nv/eSe+bYyGlFgk/UGyH+JB3I8hRIAcbUKo4LqRPK6vU7+kuiSOv9CEo+Oh1m2
 laEmV+I7OlxqUm/1f+w0DVRmFZ66I1O9kbxjdBaioQ9n/IB59Uz5ZDntoG6KT3PKe1qS
 wm0agbl80DbnsvAk8Nz9TD8KsSF4kmxNQsuF6ADOLwbgTDpZecFwFVrQxNqV6rSz6nMI
 eu8rPLJnXXWUTAX6OZQd+jwa0+SU/jyAIObrPIy7zn4N9lOeDM2OxxZG5neceKDW+WIu
 qdRkQ/rhYH55m61CXp89nGd2v0W2FQFN3GSym2tIDPIGowEwxtx4Ou5bCsFNLdkDo8cR 1g== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3quh6cj3m9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 May 2023 06:46:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzRzEP5pfptQGIGG/B9Fhwfsbnvgnj6VNAkSHfNZf0yzxvi0wmGAJod3lvxBdoovLJC9zMaXCYHv88rbk0d2VJ2WQ6q9qwtEicXU4+mtF+x6S1c9YRICd+FDvnxEJco/CruRmEwZLIB3303nolIQkV+ww7liZwywItZmY8JjdbcVhvxqOVBHgeVFzP8TB6O1hBSQ17f3cMTYtOpTwS8pALUjv9Cs7HpfiwFNCeIjtHh6aPXWaNAjNSZtEl4Dw5b9Lg6GThA6N/4Y/Cr4xu8GoQ5AisCCQqH3txJq+8r8UPQyzYEY4E4zO6M1RMdGoh2CnnV54gk1UwaE1CXNWWxBGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVyTNFF01u4HuZ8TfWgK4zln16eUlsIwofmi0ra/C0c=;
 b=P9Wtc89GLO+NPjFFlDrO1kEZebpw21mS5tgOtYQZKSa9xVeuNz+jYYUbDlJVjWufehXFrsnFg5Tx60hRLsJeqa/b2a3mpXOnDdK1vqIY/jeQmKEz7Q5cbCVKv2/B1FH1BJdrISBn8CedagilOa1JJ2e7o4HJNaIrg81lNl2DdBdp3h2LNvbO4gQwPP3I4i0F4rEnVRQuQpjqjaZFq7WO/z+CZpsFfYRpBjiVrdZZyaOXgsCWRPRSZuynK/vS4QdFPfDuYK/4dLH5vkbahLUFY74IJRS85BIbQiwUgYbJeJHJuau2oGi93yLuTbsWHStAyf4dft2Ijg8nWtq2rPY86g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVyTNFF01u4HuZ8TfWgK4zln16eUlsIwofmi0ra/C0c=;
 b=mxmTq2d5tnH5PY+EAsTwX+2vxhtcs0rdlwJ7UkIZBnP5ACT78yXSvUJf/vSRPgqOyEcZejz1eecfP54D6OjI7FNLAlxYdtrCp+y5s6c7Yp05KQCnIcIzQw0BVVqoUZkV7cbwJFqoAm/CR7XE72dI3raO3rO3dZntZZramPZku/OmF0N2uNkklP3IOUGEkq/FnYmLgquGoOYRD+RPAV0k7/5epWWPu/cq/x1kE5fViRvFyNZqJsyncl+jfn5M4ae56s4HYe0zokmtrvWIYHdm9PQu4uV3Z7cmLnEgfPhCd+59osm2zmU/Vws0iyuSVDav00RKZ3TyjwymhUCRG/p9Yw==
Received: from BL0PR02MB4579.namprd02.prod.outlook.com (2603:10b6:208:4b::10)
 by PH0PR02MB8597.namprd02.prod.outlook.com (2603:10b6:510:109::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 13:46:01 +0000
Received: from BL0PR02MB4579.namprd02.prod.outlook.com
 ([fe80::b138:ab35:d489:67f]) by BL0PR02MB4579.namprd02.prod.outlook.com
 ([fe80::b138:ab35:d489:67f%4]) with mapi id 15.20.6433.024; Wed, 31 May 2023
 13:46:01 +0000
From: Jon Kohler <jon@nutanix.com>
To: Jason Wang <jasowang@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] tap: introduce IFF_NAPI
Thread-Topic: [PATCH] tap: introduce IFF_NAPI
Thread-Index: AQHZk25qRa2mfA5TFEenDhqyNeJCB69zuhcAgAABD4CAAAMqgIAAAjcAgAAZ0oCAAItBAA==
Date: Wed, 31 May 2023 13:46:01 +0000
Message-ID: <94C45D0D-3ED9-442D-B35E-03B1023C0346@nutanix.com>
References: <20230531031645.44335-1-jon@nutanix.com>
 <CACGkMEvA6ren7Xb_ujYjeajjCEMKw=imYqf3-pNvn6wFxp0a=Q@mail.gmail.com>
 <CACGkMEtCLmi5CzpWye=tNgs_xhYoysCndDTQ+Mf8WoAGQv894g@mail.gmail.com>
 <42F3C35E-EB0C-4AA9-8863-618E60792842@nutanix.com>
 <CACGkMEu51T2JHF+mGM5xfgmA5N=oSTZgCtRy1JG0c6yDxcVDtQ@mail.gmail.com>
 <CACGkMEtXtdqrOeS1QZvBtVC3_FOi9s=_28uTDtR=nLKFrTvoXQ@mail.gmail.com>
In-Reply-To: <CACGkMEtXtdqrOeS1QZvBtVC3_FOi9s=_28uTDtR=nLKFrTvoXQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR02MB4579:EE_|PH0PR02MB8597:EE_
x-ms-office365-filtering-correlation-id: 1b3fb0c6-714c-471f-3dfd-08db61dd5f29
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GkDLd6e9s9ySscRfDLAwCTAkoBugO79V2SnD+JaXECM+WZ+iT4knea7dM51vtgdA9eTLmsaSfZiElqnXqZh7sZBKAbG4LNgI8iH7u+Xysa725CoOmbf1vCSCcQ6EV6sho8TQwrJDRkDl2f8IjNo2U6fQL3efIASzKHuEvaoAXGaEWKV3zBg6hx93otaI71iczFKtZV0xPQpIVPznqr84aVH0xBtH8iIZl4JLMzmlzky7EZc6/Hl/uo3lAeCUqVNM3haA8/3icigFBZvd1AUzt4M0qx+4d9RsbzCLloZB0c8QkreRhjr0SrcZ+kbhUAe3JCvXPuwMifmrd7sEdGX6Ebj1pVSIeXySYH68h/XoURPEYAcW8bR4y5XDcCYWzd+qhD7aLK46+sFNicgUOgZputdwQSGYEhEl3xcG/H8dhq0M3xdhyU2dS5Be/Lsh/9l3Kwyqt0N2OAeJ8gWUfBfIbihcJwzvImgxQrA/p/fk2PerJi+BgkflTpQ89PmQTmL7W0+v0Fgkn6kRP5dNpqfjF5W+/BT2ZySMrZT3U9jgEzKl6kArXTciP7akEtts/HrZ2sPwIVk3EFOU/ajDGFwsd+u4i+VnwRDILLtjbWPhf/PXct6iFerTdiFoxMsd+sp3l2JuWnh0wj5OzzCjMgDCxA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR02MB4579.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199021)(6512007)(6506007)(186003)(53546011)(2616005)(2906002)(478600001)(83380400001)(8936002)(38100700002)(8676002)(41300700001)(122000001)(6486002)(64756008)(76116006)(66556008)(33656002)(5660300002)(66946007)(316002)(86362001)(91956017)(36756003)(71200400001)(66446008)(38070700005)(66476007)(4326008)(6916009)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REcyV0JMeTFHWG5yK1JvK3p1NzdFTkNObGNsbkx0R1NydVFKL0NyRHh2V0ht?=
 =?utf-8?B?bVFXZ2ZHNmUweVlTQlkyL2M5amIxWlBHM2dtRkZzdDRJMEtETEY5T29lL0hi?=
 =?utf-8?B?WHAxTTJMWk02Q0hqcklzN3ZVWTJKMzVmTjN1d1dYcHkwQzNzakJneFZhWFd5?=
 =?utf-8?B?QTZyOU8yUFprVThvSEYvV2NSaW85ZWJ5K0lLdEJuMGFKUjNYU2p6dW56RVVl?=
 =?utf-8?B?NUFFTURqQmh3QWFiK2htZ2N2MEt1cU1EWmI0eUM4cE9MSzJ1YUoySHhsdXVq?=
 =?utf-8?B?dmFnK1B4ZW1HbFpvNURTNi9HbTFzQy82c2ZPekRIZGUrTkdERVRCVjlxWE9W?=
 =?utf-8?B?OXRGdU1FSndScWVaY2RqSG4rVnpIMGFhMUVFOCt3TUFISFZ2S0ZuWHNtVXpy?=
 =?utf-8?B?M040RDFUeVpYc2NMcytKSnBaVmdqMmRsNXcrb1R0amxXYjhkT09sSlB0UG94?=
 =?utf-8?B?cTg2ZWthVEowUGdJY1pUTFUvOS82aitJekFpYllzaFRKNDZnZGs0WXArbnJp?=
 =?utf-8?B?bmt1OVdROVJBcTdvRW43bHNKWGtYWXl1R1N6eXhBZHhacWh6UFJHQzRmSzAw?=
 =?utf-8?B?YktFRUNETVVzNWdBblYzVm14b3JWQ1NLVFdnbVFNcGVyN0duNXBuWU8vK1c4?=
 =?utf-8?B?MS80cnBKYkQ0czBxaVg4aThTQW00WmVTWUsyYXhIS0JiL0JOR3k3VlNGcDln?=
 =?utf-8?B?TmZHVFYxMThoSzI2ZFZ4VVFkWlRaTVlTMDFLRkNBY0Npc3AyeDNuTmdMUytS?=
 =?utf-8?B?NDV6Z3lQWXI2ZUZUcU80SDkrMVh1cUE3WnNFMWF6YTBXbGo2MnlER3N3clY2?=
 =?utf-8?B?MHpjZ0s2NGNuU2hHcXJLR3lvRXJtY21EdE5zNy9kaGNKSVFCeXJiNi9HSWlt?=
 =?utf-8?B?QXZMUFQvbWkvR1QrWENiUUVFUzdNY2pKSVc4d042WHBMcElWMWFrY1MxSHNL?=
 =?utf-8?B?T3loM2VrNXlXUHZZVFJ0cnYzWnUrcDhZTjduN1pYMEpOeGxwdG50SkM0b0xO?=
 =?utf-8?B?L0QvSmFmQnc5Wk9iQTFkYjFaVlZpQVdyZElwTDAxaFpPa3JuK2dkKzd1c0dN?=
 =?utf-8?B?NkNSREM2NjZaV09aUWQvNFRid0RRSTNHamttU3gwc3RUekJKT01qRGlEWG45?=
 =?utf-8?B?UVFGVjhuOG5icHZBSFBtQ012aC9KazVIZXYzVXZpUHFrR0U1QlRhcHJ6Y2tD?=
 =?utf-8?B?dkNmVit5Q0RNTjlTb3h6UUgzSTFEeDBSekthdi9sU0F0OWdnR09zSitGTTIv?=
 =?utf-8?B?K1BDTDUzaWNOT084SWlzeXJnT1ZWOVd2UXBZeFJ1cmxpSUZjTktkNmIyYnBp?=
 =?utf-8?B?QnBUay9Ra3VsM3BJREgvSy9UMTdLTGVYTWdiYzZmYWs5aldwa2N3cEtwblpR?=
 =?utf-8?B?ck0yMGNsZ3VaSFQraE9DQlpyNTl2bjJBc2tWNlB6SlNHRDVXOTBhQlhSVFJB?=
 =?utf-8?B?cDVSczFTTStYTjh0NEtSK2E1L2R1OGZ6YXhtYk9wSkJWT1MvMkM1RFl5VmtI?=
 =?utf-8?B?NnVPN2J6SHcvcWxnYjRBdGFzV1c4cmVoS2YzRHpDc2hUQUtvTVFVbXJKYzBl?=
 =?utf-8?B?cXBlcTM1c2NLbCtFeTVxdFFaNDFNYWZ6S2I4THVjL2t1eTROVVBFUFhxSkZj?=
 =?utf-8?B?b2QrS0F0VEhtUTdRZDc5aUxtaC9mYzR1SFlBcDJWTEFaYmRUZnpQcGorZEp1?=
 =?utf-8?B?c0d5dUVNWC8weHljaEJNMVFZL055Rlk5TGh4QmlIUDhJbCtuY2hxVVBucHBO?=
 =?utf-8?B?c0lnTFg1QXRzV08rZFBtblE1STRNS3JPVnpBU1YzaDROTW52WE41bThPRkly?=
 =?utf-8?B?KzUvRDkrMTFaQWFBNWVudTRNQ1BQeE91TFFXZVI4NWdtQjNLRUhmWlNrSVRF?=
 =?utf-8?B?MytGNWtjVUMyUnA1SXd0Z2tpcHBncjlXSTQ3RnQyMmp1RVhoSE9GVGRMckpT?=
 =?utf-8?B?MDdudy9uQWFIcytTNit4T0NJclpzYjJVbEtEbWw5dGVxdkNib0hFdTRzd08z?=
 =?utf-8?B?OFJIUDlvU2NoTGxQeGpaTzlRS0daN1ZIOWxFT1IvTHdkZ0FKeHhVQzV4c3NW?=
 =?utf-8?B?bXZIbjZtelBvaks0c0d1LzBNQjI0NVF0aTA5T1dvQ2lHdnc5UWovTzlZLzc5?=
 =?utf-8?B?UTgvOGhOdnBkdG4xbVp5bzJhTGJ1eUVRQ3VTUjVEMXptbmhOTFgrb0hxWFh3?=
 =?utf-8?B?ZE5rUkNqejBZRUpPdGxqS1pPeTNvSW5TMk1qWHpjR2tYd1VHazd4ZjN5YU1T?=
 =?utf-8?B?MCtRemxnUHplNnByWHdudDJ5bjNBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <519E3C19FDC3D64FA6FD5F31FE8B6FC9@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB4579.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3fb0c6-714c-471f-3dfd-08db61dd5f29
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 13:46:01.5217 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fe99/1oL/3b3QWFUusoCIXEvkCrVjfrqctYcU9SpTHjCblzDyVYQste017C2QVOJHB07iLVpmQyNqfXPOYm8CddFqPJxtVP5ZXxspfW8bBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8597
X-Proofpoint-ORIG-GUID: fK-Yg3d4hlCWr4XKX46alNU8FVXK99kH
X-Proofpoint-GUID: fK-Yg3d4hlCWr4XKX46alNU8FVXK99kH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=jon@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
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

DQoNCj4gT24gTWF5IDMxLCAyMDIzLCBhdCAxOjI3IEFNLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgTWF5IDMxLCAyMDIzIGF0IDExOjU14oCv
QU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6DQo+PiANCj4+IE9uIFdl
ZCwgTWF5IDMxLCAyMDIzIGF0IDExOjQ34oCvQU0gSm9uIEtvaGxlciA8am9uQG51dGFuaXguY29t
PiB3cm90ZToNCj4+PiANCj4+PiANCj4+PiANCj4+Pj4gT24gTWF5IDMwLCAyMDIzLCBhdCAxMToz
NSBQTSwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6DQo+Pj4+IA0KPj4+
PiBPbiBXZWQsIE1heSAzMSwgMjAyMyBhdCAxMTozMuKAr0FNIEphc29uIFdhbmcgPGphc293YW5n
QHJlZGhhdC5jb20+IHdyb3RlOg0KPj4+Pj4gDQo+Pj4+PiBPbiBXZWQsIE1heSAzMSwgMjAyMyBh
dCAxMToxN+KAr0FNIEpvbiBLb2hsZXIgPGpvbkBudXRhbml4LmNvbT4gd3JvdGU6DQo+Pj4+Pj4g
DQo+Pj4+Pj4gSWYga2VybmVsIHN1cHBvcnRzIElGRl9OQVBJLCBsZXRzIHVzZSBpdCwgd2hpY2gg
aXMgZXNwZWNpYWxseSB1c2VmdWwNCj4+Pj4+PiBvbiBrZXJuZWxzIGNvbnRhaW5pbmcgZmIzZjkw
Mzc2OWU4ICgidHVuOiBzdXBwb3J0IE5BUEkgZm9yIHBhY2tldHMNCj4+Pj4+PiByZWNlaXZlZCBm
cm9tIGJhdGNoZWQgWERQIGJ1ZmZzIiksIGFzIElGRl9OQVBJIGFsbG93cyB0aGUNCj4+Pj4+PiB2
aG9zdF90eF9iYXRjaCBwYXRoIHRvIHVzZSBOQVBJIG9uIFhEUCBidWZmcy4NCj4+Pj4+PiANCj4+
Pj4+PiBCZW5jaG1hcmsgdy8gaXBlcmYgLWMgKHJlbW90ZSBzcnYpIC1QICh0aHJlYWQgY291bnQp
IC1sIChzdHJlYW0gc2l6ZSkNCj4+Pj4+PiBmcm9tIGEgZ3Vlc3QgcnVubmluZyBrZXJuZWwgNS4x
MC4xMDUgdG8gcmVtb3RlIGJhcmUgbWV0YWwgcnVubmluZw0KPj4+Pj4+IHBhdGNoZWQgY29kZSBv
biBrZXJuZWwgNS4xMC4xMzkuIEd1ZXN0cyB3ZXJlIGNvbmZpZ3VyZWQgMXggdmlydGlvLW5ldA0K
Pj4+Pj4+IGRldmljZSB3aXRoIDR4IHF1ZXVlcywgcmVzdWx0aW5nIGluIDR4IHZob3N0LXdvcmtl
ciB0aHJlYWRzLiBIb3N0cyBhcmUNCj4+Pj4+PiBpZGVudGljYWwgd2l0aCBJbnRlbCBJQ1ggNDMx
NCBAIDIuNCBHSHogd2l0aCBNZWxsYW5veCBDWDUgMjVHYkUgTklDIC0+DQo+Pj4+Pj4gQXJpc3Rh
IDI1R2JFIHN3aXRjaC4gdmhvc3Qtd29ya2VyIHRocmVhZHMgbGFyZ2VseSBtYXhlZCBvdXQgb24g
Q1BVIG9uDQo+Pj4+Pj4gIkJlZm9yZSIgYW5kIGFyb3VuZCB+NTAtNjAlIHV0aWxpemF0aW9uICJB
ZnRlciIuDQo+Pj4+Pj4gDQo+Pj4+Pj4gU2luZ2xlIFN0cmVhbTogaXBlcmYgLVAgMQ0KPj4+Pj4+
IGlwZXJmIC1sIHNpemUgfCBCZWZvcmUgICAgICAgICAgfCBBZnRlciAgICAgICAgICB8IEluY3Jl
YXNlDQo+Pj4+Pj4gNjRCICAgICAgICAgICB8IDU5MyBNYml0cy9zZWMgICB8IDcxMiBNYml0cy9z
ZWMgIHwgfjIwJQ0KPj4+Pj4+IDEyOEIgICAgICAgICAgfCAxLjAwIEdiaXRzL3NlYyAgfCAxLjE4
IEdiaXRzL3NlYyB8IH4xOCUNCj4+Pj4+PiA0S0IgICAgICAgICAgIHwgMTcuNiBHYml0cy9zZWMg
IHwgMjIuNyBHYml0cy9zZWMgfCB+MjklDQo+Pj4+Pj4gDQo+Pj4+Pj4gTXVsdGlwbGUgU3RyZWFt
OiBpcGVyZiAtUCAxMg0KPj4+Pj4+IGlwZXJmIC1sIHNpemUgfCBCZWZvcmUgICAgICAgICAgfCBB
ZnRlciAgICAgICAgICB8IEluY3JlYXNlDQo+Pj4+Pj4gNjRCICAgICAgICAgICB8IDYuMzUgR2Jp
dHMvc2VjICB8IDcuNzggR2JpdHMvc2VjIHwgfjIzJQ0KPj4+Pj4+IDEyOEIgICAgICAgICAgfCAx
MC44IEdiaXRzL3NlYyAgfCAxNC4yIEdiaXRzL3NlYyB8IH4zMSUNCj4+Pj4+PiA0S0IgICAgICAg
ICAgIHwgMjMuNiBHYml0cy9zZWMgIHwgMjMuNiBHYml0cy9zZWMgfCAobGluZSBzcGVlZCkNCj4+
Pj4+PiANCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBKb24gS29obGVyIDxqb25AbnV0YW5peC5jb20+
DQo+Pj4+PiANCj4+Pj4+IEdyZWF0LCBidXQgSSB3b3VsZCBzdWdnZXN0IGhhdmluZyBhbiBvcHRp
b24uDQo+Pj4+PiANCj4+Pj4+IFNvIHdlIGNhbjoNCj4+Pj4+IA0KPj4+Pj4gMSkgZWFzZSB0aGUg
ZGVidWcgYW5kIGNvbXBhcmUNCj4+Pj4+IDIpIGVuYWJsZSB0aGlzIGJ5IGRlZmF1bHQgb25seSBm
b3IgOC4xLCBkaXNhYmxlIGl0IGZvciBwcmUgOC4xDQo+Pj4gDQo+Pj4gRmFpciBlbm91Z2gsIG9u
ZSBmYXZvciB0byBhc2sgdGhvdWdoIC0NCj4+PiBXb3VsZCB5b3UgYmUgYWJsZSB0byBwb2ludCBt
ZSB0byBhbiBleGlzdGluZyBvcHRpb24gbGlrZSB3aGF0IHlvdeKAmXJlDQo+Pj4gcHJvcG9zaW5n
IHNvIEkgY291bGQgbWFrZSBzdXJlIEnigJltIG9uIHRoZSBzYW1lIHBhZ2U/DQo+PiANCj4+IEZv
ciBleGFtcGxlLCB0aGUgdmhvc3Qgb3B0aW9uIGZvciB0YXAuIE1heWJlIHdlIGNhbiBoYXZlIGFu
IG5hcGkgb3B0aW9uLg0KDQpPSyB0aGFua3MsIEnigJlsbCBzZWUgd2hhdCBJIGNhbiBkbyB0aGVy
ZS4NCg0KPj4gDQo+Pj4gDQo+Pj4+IA0KPj4+PiBNb3JlIHRob3VnaHQsIGlmIHRoZSBwZXJmb3Jt
YW5jZSBib29zdCBvbmx5IGFmdGVyIGZiM2Y5MDM3NjllOCwgd2UNCj4+Pj4gcHJvYmFibHkgbmVl
ZCB0byBkaXNhYmxlIGl0IGJ5IGRlZmF1bHQgYW5kIGxldCB0aGUgbWdtdCBsYXllciB0bw0KPj4+
PiBlbmFibGUgaXQuDQo+Pj4+IA0KPj4+IA0KPj4+IEkgZm9jdXNlZCBteSB0ZXN0aW5nIHdpdGgg
dGhhdCBjb21taXQsIGJ1dCBJIGNvdWxkIHRha2UgaXQgb3V0IGFuZA0KPj4+IHdlIHN0aWxsIHNo
b3VsZCBnZXQgYmVuZWZpdC4gV291bGQgeW91IGxpa2UgbWUgdG8gcHJvZmlsZSB0aGF0IHRvIHZh
bGlkYXRlPw0KPj4+IA0KPj4gDQo+PiBPbmUgcHJvYmxlbSBpcyB0aGF0IE5BUEkgZm9yIFRBUCB3
YXMgb3JpZ2luYWxseSB1c2VkIGZvciBrZXJuZWwNCj4+IGhhcmRlbmluZy4gTG9va2luZyBhdCB0
aGUgaGlzdG9yeSwgaXQgaW50cm9kdWNlcyBhIGxvdCBvZiBidWdzLg0KPj4gDQo+PiBDb25zaWRl
cjoNCj4+IA0KPj4gMSkgaXQgaGFzIGJlZW4gbWVyZ2VkIGZvciBzZXZlcmFsIHllYXJzDQo+PiAy
KSB0YXAgaGFzIGJlZW4gd2lkZWx5IHVzZWQgZm9yIGEgbG9uZyB0aW1lIGFzIHdlbGwNCj4+IA0K
Pj4gSSB0aGluayBpdCB3b3VsZCBiZSBzdGlsbCBzYWZlIHRvIGtlZXAgdGhlIG9wdGlvbiBvZmYg
KGF0IGxlYXN0IGZvcg0KPj4gcHJlIDguMSBtYWNoaW5lcykuDQo+PiANCj4+PiBBc2tpbmcgYXMg
TkFQSSBzdXBwb3J0IGluIHR1bi5jIGhhcyBiZWVuIHRoZXJlIGZvciBhIHdoaWxlLCBndWVzc2lu
Zw0KPj4+IGF0IGZpcnN0IGdsYW5jZSB0aGF0IHRoZXJlIHdvdWxkIGJlIG5vbi16ZXJvIGdhaW5z
LCB3aXRoIGxpdHRsZSBkb3duc2lkZXMuDQo+Pj4gTG9va2luZyBhdCBnaXQgYmxhbWUsIHNlZW1z
IGFib3V0IH41LTYgeWVhcnMgb2Ygc3VwcG9ydC4NCj4+IA0KPj4gWWVzLg0KPj4gDQo+Pj4gDQo+
Pj4gQWxzbyBmb3IgcG9zdGVyaXR5LCB0aGF0IGNvbW1pdCBoYXMgYmVlbiBpbiBzaW5jZSA1LjE4
LCBzbyBhIGxpdHRsZSBvdmVyIDEgeWVhci4NCj4+IA0KPj4gVGhlbiBJIHRoaW5rIHdlIGNhbiBt
YWtlIGl0IGVuYWJsZWQgYnkgZGVmYXVsdCBmb3IgOC4xIGFuZCBzZWUuDQoNCk9LLCBJ4oCZbGwg
c2VlIHdoYXQgSSBjYW4gY29tZSB1cCB3aXRoLg0KDQo+IA0KPiBCdHcsIGl0IHdvdWxkIGJlIGJl
dHRlciBpZiB3ZSBjYW4gaGF2ZSBzb21lIFBQUyBiZW5jaG1hcmsgYXMgd2VsbC4NCj4gDQo+IFRo
YW5rcw0KDQpJcyB0aGVyZSBhIHNldCBvZiBzcGVjaWZpYyBiZW5jaG1hcmsocykgdGhhdCB5b3Ug
d2FudCB0byBzZWU/IENlcnRhaW4gcGFja2V0DQpzaXplcz8gVENQL1VEUD8gQ2VydGFpbiB0b29s
IChuZXRwZXJmLCBpcGVyZiwgZXRjKT8gVGhlIGV4aXN0aW5nIGJlbmNobWFya3MNCmluIHRoZSBj
b21taXQgbXNnIGhhdmUgYm90aCBzaW5nbGUgYW5kIG11bHRpIHN0cmVhbSBhbmQgbXVsdGlwbGUg
cGF5bG9hZA0Kc2l6ZXMsIGFsbCBvZiB3aGljaCBhcmUgYSBjb3JvbGxhcnkgdG8gUFBTLCBubz8N
Cg0KSGFwcHkgdG8gZG8gbW9yZSBwcm9maWxpbmcsIGp1c3Qgd2FudCB0byBtYWtlIHN1cmUgSSBn
ZXQgeW91IGV4YWN0bHkgd2hhdCB5b3UNCndhbnQuDQoNCj4gDQo+PiANCj4+IFRoYW5rcw0KPj4g
DQo+Pj4gDQo+Pj4+IFRoYW5rcw0KPj4+PiANCj4+Pj4+IA0KPj4+Pj4gVGhhbmtzDQo+Pj4+PiAN
Cj4+Pj4+IFRoYW5rcw0KPj4+Pj4gDQo+Pj4+Pj4gLS0tDQo+Pj4+Pj4gbmV0L3RhcC1saW51eC5j
IHwgNCArKysrDQo+Pj4+Pj4gbmV0L3RhcC1saW51eC5oIHwgMSArDQo+Pj4+Pj4gMiBmaWxlcyBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4+Pj4+PiANCj4+Pj4+PiBkaWZmIC0tZ2l0IGEvbmV0
L3RhcC1saW51eC5jIGIvbmV0L3RhcC1saW51eC5jDQo+Pj4+Pj4gaW5kZXggZjU0ZjMwOGQzNTku
LmZkOTRkZjE2NmUwIDEwMDY0NA0KPj4+Pj4+IC0tLSBhL25ldC90YXAtbGludXguYw0KPj4+Pj4+
ICsrKyBiL25ldC90YXAtbGludXguYw0KPj4+Pj4+IEBAIC02Miw2ICs2MiwxMCBAQCBpbnQgdGFw
X29wZW4oY2hhciAqaWZuYW1lLCBpbnQgaWZuYW1lX3NpemUsIGludCAqdm5ldF9oZHIsDQo+Pj4+
Pj4gICAgICAgIGlmci5pZnJfZmxhZ3MgfD0gSUZGX09ORV9RVUVVRTsNCj4+Pj4+PiAgICB9DQo+
Pj4+Pj4gDQo+Pj4+Pj4gKyAgICBpZiAoZmVhdHVyZXMgJiBJRkZfTkFQSSkgew0KPj4+Pj4+ICsg
ICAgICAgIGlmci5pZnJfZmxhZ3MgfD0gSUZGX05BUEk7DQo+Pj4+Pj4gKyAgICB9DQo+Pj4+Pj4g
Kw0KPj4+Pj4+ICAgIGlmICgqdm5ldF9oZHIpIHsNCj4+Pj4+PiAgICAgICAgaWYgKGZlYXR1cmVz
ICYgSUZGX1ZORVRfSERSKSB7DQo+Pj4+Pj4gICAgICAgICAgICAqdm5ldF9oZHIgPSAxOw0KPj4+
Pj4+IGRpZmYgLS1naXQgYS9uZXQvdGFwLWxpbnV4LmggYi9uZXQvdGFwLWxpbnV4LmgNCj4+Pj4+
PiBpbmRleCBiYmJiNjJjMmE3NS4uZjRkOGU1NTI3MGIgMTAwNjQ0DQo+Pj4+Pj4gLS0tIGEvbmV0
L3RhcC1saW51eC5oDQo+Pj4+Pj4gKysrIGIvbmV0L3RhcC1saW51eC5oDQo+Pj4+Pj4gQEAgLTM3
LDYgKzM3LDcgQEANCj4+Pj4+PiANCj4+Pj4+PiAvKiBUVU5TRVRJRkYgaWZyIGZsYWdzICovDQo+
Pj4+Pj4gI2RlZmluZSBJRkZfVEFQICAgICAgICAgIDB4MDAwMg0KPj4+Pj4+ICsjZGVmaW5lIElG
Rl9OQVBJICAgICAgICAgMHgwMDEwDQo+Pj4+Pj4gI2RlZmluZSBJRkZfTk9fUEkgICAgICAgIDB4
MTAwMA0KPj4+Pj4+ICNkZWZpbmUgSUZGX09ORV9RVUVVRSAgICAweDIwMDANCj4+Pj4+PiAjZGVm
aW5lIElGRl9WTkVUX0hEUiAgICAgMHg0MDAwDQo+Pj4+Pj4gLS0NCj4+Pj4+PiAyLjMwLjEgKEFw
cGxlIEdpdC0xMzApDQo+Pj4gDQo+IA0KDQo=

