Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD79756408
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 15:14:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLO2O-0007OI-Gc; Mon, 17 Jul 2023 09:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jniethe5@gmail.com>)
 id 1qLELg-0003zb-8a; Sun, 16 Jul 2023 22:52:32 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jniethe5@gmail.com>)
 id 1qLELe-0005ya-LE; Sun, 16 Jul 2023 22:52:32 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-52176fdad9dso2864889a12.0; 
 Sun, 16 Jul 2023 19:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689562348; x=1692154348;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9TnFiDkj57ywmA462oTkYYYn3QIt5OmmS055nI4pflM=;
 b=Bg7MTgm0pYcpM9dYv056JzsbXicAunmbbNCewdEjSRru3ihkzlnbriG2s73KVJaPJU
 xeyhdjJRLJp4PcOELC7uGvZE9okTxyhNRyD5zQw8X3UfFf3VoE4CSP2r6qrCkEC/2/Ya
 YQ1sfq0ItbJ6yPfbUiWdnqEP5vidbIWEeTgzK+ZAWXU1qYo/PEpLZIIoCsXNl0tuX/Wg
 UaehcLB2it1s+Syc2Cw45MaPptjW3Ze0wPPdGellBh0mCPIDn7ybEQIB6x4uP6bO6SYS
 +ujcEY9hwmyaU9NQc8qX6eYkaw0GUN/NOux+RnXWpobaVodG0x0x/B0kFpCwsWs/NsWa
 nw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689562348; x=1692154348;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9TnFiDkj57ywmA462oTkYYYn3QIt5OmmS055nI4pflM=;
 b=i0Mz9LoLGP6uDoW7GNv0/zQFfq092Hw182dS8eEWDrKPTHE86/beq3QQiFdLAAkwSe
 hDOfiP0+OXdRAxNzIc6842G6iXb5TXU5C4E7wg3mekXp7Fa4wgX3ayI2ISPx//nIRZ1j
 db7L0lMscs1Wq+S262LQQd/5IPxYZG0Ew/sxLqO6IgKIWqx8aiq3W3+MIAsrCOi2wnhY
 rj7JR568APsEU5tayyC7Lv40FJi1FqCOGal7FXD4s0efLoi+P/ILGJeAjr+yNUGMDCEH
 JSgL0KF+40DvX3bfqSTpPxpchrns7T70TDQzh2fuzSoDSWFkrYBpyqL+/dwwtmfPVwTE
 5coQ==
X-Gm-Message-State: ABy/qLagLZ+TGRpRsC31DRimYrneqjlaQKSejaJrzryO6B1yPZ9wedwu
 +jg8WxUH0BP7mzuWqHjDNUHNhzTMQq/q3+imBBDPBgjQF/s51w==
X-Google-Smtp-Source: APBJJlHMhaN4qKNc9vK4OY3ruiOox/w9Mc+NcgUhzEBDgdkeSAtUyx9o2zvPFPntWPHcIoFQmg2du6+gJg6yQQYTlMM=
X-Received: by 2002:aa7:da4d:0:b0:51d:d3d4:d02f with SMTP id
 w13-20020aa7da4d000000b0051dd3d4d02fmr11337652eds.8.1689562348347; Sun, 16
 Jul 2023 19:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230717012327.20149-1-jniethe5@gmail.com>
In-Reply-To: <20230717012327.20149-1-jniethe5@gmail.com>
From: Jordan Niethe <jniethe5@gmail.com>
Date: Mon, 17 Jul 2023 12:52:16 +1000
Message-ID: <CACzsE9qOehm_j6NVv9U_ACVF9yviD=te+bX9oTe0X7X-FpEHMQ@mail.gmail.com>
Subject: Re: [PATCH] tcg/ppc: Fix race in goto_tb implementation
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org, 
 dbarboza@ventanamicro.com, npiggin@gmail.com, 
 anushree.mathur@linux.vnet.ibm.com, mjt@tls.msk.ru, clg@kaod.org, 
 bgray@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=jniethe5@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 17 Jul 2023 09:13:04 -0400
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

On Mon, Jul 17, 2023 at 11:24=E2=80=AFAM Jordan Niethe <jniethe5@gmail.com>=
 wrote:
[snip]
>
> Reported-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
> Co-developed-by: Benjamin Gray <bgray@linux.ibm.com>
> Signed-off-by: Jordan Niethe <jniethe5@gmail.com>

Sorry, should also have:
Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>

[snip]

