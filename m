Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D077E351A
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 07:14:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0FKr-0003Uc-Ih; Tue, 07 Nov 2023 01:13:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r0FKp-0003N8-KO
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 01:13:11 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r0FKa-0007sx-Lr
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 01:13:11 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9c773ac9b15so784543066b.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 22:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699337574; x=1699942374; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8i/DVsUvhzFOD4AjDSqUcNrgVcqwYKIVIu/B5z9QBGc=;
 b=Tbb2zZEVKVZCBxlarQHQcVbGuTD0Vp3CQdaCxvCo06PBOAs7oa26pHEqIGXHn2GNfu
 Tu/WXW7I3MAGzWM3T+9js9T2OzAOQLJGF38OcyfH9aqu/4RwV7ybeynQaILDfaMy6qpB
 DrM0PwPO/VT8N3OojupP8mX1BChwBCXd/JqlipTjt5pIEhrtMVPp3W/nrEosga3bCp8Q
 Jlni+jmLUtMHXX3zO+Lx7edd2WbZG1wscWb/ecggNL7NxkZ5nvvYUjfHzR1l3SJmTkaJ
 ZUKI8K5sksyOb1MDOMgEWgBp2y7hXDazO3yxFXyGsomEyeVCJtfQadrw0kux1oNd37Yf
 af3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699337574; x=1699942374;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8i/DVsUvhzFOD4AjDSqUcNrgVcqwYKIVIu/B5z9QBGc=;
 b=pQJXurQ/j+nLAhnzvs7y5RdyiZMe4IQB2xg9sgyRg2qVFN1gDPJZSNkuaezu1KMgsv
 c3otm7UJ+agFDrF5H+vMyk2uCVYkQNLI8dlYXjvTx/JBpjNwmGi5t7gjma3CCWj7BJdW
 UnYJazI7wTujN5IcbALv6zwCykYLfnpbz3WnV/m+uAqBV1m3Tw/vhmGYJPO99/0F6oKs
 8KYugJvH1c5mpuUmFzCfvEJ7huDOz/ShkASJDv0TlIgIh1/Q2MHiT4PD7QRPAFCNNxev
 YaxvC6TjfFNiSLH9mB5u48MVW769ylMymdFGsTGqnVs4ZeINUdsT+QMjzXM9QfcAPNpU
 gI7A==
X-Gm-Message-State: AOJu0Yz5f+d0/mrOdDj/huVvH2TyJAQs5P1Wrm9Sf6c9p3QAVREbRrnl
 2Ntcy3tCrTLkgc+eucJqb1CKoHfCBNqpg78511kzBw==
X-Google-Smtp-Source: AGHT+IF5ufAg1P4E2vFe6zkG5fUwolJbBBAp/WDW4oDV22U2XnVl+27uRfjze1uUV0B1gZQmR8CQPHfCTkjioiTsBPs=
X-Received: by 2002:a17:907:26c5:b0:9e0:2319:16dc with SMTP id
 bp5-20020a17090726c500b009e0231916dcmr4885461ejc.73.1699337574382; Mon, 06
 Nov 2023 22:12:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1698062525.git.manos.pitsidianakis@linaro.org>
 <20231106194352-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231106194352-mutt-send-email-mst@kernel.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 7 Nov 2023 08:12:38 +0200
Message-ID: <CAAjaMXY3YSBbYHAvnMkP64Tze-RcroMcj2T85i8h2y-Rz1-8YA@mail.gmail.com>
Subject: Re: [PATCH v13 00/11] Add VIRTIO sound card
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Igor Skalkin <Igor.Skalkin@opensynergy.com>, 
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <DirtY.iCE.hu@gmail.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Tue, 7 Nov 2023 at 02:44, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Oct 23, 2023 at 03:03:17PM +0300, Manos Pitsidianakis wrote:
> > This patch series adds an audio device implementing the recent virtio
> > sound spec (1.2) and a corresponding PCI wrapper device.
>
>
> Pls send patches on top to fix checkpatch warnings.
>
> https://gitlab.com/mstredhat/qemu/-/jobs/5470533893

Do you mean this one?

6583087d531f2e37a2e2ba2cef7d123e21f8b0ad:214: ERROR: spaces required
around that ':' (ctx:VxE)
total: 1 errors, 0 warnings, 674 lines checked

If yes, it's a false warning. It's a switch statement with a macro and
it confuses it with the ternary operator.

