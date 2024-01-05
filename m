Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EDB8257E9
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 17:19:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLmu7-0007LY-2N; Fri, 05 Jan 2024 11:18:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rLmtv-0007KE-6W
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 11:18:27 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rLmts-0002yS-6I
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 11:18:26 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40d5f40ce04so17600995e9.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 08:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704471501; x=1705076301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SEiADKruN8GjNvJIGFayWYZ3vy9JdtqPKB4YiY3EGLE=;
 b=ObKf2IOD4NN5Gt888lROAET8m23RtIejIipvLMxCoHqHvPWqI8BRJ82GrKg+9A2EY1
 p2YGcqxcU7eDgenNC9mtt2oxf9GnalDLIicERxFjSkMkCs5Wtzwy1LdJMfR4rbeQj876
 gi287KVidAGoyUtJt3Qs83YI3ccAEIzkQBzEqLY0X23BDqxOKG0pScS+OF067580scw9
 U1Bo+PqPyjhTNpoVtSajCigI1/Ixr+M18ZbcsnJfVe3P7hGNNjIz+mr8EI4EGAI7Tq0B
 NHWV9r8D9cQRivvF+SsaURhghbqxicc1PJFDFOVwJqBMcokkDGHGQIxEyabtTR6QaGtb
 fy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704471501; x=1705076301;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SEiADKruN8GjNvJIGFayWYZ3vy9JdtqPKB4YiY3EGLE=;
 b=I5kzTGLWsdJJaeI1PW/Qcj3SXgvKA6Q0xBD0npTMRlltpPFiNzI1M+HFktHiLHYC79
 nDwKVgy0iIAGzUoop2nhKNN+jmvVYkVKiv/gENSvCvxN3l6d8eU1AoiXhxKkNp8Kn8uC
 alrpfLr1ZHUt+4charDok4YzNc9MJU8cE6ZZTWoxi5Kr2nAAiXNAvNHfeCO01ptcRXyj
 u79dyHTqhxCSbEmNggoDqr0Ytn8XPH805nMNVpybfLTawLQTP5X1eGwDoijv+/ew4GEq
 gjPsJgLKBUYA5c7REI8VY9IOPWFmQnkdIfZ/yjoAmpneS3UH01wK1TyBAdxlXd0nUnak
 k8zg==
X-Gm-Message-State: AOJu0YweDFubK5WCIwPr5BhPnSdufAz5vTf+6GUv5c1FDRKdWLfMML/S
 T1kvJ0aHLDZR1/nbMt20dHIbDXvz31neGA==
X-Google-Smtp-Source: AGHT+IFLOdfJJ812jifatfiC3IcTBBvRkTvL8BUTT061m8hZIOGYUty7xb39NvJ0LSVQxWL6yhDAWg==
X-Received: by 2002:a05:600c:1d95:b0:40e:3733:3a81 with SMTP id
 p21-20020a05600c1d9500b0040e37333a81mr655985wms.46.1704471501225; 
 Fri, 05 Jan 2024 08:18:21 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l8-20020a05600c1d0800b0040d6e07a147sm2023004wms.23.2024.01.05.08.18.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jan 2024 08:18:20 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 805485F933;
 Fri,  5 Jan 2024 16:18:20 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Huang Rui <ray.huang@amd.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,  =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau
 <marcandre.lureau@gmail.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,  "Michael S . Tsirkin"
 <mst@redhat.com>,  "Stefano Stabellini" <sstabellini@kernel.org>,  Anthony
 PERARD <anthony.perard@citrix.com>,  Antonio Caggiano
 <quic_acaggian@quicinc.com>,  "Dr . David Alan Gilbert"
 <dgilbert@redhat.com>,  Robert Beckett <bob.beckett@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,  Gert Wollny
 <gert.wollny@collabora.com>,  <qemu-devel@nongnu.org>,
 <xen-devel@lists.xenproject.org>,  Gurchetan Singh
 <gurchetansingh@chromium.org>,  <ernunes@redhat.com>,  Alyssa Ross
 <hi@alyssa.is>,  Roger Pau =?utf-8?Q?Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,  Stefano Stabellini
 <stefano.stabellini@amd.com>,  Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,  Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>,  "Honglei Huang"
 <honglei1.huang@amd.com>,  Julia Zhang <julia.zhang@amd.com>,  "Chen
 Jiqian" <Jiqian.Chen@amd.com>,  Antonio Caggiano
 <antonio.caggiano@collabora.com>
Subject: Re: [PATCH v6 02/11] virtio-gpu: Configure new feature flag
 context_create_with_flags for virglrenderer
In-Reply-To: <20231219075320.165227-3-ray.huang@amd.com> (Huang Rui's message
 of "Tue, 19 Dec 2023 15:53:11 +0800")
References: <20231219075320.165227-1-ray.huang@amd.com>
 <20231219075320.165227-3-ray.huang@amd.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Fri, 05 Jan 2024 16:18:20 +0000
Message-ID: <8734vbg3eb.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

Huang Rui <ray.huang@amd.com> writes:

> Configure a new feature flag (context_create_with_flags) for
> virglrenderer.
>
> Originally-by: Antonio Caggiano <antonio.caggiano@collabora.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

