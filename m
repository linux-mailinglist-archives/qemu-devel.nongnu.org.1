Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1672478D060
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:23:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7nG-0000vK-9Z; Tue, 29 Aug 2023 19:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qb4St-0007fx-Ja
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:33:29 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qb4Sq-0002oh-Qf
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:33:27 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31768ce2e81so3996511f8f.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 12:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693337603; x=1693942403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nDWlN4S/GpucdPmNTO7sMsLarljJzWSh8Wpk6jM3Ev8=;
 b=lhAfOJoVxh2uj86zPkJwqMqjLxMIvX1/vmRrQ/RNLdmsjR/04u+iKPa+VVn5DdNy2a
 xXgIE+1O3O/XV9xEXKnrHpSYrIfZmMriCYt08f8g7tEMQhmf+slp+heauIwX9DFgavRp
 puMVl8LVgT1gqzvZabxBAVJvhGu1T1Q++FZHVBPpA4fCJhCUVB6i6bspbZOSIex5M1gs
 hZkAzFOB7IXvXXWmrrT/5QiJ2lcj6bRsrXZ0m9Ma5GWdDM8Xqc3cPmOEzly5KgtQGYDg
 Yzs21C5Yi88vdFLwZJC0pZLUObjccVaDWBE697vPqQYUJIMd3Qr4zdAXziI/pK5zTZTX
 rDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693337603; x=1693942403;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nDWlN4S/GpucdPmNTO7sMsLarljJzWSh8Wpk6jM3Ev8=;
 b=fIv9HipjAFA3Rp0F3inpAJvCeKgiNN09Aik46zgkgBN5rrSi5KATzFxfqWIsIFefvB
 u1EvcKJ4tfYBt7UMNHapnt/q9rWqURDih65aDwhIWIGqL8SCspWMZJ854y1D8W6xBZB2
 TksQpSjrGdUr7TtkPRQ9tX5jPOtwn92GfQNvRb2SvWHauYkZJVoCYiQx0q2LzIN+6Y0d
 +rPOBYuN7XSko1W1hP0GVP7EpaFLO8H0cvovAVZj61qqA/FMgVg2QWTUFByZv9zhdI7I
 5cqwb1BtaDOLMXBajRmQZCNegbHjaASuKVHBshaXXgixijVCwasZmP/hvgCyOkpZBWQo
 7zhw==
X-Gm-Message-State: AOJu0Yx7AciLomv9F6t+qmvUIZ5q5NflnW6BbfmrowsCWof48JfAEgId
 o8ZInFelu58GIp6MmapMGMR6oQ==
X-Google-Smtp-Source: AGHT+IHdPntl2C8qHGbP6WHr67k5lXIICohlZelQetPZyvLFK/iuicgkvdurkYmHiqYAL1TCy36IUQ==
X-Received: by 2002:adf:e686:0:b0:31a:e89a:df0a with SMTP id
 r6-20020adfe686000000b0031ae89adf0amr50419wrm.45.1693337603182; 
 Tue, 29 Aug 2023 12:33:23 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 o5-20020a1c7505000000b003fee8502999sm17911215wmc.18.2023.08.29.12.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 12:33:22 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7201E1FFBB;
 Tue, 29 Aug 2023 20:33:22 +0100 (BST)
References: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
 <36ce5f4d63892e36f0ebd4cdb0660df75deda6bb.1693252037.git.manos.pitsidianakis@linaro.org>
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
Subject: Re: [PATCH v8 08/12] virtio-sound: handle VIRTIO_SND_R_PCM_PREPARE
Date: Tue, 29 Aug 2023 20:33:18 +0100
In-reply-to: <36ce5f4d63892e36f0ebd4cdb0660df75deda6bb.1693252037.git.manos.pitsidianakis@linaro.org>
Message-ID: <87pm35skxp.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

> Handles the PCM prepare control request. It initializes a PCM stream
> when the guests asks for it.
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

