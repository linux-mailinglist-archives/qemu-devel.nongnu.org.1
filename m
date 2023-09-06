Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96351793733
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 10:34:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdny3-0006aN-Cl; Wed, 06 Sep 2023 04:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1qdnxh-0006X1-2T
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 04:32:35 -0400
Received: from mr85p00im-zteg06022001.me.com ([17.58.23.193])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1qdnxe-0005VE-6c
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 04:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1693989148; bh=VOFq+vVyAOovci1ZmNNkoJS9P9MFdkfhFZiOKEZ40T8=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
 b=JZOCQU5rKge4nt5Guw15DW7FZzsURzzodKjG34BnQiio9mJU7gmlGz/VR5I6EQL5j
 mafIrI61TNEIQFAutY5v1XbQwVdHhD9KEuaIXCWYZly59q+PD073Sv+9T/WwcTJtsG
 u954s13YZsP/EbBs2Eb5eULgOBsTU9wpRMBXjqLQsrReFcBKfjnget31OGB6NY5WBb
 LVPHK+lJKYI2zD54W6XYngbDMzikZcH7mUXMXxXtXaprocRma9voJ9aHCUkdQJ1NEt
 hIexDq7VPdeU8LzJ8cmFVOUdfwUQOgq7kSYFwEARVL7AW/DUOmTAIlgXAS3ZZeFe0u
 GWDU34ylxmorg==
Received: from smtpclient.apple (mr38p00im-dlb-asmtp-mailmevip.me.com
 [17.57.152.18])
 by mr85p00im-zteg06022001.me.com (Postfix) with ESMTPSA id 4532180025E;
 Wed,  6 Sep 2023 08:32:26 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH v4 12/14] simpletrace: added simplified Analyzer2 class
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <ZPciRnEvDK0IPNEA@redhat.com>
Date: Wed, 6 Sep 2023 10:32:14 +0200
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7DC8DA17-6848-4981-B576-A13025E1BB21@ynddal.dk>
References: <20230823085429.20519-1-mads@ynddal.dk>
 <20230823085429.20519-13-mads@ynddal.dk> <ZPciRnEvDK0IPNEA@redhat.com>
To: =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
X-Mailer: Apple Mail (2.3731.600.7)
X-Proofpoint-ORIG-GUID: 0pomGxd1SljNCZBpwljTJRbgvqUMFX1w
X-Proofpoint-GUID: 0pomGxd1SljNCZBpwljTJRbgvqUMFX1w
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.816,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-18=5F01:2020-02-14=5F02,2022-01-18=5F01,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 mlxlogscore=934 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2309060070
Received-SPF: pass client-ip=17.58.23.193; envelope-from=mads@ynddal.dk;
 helo=mr85p00im-zteg06022001.me.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


> AFAIK, we don't consider simpletrace.py python code to be a
> supported public API, just a command line tool.
>=20
> IOW, we can change the python code at will, as long as the
> command line doesn't alter its behaviour. Thus I don't see
> a need to add new classes, just change the existing ones.
>=20
>=20
> With regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    =
https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            =
https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    =
https://www.instagram.com/dberrange :|
>=20

This was based on feedback from Stefan in v2. I don't have strong =
opinions
about the one or the other. But now that the work has already been done,
I'd think the easiest would be to follow-through on the two versions.

https://lore.kernel.org/qemu-devel/20230504180326.GB581920@fedora/=

