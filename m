Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CF87BA633
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 18:32:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoRGP-0003u6-T6; Thu, 05 Oct 2023 12:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1qoRFK-0003gX-Hb
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 12:30:48 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1qoRFG-0007v5-Sj
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 12:30:42 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 395CC6rF024127; Thu, 5 Oct 2023 16:30:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=nhqRlRy6LNJXtWeCCsslGs2u3eYGADLSOUWf2B5zxBw=;
 b=hW2Efkh8+x3BYjdBupn8MbVGvZtkWX4YIjq3f5gpMJ0i/Se3Qce3P3cxIwzxguLqoWZP
 9yi6mhAXl7hYqqsomcZNr+HDgCqk5a9j+UB73BHSwZ73bRBrZuSvqsuTApFHaQqhonNO
 G11MQ1MAJv0WWSZ/DgXJnHA9SgbGNyj3CTWRYzD7yvGK8tVqVMgnW0Q5rORC+ERd/06d
 phuyNFsg2+g39vpNeLzMs06zW7QyOez6xunBlyqw4+f9w8dtogRUIxY/h/pgTl7CNzVE
 bl8GHsvUSF88Fu+yvS2cNTJzgYjfMv6RDqqf7d6+OKS/f6tQHYiBROt8pJ798/wFctD7 Yg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teaf4a1ek-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 05 Oct 2023 16:30:05 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 395GGQ3x002861; Thu, 5 Oct 2023 16:30:05 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3tea49ax4p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 05 Oct 2023 16:30:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdputYwebRgCoI7rY9axWB9Hmpuh9RH/KvvxZsLeUjg+ntG1B02C6PeSHZVkkoiRX4dH/nVTEd27kPRyb/v1ae6S8vyr+k/1+xMndvyuktnwJSpuBv2RXVQu98suUu8eWp1S0LszVWD1cdzRm/ayCx3AjGyUuNc4DAJfES4dVa5a4OSL+uMWdmE+H9zvM9AXD4aDxC+4xIZIbl9tbsWba97tSxhq1SlMjJD/+HUST40cDGGELfuEJy9xRXdQrioSYc9lrWeSjg0Z/83o0pwSerxx7N9k2FnO/NvsNzRjKE0FOl3eBVPIDwdzW2KK19ylarz30Lh5geakj9jRDzzwHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhqRlRy6LNJXtWeCCsslGs2u3eYGADLSOUWf2B5zxBw=;
 b=Ww1P9f3nmMfCEA7u/dVcfTlBQ0RsC4dzhQvb2TeaY9vsHRkRNY+gk9qbSFpcCJHjh/nGAxF58Tof6UC/7IRhaVQ8vvuJguq2hZdG/51wbNURDXdMy2f13xjqNF14hXEiZREfG3UUiRkoxnnCxqidX709iyDuaxpqVBnqppZxJO97GIs5RNTP5HBAJ8p9EJS2dwoT3b2Snd0h4+zY9ChAzBEEi/ngV3JSNkJQ8jf+y04XLA+fHAXdJcvUx7I4kkPjt7NCc9RuoaIMZNLRrTy2wVE9OrGPbIIz2WzCPgwpBqWNJgZnUpHYg4Rt9VkioHZd86QzaM6xHvU7MKv5yLTf/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhqRlRy6LNJXtWeCCsslGs2u3eYGADLSOUWf2B5zxBw=;
 b=rkQnUp3IDL1w54QmW/ak6syjI1sxXnJUclaafBh1fDz2j9+n2AnJHN5wmp+cV/33BgO2o7NesAQR8lz9BehcEcT2+mnxfNW7Y5fkWMUwdjKXnpImVmnY5UKa+8RnoKeqJ828UVHm+qcNbX3YydLxax0qHdx4ZMbeZEm1GQRi/w8=
Received: from MN2PR10MB4013.namprd10.prod.outlook.com (2603:10b6:208:185::25)
 by IA1PR10MB6784.namprd10.prod.outlook.com (2603:10b6:208:428::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Thu, 5 Oct
 2023 16:30:03 +0000
Received: from MN2PR10MB4013.namprd10.prod.outlook.com
 ([fe80::6639:fc37:2fe9:9955]) by MN2PR10MB4013.namprd10.prod.outlook.com
 ([fe80::6639:fc37:2fe9:9955%5]) with mapi id 15.20.6838.028; Thu, 5 Oct 2023
 16:30:03 +0000
From: Jag Raman <jag.raman@oracle.com>
To: Mattias Nissler <mnissler@rivosinc.com>
CC: QEMU Developers <qemu-devel@nongnu.org>, Elena Ufimtseva
 <elena.ufimtseva@oracle.com>, David Hildenbrand <david@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 "john.levon@nutanix.com" <john.levon@nutanix.com>, "peterx@redhat.com"
 <peterx@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v5 5/5] vfio-user: Fix config space access byte order
