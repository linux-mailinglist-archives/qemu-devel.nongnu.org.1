Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCA678D07E
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:25:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7mr-0000hI-U3; Tue, 29 Aug 2023 19:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qb4Sg-0007em-0G
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:33:17 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qb4Sc-0002o0-On
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:33:12 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-401d10e3e54so16324755e9.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 12:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693337589; x=1693942389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6jTY6nWEfW13Sz56mSyWM/reuJ+HvjjBUZBONgkrZac=;
 b=Pd/w2MtVTWtDX/7V4v3/YaKsdRtZEgI5Oz2brTJ6OyXnA/YR834yCSFSSKekJZ+sLn
 cMya8aNGQ2QCUIZ7MfwhsaZ79Gx3G+njO8fcaf36feWbGUzF0WGxZCrD5cNFoTC+sOTT
 YWJhZjXoa0qTsCgpWO9eHqcGNXZCh3OL2Xb1VMCYn43Gw2hDTob3nJPZ2NoSx7MPT45g
 C+HPO40TzrS3c+9TPaRIbugR/5zbPLSV5LRjz+PRdR/nJIzLuJMDmXUJz1OX0cV7c5Gj
 4jNjtVJE+GOgLYP7+WC1kle/zEBthmkUezq7OGmYNZl1L36WacnO4EdwYdQtcrJmLxeP
 GfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693337589; x=1693942389;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6jTY6nWEfW13Sz56mSyWM/reuJ+HvjjBUZBONgkrZac=;
 b=IwLQfgORYhZdiVbG5qU/OFX9mr3vFBJVhg2ozqzr2HFsUNwVrQbQNQP+u+jxgKFDhH
 j5HF26oTZ3qgbXtpOKRbW2ishZUNb1n8OyaBoCL2++H9nTbBmkLYvPklS8E9GbXQPNOo
 BE3cl1Xxu+Lk7xaIoBch9S5XBXIQ6luuiRAZ4Qvy6Mr7LrZTY3O+zC5buaJbaeBTUUDA
 OEWQfZu6STSaQDbp0k03K/DoY4XKInplk5Bawq/Wndilz/JjPw7qPvFLeVK2j+j/DlIa
 fXKMdtnTY57XM1Z3UBua0hjVyrGkUXDS139fagSOcrOjVlM9FCLcRvYCUjw2ieJYkiPL
 eP5A==
X-Gm-Message-State: AOJu0YwLhUOB+KiZLYU1ozOcPpDDlqvMbfIFHRsqU3VooSHA3Wo1IGbI
 /C0jT90VIRtWxi5IFxSmRSbQRQ==
X-Google-Smtp-Source: AGHT+IF59Y8xyLESc42ypztGGcJMy7H6tGlWMGL79Mabmi0aAaOjlgJWj25sNISq2XXN7+58hWrqrQ==
X-Received: by 2002:a1c:7405:0:b0:401:519:c5 with SMTP id
 p5-20020a1c7405000000b00401051900c5mr178726wmc.41.1693337588959; 
 Tue, 29 Aug 2023 12:33:08 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 k21-20020a05600c0b5500b003feea62440bsm14647425wmr.43.2023.08.29.12.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 12:33:08 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4390C1FFBB;
 Tue, 29 Aug 2023 20:33:08 +0100 (BST)
References: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
 <993e6af394dc5e687abaf2d6eeb8443fd636fa1a.1693252037.git.manos.pitsidianakis@linaro.org>
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
Subject: Re: [PATCH v8 07/12] virtio-sound: handle VIRTIO_SND_R_PCM_SET_PARAMS
Date: Tue, 29 Aug 2023 20:33:04 +0100
In-reply-to: <993e6af394dc5e687abaf2d6eeb8443fd636fa1a.1693252037.git.manos.pitsidianakis@linaro.org>
Message-ID: <87ttshsky3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

> Handle the set parameters control request. It reconfigures a stream
> based on a guest's preference if the values are valid and supported.
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

