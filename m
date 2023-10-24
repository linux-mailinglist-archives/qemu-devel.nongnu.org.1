Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 303967D5729
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 18:00:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvJnr-00008L-Ok; Tue, 24 Oct 2023 11:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qvJnn-00007z-PA
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:58:44 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qvJnm-0002ur-0Q
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:58:43 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40907b82ab9so10757065e9.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 08:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698163120; x=1698767920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=awxLtNOqWYASZHdbf28m2QJJs6Pq6yxb+MFNpXcWp9c=;
 b=KA4kBFJ0lMFc87jOswx4Gb8z4Lp0/ZuM3UYinrmoQZekjyRAk2pyKnv33G1gdtIfh+
 Q1+M6ZqfFu7DXdtzCSjBwGd3zBWFSCks0g3bUabm7XPjQtnVOSxyv3I9dOOa/veCHAt9
 bKtys5Pc+sdcuLB6UOkbDM7ChF8Wqt7AeNBeDOLVmjmeCBkZayRmG+4za6YO2daLpCib
 r0IcM5MsvNIVf+eMg344oQeXP+TU6/pofpkwIncCv0sTDy41ocYLUIJeUuI1spKtEd0/
 04q2/Gze9Zt3nSQYhtSS9M+2GeGYuOH5YN6s9LJrvZcTuBZBT0E7hz7V3LHtoqJ13gkV
 qcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698163120; x=1698767920;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=awxLtNOqWYASZHdbf28m2QJJs6Pq6yxb+MFNpXcWp9c=;
 b=EacAM+A6yOvpZKkl+cWxE/XK5m1TynhRpxzB6CPGK31DvfPASx8TVKkuX+K7maWF/l
 r4Kb1QPWkfGXCLglMrBKG4HCcSyFAXu4AHfov9ncC/UZQ2TtvHPWTiDGjjqy+M48Oueh
 Zj2AmzIpGHHknTxxQ8+1scYjpJvoo4k6KPvCSVVtRt2FCHspXTH/uEx+c+LX7p1qneEh
 JpNdiJQ9YpH8QRN0rTF9kPmDYBv6aCWQNPBN2W/OlNwh21y+FDxWywAFoE4EiiWG2bCX
 h96irPjxA9OFa8Vp/jjElnTG0kP43df5SleK29G47tLpj8qZpIUz4b495lJJraq5ndjL
 MxQQ==
X-Gm-Message-State: AOJu0YyYqsLC3z14Rn+KMXsHoCPCTx42BvLZDK9EeAzTHdnpQV6h3mCq
 WSYU1rL8ShJsoMiO5uyJ29uH5Q==
X-Google-Smtp-Source: AGHT+IHFJsBjiGP0P/g59ErYALqyrmdMLeBBQ0qB7A9r+Py9lXNQGLOWG8FnMd/oMfpOIud1WyjeTw==
X-Received: by 2002:adf:e0c4:0:b0:31f:a717:f1b6 with SMTP id
 m4-20020adfe0c4000000b0031fa717f1b6mr11045299wri.11.1698163119938; 
 Tue, 24 Oct 2023 08:58:39 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 g7-20020a5d6987000000b003232380ffd7sm10190419wru.102.2023.10.24.08.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 08:58:39 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1D4771FFBB;
 Tue, 24 Oct 2023 16:58:39 +0100 (BST)
References: <20231019102657.129512-1-akihiko.odaki@daynix.com>
 <20231019102657.129512-16-akihiko.odaki@daynix.com>
User-agent: mu4e 1.11.22; emacs 29.1.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>, qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-?=
 =?utf-8?Q?Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v14 15/18] cpu: Call plugin hooks only when ready
Date: Tue, 24 Oct 2023 16:58:25 +0100
In-reply-to: <20231019102657.129512-16-akihiko.odaki@daynix.com>
Message-ID: <87ttqg107k.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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


Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> The initialization and exit hooks will not affect the state of vCPU
> outside TCG context, but they may depend on the state of vCPU.
> Therefore, it's better to call plugin hooks after the vCPU state is
> fully initialized and before it gets uninitialized.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

