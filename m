Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31336708207
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 15:05:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzdJA-0001fE-I3; Thu, 18 May 2023 09:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pzdJ8-0001eW-EE
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:04:38 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pzdJ5-0001oz-Ku
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:04:38 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f42d937d2eso12691225e9.2
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 06:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684415072; x=1687007072;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F5KI15Czh03oBpwRJEUqw2YPs/UI7TyiDPqYBelrrFw=;
 b=sb4RvuydaaB7zNZmR1bEPOCZ/TViw85jBu9TEbsyV3In78mDHFD0AsPi3LZWXBOfMg
 kMJzVkJaiKNA0q8H85IisPq7BLShvRILDxMor+GfbMWamDf9kvmlnZQC3hYyucueH2BH
 ESxjG2M53HgAB1IHrchB/DDDatPqX/P5pc0AfnsLWCPIgIR++FwKsub5Ah/Pvlg4Pzmi
 wjTd8nQiKPuMQaSmhS+a4UGxtGcr7yOJAe25eM9DX0ZIAcAVKhenBEb05L0dM3XhxFyP
 MWdq3+mkN3EwQitCHYMVeLnztFGth2qL9dEFnhct0Pc71Of/afusinZIf+A2ZUMTbg9e
 BrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684415072; x=1687007072;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=F5KI15Czh03oBpwRJEUqw2YPs/UI7TyiDPqYBelrrFw=;
 b=boMSmikfZaEogolqfCCQwDRvFAYpNpeqXfjKcwPs3P29evX1Jbr4emJDgtCNrxGyMO
 v0hG5qMihZS9MAX1/oWpJV8gcIBxsANr67ALvOvix89MGdm0+KHwYafOT9NvXQP+JxMh
 mCeGu57B1QTWJWf1ytmpg3hlH/20nkfz1VlwPh2OB/g1WAr/L/3mVhAQnXCQM7R8bBfl
 VG8yf2352GY1g2gGQAq2U4sM2U+LTXgyGzqS7og9f82HD7gnfwqUAu1Lnu2QBvtJuJvx
 UPG3Hv9b8/Bj75MLiV/4B9Euzv13Khc+2OvnKpjIVoU9dHGOsFA9y7Wv0h36ySFjeZJh
 XPfg==
X-Gm-Message-State: AC+VfDwjSVuNg6kgLVM1rXjDI78p2jg4znZ1ObUSanrn61cmqJ3cUVpr
 yGAojFG9BHQVz0Buwamb3dAHuA==
X-Google-Smtp-Source: ACHHUZ5e0h3Gecb37yKqDi3y60/Vh57IBUluAX3rv6wkEDZqif61wq9vB2R5NH3MlEm5EdtHDWKxDw==
X-Received: by 2002:a05:600c:210a:b0:3f4:2452:966a with SMTP id
 u10-20020a05600c210a00b003f42452966amr1312940wml.27.1684415071902; 
 Thu, 18 May 2023 06:04:31 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n16-20020a1c7210000000b003f19b3d89e9sm5231468wmc.33.2023.05.18.06.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 06:04:31 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 48CDB1FFBB;
 Thu, 18 May 2023 14:04:30 +0100 (BST)
References: <20230506072012.10350-1-anisinha@redhat.com>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ani Sinha <anisinha@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Thomas Huth
 <thuth@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, berrange@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH] docs/devel: remind developers to run CI container
 pipeline when updating images
Date: Thu, 18 May 2023 14:04:22 +0100
In-reply-to: <20230506072012.10350-1-anisinha@redhat.com>
Message-ID: <871qjdn63l.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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


Ani Sinha <anisinha@redhat.com> writes:

> When new dependencies and packages are added to containers, its important=
 to
> run CI container generation pipelines on gitlab to make sure that there a=
re no
> obvious conflicts between packages that are being added and those that are
> already present. Running CI container pipelines will make sure that there=
 are
> no such breakages before we commit the change updating the containers. Ad=
d a
> line in the documentation reminding developers to run the pipeline before
> submitting the change. It will also ease the life of the maintainers.
>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