Thread-Topic: [PATCH v5 5/5] vfio-user: Fix config space access byte order
Thread-Index: AQHZ65lrDcR3C4Dh0E68oQuw796gkrA7eyIA
Date: Thu, 5 Oct 2023 16:30:02 +0000
Message-ID: <7041B00F-1F3D-4E65-B058-3D9739E58895@oracle.com>
References: <20230920080622.3600226-1-mnissler@rivosinc.com>
 <20230920080622.3600226-6-mnissler@rivosinc.com>
In-Reply-To: <20230920080622.3600226-6-mnissler@rivosinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR10MB4013:EE_|IA1PR10MB6784:EE_
x-ms-office365-filtering-correlation-id: dae5f8eb-bce8-4003-6367-08dbc5c0539b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3dRnZ4cwPZGu8MJgKl8plc4LTSLnEBBHBSPq2o3bA1S9WX5+aMvJ+pYtWIui4KpNj5yHL02FnGW5QRfsLQbbCBaew2sviUIEN+aDDLym+RClfkMiz0XjSaRg5nTd3u17URzcX9P3TxD/9vBA0IN5OwnfxN9LBc0gosybSlOxcGU85cDBLA3rDpHyP+BhLK8MolaP6DSLLSp650u+GgKqiPx/6qigu3rOF9Jig1kl0SRWQzVGnpVUrlOwY23Gt/K6F20WgTKKBQetChJHnV55xKH3GwIiuYremgcNypEIpOvipaZVrSowj+y0P6vAShw+ZzeGIYC2ZPjFkvwn11NjyTfTaX0k+05vC+jjQ2iVLmN9rHD9gEhh6PdlHOBwzA2wV0M6mFwtwHXdG+iFZ0pUceERi3LV6gz0znVuJR90tC3lbW2I0bpZhLdZbx66Yl75sTUobQyiqGkhkBDhdSyj+6arhBwm25bFuS/pARp9CvERDsXIlv4KT2Yet9zFrbWgdQ1+BwaVNmqznf+V6qOOAL6zM4i8gqBpqu8S3BHxxUkM5YwNPCEjlhz3r0mQ6fiP1v6CgC9uhNZviDCi5Do94FwJsJ21xvaT+8mhzUa8lR+0Euedv6IO9rULLBp5gM1uzZW6GveRRkNPoRfSCq0YNA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR10MB4013.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(39860400002)(376002)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(53546011)(71200400001)(6506007)(478600001)(6486002)(38100700002)(33656002)(38070700005)(122000001)(86362001)(2906002)(7416002)(8676002)(83380400001)(26005)(2616005)(6512007)(76116006)(36756003)(5660300002)(44832011)(66946007)(66446008)(64756008)(54906003)(41300700001)(66476007)(66556008)(4326008)(316002)(8936002)(6916009)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?t1/d4dYj/efWg2st7zLehulzbq/Np1ENBRjbTnF9zusLMBNbyUiikpXGjs?=
 =?iso-8859-1?Q?gMvTpHt16Z0xQ87Ga9TOKgPdCDRAVkyajg0mEe69v24yin2Z4ifSzeTxWW?=
 =?iso-8859-1?Q?nM4PEcvO+DBtX++phKUkYRoyTxxGl/jIxSJUkJ94miGQ7af9pMOcjBpNbF?=
 =?iso-8859-1?Q?7A4ITI4iy8ynl7ICbtFhKaPrq6lO1pXbQ8OTlHDBxBwzRpssRJSK9ghk0h?=
 =?iso-8859-1?Q?mXISTaBd8SH4YgHCAGsWBIOyQhI8KZsyK0X2njl+xkD+cO2MzSIpGEnmvJ?=
 =?iso-8859-1?Q?NfjlYTSRSk4Em7JPp4k1B/YGBXRc0uzAyaeWYKt9xUzTG2E0K+sEBP7gho?=
 =?iso-8859-1?Q?XKfI+IMaZw8oXBfVGjyRuIRrZyev3E09Cu00jeKc82L6li55EFobpiHq1A?=
 =?iso-8859-1?Q?816Z2TYAZB+n0CUpgIKLMq5tQFYnvINArEGwaMcIelLex5Hw5hYGtzEDPc?=
 =?iso-8859-1?Q?VBoMmyjRHO+Cre9JaI9I6gQQNXpNimSSfOcUZ1ZB8hYHFZp9v4MQtUUqHk?=
 =?iso-8859-1?Q?mbQSRlIWQnGpjSnKnvN4q77MEUu3nTvy1a8YmHk48sK/t4DR+ikUpvp52X?=
 =?iso-8859-1?Q?VYJ6I1Se/alLMGOS/uKX/9+dA/Dk6nNoTI2w9r9Ro0Ow9rHCxW/QDrmz9g?=
 =?iso-8859-1?Q?r9+hrF59ZXvDpgtFq9VIHngg3zH2oJ9TRHmFAmFTEOJaaa7wuwedytOjDf?=
 =?iso-8859-1?Q?i9XjdFQM6PDq+4COknZri9+Mlzl3rGz4QXTYH8WfGEZolN1EMZ/wnvuMx7?=
 =?iso-8859-1?Q?wFWWYG7vd3V6icFomhHf78QEILdGfXpVpn6fjVueGs9n0j7rWsHtDSo9JJ?=
 =?iso-8859-1?Q?T/QLdqJfZ2ruilGol8BSon6DUTJEfi3arOQlLXoZI2HZzMv0aGbAzQLR8r?=
 =?iso-8859-1?Q?+4SFhyLsqCwWbKKS1tkg7jzHAaWrw/pin2wBqdEpnjG+8vL7Q1ATjOPLV5?=
 =?iso-8859-1?Q?Edl4f6oks+zUFxAwr9vGumBHzzF1aYkA+kwpyXFKlQLyEzqGwWIeSXsLgy?=
 =?iso-8859-1?Q?WSfWnD43wNPfhAWNckH326Kwk2PlVNEfZsOFHX7L09iaT4QmpnPYbutaxZ?=
 =?iso-8859-1?Q?qDJ4ICmsC7vIvBKEPPiGaeivMXc64TBP9javRNTSRVBew94XqQJKGAat8p?=
 =?iso-8859-1?Q?mXqRYgm7p3i+aW29f+C6VOtaILQ3nJ+CuMG8Rwisqi9GqmGMvkizRblJ4r?=
 =?iso-8859-1?Q?+4Ko5GOKD0N8xrvxzHel90CNXx/bygsoTZBmgsXOLfe03NTmjRruA/EDJD?=
 =?iso-8859-1?Q?+g2TtH9v7IuzHmOQTjlUDW1BexAFNqLO5uCtigZA1NxtnlW8zMK1xVqXMD?=
 =?iso-8859-1?Q?yKN1TNCUzE02kQdSnVKKbFA9MTMpSuZSRT93ItDE9lvhGpFcsyN2FhLkQh?=
 =?iso-8859-1?Q?AxC95vOpYDkvRFZLK61Ri2hyRAlU8VHWhVNoyf5Lkf4j+0y5y5eKfrf06L?=
 =?iso-8859-1?Q?EzyIQLiZy5G4llJJpMmMjnLQO8iKjVzW9YvxBwtSmqvpJ4ME4LuAOGqpRV?=
 =?iso-8859-1?Q?hk3NJ9whhdq4xWw6pgnGA69MHo2n0QokuUsgu5jf2Hna5EAYeQJ5ZLJRPy?=
 =?iso-8859-1?Q?6ULbC1gxZFK/b5AsuB7G89mmfuz/i4pjZ39DRuv1YwsyaqneTDy3Lh0Wvl?=
 =?iso-8859-1?Q?e7MsO8K2i5MjPTiQ9z8l5GK679Fia+QNMg?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <FCEFBAA1C35DE543BDF986C555905FBF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aKS9H3K4zA8BVEDT+5vMWHrCQeO2mrch3AiRs3ovIpB054kJYkIBVvA2RwdBHOjClTbTcOzAIKHv4oMvF+Q+2zfhAvGuur/6cjDP+6qxMImTkskonkaI09OclDhsGi47YaFAeBu0+DKhu4MVexi/rYD+az1XTxalABRCwW5CmoMrwx9YQFj8gzHvfdwzLYhHl9lqdLnXUIIAxehhWOmgHkM1Ei0c/DypA5Q4NHBbxJNXOoHRInCQMkZe1ba+FUC/cDqo++VIx2MIlMdSWK7tW7iXfMlOBHxeZM0yPkvgSxdRFgKtdajfYfYZJstxmXxubtII058S2sWrW11jtOhHyrqr85fcUIvUn+I5nciuiFSspijYi6j5/GGkNCGxsrgdQrihVvC4D72Eq5S7owKoz+ulI/SNLukqrhutMRrNYHGIVIOzLbYm9FLeno62rZHWU7zOb1YI6ZPsOECY9Ipj+yCM4yOSY0s1hr0zf7qw7m14smLAel+BN63rHbW6RVdd5i4YmLTEV/tl3p5IXLjpvQ1hWBNy3BfguGXEpAW/JCSN5ssb3jfDDrEM6fodGPXmDUuOo0fnzJhxr9K9bSySYlEOmAQYN+OJjDeuX++42Ssd3Z8/gd8nwVQ29vR/0T6wBeMwicshCo5qNm0sEyrXHSdnb/5VZVTqAskHT6FuuD+ph15Noci5aNr/sj9XuDIcfGFU7DouSs6IzBhcaJr9ycG5LhC/OZrLHce1pvNv84tbrHTH1g2Hj1dhKzMZyN+ypUOWq7JgLu8nsjj1pk/kudOqrcXc+aOd09GAAymPahzEpk+jhCM6Vz49uGkzngxEVpY5Ly/dQF8mkCnwev3F6Qa7+DV9fz7f1o2KE7RyZPJU0/CTvXFvLDOMAiBmoatjC8ATXoq7FjkRHGKjuqaNZQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4013.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dae5f8eb-bce8-4003-6367-08dbc5c0539b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 16:30:02.9966 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gH61UXXOnEN7X6/YHBUwZVkRwqWBCpsILL95O5BZ4ziTk392sGqC+HBg+96U4PlG63XaOJ4Ep0DU4S12DEq5MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6784
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_12,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310050129
X-Proofpoint-GUID: nCSEbkuI86cdg3TE2-eCtF9WcWtt5Olb
X-Proofpoint-ORIG-GUID: nCSEbkuI86cdg3TE2-eCtF9WcWtt5Olb
Received-SPF: pass client-ip=205.220.177.32; envelope-from=jag.raman@oracle.com;
 helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On Sep 20, 2023, at 4:06 AM, Mattias Nissler <mnissler@rivosinc.com> wrot=
