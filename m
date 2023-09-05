Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D35AC7921F6
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 12:47:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdTac-0007Eq-Dc; Tue, 05 Sep 2023 06:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1qdTaG-00079G-6R
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 06:47:05 -0400
Received: from ms11p00im-qufo17282001.me.com ([17.58.38.57])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1qdTaA-0005IT-05
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 06:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1693910810; bh=NAnQzMFdGNa/+GlIQux0X5+78jPdAA+TnTYtaHb4MCc=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
 b=M25eNrYB53DtMk6mt4faLWdYKqHKGeNXUnNITbYVk6Czp/TbKpGjf78EAPUmwjZbS
 KbeZDFnFiH6f2khkIfoU4WT5Z71W9RehtY5p/0wxLoMZW3zeMXbuxZWN3kmxwMM4wi
 HIZG0pbicDeo6ULFcfkc/v0ABqUBlnq15JaCHZ6NQhlbxe6glpBaja9rBjELt1uEGZ
 44KxNBD7JSjV1+tXHeRKmznSf26jf+CK+mBWIRCjvUwWQToQXw2d4XcYT9GQpQ1oKa
 wyDWetLWpt8GesOXMdQFXJOEroV/hwGCSBzkIG0ZegFJwhVeUqL0aZ/Km1TwJHMDJ+
 3BJm7FluhEqig==
Received: from smtpclient.apple (ms11p00im-dlb-asmtpmailmevip.me.com
 [17.57.154.19])
 by ms11p00im-qufo17282001.me.com (Postfix) with ESMTPSA id 150DA1E00EB;
 Tue,  5 Sep 2023 10:46:48 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH v4 00/14] simpletrace: refactor and general improvements
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20230823085429.20519-1-mads@ynddal.dk>
Date: Tue, 5 Sep 2023 12:46:36 +0200
Cc: qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CC2B194B-06EE-42A1-B0CB-0AF72652EC8D@ynddal.dk>
References: <CGME20230823085439eucas1p2d351b168833b9206cee2bbc8af9df1ac@eucas1p2.samsung.com>
 <20230823085429.20519-1-mads@ynddal.dk>
To: John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
X-Mailer: Apple Mail (2.3731.600.7)
X-Proofpoint-GUID: IdF7sxMv59fu7c0Kny-ybTGGDsobjkhO
X-Proofpoint-ORIG-GUID: IdF7sxMv59fu7c0Kny-ybTGGDsobjkhO
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 clxscore=1030
 mlxlogscore=552 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2309050096
Received-SPF: pass client-ip=17.58.38.57; envelope-from=mads@ynddal.dk;
 helo=ms11p00im-qufo17282001.me.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


> On 23 Aug 2023, at 10.54, Mads Ynddal <mads@ynddal.dk> wrote:
>=20
> From: Mads Ynddal <m.ynddal@samsung.com>
>=20
> I wanted to use simpletrace.py for an internal project, so I tried to =
update
> and polish the code. Some of the commits resolve specific issues, =
while some
> are more subjective.
>=20
> I've tried to divide it into commits so we can discuss the
> individual changes, and I'm ready to pull things out, if it isn't =
needed.
>=20
> v4:
> * Added missing Analyzer2 to __all__
> * Rebased with master
> v3:
> * Added __all__ with public interface
> * Added comment about magic numbers and structs from Stefan Hajnoczi
> * Reintroduced old interface for process, run and Analyzer
> * Added comment about Python 3.6 in ref. to getfullargspec
> * process now accepts events as file-like objects
> * Updated context-manager code for Analyzer
> * Moved logic of event processing to Analyzer class
> * Moved logic of process into _process function
> * Added new Analyzer2 class with kwarg event-processing
> * Reverted changes to process-call in =
scripts/analyse-locks-simpletrace.py
> v2:
> * Added myself as maintainer of simpletrace.py
> * Improve docstring on `process`
> * Changed call to `process` in scripts/analyse-locks-simpletrace.py to =
reflect new argument types
> * Replaced `iteritems()` with `items()` in =
scripts/analyse-locks-simpletrace.py to support Python 3
>=20
> Mads Ynddal (14):
>  simpletrace: add __all__ to define public interface
>  simpletrace: annotate magic constants from QEMU code
>  simpletrace: improve parsing of sys.argv; fix files never closed.
>  simpletrace: changed naming of edict and idtoname to improve
>    readability
>  simpletrace: update code for Python 3.11
>  simpletrace: improved error handling on struct unpack
>  simpletrace: define exception and add handling
>  simpletrace: made Analyzer into context-manager
>  simpletrace: refactor to separate responsibilities
>  simpletrace: move logic of process into internal function
>  simpletrace: move event processing to Analyzer class
>  simpletrace: added simplified Analyzer2 class
>  MAINTAINERS: add maintainer of simpletrace.py
>  scripts/analyse-locks-simpletrace.py: changed iteritems() to items()
>=20
> MAINTAINERS                          |   6 +
> scripts/analyse-locks-simpletrace.py |   2 +-
> scripts/simpletrace-benchmark.zip    | Bin 0 -> 4809 bytes
> scripts/simpletrace.py               | 362 ++++++++++++++++++---------
> 4 files changed, 247 insertions(+), 123 deletions(-)
> create mode 100644 scripts/simpletrace-benchmark.zip
>=20
> --=20
> 2.38.1
>=20

Ping :)=

