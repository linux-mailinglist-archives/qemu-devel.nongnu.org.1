Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEFB7C58AD
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 17:57:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqbaZ-0007F3-EZ; Wed, 11 Oct 2023 11:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqbaU-0007Ed-JH
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 11:57:30 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqbaQ-0005va-Uj
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 11:57:30 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-32157c8e4c7so6892331f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 08:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697039845; x=1697644645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HjPu7atdlS2IZpPXaHpNd9KaQ0KaUErdKUS/i8iR7zk=;
 b=VFCooRVhcGpLRSI5Cjc/3Lm8vY+3OZt5X+gk4k//OXOZ9LPDG0ix3eW+3W25RzSPXe
 K7sZGfUn3Zx95dkeCzqhuICeeWrVMeqkhBQN0q1Yd2/O8F9iEG+RPY7WDdnw2wDhIwO9
 QTLftM/uhDq3OVVkvB8rL92k8jhI0xXz+Ffb6B1mCkUwSK6bNsXRFSsdZfFptDIn/I06
 CW+0uHAFDBBnB04pBbZePRFE5JtKjhDw+eTUPKAuy6kKX7RyRcksEvp5AKX/OfI2pRZz
 yTq1nYuNNQHGHuEiv9fPEYLYcHhLvCCNUXFIp374uSLyjQxgd1p7OhhYa6raMyEod+q2
 ebJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697039845; x=1697644645;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HjPu7atdlS2IZpPXaHpNd9KaQ0KaUErdKUS/i8iR7zk=;
 b=VnhMW9caPaiCb95rZcsKjA5C6Tz0HZiLEgR7botva8v1xSjvU1Y5FPn/XoSZ4abZEd
 m4FQ1sXAI/+wIXLFtJmEPcHn84EXUvro1QlZ9DNGG2CXoAs9ROkaMQ2kB2kmzXSxS3vC
 QhsYrHloSTNbQ5BYmWfwP1SXeVSVKHPtmKGHaIC7BjILev8LxF8do+o4peCMeYV3Lxq0
 bDutNXY0vpCCPUZf+/VbOcVgE/ztNPRopO/kNLfn3H30Rrf6DnaGlPhTn2GjRwMSjbuV
 SNJzF93Gcc8XKv33qirelSe69jT7rmKi5s9VAnUArVU4kiIfkU0+ktfK2/AysrPddeNl
 QYzQ==
X-Gm-Message-State: AOJu0Yyg9Itoph6elJE/XSk/zvcxBPOCZfMTPTdUlrGUxl6Mgp/VrwSJ
 agUyPcGzzjBs1QkSJmT5K4jM2g==
X-Google-Smtp-Source: AGHT+IGWmWo3bPiCUqZCBwUnXwzgL5gqMrJIQnpQ/gBvXSIYeMEbqKMaHoIjIorIWod6kFYCvCdFcw==
X-Received: by 2002:a05:6000:8a:b0:31d:c3d2:4300 with SMTP id
 m10-20020a056000008a00b0031dc3d24300mr17756449wrx.71.1697039845305; 
 Wed, 11 Oct 2023 08:57:25 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 t25-20020adfa2d9000000b0032d8373fbe4sm2516698wra.51.2023.10.11.08.57.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 08:57:25 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6C1171FFBB;
 Wed, 11 Oct 2023 16:57:24 +0100 (BST)
References: <20231011070335.14398-1-akihiko.odaki@daynix.com>
 <20231011070335.14398-12-akihiko.odaki@daynix.com>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>, qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-?=
 =?utf-8?Q?Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v9 11/23] gdbstub: Use GDBFeature for GDBRegisterState
Date: Wed, 11 Oct 2023 16:57:20 +0100
In-reply-to: <20231011070335.14398-12-akihiko.odaki@daynix.com>
Message-ID: <87mswpnod7.fsf@linaro.org>
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


Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> Simplify GDBRegisterState by replacing num_regs and xml members with
> one member that points to GDBFeature.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

