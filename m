Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 007A87B7F80
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:43:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo1CZ-0008RV-FC; Wed, 04 Oct 2023 08:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1qo1CV-0008Ky-IZ
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:42:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1qo1CS-0004kf-53
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:42:03 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3947AsRq012110; Wed, 4 Oct 2023 12:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=qnEZXwApC8rC3HzGX28N3DwkAGWP0kZQI/tRLI0zOas=;
 b=Gf7e6sBYCl0pHtsboTJbGxEfD7bXRrV7VzCgxqXvxl1d1N5dzpSJW1tl9zVMMupEQe1k
 hG1/S3aFaXPAyA5O1NkVBVUQUMRfdjDwfg3OKpCL1Rrec1Gg7i3T/MWA3pVAPNYdqvqj
 W0U69Vpf4J5CVtGtYpIt+562dpwfJbdeUKA/f3yW3V/kIyDYu2CZQ0UqCfDbo4kK2viL
 dQg5K3MC3km8KfIeZu66JPGswficezJXB4Acxt/aD5MfyJKwLxrGQwUoRUhOBIN/Y2jr
 1kwLbFsSNQ9ibk4bBOCOIhfIfcvF5Cobj+/Xy/50yn7iih1GJvaZdO4VxWK3p/4BTaFR LQ== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tgynh954v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 12:41:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3fEdQgB93+nhyhBj4wkc1yHdo6PCY0VhqToJXubqhMWHEZFSFN6scJSuXMRletXwVghUFbZOISCM4+DuhxrMPyQRfojJ3OLYLk/gv37ad3BoTe30GEuPzfIUPju658U12LImhioJDDffwEhiwwRKeh7D+wfiVBmim8rFQg7lLZBjTY99o/IJhaCJSWCQAsNjlgLKFI3/m1BmFRn2f8Pu8l+xXSfBaktXR7CdcAxW3NipR4tbqIq7f1SN7qx0TqIWNY36pxZTcL5OKm26kd/VYVlT3Vdj49PBycktqYExmvfqHqUclmqf/w593j5xIv+6iFMBwIEEf+dqPLct6dqsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnEZXwApC8rC3HzGX28N3DwkAGWP0kZQI/tRLI0zOas=;
 b=jrTsWNBx4uNFNfQvm12rwMPsnOP60iBiFtCqKtmUknKwl3B+3IEO15dFavJN3TwL7IIKwsYAxaRyiiJp/ztDJAGjzJwyaBn6EWugPm4zMAUH/YSnVwNOw/cR1IEbZ9obXd9BkuRrtl5YWCL6u7XyQItuSRcq5Hk3qqSlpcaarTC77T9y0lbV2lDef+HUWMjvdSd8eMmmrTABvKVdLGzsLDhW9TzwYCVQIAK3byD+zUvMdV+02HQ64ni7XGrl1vXULDL2gV5vnYZ4BG2k5TfUY6stPCI4SYdv1BnMhSeAkWfBCt5J16EQDJKhJSDuwcZYTH89TAlTQ6NK84Ks6WBc0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4205.namprd02.prod.outlook.com (2603:10b6:805:35::17)
 by DS0PR02MB9355.namprd02.prod.outlook.com (2603:10b6:8:150::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Wed, 4 Oct
 2023 12:41:47 +0000
Received: from SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::4e82:c5b1:f941:be35]) by SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::4e82:c5b1:f941:be35%6]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 12:41:47 +0000
From: Brian Cain <bcain@quicinc.com>
To: Markus Armbruster <armbru@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "Matheus Bernardino (QUIC)"
 <quic_mathbern@quicinc.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "ale@rev.ng" <ale@rev.ng>,
 "anjo@rev.ng" <anjo@rev.ng>, "Marco Liebel (QUIC)"
 <quic_mliebel@quicinc.com>, "ltaylorsimpson@gmail.com"
 <ltaylorsimpson@gmail.com>
Subject: RE: [PULL 0/2] hex queue
Thread-Topic: [PULL 0/2] hex queue
Thread-Index: AQHZ9lx7Jq8mlfoNdk2ypDLZR94cErA5PtNUgABUWYA=
Date: Wed, 4 Oct 2023 12:41:46 +0000
Message-ID: <SN6PR02MB4205C95307F85E2DA102EB24B8CBA@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <20231004004806.1461248-1-bcain@quicinc.com>
 <87mswyltwl.fsf@pond.sub.org>
