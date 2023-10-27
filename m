Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE127D8E7C
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 08:09:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwG1m-00056d-Ci; Fri, 27 Oct 2023 02:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1qwG1j-00055j-CX; Fri, 27 Oct 2023 02:08:59 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1qwG1g-0001Ni-Ik; Fri, 27 Oct 2023 02:08:59 -0400
Received: from [192.168.68.112]
 (ppp118-210-136-142.adl-adc-lon-bras33.tpg.internode.on.net
 [118.210.136.142])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id F052A2017B;
 Fri, 27 Oct 2023 14:08:48 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1698386929;
 bh=g16CvfS0OYfewcGbYBDyxJR0tshXGS+QzvGp+YH9ZjE=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=i3Ts+pL/d1TFjlNz9Y1HYhlDBJvHKIcd6HfOTEOBKuFc60r3Y9iolHzXMx9cB/h34
 QUDf8LQc2zxOhheECJ5Z1vx6K8XxWBdz0o8MqgYj2r/nGNgCG5QRD0H35+YXCAsXaE
 GRT5lt/1xErBFN/faOLwET9AsY0d8m770/dEEti6Cz7/qlTKdrXYmOrGMgQgW3zXVj
 29/J/UpyrA6/wJaoDyaUpWlH8e481xMUwL7W8ssZxoyw0Q1CSPaD19WAWDtEezhNlt
 k0jhbhAnX9Zx6edBWMslfWqNuTH/owgz0yJdtNmFWNZInKPyb92baX+w8ZXzFMbcoW
 IYDVihORiM7JA==
Message-ID: <e12e01428066976c2e02af78cb380f808b12865a.camel@codeconstruct.com.au>
Subject: Re: [PATCH v3 2/2] misc/pca9552: Let external devices set pca9552
 inputs
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, clg@kaod.org, joel@jms.id.au, philmd@linaro.org
Date: Fri, 27 Oct 2023 16:38:48 +1030
In-Reply-To: <20231024181144.4045056-3-milesg@linux.vnet.ibm.com>
References: <20231024181144.4045056-1-milesg@linux.vnet.ibm.com>
 <20231024181144.4045056-3-milesg@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
Received-SPF: pass client-ip=203.29.241.158;
 envelope-from=andrew@codeconstruct.com.au; helo=codeconstruct.com.au
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Tue, 2023-10-24 at 13:11 -0500, Glenn Miles wrote:
> Allow external devices to drive pca9552 input pins by adding
> input GPIO's to the model.  This allows a device to connect
> its output GPIO's to the pca9552 input GPIO's.
>=20
> In order for an external device to set the state of a pca9552
> pin, the pin must first be configured for high impedance (LED
> is off).  If the pca9552 pin is configured to drive the pin low
> (LED is on), then external input will be ignored.
>=20
> Here is a table describing the logical state of a pca9552 pin
> given the state being driven by the pca9552 and an external device:
>=20
>                    PCA9552
>                    Configured
>                    State
>=20
>                   | Hi-Z | Low |
>             ------+------+-----+
>   External   Hi-Z |  Hi  | Low |
>   Device    ------+------+-----+
>   State      Low  |  Low | Low |
>             ------+------+-----+
>=20
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

