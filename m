Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0BC725596
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 09:26:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6nYY-0006J0-Ab; Wed, 07 Jun 2023 03:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenbaozi@phytium.com.cn>)
 id 1q6nYP-0006Ht-Jv; Wed, 07 Jun 2023 03:26:01 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chenbaozi@phytium.com.cn>)
 id 1q6nYL-0007e2-AU; Wed, 07 Jun 2023 03:26:01 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDXtI+TMIBkpQaMAg--.279S2;
 Wed, 07 Jun 2023 15:24:03 +0800 (CST)
Received: from smtpclient.apple (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwAHNEzuMIBkU2cAAA--.1400S3;
 Wed, 07 Jun 2023 15:25:34 +0800 (CST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH v4 1/1] hw/arm/sbsa-ref: use XHCI to replace EHCI
From: Chen Baozi <chenbaozi@phytium.com.cn>
In-Reply-To: <20230607023314.192439-2-wangyuquan1236@phytium.com.cn>
Date: Wed, 7 Jun 2023 15:25:23 +0800
Cc: rad@semihalf.com, Peter Maydell <peter.maydell@linaro.org>,
 pbonzini@redhat.com, marcin.juszkiewicz@linaro.org,
 quic_llindhol@quicinc.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A317ED6E-AD4B-475C-A889-0BD4E6A4D1B5@phytium.com.cn>
References: <20230607023314.192439-1-wangyuquan1236@phytium.com.cn>
 <20230607023314.192439-2-wangyuquan1236@phytium.com.cn>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
X-Mailer: Apple Mail (2.3731.600.7)
X-CM-TRANSID: AQAAfwAHNEzuMIBkU2cAAA--.1400S3
X-CM-SenderInfo: hfkh0updr2xqxsk13x1xpou0fpof0/1tbiAQADEWR-hSkCmgAAs8
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=chenbaozi@
 phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=chenbaozi@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
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


> On Jun 7, 2023, at 10:33, Yuquan Wang <wangyuquan1236@phytium.com.cn> =
wrote:
>=20
> The current sbsa-ref cannot use EHCI controller which is only
> able to do 32-bit DMA, since sbsa-ref doesn't have RAM below 4GB.
> Hence, this uses system bus XHCI to provide a usb controller with
> 64-bit DMA capablity instead of EHCI.
>=20
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>

Signed-off-by: Chen Baozi <chenbaozi@phytium.com.cn =
<mailto:chenbaozi@phytium.com.cn>>


