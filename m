Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E785F7DC3BB
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 01:57:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxd49-0004Ut-6k; Mon, 30 Oct 2023 20:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marielle@novastrider.com>)
 id 1qxd44-0004Ui-Eh
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 20:57:05 -0400
Received: from out-180.mta1.migadu.com ([2001:41d0:203:375::b4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marielle@novastrider.com>)
 id 1qxd40-0005IP-MK
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 20:57:04 -0400
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=novastrider.com;
 s=key1; t=1698713814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pVbafBFqKPatxB43OuunNmIhOS40uXwLhFSccyyX0Hw=;
 b=e3l8YVJ6xr3ozeOtPsnsCpRGqOe23k9dmK0r7nJ+PYPvd/nZ/E1JQy/dqCTdhZZ/iwKwSu
 kgD2Kk4wOKIidHw9ND9MbPQU0NZQ6TnqsQWkIV6yF9PDbWh4h9L/wplFJFTfxOR0dpzHa8
 S+aI0KoWXlfT6a25WHe7vvStUtWy7HYYOgZNGXC4XsHVvfrWI9U0aBEiiFH6vOB+5VLJBd
 JWYJVEpK+8tMRd5iFAnywwyTXecOMy2IEg14B3MLGOoIBBl1yUehZayF//f3Ugo1M/tOn0
 DfQ103+foNeBSKZuiHS/Mz6+UGzIEqSEhOXvmb145lwwEs1qE98MUunR9awu+Q==
Mime-Version: 1.0
Subject: Re: [PATCH] linux-user/elfload: Add missing arm64 hwcap values
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Marielle Novastrider <marielle@novastrider.com>
In-Reply-To: <CAFEAcA8ELCiGy3jDKjJhAd9Zn7Sse9ZSoJ6uQ=u4ROvV3rNcyQ@mail.gmail.com>
Date: Tue, 31 Oct 2023 00:56:41 +0000
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7DBF1391-69C2-4FA7-BB3B-378767DF42D4@novastrider.com>
References: <20231029210058.38986-1-marielle@novastrider.com>
 <CAFEAcA8ELCiGy3jDKjJhAd9Zn7Sse9ZSoJ6uQ=u4ROvV3rNcyQ@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:203:375::b4;
 envelope-from=marielle@novastrider.com; helo=out-180.mta1.migadu.com
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


> On 30 Oct 2023, at 09:52, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> ...but we don't implement FEAT_MTE3 yet. We would add this feature =
test
> function, and the GET_FEATURE_ID() line, when we do, but we don't
> need it until then.

Understood.

I made this patch as I noticed the discrepancy between cpuid and hwcap =
output.

The following code produces the value of 3 on current master, which =
would be erroneous if FEAT_MT3 is unimplemented:

#include <stdint.h>
#include <stdio.h>

int main() {
    uint64_t aa64pfr1;
    __asm__("mrs %0, s3_0_c0_c4_1" : "=3Dr"(aa64pfr1));
    std::printf("%lu\n", (aa64pfr1 >> 8) & 0xf);
    return 0;
}

I can submit another patch to correct this.

- Marielle


