Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EB57D96D9
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 13:44:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwLEj-0007Wq-Ti; Fri, 27 Oct 2023 07:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwLEg-0007WV-Tu
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 07:42:42 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwLEf-00057w-CX
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 07:42:42 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5401bab7525so3325367a12.2
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 04:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698406957; x=1699011757; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jaInLbtt3UdnV88j9B6N+5VHWdNSaACQFHJiHwvJN3g=;
 b=aXVPDgM3iV3qdywKAYhck7mDA2QDDMbO2WE79hmdGCC1OrgG7XkO27VSeMYzC+aQjl
 +8QlkS6u/2uj/JqvY94zJYoJ6sDESTuF+sKIOEhRjF4vzua/Eu7QMoRgyVbDbGa3RiQA
 ZKQhcnFvFt0TakoRbu4rCFeBfODpw9YgYchjTcOCfHvAW0gMlTEoc2y93EwQZtyXxEsp
 WWvohCZB64EATD2ln92M0+KSeueqWUHSNYJ7TjVuVIvYYfPr1CSMGdMz50rN1h8pPdPr
 Jha7Vf92DiP+WWF2w9ML/eY3dk0xrvsN3N5mXnaD8WIwkEs+eNuRtcEUItytK6Yt0aE9
 gWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698406957; x=1699011757;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jaInLbtt3UdnV88j9B6N+5VHWdNSaACQFHJiHwvJN3g=;
 b=lWV3/TKbAGVThAMol5PKzKqZjQfgIVao/gZqpAanlW9lcmM9hq+07WI6NqVKUdVNXR
 LssrkDb+EEEqaQsoXV0SC/ttkSJL7nR+XQp2wFnek5XAmFB3X24BGnogNPeQ3tVHtH2B
 S/6OKFglva1YHtAQUI24km5eqmZOnxz3LFS4QFSP9/TRmNAH2Ta1VGP6nlt3Pl+VHxAj
 kybACYNbw2Ad6TTjXACsyLew8vonBiTUfla/6gvOOzyjGaM52egijEIywvyTSLQCQCJf
 VE2mBh+d8Z+twhNC89OyLt79ME1UNALaQNu0bSlolC7Jo+UOxZdXY5NeP1GL66TpbVdG
 BahQ==
X-Gm-Message-State: AOJu0YxX0fwBAAD3RD1RPY2UnUIAUhszjnQHLAQ5FDtlRoSm6rJMKwGy
 Kg0YDoxDjPxWDijr+OY+MPDO8jVinLC32ynB7765EioHul0exrYF
X-Google-Smtp-Source: AGHT+IEAtVioxAW0kvS06lxCOzMkPHUi8E8nwTFBPIeUPKgEL/67iP4EwfSBfOF21nQIYG2JvMmdo3FDvCrWv1RlvzQ=
X-Received: by 2002:a50:9994:0:b0:53f:bab5:1949 with SMTP id
 m20-20020a509994000000b0053fbab51949mr2062090edb.12.1698406957329; Fri, 27
 Oct 2023 04:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <20231025065316.56817-1-philmd@linaro.org>
In-Reply-To: <20231025065316.56817-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Oct 2023 12:42:25 +0100
Message-ID: <CAFEAcA_fBMV=X7Fs38YAtZWmN_s9LKwN-06BW6Gn_DXD3u1chw@mail.gmail.com>
Subject: Re: [PATCH 00/10] hw/arm: Move 'hw/arm/boot.h' from header to source
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 qemu-trivial@nongnu.org, 
 qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Wed, 25 Oct 2023 at 07:54, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Almost no ARM board header requires "hw/arm/boot.h".
> Move this header inclusion to the source.
>
> Philippe Mathieu-Daud=C3=A9 (10):
>   hw/arm/allwinner-a10: Remove 'hw/arm/boot.h' from header
>   hw/arm/allwinner-h3: Remove 'hw/arm/boot.h' from header
>   hw/arm/allwinner-r40: Remove 'hw/arm/boot.h' from header
>   hw/arm/fsl-imx25: Remove 'hw/arm/boot.h' from header
>   hw/arm/fsl-imx31: Remove 'hw/arm/boot.h' from header
>   hw/arm/fsl-imx6: Remove 'hw/arm/boot.h' from header
>   hw/arm/fsl-imx6ul: Remove 'hw/arm/boot.h' from header
>   hw/arm/fsl-imx7: Remove 'hw/arm/boot.h' from header
>   hw/arm/xlnx-versal: Remove 'hw/arm/boot.h' from header
>   hw/arm/xlnx-zynqmp: Remove 'hw/arm/boot.h' from header



Applied to target-arm.next, thanks.

-- PMM

