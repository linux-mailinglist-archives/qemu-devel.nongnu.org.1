Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D64BD7739F2
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 13:46:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTLAP-0005iR-3h; Tue, 08 Aug 2023 07:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTLA5-0005gv-Uo
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 07:46:08 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTLA4-0007GR-55
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 07:46:05 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fe4ad22e36so37045835e9.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 04:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691495162; x=1692099962;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mQgV8Ld8nRMceR/T0S32AJCqZ+bvgCBv2ZQsbsGh8DE=;
 b=rGRXylp3W7Sx1p2tenOSth43HjkdrqupClyyIa5hL8XVD9jjlEHQ0wYIahRcVAs/MV
 7JiTzkDfm+tskwjtAtvAmZxPrKmbToav1mkWHTi9ztIU/zy0yFsA2j/6PKEsDkJNpEKf
 vm+4Ui6ayC4/NuUQNyYieTy0SsLcK+gKRYTnH3zxFoylRPzWJ607h/eN5nuCCiNxbr2D
 HMKtaMNENoLzYpMyprwltNWrLigxZaE3+md3CdqhX7OJ0ZIbr1jDDePX4Ny8nCLPgtT+
 JgnL7gZChpOA2fe3dUxrNpMhS8PtfBnuQTwqMcSMl21gv3cjZSWso7lxpbVYmnE0Py0Y
 Y1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691495162; x=1692099962;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mQgV8Ld8nRMceR/T0S32AJCqZ+bvgCBv2ZQsbsGh8DE=;
 b=Fg6jEHiFpx1zybGNWtmWUM5IqqfdlB3/J8y2CXVQTtegnhnFQGZZAs2TWB5a3nQzM5
 /yxDvP6sE1u67Ymy1IgsdhsmIqsZe8cNsG+kRwexnaRKhyhPMhmol4PcZ/vg/GvKeolj
 wBReCNgpn2ATMMJ/hC02TdSmMLrk11MDk0NLk1/P/2zAd0FcWwmJajIrAPYBd6ymXz8R
 QBVyKgmTx1e1PSyicQW/5daoTztKHsnpxAFrVgkpEk4bofmJyfhNx11IAaqCYCEk1Eec
 giKMVrZ5BHQcwWMWkQFDtWtwFdB/SZacoEKS0r7TXcxsGOX3iHS6I4kiM1y9mItXAXRX
 qozQ==
X-Gm-Message-State: AOJu0Yxgcik6WfVXatHh9zFI2V33BUsD+yNAtYmrwNYCsk5qirZt/EZX
 DGSLx0H8Ylku0cC9PaeLWdY9+i0H2Odhu+k8Oh0=
X-Google-Smtp-Source: AGHT+IGVSo9lVjygod9v9aYvRNEfb+mH0tRRhMedWPyoGG+5ws6WUQK3opbYUf6oOotctDp8UK8cEg==
X-Received: by 2002:a7b:c451:0:b0:3f5:146a:c79d with SMTP id
 l17-20020a7bc451000000b003f5146ac79dmr9293234wmi.15.1691495162428; 
 Tue, 08 Aug 2023 04:46:02 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 4-20020a05600c248400b003fbb5506e54sm13543675wms.29.2023.08.08.04.46.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 04:46:02 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 62A3C1FFBB;
 Tue,  8 Aug 2023 12:46:01 +0100 (BST)
References: <20230807163705.9848-1-richard.henderson@linaro.org>
 <20230807163705.9848-12-richard.henderson@linaro.org>
User-agent: mu4e 1.11.13; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu,
 deller@gmx.de, qemu-devel@nongnu.org
Subject: Re: [PATCH for-8.1 v10 11/14] linux-user: Remove duplicate
 CPU_LOG_PAGE from probe_guest_base
Date: Tue, 08 Aug 2023 12:45:52 +0100
In-reply-to: <20230807163705.9848-12-richard.henderson@linaro.org>
Message-ID: <87y1il7o5i.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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


Richard Henderson <richard.henderson@linaro.org> writes:

> The proper logging for probe_guest_base is in the main function.
> There is no need to duplicate that in the subroutines.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

