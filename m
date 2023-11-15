Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9956D7EC829
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 17:07:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3IPk-0002CR-T1; Wed, 15 Nov 2023 11:06:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r3IPi-0002C1-0J
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 11:06:50 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r3IPg-00083b-Dl
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 11:06:49 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c504a5e1deso93981421fa.2
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 08:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700064405; x=1700669205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lxBV5F+ejfImJH4NDWExPgkTZLPFCvyWoyiPiO4uvDk=;
 b=R4GAkj6FVFX+nV+IaGLtwnI5YHkeSX78+t5zLek81ZvOzduZW5z4r3X2CxwCSH2yOh
 ztL5f4g/IOWI2FbjRrCQMGdyxX1TLXNkoqPoW2uNNfLMulCFOzECEqwBOo5WMGJft8LX
 4LV/Nagk/hFuN6GKQJt7FkakstH3gYLNDHzUhFfdi3SDs61WrlKjDfFJ40lHD3BMJoCP
 bAXwJFMh/qqTsKi/Kgf0i4nWCmufFtNokJBz1dBMJ6zk9kCevCVpqY8Fu66za4Pc7ZsE
 pMVVVsm1Bldz1ly+zo/v4cdigbCdA+ISt+5E4DZkm91mhvFTbVHOD5QLxt+587JXp/aA
 Pz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700064405; x=1700669205;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lxBV5F+ejfImJH4NDWExPgkTZLPFCvyWoyiPiO4uvDk=;
 b=LRaUcfjggJuNWMVZnF/+28JMCgjD2cqwksiyyr+ufPMJNsocppXJpgVb5c0gkUKaH8
 mvb0ePWl3yuL0zDIbIf5iJveI+6erYe3wrYs5BkwuG/2N30eT9A/H0F9XQL1Xoq+B6Th
 KAEjoezuLoDrdrLHubZUC8rEq54EyhsIofvqx5RNML8S7soi15Fow00xauyHf+NegPDM
 9ugFwwaGqt1WhS3IdjBRJ/elWrDLVNpkWR6Yp6346ep9fnr2QT3uo9mcLhYdC7wFBAQv
 7bpNluG+JW1fFHOwZwg8gaFNTN9LCc+9+GYHuV29tKh+dkO4PQ6N8s46XLtbqJa8wZDI
 SWpg==
X-Gm-Message-State: AOJu0YwOY6BccfrcnJ7jQKfqZTOxcVtp3R7vl4hmGLijCnntxGjwA+lT
 Ub4ZZmEjp+30zFdNxphyOfnkHA==
X-Google-Smtp-Source: AGHT+IHS9ppf59HLDBJjLjjsZFdQvgJE8N8GYHr12xe963xVfRZaG9I7ES4z9ZZdKxOYc6zPastFuA==
X-Received: by 2002:a2e:a377:0:b0:2c8:33fd:ca8c with SMTP id
 i23-20020a2ea377000000b002c833fdca8cmr4093384ljn.45.1700064405114; 
 Wed, 15 Nov 2023 08:06:45 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 j6-20020adff006000000b0033142b1a1eesm10550283wro.87.2023.11.15.08.06.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 08:06:44 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6836A5F7A4;
 Wed, 15 Nov 2023 16:06:44 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Beraldo Leal <bleal@redhat.com>,  Wainer dos
 Santos Moschetta <wainersm@redhat.com>,  Daniel P . =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9?=
 <berrange@redhat.com>,  Cleber Rosa <crosa@redhat.com>,  Thomas Huth
 <thuth@redhat.com>
Subject: Re: [PATCH-for-8.2?] tests/avocado: Make fetch_asset()
 inconditionally require a crypto hash
In-Reply-To: <20231115153247.89486-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 15 Nov 2023 16:32:47
 +0100")
References: <20231115153247.89486-1-philmd@linaro.org>
User-Agent: mu4e 1.11.24; emacs 29.1
Date: Wed, 15 Nov 2023 16:06:44 +0000
Message-ID: <87wmujuhkb.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22d.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

s/inconditionally/unconditionally/

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

