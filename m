Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F2D7CFD1F
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 16:42:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtUDP-0006Z6-2f; Thu, 19 Oct 2023 10:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtUDM-0006UP-0I
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:41:32 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtUDJ-0001wt-PH
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:41:31 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so1836782a12.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 07:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697726488; x=1698331288; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/WMTinwmL9s4fI/yOTGl9SR1J6Ly62/viPWfABjxWiI=;
 b=Tcb+DH8UZ4VItM7yib2wK2zZXSSMJi6pfAPhs2PRdpAJjV62RRyUiZB8ih6ZOwxly2
 ZkcOK3YuP1z774dZsVXs2sTlMRvuZsdk/NtDD62fppOF34FsH+KzzdfaCkVz8Cjddo+V
 ram/ES+jXeOoPAH4YVh7XaqPqR1uR+iQfH6VFi6WsHY+bYavXRtsWUt2eeiv9QM0MI4m
 mbN7Ypp7zpD68qAjrnOItqy/wN6N3KMg2goHtkin2Xu1rAjQAPrLW4z/cZR7k4NS/ysi
 qIesLxsNBJ4fTtwCib58gnWHuVAaTDn5xfJYK2nm3UkVePnt4HYgYklwKuUc4NOjEPRg
 n1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697726488; x=1698331288;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/WMTinwmL9s4fI/yOTGl9SR1J6Ly62/viPWfABjxWiI=;
 b=wjxcze8vMj/13HuaHr7l8P9vFzK1snG4kMef8aDo8ZJzbzUMM9DT9bf6RGoJc+W84H
 9h8+h09ouveKXqtPAeVwgbpfVUC8CDcZSwjaFh5srDhtM0DjguE1mE20izCSOT5kX7JZ
 zj+Zb1GBBQsV8hyDHpQPHRQ+0i+Z7lhq8fsWvHjaRMOPPztDv3TQui02OcJm5Il81UDU
 GHVoaRDm9LJdAp2E2SfclGKn1FtFY2k/tkgsxCu/n5ADdc31W8kp7YsYh8ltGtYVO7Xy
 Hg4aNx6lALbTwYAek6amITHDLSp1i8S2Ew/dIt8NmfN7CD9RBcRaWMRFGLsIJdZ8uA8x
 IUtw==
X-Gm-Message-State: AOJu0YxXpayHvGVtqNMmOEAEk24dIdVBk0nXD8TFTjyx6YPazwOI0N8J
 5n7TksLimqJD+gLJTUHd8HpK9jEAM+LAtCBBQguQmg==
X-Google-Smtp-Source: AGHT+IFaFLNTdcj+69gUmdCXU1Dn29Sb9AdHVtXsUnuNnN1WX90XImGGl3c5f5FjGqa14x3atgGXEUh6XIzQRoZ47Z8=
X-Received: by 2002:a05:6402:5148:b0:53d:bf72:d586 with SMTP id
 n8-20020a056402514800b0053dbf72d586mr1868414edd.16.1697726487969; Thu, 19 Oct
 2023 07:41:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231011112054.1031975-1-mjt@tls.msk.ru>
 <20231011112054.1031975-3-mjt@tls.msk.ru>
 <CAJSP0QVkuu4EbW5gKmrN6Gotnhw1LG+ka=6vjuftPXBrKY+R3g@mail.gmail.com>
 <3f804d1f-cb72-452c-83b2-80f57331d170@redhat.com>
In-Reply-To: <3f804d1f-cb72-452c-83b2-80f57331d170@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Oct 2023 15:41:15 +0100
Message-ID: <CAFEAcA-Fu1SrkYzo_2A3R+QRcZsmeFt_zsj45dfSKJM3DyniVA@mail.gmail.com>
Subject: Re: [PULL 02/13] hw/rdma/vmw/pvrdma_cmd: Use correct struct in
 query_port()
To: Thomas Huth <thuth@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-stable@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 11 Oct 2023 at 17:29, Thomas Huth <thuth@redhat.com> wrote:
>
> On 11/10/2023 17.38, Stefan Hajnoczi wrote:
> > The following CI failure has occurred:
> >
> > ../hw/rdma/vmw/pvrdma_cmd.c:144:59: error: implicit conversion from
> > enumeration type 'enum ibv_port_state' to different enumeration type
> > 'enum pvrdma_port_state' [-Werror,-Wenum-conversion]
> > resp->attrs.state = dev->func0->device_active ? attrs.state :
> > ~ ~~~~~~^~~~~
> > ../hw/rdma/vmw/pvrdma_cmd.c:146:33: error: implicit conversion from
> > enumeration type 'enum ibv_mtu' to different enumeration type 'enum
> > pvrdma_mtu' [-Werror,-Wenum-conversion]
> > resp->attrs.max_mtu = attrs.max_mtu;
> > ~ ~~~~~~^~~~~~~
> > ../hw/rdma/vmw/pvrdma_cmd.c:147:36: error: implicit conversion from
> > enumeration type 'enum ibv_mtu' to different enumeration type 'enum
> > pvrdma_mtu' [-Werror,-Wenum-conversion]
> > resp->attrs.active_mtu = attrs.active_mtu;
> > ~ ~~~~~~^~~~~~~~~~
> >
> > https://gitlab.com/qemu-project/qemu/-/jobs/5270666420
> >
> > Please take a look.
>
> That pvrdma patch unfortunately does not work with Clang, see also:
>
>
> https://lore.kernel.org/qemu-devel/781330fc-85b3-4ef1-8f07-1cc5fc5e4ad2@redhat.com/T/#t

Explicitly casting to the new enum type is OK and fixes the clang
warnings; I'll send out a v2 of the patch in a moment.

thanks
-- PMM

