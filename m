Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7D9AF90D1
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Jul 2025 12:41:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdqZ-0000YP-0Y; Fri, 04 Jul 2025 06:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uXdqO-0000Vz-5x
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:40:37 -0400
Received: from p-east3-cluster3-host8-snip4-2.eps.apple.com ([57.103.86.75]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uXdqE-0002ZC-Us
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=wA9O8GpU1RffYD0QdjQuLE48gweREtqMni7yHIHOGP8=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=b9wvfymnaad619MUtxtjryFyOVz6pbK3QU2vuzujFXkT+1T9niTA0BqBS5Lm6CRGp
 IhFv3dpy+4iA2eVcHPyCk1o8oAFtfdGFpI7f/0dhoOONztvryge4J88pjabQ0yma1G
 zYowfSwGfpxcmAXEOEBQwf/aJQ3ykmqfqhPNWyMnQYV4GGm29cKEdAd8OEzIMnRw+h
 6Wcgbl3nyom1gKes9uFSTXrcoBzAfTwI+qylPxrIqd9tCtZmseUlhRZMq5Jo/DZ4CY
 yLp580O1wtgNYlrGwT5WE/uSIob2ZTHAU0ciGqB89AFc4W3Nw3CJ2J41eecfCeT58G
 utJl/dDc6SCMg==
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by outbound.qs.icloud.com (Postfix) with ESMTPS id 671DE180014D;
 Fri,  4 Jul 2025 10:40:19 +0000 (UTC)
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by outbound.qs.icloud.com (Postfix) with ESMTPSA id A19101800127;
 Fri,  4 Jul 2025 10:40:17 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v4 33/65] accel/hvf: Replace @dirty field by generic
 CPUState::vcpu_dirty field
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250702185332.43650-34-philmd@linaro.org>
Date: Fri, 4 Jul 2025 12:40:06 +0200
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D6976823-5443-47C6-BB9F-A457D71FA0A0@ynddal.dk>
References: <20250702185332.43650-1-philmd@linaro.org>
 <20250702185332.43650-34-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-Proofpoint-GUID: oJiluUS6wIuhdirv8vTfgQBS2awDhsx1
X-Proofpoint-ORIG-GUID: oJiluUS6wIuhdirv8vTfgQBS2awDhsx1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDA4MiBTYWx0ZWRfX3RaVDKJDT/SD
 3FZvkheal41M812L1Whg0ZiyipLgcUsLKcYJb87N+e2UagaagQvOG9U+DHck2vu+NSFpkiB3V2G
 pR8kq2ro8RfhbiX2lownRu9VrAqCh4Nin+RH9Na2rx16RoRZY9pxO80BDw/SSJ+Ibasiw5lBHtp
 HPVsYUjLoD3FggTORC0uphrOHVo7QmgT8UShpC0GE64auUNgzBwsOlHxRd6a8F2z/M40WQFdjuD
 BYR8yznHfTtV8/Qd1VIIRNHnKAZu0ZQSLaWHk+XcV2I5UnH0pNMUkUhaxaFXPPvCRld5q01xk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_04,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 clxscore=1030 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0
 spamscore=0 mlxlogscore=445 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506060001 definitions=main-2507040082
Received-SPF: pass client-ip=57.103.86.75; envelope-from=mads@ynddal.dk;
 helo=outbound.qs.icloud.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


> On 2 Jul 2025, at 20.52, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> No need for accel-specific @dirty field when we have
> a generic one in CPUState.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> include/system/hvf_int.h  |  1 -
> accel/hvf/hvf-accel-ops.c | 10 +++++-----
> target/arm/hvf/hvf.c      |  4 ++--
> target/i386/hvf/hvf.c     |  4 ++--
> target/i386/hvf/x86hvf.c  |  2 +-
> 5 files changed, 10 insertions(+), 11 deletions(-)
>=20

Reviewed-by: Mads Ynddal <mads@ynddal.dk>


