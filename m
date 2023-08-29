Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8578F78CFF5
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:09:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7oo-0002v3-NH; Tue, 29 Aug 2023 19:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qb4Qo-0007Rp-TN
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:31:23 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qb4Ql-0002VA-GY
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:31:17 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4018af103bcso996885e9.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 12:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693337473; x=1693942273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rzo4+KDdgc9mvQf1jpCBy3kJyAMNQ9tWI7LM1Ny6mkE=;
 b=fPCfT/rN6sbtFX4X1BAfoC80H4lL+lc4+qEw7yrS657xiUB3uNZKV8IkYNU04aaLzS
 HpBBhqnfhzHOaaETNbA+fiNNxJQ8XrYV4lt8pzFhn0CC2DYbwcteBK8bQCRG9vgUg6N8
 OxSXegu1+uj3VL4blIQCMre0ey9dfQ5i9IqzGI6JvPxIydJpeXlhxVoumSqcS/ubgZmm
 /C2JGKfFVkFqrC181OlXlUGkU9i3U92MR8P/SrOYLsgcExOS3RbY2PMq2EjAhMguR6HL
 IYtGi24db3XB/0M+T7cTf+TtKuDEvt2N6O1gIK+oVfumCrct1Mgju2VknLnT/0aRvMXe
 foWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693337473; x=1693942273;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Rzo4+KDdgc9mvQf1jpCBy3kJyAMNQ9tWI7LM1Ny6mkE=;
 b=Rf1PSBlQZHLXOD0D4j4QcWg+a7DxUZWl5uOnD56wb4xTSqmPJncQda1P18B/xnB0KX
 rypvdIuNVE5yp8+LmuePnF4PWG6mig5vJERY+mZoOJCAn6apMFVAOduV0lf48uKIq4DQ
 TWE2Rx1UxzZvS7pF16St9sZ8m26v1tsrvq+x4Yup2a/Pnldp5S+ajUE+OigygNuAsum0
 UhKNm9ClcEf8iBy0mrOmnblPDUplRzIplvQoJ3x74N3lwWquoV/+XFZyKEGI1ihsmQ+m
 /fyk0BZ1B+ynLq8EMRb3SwhYoKMEzP9gnvGcfO5fKyfuqqlSAlsaxLQg8rZSdbfnoFwa
 HBTA==
X-Gm-Message-State: AOJu0YyN2eBNv9ccLUfXAFLjgqgTvEoCe6A889V2Ol0htoruBFnTILGE
 P/FlSfUyJg49djIp6PaJwRzOEw==
X-Google-Smtp-Source: AGHT+IHZ5dl8wAHaPdumJKsV4XAe0cF7HeiFG31/NA3UCrHFBMwgt35/MjGTIzV9AOqf1o2vn5Cwcg==
X-Received: by 2002:a05:600c:35c8:b0:401:609f:7f9a with SMTP id
 r8-20020a05600c35c800b00401609f7f9amr2941792wmq.8.1693337473138; 
 Tue, 29 Aug 2023 12:31:13 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 u11-20020a05600c210b00b003fe2b081661sm18038773wml.30.2023.08.29.12.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 12:31:12 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 38C1C1FFBB;
 Tue, 29 Aug 2023 20:31:12 +0100 (BST)
References: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
 <974d88412dd4ee18ae35efdbec657fa558c13fbf.1693252037.git.manos.pitsidianakis@linaro.org>
User-agent: mu4e 1.11.16; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>, =?utf-8?B?S8WRdsOh?=
 =?utf-8?B?Z8OzLCBab2x0w6Fu?=
 <DirtY.iCE.hu@gmail.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH v8 05/12] virtio-sound: handle VIRTIO_SND_R_PCM_INFO
 request
Date: Tue, 29 Aug 2023 20:31:06 +0100
In-reply-to: <974d88412dd4ee18ae35efdbec657fa558c13fbf.1693252037.git.manos.pitsidianakis@linaro.org>
Message-ID: <873501tzlr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> Respond to the VIRTIO_SND_R_PCM_INFO control request with the parameters
> of each requested PCM stream.
>
> Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9=
c7b40a8e603f4da92471
> Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
> Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
> Signed-off-by: Emmanouil Pitsidianakis
> <manos.pitsidianakis@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

