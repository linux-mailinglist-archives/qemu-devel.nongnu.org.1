Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA80472236F
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 12:29:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q67Rx-0006va-MH; Mon, 05 Jun 2023 06:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q67Rw-0006vR-2M
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 06:28:32 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q67Ru-0004oH-Gx
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 06:28:31 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-4f3bb395e69so5835822e87.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 03:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685960908; x=1688552908;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YL7zOR9I/f05zMsOCyd77n4fVdcAyI4CfL8JXfCHqpk=;
 b=SCH8QN745PkEqft0pluwP2OlTioLqkvyrI5KJgF1rJ0GyihuywZOVicBaFxmJoJXHn
 IxaLlwLLoUO2I+szT15r60DprbIW449lld88clQ5V7YPOf0I8tRyv/ExYKpLrH83OBnw
 WKUbNXRSmLPQc9f003WJ5+0cHer05G2bkMVArYGNd8fy9JK+vT/EtmGeFCyDtE7yA6Nu
 kVrpgWpVVKf9nR6mvvr+eZLF2eYT2pprPUCvO0PqY4JWLPHPgTqx0crFyDVfVhC3Gv2y
 GDoHd0T+X1aC92sHMFzvKdsVjhg+aRsRSvhLR+LpVLAIKhQD6LCqqwuPmxQmQQB7SVWH
 zrew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685960908; x=1688552908;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YL7zOR9I/f05zMsOCyd77n4fVdcAyI4CfL8JXfCHqpk=;
 b=Rzw0+sKsn9icu+Oy0ftoqO8b76LiBh6xXSQku3hlwyEAw5RYVG9vBp90bCQ5D0T3zo
 ORB//rpMUMJIcgRDHyWAKia+udErEPAllfATQrQsTYwnEt6lF0lFyPu36F5GtBjPfcTg
 fLZSF/4FcHuM0jTMWel88mStEpTz2yNo6X+v3S2LLpCXTxIsmSOjPfQ/pipOcubGY99L
 bIVYOo1eQUyocq6YrUFiCRDB4y0SV8bL+6qDXv0f5ffsE4ukWrJ+3yTWNPT+0lAeV+Ba
 bMIl4SnTcng5s/iVMN6UF1/gTukluW4Yl63mTDcnItCOe2vI6yICONK2Mpkm4dcR6/J5
 mm3Q==
X-Gm-Message-State: AC+VfDxwJFAtlLSVv4wrBihAf1MZSPPfT5IqSfEutjENoeYbOv7/1gIh
 UOCfQpoE9UKH9CWx3pVZ3+WAp85duiDThnT0JVw=
X-Google-Smtp-Source: ACHHUZ6QwbVBMVnDRKoOQjQ8Tc2FcckxXwxkDA/r2A8h58v4GiGE/WXtVHSB2BUMMZeGdy5oqdq+Gg==
X-Received: by 2002:a05:6512:4c6:b0:4f3:ba7f:80c9 with SMTP id
 w6-20020a05651204c600b004f3ba7f80c9mr5217049lfq.59.1685960907778; 
 Mon, 05 Jun 2023 03:28:27 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 d24-20020a1c7318000000b003f18b942338sm10375157wmb.3.2023.06.05.03.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 03:28:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 364781FFBB;
 Mon,  5 Jun 2023 11:28:27 +0100 (BST)
References: <20230605095223.107653-1-pbonzini@redhat.com>
 <20230605095223.107653-3-pbonzini@redhat.com>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: thuth@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 02/10] configure: rename --enable-pypi to
 --enable-download, control subprojects too
Date: Mon, 05 Jun 2023 11:28:22 +0100
In-reply-to: <20230605095223.107653-3-pbonzini@redhat.com>
Message-ID: <874jnm19v8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12a.google.com
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


Paolo Bonzini <pbonzini@redhat.com> writes:

> The behavior of --{enable,disable}-pypi is similar to that of
> -Dwrapmode=3D{default,nodownload} respectively.  In particular,
> in both cases a feature needs to be explicitly enabled for the
> dependency to be downloaded.
>
> So, use a single option to control both cases.  Now, --enable-slirp
> will trigger cloning and building of libslirp if the .pc file
> is not found on the machine.
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

