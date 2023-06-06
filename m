Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3B7723EE3
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 12:05:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TYg-0006VU-4g; Tue, 06 Jun 2023 06:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TYa-0006V6-Sp
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:04:52 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TYZ-0002PQ-Am
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:04:52 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-976a0a1a92bso648918466b.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 03:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686045889; x=1688637889;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=92wGn4QQJVreuFWfrl+WHcmwD8spWYxPz6rnS0StpKE=;
 b=b6+F7z91QPU0xCaO56NM84FKpnTxhxEfnVcTo3L9NXY+O2JAJtiBYtBbudpwZ7z3C1
 NBfC8eZnXCwWNKY8U5Nbgo6wpB75mhLqUQ+Sc6zD+Rmx1BCf4PM8Fvrgi2wG2RtBXO4C
 AhaYyjosQYRnZkpOI/dKSUp3245ZlGwY5pgJ/PGubXHB4qQaYSwqoYLfgGTwKpDiiyR3
 Ep1wRWroBmdvQ9nqz3/iUoX6WSje1Q64I6S1rHrWE3DGT/WENXiPs/mToxx9+TWurAuu
 tKkKlQ311AUcwBHL4i1zsRiUYeg1FJKyILiDXbfphKICXna3QcjrV15b4F+yNnurxkDq
 Wh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686045889; x=1688637889;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=92wGn4QQJVreuFWfrl+WHcmwD8spWYxPz6rnS0StpKE=;
 b=hQVrMVWNZOxtqsHXwQNv2ZNVrh7i5K2usUmoV3uCzJ+WsT1uccb/CQVTb87MeyTFIG
 5gebCCqQJToYhuCQksMeM4sUmoNMxyO9/dZiKrPo+nToZhDBSX6XnILjo2CU4bw/74IK
 HH+iXRYaAwAwUa9ytHuWa3pRKAz0KNilMUDsVk3JdUtCbOwUU318OIyrx9OFTWOiFQzD
 ny30ryFzZZATxP+4xVGej8gXCV5Oqm8DQ6884sm5AFqzDHl823KOayckLXPkviQ8cjlc
 ARTA38GFzzgRRJx7VdbliLIWzVOQYyFUyTXsox657qYhkZB+LQF5bPHy8pvrcnbiTWuW
 f/UQ==
X-Gm-Message-State: AC+VfDwe8OI7dNMgexhRWL5Fbc5YLiuOSCkhoGUBE278bzp6m3S/5GOp
 M1+puZotc1aboWEYn1tlJ/pu550l3tXdjVUPyYYtDg==
X-Google-Smtp-Source: ACHHUZ4IUXeFMwtlyv8AJ1bvbZOGBoi7b1ted+wtiiIpqqQfM73/KgbiQIr336zq4NOvBw8P7Y9S4qPGUe7rbOAdxKk=
X-Received: by 2002:a17:907:9729:b0:978:4027:57eb with SMTP id
 jg41-20020a170907972900b00978402757ebmr1914627ejc.47.1686045889541; Tue, 06
 Jun 2023 03:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230605095536.117384-1-wangyuquan1236@phytium.com.cn>
 <20230605095536.117384-2-wangyuquan1236@phytium.com.cn>
 <1fc502fa-8363-5a5b-0697-f3001c7ab773@linaro.org>
In-Reply-To: <1fc502fa-8363-5a5b-0697-f3001c7ab773@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Jun 2023 11:04:38 +0100
Message-ID: <CAFEAcA_sGtV3HFZHX1JapnE04UpOxxxWvwgApVVm7dMX7+A-uw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] hw/arm/sbsa-ref: use XHCI to replace EHCI
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: Yuquan Wang <wangyuquan1236@phytium.com.cn>, rad@semihalf.com, 
 quic_llindhol@quicinc.com, chenbaozi@phytium.com.cn, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 6 Jun 2023 at 10:47, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> W dniu 5.06.2023 o 11:55, Yuquan Wang pisze:
> > The current sbsa-ref cannot use EHCI controller which is only
> > able to do 32-bit DMA, since sbsa-ref doesn't have RAM below 4GB.
> > Hence, this uses XHCI to provide a usb controller with 64-bit
> > DMA capablity instead of EHCI.
> >
> > Signed-off-by: Yuquan Wang<wangyuquan1236@phytium.com.cn>
>
> Reviewed-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
>
> Without EDK2 changes Linux behaves same way (no USB found), with EDK2
> changes (EHCI->XHCI) Linux gets USB devices.

So it doesn't break (cause to crash) old EDK2 images? That's a
pleasant surprise.

-- PMM

