Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A1578D075
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:25:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7nm-0001Bf-5i; Tue, 29 Aug 2023 19:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qb4Ry-0007cC-7A
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:32:30 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qb4Rv-0002f2-PT
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:32:29 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-31aeedbb264so4324794f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 12:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693337546; x=1693942346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7gonYvh68nIa/u69xzo2nJ01Nf1tslVtxCZ3XkTe1F4=;
 b=EoNVAcXwRJ44qNspjnqMIWyGZD5K4/5aG+7BzWd52sVtW8nUv7NOqRTQWNdYxEQ26y
 7OA0UArCLSrHylVOKsS3nCfQRlLFFQ2FCgbJZNqVHfWPOTGFIf8xoi5D57o4OAvrePaH
 ybCXHv37DmVEun7JkAfjspPi3lAn3WbVf+pj/VtbGAJc1VkuOExMWyr6mXgMVQhxd9nJ
 gXC6ev24vwjN8L6OFbJJDTbQlLZOXVvAr40s9nsuFW9F02mFOGmYUu2VoVHN9iOYbkYW
 48FrJqW+HCSHHvDJPRhhDPkgHki++CKTiNwWp7PNzFZ3HrYF77iK+90SvkkZ+GLF2ZRz
 7bvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693337546; x=1693942346;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7gonYvh68nIa/u69xzo2nJ01Nf1tslVtxCZ3XkTe1F4=;
 b=L2zzUabpX7aEJiyMwPwXEqyAPrnr1FUkm3n2f4/uyflWePgYG3HctLBIejkz8IPyhX
 p+DR5/57UuuDTFSL4yl6Ef7FcVgsUQFhYT7RhhDnha19r/GBfGlDTLCi12z3FXmbsLDU
 Osxv3DZXyR099JHSCbUJWQdbl1fVbEICwbbAAdYWr9hGVpk5LnPoVBqMgNg1AN300bd+
 OyqtoRTEveEsPrEBLnThB+f2rhLbMdixzr/nb1G9Dgur/+WzGs+LB+fpaDuV1DgsO7u7
 KXQ7Uk6NqNClBUqNd/Jd2SFmt1TjzCjauA3U+m+J+gGFX1ZbiQwWpgD+eZaHwDrPct76
 9mIQ==
X-Gm-Message-State: AOJu0YwisVgNX8IG9hBoxZ3Y2yeQ22lMyrOXdyKDES55uccHZDw0XK6E
 Sy/huPeWmVEMVHIUAb4Vy00EuQ==
X-Google-Smtp-Source: AGHT+IH7b6tN/37nyzvPPU9ymbq5r+woxqEf+jiwEgsin1I9UOq9QfnVyEN166xecT6FJN7sPyHexA==
X-Received: by 2002:a5d:4c92:0:b0:317:3c89:7f03 with SMTP id
 z18-20020a5d4c92000000b003173c897f03mr46938wrs.5.1693337546031; 
 Tue, 29 Aug 2023 12:32:26 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 y6-20020adfd086000000b003179b3fd837sm14613623wrh.33.2023.08.29.12.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 12:32:25 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 485111FFBB;
 Tue, 29 Aug 2023 20:32:25 +0100 (BST)
References: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
 <ff6f1320047826fa9260ab4c461873b2460cc350.1693252037.git.manos.pitsidianakis@linaro.org>
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
Subject: Re: [PATCH v8 06/12] virtio-sound: handle
 VIRTIO_SND_R_PCM_{START,STOP}
Date: Tue, 29 Aug 2023 20:32:21 +0100
In-reply-to: <ff6f1320047826fa9260ab4c461873b2460cc350.1693252037.git.manos.pitsidianakis@linaro.org>
Message-ID: <87y1htskza.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

> Handle the start and stop control messages for a stream_id. This request
> does nothing at the moment except for replying to it. Audio playback
> or capture will be started/stopped here in follow-up commits.
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