e:
>=20
> PCI config space is little-endian, so on a big-endian host we need to
> perform byte swaps for values as they are passed to and received from
> the generic PCI config space access machinery.
>=20
> Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> ---
> hw/remote/vfio-user-obj.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
> index 6a561f7969..6043a91b11 100644
> --- a/hw/remote/vfio-user-obj.c
> +++ b/hw/remote/vfio-user-obj.c
> @@ -281,7 +281,7 @@ static ssize_t vfu_object_cfg_access(vfu_ctx_t *vfu_c=
tx, char * const buf,
>     while (bytes > 0) {
>         len =3D (bytes > pci_access_width) ? pci_access_width : bytes;
>         if (is_write) {
> -            memcpy(&val, ptr, len);
> +            val =3D ldn_le_p(ptr, len);
>             pci_host_config_write_common(o->pci_dev, offset,
>                                          pci_config_size(o->pci_dev),
>                                          val, len);
> @@ -289,7 +289,7 @@ static ssize_t vfu_object_cfg_access(vfu_ctx_t *vfu_c=
tx, char * const buf,
>         } else {
>             val =3D pci_host_config_read_common(o->pci_dev, offset,
>                                               pci_config_size(o->pci_dev)=
, len);
> -            memcpy(ptr, &val, len);
> +            stn_le_p(ptr, len, val);
>             trace_vfu_cfg_read(offset, val);
>         }
>         offset +=3D len;
> --=20
> 2.34.1
>=20

Hey,

When you tested on s390x, could you see the correct values for the config s=
pace in the Kernel? For example, were any known device's vendor and device =
IDs valid?

I'm asking because flatview_read_continue() / flatview_write_continue() doe=
s endianness adjustment. So, I want to confirm that the endianness adjustme=
nt in your code also makes sense from Kernel's perspective.

I'm trying to access a big-endian system, but no luck.

#0  0x0000555555b97a30 in vfio_user_io_region_read (vbasedev=3D0x555557802c=
80, index=3D7 '\a', off=3D4, size=3D2, data=3D0x7fff6cfb945c) at ../hw/vfio=
/user.c:1985
#1  0x0000555555b8dcfb in vfio_pci_read_config (pdev=3D0x555557802250, addr=
=3D4, len=3D2) at ../hw/vfio/pci.c:1202
#2  0x000055555599d3f9 in pci_host_config_read_common (pci_dev=3D0x55555780=
2250, addr=3Daddr@entry=3D4, limit=3D<optimized out>, limit@entry=3D256, le=
n=3Dlen@entry=3D2) at ../hw/pci/pci_host.c:107
#3  0x000055555599d74a in pci_data_read (s=3D<optimized out>, addr=3D214749=
3892, len=3D2) at ../hw/pci/pci_host.c:143
#4  0x000055555599d84f in pci_host_data_read (opaque=3D<optimized out>, add=
r=3D<optimized out>, len=3D<optimized out>) at ../hw/pci/pci_host.c:188
#5  0x0000555555bc3c4d in memory_region_read_accessor (mr=3Dmr@entry=3D0x55=
55569de370, addr=3D0, value=3Dvalue@entry=3D0x7fff6cfb9710, size=3Dsize@ent=
ry=3D2, shift=3D0, mask=3Dmask@entry=3D65535, attrs=3D...) at ../softmmu/me=
mory.c:441
#6  0x0000555555bc3fce in access_with_adjusted_size (addr=3Daddr@entry=3D0,=
 value=3Dvalue@entry=3D0x7fff6cfb9710, size=3Dsize@entry=3D2, access_size_m=
