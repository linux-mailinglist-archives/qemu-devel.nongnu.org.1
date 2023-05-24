Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBA870F313
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 11:38:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1kvq-00042u-0x; Wed, 24 May 2023 05:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1kvo-00042d-C8
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:37:20 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1kvm-0006iV-Qk
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:37:20 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3f6077660c6so6274105e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 02:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684921037; x=1687513037;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XqQ0J58mREW8vK0ciKOwAOG3pTBfMYBfnwB9UJG/Yuo=;
 b=gd9Q1zcGLvRNNv+5tiKHzpgQWlcLH22o2AZaBLpOzya9M8nfVghy85V/nQ0+8w1To1
 RIIQDF4pXdXe5sQkqf08nxvP1t6XgomlB8xZkl+oieBm6XvPqFJdmR6ex/5GnBqpIhS5
 3DD6pEkIhL6iL9QPAcq55j12dNA/KHSUPyrZAmusiTbugVYy5lLMgRgdzlT15R0CuZXN
 wYBbIt1NDf/iA5MzENjwQdaIkcMAPn7xftIDX5BtspwwBMnjILjnm9wJr0WwTe0JeXmj
 UE5BBP+FrU7WYgBfT6Q2yCyqs0JYYmSMfyYhGnEat1WaAaGLrKCDcmMmwTvMGPxyG2C5
 2kSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684921037; x=1687513037;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XqQ0J58mREW8vK0ciKOwAOG3pTBfMYBfnwB9UJG/Yuo=;
 b=RsmWgFwZb/kX94jtgyx9DMfsRcqQDgdvKt9bcORvgcY5qNI9GE7QCiu/ogs1bkZjgy
 k0JT93JAxZVyrFmScYPRN9/XZmyBNLGmZPmzOIc03Rmoh2ci+1KtHdH2Vgver+q3QvX2
 uAxDwO8rQffbXlFQFnwT+R60/EuhdEEZpeahM2eFNLrmF/yhcysqdL4Ixg9/B25QYcbu
 pOizqdFZoCwY6oA1+2QZ9LTdOHbqCiute7H2yWQ7RkJZDWWXD60fEmq+qGiSzufgBqUh
 M6spEluG4v+a4nYByYByIQV0onfXi3Hs1D9pdgcxtyeq4wB9giwsJTlxfRg/juCOhSJ+
 xiGA==
X-Gm-Message-State: AC+VfDw4Wgru7CHg/lq/JAAZjyFwUeTnIe5O4jifu9ZXPDZXUC9DN1Tb
 zwjTXalKtlF/cK/+966zWIZ4fA==
X-Google-Smtp-Source: ACHHUZ5mvqX5YFtet1TIte3o9fjzIB3b4geaDAWtgvM8GGSwK8K9T6skcjj/AsjUhuf61Wu1hr6vew==
X-Received: by 2002:a1c:f715:0:b0:3f4:24c8:f7c6 with SMTP id
 v21-20020a1cf715000000b003f424c8f7c6mr12907317wmh.16.1684921037248; 
 Wed, 24 May 2023 02:37:17 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 l17-20020a7bc451000000b003f4fb5532a1sm1658016wmi.43.2023.05.24.02.37.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 02:37:17 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 68B2E1FFBB;
 Wed, 24 May 2023 10:37:16 +0100 (BST)
References: <20230510202654.225689-1-iii@linux.ibm.com>
 <20230510202654.225689-3-iii@linux.ibm.com>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Laurent Vivier
 <laurent@vivier.eu>, Dominik 'Disconnect3d' Czarnota
 <dominik.b.czarnota@gmail.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Andreas Arnez <arnez@linux.ibm.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH RESEND 2/6] gdbstub: Expose gdb_get_process() and
 gdb_get_first_cpu_in_process()
Date: Wed, 24 May 2023 10:37:11 +0100
In-reply-to: <20230510202654.225689-3-iii@linux.ibm.com>
Message-ID: <871qj6xe7n.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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


Ilya Leoshkevich <iii@linux.ibm.com> writes:

> These functions will be needed by user-target.c in order to retrieve
> the name of the executable.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

