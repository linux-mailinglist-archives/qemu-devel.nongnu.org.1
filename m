Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2627DC96D
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 10:25:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxky6-0000iM-9k; Tue, 31 Oct 2023 05:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marielle@novastrider.com>)
 id 1qxky1-0000hk-Ub
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:23:21 -0400
Received: from out-175.mta0.migadu.com ([2001:41d0:1004:224b::af])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marielle@novastrider.com>)
 id 1qxky0-0002Wj-Dw
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:23:21 -0400
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=novastrider.com;
 s=key1; t=1698744195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TVbbsKinzzopVuB4its/eyIhqr30DU4HcxGoOz7zkFI=;
 b=gFt2hwPSnU63OwK0mY1ky3OtHxKElfONBWGCWbYtqDQovk6ILGBs9eSV1726ZgJPG4VGcj
 pXehfd6gM0FWOj5briuQnVsUCVAvGWcLbpR+kKc3axE5dH7gC+c1ZlbW5HI8E+3sorCwlk
 5IPswcMQZUko82s/VEt2+YyQXl4BqIg82vGlhByNbucr5ZHPGEt86UtGTi2bAuPg7XAVuE
 rPWQKJF1ElB5m4reJUtEEIbb4Uy6AEPU/RurBuBU+qQjxxCoFHRT6w2lQe+fovmbxjKEw1
 /D6fvAYDu8RWK1loWDZtIZzlo1g8ddWFk7a8Pmha7cvgQVPz27XSPXTOdhkstg==
Mime-Version: 1.0
Subject: Re: [PATCH] linux-user/elfload: Add missing arm64 hwcap values
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Marielle Novastrider <marielle@novastrider.com>
In-Reply-To: <7DBF1391-69C2-4FA7-BB3B-378767DF42D4@novastrider.com>
Date: Tue, 31 Oct 2023 09:23:02 +0000
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <834B7660-49CF-4704-9AE4-EB18B374BCB7@novastrider.com>
References: <20231029210058.38986-1-marielle@novastrider.com>
 <CAFEAcA8ELCiGy3jDKjJhAd9Zn7Sse9ZSoJ6uQ=u4ROvV3rNcyQ@mail.gmail.com>
 <7DBF1391-69C2-4FA7-BB3B-378767DF42D4@novastrider.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:1004:224b::af;
 envelope-from=marielle@novastrider.com; helo=out-175.mta0.migadu.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_FMBLA_NEWDOM=1.499, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



> On 31 Oct 2023, at 00:56, Marielle Novastrider =
<marielle@novastrider.com> wrote:
>=20
>> On 30 Oct 2023, at 09:52, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>>=20
>> ...but we don't implement FEAT_MTE3 yet. We would add this feature =
test
>> function, and the GET_FEATURE_ID() line, when we do, but we don't
>> need it until then.
>=20
> Understood.
>=20
> I made this patch as I noticed the discrepancy between cpuid and hwcap =
output.
>=20
> The following code produces the value of 3 on current master, which =
would be erroneous if FEAT_MT3 is unimplemented:
>=20
> #include <stdint.h>
> #include <stdio.h>
>=20
> int main() {
>    uint64_t aa64pfr1;
>    __asm__("mrs %0, s3_0_c0_c4_1" : "=3Dr"(aa64pfr1));
>    std::printf("%lu\n", (aa64pfr1 >> 8) & 0xf);
>    return 0;
> }
>=20
> I can submit another patch to correct this.
>=20
> - Marielle
>=20

I note that commit 86f0d4c7290eb2b21ec3eb44956ec245441275db suggests =
that FEAT_MTE3 is already implemented.=