in=3D<optimized out>, access_size_max=3D<optimized out>, access_fn=3D0x5555=
55bc3c10 <memory_region_read_accessor>, mr=3D0x5555569de370, attrs=3D...) a=
t ../softmmu/memory.c:569
#7  0x0000555555bc41a1 in memory_region_dispatch_read1 (attrs=3D..., size=
=3D2, pval=3D0x7fff6cfb9710, addr=3D<optimized out>, mr=3D<optimized out>) =
at ../softmmu/memory.c:1443
#8  0x0000555555bc41a1 in memory_region_dispatch_read (mr=3Dmr@entry=3D0x55=
55569de370, addr=3D<optimized out>, pval=3Dpval@entry=3D0x7fff6cfb9710, op=
=3DMO_16, attrs=3Dattrs@entry=3D...) at ../softmmu/memory.c:1476
#9  0x0000555555bce13b in flatview_read_continue (fv=3Dfv@entry=3D0x7fff686=
1e120, addr=3Daddr@entry=3D3324, attrs=3D..., ptr=3Dptr@entry=3D0x7ffff7fdf=
000, len=3Dlen@entry=3D2, addr1=3D<optimized out>, l=3D<optimized out>, mr=
=3D0x5555569de370) at /home/github/oracle/qemu/include/qemu/host-utils.h:21=
9
#10 0x0000555555bce2f7 in flatview_read (fv=3D0x7fff6861e120, addr=3Daddr@e=
ntry=3D3324, attrs=3Dattrs@entry=3D..., buf=3Dbuf@entry=3D0x7ffff7fdf000, l=
en=3Dlen@entry=3D2) at ../softmmu/physmem.c:2762
#11 0x0000555555bce448 in address_space_read_full (as=3D0x555556671620 <add=
ress_space_io>, addr=3D3324, attrs=3D..., buf=3D0x7ffff7fdf000, len=3D2) at=
 ../softmmu/physmem.c:2775