In-Reply-To: <87mswyltwl.fsf@pond.sub.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4205:EE_|DS0PR02MB9355:EE_
x-ms-office365-filtering-correlation-id: 827d00ee-70ea-4614-7ec3-08dbc4d745be
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RoUg67IAZZ+lglNOS2+9o17TDrYGNRB318EIVnFJOlrmPi3nOqOSxOct2Lbo6BQriPQXHagH28UdsPcTUmQUpOZNDaxfJZL9QPIoeBOGNwEPAKbp+ypl3XT4SNy+TfPN7jZxhNYlGxQ87a3KPhve6etzkzchLv/FS1eDo/y6/trNxs88j4DOaxiqBcwhxciD4plYTVNcBx+zXUjjbBFt3XrsweiTXaqAbkovaceoALUVDaflmPaPuiWigirCt9WBbZGEv6K+8Y6a6K7+R44CbXJetl7ge5OHv4uKpaiQ3eC6IxUHrrReR34U1oejKe2DYE+VK4p9831wHb3WkTghwZQsiK/592UeiqPFIxtyQQKxLq6J5YnehL37gEC0HPLpLDCzipXy75t+xKgfx2VFDOelIc3EZoqxY9LrqB/Hg9soLyQCLloI5mQG5NuWi1U6XEjvbvLSjf60lzmk2bUhAQICnhMoqf5DQ6if2DZUzUpqEivKbQWZE62L+Z1+RAiqybOMlZRZ0o7vrYd5tIVSI5BbokxY9n41Mz1aoFwyCoSYKdnG7wTwhIWCGH1+pa51UosFhoQbjvoyZ2iFs+1site2oEMo1b+bNEvqKQaYAdRSMfw988uoEDfZBlzc3az+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR02MB4205.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(346002)(366004)(136003)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(7696005)(9686003)(2906002)(8676002)(8936002)(316002)(5660300002)(4326008)(55016003)(33656002)(4744005)(76116006)(41300700001)(52536014)(53546011)(66446008)(71200400001)(86362001)(54906003)(38100700002)(66946007)(6506007)(64756008)(66556008)(6916009)(26005)(66476007)(38070700005)(83380400001)(478600001)(122000001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jYywYT04VPd4qGU/ycL2+ZQn2AN+KaYxvh7zetssxZ5Kymt9tzwgvNg9Xc4H?=
 =?us-ascii?Q?oGzR5rlXDxCHlFZwYDgmcmSrL1dokzS2ytxF4q69MaZ5DbvqknDfURpWA2SF?=
 =?us-ascii?Q?5ZEpk4HY80AfqUFs+bklccW9HdFoZpBfKzCA1W7V0YU6kXBUKFIl5nJOA61h?=
 =?us-ascii?Q?9/h2p1Q7O9GAt5+XE1AiJjceQE513cCtJG4f/mvAKO6asH5c5j+vLG5o1OQs?=
 =?us-ascii?Q?2TPvRHDE6fuPct1N9PGTBIJ93TTJ/XxYIv4pqyl5RhUQ5SrJ5HF4VksGxRLk?=
 =?us-ascii?Q?MaR/FrvWhYMixLkWd6k+d6wUoqoS8Z0xxveq1nYa+zzgGzHeg2IVJlpuJjvK?=
 =?us-ascii?Q?tJEni+Ch4PulagNGXuS7EUq55L9q2ozOy/Ujnv4yXPme3Pf8nLlZDzJzqKT9?=
 =?us-ascii?Q?f4YDB2QuODc3gMsqJOX/mIa9oULyNoUlZR1PZcwK1OjXyj8elqUFA+x2DSQF?=
 =?us-ascii?Q?YkhHK2d1SHXYvm+QdsBa0riB9+IVib+9XYiY/OMxDb0tdOYuYMtmysf2cyu3?=
 =?us-ascii?Q?OWzUlJqG5KNVtgMjYM6R+91dSkMjkMFXYRQ+tQ2JU74ovOHWeabgZ5xer5FB?=
 =?us-ascii?Q?wUHD4nUa3jgmPYZaBXSge2RdwWi5AejnIgXwAEK8IOGwqwLfCPGq+1bopotg?=
 =?us-ascii?Q?A5oTdwGnmlyJsTUgq2Yb3V9CLxqXcQJ7aaeSWFLvxR/IzyHdDJ0BA90VDffP?=
 =?us-ascii?Q?b2GeWEp/K0hqVyKYPOv1rxE1c50HhuGcis+UlYZFqEOZ+licGYlVVdGSVT04?=
 =?us-ascii?Q?61YEI30qH4mbHu08ENL52s+eroOj1WoR6n5lx8Mu7QbBckzDc635aZD6xSIP?=
 =?us-ascii?Q?H3KppuRetiDZ30dZcHOyH46T7ue/wnYwIwMvcJ+fEKyEvr2X1/UVglZFZhp9?=
 =?us-ascii?Q?jPmY9G8xh6zHAN9U0/Vp9Od6z8pO9YL5b2jXUFskXXxh+ZdkKBFtPoU5GrHs?=
 =?us-ascii?Q?TwBxQOj8P2V2gWadNzHl29Dv7JzUQIL1FmNSOdeLxhxs3q4MnKcp2PlEdqLt?=
 =?us-ascii?Q?0rZiozTJ/ust3YaWp5sQUFL9P6eqJ2Tuj56scrElnkl6+nlvOS2GnUaAbOnJ?=
 =?us-ascii?Q?3E6rkWXCPXZNgC/P/vX13BVK+YtDN9uWK1qzsMtnarPRbQj0ZUp41vVV5afM?=
 =?us-ascii?Q?o11hSLEdMvfi86bLo6QWyJP5LGEabdLl9eBZDon0eFS68ScXV7fB1XGUqDtG?=
 =?us-ascii?Q?5SfAtKXqOmpamnN/+/VAOBoE7qavtJhn3IFgYW4lC6aat3mpP+EzJPSuBwv1?=
 =?us-ascii?Q?QmIDE/m4YYY4Clt1RjtkcwWrbkTWFXsXUxB5ERJ9m+5evBjEUOYPgrS+frz0?=
 =?us-ascii?Q?Q/fK/gSZ8zofgKoVPqu6k5rhRT8GSmM5bVx0DxfwxRgJhyk0WqzaS/tgN/OC?=
 =?us-ascii?Q?U+69mENEPZDGvIE8D6a4W4Aeot9z1Ak64CLsemyBh8dMROHV1X5klG3UwOme?=
 =?us-ascii?Q?AM9yKXrjWmPqM6UzbwvJ5TuyizGKGFFOO10nPgrziyZQnOziqXF4rFP6bZxo?=
 =?us-ascii?Q?olpUocIpH7NXwk3yc0SQX05f+w7DJ7caNDb1s2STdVoM0yaSpSL8VzRdUGte?=
 =?us-ascii?Q?HnZNJ6AhL/VYWPxdn+NrVykFswnrTDoCFGj9abHM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2T7sz3wWNk71htR5WnHFKZd/4KvPt1OUcXBGkEVCUYKNHmpHq9apFZaTPH3usGe25RjkW0XbsKanGVBK0x4yZm0yeNOJ0WcsWgq4fmnMCFyA7ovG6/4cPz9pes1TykL/kXb5Ewsjsi7tFw2EUuAy4sHikMi8eJCOJVV6lqRnynxWwp3lVO/3K+F5vkaimTwq9HyRqsoTHXdfWGm2ZGc5g4Wz1JXAMyxtkvIRa+7zIMPOxms9xsnaw1Pli2kv/y/4/N+A4aQ1xixi9fU+et9OT3u2xDcVTFzcr+PsPS/njQ2SJ4M7VJeY3s1E7qTGsbG1o84ZkeEwIYQOxBHzE36UkPL/Kfk0ipjbl8Xzqn1HWJlnRUxn1PYnJ2szwLnLV/UJC5X/JgGAK9A0eAhfKLadp+KB1dxD3NrAs0VLVdzr5Fgq7QBA820LiggPQ2PTJXqcyGmwrjTI0u99FLxvSOmNtbYTp8vHhivhG5k/WJb6uRE+sd9iYvUPXX8T13ZgxQeYFL6rBRy3vvnKDqaWeRZRwJXqS9S6Dse2Z6xjHbKnBdYSmEg2h0PlyPG7n6twQFPR8slINdoWXNhCmxufO4j61DqP63GHFB6g0wJkvWsq3QIZM5YoS8i8n3mPvAwKipQgfB/248LeUGGpjA44mnxehZN5vQpHiCAnxcEf7lxU0y4QHPpcjjoQyRFl227pPKg4mR01Tp57FxPgoPk2GUx3wYNxRFcBmFOEkBa2LsNsTanrfwm3P69Kh28G3QE7jVSGlMLxQkoufO10TRkJ9j2NtZQkBXwz0Zi6ZEyQtkIIL+O5cY0qAsfuL0D7W6P2x6+t3caFl2iFvaDQse/iqZnY4zHj3tATWoiSHZ0I7Gpx/d+FKfwOxx6kCE+LD+Oj/AVv
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4205.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 827d00ee-70ea-4614-7ec3-08dbc4d745be
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 12:41:46.9858 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +37wJLlxH0daiKcsEgzn29THH7lBfj/9DImwkMi+HlxAsrk3Ly9yT2Xt5hB6JwcnHJYTe0t2ty/S1XWD6VXFeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9355
X-Proofpoint-GUID: yA8sGZcZMWEjXlxLJujwzGvPcz0UOibn
X-Proofpoint-ORIG-GUID: yA8sGZcZMWEjXlxLJujwzGvPcz0UOibn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_04,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=439 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040092
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



> -----Original Message-----
> From: Markus Armbruster <armbru@redhat.com>
> Sent: Wednesday, October 4, 2023 2:38 AM
> To: Brian Cain <bcain@quicinc.com>
> Cc: qemu-devel@nongnu.org; richard.henderson@linaro.org;
> philmd@linaro.org; peter.maydell@linaro.org; Matheus Bernardino (QUIC)
> <quic_mathbern@quicinc.com>; stefanha@redhat.com; ale@rev.ng;
> anjo@rev.ng; Marco Liebel (QUIC) <quic_mliebel@quicinc.com>;
> ltaylorsimpson@gmail.com
> Subject: Re: [PULL 0/2] hex queue
>=20
> WARNING: This email originated from outside of Qualcomm. Please be wary o=
f
> any links or attachments, and do not enable macros.
>=20
> Looks like these patches haven't been posted to the list for (public)
> review.  Needs to happen before a pull request.

I'm sorry -- that was careless.  Matheus' patch had been but mine had not.

I've sent Matheus and my patches to the list for review only just now.

-Brian

