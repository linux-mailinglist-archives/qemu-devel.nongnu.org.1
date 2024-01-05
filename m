Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0CE825382
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 13:54:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLjhY-0001kr-Cr; Fri, 05 Jan 2024 07:53:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLjhW-0001kh-17
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 07:53:26 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLjhU-0008KG-5y
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 07:53:25 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-50e7dd8bce8so1797859e87.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 04:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704459200; x=1705064000; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=249vhzwPgN1JVD24dXaosALaFCDBT3qv/vgDwXMnbzc=;
 b=zrJ3bpAXUsDziYYHJ6lmy68v250cAVb7/BFXCh5fNDe9clkheC77jicuU+ptHLcfwS
 4KUiHJijIlJQ9vtHmlsFvdmMlMtFYPIdXLTg1i2skg0HO1TH02Xw+/oX23CcvnVGroLq
 99MIVuRKAgDtTNYqWrA96nK9GwMB/ej6lKjnHyuDso2LP/baLooAdR0yaipZfDNv0JTh
 tPyk7WcTF8n/SAyP9/0LNDHj6w5LrtpMlLp4fpr2Z6JR5T1QFc2A0nbm9qWqNbQJM40M
 JJjEBCTx22AhZEuAbnUVUmolrC2263tpDr65nGBadUQYuvDxvtQSsTEn5CUcyrpVztUd
 jZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704459200; x=1705064000;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=249vhzwPgN1JVD24dXaosALaFCDBT3qv/vgDwXMnbzc=;
 b=VTry7+BfsXZ2BK2pvTEGT+DJRcIpDNsYuJCALHw5Rvd7rcPU6ZfgdAdHZAljxiNo5z
 XWrYX/6S8oY5kifWlx+717V/y62kW6U7MvM7kxirKbvgGwalG5Ym2Vec3j9N9isFOmlO
 JdBLAXqjuuR+I9Lh1sWA5JI8DLWIbkDefHhywnWmQIhTDvXI/3M3ZYY+KkkrROmHHNCc
 AmxDmlr5oBnyzqrMWMqHykzfQGY6Ixe6SENBsOJ/L9buljk7qfTSav/g+t9qviJdiLie
 1WmpbcG6kl5IPYNVpc4hPzxALCs516kYKyrwPr/H7qyT3nbDgv1BPBDhM4mI7u05+WqV
 BFBQ==
X-Gm-Message-State: AOJu0YxekGwNpDqUjGvotkIY66MVptaKWWGpBA7ES6/pKFoX4XmeL1AR
 vf5nRGPRjiE41MC49t7+t3y5BG3PYlf32qpp0beK5dbGWkDmrQ==
X-Google-Smtp-Source: AGHT+IFR2tcpVVOFOFwyLOI9+EOf5tt2OctZAvvdZnIDwgOvIJQAt2zBR2ebpj8hvUp4V/DF6WpISW5/5MTIHrb4QXI=
X-Received: by 2002:ac2:4c99:0:b0:50e:7bb7:af8d with SMTP id
 d25-20020ac24c99000000b0050e7bb7af8dmr1021169lfl.116.1704459200125; Fri, 05
 Jan 2024 04:53:20 -0800 (PST)
MIME-Version: 1.0
References: <20231231084502.235366-1-pbonzini@redhat.com>
In-Reply-To: <20231231084502.235366-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Jan 2024 12:53:09 +0000
Message-ID: <CAFEAcA8MUDUchXrz50kr0e-vf0vQ+38o3P2fWx9kO5SZnvXdkw@mail.gmail.com>
Subject: Re: [PULL 00/46] (mostly) target/i386 and meson changes for 2023-12-31
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x132.google.com
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

On Sun, 31 Dec 2023 at 08:50, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 191710c221f65b1542f6ea7fa4d30dde6e134fd7:
>
>   Merge tag 'pull-request-2023-12-20' of https://gitlab.com/thuth/qemu into staging (2023-12-20 09:40:16 -0500)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to f705c1f25d9a075534f8279048082af4ce2066bf:
>
>   meson.build: report graphics backends separately (2023-12-31 09:11:29 +0100)
>
> ----------------------------------------------------------------
> * configure: use a native non-cross compiler for linux-user
> * meson: cleanups
> * target/i386: miscellaneous cleanups and optimizations
> * target/i386: implement CMPccXADD
> * target/i386: the sgx_epc_get_section stub is reachable
> * esp: check for NULL result from scsi_device_find()
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

