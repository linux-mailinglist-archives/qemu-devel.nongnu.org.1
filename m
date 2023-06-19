Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF637735B1C
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 17:26:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBGkF-0005KX-I7; Mon, 19 Jun 2023 11:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenbaozi@phytium.com.cn>)
 id 1qBGk9-0005It-5m; Mon, 19 Jun 2023 11:24:37 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chenbaozi@phytium.com.cn>)
 id 1qBGk6-0004KZ-Q2; Mon, 19 Jun 2023 11:24:36 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDXX2G5cpBkKjNtAA--.4643S2;
 Mon, 19 Jun 2023 23:22:33 +0800 (CST)
Received: from smtpclient.apple (unknown [118.248.140.64])
 by mail (Coremail) with SMTP id AQAAfwA3mpYbc5Bk16QAAA--.1469S3;
 Mon, 19 Jun 2023 23:24:11 +0800 (CST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH v4 1/1] hw/arm/sbsa-ref: use XHCI to replace EHCI
From: Chen Baozi <chenbaozi@phytium.com.cn>
In-Reply-To: <CAFEAcA-sv5R0RTp5z-i70dYj0GM88xVOOQ8ktp4k2adD-BRJQw@mail.gmail.com>
Date: Mon, 19 Jun 2023 23:24:00 +0800
Cc: Yuquan Wang <wangyuquan1236@phytium.com.cn>, rad@semihalf.com,
 pbonzini@redhat.com, marcin.juszkiewicz@linaro.org,
 quic_llindhol@quicinc.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C89FDFEE-F033-49FA-A5CC-DA2A7FC8EC0A@phytium.com.cn>
References: <20230607023314.192439-1-wangyuquan1236@phytium.com.cn>
 <20230607023314.192439-2-wangyuquan1236@phytium.com.cn>
 <A317ED6E-AD4B-475C-A889-0BD4E6A4D1B5@phytium.com.cn>
 <CAFEAcA-sv5R0RTp5z-i70dYj0GM88xVOOQ8ktp4k2adD-BRJQw@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3731.600.7)
X-CM-TRANSID: AQAAfwA3mpYbc5Bk16QAAA--.1469S3
X-CM-SenderInfo: hfkh0updr2xqxsk13x1xpou0fpof0/1tbiAQAPEWSPVyYEHwAAse
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=chenbaozi@
 phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWruFW7Ww4fJrWrtw45tw4fXwb_yoWDJwb_ZF
 4xArnY9r1DKr1xGasrtF43Xr9YgrW3Wr45Wwn8Aa4fta4qvFy5JFs5try8Zr13tFWvgrWx
 uw1aqFW5trWavjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
 Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
 UUUU=
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=chenbaozi@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



> On Jun 19, 2023, at 18:28, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On Wed, 7 Jun 2023 at 08:25, Chen Baozi <chenbaozi@phytium.com.cn> =
wrote:
>>=20
>>=20
>>> On Jun 7, 2023, at 10:33, Yuquan Wang =
<wangyuquan1236@phytium.com.cn> wrote:
>>>=20
>>> The current sbsa-ref cannot use EHCI controller which is only
>>> able to do 32-bit DMA, since sbsa-ref doesn't have RAM below 4GB.
>>> Hence, this uses system bus XHCI to provide a usb controller with
>>> 64-bit DMA capablity instead of EHCI.
>>>=20
>>> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
>>=20
>> Signed-off-by: Chen Baozi <chenbaozi@phytium.com.cn =
<mailto:chenbaozi@phytium.com.cn>>
>=20
> Hi; why have you added yourself as a Signed-off-by: here?
> Did you do the work jointly with Yuquan? Or did you intend
> to provide some other tag (like a reviewed-by or a tested-by?)

Oh yes, we are. And I asked him to send this patch upstream after we =
have worked it
out internally first.

Cheers,

Baozi.=


