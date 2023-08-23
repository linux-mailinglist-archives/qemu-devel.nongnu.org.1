Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5626785A18
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 16:11:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYoYg-0000Vz-AY; Wed, 23 Aug 2023 10:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qYoYK-0000Uo-RC
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:09:44 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qYoYI-0007MK-Pe
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:09:44 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-31c71898109so66168f8f.2
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 07:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692799780; x=1693404580;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AtgSJyYHVZdit42TVhGOM+9HQMEfY6ul5cvMvgaD4Y4=;
 b=zpQR/4zIFISxyC+aBsiJ6/s59lpFSgtGnb8dU7tCnynaf6p5w7jbBz8EhrCvnJqoxg
 sgckTyUagQvhlpm9tgXysdpUq8ekUNOV6O26eHxlr5eoviAzO28ZO42curLbnqiMIlKq
 hXodxKTL/VvxQI1WfXIQ3OSYv8rpNnwypf5pNy3xlzfPPa+DYp7Dr1aavSmU8Gk50Iug
 gFHPzjbZnbZk74d5V/p02Xvc8c+XKbf+q7mzXll8foda/L0yryalFvXLC2Z9l4SjHf/4
 vKcVrE1wwtszITOvslAdNGgZdkIsaEIpl91mpxgyWun6WPvQ9UJS3WXIZ16HGjlNTigj
 7URw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692799780; x=1693404580;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:to:from:user-agent:references:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AtgSJyYHVZdit42TVhGOM+9HQMEfY6ul5cvMvgaD4Y4=;
 b=jFKPkkk7GwASu3F7gAe//LjrQsy1fiyU+jri9K2QqD7W9kIfaMaZEzYWu0seezK2Nr
 BQDzCsOUXJgN8cM5kOXdsOVRKDIvj2EH2mjoyAj6pUFOUSB4SID5q7rfZ1Sh0/7ddhlY
 Mu1VybY6mL36mJ59IkJ+Ff5P2xsdJg87q2EcTzSy25omxF93AJAGjtL1hYORZ49wSjHw
 XqELyNk5lp3jBNk19xV91469C4WekqnujDkYj4VmWIALKtbpA4rRW9LYSRwr44EEnSIN
 DI6MC0GQpOOo+vNL7VOo9pfsEKji4yarWR73kIIZXWNGNWT6fhE2HrM4hGGGjpe3NaxS
 zDCA==
X-Gm-Message-State: AOJu0YwsSFUAcDOinXxiChNvk/ArJjMJvDZmjCMuVhqEvIhD/7XEolZu
 wdW90KptJVLIPyg0hx7cXpdRGCEMzsl/eFOYhgM=
X-Google-Smtp-Source: AGHT+IE3JdPJaOZ/LHhToDx8fXok+K1q9VTQfF+VpLPwhaQH/1+BEr0oWGAgi85+GTWLRNzcAC5szw==
X-Received: by 2002:a5d:45c6:0:b0:319:854a:9ea1 with SMTP id
 b6-20020a5d45c6000000b00319854a9ea1mr9047146wrs.15.1692799780533; 
 Wed, 23 Aug 2023 07:09:40 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 p10-20020a5d638a000000b003177074f830sm19336098wru.59.2023.08.23.07.09.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 07:09:40 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AE8751FFBB;
 Wed, 23 Aug 2023 15:09:39 +0100 (BST)
References: <20230823055155.1917375-1-mjt@tls.msk.ru>
 <20230823065335.1919380-19-mjt@tls.msk.ru>
User-agent: mu4e 1.11.14; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH 20/24] include/: spelling fixes
Date: Wed, 23 Aug 2023 15:09:36 +0100
In-reply-to: <20230823065335.1919380-19-mjt@tls.msk.ru>
Message-ID: <87msyhhmu4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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


Michael Tokarev <mjt@tls.msk.ru> writes:

> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

