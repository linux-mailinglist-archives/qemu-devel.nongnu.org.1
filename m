Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 930B170DDF3
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:51:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SO3-0004WQ-BW; Tue, 23 May 2023 09:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q1SNu-0004Cs-P4
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:49:10 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q1SNs-0001Tv-3L
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:49:06 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-513fea21228so1556685a12.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684849742; x=1687441742;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=suCjM39hqwpZIWiSnBh466jG9Q2/j6oW3MExBX4JV+w=;
 b=GDCZ9tS7dVTit9+hfPXoFnv13MXImtkHPLjtNKn8ztjyXuDVDhVzD6CUV9tmil10HN
 SvgLqZc/Zn6Jo+RSV2HaCci0zgoES/XgCuXDGRdUghCd19ncCrskRpjzR3hW6ADyG91c
 VbOZhwWZmBg8HEFEAfO3jUVx4bTK+kdsZ7lD8pWVs5JrimztVRRu1wy67kGVK3DSipEJ
 5rcAjH2c5dq137tvsRjOz76/Vt/uda1Xz3PGoVEtciD+CkqsHExo5wNAtKWQ4wywHWlq
 OeEUUiuPy9jyVGUjzUcaPVNaI8BG9IXo698owwGv7ktM3OJKq2UTRcBO20Km5Z1W7IeS
 WSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684849742; x=1687441742;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=suCjM39hqwpZIWiSnBh466jG9Q2/j6oW3MExBX4JV+w=;
 b=FODbLBtR6DpGlhcRgnykSmLHJO/ZHnUOAj8KhrXtH/GMTiq6Tw16VLsqnEztkoTIw2
 XYqTyMPPGc+OPc/1eHO4AucppNBncYXJp4x7Lapxeh/6RqNbR0UisnOHwHv6QJlNEXOj
 ZR+up4/iWAKP9sX9YOPH02jgWl2Bz4Pj+2ut1rPqMWiz20PQQY+FNe9GsviTO1DYAtGh
 /5fme+RfAVFiPrX1FVrEPgccX/tCEQUWVjcbTUHrbl6b+U6naihfIZZbgBWU9OKdtmI4
 QndBuRm5r5n2O/SXBEVPSuxUBARcJ8pVjRAAl2Jx14/xGEl9GfutFexJ4Hw998RShNJy
 FQpQ==
X-Gm-Message-State: AC+VfDwwWd07IZuEx8rbLGwOXLX0KFAMZMCXi0T9a5gy7HWPaf0JMg4z
 AuRy6SCF7DlEvbG30r98YK2fCfvASjHKQxHhUOclqA==
X-Google-Smtp-Source: ACHHUZ7HbRKBt+OG1mI2S89QOB3BypgxgyLE4HfUgf1+xi+pz4/1Y/+2PJIbk0IJlciLLFcBDhHzeTkTscKKEG1aGvc=
X-Received: by 2002:aa7:d14d:0:b0:510:cda9:1eb7 with SMTP id
 r13-20020aa7d14d000000b00510cda91eb7mr11595209edo.21.1684849742061; Tue, 23
 May 2023 06:49:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230516203327.2051088-1-smostafa@google.com>
In-Reply-To: <20230516203327.2051088-1-smostafa@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 May 2023 14:48:51 +0100
Message-ID: <CAFEAcA95KAM53cdZs46aZe8p0HuWm7g+25DryER8870f9NH55g@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] Add stage-2 translation for SMMUv3
To: Mostafa Saleh <smostafa@google.com>
Cc: qemu-devel@nongnu.org, jean-philippe@linaro.org, eric.auger@redhat.com, 
 qemu-arm@nongnu.org, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Tue, 16 May 2023 at 21:33, Mostafa Saleh <smostafa@google.com> wrote:
>
> This patch series adds stage-2 translation support for SMMUv3. It is
> controlled by a new system property =E2=80=9Carm-smmuv3.stage=E2=80=9D.
> - When set to =E2=80=9C1=E2=80=9D: Stage-1 only would be advertised and s=
upported (default
> behaviour)
> - When set to =E2=80=9C2=E2=80=9D: Stage-2 only would be advertised and s=
upported.

Applied to target-arm.next, thanks.

-- PMM