#12 0x0000555555bce595 in address_space_rw (as=3Das@entry=3D0x555556671620 =
<address_space_io>, addr=3Daddr@entry=3D3324, attrs=3D..., attrs@entry=3D..=
., buf=3D<optimized out>, len=3Dlen@entry=3D2, is_write=3Dis_write@entry=3D=
false) at ../softmmu/physmem.c:2803
#13 0x0000555555c1973f in kvm_handle_io (count=3D1, size=3D2, direction=3D<=
optimized out>, data=3D<optimized out>, attrs=3D..., port=3D3324) at ../acc=
el/kvm/kvm-all.c:2778
#14 0x0000555555c1973f in kvm_cpu_exec (cpu=3Dcpu@entry=3D0x5555569ab390) a=
t ../accel/kvm/kvm-all.c:3029
#15 0x0000555555c1a8dd in kvm_vcpu_thread_fn (arg=3Darg@entry=3D0x5555569ab=
390) at ../accel/kvm/kvm-accel-ops.c:51
#16 0x0000555555d8f4fb in qemu_thread_start (args=3D<optimized out>) at ../=
util/qemu-thread-posix.c:541
#17 0x00007ffff577dea5 in start_thread () at /lib64/libpthread.so.0
#18 0x00007ffff54a6b0d in clone () at /lib64/libc.so.6

FYI, the above is the stack trace from the client. vfio_user_io_region_read=
() in the above sends a message to the server, and the server ends up calli=
ng either vfu_object_cfg_access() or vfu_object_bar_rw()  (which also does =
the endianness correction) depending on the region.

--
Jag


